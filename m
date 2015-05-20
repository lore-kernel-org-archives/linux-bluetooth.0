Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/3] emulator: Move Host Buffer Size Command handling block
Date: Wed, 20 May 2015 19:10:44 +0200
Message-Id: <1432141845-9207-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1432141845-9207-1-git-send-email-szymon.janc@tieto.com>
References: <1432141845-9207-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Commands codes in switch-case are kept in ascending order.
---
 emulator/btdev.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index a2a2e50..d47d50e 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -2386,11 +2386,6 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		cmd_complete(btdev, opcode, &status, sizeof(status));
 		break;
 
-	case BT_HCI_CMD_HOST_BUFFER_SIZE:
-		status = BT_HCI_ERR_SUCCESS;
-		cmd_complete(btdev, opcode, &status, sizeof(status));
-		break;
-
 	case BT_HCI_CMD_SET_HOST_FLOW_CONTROL:
 		shfc = data;
 		if (shfc->enable > 0x03) {
@@ -2402,6 +2397,11 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		cmd_complete(btdev, opcode, &status, sizeof(status));
 		break;
 
+	case BT_HCI_CMD_HOST_BUFFER_SIZE:
+		status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+
 	case BT_HCI_CMD_READ_NUM_SUPPORTED_IAC:
 		if (btdev->type == BTDEV_TYPE_LE)
 			goto unsupported;
-- 
1.9.3

