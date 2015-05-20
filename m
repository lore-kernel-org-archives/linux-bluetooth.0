Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/3] emulator: Verify Set Controller To Host Flow Control Command
Date: Wed, 20 May 2015 19:10:43 +0200
Message-Id: <1432141845-9207-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Return invalid parameters error if reserved value is used.
---
 emulator/btdev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 2a0c673..a2a2e50 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -2393,8 +2393,12 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 
 	case BT_HCI_CMD_SET_HOST_FLOW_CONTROL:
 		shfc = data;
-		btdev->host_flow_control = shfc->enable;
-		status = BT_HCI_ERR_SUCCESS;
+		if (shfc->enable > 0x03) {
+			status = BT_HCI_ERR_INVALID_PARAMETERS;
+		} else {
+			btdev->host_flow_control = shfc->enable;
+			status = BT_HCI_ERR_SUCCESS;
+		}
 		cmd_complete(btdev, opcode, &status, sizeof(status));
 		break;
 
-- 
1.9.3

