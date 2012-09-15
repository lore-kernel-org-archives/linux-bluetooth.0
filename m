Return-Path: <cyrus@holtmann.org>
Message-ID: <50549F3C.8050406@butterbrot.org>
Date: Sat, 15 Sep 2012 17:31:08 +0200
From: Florian Echtler <floe@butterbrot.org>
MIME-Version: 1.0
To: David Herrmann <dh.herrmann@googlemail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Wii Balance Board vs. bluez
References: <5050F5A9.5090401@butterbrot.org> <CANq1E4RYuVy2b1GD2E4MsErbkGZgD6gnDaYeDmyWyYnKaze0Jg@mail.gmail.com> <ed6fbaf1-1410-4539-a36e-1d6d6f6220b5@email.android.com> <CANq1E4RmacRAkTVtRt2JH_+V=qn1AH3iJWZZS_LCqmj_yt4DoQ@mail.gmail.com> <CANq1E4S70tqhTG7PTMj5cHp45NLO9g4n1eLVaHJMuDZx1KMYjg@mail.gmail.com> <5052519F.30803@butterbrot.org> <CANq1E4TRWGTdpiXsrR3uUp+n1jtptRnSaOp++LBKqyiRM0=eGg@mail.gmail.com>
In-Reply-To: <CANq1E4TRWGTdpiXsrR3uUp+n1jtptRnSaOp++LBKqyiRM0=eGg@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------090602020208080509060408"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------090602020208080509060408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello David,

On 14.09.2012 11:02, David Herrmann wrote:
> On Thu, Sep 13, 2012 at 2:35 PM, Florian Echtler <floe@butterbrot.org> wrote:
>> I've attached an additional patch on top of yours to also read the
>> calibration data (24 bytes at address 0xa40024). Calibration data is applied
>> in handler_balance_board, resulting values are in units of 10 grams.
>> Although this looks correct to me, I'm not getting any events with my patch
>> applied - I suspect some connection to the min/max input values. Do you have
>> any ideas what's wrong?
> Ah, yeah I forgot to change the min/max values of ABS_HAT**. I will
> fix that. The calibration data looks also nice. I have no idea what
> went wrong, but you should definitely initialize it to some sane value
> and fallback to this if you cannot read the data from the device. I
> would also like to split this into two patches. The first one without
> calibration and the second one applies the calibration data.
> I will try to resend these this afternoon, otherwise, I will not have
> time until Sunday afternoon. Sorry.
never mind - I tested my patch again and noticed that the driver wasn't 
able to read all 24 calibration bytes in one go, which was the root 
cause for not getting any data (I am simply disabling the extension when 
not getting proper calibration data).

I fixed this by doing two reads of 12 bytes each instead. I've also 
fixed some signedness issues with the data calculation - I've attached 
the updated version, which I think should now be ready for integration.

Can you submit both patches to the list when you get around to it (and 
have tested it yourself)?

Many thanks!
Florian
-- 
SENT FROM MY DEC VT50 TERMINAL

--------------090602020208080509060408
Content-Type: text/x-patch;
 name="balance_calibration_v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="balance_calibration_v2.patch"

diff -u a/hid-wiimote-ext.c b/hid-wiimote-ext.c
--- a/hid-wiimote-ext.c	2012-09-13 21:04:01.600494774 +0200
+++ b/hid-wiimote-ext.c	2012-09-15 17:21:57.292848979 +0200
@@ -28,6 +28,7 @@
 	bool mp_plugged;
 	bool motionp;
 	__u8 ext_type;
+	__u16 calib[4][3];
 };
 
 enum wiiext_type {
@@ -127,6 +128,7 @@
 static __u8 ext_read(struct wiimote_ext *ext)
 {
 	ssize_t ret;
+	__u8 buf[24], i, j, offs = 0;
 	__u8 rmem[2], wmem;
 	__u8 type = WIIEXT_NONE;
 
@@ -159,6 +161,28 @@
 				 rmem[0], rmem[1]);
 	}
 
+	/* get balance board calibration */
+	if (type == WIIEXT_BALANCE_BOARD) {
+
+		/* retrieve 24 bytes of calibration data */
+		/* read requests > 16 do not work => read in two batches */
+		ret  = wiimote_cmd_read(ext->wdata, 0xa40024   , buf   , 12);
+		ret += wiimote_cmd_read(ext->wdata, 0xa40024+12, buf+12, 12);
+
+		/* failed to read calibration data => disable balance board */
+		if (ret != 24)
+			type = WIIEXT_NONE;
+
+		for ( i = 0; i < 3; i++ ) {
+			for ( j = 0 ; j < 4 ; j++ ) {
+				ext->calib[j][i] = ((__u16)buf[offs]<<8 | (__u16)buf[offs+1]);
+				offs += 2;
+				/* printk("calib[%d][%d] = %d\n",j,i,ext->calib[j][i]); */
+			}
+		}
+
+	}
+
 	wiimote_cmd_release(ext->wdata);
 
 	return type;
@@ -517,7 +541,8 @@
 
 static void handler_balance_board(struct wiimote_ext *ext, const __u8 *payload)
 {
-	__s16 tr, br, tl, bl;
+	__s32 tmp, val[4]; /* tr, br, tl, bl */
+	__u8 i;
 
 	/*   Byte |  8  7  6  5  4  3  2  1  |
 	 *   -----+--------------------------+
@@ -540,19 +565,24 @@
 	 * The balance-board is never reported interleaved with motionp.
 	 */
 
-	tr = payload[0] << 8;
-	tr |= payload[1];
-	br = payload[2] << 8;
-	br |= payload[3];
-	tl = payload[4] << 8;
-	tl |= payload[5];
-	bl = payload[6] << 8;
-	bl |= payload[7];
-
-	input_report_abs(ext->input, ABS_HAT0X, tl);
-	input_report_abs(ext->input, ABS_HAT0Y, tr);
-	input_report_abs(ext->input, ABS_HAT1X, bl);
-	input_report_abs(ext->input, ABS_HAT1Y, br);
+	val[0] = (__u16)payload[0] << 8 | (__u16)payload[1];
+	val[1] = (__u16)payload[2] << 8 | (__u16)payload[3];
+	val[2] = (__u16)payload[4] << 8 | (__u16)payload[5];
+	val[3] = (__u16)payload[6] << 8 | (__u16)payload[7];
+
+	/* apply calibration data */
+	for ( i = 0; i < 4; i++ ) {
+		if (val[i] < ext->calib[i][1])
+			tmp = (1700 * (__s32)(val[i] - ext->calib[i][0])) / (__s32)(ext->calib[i][1] - ext->calib[i][0]);
+		else
+			tmp = (1700 * (__s32)(val[i] - ext->calib[i][1])) / (__s32)(ext->calib[i][2] - ext->calib[i][1]) + 1700;
+		val[i] = tmp;
+	}
+
+	input_report_abs(ext->input, ABS_HAT0X, val[0]);
+	input_report_abs(ext->input, ABS_HAT0Y, val[1]);
+	input_report_abs(ext->input, ABS_HAT1X, val[2]);
+	input_report_abs(ext->input, ABS_HAT1Y, val[3]);
 
 	input_sync(ext->input);
 }

--------------090602020208080509060408--
