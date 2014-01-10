Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 09/19] emulator/bthost: Add recv_pn implementation
Date: Fri, 10 Jan 2014 10:18:19 +0100
Message-Id: <1389345509-27206-10-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1389345509-27206-1-git-send-email-marcin.kraglak@tieto.com>
References: <1389345509-27206-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 emulator/bthost.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 591aae9..83f1e96 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -54,6 +54,7 @@
 #define RFCOMM_CTRL(type, pf)	(((type & 0xef) | (pf << 4)))
 #define RFCOMM_LEN8(len)	(((len) << 1) | 1)
 #define RFCOMM_LEN16(len)	((len) << 1)
+#define RFCOMM_MCC_TYPE(cr, type)	(((type << 2) | (cr << 1) | 0x01))
 
 /* RFCOMM FCS calculation */
 #define CRC(data) (rfcomm_crc_table[rfcomm_crc_table[0xff ^ data[0]] ^ data[1]])
@@ -105,6 +106,11 @@ static uint8_t rfcomm_fcs2(uint8_t *data)
 	return 0xff - rfcomm_crc_table[CRC(data) ^ data[2]];
 }
 
+static uint8_t rfcomm_fcs(uint8_t *data)
+{
+	return 0xff - CRC(data);
+}
+
 struct cmd {
 	struct cmd *next;
 	struct cmd *prev;
@@ -1387,9 +1393,56 @@ static void rfcomm_dm_recv(struct bthost *bthost, struct btconn *conn,
 {
 }
 
+static void rfcomm_pn_recv(struct bthost *bthost, struct btconn *conn,
+					struct l2conn *l2conn, uint8_t cr,
+					const struct rfcomm_pn *pn)
+{
+	if (cr) {
+		uint8_t buf[14];
+		struct rfcomm_hdr *hdr = (struct rfcomm_hdr *)buf;
+		struct rfcomm_mcc *mcc = (struct rfcomm_mcc *)(buf +
+								sizeof(*hdr));
+		struct rfcomm_pn *pn_cmd = (struct rfcomm_pn *)
+					(buf + sizeof(*hdr) + sizeof(*mcc));
+
+		memset(buf, 0, sizeof(buf));
+
+		hdr->address = RFCOMM_ADDR(1, 0);
+		hdr->control = RFCOMM_CTRL(RFCOMM_UIH, 0);
+		hdr->length  = RFCOMM_LEN8(sizeof(*mcc) + sizeof(*pn_cmd));
+
+		mcc->type = RFCOMM_MCC_TYPE(0, RFCOMM_PN);
+		mcc->length = RFCOMM_LEN8(sizeof(*pn_cmd));
+
+		pn_cmd->dlci = pn->dlci;
+		pn_cmd->priority = pn->priority;
+		pn_cmd->ack_timer = pn->ack_timer;
+		pn_cmd->max_retrans = pn->max_retrans;
+		pn_cmd->mtu = pn->mtu;
+		pn_cmd->credits = pn->credits;
+
+		buf[sizeof(*hdr) + sizeof(*mcc) + sizeof(*pn_cmd)] =
+							rfcomm_fcs(buf);
+
+		send_acl(bthost, conn->handle, l2conn->dcid, buf, sizeof(buf));
+	}
+}
+
 static void rfcomm_mcc_recv(struct bthost *bthost, struct btconn *conn,
 			struct l2conn *l2conn, const void *data, uint16_t len)
 {
+	const struct rfcomm_mcc *mcc = data;
+	uint8_t type = RFCOMM_GET_MCC_TYPE(mcc->type);
+
+	switch (type) {
+	case RFCOMM_PN:
+		rfcomm_pn_recv(bthost, conn, l2conn,
+					RFCOMM_TEST_CR(mcc->type) / 2,
+					data + sizeof(*mcc));
+		break;
+	default:
+		break;
+	}
 }
 
 static void rfcomm_uih_recv(struct bthost *bthost, struct btconn *conn,
-- 
1.8.3.1

