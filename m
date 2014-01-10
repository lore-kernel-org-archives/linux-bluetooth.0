Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 08/19] emulator/bthost: Add rfcomm_mcc_recv stub
Date: Fri, 10 Jan 2014 10:18:18 +0100
Message-Id: <1389345509-27206-9-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1389345509-27206-1-git-send-email-marcin.kraglak@tieto.com>
References: <1389345509-27206-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will handle mcc frames in bthost.
---
 emulator/bthost.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 242ce19..591aae9 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -1387,10 +1387,29 @@ static void rfcomm_dm_recv(struct bthost *bthost, struct btconn *conn,
 {
 }
 
+static void rfcomm_mcc_recv(struct bthost *bthost, struct btconn *conn,
+			struct l2conn *l2conn, const void *data, uint16_t len)
+{
+}
+
 static void rfcomm_uih_recv(struct bthost *bthost, struct btconn *conn,
 				struct l2conn *l2conn, const void *data,
 				uint16_t len)
 {
+	const struct rfcomm_cmd *hdr = data;
+	const void *p;
+	uint8_t ea;
+
+	ea = RFCOMM_TEST_EA(hdr->length) ? true : false;
+
+	if (!RFCOMM_GET_DLCI(hdr->address)) {
+		if (ea)
+			p = data + sizeof(struct rfcomm_hdr);
+		else
+			p = data + sizeof(struct rfcomm_hdr) + sizeof(uint8_t);
+
+		rfcomm_mcc_recv(bthost, conn, l2conn, p, p - data);
+	}
 }
 
 static void process_rfcomm(struct bthost *bthost, struct btconn *conn,
-- 
1.8.3.1

