Return-Path: <cyrus@holtmann.org>
From: marcandre.lureau@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: =?utf-8?q?Marc-Andr=C3=A9=20Lureau?= <marc-andre.lureau@nokia.com>
Subject: [PATCH] sbc: don't dereference sbc pointer if NULL
Date: Tue, 17 Feb 2009 22:46:41 +0200
Message-Id: <1234903601-7124-1-git-send-email-marcandre.lureau@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marc-André Lureau <marc-andre.lureau@nokia.com>

---
 sbc/sbc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index e2e7c61..a33ed57 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -985,7 +985,7 @@ int sbc_decode(sbc_t *sbc, void *input, int input_len, void *output,
 	char *ptr;
 	int i, ch, framelen, samples;
 
-	if (!sbc && !input)
+	if (!sbc || !input)
 		return -EIO;
 
 	priv = sbc->priv;
@@ -1053,7 +1053,7 @@ int sbc_encode(sbc_t *sbc, void *input, int input_len, void *output,
 			const uint8_t *pcm, int16_t X[2][SBC_X_BUFFER_SIZE],
 			int nsamples, int nchannels);
 
-	if (!sbc && !input)
+	if (!sbc || !input)
 		return -EIO;
 
 	priv = sbc->priv;
-- 
1.6.1.224.gb56c

