Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] SBC Encoder program
From: Christian Hoene <hoene@uni-tuebingen.de>
To: Siarhei Siamashka <siarhei.siamashka@nokia.com>
Cc: "'Marcel Holtmann'" <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
In-Reply-To: <200901051027.57446.siarhei.siamashka@nokia.com>
References: <200812301246.25781.siarhei.siamashka@nokia.com>
	 <000a01c96c1c$a4c86390$ee592ab0$@hoene@gmx.net>
	 <200901051027.57446.siarhei.siamashka@nokia.com>
Content-Type: multipart/mixed; boundary="=-PI297mZx0387p10KzAeN"
Date: Mon, 05 Jan 2009 12:43:03 +0100
Message-Id: <1231155783.9401.1.camel@hoene-desktop>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


--=-PI297mZx0387p10KzAeN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> I wonder if we need to do something about test 08?

Yes, there was a bug in the encoder program. Attached the patch.

Greetings
 Christian


--=-PI297mZx0387p10KzAeN
Content-Disposition: attachment; filename*0=0003-Bug-fix-in-SBC-encoder-program-to-correctly-handle-f.pat; filename*1=ch
Content-Type: application/mbox; name=0003-Bug-fix-in-SBC-encoder-program-to-correctly-handle-f.patch
Content-Transfer-Encoding: 7bit

>From e302dcac067486b83d1ba824227fd14878321cb2 Mon Sep 17 00:00:00 2001
From: Christian Hoene <hoene@ieee.org>
Date: Mon, 5 Jan 2009 12:38:52 +0100
Subject: [PATCH 3/3] Bug fix in SBC encoder program to correctly handle file sizes.

---
 sbc/sbcenc.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sbc/sbcenc.c b/sbc/sbcenc.c
index 180c348..9a3df3f 100644
--- a/sbc/sbcenc.c
+++ b/sbc/sbcenc.c
@@ -47,7 +47,7 @@ static ssize_t __read(int fd, void *buf, size_t count)
 	while (count > 0) {
 		len = read(fd, buf + pos, count);
 		if (len <= 0)
-			return len;
+			return pos>len?pos:len;
 
 		count -= len;
 		pos   += len;
@@ -188,6 +188,8 @@ static void encode(char *filename, int subbands, int bitpool, int joint,
 
 		len = sbc_encode(&sbc, input, size,
 					output, sizeof(output), &encoded);
+		if (len <= 0)
+			break;
 		if (len < size)
 			memmove(input, input + len, size - len);
 
-- 
1.6.1.rc2


--=-PI297mZx0387p10KzAeN--
