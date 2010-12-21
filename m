Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] sbc: detect when bitpool has changed
Date: Tue, 21 Dec 2010 18:58:44 +0200
Message-Id: <1292950724-4918-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 sbc/sbc.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index a6391ae..b3a7a09 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -965,7 +965,8 @@ ssize_t sbc_decode(sbc_t *sbc, const void *input, size_t input_len,
 
 	framelen = sbc_unpack_frame(input, &priv->frame, input_len);
 
-	if (!priv->init) {
+	/* init if no previous frame was encode or bitpool has changed */
+	if (!priv->init || priv->frame.bitpool != sbc->bitpool) {
 		sbc_decoder_init(&priv->dec_state, &priv->frame);
 		priv->init = 1;
 
@@ -1035,7 +1036,8 @@ ssize_t sbc_encode(sbc_t *sbc, const void *input, size_t input_len,
 	if (written)
 		*written = 0;
 
-	if (!priv->init) {
+	/* init if no previous frame was encode or bitpool has changed */
+	if (!priv->init || priv->frame.bitpool != sbc->bitpool) {
 		priv->frame.frequency = sbc->frequency;
 		priv->frame.mode = sbc->mode;
 		priv->frame.channels = sbc->mode == SBC_MODE_MONO ? 1 : 2;
@@ -1120,7 +1122,7 @@ size_t sbc_get_frame_length(sbc_t *sbc)
 	struct sbc_priv *priv;
 
 	priv = sbc->priv;
-	if (priv->init)
+	if (priv->init && priv->frame.bitpool == sbc->bitpool)
 		return priv->frame.length;
 
 	subbands = sbc->subbands ? 8 : 4;
-- 
1.7.1

