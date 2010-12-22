Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] sbc: detect when bitpool has changed
Date: Wed, 22 Dec 2010 10:33:07 +0200
Message-Id: <1293006787-24217-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 sbc/sbc.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index a6391ae..77fcc5d 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -978,6 +978,9 @@ ssize_t sbc_decode(sbc_t *sbc, const void *input, size_t input_len,
 
 		priv->frame.codesize = sbc_get_codesize(sbc);
 		priv->frame.length = framelen;
+	} else if (priv->frame.bitpool != sbc->bitpool) {
+		priv->frame.length = framelen;
+		sbc->bitpool = priv->frame.bitpool;
 	}
 
 	if (!output)
@@ -1050,6 +1053,9 @@ ssize_t sbc_encode(sbc_t *sbc, const void *input, size_t input_len,
 
 		sbc_encoder_init(&priv->enc_state, &priv->frame);
 		priv->init = 1;
+	} else if (priv->frame.bitpool != sbc->bitpool) {
+		priv->frame.length = sbc_get_frame_length(sbc);
+		priv->frame.bitpool = sbc->bitpool;
 	}
 
 	/* input must be large enough to encode a complete frame */
@@ -1120,7 +1126,7 @@ size_t sbc_get_frame_length(sbc_t *sbc)
 	struct sbc_priv *priv;
 
 	priv = sbc->priv;
-	if (priv->init)
+	if (priv->init && priv->frame.bitpool == sbc->bitpool)
 		return priv->frame.length;
 
 	subbands = sbc->subbands ? 8 : 4;
-- 
1.7.1

