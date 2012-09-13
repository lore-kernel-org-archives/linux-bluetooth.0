Return-Path: <cyrus@holtmann.org>
Message-ID: <5052519F.30803@butterbrot.org>
Date: Thu, 13 Sep 2012 23:35:27 +0200
From: Florian Echtler <floe@butterbrot.org>
MIME-Version: 1.0
To: David Herrmann <dh.herrmann@googlemail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Wii Balance Board vs. bluez
References: <5050F5A9.5090401@butterbrot.org> <CANq1E4RYuVy2b1GD2E4MsErbkGZgD6gnDaYeDmyWyYnKaze0Jg@mail.gmail.com> <ed6fbaf1-1410-4539-a36e-1d6d6f6220b5@email.android.com> <CANq1E4RmacRAkTVtRt2JH_+V=qn1AH3iJWZZS_LCqmj_yt4DoQ@mail.gmail.com> <CANq1E4S70tqhTG7PTMj5cHp45NLO9g4n1eLVaHJMuDZx1KMYjg@mail.gmail.com>
In-Reply-To: <CANq1E4S70tqhTG7PTMj5cHp45NLO9g4n1eLVaHJMuDZx1KMYjg@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------070003080007080200010103"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------070003080007080200010103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 13.09.2012 16:39, David Herrmann wrote:
>> Please see the appended patch. You have to apply it to your kernel
>> tree and recompile the hid-wiimote driver. No other sources are
>> changed so you don't need to reboot or install the new kernel. Just
>> install the new hid-wiimote.ko module.
>>
>> One of the 5 input devices should then report the wiimote weight
>> sensor data. (the input device with name "Wii Remote Balance Board").
> Forgot to attach the patch... Here it is.
Awesome - works as expected, weight sensor data can be read from one of 
the event devices.

I've attached an additional patch on top of yours to also read the 
calibration data (24 bytes at address 0xa40024). Calibration data is 
applied in handler_balance_board, resulting values are in units of 10 
grams. Although this looks correct to me, I'm not getting any events 
with my patch applied - I suspect some connection to the min/max input 
values. Do you have any ideas what's wrong?

Florian
-- 
SENT FROM MY DEC VT50 TERMINAL

--------------070003080007080200010103
Content-Type: text/x-patch;
 name="balance_calibration.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="balance_calibration.patch"

diff -u a/hid-wiimote-ext.c b/hid-wiimote-ext.c
--- a/hid-wiimote-ext.c	2012-09-13 21:04:01.600494774 +0200
+++ b/hid-wiimote-ext.c	2012-09-13 23:30:57.416209821 +0200
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
+	__u8 buf[24];
 	__u8 rmem[2], wmem;
 	__u8 type = WIIEXT_NONE;
 
@@ -159,6 +161,29 @@
 				 rmem[0], rmem[1]);
 	}
 
+	/* get balance board calibration */
+	if (type == WIIEXT_BALANCE_BOARD) {
+
+		ret = wiimote_cmd_read(ext->wdata, 0xa40024, buf, 24);
+		if (ret != 24)
+			type = WIIEXT_NONE;
+
+		ext->calib[0][0] = ((__u16)buf[ 0]<<8 | (__u16)buf[ 1]);
+		ext->calib[1][0] = ((__u16)buf[ 2]<<8 | (__u16)buf[ 3]);
+		ext->calib[2][0] = ((__u16)buf[ 4]<<8 | (__u16)buf[ 5]);
+		ext->calib[3][0] = ((__u16)buf[ 6]<<8 | (__u16)buf[ 7]);
+
+		ext->calib[0][1] = ((__u16)buf[ 8]<<8 | (__u16)buf[ 9]);
+		ext->calib[1][1] = ((__u16)buf[10]<<8 | (__u16)buf[11]);
+		ext->calib[2][1] = ((__u16)buf[12]<<8 | (__u16)buf[13]);
+		ext->calib[3][1] = ((__u16)buf[14]<<8 | (__u16)buf[15]);
+
+		ext->calib[0][2] = ((__u16)buf[16]<<8 | (__u16)buf[17]);
+		ext->calib[1][2] = ((__u16)buf[18]<<8 | (__u16)buf[19]);
+		ext->calib[2][2] = ((__u16)buf[20]<<8 | (__u16)buf[21]);
+		ext->calib[3][2] = ((__u16)buf[22]<<8 | (__u16)buf[23]);
+	}
+
 	wiimote_cmd_release(ext->wdata);
 
 	return type;
@@ -517,7 +542,9 @@
 
 static void handler_balance_board(struct wiimote_ext *ext, const __u8 *payload)
 {
-	__s16 tr, br, tl, bl;
+	__s16 val[4]; /*tr, br, tl, bl;*/
+	unsigned long tmp;
+	__u8 i;
 
 	/*   Byte |  8  7  6  5  4  3  2  1  |
 	 *   -----+--------------------------+
@@ -540,19 +567,28 @@
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
+	val[0]  = payload[0] << 8;
+	val[0] |= payload[1];
+	val[1]  = payload[2] << 8;
+	val[1] |= payload[3];
+	val[2]  = payload[4] << 8;
+	val[2] |= payload[5];
+	val[3]  = payload[6] << 8;
+	val[3] |= payload[7];
+
+	/* apply calibration data */
+	for( i = 0; i < 4; i++ ) {
+		if (val[i] < ext->calib[i][1])
+			tmp = 1700 * (val[i] - ext->calib[i][0]) / (ext->calib[i][1] - ext->calib[i][0]);
+		else
+			tmp = 1700 * (val[i] - ext->calib[i][1]) / (ext->calib[i][2] - ext->calib[i][1]) + 1700;
+		val[i] = tmp;
+	}
+
+	input_report_abs(ext->input, ABS_HAT0X, val[0]);
+	input_report_abs(ext->input, ABS_HAT0Y, val[1]);
+	input_report_abs(ext->input, ABS_HAT1X, val[2]);
+	input_report_abs(ext->input, ABS_HAT1Y, val[3]);
 
 	input_sync(ext->input);
 }
@@ -707,10 +743,10 @@
 	set_bit(ABS_HAT2Y, ext->input->absbit);
 	set_bit(ABS_HAT3X, ext->input->absbit);
 	set_bit(ABS_HAT3Y, ext->input->absbit);
-	input_set_abs_params(ext->input, ABS_HAT0X, -120, 120, 2, 4);
-	input_set_abs_params(ext->input, ABS_HAT0Y, -120, 120, 2, 4);
-	input_set_abs_params(ext->input, ABS_HAT1X, -30, 30, 1, 1);
-	input_set_abs_params(ext->input, ABS_HAT1Y, -30, 30, 1, 1);
+	input_set_abs_params(ext->input, ABS_HAT0X, -20000, 20000, 2, 4);
+	input_set_abs_params(ext->input, ABS_HAT0Y, -20000, 20000, 2, 4);
+	input_set_abs_params(ext->input, ABS_HAT1X, -20000, 20000, 1, 1);
+	input_set_abs_params(ext->input, ABS_HAT1Y, -20000, 20000, 1, 1);
 	input_set_abs_params(ext->input, ABS_HAT2X, -30, 30, 1, 1);
 	input_set_abs_params(ext->input, ABS_HAT2Y, -30, 30, 1, 1);
 	input_set_abs_params(ext->input, ABS_HAT3X, -30, 30, 1, 1);

--------------070003080007080200010103--
