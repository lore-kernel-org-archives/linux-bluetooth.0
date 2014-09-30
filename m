Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] emulator/bthost: Refactor code using RFCOMM_UIH
Date: Tue, 30 Sep 2014 17:19:54 +0300
Message-Id: <1412086795-25000-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412086795-25000-1-git-send-email-luiz.dentz@gmail.com>
References: <1412086795-25000-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This refactor code that was using RFCOMM_UIH so it can be reused.
---
 emulator/bthost.c | 125 +++++++++++++++++++++++++-----------------------------
 1 file changed, 57 insertions(+), 68 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 8d06de9..30a612e 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -1726,6 +1726,39 @@ static void rfcomm_disc_recv(struct bthost *bthost, struct btconn *conn,
 	rfcomm_ua_send(bthost, conn, l2conn, 0, dlci);
 }
 
+static void rfcomm_uih_send(struct bthost *bthost, struct btconn *conn,
+				struct l2conn *l2conn, uint8_t address,
+				uint8_t type, const void *data, uint16_t len)
+{
+	struct rfcomm_hdr hdr;
+	struct rfcomm_mcc mcc;
+	uint8_t fcs;
+	struct iovec iov[4];
+
+	hdr.address = address;
+	hdr.control = RFCOMM_CTRL(RFCOMM_UIH, 0);
+	hdr.length  = RFCOMM_LEN8(sizeof(mcc) + len);
+
+	iov[0].iov_base = &hdr;
+	iov[0].iov_len = sizeof(hdr);
+
+	mcc.type = type;
+	mcc.length = RFCOMM_LEN8(len);
+
+	iov[1].iov_base = &mcc;
+	iov[1].iov_len = sizeof(mcc);
+
+	iov[2].iov_base = (void *) data;
+	iov[2].iov_len = len;
+
+	fcs = rfcomm_fcs((uint8_t *) &hdr);
+
+	iov[3].iov_base = &fcs;
+	iov[3].iov_len = sizeof(fcs);
+
+	send_iov(bthost, conn->handle, l2conn->dcid, iov, 4);
+}
+
 static void rfcomm_ua_recv(struct bthost *bthost, struct btconn *conn,
 				struct l2conn *l2conn, const void *data,
 				uint16_t len)
