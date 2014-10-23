Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Aur=C3=A9lien=20Zanelli?= <aurelien.zanelli@parrot.com>
To: <linux-bluetooth@vger.kernel.org>
CC: =?UTF-8?q?Aur=C3=A9lien=20Zanelli?= <aurelien.zanelli@parrot.com>
Subject: [PATCH 2/2] sbc: use an uint16 to store frame length in internal frame structure
Date: Thu, 23 Oct 2014 16:32:21 +0200
Message-ID: <1414074741-20286-3-git-send-email-aurelien.zanelli@parrot.com>
In-Reply-To: <1414074741-20286-1-git-send-email-aurelien.zanelli@parrot.com>
References: <1414074741-20286-1-git-send-email-aurelien.zanelli@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Otherwise it could overflow in some cases.
For instance in DUAL_CHANNEL mode, with subbands set to SBC_SB_8, blocks
set to SBC_BLK_16 and bitpool set to 64 results in a frame length of 268.
---
 sbc/sbc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index e830388..606f11c 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -119,7 +119,7 @@ struct sbc_frame {
 	uint8_t subbands;
 	uint8_t bitpool;
 	uint16_t codesize;
-	uint8_t length;
+	uint16_t length;
 
 	/* bit number x set means joint stereo has been used in subband x */
 	uint8_t joint;
-- 
1.7.10.4

