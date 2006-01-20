Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0601201037y4d6eccdem6a9cbca135196520@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_14314_22285675.1137782277332"
Subject: [Bluez-devel] [DBUS] remote name patch
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
Date: Fri, 20 Jan 2006 16:37:57 -0200

------=_Part_14314_22285675.1137782277332
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

The attached patch improves the remote name request. It's the same
approach of "hcitool name", I am using the textfile library. Maybe we
should move the function "get_device_name" to a common place, like
"libtextfile.a" or create a new utility library(ie: "libbluezutil.a").

Another point is an option to "force" send HCI remote name instead of
use the stored value. If you want I can add an extra argument(boolean)
to indicate the type(use cache/no cache), but keeping the backward
compatibility, where the default request signature is use the cache.

1. RemoteName("AA:BB:CC:DD:EE:FF")  =3D=3D RemoteName("AA:BB:CC:DD:EE:FF", =
TRUE)
2. RemoteName("AA:BB:CC:DD:EE:FF", FALSE)

Regards,
Claudio.
--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_14314_22285675.1137782277332
Content-Type: text/x-patch; name=remote_name_cache01.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="remote_name_cache01.patch"

--- bluez-utils-cvs.orig/hcid/dbus.c	2006-01-03 11:28:58.000000000 -0200
+++ bluez-utils-cvs/hcid/dbus.c	2006-01-20 12:54:29.000000000 -0200
@@ -45,6 +45,7 @@
 
 #include "hcid.h"
 #include "dbus.h"
+#include "textfile.h"
 
 #ifndef DBUS_NAME_FLAG_PROHIBIT_REPLACEMENT
 #define DBUS_NAME_FLAG_PROHIBIT_REPLACEMENT	0x00
@@ -98,6 +99,19 @@
 	unregister_function_t	*unreg_func;
 	get_svc_table_func_t	*get_svc_table;	/* return the service table */
 };
+/*
+ * Utility functions
+ */
+static char *get_device_name(const bdaddr_t *local, const bdaddr_t *peer)
+{
+	char filename[PATH_MAX + 1], addr[18];
+
+	ba2str(local, addr);
+	snprintf(filename, PATH_MAX, "%s/%s/names", STORAGEDIR, addr);
+
+	ba2str(peer, addr);
+	return textfile_get(filename, addr);
+}
 
 /*
  * D-Bus error messages functions and declarations.
@@ -1709,13 +1723,17 @@
 static DBusMessage* handle_remote_name_req(DBusMessage *msg, void *data)
 {
 	DBusMessage *reply = NULL;
+	DBusMessage *signal = NULL;
 	struct hci_dbus_data *dbus_data = data;
-	int dd = -1;
 	const char *str_bdaddr;
+	char *name;
+	char path[MAX_PATH_LENGTH];
 	bdaddr_t bdaddr;
+	struct hci_dev_info di;
 	struct hci_request rq;
 	remote_name_req_cp cp;
 	evt_cmd_status rp;
+	int dd = -1;
 
 	dbus_message_get_args(msg, NULL,
 					DBUS_TYPE_STRING, &str_bdaddr,
@@ -1723,36 +1741,72 @@
 
 	str2ba(str_bdaddr, &bdaddr);
 
-	dd = hci_open_dev(dbus_data->dev_id);
-	if (dd < 0) {
-		syslog(LOG_ERR, "Unable to open device %d: %s (%d)",
-					dbus_data->dev_id, strerror(errno), errno);
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+	if (hci_devinfo(dbus_data->dev_id, &di) < 0) {
+		syslog(LOG_ERR, "Can't get device info");
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
 		goto failed;
 	}
 
-	memset(&cp, 0, sizeof(cp));
-	cp.bdaddr = bdaddr;
-	cp.pscan_rep_mode = 0x01;
+	/* Try retrieve from local cache */
+	name = get_device_name(&di.bdaddr, &bdaddr);
+	if (name) {
+		reply = dbus_message_new_method_return(msg);
 
-	memset(&rq, 0, sizeof(rq));
-	rq.ogf    = OGF_LINK_CTL;
-	rq.ocf    = OCF_REMOTE_NAME_REQ;
-	rq.cparam = &cp;
-	rq.clen   = REMOTE_NAME_REQ_CP_SIZE;
-	rq.rparam = &rp;
-	rq.rlen   = EVT_CMD_STATUS_SIZE;
-	rq.event  = EVT_CMD_STATUS;
+		snprintf(path, sizeof(path), "%s/hci%d/%s", DEVICE_PATH, dbus_data->dev_id, BLUEZ_HCI);
 
-	if (hci_send_req(dd, &rq, 100) < 0) {
-		syslog(LOG_ERR, "Unable to send remote name request: %s (%d)",
-							strerror(errno), errno);
-		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
-		goto failed;
+		signal = dbus_message_new_signal(path, DEV_HCI_INTERFACE,
+						 BLUEZ_HCI_REMOTE_NAME);
+
+		dbus_message_append_args(signal,
+					 DBUS_TYPE_STRING, &str_bdaddr,
+					 DBUS_TYPE_STRING, &name,
+					 DBUS_TYPE_INVALID);
+
+		if (dbus_connection_send(connection, signal, NULL) == FALSE) {
+			syslog(LOG_ERR, "Can't send D-BUS remote name signal message");
+			goto failed;
+		}
+
+		dbus_message_unref(signal);
+
+		reply = dbus_message_new_method_return(msg);
+		free(name);
+
+	} else {
+
+		/* Send HCI command */
+		dd = hci_open_dev(dbus_data->dev_id);
+		if (dd < 0) {
+			syslog(LOG_ERR, "Unable to open device %d: %s (%d)",
+						dbus_data->dev_id, strerror(errno), errno);
+			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+			goto failed;
+		}
+
+		memset(&cp, 0, sizeof(cp));
+		cp.bdaddr = bdaddr;
+		cp.pscan_rep_mode = 0x01;
+
+		memset(&rq, 0, sizeof(rq));
+		rq.ogf    = OGF_LINK_CTL;
+		rq.ocf    = OCF_REMOTE_NAME_REQ;
+		rq.cparam = &cp;
+		rq.clen   = REMOTE_NAME_REQ_CP_SIZE;
+		rq.rparam = &rp;
+		rq.rlen   = EVT_CMD_STATUS_SIZE;
+		rq.event  = EVT_CMD_STATUS;
+
+		if (hci_send_req(dd, &rq, 100) < 0) {
+			syslog(LOG_ERR, "Unable to send remote name request: %s (%d)",
+						strerror(errno), errno);
+			reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
+			goto failed;
+		}
+
+		reply = dbus_message_new_method_return(msg);
 	}
 
 	reply = dbus_message_new_method_return(msg);
-
 failed:
 	if (dd >= 0)
 		hci_close_dev(dd);












------=_Part_14314_22285675.1137782277332--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
