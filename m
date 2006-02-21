Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602210649n3f391d0bgb3b6192e60ac083a@mail.gmail.com>
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_11045_29601364.1140533356120"
Subject: [Bluez-devel] [DBUS PATH] RemoveBonding
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
Date: Tue, 21 Feb 2006 11:49:16 -0300

------=_Part_11045_29601364.1140533356120
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

Here is the patch to remove bondings.

Please check the logic. I read the BlueZ D-Bus API and the Bluetooth
Spec, but I am not complete sure if I am covering all scenarios.

Regarding the HCI disconnect complete event, I think we need notify
the connected applications sending a D-Bus signal. What do you think?

Regards,
Claudio.
--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_11045_29601364.1140533356120
Content-Type: text/x-patch; name=remove-bonding01.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ejy5cah8
Content-Disposition: attachment; filename="remove-bonding01.patch"

--- bluez-utils-cvs.orig/hcid/dbus-device.c	2006-02-20 14:52:10.000000000 -0300
+++ bluez-utils-cvs-remove-bonding/hcid/dbus-device.c	2006-02-21 08:38:21.000000000 -0300
@@ -791,8 +791,121 @@
 
 static DBusMessage* handle_dev_remove_bonding_req(DBusMessage *msg, void *data)
 {
-	/*FIXME: */
-	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+	evt_disconn_complete dis_rp;
+	delete_stored_link_key_rp del_rp;
+	disconnect_cp dis_cp;
+	delete_stored_link_key_cp del_cp;
+	struct hci_request rq;
+	struct hci_dbus_data *dbus_data = data;
+	struct hci_conn_info_req *cr = NULL;
+	DBusMessageIter iter;
+	DBusMessage *reply = NULL;
+	char filename[PATH_MAX + 1];
+	char addr[18], *addr_ptr, *str;
+	bdaddr_t bdaddr;
+	int dd;
+
+	dd = hci_open_dev(dbus_data->dev_id);
+	if (dd < 0)
+		return bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_ENODEV);
+
+	get_device_address(dbus_data->dev_id, addr, sizeof(addr));
+
+	snprintf(filename, PATH_MAX, "%s/%s/linkkeys", STORAGEDIR, addr);
+
+	dbus_message_iter_init(msg, &iter);
+	dbus_message_iter_get_basic(&iter, &addr_ptr);
+
+	str = textfile_get(filename, addr_ptr);
+	if (str) {
+		/* delete the link key from linkkeys file */
+		textfile_del(filename, addr_ptr);
+		free(str);
+	}
+
+	str2ba(addr_ptr, &bdaddr);
+	
+	/* Send HCI Delete Stored Link Keys */
+	memset(&del_cp, 0, sizeof(del_cp));
+	memcpy(&del_cp.bdaddr, &bdaddr, sizeof(bdaddr));
+	del_cp.delete_all = 0; /* delete only bdaddr keys */
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf    = OGF_HOST_CTL;
+	rq.ocf    = OCF_DELETE_STORED_LINK_KEY;
+	rq.event  = EVT_CMD_COMPLETE;
+	rq.cparam = &del_cp;
+	rq.clen   = DELETE_STORED_LINK_KEY_CP_SIZE;
+	rq.rparam = &del_rp;
+	rq.rlen   = DELETE_STORED_LINK_KEY_RP_SIZE;
+	
+	if (hci_send_req(dd, &rq, 100) < 0) {
+		/* if fail, try disconnect */
+		syslog(LOG_ERR, "Can't send delete stored link key command");
+		goto disconnect;
+	}
+
+	if (del_rp.status) {
+		/* if fail, try disconnect */
+		syslog(LOG_ERR, "Delete store key failed with status: 0x%X", del_rp.status);
+		goto disconnect;
+	}
+
+disconnect:
+	/* close active connections for the remote device */
+	cr = malloc(sizeof(*cr) + sizeof(struct hci_conn_info));
+	if (!cr) {
+		syslog(LOG_ERR, "Can't allocate memory");
+		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_NO_MEM);
+		goto failed;
+	}
+
+	bacpy(&cr->bdaddr, &bdaddr);
+	cr->type = ACL_LINK;
+	if (ioctl(dd, HCIGETCONNINFO, (unsigned long) cr) < 0) {
+		/* Ignore when there isn't active connections, return success */
+		syslog(LOG_INFO, "skipping: there isn't active connections or get connection info failed");
+		reply = dbus_message_new_method_return(msg);
+		goto failed;
+	}
+
+	/* send the disconnect HCI command */
+	memset(&dis_cp, 0, sizeof(dis_cp));
+	dis_cp.handle = cr->conn_info->handle;
+	dis_cp.reason = HCI_OE_USER_ENDED_CONNECTION;
+
+	memset(&rq, 0, sizeof(rq));
+	rq.ogf    = OGF_LINK_CTL;
+	rq.ocf    = OCF_DISCONNECT;
+	rq.event  = EVT_DISCONN_COMPLETE;
+	rq.cparam = &dis_cp;
+	rq.clen   = DISCONNECT_CP_SIZE;
+	rq.rparam = &dis_rp;
+	rq.rlen   = EVT_DISCONN_COMPLETE_SIZE;
+
+	if (hci_send_req(dd, &rq, 100) < 0) {
+		syslog(LOG_ERR, "Can't send disconnect command");
+		reply = bluez_new_failure_msg(msg, BLUEZ_ESYSTEM_OFFSET | errno);
+		goto failed;
+	}
+
+	if (dis_rp.status) {
+		syslog(LOG_ERR, "Disconnect failed with status:0x%X", dis_rp.status);
+		reply = bluez_new_failure_msg(msg, BLUEZ_EBT_OFFSET | dis_rp.status);
+		goto failed;
+	}
+
+	reply = dbus_message_new_method_return(msg);
+
+failed:
+	if (dd >= 0)
+		close(dd);
+
+	if (cr)
+		free(cr);
+
+	return reply;
+
 }
 
 static DBusMessage* handle_dev_pin_code_length_req(DBusMessage *msg, void *data)




------=_Part_11045_29601364.1140533356120--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
