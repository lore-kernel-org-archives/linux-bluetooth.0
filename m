Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Joshua Kessinger <jkessinger@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Joshua Kessinger <jkessinger@google.com>
Subject: [PATCH 1/1] sbc: Fix stack overflow read in sbc_crc8.
Date: Wed, 21 Feb 2018 11:28:00 -0800
Message-Id: <20180221192800.254383-1-jkessinger@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When encoding or decoding with JOINT_STEREO and 8 subbands the crc_pos is 88
bits. In this case there are no extra bits which need to be added to the CRC,
but there is still a read 1 byte past the end of the crc_header stack variable.

Signed-off-by: Joshua Kessinger <jkessinger@google.com>
---
 sbc/sbc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index 606f11c..7f1efaa 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -190,7 +190,7 @@ static uint8_t sbc_crc8(const uint8_t *data, size_t len)
 	for (i = 0; i < len / 8; i++)
 		crc = crc_table[crc ^ data[i]];
 
-	octet = data[i];
+	octet = len % 8 ? data[i] : 0;
 	for (i = 0; i < len % 8; i++) {
 		char bit = ((octet ^ crc) & 0x80) >> 7;
 
-- 
2.16.1.291.g4437f3f132-goog

