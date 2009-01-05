Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] SBC Encoder program
From: Christian Hoene <hoene@uni-tuebingen.de>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Siarhei Siamashka <siarhei.siamashka@nokia.com>,
        Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
In-Reply-To: <2d5a2c100901050422hcf69bcak8e717356e1f8dbf9@mail.gmail.com>
References: <200812301246.25781.siarhei.siamashka@nokia.com>
	 <200901051027.57446.siarhei.siamashka@nokia.com>
	 <1231155783.9401.1.camel@hoene-desktop>
	 <2d5a2c100901050422hcf69bcak8e717356e1f8dbf9@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-+qUGmsCOy2V6KSCLHOIh"
Date: Mon, 05 Jan 2009 13:28:36 +0100
Message-Id: <1231158516.9401.3.camel@hoene-desktop>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


--=-+qUGmsCOy2V6KSCLHOIh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2009-01-05 at 09:22 -0300, Luiz Augusto von Dentz wrote:
> Hi Christian
> 
> > Yes, there was a bug in the encoder program. Attached the patch.
> >
> > Greetings
> >  Christian
> >
> >
> 
> Coding style:
> 
> return pos > len ? pos : len;

Thanks. I corrected it and even found another bug.

Attached the new and corrected patch.

Greetings
 Christian


--=-+qUGmsCOy2V6KSCLHOIh
Content-Disposition: attachment; filename*0=0003-Fixed-correct-handling-of-frame-sizes-in-the-encoder.pat; filename*1=ch
Content-Type: application/mbox; name=0003-Fixed-correct-handling-of-frame-sizes-in-the-encoder.patch
Content-Transfer-Encoding: 7bit

>From 9a914d4b282f4c885ff074263c4da03e482fd99d Mon Sep 17 00:00:00 2001
From: Christian Hoene <hoene@ieee.org>
Date: Mon, 5 Jan 2009 13:26:08 +0100
Subject: [PATCH 3/3] Fixed correct handling of frame sizes in the encoder

---
 sbc/sbc.c    |    6 +++---
 sbc/sbc.h    |    2 +-
 sbc/sbcenc.c |    4 +++-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index ce52e1e..959510f 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -69,7 +69,7 @@ struct sbc_frame {
 	uint8_t subband_mode;
 	uint8_t subbands;
 	uint8_t bitpool;
-	uint8_t codesize;
+	uint16_t codesize;
 	uint8_t length;
 
 	/* bit number x set means joint stereo has been used in subband x */
@@ -1293,9 +1293,9 @@ int sbc_get_frame_duration(sbc_t *sbc)
 	return (1000000 * blocks * subbands) / frequency;
 }
 
-int sbc_get_codesize(sbc_t *sbc)
+uint16_t sbc_get_codesize(sbc_t *sbc)
 {
-	uint8_t subbands, channels, blocks;
+	uint16_t subbands, channels, blocks;
 	struct sbc_priv *priv;
 
 	priv = sbc->priv;
diff --git a/sbc/sbc.h b/sbc/sbc.h
index ab47e32..73f3058 100644
--- a/sbc/sbc.h
+++ b/sbc/sbc.h
@@ -87,7 +87,7 @@ int sbc_encode(sbc_t *sbc, void *input, int input_len, void *output,
 		int output_len, int *written);
 int sbc_get_frame_length(sbc_t *sbc);
 int sbc_get_frame_duration(sbc_t *sbc);
-int sbc_get_codesize(sbc_t *sbc);
+uint16_t sbc_get_codesize(sbc_t *sbc);
 void sbc_finish(sbc_t *sbc);
 
 #ifdef __cplusplus
diff --git a/sbc/sbcenc.c b/sbc/sbcenc.c
index 180c348..124a9e2 100644
--- a/sbc/sbcenc.c
+++ b/sbc/sbcenc.c
@@ -47,7 +47,7 @@ static ssize_t __read(int fd, void *buf, size_t count)
 	while (count > 0) {
 		len = read(fd, buf + pos, count);
 		if (len <= 0)
-			return len;
+			return pos > len ? pos : len;
 
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


--=-+qUGmsCOy2V6KSCLHOIh--
