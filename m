Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/6] emulator/bthost: Add api to handle RFCOMM data on bthost
Date: Tue, 18 Feb 2014 08:50:50 +0100
Message-Id: <1392709855-32600-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1392709855-32600-1-git-send-email-marcin.kraglak@tieto.com>
References: <1392709855-32600-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this change user can handle data received on RFCOMM connection.
---
 emulator/bthost.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 emulator/bthost.h |  9 +++++++
 2 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 6fbabe8..9bf9ad3 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -126,6 +126,13 @@ struct cid_hook {
 	struct cid_hook *next;
 };
 
+struct rfcomm_channel_hook {
+	uint8_t channel;
+	bthost_rfcomm_channel_hook_func_t func;
+	void *user_data;
+	struct rfcomm_channel_hook *next;
+};
+
 struct btconn {
 	uint16_t handle;
 	uint8_t bdaddr[6];
@@ -134,6 +141,7 @@ struct btconn {
 	uint16_t next_cid;
 	struct l2conn *l2conns;
 	struct cid_hook *cid_hooks;
+	struct rfcomm_channel_hook *rfcomm_channel_hooks;
 	struct btconn *next;
 	void *smp_data;
 };
@@ -233,6 +241,13 @@ static void btconn_free(struct btconn *conn)
 		free(hook);
 	}
 
+	while (conn->rfcomm_channel_hooks) {
+		struct rfcomm_channel_hook *hook = conn->rfcomm_channel_hooks;
+
+		conn->rfcomm_channel_hooks = hook->next;
+		free(hook);
+	}
+
 	free(conn);
 }
 
@@ -1547,6 +1562,18 @@ static struct cid_hook *find_cid_hook(struct btconn *conn, uint16_t cid)
 	return NULL;
 }
 
+static struct rfcomm_channel_hook *find_rfcomm_channel_hook(struct btconn *conn,
+							uint16_t channel)
+{
+	struct rfcomm_channel_hook *hook;
+
+	for (hook = conn->rfcomm_channel_hooks; hook != NULL; hook = hook->next)
+		if (hook->channel == channel)
+			return hook;
+
+	return NULL;
+}
+
 static void rfcomm_ua_send(struct bthost *bthost, struct btconn *conn,
 			struct l2conn *l2conn, uint8_t cr, uint8_t dlci)
 {
@@ -1801,9 +1828,6 @@ static void rfcomm_uih_recv(struct bthost *bthost, struct btconn *conn,
 	if (len < sizeof(*hdr))
 		return;
 
-	if (RFCOMM_GET_DLCI(hdr->address))
-		return;
-
 	if (RFCOMM_TEST_EA(hdr->length))
 		hdr_len = sizeof(*hdr);
 	else
@@ -1814,7 +1838,19 @@ static void rfcomm_uih_recv(struct bthost *bthost, struct btconn *conn,
 
 	p = data + hdr_len;
 
-	rfcomm_mcc_recv(bthost, conn, l2conn, p, len - hdr_len);
+	if (RFCOMM_GET_DLCI(hdr->address)) {
+		struct rfcomm_channel_hook *hook;
+
+		hook = find_rfcomm_channel_hook(conn,
+					RFCOMM_GET_CHANNEL(hdr->address));
+		if (!hook)
+			return;
+
+		hook->func(p, len - hdr_len - sizeof(uint8_t),
+							hook->user_data);
+	} else {
+		rfcomm_mcc_recv(bthost, conn, l2conn, p, len - hdr_len);
+	}
 }
 
 static void process_rfcomm(struct bthost *bthost, struct btconn *conn,
@@ -2112,6 +2148,32 @@ bool bthost_connect_rfcomm(struct bthost *bthost, uint16_t handle,
 					&req, sizeof(req), NULL, NULL);
 }
 
+void bthost_add_rfcomm_channel_hook(struct bthost *bthost, uint16_t handle,
+					uint8_t channel,
+					bthost_rfcomm_channel_hook_func_t func,
+					void *user_data)
+{
+	struct rfcomm_channel_hook *hook;
+	struct btconn *conn;
+
+	conn = bthost_find_conn(bthost, handle);
+	if (!conn)
+		return;
+
+	hook = malloc(sizeof(*hook));
+	if (!hook)
+		return;
+
+	memset(hook, 0, sizeof(*hook));
+
+	hook->channel = channel;
+	hook->func = func;
+	hook->user_data = user_data;
+
+	hook->next = conn->rfcomm_channel_hooks;
+	conn->rfcomm_channel_hooks = hook;
+}
+
 void bthost_stop(struct bthost *bthost)
 {
 	if (bthost->smp_data) {
diff --git a/emulator/bthost.h b/emulator/bthost.h
index a3c26a1..e922f0b 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -99,6 +99,15 @@ bool bthost_connect_rfcomm(struct bthost *bthost, uint16_t handle,
 				uint8_t channel, bthost_rfcomm_connect_cb func,
 				void *user_data);
 
+typedef void (*bthost_rfcomm_channel_hook_func_t) (const void *data,
+							uint16_t len,
+							void *user_data);
+
+void bthost_add_rfcomm_channel_hook(struct bthost *bthost, uint16_t handle,
+					uint8_t channel,
+					bthost_rfcomm_channel_hook_func_t func,
+					void *user_data);
+
 void bthost_start(struct bthost *bthost);
 void bthost_stop(struct bthost *bthost);
 
-- 
1.8.3.1

