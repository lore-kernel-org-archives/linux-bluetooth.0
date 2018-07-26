Return-Path: <jaganath.k.os@gmail.com>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH BlueZ] emulator: Fix unsupported command for WRITE_LE_HOST_SUPPORTED
Date: Thu, 26 Jul 2018 16:53:29 +0530
Message-Id: <1532604209-32633-1-git-send-email-jaganathx.kanakkassery@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

WRITE_LE_HOST_SUPPORTED command needs check for BTDEV_TYPE_LE as well.
---
 emulator/btdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index f8289d0..ae30950 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -2960,6 +2960,7 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 
 	case BT_HCI_CMD_WRITE_LE_HOST_SUPPORTED:
 		if (btdev->type != BTDEV_TYPE_BREDRLE &&
+				btdev->type != BTDEV_TYPE_LE &&
 				btdev->type != BTDEV_TYPE_BREDRLE50)
 			goto unsupported;
 		wlhs = data;
-- 
2.7.4
