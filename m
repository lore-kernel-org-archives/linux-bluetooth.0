Return-Path: <jaganath.k.os@gmail.com>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH BlueZ 4/8] emulator: Add BREDR 2M & 3M, 3 & 5 Slot packet type support
Date: Fri,  6 Jul 2018 16:58:01 +0530
Message-Id: <1530876485-17218-5-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1530876485-17218-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1530876485-17218-1-git-send-email-jaganathx.kanakkassery@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 emulator/btdev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index f8289d0..9f07527 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -535,6 +535,16 @@ static void set_bredrle_features(struct btdev *btdev)
 	btdev->features[7] |= 0x80;	/* Extended features */
 
 	if (btdev->type >= BTDEV_TYPE_BREDRLE50) {
+		/* These BREDR features are added to test new configuration
+		 * command. If this is added above it will break existing tests
+		 */
+		btdev->features[0] |= 0x01;	/* 3 slot Packets */
+		btdev->features[0] |= 0x02;	/* 5 slot Packets */
+		btdev->features[3] |= 0x02;	/* EDR ACL 2M mode */
+		btdev->features[3] |= 0x04;	/* EDR ACL 3M mode */
+		btdev->features[4] |= 0x80;	/* 3 slot EDR ACL packets */
+		btdev->features[5] |= 0x01;	/* 5 slot EDR ACL packets */
+
 		btdev->le_features[1] |= 0x01;	/* LE 2M PHY */
 		btdev->le_features[1] |= 0x08;	/* LE Coded PHY */
 		btdev->le_features[1] |= 0x10;  /* LE EXT ADV */
-- 
2.7.4
