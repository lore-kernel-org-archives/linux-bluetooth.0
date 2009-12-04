Return-Path: <cyrus@holtmann.org>
Message-ID: <4B18E581.6070305@novero.com>
Date: Fri, 4 Dec 2009 11:33:37 +0100
From: Bas Vermeulen <Bas.Vermeulen@novero.com>
MIME-Version: 1.0
To: <linux-bluetooth@vger.kernel.org>
Subject: Bug in sbc decoder gstreamer plugin
Content-Type: multipart/mixed;
	boundary="------------060203070506050609080601"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--------------060203070506050609080601
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hello *,

We've run into a problem with the gstreamer sbcdec plugin, where a=20
pipeline would accumulate memory at the rate of data sent into it. This=20
is caused by invalid data in a packet (incomplete or wrong data in the=20
stream), causing sbc_decode to return -2 (sbc_unpack_frame can't find=20
the SBC_SYNCWORD in data[0]).
The sbcdec plugin handles this by putting away the buffer, and trying=20
again when a new buffer comes in. Since the buffer isn't changed (only=20
new data tacked on), sbc_decode will continue to send the -2 response=20
from sbc_unpack_frame function, and the sbcdec plugin will continue to=20
accumulate data into the buffer it is working on.

The fix is to simply drop a buffer when sbc_decode returns -2.

Regards,

Bas Vermeulen
--
novero gmbh | parsevalstr. 7 a | 40468 d=FCsseldorf | germany |=20
amtsgericht d=FCsseldorf | hrb 58283 | umsatzsteueridentifikationsnummer:=
=20
de 814973142 | gesch=E4ftsf=FChrender gesellschafter: razvan olosu

--------------060203070506050609080601
Content-Type: text/plain; name="bluez-gstsbcdec.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="bluez-gstsbcdec.patch"

--- /usr/src/nokia/mms_p2430-mute/mms_p2430/src/plugins/audio/decoder/gstrtpsbc/src/gstsbcdec.c	2009-12-01 11:32:45.000000000 +0100
+++ gstsbcdec.c	2009-12-04 10:06:34.000000000 +0100
@@ -95,7 +95,12 @@
 					GST_BUFFER_DATA(output), codesize,
 					NULL);
 		if (consumed <= 0)
-			break;
+		{
+			if (-2 == consumed)
+				goto done;
+			else 
+				break;
+		}
 
 		/* we will reuse the same caps object */
 		if (dec->outcaps == NULL) {

--------------060203070506050609080601--
