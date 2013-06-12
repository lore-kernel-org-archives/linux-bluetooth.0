Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [RFC BlueZ 11/35] emulator: Set LE supported states
Date: Wed, 12 Jun 2013 08:56:57 -0400
Message-Id: <1371041841-21793-12-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jefferson Delfes <jefferson.delfes@openbossa.org>

---
 emulator/btdev.c |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index e350a96..6d95938 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -440,6 +440,37 @@ static void set_le_features(struct btdev *btdev)
 	btdev->max_page = 1;
 }
 
+static void set_le_states(struct btdev *btdev)
+{
+	btdev->le_states[0] |= 0x01; /* Non-connectable Advertsing */
+	btdev->le_states[0] |= 0x02; /* Scannable Advertising */
+	btdev->le_states[0] |= 0x04; /* Connectable Advertising */
+	btdev->le_states[0] |= 0x08; /* Directed Advertising */
+	btdev->le_states[0] |= 0x10; /* Passive Scanning */
+	btdev->le_states[0] |= 0x20; /* Active Scanning */
+	btdev->le_states[0] |= 0x40; /* Initiating / Connection (Master) */
+	btdev->le_states[0] |= 0x80; /* Connection (Slave) */
+	btdev->le_states[1] |= 0x01; /* Non-connectable Adv and Passive Scan */
+	btdev->le_states[1] |= 0x02; /* Scannable Adv and Passive Scan */
+	btdev->le_states[1] |= 0x04; /* Connectable Adv and Passive Scan */
+	btdev->le_states[1] |= 0x08; /* Directed Adv and Passive Scan */
+	btdev->le_states[1] |= 0x10; /* Non-connectable Adv and Active Scan */
+	btdev->le_states[1] |= 0x20; /* Scannable Adv and Active Scan */
+	btdev->le_states[1] |= 0x40; /* Connectable Adv and Active Scan */
+	btdev->le_states[1] |= 0x80; /* Directed Adv and Active Scan */
+	btdev->le_states[2] |= 0x01; /* Non-connectable Adv and Initiating */
+	btdev->le_states[2] |= 0x02; /* Scannable Adv and Initiating */
+	btdev->le_states[2] |= 0x04; /* Non-connectable Adv and Master Role */
+	btdev->le_states[2] |= 0x08; /* Scannable Adv and Master Role */
+	btdev->le_states[2] |= 0x10; /* Non-connectable Adv and Slave Role */
+	btdev->le_states[2] |= 0x20; /* Scannable Adv and Slave Role */
+	btdev->le_states[3] |= 0x01; /* Passive Scan and Master Role */
+	btdev->le_states[3] |= 0x02; /* Active Scan and Master Role */
+	btdev->le_states[3] |= 0x04; /* Passive Scan and Slave Role */
+	btdev->le_states[3] |= 0x08; /* Active Scan and Slave Role */
+	btdev->le_states[3] |= 0x10; /* Initiating and Master Role */
+}
+
 static void set_amp_features(struct btdev *btdev)
 {
 }
@@ -469,6 +500,7 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 	case BTDEV_TYPE_BREDRLE:
 		set_bredrle_features(btdev);
 		set_bredrle_commands(btdev);
+		set_le_states(btdev);
 		break;
 	case BTDEV_TYPE_BREDR:
 		set_bredr_features(btdev);
@@ -477,6 +509,7 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 	case BTDEV_TYPE_LE:
 		set_le_features(btdev);
 		set_le_commands(btdev);
+		set_le_states(btdev);
 		break;
 	case BTDEV_TYPE_AMP:
 		set_amp_features(btdev);
-- 
1.7.9.5

