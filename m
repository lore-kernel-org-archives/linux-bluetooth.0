Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [RFC BlueZ 14/35] emulator: Add hook only if there aren't other with same type and opcode
Date: Wed, 12 Jun 2013 08:57:00 -0400
Message-Id: <1371041841-21793-15-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

---
 emulator/btdev.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 1560936..1006e03 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -123,6 +123,23 @@ struct connection {
 
 static struct connection *connection_list[MAX_CONNECTION_ENTRIES] = { };
 
+static int get_hook_index(struct btdev *btdev, enum btdev_hook_type type,
+								uint16_t opcode)
+{
+	int i;
+
+	for (i = 0; i < MAX_HOOK_ENTRIES; i++) {
+		if (btdev->hook_list[i] == NULL)
+			continue;
+
+		if (btdev->hook_list[i]->type == type &&
+					btdev->hook_list[i]->opcode == opcode)
+			return i;
+	}
+
+	return -1;
+}
+
 static inline int add_btdev(struct btdev *btdev)
 {
 	int i, index = -1;
@@ -1857,6 +1874,9 @@ int btdev_add_hook(struct btdev *btdev, enum btdev_hook_type type,
 	if (!btdev)
 		return -1;
 
+	if (get_hook_index(btdev, type, opcode) > 0)
+		return -1;
+
 	for (i = 0; i < MAX_HOOK_ENTRIES; i++) {
 		if (btdev->hook_list[i] == NULL) {
 			btdev->hook_list[i] = malloc(sizeof(struct hook));
-- 
1.7.9.5

