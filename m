Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20051103072032.GA28568@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Subject: [Bluez-devel] [PATCH] dbus.c cleanup
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
Date: Thu, 3 Nov 2005 09:20:33 +0200


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Marcel,

Here's a cleanup patch for dbus.c which fixes some issues with
whitespace, coding-style, unecessary variables, etc.

I've also fixed PeriodicInquiry functionality of the python test script
(http://www.iki.fi/~jhedberg/bluez-python/pybt.py). It should now
support all currently implemented D-BUS services in hcid. Do you think
it would be worth including it in the bluez-utils cvs?

Johan

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cleanup.patch"

Index: hcid/dbus.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.c,v
retrieving revision 1.44
diff -u -r1.44 dbus.c
--- hcid/dbus.c	2 Nov 2005 18:46:46 -0000	1.44
+++ hcid/dbus.c	3 Nov 2005 07:12:24 -0000
@@ -106,7 +106,7 @@
 typedef struct  {
 	uint32_t code;
 	const char *str;
-}bluez_error_t;
+} bluez_error_t;
 
 typedef struct {
 	char *str;
@@ -381,14 +381,15 @@
 static gboolean register_dbus_path(const char *path, uint16_t path_id, uint16_t dev_id,
 				const DBusObjectPathVTable *pvtable, gboolean fallback)
 {
-	struct hci_dbus_data *data;
+	gboolean ret = FALSE;
+	struct hci_dbus_data *data = NULL;
 
 	syslog(LOG_INFO,"Registering DBUS Path: %s", path);
 
 	data = malloc(sizeof(struct hci_dbus_data));
 	if (data == NULL) {
 		syslog(LOG_ERR,"Failed to alloc memory to DBUS path register data (%s)", path);
-		return FALSE;
+		goto out;
 	}
 
 	data->path_id = path_id;
@@ -396,19 +397,23 @@
 
 	if (fallback) {
 		if (!dbus_connection_register_fallback(connection, path, pvtable, data)) {
-			syslog(LOG_ERR,"DBUS failed to register %s object", path);
-			free(data);
-			return FALSE;
+			syslog(LOG_ERR,"DBUS failed to register %s fallback", path);
+			goto out;
 		}
 	} else {
 		if (!dbus_connection_register_object_path(connection, path, pvtable, data)) {
 			syslog(LOG_ERR,"DBUS failed to register %s object", path);
-			free(data);
-			return FALSE;
+			goto out;
 		}
 	}
 
-	return TRUE;
+	ret = TRUE;
+
+out:
+	if (!ret && data)
+		free(data);
+
+	return ret;
 }
 
 static gboolean unregister_dbus_path(const char *path)
@@ -468,8 +473,7 @@
 
 failed:
 	dbus_message_unref(message);
-	hci_send_cmd(dev, OGF_LINK_CTL,
-				OCF_PIN_CODE_NEG_REPLY, 6, &ci->bdaddr);
+	hci_send_cmd(dev, OGF_LINK_CTL, OCF_PIN_CODE_NEG_REPLY, 6, &ci->bdaddr);
 }
 
 void hcid_dbus_inquiry_start(bdaddr_t *local)
@@ -506,10 +510,7 @@
 
 failed:
 	dbus_message_unref(message);
-
 	bt_free(local_addr);
-
-	return;
 }
 
 void hcid_dbus_inquiry_complete(bdaddr_t *local)
@@ -546,10 +547,7 @@
 
 failed:
 	dbus_message_unref(message);
-
 	bt_free(local_addr);
-
-	return;
 }
 
 void hcid_dbus_inquiry_result(bdaddr_t *local, bdaddr_t *peer, uint32_t class, int8_t rssi)
@@ -598,8 +596,6 @@
 
 	bt_free(local_addr);
 	bt_free(peer_addr);
-
-	return;
 }
 
 void hcid_dbus_remote_name(bdaddr_t *local, bdaddr_t *peer, char *name)
@@ -645,8 +641,6 @@
 
 	bt_free(local_addr);
 	bt_free(peer_addr);
-
-	return;
 }
 
 void hcid_dbus_remote_name_failed(bdaddr_t *local, bdaddr_t *peer, uint8_t status)
@@ -692,8 +686,6 @@
 
 	bt_free(local_addr);
 	bt_free(peer_addr);
-
-	return;
 }
 
 void hcid_dbus_conn_complete(bdaddr_t *local, bdaddr_t *peer)
@@ -910,7 +902,6 @@
 
 	unregister_dbus_path(DEVICE_PATH);
 	unregister_dbus_path(MANAGER_PATH);
-
 }
 
 gboolean hcid_dbus_register_device(uint16_t id) 
@@ -1046,7 +1037,7 @@
 
 	for (; ptr->id != INVALID_PATH_ID; ptr++) {
 		if (ptr->unreg_func(connection, id) < 0)
-			goto failed;
+			syslog(LOG_ERR, "Unregistering profile id %04X failed", ptr->id);
 	}
 
 	up_adapters--;
@@ -1161,8 +1152,6 @@
 	const struct service_data *handlers = NULL;
 	DBusMessage *reply = NULL;
 	struct hci_dbus_data *dbus_data = data;
-	int type;
-	const char *iface;
 	const char *method;
 	const char *signature;
 	const char *path;
@@ -1170,8 +1159,6 @@
 	DBusHandlerResult ret = DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 
 	path = dbus_message_get_path(msg);
-	type = dbus_message_get_type(msg);
-	iface = dbus_message_get_interface(msg);
 	method = dbus_message_get_member(msg);
 	signature = dbus_message_get_signature(msg);
 
@@ -1216,11 +1203,9 @@
 	if (error)
 		reply = bluez_new_failure_msg(msg, error);
 
-
 	if (reply) {
-		if (!dbus_connection_send (conn, reply, NULL)) {
+		if (!dbus_connection_send (conn, reply, NULL))
 			syslog(LOG_ERR, "Can't send reply message!");
-		}
 		dbus_message_unref (reply);
 	}
 
@@ -1240,7 +1225,7 @@
 
 	path = dbus_message_get_path(msg);
 	iface = dbus_message_get_interface(msg);
-	method = dbus_message_get_member (msg);
+	method = dbus_message_get_member(msg);
 	signature = dbus_message_get_signature(msg);
 
 	syslog (LOG_INFO, "%s - path:%s", __PRETTY_FUNCTION__, path);
@@ -1264,11 +1249,9 @@
 	if (error)
 		reply = bluez_new_failure_msg(msg, error);
 
-
 	if (reply) {
-		if (!dbus_connection_send (conn, reply, NULL)) {
+		if (!dbus_connection_send (conn, reply, NULL))
 			syslog(LOG_ERR, "Can't send reply message!");
-		}
 		dbus_message_unref (reply);
 	}
 
@@ -1505,13 +1488,10 @@
 	if (hci_switch_role(dd, &bdaddr, role, 10000) < 0) {
 		syslog(LOG_ERR, "Switch role request failed\n");
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
-	} else {
-		uint8_t result = 0;
-		/* return TRUE to indicate that operation was completed */
-		reply = dbus_message_new_method_return(msg);
-		dbus_message_iter_init_append(reply, &iter);
-		dbus_message_iter_append_basic(&iter, DBUS_TYPE_BYTE, &result);
+		goto failed;
 	}
+	
+	reply = dbus_message_new_method_return(msg);
 
 failed:
 	return reply;

--r5Pyd7+fXNt84Ff3--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
