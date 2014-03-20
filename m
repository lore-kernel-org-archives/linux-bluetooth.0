Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 35/62] unit: Use lower-case for 128-bit UUIDs
Date: Thu, 20 Mar 2014 11:43:00 -0300
Message-Id: <1395326607-27068-36-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to ISO/IEC 9834-8: "It is recommended that the hexadecimal
representation used in all human-readable formats be restricted to
lower-case letters. Software processing this representation is, however,
required to accept both upper and lower case letters as specified in
6.5.2."
---
 unit/test-uuid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/unit/test-uuid.c b/unit/test-uuid.c
index 79ab3e6..225a7b5 100644
--- a/unit/test-uuid.c
+++ b/unit/test-uuid.c
@@ -46,10 +46,10 @@ static unsigned char uuid_base_binary[] = {
 			0x80, 0x00, 0x00, 0x80, 0x5f, 0x9b, 0x34, 0xfb };
 
 static struct uuid_test_data uuid_base = {
-	.str = "00000000-0000-1000-8000-00805F9B34FB",
+	.str = "00000000-0000-1000-8000-00805f9b34fb",
 	.binary = uuid_base_binary,
 	.type = BT_UUID128,
-	.str128 = "00000000-0000-1000-8000-00805F9B34FB",
+	.str128 = "00000000-0000-1000-8000-00805f9b34fb",
 	.binary128 = uuid_base_binary,
 };
 
-- 
1.8.3.1

