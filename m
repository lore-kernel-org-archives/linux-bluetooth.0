Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v2 BlueZ 26/27] alert: Implement Release() agent method
Date: Thu, 27 Sep 2012 14:36:35 -0400
Message-Id: <1348770996-12236-27-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1348509661-15967-1-git-send-email-anderson.lizardo@openbossa.org>
 <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This method allows BlueZ to notify the agent that it will not be used
anymore, and can thus cleanup itself (e.g. deallocate D-Bus object, or
exit).
---
 profiles/alert/server.c |   18 +++++++++++++++++-
 test/test-alert         |   11 +++++++++--
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index c631e0d..4b00ae3 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -179,9 +179,25 @@ static void alert_data_destroy(gpointer user_data)
 	g_free(alert);
 }
 
+static void alert_release(gpointer user_data)
+{
+	struct alert_data *alert = user_data;
+	DBusMessage *msg;
+
+	msg = dbus_message_new_method_call(alert->srv, alert->path,
+							ALERT_AGENT_INTERFACE,
+							"Release");
+	if (msg)
+		g_dbus_send_message(btd_get_dbus_connection(), msg);
+
+	alert_data_destroy(alert);
+}
+
 static void alert_destroy(gpointer user_data)
 {
-	g_slist_free_full(registered_alerts, alert_data_destroy);
+	DBG("");
+
+	g_slist_free_full(registered_alerts, alert_release);
 	registered_alerts = NULL;
 }
 
diff --git a/test/test-alert b/test/test-alert
index c92a719..1e241a3 100755
--- a/test/test-alert
+++ b/test/test-alert
@@ -15,9 +15,10 @@ BLUEZ_OBJECT_PATH = '/org/bluez'
 TEST_OBJECT_PATH = '/org/bluez/test'
 
 class AlertAgent(dbus.service.Object):
-	def __init__(self, bus, object_path, alert):
+	def __init__(self, bus, object_path, alert, mainloop):
 		dbus.service.Object.__init__(self, bus, object_path)
 		self.alert = alert
+		self.mainloop = mainloop
 
 	@dbus.service.method(ALERT_AGENT_INTERFACE, in_signature='',
 							out_signature='')
@@ -31,6 +32,12 @@ class AlertAgent(dbus.service.Object):
 		print('method SetRinger(%s) was called' % mode)
 		self.alert.NewAlert('ringer', 1, mode)
 
+	@dbus.service.method(ALERT_AGENT_INTERFACE, in_signature='',
+							out_signature='')
+	def Release(self):
+		print('method Release() was called')
+		self.mainloop.quit()
+
 def print_command_line(options):
 	if not options.verbose:
 		return False
@@ -145,7 +152,7 @@ bus = dbus.SystemBus()
 mainloop = gobject.MainLoop()
 alert = dbus.Interface(bus.get_object(BUS_NAME, BLUEZ_OBJECT_PATH),
 								ALERT_INTERFACE)
-alert_agent = AlertAgent(bus, TEST_OBJECT_PATH, alert)
+alert_agent = AlertAgent(bus, TEST_OBJECT_PATH, alert, mainloop)
 
 print_command_line(options)
 
-- 
1.7.9.5

