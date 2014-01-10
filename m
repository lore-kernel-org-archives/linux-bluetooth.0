Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 15/19] emulator/bthost: Ad implementation of rfcomm_ua_recv
Date: Fri, 10 Jan 2014 10:18:25 +0100
Message-Id: <1389345509-27206-16-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1389345509-27206-1-git-send-email-marcin.kraglak@tieto.com>
References: <1389345509-27206-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will handle ua responses in bthost.
---
 emulator/bthost.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 4006b71..ebf8789 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -1418,6 +1418,41 @@ static void rfcomm_ua_recv(struct bthost *bthost, struct btconn *conn,
 				struct l2conn *l2conn, const void *data,
 				uint16_t len)
 {
+	const struct rfcomm_cmd *hdr = data;
+	uint8_t channel = RFCOMM_GET_CHANNEL(hdr->address);
+
+	if (!channel && RFCOMM_TEST_CR(RFCOMM_GET_TYPE(hdr->control)) &&
+						 bthost->rfcomm_conn_data) {
+		uint8_t buf[14];
+		struct rfcomm_hdr *hdr = (struct rfcomm_hdr *)buf;
+		struct rfcomm_mcc *mcc = (struct rfcomm_mcc *)
+							(buf + sizeof(*hdr));
+		struct rfcomm_pn *pn_cmd = (struct rfcomm_pn *)
+							(buf + sizeof(*hdr)
+							+ sizeof(*mcc));
+
+		memset(buf, 0, sizeof(buf));
+
+		hdr->address = RFCOMM_ADDR(1, 0);
+		hdr->control = RFCOMM_CTRL(RFCOMM_UIH, 0);
+		hdr->length  = RFCOMM_LEN8(sizeof(*mcc) +
+							sizeof(*pn_cmd));
+
+		mcc->type = RFCOMM_MCC_TYPE(1, RFCOMM_PN);
+		mcc->length = RFCOMM_LEN8(sizeof(*pn_cmd));
+
+		pn_cmd->dlci = bthost->rfcomm_conn_data->channel * 2;
+		pn_cmd->priority = 7;
+		pn_cmd->ack_timer = 0;
+		pn_cmd->max_retrans = 0;
+		pn_cmd->mtu = 667;
+		pn_cmd->credits = 7;
+
+		buf[sizeof(*hdr) + sizeof(*mcc) + sizeof(*pn_cmd)] =
+							rfcomm_fcs(buf);
+
+		send_acl(bthost, conn->handle, l2conn->dcid, buf, sizeof(buf));
+	}
 }
 
 static void rfcomm_dm_recv(struct bthost *bthost, struct btconn *conn,
-- 
1.8.3.1

