Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 5/5] emulator/bthost: Add method to create rfcomm server
Date: Tue,  7 Jan 2014 11:59:14 +0100
Message-Id: <1389092354-32544-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1389092354-32544-1-git-send-email-marcin.kraglak@tieto.com>
References: <1389092354-32544-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It allows user to create rfcomm server on bthost.
---
 emulator/bthost.c | 32 ++++++++++++++++++++++++++++++++
 emulator/bthost.h |  6 ++++++
 2 files changed, 38 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 8638f13..676c0ae 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -99,6 +99,13 @@ struct l2cap_conn_cb_data {
 	struct l2cap_conn_cb_data *next;
 };
 
+struct rfcomm_conn_cb_data {
+	uint8_t channel;
+	bthost_rfcomm_connect_cb func;
+	void *user_data;
+	struct rfcomm_conn_cb_data *next;
+};
+
 struct bthost {
 	uint8_t bdaddr[6];
 	bthost_send_func send_handler;
@@ -111,6 +118,7 @@ struct bthost {
 	bthost_new_conn_cb new_conn_cb;
 	void *new_conn_data;
 	struct l2cap_conn_cb_data *new_l2cap_conn_data;
+	struct rfcomm_conn_cb_data *new_rfcomm_conn_data;
 	struct l2cap_pending_req *l2reqs;
 };
 
@@ -246,6 +254,13 @@ void bthost_destroy(struct bthost *bthost)
 		free(cb);
 	}
 
+	while (bthost->new_rfcomm_conn_data) {
+		struct rfcomm_conn_cb_data *cb = bthost->new_rfcomm_conn_data;
+
+		bthost->new_rfcomm_conn_data = cb->next;
+		free(cb);
+	}
+
 	free(bthost);
 }
 
@@ -1392,6 +1407,23 @@ void bthost_add_l2cap_server(struct bthost *bthost, uint16_t psm,
 	bthost->new_l2cap_conn_data = data;
 }
 
+void bthost_add_rfcomm_server(struct bthost *bthost, uint8_t channel,
+				bthost_rfcomm_connect_cb func, void *user_data)
+{
+	struct rfcomm_conn_cb_data *data;
+
+	data = malloc(sizeof(struct rfcomm_conn_cb_data));
+	if (!data)
+		return;
+
+	data->channel = channel;
+	data->user_data = user_data;
+	data->func = func;
+	data->next = bthost->new_rfcomm_conn_data;
+
+	bthost->new_rfcomm_conn_data = data;
+}
+
 void bthost_start(struct bthost *bthost)
 {
 	if (!bthost)
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 97f011b..7186aa0 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -80,5 +80,11 @@ typedef void (*bthost_l2cap_connect_cb) (uint16_t handle, uint16_t cid,
 void bthost_add_l2cap_server(struct bthost *bthost, uint16_t psm,
 				bthost_l2cap_connect_cb func, void *user_data);
 
+typedef void (*bthost_rfcomm_connect_cb) (uint16_t handle, uint16_t cid,
+					uint8_t channel, void *user_data);
+
+void bthost_add_rfcomm_server(struct bthost *bthost, uint8_t channel,
+			bthost_rfcomm_connect_cb func, void *user_data);
+
 void bthost_start(struct bthost *bthost);
 void bthost_stop(struct bthost *bthost);
-- 
1.8.3.1

