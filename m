Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602130950x5834aa71lb6eeeec3fc5bb4cd@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_12528_9485329.1139853040920"
Subject: [Bluez-devel] [DBUS PATCH] scan mode
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
Date: Mon, 13 Feb 2006 15:50:40 -0200

------=_Part_12528_9485329.1139853040920
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi guys,


This patch add/fix the following services:
1. Changed GetMode/SetMode arguments to string, instead of use byte
2. Added IsConnectable
3. Added IsDiscoverable

Next action:
- Discoverable timout functions.

Regards,
Claudio
--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_12528_9485329.1139853040920
Content-Type: text/x-patch; name=scan04.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ejmwiip7
Content-Disposition: attachment; filename="scan04.patch"

--- bluez-utils-cvs.orig/hcid/dbus.h	2006-02-12 05:27:40.000000000 -0200
+++ bluez-utils-cvs-scan/hcid/dbus.h	2006-02-13 11:53:24.000000000 -0200
@@ -206,17 +206,18 @@
 #define DEV_SIG_DISCOVER_COMPLETE	"DiscoverComplete"
 #define DEV_SIG_DISCOVER_RESULT		"DiscoverResult"
 
-/* FIXME: Change to string
+/*
  * Scanning modes, used by DEV_SET_MODE
  * off: remote devices are not allowed to find or connect to this device
  * connectable: remote devices are allowed to connect, but they are not
  *              allowed to find it.
  * discoverable: remote devices are allowed to connect and find this device
+ * unknown: reserved to not allowed/future modes
  */
-#define MODE_OFF		0x00	
-#define MODE_CONNECTABLE	0x01	
-#define MODE_DISCOVERABLE	0x02	
-
+#define MODE_OFF		"off"
+#define MODE_CONNECTABLE	"connectable"
+#define MODE_DISCOVERABLE	"discoverable"
+#define MODE_UNKNOWN		"unknown"
 
 /* BLUEZ_DBUS_ERROR 
  * EFailed error messages signature is : su
--- bluez-utils-cvs.orig/hcid/dbus-device.c	2006-02-12 04:33:18.000000000 -0200
+++ bluez-utils-cvs-scan/hcid/dbus-device.c	2006-02-13 12:42:26.000000000 -0200
@@ -41,6 +41,7 @@
 
 #include "textfile.h"
 
+
 static char *get_peer_name(const bdaddr_t *local, const bdaddr_t *peer)
 {
 	char filename[PATH_MAX + 1], addr[18];
@@ -257,7 +258,7 @@
 	const struct hci_dbus_data *dbus_data = data;
 	DBusMessage *reply = NULL;
 	const uint8_t hci_mode = dbus_data->path_data;
-	uint8_t scan_mode;
+	const char *scan_mode;
 
 	switch (hci_mode) {
 	case SCAN_DISABLED:
@@ -270,16 +271,16 @@
 		scan_mode = MODE_DISCOVERABLE;
 		break;
 	case SCAN_INQUIRY:
-	/* inquiry scan mode is not handled, return 0xff */
+	/* inquiry scan mode is not handled, return unknown */
 	default:
 		/* reserved */
-		scan_mode = 0xff;
+		scan_mode = MODE_UNKNOWN;
 	}
 
 	reply = dbus_message_new_method_return(msg);
 
 	dbus_message_append_args(reply,
-					DBUS_TYPE_BYTE, &scan_mode,
+					DBUS_TYPE_STRING, &scan_mode,
 					DBUS_TYPE_INVALID);
 
 	return reply;
