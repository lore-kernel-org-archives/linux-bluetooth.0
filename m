Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20051105124837.GA27883@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="DBIVS5p969aUjpLe"
Subject: [Bluez-devel] [PATCH] dbus.c: cleanup/fix method parameter getting
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
Date: Sat, 5 Nov 2005 14:49:13 +0200


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

These patches have the following changes:

1. Return the right error if a matching handler is not found in the
device message handler function. Eduardo said he would fix it in his
next patch, but I think it's good to get the fix in as soon as possible.

2. Change a couple of places which use DBusMessageIter to use
dbus_message_get_args instead (just one function call and removes the
need to have the DBusMessageIter variable).

3. Use uint16 instead of uint8 for periodic inquiry period length
parameters (since they are two octets each in the HCI spec).

4. Fix checking for the range of inquiry parameters (HCI spec says
length 0x01-0x30 and num_resp 0x00-0xFF).

The range checking for periodic inquiry and role switch should probably
also be fixed at some point. However, the controller should return an
error if invalid values are passed to it, so I'm not even sure that it
should be hcid's task to check them. What do you think?

Another thing with the inquiry and periodic inquiry methods is that the
inquiry method allows the caller to specify the num_responses parameter
while the periodic inquiry method has it hardcoded to 100 currently.
Should the parameter also be added to periodic inquiry or should it be
removed from normal inquiry?

The reason why I'm submitting the changes in two patches is that there's
currently a bug[1] in the python dbus bindings which prevents uint16
values from being sent. The fix will probably go to the next dbus
release but we may want to wait for it before applying the change at our
end.

[1] http://lists.freedesktop.org/archives/dbus/2005-November/003733.html

Johan

--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dbus-args.patch"

