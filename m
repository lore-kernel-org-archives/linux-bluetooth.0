Return-Path: <maxtram95@gmail.com>
From: maxtram95@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Maxim Mikityanskiy <maxtram95@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH] sbc: don't try to initialize sbc parameters if no data was decoded
Date: Mon, 14 Dec 2015 19:27:41 +0200
Message-Id: <1450114061-19629-1-git-send-email-maxtram95@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Maxim Mikityanskiy <maxtram95@gmail.com>

If the first data chunk passed to sbc_decode was not long enough and
didn't contain full SBC packet, don't try to initialize codec parameters
with random values.

Signed-off-by: Maxim Mikityanskiy <maxtram95@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
---
The patch is for SBC library located at https://git.kernel.org/cgit/bluetooth/sbc.git/

 sbc/sbc.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 606f11c..7da476b 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -1222,22 +1222,24 @@ SBC_EXPORT ssize_t sbc_decode(sbc_t *sbc, const void *input, size_t input_len,
 
 	framelen = priv->unpack_frame(input, &priv->frame, input_len);
 
-	if (!priv->init) {
-		sbc_decoder_init(&priv->dec_state, &priv->frame);
-		priv->init = true;
-
-		sbc->frequency = priv->frame.frequency;
-		sbc->mode = priv->frame.mode;
-		sbc->subbands = priv->frame.subband_mode;
-		sbc->blocks = priv->frame.block_mode;
-		sbc->allocation = priv->frame.allocation;
-		sbc->bitpool = priv->frame.bitpool;
-
-		priv->frame.codesize = sbc_get_codesize(sbc);
-		priv->frame.length = framelen;
-	} else if (priv->frame.bitpool != sbc->bitpool) {
-		priv->frame.length = framelen;
-		sbc->bitpool = priv->frame.bitpool;
+	if (framelen >= 0) {
+		if (!priv->init) {
+			sbc_decoder_init(&priv->dec_state, &priv->frame);
+			priv->init = true;
+
+			sbc->frequency = priv->frame.frequency;
+			sbc->mode = priv->frame.mode;
+			sbc->subbands = priv->frame.subband_mode;
+			sbc->blocks = priv->frame.block_mode;
+			sbc->allocation = priv->frame.allocation;
+			sbc->bitpool = priv->frame.bitpool;
+
+			priv->frame.codesize = sbc_get_codesize(sbc);
+			priv->frame.length = framelen;
+		} else if (priv->frame.bitpool != sbc->bitpool) {
+			priv->frame.length = framelen;
+			sbc->bitpool = priv->frame.bitpool;
+		}
 	}
 
 	if (!output)
-- 
2.5.4 (Apple Git-61)
