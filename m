Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Aur=C3=A9lien=20Zanelli?= <aurelien.zanelli@parrot.com>
To: <linux-bluetooth@vger.kernel.org>
CC: =?UTF-8?q?Aur=C3=A9lien=20Zanelli?= <aurelien.zanelli@parrot.com>
Subject: [PATCH 1/2] sbc: fix frame length calculation for DUAL_CHANNEL mode
Date: Thu, 23 Oct 2014 16:32:20 +0200
Message-ID: <1414074741-20286-2-git-send-email-aurelien.zanelli@parrot.com>
In-Reply-To: <1414074741-20286-1-git-send-email-aurelien.zanelli@parrot.com>
References: <1414074741-20286-1-git-send-email-aurelien.zanelli@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to A2DP specification, section 12.9, for DUAL_CHANNEL mode, we
shall use the same formula as for MONO mode.
---
 sbc/sbc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 534027e..e830388 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -1402,7 +1402,7 @@ SBC_EXPORT size_t sbc_get_frame_length(sbc_t *sbc)
 
 	ret = 4 + (4 * subbands * channels) / 8;
 	/* This term is not always evenly divide so we round it up */
-	if (channels == 1)
+	if (channels == 1 || sbc->mode == SBC_MODE_DUAL_CHANNEL)
 		ret += ((blocks * channels * bitpool) + 7) / 8;
 	else
 		ret += (((joint ? subbands : 0) + blocks * bitpool) + 7) / 8;
-- 
1.7.10.4

