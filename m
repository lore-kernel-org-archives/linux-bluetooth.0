Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20051029175338.GA26114@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
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
Date: Sat, 29 Oct 2005 20:53:38 +0300


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Here's a cleanup patch for the hcid dbus code. It changes several
sprintf calls to snprintf (better to risk string truncation than buffer
overflow), as well as removes unecessary byte parameters from the replys
of periodic inquiry methods.

Johan

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dbus-cleanup.patch"

Index: dbus.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.c,v
retrieving revision 1.36
diff -u -r1.36 dbus.c
--- dbus.c	27 Oct 2005 17:08:13 -0000	1.36
+++ dbus.c	29 Oct 2005 17:44:37 -0000
@@ -886,12 +886,12 @@
 
 		for (; *fst_level; fst_level++) {
 			ptr1 = *fst_level;
-			sprintf(snd_parent, "%s/%s", fst_parent, ptr1);
+			snprintf(snd_parent, sizeof(snd_parent), "%s/%s", fst_parent, ptr1);
 
 			if (dbus_connection_list_registered(connection, snd_parent, &snd_level)) {
 
 				if (!(*snd_level)) {
-					sprintf(path, "%s/%s", MANAGER_PATH, ptr1);
+					snprintf(path, sizeof(path), "%s/%s", MANAGER_PATH, ptr1);
 
 					if (dbus_connection_get_object_path_data(connection,
 								path, &data)) {
@@ -909,7 +909,7 @@
 
 				for (; *snd_level; snd_level++) {
 					ptr2 = *snd_level;
-					sprintf(path, "%s/%s/%s", MANAGER_PATH, ptr1, ptr2);
+					snprintf(path, sizeof(path), "%s/%s/%s", MANAGER_PATH, ptr1, ptr2);
 
 					if (dbus_connection_get_object_path_data(connection,
 								path, &data)) {
@@ -935,12 +935,12 @@
 
 gboolean hcid_dbus_register_device(uint16_t id) 
 {
-	char path[MAX_PATH_LENGTH+1];
-	char dev[BLUETOOTH_DEVICE_NAME_LEN+1];
+	char path[MAX_PATH_LENGTH];
+	char dev[BLUETOOTH_DEVICE_NAME_LEN];
 	const char *pdev = dev;
 
-	snprintf(dev, BLUETOOTH_DEVICE_NAME_LEN, HCI_DEVICE_NAME "%d", id);
-	snprintf(path, MAX_PATH_LENGTH, "%s/%s", DEVICE_PATH, pdev);
+	snprintf(dev, sizeof(dev), HCI_DEVICE_NAME "%d", id);
+	snprintf(path, sizeof(path), "%s/%s", DEVICE_PATH, pdev);
 
 	/* register the default path*/
 	return register_dbus_path(path, id);
@@ -948,12 +948,12 @@
 
 gboolean hcid_dbus_unregister_device(uint16_t id)
 {
-	char dev[BLUETOOTH_DEVICE_NAME_LEN+1];
-	char path[MAX_PATH_LENGTH+1];
+	char dev[BLUETOOTH_DEVICE_NAME_LEN];
+	char path[MAX_PATH_LENGTH];
 	const char *pdev = dev;
 
-	snprintf(dev, BLUETOOTH_DEVICE_NAME_LEN, HCI_DEVICE_NAME "%d", id);
-	snprintf(path, MAX_PATH_LENGTH, "%s/%s", DEVICE_PATH, pdev);
+	snprintf(dev, sizeof(dev), HCI_DEVICE_NAME "%d", id);
+	snprintf(path, sizeof(path), "%s/%s", DEVICE_PATH, pdev);
 
 	return unregister_dbus_path(path);
 }
@@ -986,7 +986,7 @@
 		goto failed;
 	}
 
-	sprintf(dev, HCI_DEVICE_NAME "%d", id);
+	snprintf(dev, sizeof(dev), HCI_DEVICE_NAME "%d", id);
 
 	dbus_message_iter_init_append(message, &iter);
 	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING ,&pdev);
@@ -1036,7 +1036,7 @@
 		goto failed;
 	}
 
-	sprintf(dev, HCI_DEVICE_NAME "%d", id);
+	snprintf(dev, sizeof(dev), HCI_DEVICE_NAME "%d", id);
 
 	dbus_message_iter_init_append(message, &iter);
 	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING ,&pdev);
@@ -1072,12 +1072,12 @@
 
 	/* register the default path*/
 	if (!dft_reg) {
-		sprintf(path, "%s/%s/%s", MANAGER_PATH, HCI_DEFAULT_DEVICE_NAME, BLUEZ_HCI);
+		snprintf(path, sizeof(path), "%s/%s/%s", MANAGER_PATH, HCI_DEFAULT_DEVICE_NAME, BLUEZ_HCI);
 		register_dbus_path(path, DEFAULT_DEVICE_PATH_ID);
 	}
 
 	/* register the default path*/
-	sprintf(path, "%s/%s%d/%s", MANAGER_PATH, HCI_DEVICE_NAME, id, BLUEZ_HCI);
+	snprintf(path, sizeof(path), "%s/%s%d/%s", MANAGER_PATH, HCI_DEVICE_NAME, id, BLUEZ_HCI);
 	register_dbus_path(path, id);
 
 	return 0;
@@ -1099,11 +1099,11 @@
 	char path[MAX_PATH_LENGTH];
 
 	if (unreg_dft) {
-		sprintf(path, "%s/%s/%s", MANAGER_PATH, HCI_DEFAULT_DEVICE_NAME, BLUEZ_HCI);
+		snprintf(path, sizeof(path), "%s/%s/%s", MANAGER_PATH, HCI_DEFAULT_DEVICE_NAME, BLUEZ_HCI);
 		unregister_dbus_path(path);
 	}
 
-	sprintf(path, "%s/%s%d/%s", MANAGER_PATH, HCI_DEVICE_NAME, id, BLUEZ_HCI);
+	snprintf(path, sizeof(path), "%s/%s%d/%s", MANAGER_PATH, HCI_DEVICE_NAME, id, BLUEZ_HCI);
 	unregister_dbus_path(path);
 
 	return ret;
@@ -1318,14 +1318,10 @@
 		syslog(LOG_ERR, "Can't send HCI commands:%s.", strerror(errno));
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
 		goto failed;
-	} else {
-		uint8_t result = 0;
-		/* return TRUE to indicate that operation was completed */
-		reply = dbus_message_new_method_return(msg);
-		dbus_message_iter_init_append(reply, &iter);
-		dbus_message_iter_append_basic(&iter, DBUS_TYPE_BYTE ,&result);
 	}
 
+	reply = dbus_message_new_method_return(msg);
+
 failed:
 	if (dd >= 0)
 		close(dd);
@@ -1335,7 +1331,6 @@
 
 static DBusMessage* handle_cancel_periodic_inq_req(DBusMessage *msg, void *data)
 {
-	DBusMessageIter iter;
 	DBusMessage *reply = NULL;
 	struct hci_dbus_data *dbus_data = data;
 	int dd = -1;
@@ -1361,14 +1356,11 @@
 	if (hci_send_cmd(dd, OGF_LINK_CTL, OCF_EXIT_PERIODIC_INQUIRY, 0 , NULL) < 0) {
 		syslog(LOG_ERR, "Send hci command failed.");
 		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET + errno);
-	} else {
-		uint8_t result  = 0;
-		/* return TRUE to indicate that operation was completed */
-		reply = dbus_message_new_method_return(msg);
-		dbus_message_iter_init_append(reply, &iter);
-		dbus_message_iter_append_basic(&iter, DBUS_TYPE_BYTE ,&result);
+		goto failed;
 	}
 
+	reply = dbus_message_new_method_return(msg);
+
 failed:
 	if (dd >= 0)
 		close(dd);

--7AUc2qLy4jB3hD7Z--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
