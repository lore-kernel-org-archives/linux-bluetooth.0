Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 5/8] emulator/btdev: Overwrite default feature mask when SPP is toggled
Date: Wed,  3 Sep 2014 11:02:46 +0200
Message-Id: <1409734969-10716-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1409734969-10716-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1409734969-10716-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Without this we cannot test the legacy HID Device reconnection, as L2Cap
connection is refused when SSP is reported in remote device's features.
---
 emulator/btdev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 86fd3d9..8aebb8f 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -2332,6 +2332,13 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 			goto unsupported;
 		wspm = data;
 		btdev->simple_pairing_mode = wspm->mode;
+
+		/* set SSP feature mask */
+		if (wspm->mode)
+			btdev->features[6] |= 0x08;
+		else
+			btdev->features[6] &= ~0x08;
+
 		status = BT_HCI_ERR_SUCCESS;
 		cmd_complete(btdev, opcode, &status, sizeof(status));
 		break;
-- 
1.9.1

