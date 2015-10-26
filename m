Return-Path: <cyrus@holtmann.org>
From: Kunio AKASHI <k_akashi@jaist.ac.jp>
To: linux-bluetooth@vger.kernel.org
Cc: Kunio AKASHI <k_akashi@jaist.ac.jp>
Subject: [PATCH] tools/hciconfig: Fix hci_close_dev
Date: Tue, 27 Oct 2015 07:52:10 +0900
Message-Id: <1445899930-28915-1-git-send-email-k_akashi@jaist.ac.jp>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It had been closed different file descriptor.
When has two or more interfaces, hciconfig -a exit after cmd_class function.

Signed-off-by: Kunio AKASHI <k_akashi@jaist.ac.jp>
---
 tools/hciconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index eac96b0..9029f7d 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -964,7 +964,7 @@ static void cmd_class(int ctl, int hdev, char *opt)
 				get_minor_device_name(cls[1] & 0x1f, cls[0] >> 2));
 	}
 
-	hci_close_dev(hdev);
+	hci_close_dev(s);
 }
 
 static void cmd_voice(int ctl, int hdev, char *opt)
-- 
2.1.0

