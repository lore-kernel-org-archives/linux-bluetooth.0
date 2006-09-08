Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45015406.60208@vasmac.com>
Date: Fri, 08 Sep 2006 07:29:10 -0400
From: Jose Vasconcellos <jose@vasmac.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="------------010406030606040807070806"
Subject: [Bluez-devel] hcid dbus patches
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010406030606040807070806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Here are a couple of patches that implement the following
commands in dbus-test:
GetRemoteClass
GetRemoteServiceHandles
GetRemoteServiceRecord

This required modifications to dbus-sdp.c. The problem was
that the call to dbus_message_get_args in this file used a NULL
pointer for the error structure. This patch adds a pointer in
the same way that dbus-adapter.c calls dbus_messsage_get_args.
The end result is that both GetRemoteService* calls now seem
to work.

Regards,

Jose Vasconcellos


--------------010406030606040807070806
Content-Type: text/x-patch;
 name="dbus-test.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dbus-test.patch"

--- dbus-test	2006-08-09 16:10:50.000000000 -0400
+++ ../../../bluez-utils-3.5/hcid/dbus-test	2006-09-08 07:00:56.000000000 -0400
@@ -55,6 +55,8 @@
              "GetEncryptionKeySize",
              "DiscoverDevices",
              "DiscoverDevicesWithoutNameResolving",
