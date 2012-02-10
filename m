Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 21/22] hciconfig: Fix compiler warnings related to unaligned memory access
Date: Fri, 10 Feb 2012 18:40:06 -0300
Message-Id: <1328910007-25604-22-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/hciconfig.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index 5d01bd9..f1458b9 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -1305,7 +1305,7 @@ static void cmd_inq_data(int ctl, int hdev, char *opt)
 				printf("\t%s service classes:",
 					type == 0x02 ? "Shortened" : "Complete");
 				for (i = 0; i < (len - 1) / 2; i++) {
-					uint16_t val = btohs(bt_get_unaligned((uint16_t *) (ptr + (i * 2))));
+					uint16_t val = bt_get_le16((ptr + (i * 2)));
 					printf(" 0x%4.4x", val);
 				}
 				printf("\n");
-- 
1.7.8.1

