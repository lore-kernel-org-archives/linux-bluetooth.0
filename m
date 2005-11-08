Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20051108134311.GA7150@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
Subject: [Bluez-devel] [PATCH] Variable arguments to Inquiry and PeriodicInquiry D-BUS methods
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
Date: Tue, 8 Nov 2005 15:43:11 +0200


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Here's a patch which allows Inquiry and PeriodicInquiry to be called
with two possible sets of parameters. We can't unfortunately get (at
least very easily) the same flexibility that you can get with e.g.
command line options because there are no "labels" for the D-BUS
parameters. So, the solution I went for was that either you provide only
the essential parameters (the ones that don't have a sane default
value), or then you provide all parameters.

The possible ways of calling the methods after applying this patch are:

Inquiry()
Inquiry(byte: length, byte: num_rsp, uint32: lap)
PeriodicInquiry(byte: length, uint16: min_period, uint16: max_period)
PeriodicInquiry(byte: length, uint16: min_period, uint16: max_period,
		byte: num_rsp, uint32: lap)

With dbus-test you can test this with e.g.
./dbus-test Inquiry 8 100 0x9e8b33

Then, I'd like to start some discussion about the interface for setting
default values for certain parameters. I'd suggest to use a similar
interface that we currently have for the properties where there are only
two methods ("Set" and "Get") and strings are used to identify the
parameter which should be operated on. I think it would be good to have
each module under the device path (e.g. "Controller", "PAN", etc.)
implement this interface. You would then do something like:

Object: /org/bluez/Device/hci0/Controller
Interface: org.bluez.Defaults
Method: Set("LAP", 0x9e8b00)

Object: /org/bluez/Device/hci0/Controller
Interface: org.bluez.Defaults
Method: Set("role", "slave")

Object: /org/bluez/Device/hci0/RFCOMM
Interface: org.bluez.Defaults
Method: Set("authenticate", True)

Does this sound like a sensible way to do it?

Johan


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="inq-params.patch"

Index: hcid/dbus-test
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-test,v
retrieving revision 1.3
diff -u -r1.3 dbus-test
--- hcid/dbus-test	6 Nov 2005 21:24:05 -0000	1.3
+++ hcid/dbus-test	8 Nov 2005 13:05:29 -0000
@@ -182,12 +182,12 @@
 
         # Device.Controller methods
         elif self.cmd == 'Inquiry':
-            if len(self.cmd_args) != 2:
-                length, maxrsp = (10, 100)
-            else:
-                length, maxrsp = self.cmd_args
             try:
-                self.ctl.Inquiry(dbus.Byte(length), dbus.Byte(maxrsp))
+                if len(self.cmd_args) != 3:
+                    self.ctl.Inquiry()
+                else:
+                    length, maxrsp, lap = self.cmd_args
+                    self.ctl.Inquiry(dbus.Byte(length), dbus.Byte(maxrsp), dbus.UInt32(long(lap, 0)))
             except dbus.DBusException, e:
                 print 'Sending %s failed: %s' % (self.cmd, e)
                 sys.exit(1)
@@ -216,13 +216,18 @@
             self.exit_events.append('RemoteName')
 
         elif self.cmd == 'PeriodicInquiry':
-            if len(self.cmd_args) != 3:
-                length, min, max = (6, 20, 60)
-            else:
-                length, min, max = self.cmd_args
-            self.listen = True
             try:
-                self.ctl.PeriodicInquiry(dbus.Byte(length), dbus.UInt16(min), dbus.UInt16(max))
+                if len(self.cmd_args) < 3:
+                    length, min, max = (6, 20, 60)
+                    self.ctl.PeriodicInquiry(dbus.Byte(length), dbus.UInt16(min), dbus.UInt16(max))
+                elif len(self.cmd_args) == 3:
+                    length, min, max = self.cmd_args
+                    self.ctl.PeriodicInquiry(dbus.Byte(length), dbus.UInt16(min), dbus.UInt16(max))
+                else:
+                    length, min, max, nrsp, lap = self.cmd_args
+                    self.ctl.PeriodicInquiry(dbus.Byte(length), dbus.UInt16(min), dbus.UInt16(max),
+                            dbus.Byte(nrsp), dbus.UInt32(long(lap, 0)))
+                self.listen = True
             except dbus.DBusException, e:
                 print 'Sending %s failed: %s' % (self.cmd, e)
                 sys.exit(1)
