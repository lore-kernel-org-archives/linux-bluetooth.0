Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602201044v32058889w46985145313b81ba@mail.gmail.com>
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_9152_10714551.1140461058718"
Subject: [Bluez-devel] [DBUS PATCH] HasBonding
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
Date: Mon, 20 Feb 2006 15:44:18 -0300

------=_Part_9152_10714551.1140461058718
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

Here is the patch to check if there is a link key available for a remote de=
vice.
Do you have suggestions/comments?

Regards,
Claudio.
--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_9152_10714551.1140461058718
Content-Type: text/x-patch; name=has-bonding01.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ejwygjfw
Content-Disposition: attachment; filename="has-bonding01.patch"

--- bluez-utils-cvs.orig/hcid/hcid.h	2006-02-12 03:49:17.000000000 -0200
+++ bluez-utils-cvs-has-bonding/hcid/hcid.h	2006-02-20 12:38:29.000000000 -0300
@@ -154,6 +154,7 @@
 int stop_device(uint16_t dev_id);
 
 int get_device_address(uint16_t dev_id, char *address, size_t size);
+int get_device_bluetooth_address(uint16_t dev_id, bdaddr_t *ba);
 int get_device_version(uint16_t dev_id, char *version, size_t size);
 int get_device_revision(uint16_t dev_id, char *revision, size_t size);
 int get_device_manufacturer(uint16_t dev_id, char *manufacturer, size_t size);
--- bluez-utils-cvs.orig/hcid/device.c	2006-02-12 04:33:18.000000000 -0200
+++ bluez-utils-cvs-has-bonding/hcid/device.c	2006-02-20 12:38:06.000000000 -0300
@@ -227,6 +227,19 @@
 	return ba2str(&dev->bdaddr, address);
 }
 
+int get_device_bluetooth_address(uint16_t dev_id, bdaddr_t *ba)
+{
+	struct hci_dev *dev;
+
+	ASSERT_DEV_ID;
+
+	dev = &devices[dev_id];
+
+	memcpy(ba, &dev->bdaddr, sizeof(dev->bdaddr));
+
+	return 0;
+}
+
 int get_device_version(uint16_t dev_id, char *version, size_t size)
 {
 	struct hci_dev *dev;
--- bluez-utils-cvs.orig/hcid/dbus-device.c	2006-02-15 15:44:38.000000000 -0200
+++ bluez-utils-cvs-has-bonding/hcid/dbus-device.c	2006-02-20 12:37:40.000000000 -0300
@@ -735,8 +735,37 @@
 
 static DBusMessage* handle_dev_has_bonding_req(DBusMessage *msg, void *data)
 {
-	/*FIXME: */
-	return bluez_new_failure_msg(msg, BLUEZ_EDBUS_NOT_IMPLEMENTED);
+	unsigned char key[16];
+	struct hci_dbus_data *dbus_data = data;
+	DBusMessage *reply = NULL;
+	const char *str_bdaddr;
+	bdaddr_t dba;
+	bdaddr_t sba;
+	dbus_bool_t result = FALSE;
+
+	dbus_message_get_args(msg, NULL,
+			      DBUS_TYPE_STRING, &str_bdaddr,
+			      DBUS_TYPE_INVALID);
+
+	/* basic arguments validation */
+	if (!str_bdaddr || strlen(str_bdaddr) != 17)
+		return bluez_new_failure_msg(msg, BLUEZ_EDBUS_WRONG_PARAM);
+
+	str2ba(str_bdaddr, &dba);
+
+	/* get the local Bluetooth Address */
+	get_device_bluetooth_address(dbus_data->dev_id, &sba);
+
+	/* check if there is a link key associated to the remote device */
+	if(!read_link_key(&sba, &dba, key))
+		result = TRUE;
+
+	reply = dbus_message_new_method_return(msg);
+
+	dbus_message_append_args(reply, DBUS_TYPE_BOOLEAN, &result,
+					DBUS_TYPE_INVALID);
+
+	return reply;
 }
 
 static DBusMessage* handle_dev_remove_bonding_req(DBusMessage *msg, void *data)

------=_Part_9152_10714551.1140461058718--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
