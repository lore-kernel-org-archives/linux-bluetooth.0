Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 10/19] emulator/bthost: Service msc frames
Date: Fri, 10 Jan 2014 10:18:20 +0100
Message-Id: <1389345509-27206-11-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1389345509-27206-1-git-send-email-marcin.kraglak@tieto.com>
References: <1389345509-27206-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 emulator/bthost.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 83f1e96..1e2506e 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -1393,6 +1393,29 @@ static void rfcomm_dm_recv(struct bthost *bthost, struct btconn *conn,
 {
 }
 
+static void rfcomm_msc_recv(struct bthost *bthost, struct btconn *conn,
+					struct l2conn *l2conn, uint8_t cr,
+					const struct rfcomm_msc *msc)
+{
+	uint8_t buf[8];
+	struct rfcomm_hdr *hdr = (struct rfcomm_hdr *)buf;
+	struct rfcomm_mcc *mcc = (struct rfcomm_mcc *)(buf + sizeof(*hdr));
+	struct rfcomm_msc *msc_cmd = (struct rfcomm_msc *)(buf + sizeof(*hdr)
+							+ sizeof(*mcc));
+
+	hdr->address = RFCOMM_ADDR(0, 0);
+	hdr->control = RFCOMM_CTRL(RFCOMM_UIH, 0);
+	hdr->length  = RFCOMM_LEN8(sizeof(*mcc) + sizeof(*msc));
+	mcc->type = RFCOMM_MCC_TYPE(cr, RFCOMM_MSC);
+	mcc->length = RFCOMM_LEN8(sizeof(*msc));
+
+	msc_cmd->dlci = msc->dlci;
+	msc_cmd->v24_sig = msc->v24_sig;
+	buf[sizeof(*hdr) + sizeof(*mcc) + sizeof(*msc_cmd)] = rfcomm_fcs(buf);
+
+	send_acl(bthost, conn->handle, l2conn->dcid, buf, sizeof(buf));
+}
+
 static void rfcomm_pn_recv(struct bthost *bthost, struct btconn *conn,
 					struct l2conn *l2conn, uint8_t cr,
 					const struct rfcomm_pn *pn)
@@ -1435,6 +1458,11 @@ static void rfcomm_mcc_recv(struct bthost *bthost, struct btconn *conn,
 	uint8_t type = RFCOMM_GET_MCC_TYPE(mcc->type);
 
 	switch (type) {
+	case RFCOMM_MSC:
+		rfcomm_msc_recv(bthost, conn, l2conn,
+						RFCOMM_TEST_CR(mcc->type) / 2,
+							data + sizeof(*mcc));
+		break;
 	case RFCOMM_PN:
 		rfcomm_pn_recv(bthost, conn, l2conn,
 					RFCOMM_TEST_CR(mcc->type) / 2,
-- 
1.8.3.1