Index: hcid/dbus.c
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.c,v
retrieving revision 1.51
diff -u -r1.51 dbus.c
--- hcid/dbus.c	6 Nov 2005 21:37:17 -0000	1.51
+++ hcid/dbus.c	8 Nov 2005 13:05:30 -0000
@@ -356,9 +356,11 @@
 
 static const struct service_data device_hci_services[] = {
 	{ HCI_PERIODIC_INQ,		handle_periodic_inq_req,	HCI_PERIODIC_INQ_SIGNATURE		},
+	{ HCI_PERIODIC_INQ,		handle_periodic_inq_req,	HCI_PERIODIC_INQ_EXT_SIGNATURE		},
 	{ HCI_CANCEL_PERIODIC_INQ,	handle_cancel_periodic_inq_req,	HCI_CANCEL_PERIODIC_INQ_SIGNATURE	},
 	{ HCI_ROLE_SWITCH,		handle_role_switch_req,		HCI_ROLE_SWITCH_SIGNATURE		},
 	{ HCI_INQ,			handle_inq_req,			HCI_INQ_SIGNATURE			},
+	{ HCI_INQ,			handle_inq_req,			HCI_INQ_EXT_SIGNATURE			},
 	{ HCI_CANCEL_INQ,		handle_cancel_inq_req,		HCI_CANCEL_INQ_SIGNATURE		},
 	{ HCI_REMOTE_NAME,		handle_remote_name_req,		HCI_REMOTE_NAME_SIGNATURE		},
 	{ HCI_CONNECTIONS,		handle_display_conn_req,	HCI_CONNECTIONS_SIGNATURE		},
@@ -1312,9 +1314,10 @@
 	periodic_inquiry_cp inq_param;
 	DBusMessage *reply = NULL;
 	struct hci_dbus_data *dbus_data = data;
-	uint8_t length;
+	uint8_t length, num_rsp = 0;
 	uint16_t max_period;
 	uint16_t min_period;
+	uint32_t lap = 0x9e8b33;
 	int dd = -1;
 
 	dd = hci_open_dev(dbus_data->dev_id);
@@ -1324,29 +1327,38 @@
 		goto failed;
 	}
 
-	dbus_message_get_args(msg, NULL,
-			DBUS_TYPE_BYTE, &length,
-			DBUS_TYPE_UINT16, &min_period,
-			DBUS_TYPE_UINT16, &max_period,
-			DBUS_TYPE_INVALID);
-
-	syslog(LOG_DEBUG, "%02X %04X %04X", length, min_period, max_period);
-
-	if (length >= min_period || min_period >= max_period) {
+	if (dbus_message_has_signature(msg, HCI_PERIODIC_INQ_EXT_SIGNATURE))
+		dbus_message_get_args(msg, NULL,
+				DBUS_TYPE_BYTE, &length,
+				DBUS_TYPE_UINT16, &min_period,
+				DBUS_TYPE_UINT16, &max_period,
+				DBUS_TYPE_BYTE, &num_rsp,
+				DBUS_TYPE_UINT32, &lap,
+				DBUS_TYPE_INVALID);
+	else
+		dbus_message_get_args(msg, NULL,
+				DBUS_TYPE_BYTE, &length,
+				DBUS_TYPE_UINT16, &min_period,
+				DBUS_TYPE_UINT16, &max_period,
+				DBUS_TYPE_INVALID);
+
+	/* Check for valid parameters */
+	if (length >= min_period || min_period >= max_period
+			|| length < 0x01 || length > 0x30
+			|| lap < 0x9e8b00 || lap > 0x9e8b3f) {
 		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_WRONG_PARAM);
 		goto failed;
 	}
 
-	inq_param.num_rsp = 100;
+	inq_param.num_rsp = num_rsp;
 	inq_param.length  = length;
 
 	inq_param.max_period = htobs(max_period);
 	inq_param.min_period = htobs(min_period);
 
