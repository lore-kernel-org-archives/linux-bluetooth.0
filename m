Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20051013172036.GA24585@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Subject: [Bluez-devel] [PATCH] Set D-BUS signal paths according to local device
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 13 Oct 2005 20:20:36 +0300


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

The attached patch sets the object path of D-BUS signals according to
the local device id, e.g. /org/bluez/Manager/hci0/Controller. It also
removes the local address arguments from those signals.

Johan

--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="signal-path.patch"

Index: hcid/dbus.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.c,v
retrieving revision 1.23
diff -u -r1.23 dbus.c
--- hcid/dbus.c	13 Oct 2005 09:36:00 -0000	1.23
+++ hcid/dbus.c	13 Oct 2005 16:52:47 -0000
@@ -338,23 +338,29 @@
 
 void hcid_dbus_inquiry_start(bdaddr_t *local)
 {
-	DBusMessage *message;
+	DBusMessage *message = NULL;
+	char path[MAX_PATH_LENGTH];
 	char *local_addr;
 	bdaddr_t tmp;
+	int id;
 
 	baswap(&tmp, local); local_addr = batostr(&tmp);
 
-	message = dbus_message_new_signal(BLUEZ_HCI_PATH,
+	id = hci_devid(local_addr);
+	if (id < 0) {
+		syslog(LOG_ERR, "No matching device id for %s", local_addr);
+		goto failed;
+	}
+
+	snprintf(path, sizeof(path), "%s/hci%d/%s", MANAGER_PATH, id, BLUEZ_HCI);
+
+	message = dbus_message_new_signal(path,
 				BLUEZ_HCI_INTERFACE, BLUEZ_HCI_INQ_START);
 	if (message == NULL) {
 		syslog(LOG_ERR, "Can't allocate D-BUS inquiry start message");
 		goto failed;
 	}
 
-	dbus_message_append_args(message,
-					DBUS_TYPE_STRING, &local_addr,
-					DBUS_TYPE_INVALID);
-
 	if (dbus_connection_send(connection, message, NULL) == FALSE) {
 		syslog(LOG_ERR, "Can't send D-BUS inquiry start message");
 		goto failed;
@@ -372,23 +378,29 @@
 
 void hcid_dbus_inquiry_complete(bdaddr_t *local)
 {
-	DBusMessage *message;
+	DBusMessage *message = NULL;
+	char path[MAX_PATH_LENGTH];
 	char *local_addr;
 	bdaddr_t tmp;
+	int id;
 
 	baswap(&tmp, local); local_addr = batostr(&tmp);
 
-	message = dbus_message_new_signal(BLUEZ_HCI_PATH,
+	id = hci_devid(local_addr);
+	if (id < 0) {
+		syslog(LOG_ERR, "No matching device id for %s", local_addr);
+		goto failed;
+	}
+
+	snprintf(path, sizeof(path), "%s/hci%d/%s", MANAGER_PATH, id, BLUEZ_HCI);
+
+	message = dbus_message_new_signal(path,
 				BLUEZ_HCI_INTERFACE, BLUEZ_HCI_INQ_COMPLETE);
 	if (message == NULL) {
 		syslog(LOG_ERR, "Can't allocate D-BUS inquiry complete message");
 		goto failed;
 	}
 
-	dbus_message_append_args(message,
-					DBUS_TYPE_STRING, &local_addr,
-					DBUS_TYPE_INVALID);
-
 	if (dbus_connection_send(connection, message, NULL) == FALSE) {
 		syslog(LOG_ERR, "Can't send D-BUS inquiry complete message");
 		goto failed;
@@ -406,16 +418,26 @@
 
 void hcid_dbus_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class, int8_t rssi)
 {
-	DBusMessage *message;
+	DBusMessage *message = NULL;
+	char path[MAX_PATH_LENGTH];
 	char *local_addr, *peer_addr;
 	dbus_uint32_t tmp_class = class;
 	dbus_int32_t tmp_rssi = rssi;
 	bdaddr_t tmp;
+	int id;
 
 	baswap(&tmp, local); local_addr = batostr(&tmp);
 	baswap(&tmp, peer); peer_addr = batostr(&tmp);
 
-	message = dbus_message_new_signal(BLUEZ_HCI_PATH,
+	id = hci_devid(local_addr);
+	if (id < 0) {
+		syslog(LOG_ERR, "No matching device id for %s", local_addr);
+		goto failed;
+	}
+
+	snprintf(path, sizeof(path), "%s/hci%d/%s", MANAGER_PATH, id, BLUEZ_HCI);
+
+	message = dbus_message_new_signal(path,
 				BLUEZ_HCI_INTERFACE, BLUEZ_HCI_INQ_RESULT);
 	if (message == NULL) {
 		syslog(LOG_ERR, "Can't allocate D-BUS inquiry result message");
@@ -423,7 +445,6 @@
 	}
 
 	dbus_message_append_args(message,
-					DBUS_TYPE_STRING, &local_addr,
 					DBUS_TYPE_STRING, &peer_addr,
 					DBUS_TYPE_UINT32, &tmp_class,
 					DBUS_TYPE_INT32, &tmp_rssi,
@@ -447,14 +468,24 @@
 
 void hcid_dbus_remote_name(bdaddr_t *local, bdaddr_t *peer, char *name)
 {
-	DBusMessage *message;
+	DBusMessage *message = NULL;
+	char path[MAX_PATH_LENGTH];
 	char *local_addr, *peer_addr;
 	bdaddr_t tmp;
+	int id;
 
 	baswap(&tmp, local); local_addr = batostr(&tmp);
 	baswap(&tmp, peer); peer_addr = batostr(&tmp);
 
-	message = dbus_message_new_signal(BLUEZ_HCI_PATH,
+	id = hci_devid(local_addr);
+	if (id < 0) {
+		syslog(LOG_ERR, "No matching device id for %s", local_addr);
+		goto failed;
+	}
+
+	snprintf(path, sizeof(path), "%s/hci%d/%s", MANAGER_PATH, id, BLUEZ_HCI);
+
+	message = dbus_message_new_signal(path,
 				BLUEZ_HCI_INTERFACE, BLUEZ_HCI_REMOTE_NAME);
 	if (message == NULL) {
 		syslog(LOG_ERR, "Can't allocate D-BUS remote name message");
@@ -462,7 +493,6 @@
 	}
 
 	dbus_message_append_args(message,
-					DBUS_TYPE_STRING, &local_addr,
 					DBUS_TYPE_STRING, &peer_addr,
 					DBUS_TYPE_STRING, &name,
 					DBUS_TYPE_INVALID);
@@ -1314,7 +1344,7 @@
 	struct hci_dbus_data *dbus_data = data;
 	int i;
 	int dev_id = -1;
-	int sk;
+	int sk = -1;
 
 	if (dbus_data->id == DEFAULT_DEVICE_PATH_ID) {
 		if ((dev_id = hci_get_route(NULL)) < 0) {

--bp/iNruPH9dso1Pn--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
