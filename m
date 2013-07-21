Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [PATCH BlueZ 6/8] emulator: cmd_status() using send_packet() for run hooks easily
Date: Sat, 20 Jul 2013 20:17:18 -0400
Message-Id: <1374365840-14651-7-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1374365840-14651-1-git-send-email-bruna.moreira@openbossa.org>
References: <1374365840-14651-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

Now like cmd_command(), cmd_status() directly uses send_packet() instead
of send_event(), consequently cmd_status() must build the hci packet
without help of send_event(). With this change the events sent by
default_cmd() no more use send_event(), who is a good place to run hooks
for BTDEV_HOOK_POST_EVT. And the functions cmd_command() and
cmd_status() can run hooks for BTDEV_HOOK_POST_CMD.
---
 emulator/btdev.c |   28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index e863b5f..006db8c 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -571,13 +571,31 @@ static void cmd_complete(struct btdev *btdev, uint16_t opcode,
 
 static void cmd_status(struct btdev *btdev, uint8_t status, uint16_t opcode)
 {
-	struct bt_hci_evt_cmd_status cs;
+	struct bt_hci_evt_hdr *hdr;
+	struct bt_hci_evt_cmd_status *cs;
+	uint16_t pkt_len;
+	void *pkt_data;
+
+	pkt_len = 1 + sizeof(*hdr) + sizeof(*cs);
 
-	cs.status = status;
-	cs.ncmd = 0x01;
-	cs.opcode = cpu_to_le16(opcode);
+	pkt_data = malloc(pkt_len);
+	if (!pkt_data)
+		return;
 
-	send_event(btdev, BT_HCI_EVT_CMD_STATUS, &cs, sizeof(cs));
+	((uint8_t *) pkt_data)[0] = BT_H4_EVT_PKT;
+
+	hdr = pkt_data + 1;
+	hdr->evt = BT_HCI_EVT_CMD_STATUS;
+	hdr->plen = sizeof(*cs);
+
+	cs = pkt_data + 1 + sizeof(*hdr);
+	cs->status = status;
+	cs->ncmd = 0x01;
+	cs->opcode = cpu_to_le16(opcode);
+
+	send_packet(btdev, pkt_data, pkt_len);
+
+	free(pkt_data);
 }
 
 static void num_completed_packets(struct btdev *btdev)
-- 
1.7.9.5

