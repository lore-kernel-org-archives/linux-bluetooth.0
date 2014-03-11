Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] emulator/btdev: Add support for LE set scan response command
Date: Tue, 11 Mar 2014 11:09:32 +0100
Message-Id: <1394532573-19278-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1394532573-19278-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1394532573-19278-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for btdev LE set scan response command.
---
 emulator/btdev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index b54f91e..a5a9123 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -2454,6 +2454,13 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		cmd_complete(btdev, opcode, &lte, sizeof(lte));
 		break;
 
+	case BT_HCI_CMD_LE_SET_SCAN_RSP_DATA:
+		if (btdev->type == BTDEV_TYPE_BREDR)
+			goto unsupported;
+		status = BT_HCI_ERR_SUCCESS;
+		cmd_complete(btdev, opcode, &status, sizeof(status));
+		break;
+
 	default:
 		goto unsupported;
 	}
-- 
1.8.5.2