-	/* General/Unlimited Inquiry Access Code (GIAC) */
-	inq_param.lap[0] = 0x33;
-	inq_param.lap[1] = 0x8b;
-	inq_param.lap[2] = 0x9e;
+	inq_param.lap[0] = (lap & 0xff);
+	inq_param.lap[1] = (lap >> 8) & 0xff;
+	inq_param.lap[2] = (lap >> 16) & 0xff;
 
 	inq_mode.mode = 1; //INQUIRY_WITH_RSSI;
 
@@ -1409,16 +1421,21 @@
 	struct hci_request rq;
 	struct hci_dbus_data *dbus_data = data;
 	int dd = -1;
-	uint8_t length, num_rsp;
+	uint8_t length = 8, num_rsp = 0;
+	uint32_t lap = 0x9e8b33;
 
-	dbus_message_get_args(msg, NULL,
-					DBUS_TYPE_BYTE, &length,
-					DBUS_TYPE_BYTE, &num_rsp,
-					DBUS_TYPE_INVALID);
-
-	if (length < 0x01 || length > 0x30) {
-		reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_WRONG_PARAM);
-		goto failed;
+	if (dbus_message_has_signature(msg, HCI_INQ_EXT_SIGNATURE)) {
+		dbus_message_get_args(msg, NULL,
+				DBUS_TYPE_BYTE, &length,
+				DBUS_TYPE_BYTE, &num_rsp,
+				DBUS_TYPE_UINT32, &lap,
+				DBUS_TYPE_INVALID);
+
+		if (length < 0x01 || length > 0x30
+				|| lap < 0x9e8b00 || lap > 0x9e8b3f) {
+			reply = bluez_new_failure_msg(msg, BLUEZ_EDBUS_WRONG_PARAM);
+			goto failed;
+		}
 	}
 
 	dd = hci_open_dev(dbus_data->dev_id);
@@ -1429,9 +1446,9 @@
 	}
 
 	memset(&cp, 0, sizeof(cp));
-	cp.lap[0]  = 0x33;
-	cp.lap[1]  = 0x8b;
-	cp.lap[2]  = 0x9e;
+	cp.lap[0]  = (lap & 0xff);
+	cp.lap[1]  = (lap >> 8) & 0xff;
+	cp.lap[2]  = (lap >> 16) & 0xff;
 	cp.length  = length;
 	cp.num_rsp = num_rsp;
 
Index: hcid/dbus.h
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.h,v
retrieving revision 1.15
diff -u -r1.15 dbus.h
--- hcid/dbus.h	6 Nov 2005 21:24:05 -0000	1.15
+++ hcid/dbus.h	8 Nov 2005 13:05:31 -0000
@@ -164,6 +164,12 @@
 #define DEV_GET_PROPERTY_SIGNATURE		DBUS_TYPE_STRING_AS_STRING \
 						__END_SIG__
 
+#define HCI_PERIODIC_INQ_EXT_SIGNATURE			DBUS_TYPE_BYTE_AS_STRING \
+							DBUS_TYPE_UINT16_AS_STRING \
+							DBUS_TYPE_UINT16_AS_STRING \
+							DBUS_TYPE_BYTE_AS_STRING \
+							DBUS_TYPE_UINT32_AS_STRING \
+							__END_SIG__
 
 #define HCI_PERIODIC_INQ_SIGNATURE			DBUS_TYPE_BYTE_AS_STRING \
 							DBUS_TYPE_UINT16_AS_STRING \
@@ -172,8 +178,11 @@
 
 #define HCI_CANCEL_PERIODIC_INQ_SIGNATURE		__END_SIG__
 
-#define HCI_INQ_SIGNATURE				DBUS_TYPE_BYTE_AS_STRING \
+#define HCI_INQ_SIGNATURE				__END_SIG__
+
+#define HCI_INQ_EXT_SIGNATURE				DBUS_TYPE_BYTE_AS_STRING \
 							DBUS_TYPE_BYTE_AS_STRING \
+							DBUS_TYPE_UINT32_AS_STRING \
 							__END_SIG__
 
 #define HCI_CANCEL_INQ_SIGNATURE			__END_SIG__

--VS++wcV0S1rZb1Fb--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
