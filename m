Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 26/35] btdev: Add function to send an aborted packet
Date: Wed, 12 Jun 2013 08:57:12 -0400
Message-Id: <1371041841-21793-27-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

After running a hook, it is possible to ignore a packet in this moment
for sending the same packet later.
---
 emulator/btdev.c    |   14 ++++++++++++++
 emulator/btdev.h    |    2 ++
 src/shared/hciemu.c |    5 +++++
 src/shared/hciemu.h |    2 ++
 4 files changed, 23 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index e70ad19..6d71ce2 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -107,6 +107,9 @@ struct btdev {
 	uint16_t sync_train_interval;
 	uint32_t sync_train_timeout;
 	uint8_t  sync_train_service_data;
+
+	uint8_t dropped_pkt_data[255];
+	uint16_t dropped_pkt_len;
 };
 
 #define MAX_BTDEV_ENTRIES 16
@@ -647,6 +650,10 @@ static void send_event(struct btdev *btdev, uint8_t event,
 
 	if (run_hooks(btdev, BTDEV_HOOK_POST_EVT, event, pkt_data, pkt_len))
 		send_packet(btdev, pkt_data, pkt_len);
+	else {
+		memcpy(btdev->dropped_pkt_data, pkt_data, pkt_len);
+		btdev->dropped_pkt_len = pkt_len;
+	}
 
 	free(pkt_data);
 }
@@ -2027,3 +2034,10 @@ bool btdev_del_hook(struct btdev *btdev, enum btdev_hook_type type,
 
 	return false;
 }
+
+void btdev_send_packet(struct btdev *btdev)
+{
+	if (btdev->dropped_pkt_len)
+		send_packet(btdev, btdev->dropped_pkt_data,
+							btdev->dropped_pkt_len);
+}
diff --git a/emulator/btdev.h b/emulator/btdev.h
index 5118a4a..c1cf882 100644
--- a/emulator/btdev.h
+++ b/emulator/btdev.h
@@ -92,3 +92,5 @@ int btdev_add_hook(struct btdev *btdev, enum btdev_hook_type type,
 
 bool btdev_del_hook(struct btdev *btdev, enum btdev_hook_type type,
 							uint16_t opcode);
+
+void btdev_send_packet(struct btdev *btdev);
diff --git a/src/shared/hciemu.c b/src/shared/hciemu.c
index 0bbaa09..d36639f 100644
--- a/src/shared/hciemu.c
+++ b/src/shared/hciemu.c
@@ -463,3 +463,8 @@ bool hciemu_del_hook(struct hciemu *hciemu, enum hciemu_hook_type type,
 
 	return btdev_del_hook(hciemu->master_dev, hook_type, opcode);
 }
+
+void hciemu_send_packet(struct hciemu *hciemu)
+{
+	btdev_send_packet(hciemu->master_dev);
+}
diff --git a/src/shared/hciemu.h b/src/shared/hciemu.h
index 2abf404..5b23a0b 100644
--- a/src/shared/hciemu.h
+++ b/src/shared/hciemu.h
@@ -65,3 +65,5 @@ int hciemu_add_hook(struct hciemu *hciemu, enum hciemu_hook_type type,
 
 bool hciemu_del_hook(struct hciemu *hciemu, enum hciemu_hook_type type,
 							uint16_t opcode);
+
+void hciemu_send_packet(struct hciemu *hciemu);
-- 
1.7.9.5

