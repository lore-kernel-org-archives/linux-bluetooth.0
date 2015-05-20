Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/3] emulator: Handle Host Number Of Completed Packets Command
Date: Wed, 20 May 2015 19:10:45 +0200
Message-Id: <1432141845-9207-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1432141845-9207-1-git-send-email-szymon.janc@tieto.com>
References: <1432141845-9207-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Host_Number_Of_Completed_Packets command is a special command in
the sense that no event is normally generated after the command
has completed.
---
 emulator/btdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index d47d50e..af93933 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -2402,6 +2402,12 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		cmd_complete(btdev, opcode, &status, sizeof(status));
 		break;
 
+	case BT_HCI_CMD_HOST_NUM_COMPLETED_PACKETS:
+		/* This command is special in the sense that no event is
+		 * normally generated after the command has completed.
+		 */
+		break;
+
 	case BT_HCI_CMD_READ_NUM_SUPPORTED_IAC:
 		if (btdev->type == BTDEV_TYPE_LE)
 			goto unsupported;
-- 
1.9.3