@@ -1734,10 +1767,7 @@ static void rfcomm_ua_recv(struct bthost *bthost, struct btconn *conn,
 	uint8_t channel;
 	struct rfcomm_connection_data *conn_data = bthost->rfcomm_conn_data;
 	uint8_t type;
-	uint8_t buf[14];
-	struct rfcomm_hdr *hdr;
-	struct rfcomm_mcc *mcc;
-	struct rfcomm_pn *pn_cmd;
+	struct rfcomm_pn pn_cmd;
 
 	if (len < sizeof(*ua_hdr))
 		return;
@@ -1760,29 +1790,15 @@ static void rfcomm_ua_recv(struct bthost *bthost, struct btconn *conn,
 
 	bthost_add_rfcomm_conn(bthost, conn, l2conn, channel);
 
-	memset(buf, 0, sizeof(buf));
-
-	hdr = (struct rfcomm_hdr *) buf;
-	mcc = (struct rfcomm_mcc *) (buf + sizeof(*hdr));
-	pn_cmd = (struct rfcomm_pn *) (buf + sizeof(*hdr) + sizeof(*mcc));
+	pn_cmd.dlci = conn_data->channel * 2;
+	pn_cmd.priority = 7;
+	pn_cmd.ack_timer = 0;
+	pn_cmd.max_retrans = 0;
+	pn_cmd.mtu = 667;
+	pn_cmd.credits = 7;
 
-	hdr->address = RFCOMM_ADDR(1, 0);
-	hdr->control = RFCOMM_CTRL(RFCOMM_UIH, 0);
-	hdr->length  = RFCOMM_LEN8(sizeof(*mcc) + sizeof(*pn_cmd));
-
-	mcc->type = RFCOMM_MCC_TYPE(1, RFCOMM_PN);
-	mcc->length = RFCOMM_LEN8(sizeof(*pn_cmd));
-
-	pn_cmd->dlci = conn_data->channel * 2;
-	pn_cmd->priority = 7;
-	pn_cmd->ack_timer = 0;
-	pn_cmd->max_retrans = 0;
-	pn_cmd->mtu = 667;
-	pn_cmd->credits = 7;
-
-	buf[sizeof(*hdr) + sizeof(*mcc) + sizeof(*pn_cmd)] = rfcomm_fcs(buf);
-
-	send_acl(bthost, conn->handle, l2conn->dcid, buf, sizeof(buf));
+	rfcomm_uih_send(bthost, conn, l2conn, RFCOMM_ADDR(1, 0),
+			RFCOMM_MCC_TYPE(1, RFCOMM_PN), &pn_cmd, sizeof(pn_cmd));
 }
 
 static void rfcomm_dm_recv(struct bthost *bthost, struct btconn *conn,
@@ -1811,34 +1827,21 @@ static void rfcomm_msc_recv(struct bthost *bthost, struct btconn *conn,
 					struct l2conn *l2conn, uint8_t cr,
 					const struct rfcomm_msc *msc)
 {
-	uint8_t buf[8];
-	struct rfcomm_hdr *hdr = (struct rfcomm_hdr *) buf;
-	struct rfcomm_mcc *mcc = (struct rfcomm_mcc *) (buf + sizeof(*hdr));
-	struct rfcomm_msc *msc_cmd = (struct rfcomm_msc *) (buf +
-								sizeof(*hdr) +
-								sizeof(*mcc));
-
-	hdr->address = RFCOMM_ADDR(0, 0);
-	hdr->control = RFCOMM_CTRL(RFCOMM_UIH, 0);
-	hdr->length  = RFCOMM_LEN8(sizeof(*mcc) + sizeof(*msc));
-	mcc->type = RFCOMM_MCC_TYPE(cr, RFCOMM_MSC);
-	mcc->length = RFCOMM_LEN8(sizeof(*msc));
+	struct rfcomm_msc msc_cmd;
 
-	msc_cmd->dlci = msc->dlci;
-	msc_cmd->v24_sig = msc->v24_sig;
-	buf[sizeof(*hdr) + sizeof(*mcc) + sizeof(*msc_cmd)] = rfcomm_fcs(buf);
+	msc_cmd.dlci = msc->dlci;
+	msc_cmd.v24_sig = msc->v24_sig;
 
-	send_acl(bthost, conn->handle, l2conn->dcid, buf, sizeof(buf));
+	rfcomm_uih_send(bthost, conn, l2conn, RFCOMM_ADDR(0, 0),
+				RFCOMM_MCC_TYPE(cr, RFCOMM_MSC), &msc_cmd,
+				sizeof(msc_cmd));
 }
 
 static void rfcomm_pn_recv(struct bthost *bthost, struct btconn *conn,
 					struct l2conn *l2conn, uint8_t cr,
 					const struct rfcomm_pn *pn)
 {
-	uint8_t buf[14];
-	struct rfcomm_hdr *hdr;
-	struct rfcomm_mcc *mcc;
-	struct rfcomm_pn *pn_cmd;
+	struct rfcomm_pn pn_cmd;
 
 	if (!cr) {
 		rfcomm_sabm_send(bthost, conn, l2conn, 1,
@@ -1846,29 +1849,15 @@ static void rfcomm_pn_recv(struct bthost *bthost, struct btconn *conn,
 		return;
 	}
 
-	hdr = (struct rfcomm_hdr *) buf;
-	mcc = (struct rfcomm_mcc *) (buf + sizeof(*hdr));
-	pn_cmd = (struct rfcomm_pn *) (buf + sizeof(*hdr) + sizeof(*mcc));
-
-	memset(buf, 0, sizeof(buf));
-
-	hdr->address = RFCOMM_ADDR(1, 0);
-	hdr->control = RFCOMM_CTRL(RFCOMM_UIH, 0);
-	hdr->length  = RFCOMM_LEN8(sizeof(*mcc) + sizeof(*pn_cmd));
-
-	mcc->type = RFCOMM_MCC_TYPE(0, RFCOMM_PN);
-	mcc->length = RFCOMM_LEN8(sizeof(*pn_cmd));
-
-	pn_cmd->dlci = pn->dlci;
-	pn_cmd->priority = pn->priority;
-	pn_cmd->ack_timer = pn->ack_timer;
-	pn_cmd->max_retrans = pn->max_retrans;
-	pn_cmd->mtu = pn->mtu;
-	pn_cmd->credits = pn->credits;
-
-	buf[sizeof(*hdr) + sizeof(*mcc) + sizeof(*pn_cmd)] = rfcomm_fcs(buf);
+	pn_cmd.dlci = pn->dlci;
+	pn_cmd.priority = pn->priority;
+	pn_cmd.ack_timer = pn->ack_timer;
+	pn_cmd.max_retrans = pn->max_retrans;
+	pn_cmd.mtu = pn->mtu;
+	pn_cmd.credits = pn->credits;
 
-	send_acl(bthost, conn->handle, l2conn->dcid, buf, sizeof(buf));
+	rfcomm_uih_send(bthost, conn, l2conn, RFCOMM_ADDR(1, 0),
+			RFCOMM_MCC_TYPE(0, RFCOMM_PN), &pn_cmd, sizeof(pn_cmd));
 }
 
 static void rfcomm_mcc_recv(struct bthost *bthost, struct btconn *conn,
-- 
1.9.3

