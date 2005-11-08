Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedberg <johan.hedberg@nokia.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] [PATCH] Variable arguments to Inquiry and PeriodicInquiry D-BUS methods
Message-ID: <20051108143016.GA7919@localhost.localdomain>
References: <20051108134311.GA7150@localhost.localdomain> <1131458070.5824.181.camel@blade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
In-Reply-To: <1131458070.5824.181.camel@blade>
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
Date: Tue, 8 Nov 2005 16:30:16 +0200


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Marcel,

Attached is a new patch with some of your proposed changes (the ones I
agree with ;)

On Tue, Nov 08, 2005, Marcel Holtmann wrote:
> > The possible ways of calling the methods after applying this patch are:
> > 
> > Inquiry()
> > Inquiry(byte: length, byte: num_rsp, uint32: lap)
> > PeriodicInquiry(byte: length, uint16: min_period, uint16: max_period)
> > PeriodicInquiry(byte: length, uint16: min_period, uint16: max_period,
> > 		byte: num_rsp, uint32: lap)
> 
> please swap the lap and num_rsp (call it num_responses btw.) and make
> the num_responses also optional. It is more usual that you will specify
> a different lap instead of num_responses. The reason for this is,
> because the num_responses value is not really useful anymore. All chips
> in inquiry mode 1 or 2 tend to send results multiple times and this
> makes the num_responses value useless. It is only good for devices where
> the memory storage for inquiry results is limited. Maybe we shouldn't
> use it at all.

I removed the num_responses parameter alltogether. If it's needed we can
always allow changing it through the default settings interface in the
future.

> Is it not better to call it access_code instead of lap?

Maybe. I called it lap since that's what your structs in hci.h and the
HCI spec calls it. Note that the terms we use in the code don't have to
the same what we put in the (yet to be created) public documentation of
the interface.

> The length parameter should also be in seconds and not the slot timing
> we get from the baseband.

Well, then it would always have to be rounded to the nearest 1.28 sec
multiple, so I'm not so sure how useful it would be (and it might be
even confusing for the user when the inquiry doesn't last the exact
amount of seconds that was given). I've left it unchanged for now. I can
send a new patch later specifically for it. If we do change it, should
it be an integer or a floating point number?

Johan

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="inq-params2.patch"

Index: hcid/dbus-test
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus-test,v
retrieving revision 1.3
diff -u -r1.3 dbus-test
--- hcid/dbus-test	6 Nov 2005 21:24:05 -0000	1.3
+++ hcid/dbus-test	8 Nov 2005 14:24:16 -0000
@@ -182,12 +182,12 @@
 
         # Device.Controller methods
         elif self.cmd == 'Inquiry':
-            if len(self.cmd_args) != 2:
-                length, maxrsp = (10, 100)
-            else:
-                length, maxrsp = self.cmd_args
             try:
-                self.ctl.Inquiry(dbus.Byte(length), dbus.Byte(maxrsp))
+                if len(self.cmd_args) != 2:
+                    self.ctl.Inquiry()
+                else:
+                    length, lap = self.cmd_args
+                    self.ctl.Inquiry(dbus.Byte(length), dbus.UInt32(long(lap, 0)))
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
+                    length, min, max, lap = self.cmd_args
+                    self.ctl.PeriodicInquiry(dbus.Byte(length), dbus.UInt16(min), dbus.UInt16(max),
+                            dbus.UInt32(long(lap, 0)))
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
+++ hcid/dbus.c	8 Nov 2005 14:24:17 -0000
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
+	uint8_t length, num_responses = 0;
 	uint16_t max_period;
 	uint16_t min_period;
+	uint32_t lap = 0x9e8b33;
 	int dd = -1;
 
 	dd = hci_open_dev(dbus_data->dev_id);
@@ -1324,29 +1327,37 @@
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
+	inq_param.num_rsp = num_responses;
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
 
@@ -1409,16 +1420,20 @@
 	struct hci_request rq;
 	struct hci_dbus_data *dbus_data = data;
 	int dd = -1;
-	uint8_t length, num_rsp;
+	uint8_t length = 8, num_responses = 0;
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
@@ -1429,11 +1444,11 @@
 	}
 
 	memset(&cp, 0, sizeof(cp));
-	cp.lap[0]  = 0x33;
-	cp.lap[1]  = 0x8b;
-	cp.lap[2]  = 0x9e;
+	cp.lap[0]  = (lap & 0xff);
+	cp.lap[1]  = (lap >> 8) & 0xff;
+	cp.lap[2]  = (lap >> 16) & 0xff;
 	cp.length  = length;
-	cp.num_rsp = num_rsp;
+	cp.num_rsp = num_responses;
 
 	memset(&rq, 0, sizeof(rq));
 	rq.ogf    = OGF_LINK_CTL;
Index: hcid/dbus.h
===================================================================
RCS file: /cvsroot/bluez/utils/hcid/dbus.h,v
retrieving revision 1.15
diff -u -r1.15 dbus.h
--- hcid/dbus.h	6 Nov 2005 21:24:05 -0000	1.15
+++ hcid/dbus.h	8 Nov 2005 14:24:18 -0000
@@ -164,6 +164,11 @@
 #define DEV_GET_PROPERTY_SIGNATURE		DBUS_TYPE_STRING_AS_STRING \
 						__END_SIG__
 
+#define HCI_PERIODIC_INQ_EXT_SIGNATURE			DBUS_TYPE_BYTE_AS_STRING \
+							DBUS_TYPE_UINT16_AS_STRING \
+							DBUS_TYPE_UINT16_AS_STRING \
+							DBUS_TYPE_UINT32_AS_STRING \
+							__END_SIG__
 
 #define HCI_PERIODIC_INQ_SIGNATURE			DBUS_TYPE_BYTE_AS_STRING \
 							DBUS_TYPE_UINT16_AS_STRING \
@@ -172,8 +177,10 @@
 
 #define HCI_CANCEL_PERIODIC_INQ_SIGNATURE		__END_SIG__
 
-#define HCI_INQ_SIGNATURE				DBUS_TYPE_BYTE_AS_STRING \
-							DBUS_TYPE_BYTE_AS_STRING \
+#define HCI_INQ_SIGNATURE				__END_SIG__
+
+#define HCI_INQ_EXT_SIGNATURE				DBUS_TYPE_BYTE_AS_STRING \
+							DBUS_TYPE_UINT32_AS_STRING \
 							__END_SIG__
 
 #define HCI_CANCEL_INQ_SIGNATURE			__END_SIG__

--7AUc2qLy4jB3hD7Z--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