+             "GetRemoteServiceHandles",
+             "GetRemoteServiceRecord",
              "CancelDiscovery" ]
 dev_signals = [ "ModeChanged",
                 "NameChanged",
@@ -303,9 +305,9 @@
                    print self.device.GetRemoteCompany(self.cmd_args[0])
                else:
                    print 'Usage: %s -i <dev> GetRemoteCompany address' % self.name
-           elif self.cmd == 'GetRemoteAlias':
+           elif self.cmd == 'GetRemoteClass':
                if len(self.cmd_args) == 1:
-                   print self.device.GetRemoteAlias(self.cmd_args[0])
+                   print self.device.GetRemoteClass(self.cmd_args[0])
                else:
                    print 'Usage: %s -i <dev> GetRemoteAlias address' % self.name
            elif self.cmd == 'GetRemoteMajorClass':
@@ -323,6 +325,11 @@
                    print self.device.GetRemoteServiceClasses(self.cmd_args[0])
                else:
                    print 'Usage: %s -i <dev> GetRemoteServiceClasses address' % self.name
+           elif self.cmd == 'GetRemoteAlias':
+               if len(self.cmd_args) == 1:
+                   print self.device.GetRemoteAlias(self.cmd_args[0])
+               else:
+                   print 'Usage: %s -i <dev> GetRemoteAlias address' % self.name
            elif self.cmd == 'SetRemoteAlias':
                if len(self.cmd_args) == 2:
                    self.device.SetRemoteAlias(self.cmd_args[0], self.cmd_args[1])
@@ -386,6 +393,16 @@
                print self.device.DiscoverDevices()
            elif self.cmd == 'DiscoverDevicesWithoutNameResolving':
                print self.device.DiscoverDevicesWithoutNameResolving()
+           elif self.cmd == 'GetRemoteServiceHandles':
+               if len(self.cmd_args) == 1:
+                   print self.device.GetRemoteServiceHandles(self.cmd_args[0])
+               else:
+                   print 'Usage: %s -i <dev> GetRemoteServiceHandles address service' % self.name
+           elif self.cmd == 'GetRemoteServiceRecord':
+               if len(self.cmd_args) == 2:
+                   print self.device.GetRemoteServiceRecord(self.cmd_args[0],dbus.UInt32(self.cmd_args[1]))
+               else:
+                   print 'Usage: %s -i <dev> GetRemoteServiceRecord address service handle' % self.name
            else:
                 # FIXME: remove at future version
                 print 'Script Error: Method %s not found. Maybe a mispelled word.' % (self.cmd_args)

--------------010406030606040807070806
Content-Type: text/x-patch;
 name="dbus-sdp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dbus-sdp.patch"

--- dbus-sdp.c	2006-09-07 08:17:18.000000000 -0400
+++ ../../../bluez-utils-3.5/hcid/dbus-sdp.c	2006-09-08 07:11:28.000000000 -0400
@@ -444,8 +444,10 @@
 	int sk, err = 0;
 	socklen_t len;
 	const char *dst;
+	DBusError dbuserr;
 
-	dbus_message_get_args(ctxt->rq, NULL,
+	dbus_error_init(&dbuserr);
+	dbus_message_get_args(ctxt->rq, &dbuserr,
 			DBUS_TYPE_STRING, &dst,
 			DBUS_TYPE_INVALID);
 
@@ -481,6 +483,7 @@
 	DBusMessageIter iter, array_iter;
 	const char *dst;
 	int i, scanned;
+	DBusError dbuserr;
 
 	if (!ctxt)
 		return;
@@ -497,7 +500,8 @@
 		return;
 	}
 
-	dbus_message_get_args(ctxt->rq, NULL,
+	dbus_error_init(&dbuserr);
+	dbus_message_get_args(ctxt->rq, &dbuserr,
 			DBUS_TYPE_STRING, &dst,
 			DBUS_TYPE_INVALID);
 
@@ -540,6 +544,7 @@
 	uint8_t *pdata;
 	uint8_t dataType = 0;
 	int scanned, seqlen = 0;
+	DBusError dbuserr;
 
 	if (!ctxt)
 		return;
@@ -556,7 +561,8 @@
 		return;
 	}
 
-	dbus_message_get_args(ctxt->rq, NULL,
+	dbus_error_init(&dbuserr);
+	dbus_message_get_args(ctxt->rq, &dbuserr,
 			DBUS_TYPE_STRING, &dst,
 			DBUS_TYPE_INVALID);
 
@@ -612,6 +618,7 @@
 	const char *dst;
 	uint8_t *pdata;
 	int scanned = 0;
+	DBusError dbuserr;
 #ifdef SERVICE_SEARCH_ATTR_REQ
 	uint8_t dataType = 0;
 	int seqlen = 0;
@@ -638,7 +645,8 @@
 		return;
 	}
 
-	dbus_message_get_args(ctxt->rq, NULL,
+	dbus_error_init(&dbuserr);
+	dbus_message_get_args(ctxt->rq, &dbuserr,
 			DBUS_TYPE_STRING, &dst,
 			DBUS_TYPE_INVALID);
 
@@ -833,6 +841,7 @@
 	uint32_t range = 0x0000ffff;
 	const char *dst;
 	uint32_t handle;
+	DBusError dbuserr;
 	int err = 0;
 
 	if (sdp_set_notify(ctxt->session, remote_svc_rec_completed_cb, ctxt) < 0) {
@@ -841,7 +850,8 @@
 		goto fail;
 	}
 
-	dbus_message_get_args(ctxt->rq, NULL,
+	dbus_error_init(&dbuserr);
+	dbus_message_get_args(ctxt->rq, &dbuserr,
 			DBUS_TYPE_STRING, &dst,
 			DBUS_TYPE_UINT32, &handle,
 			DBUS_TYPE_INVALID);
@@ -866,13 +876,20 @@
 	struct hci_dbus_data *dbus_data = data;
 	const char *dst;
 	uint32_t handle;
+	DBusError dbuserr;
 	int err = 0;
 
-	if (!dbus_message_get_args(msg, NULL,
+	dbus_error_init(&dbuserr);
+	dbus_message_get_args(msg, &dbuserr,
 			DBUS_TYPE_STRING, &dst,
 			DBUS_TYPE_UINT32, &handle,
-			DBUS_TYPE_INVALID))
+				DBUS_TYPE_INVALID);
+
+	if (dbus_error_is_set(&dbuserr)) {
+		error("Can't extract message arguments:%s", dbuserr.message);
+		dbus_error_free(&dbuserr);
 		return error_invalid_arguments(conn, msg);
+	}
 
 	if (find_pending_connect(dst))
 		return error_service_search_in_progress(conn, msg);
@@ -923,12 +940,19 @@
 {
 	struct hci_dbus_data *dbus_data = data;
 	const char *dst;
+	DBusError dbuserr;
 	int err = 0;
 
-	if (!dbus_message_get_args(msg, NULL,
+	dbus_error_init(&dbuserr);
+	dbus_message_get_args(msg, &dbuserr,
 			DBUS_TYPE_STRING, &dst,
-			DBUS_TYPE_INVALID))
+				DBUS_TYPE_INVALID);
+
+	if (dbus_error_is_set(&dbuserr)) {
+		error("Can't extract message arguments:%s", dbuserr.message);
+		dbus_error_free(&dbuserr);
 		return error_invalid_arguments(conn, msg);
+	}
 
 	if (find_pending_connect(dst))
 		return error_service_search_in_progress(conn, msg);
@@ -984,12 +1008,19 @@
 {
 	struct hci_dbus_data *dbus_data = data;
 	const char *dst;
+	DBusError dbuserr;
 	int err = 0;
 
-	if (!dbus_message_get_args(msg, NULL,
+	dbus_error_init(&dbuserr);
+	dbus_message_get_args(msg, &dbuserr,
 			DBUS_TYPE_STRING, &dst,
-			DBUS_TYPE_INVALID))
+			DBUS_TYPE_INVALID);
+
+	if (dbus_error_is_set(&dbuserr)) {
+		error("Can't extract message arguments:%s", dbuserr.message);
+		dbus_error_free(&dbuserr);
 		return error_invalid_arguments(conn, msg);
+	}
 
 	/* in progress is not working properly */
 	if (find_pending_connect(dst))
@@ -1062,15 +1093,22 @@
 	char identifier[MAX_IDENTIFIER_LEN];
 	const char *ptr = identifier;
 	const char *dst, *svc;
+	DBusError dbuserr;
 	int err = 0, nrec = 0;
 	uint32_t class;
 	uuid_t uuid;
 
-	if (!dbus_message_get_args(msg, NULL,
+	dbus_error_init(&dbuserr);
+	dbus_message_get_args(msg, &dbuserr,
 			DBUS_TYPE_STRING, &dst,
 			DBUS_TYPE_STRING, &svc,
-			DBUS_TYPE_INVALID))
+			DBUS_TYPE_INVALID);
+
+	if (dbus_error_is_set(&dbuserr)) {
+		error("Can't extract message arguments:%s", dbuserr.message);
+		dbus_error_free(&dbuserr);
 		return error_invalid_arguments(conn, msg);
+	}
 
 	class = sdp_str2svclass(svc);
 	if (!class) {
@@ -1218,11 +1256,18 @@
 	char *ptr = uuid_str;
 	const char *identifier;
 	uint32_t handle;
+	DBusError dbuserr;
 
-	if (!dbus_message_get_args(msg, NULL,
+	dbus_error_init(&dbuserr);
+	dbus_message_get_args(msg, &dbuserr,
 				DBUS_TYPE_STRING, &identifier,
-				DBUS_TYPE_INVALID))
+				DBUS_TYPE_INVALID);
+
+	if (dbus_error_is_set(&dbuserr)) {
+		error("Can't extract message arguments:%s", dbuserr.message);
+		dbus_error_free(&dbuserr);
 		return error_invalid_arguments(conn, msg);
+	}
 
 	if (str2identifier(identifier, address, &handle) != 0)
 		return error_invalid_arguments(conn, msg);
@@ -1266,11 +1311,18 @@
 	const char *identifier;
 	uuid_t *puuid;
 	uint32_t handle;
+	DBusError dbuserr;
 
-	if (!dbus_message_get_args(msg, NULL,
+	dbus_error_init(&dbuserr);
+	dbus_message_get_args(msg, &dbuserr,
 				DBUS_TYPE_STRING, &identifier,
-				DBUS_TYPE_INVALID))
+				DBUS_TYPE_INVALID);
+
+	if (dbus_error_is_set(&dbuserr)) {
+		error("Can't extract message arguments:%s", dbuserr.message);
+		dbus_error_free(&dbuserr);
 		return error_invalid_arguments(conn, msg);
+	}
 
 	if (str2identifier(identifier, address, &handle) != 0)
 		return error_invalid_arguments(conn, msg);
@@ -1312,11 +1364,13 @@
 	char identifier[MAX_IDENTIFIER_LEN];
 	const char *ptr = identifier;
 	bdaddr_t sba;
+	DBusError dbuserr;
 	int err = 0;
 	uint8_t channel;
 
 	owner = dbus_message_get_sender(msg);
 
+	dbus_error_init(&dbuserr);
 	if (!dbus_message_get_args(msg, NULL,
 			DBUS_TYPE_STRING, &name,
 			DBUS_TYPE_BYTE, &channel,
@@ -1367,11 +1421,13 @@
 	DBusMessage *reply;
 	const char *owner, *identifier;
 	bdaddr_t sba;
+	DBusError dbuserr;
 	int err = 0;
 	uint32_t handle;
 
 	owner = dbus_message_get_sender(msg);
 
+	DBusError dbuserr;
 	if (!dbus_message_get_args(msg, NULL,
 			DBUS_TYPE_STRING, &identifier,
 			DBUS_TYPE_INVALID))

--------------010406030606040807070806
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------010406030606040807070806
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------010406030606040807070806--