Index: dbus.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.c,v
retrieving revision 1.48
diff -u -r1.48 dbus.c
--- dbus.c	4 Nov 2005 15:42:24 -0000	1.48
+++ dbus.c	5 Nov 2005 11:05:31 -0000
@@ -1222,15 +1222,19 @@
 	}
 
 	if (handlers) {
-		error = BLUEZ_EDBUS_WRONG_SIGNATURE;
 		for (; handlers->name != NULL; handlers++) {
 			if (strcmp(handlers->name, method) == 0) {
+				ret = DBUS_HANDLER_RESULT_HANDLED;
 				if (strcmp(handlers->signature, signature) == 0) {
 					reply = handlers->handler_func(msg, data);
 					error = 0;
-					ret = DBUS_HANDLER_RESULT_HANDLED;
 					break;
 				}
+				else
+					/* Set the error, but continue looping incase there is
+					 * another method with the same name but a different
+					 * signature */
+					error = BLUEZ_EDBUS_WRONG_SIGNATURE;
 
 			}
 		}
@@ -1392,22 +1396,20 @@
 
 static DBusMessage* handle_inq_req(DBusMessage *msg, void *data)
 {
-	DBusMessageIter iter;
 	DBusMessage *reply = NULL;
 	inquiry_cp cp;
 	evt_cmd_status rp;
 	struct hci_request rq;
 	struct hci_dbus_data *dbus_data = data;
 	int dd = -1;
-	int8_t length;
-	int8_t num_rsp;
+	uint8_t length, num_rsp;
 
-	dbus_message_iter_init(msg, &iter);
-	dbus_message_iter_get_basic(&iter, &length);
-	dbus_message_iter_next(&iter);
-	dbus_message_iter_get_basic(&iter, &num_rsp);
+	dbus_message_get_args(msg, NULL,
+			DBUS_TYPE_BYTE, &length,
+			DBUS_TYPE_BYTE, &num_rsp,
+			DBUS_TYPE_INVALID);
 
-	if ((length <= 0) || (num_rsp <= 0)) {
+	if (length < 0x01 || length > 0x30) {
 		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_WRONG_PARAM);
 		goto failed;
 	}
@@ -1486,7 +1488,6 @@
 
 static DBusMessage* handle_role_switch_req(DBusMessage *msg, void *data)
 {
-	DBusMessageIter iter;
 	DBusMessage *reply = NULL;
 	char *str_bdaddr = NULL;
 	struct hci_dbus_data *dbus_data = data;
@@ -1494,10 +1495,10 @@
 	uint8_t role;
 	int dev_id = -1, dd = -1;
 
-	dbus_message_iter_init(msg, &iter);
-	dbus_message_iter_get_basic(&iter, &str_bdaddr);
-	dbus_message_iter_next(&iter);
-	dbus_message_iter_get_basic(&iter, &role);
+	dbus_message_get_args(msg, NULL,
+			DBUS_TYPE_STRING, &str_bdaddr,
+			DBUS_TYPE_BYTE, &role,
+			DBUS_TYPE_INVALID);
 
 	str2ba(str_bdaddr, &bdaddr);
 
@@ -1536,7 +1537,6 @@
 
 static DBusMessage* handle_remote_name_req(DBusMessage *msg, void *data)
 {
-	DBusMessageIter iter;
 	DBusMessage *reply = NULL;
 	struct hci_dbus_data *dbus_data = data;
 	int dd = -1;
@@ -1546,8 +1546,9 @@
 	remote_name_req_cp cp;
 	evt_cmd_status rp;
 
-	dbus_message_iter_init(msg, &iter);
-	dbus_message_iter_get_basic(&iter, &str_bdaddr);
+	dbus_message_get_args(msg, NULL,
+			DBUS_TYPE_STRING, &str_bdaddr,
+			DBUS_TYPE_INVALID);
 
 	str2ba(str_bdaddr, &bdaddr);
 
@@ -1662,7 +1663,6 @@
 	struct hci_request rq;
 	auth_requested_cp cp;
 	evt_cmd_status rp;
-	DBusMessageIter iter;
 	DBusMessage *reply = NULL;
 	char *str_bdaddr = NULL;
 	struct hci_dbus_data *dbus_data = data;
@@ -1671,8 +1671,10 @@
 	int dev_id = -1;
 	int dd = -1;
 
-	dbus_message_iter_init(msg, &iter);
-	dbus_message_iter_get_basic(&iter, &str_bdaddr);
+	dbus_message_get_args(msg, NULL,
+			DBUS_TYPE_STRING, &str_bdaddr,
+			DBUS_TYPE_INVALID);
+
 	str2ba(str_bdaddr, &bdaddr);
 
 	dev_id = hci_for_each_dev(HCI_UP, find_conn, (long) &bdaddr);

--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dbus-args-uint16.patch"

Index: dbus-test
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-test,v
retrieving revision 1.2
diff -u -r1.2 dbus-test
--- dbus-test	3 Nov 2005 14:35:15 -0000	1.2
+++ dbus-test	5 Nov 2005 11:09:05 -0000
@@ -222,7 +222,7 @@
                 length, min, max = self.cmd_args
             self.listen = True
             try:
-                self.ctl.PeriodicInquiry(dbus.Byte(length), dbus.Byte(min), dbus.Byte(max))
+                self.ctl.PeriodicInquiry(dbus.Byte(length), dbus.UInt16(min), dbus.UInt16(max))
             except dbus.DBusException, e:
                 print 'Sending %s failed: %s' % (self.cmd, e)
                 sys.exit(1)
Index: dbus.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.c,v
retrieving revision 1.48
diff -u -r1.48 dbus.c
--- dbus.c	4 Nov 2005 15:42:24 -0000	1.48
+++ dbus.c	5 Nov 2005 11:09:05 -0000
@@ -1299,12 +1299,11 @@
 {
 	write_inquiry_mode_cp inq_mode;
 	periodic_inquiry_cp inq_param;
-	DBusMessageIter iter;
 	DBusMessage *reply = NULL;
 	struct hci_dbus_data *dbus_data = data;
 	uint8_t length;
-	uint8_t max_period;
-	uint8_t min_period;
+	uint16_t max_period;
+	uint16_t min_period;
 	int dd = -1;
 
 	dd = hci_open_dev(dbus_data->dev_id);
@@ -1314,12 +1313,13 @@
 		goto failed;
 	}
 
-	dbus_message_iter_init(msg, &iter);
-	dbus_message_iter_get_basic(&iter, &length);
-	dbus_message_iter_next(&iter);
-	dbus_message_iter_get_basic(&iter, &min_period);
-	dbus_message_iter_next(&iter);
-	dbus_message_iter_get_basic(&iter, &max_period);
+	dbus_message_get_args(msg, NULL,
+			DBUS_TYPE_BYTE, &length,
+			DBUS_TYPE_UINT16, &min_period,
+			DBUS_TYPE_UINT16, &max_period,
+			DBUS_TYPE_INVALID);
+
+	syslog(LOG_DEBUG, "%02X %04X %04X", length, min_period, max_period);
 
 	if (length >= min_period || min_period >= max_period) {
 		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_WRONG_PARAM);
@@ -1329,8 +1329,8 @@
 	inq_param.num_rsp = 100;
 	inq_param.length  = length;
 
-	inq_param.max_period = max_period;
-	inq_param.min_period = min_period;
+	inq_param.max_period = htobs(max_period);
+	inq_param.min_period = htobs(min_period);
 
 	/* General/Unlimited Inquiry Access Code (GIAC) */
 	inq_param.lap[0] = 0x33;
Index: dbus.h
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.h,v
retrieving revision 1.14
diff -u -r1.14 dbus.h
--- dbus.h	4 Nov 2005 15:42:24 -0000	1.14
+++ dbus.h	5 Nov 2005 11:09:06 -0000
@@ -166,8 +166,8 @@
 
 
 #define HCI_PERIODIC_INQ_SIGNATURE			DBUS_TYPE_BYTE_AS_STRING \
-							DBUS_TYPE_BYTE_AS_STRING \
-							DBUS_TYPE_BYTE_AS_STRING \
+							DBUS_TYPE_UINT16_AS_STRING \
+							DBUS_TYPE_UINT16_AS_STRING \
 							__END_SIG__
 
 #define HCI_CANCEL_PERIODIC_INQ_SIGNATURE		__END_SIG__

--DBIVS5p969aUjpLe--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
