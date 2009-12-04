Return-Path: <cyrus@holtmann.org>
Message-ID: <4B18F26A.2080501@novero.com>
Date: Fri, 4 Dec 2009 12:28:42 +0100
From: Bas Vermeulen <Bas.Vermeulen@novero.com>
MIME-Version: 1.0
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Re: Bug in sbc decoder gstreamer plugin
References: <4B18E581.6070305@novero.com>
In-Reply-To: <4B18E581.6070305@novero.com>
Content-Type: multipart/mixed;
	boundary="------------050607010500030705000005"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--------------050607010500030705000005
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable

Bas Vermeulen wrote:
> We've run into a problem with the gstreamer sbcdec plugin, where a=20
> pipeline would accumulate memory at the rate of data sent into it. This=
=20
> is caused by invalid data in a packet (incomplete or wrong data in the=20
> stream), causing sbc_decode to return -2 (sbc_unpack_frame can't find=20
> the SBC_SYNCWORD in data[0]).
> The sbcdec plugin handles this by putting away the buffer, and trying=20
> again when a new buffer comes in. Since the buffer isn't changed (only=20
> new data tacked on), sbc_decode will continue to send the -2 response=20
> from sbc_unpack_frame function, and the sbcdec plugin will continue to=20
> accumulate data into the buffer it is working on.
>
> The fix is to simply drop a buffer when sbc_decode returns -2.
>  =20
I just realised this doesn't do enough, as sbc_decode can return=20
negative values in the range of -1 to -4 (-1 being need more data, the=20
rest being can't handle this frame for various reasons).

I've included a new version of the patch, which handles a -1 return=20
value by keeping the buffer for the next decode, and the other values by=20
dropping the buffer. This should also fix similar errors in case we get=20
a bad CRC or a faulty packet.

Regards,

Bas Vermeulen

--
novero gmbh | parsevalstr. 7 a | 40468 d=FCsseldorf | germany |=20
amtsgericht d=FCsseldorf | hrb 58283 | umsatzsteueridentifikationsnummer:=
=20
de 814973142 | gesch=E4ftsf=FChrender gesellschafter: razvan olosu


--------------050607010500030705000005
Content-Type: text/plain; name="bluez-gstsbcdec-try2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="bluez-gstsbcdec-try2.patch"

--- /usr/src/nokia/mms_p2430-mute/mms_p2430/src/plugins/audio/decoder/gstrtpsbc/src/gstsbcdec.c	2009-12-01 11:32:45.000000000 +0100
+++ gstsbcdec.c	2009-12-04 12:23:04.000000000 +0100
@@ -95,7 +95,18 @@
 					GST_BUFFER_DATA(output), codesize,
 					NULL);
 		if (consumed <= 0)
-			break;
+		{
+			/*
+			 * sbc_decode returns -1 when not enough data is available to process.
+			 * If that is the case, we need to tack on another buffer.
+			 * In case of other errors (crc failure, SBC_SYNCWORD not found, etc),
+			 * keeping the offending data does no good, as we will keep getting the
+			 * same error over and over. So just free the buffer by jumping to done. 
+			 */
+			if (-1 == consumed)
+				break;
+			goto done;
+		}
 
 		/* we will reuse the same caps object */
 		if (dec->outcaps == NULL) {

--------------050607010500030705000005--