@@ -287,14 +288,40 @@
 
 static DBusMessage* handle_dev_is_connectable_req(DBusMessage *msg, void *data)
 {
-	/*FIXME: */
-	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+	const struct hci_dbus_data *dbus_data = data;
+	DBusMessage *reply = NULL;
+	const uint8_t hci_mode = dbus_data->path_data;
+	dbus_bool_t connectable = FALSE;
+
+	if (hci_mode & SCAN_PAGE)
+		connectable = TRUE;
+
+	reply = dbus_message_new_method_return(msg);
+
+	dbus_message_append_args(reply,
+					DBUS_TYPE_BOOLEAN, &connectable,
+					DBUS_TYPE_INVALID);
+
+	return reply;
 }
 
 static DBusMessage* handle_dev_is_discoverable_req(DBusMessage *msg, void *data)
 {
-	/*FIXME: */
-	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+	const struct hci_dbus_data *dbus_data = data;
+	DBusMessage *reply = NULL;
+	const uint8_t hci_mode = dbus_data->path_data;
+	dbus_bool_t discoverable = FALSE;
+
+	if (hci_mode & SCAN_INQUIRY)
+		discoverable = TRUE;
+	
+	reply = dbus_message_new_method_return(msg);
+
+	dbus_message_append_args(reply,
+					DBUS_TYPE_BOOLEAN, &discoverable,
+					DBUS_TYPE_INVALID);
+
+	return reply;
 }
 
 static DBusMessage* handle_dev_set_class_req(DBusMessage *msg, void *data)
@@ -315,36 +342,31 @@
 	DBusMessage *reply = NULL;
 	struct hci_request rq;
 	int dd = -1;
-	const uint8_t scan_mode;
+	const char* scan_mode;
 	uint8_t hci_mode;
 	uint8_t status = 0;
 	const uint8_t current_mode = dbus_data->path_data;
 
 	dbus_message_get_args(msg, NULL,
-					DBUS_TYPE_BYTE, &scan_mode,
+					DBUS_TYPE_STRING, &scan_mode,
 					DBUS_TYPE_INVALID);
 
-	switch (scan_mode) {
-	case MODE_OFF:
+	if (!scan_mode)
+		return bluez_new_failure_msg(msg, BLUEZ_EDBUS_WRONG_PARAM);
+
+	if (strcasecmp(MODE_OFF, scan_mode) == 0)
 		hci_mode = SCAN_DISABLED;
-		break;
-	case MODE_CONNECTABLE:
+	else if (strcasecmp(MODE_CONNECTABLE, scan_mode) == 0)
 		hci_mode = SCAN_PAGE;
-		break;
-	case MODE_DISCOVERABLE:
+	else if (strcasecmp(MODE_DISCOVERABLE, scan_mode) == 0)
 		hci_mode = (SCAN_PAGE | SCAN_INQUIRY);
-		break;
-	default:
-		/* invalid mode */
-		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_WRONG_PARAM);
-		goto failed;
-	}
+	else
+		return bluez_new_failure_msg(msg, BLUEZ_EDBUS_WRONG_PARAM);
 
 	dd = hci_open_dev(dbus_data->dev_id);
 	if (dd < 0) {
 		syslog(LOG_ERR, "HCI device open failed: hci%d", dbus_data->dev_id);
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
-		goto failed;
+		return bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
 	}
 
 	/* Check if the new requested mode is different from the current */
--- bluez-utils-cvs.orig/hcid/dbus.c	2006-02-12 03:49:17.000000000 -0200
+++ bluez-utils-cvs-scan/hcid/dbus.c	2006-02-13 12:42:27.000000000 -0200
@@ -1054,7 +1054,7 @@
 	struct hci_request rq;
 	int id;
 	int dd = -1;
-	uint8_t scan_mode;
+	const char *scan_mode;
 
 	baswap(&tmp, local); local_addr = batostr(&tmp);
 	id = hci_devid(local_addr);
@@ -1123,7 +1123,7 @@
 	}
 
 	dbus_message_append_args(message,
-					DBUS_TYPE_BYTE, &scan_mode,
+					DBUS_TYPE_STRING, &scan_mode,
 					DBUS_TYPE_INVALID);
 
 	if (dbus_connection_send(connection, message, NULL) == FALSE) {

------=_Part_12528_9485329.1139853040920--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
