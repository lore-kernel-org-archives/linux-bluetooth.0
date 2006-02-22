Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0602220912k39f3f9d0g627bca665e0c4dad@mail.gmail.com>
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_6548_30724801.1140628321277"
Subject: [Bluez-devel] [DBUS PATCH] msg_func_device: wrong request handling for unknow methods
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
Date: Wed, 22 Feb 2006 14:12:01 -0300

------=_Part_6548_30724801.1140628321277
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel,

Here is a patch to fix the function msg_func_device.

While Eduardo was fixing the dbus-test script he noticed a strange
reply value. The daemon was returning two consecutives error
messages(unknow method and unknow path) for services   not implemented
in the path.

This bug happens due the registered fallback path associated with the
wrong return value. The "/org/bluez/Device/hciX" was returning unknow
method and the root path "/org/bluez/Device" was returning unknow
path.


Regards,
Claudio
--
---------------------------------------------------------
Claudio Takahasi
Instituto Nokia de Tecnologia - INdT

------=_Part_6548_30724801.1140628321277
Content-Type: text/x-patch; name=msg_func_device.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ejzpfpt4
Content-Disposition: attachment; filename="msg_func_device.patch"

Index: hcid/dbus-device.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-device.c,v
retrieving revision 1.6
diff -u -r1.6 dbus-device.c
--- hcid/dbus-device.c	21 Feb 2006 23:55:19 -0000	1.6
+++ hcid/dbus-device.c	22 Feb 2006 16:48:21 -0000
@@ -917,17 +917,20 @@
 	struct hci_dbus_data *dbus_data = data;
 	const char *method;
 	const char *signature;
+	const char *iface;
 	uint32_t error = BLUEZ_EDBUS_UNKNOWN_METHOD;
-	DBusHandlerResult ret = DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
 
 	method = dbus_message_get_member(msg);
 	signature = dbus_message_get_signature(msg);
+	iface = dbus_message_get_interface(msg);
 
 	syslog(LOG_INFO, "[%s,%d] path:%s, method:%s", __PRETTY_FUNCTION__, __LINE__, dbus_message_get_path(msg), method);
 
+	if (strcmp(DEVICE_INTERFACE, iface))
+		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+
 	if (dbus_data->path_id == DEVICE_ROOT_ID) {
 		/* Device is down(path unregistered) or the path is wrong */
-		ret = DBUS_HANDLER_RESULT_HANDLED;
 		error = BLUEZ_EDBUS_UNKNOWN_PATH;
 		goto failed;
 	}
@@ -937,8 +940,6 @@
 		if (strcmp(handlers->name, method))
 			continue;
 
-		ret = DBUS_HANDLER_RESULT_HANDLED;
-
 		if (!strcmp(handlers->signature, signature)) {
 			reply = handlers->handler_func(msg, data);
 			error = 0;
@@ -962,5 +963,5 @@
 		dbus_message_unref(reply);
 	}
 
-	return ret;
+	return DBUS_HANDLER_RESULT_HANDLED;
 }






------=_Part_6548_30724801.1140628321277--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
