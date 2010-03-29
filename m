Return-Path: <cyrus@holtmann.org>
Message-ID: <4BB1048D.3070806@aircable.net>
Date: Mon, 29 Mar 2010 16:50:37 -0300
From: Manuel Naranjo <manuel@aircable.net>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Allow bccmd psset to get words along with bytes
Content-Type: multipart/mixed;
 boundary="------------050600070007080500020705"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------050600070007080500020705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello guys,

This patch allows bccmd psset input to be compatible with psget output, 
psget returns words not bytes, but when you want to get that back into 
psset it complains. This patch fixes the problem by allowing words to be 
input.

Here's the output that shows it works:

[root@laptop:bluez-4.61]$ tools/bccmd psset -r -s psi 0x0031 0x3714 
0x0100 0x411e 0x7100 0x00f4 0x4410 0x0100 0x4123 0x7100 0x00f8 0x4e11 
0x0100 0x4123 0x6100 0x00fc 0x5d10 0x0100 0x4123 0x5100 0x0000 0x6914 
0x0100 0x4b23 0x4000 0x0004 0x7317 0x0100 0x4123 0x3000 0x000a 0x731c 
0x0100 0x4123 0x2000 0x000e 0x7321 0x0100 0x4123 0x1000 0x0014

[root@laptop:bluez-4.61]$ tools/bccmd psget 0x0031
Radio power table: 0x3714 0x0100 0x411e 0x7100 0x00f4 0x4410 0x0100 
0x4123 0x7100 0x00f8 0x4e11 0x0100 0x4123 0x6100 0x00fc 0x5d10 0x0100 
0x4123 0x5100 0x0000 0x6914 0x0100 0x4b23 0x4000 0x0004 0x7317 0x0100 
0x4123 0x3000 0x000a 0x731c 0x0100 0x4123 0x2000 0x000e 0x7321 0x0100 
0x4123 0x1000 0x0014

Cheers,
Manuel

--------------050600070007080500020705
Content-Type: text/plain;
 name="bccmd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="bccmd.patch"

--- ../bluez-4.59/tools/bccmd.c	2009-02-01 23:30:43.000000000 -0200
+++ tools/bccmd.c	2010-03-29 16:47:04.000000000 -0300
@@ -823,16 +823,32 @@ static int cmd_psset(int transport, int 
 		break;
 
 	default:
-		if (argc != length * 2) {
+		if (argc != length * 2 && argc != length) {
 			errno = EINVAL;
 			return -1;
 		}
 
-		for (i = 0; i < length * 2; i++)
-			if (!strncasecmp(argv[0], "0x", 2))
+		if (argc == length * 2) {
+		    for (i = 0; i < length * 2; i++)
+			if (!strncasecmp(argv[0], "0x", 2)){
 				array[i + 6] = strtol(argv[i] + 2, NULL, 16);
+			}
 			else
 				array[i + 6] = atoi(argv[i]);
+		}
+		else {
+		    for (i = 0; i < length; i++){
+			uint16_t val = 0;
+
+			if (!strncasecmp(argv[0], "0x", 2))
+			    val = strtol(argv[i] + 2, NULL, 16);
+			else
+			    val = atoi(argv[i]);
+
+			array[i*2 + 7] = val % 0x100;
+			array[i*2 + 6] = (val / 0x100);
+		    }
+		}
 		break;
 	}
 

--------------050600070007080500020705--
