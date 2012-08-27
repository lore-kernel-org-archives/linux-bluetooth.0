Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [RFC BlueZ 21/22] alert: Add test script
Date: Mon, 27 Aug 2012 13:12:05 -0400
Message-Id: <1346087526-15107-22-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

---
 test/test-alert |  167 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 167 insertions(+)
 create mode 100755 test/test-alert

diff --git a/test/test-alert b/test/test-alert
new file mode 100755
index 0000000..ccc272c
--- /dev/null
+++ b/test/test-alert
@@ -0,0 +1,167 @@
+#!/usr/bin/python
+from __future__ import absolute_import, print_function, unicode_literals
+import dbus
+import dbus.service
+import dbus.mainloop.glib
+import gobject
+import optparse
+import sys
+import os
+
+BUS_NAME = 'org.bluez'
+ALERT_INTERFACE = 'org.bluez.Alert'
+ALERT_AGENT_INTERFACE = 'org.bluez.AlertAgent'
+BLUEZ_OBJECT_PATH = '/org/bluez'
+TEST_OBJECT_PATH = '/org/bluez/test'
+
+class AlertAgent(dbus.service.Object):
+	@dbus.service.method(ALERT_AGENT_INTERFACE, in_signature='',
+							out_signature='')
+	def MuteOnce(self):
+		print('method MuteOnce() was called')
+
+	@dbus.service.method(ALERT_AGENT_INTERFACE, in_signature='s',
+							out_signature='')
+	def SetRinger(self, mode):
+		print('method SetRinger(%s) was called' % mode)
+
+def print_command_line(options):
+	if not options.verbose:
+		return False
+
+	print('-w: ' + str(options.wait))
+
+	if options.times:
+		print('-t: ' + str(options.times))
+
+	if options.register:
+		print('-r: ' + options.register)
+	else:
+		print('-r: ' + str(None))
+
+	if options.new_alert:
+		print('-n:')
+		for i in options.new_alert:
+			print('    ' + i[0] + ', ' + i[1] + ', ' + i[2])
+	else:
+		print('-n: ' + str(None))
+
+	if options.unread_alert:
+		print('-u:')
+		for i in options.unread_alert:
+			print('    ' + i[0] + ', ' + i[1])
+	else:
+		print('-u: ' + str(None))
+
+	print()
+
+	return True
+
+def read_count(param):
+	try:
+		return int(param)
+	except ValueError:
+		print('<count> must be integer, not \"%s\"' % param)
+		sys.exit(1)
+
+def new_alert(alert, params):
+	if not params:
+		return False
+
+	for param in params:
+		category = param[0]
+		count = read_count(param[1])
+		description = param[2]
+
+		alert.NewAlert(category, count, description)
+
+def unread_alert(alert, params):
+	if not params:
+		return False
+
+	for param in params:
+		category = param[0]
+		count = read_count(param[1])
+
+		alert.UnreadAlert(category, count)
+
+option_list = [
+	optparse.make_option('-v', None,
+			action = 'store_true',
+			default = False,
+			dest = 'verbose',
+			help = 'verbose'),
+
+	optparse.make_option('-w', None,
+			action = 'store_true',
+			default = False,
+			dest = 'wait',
+			help = 'wait for dbus events'),
+
+	optparse.make_option('-t', None,
+			action = 'store',
+			default = 1,
+			type = "int",
+			dest = 'times',
+			help = 'repeat UnreadAlert/NewAlert <times> times',
+			metavar = '<times>'),
+
+	optparse.make_option('-r', None,
+			action = 'store',
+			dest = 'register',
+			type = 'string',
+			metavar = '<category>',
+			help = 'register alert'),
+
+	optparse.make_option('-n', None,
+			action = 'append',
+			dest = 'new_alert',
+			type = 'string',
+			nargs = 3,
+			metavar = '<category> <count> <description>',
+			help = 'send new alert'),
+
+	optparse.make_option('-u', None,
+			action = 'append',
+			dest = 'unread_alert',
+			type = 'string',
+			nargs = 2,
+			metavar = '<category> <count>',
+			help = 'send unread alert'),
+]
+
+parser = optparse.OptionParser(option_list=option_list)
+parser.disable_interspersed_args()
+(options, args) = parser.parse_args()
+
+dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
+bus = dbus.SystemBus()
+mainloop = gobject.MainLoop()
+alert = dbus.Interface(bus.get_object(BUS_NAME, BLUEZ_OBJECT_PATH),
+								ALERT_INTERFACE)
+alert_agent = AlertAgent(bus, TEST_OBJECT_PATH)
+
+print_command_line(options)
+
+if not (options.register or options.new_alert or options.unread_alert or
+								options.wait):
+	parser.print_usage()
+	sys.exit(1)
+
+if options.register:
+	alert.RegisterAlert(options.register, TEST_OBJECT_PATH)
+
+times = 0
+while times < options.times:
+	times += 1
+
+	new_alert(alert, options.new_alert)
+	unread_alert(alert, options.unread_alert)
+
+if not options.wait:
+	sys.exit(0)
+
+try:
+	mainloop.run()
+except:
+	pass
-- 
1.7.9.5

