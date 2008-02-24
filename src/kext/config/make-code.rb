#!/usr/bin/ruby

while l = $stdin.gets
  l.strip!

  if /<sysctl>keyremap4macbook\.(.+?)\.(.+)<\/sysctl>/ =~ l then
    type = $1
    entry = $2

    case ARGV[0]
    when 'hpp'
      print "int #{type}_#{entry};\n"
    when 'cpp_SYSCTL'
      print "SYSCTL_INT(_keyremap4macbook_#{type}, OID_AUTO, #{entry}, CTLTYPE_INT|CTLFLAG_RW, &(config.#{type}_#{entry}), 0, \"\");\n"
    when 'cpp_register'
      print "sysctl_register_oid(&sysctl__keyremap4macbook_#{type}_#{entry});\n"
    when 'cpp_unregister'
      print "sysctl_unregister_oid(&sysctl__keyremap4macbook_#{type}_#{entry});\n"
    end
  end
end
