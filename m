Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] monitor/avctp: Print <empty> if folder lenght is 0
Date: Fri, 22 Jan 2016 17:14:27 +0200
Message-Id: <1453475668-4609-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1453475668-4609-1-git-send-email-luiz.dentz@gmail.com>
References: <1453475668-4609-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is a bit more clear that is was not a parsing error but just that
there is nothing to print:

> ACL Data RX: Handle 256 flags 0x02 dlen 39
      Channel: 68 len 35 ctrl 0x0304 [PSM 27 mode 3] {chan 4}
      I-frame: Unsegmented TxSeq 2 ReqSeq 3
      AVCTP Browsing: Response: type 0x00 label 2 PID 0x110e
        AVRCP: SetBrowsedPlayer: len 0x0019
          Status: 0x04 (Success)
          UIDCounter: 0x0000 (0)
          Number of Items: 0x00000002 (2)
          CharsetID: 0x006a (UTF-8)
          Folder Depth: 0x01 (1)
          Folder: <empty>
---
 monitor/avctp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index a024a0f..81e9166 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -2430,7 +2430,12 @@ response:
 		if (!l2cap_frame_get_u8(frame, &len))
 			return false;
 
-		printf("Folder: ");
+		if (!len) {
+			print_field("%*cFolder: <empty>", indent, ' ');
+			continue;
+		}
+
+		printf("%*cFolder: ", indent+8, ' ');
 		for (; len > 0; len--) {
 			uint8_t c;
 
-- 
2.5.0

