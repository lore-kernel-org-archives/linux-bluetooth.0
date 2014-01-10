Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 05/19] emulator/bthost: Add method to create rfcomm server
Date: Fri, 10 Jan 2014 10:18:15 +0100
Message-Id: <1389345509-27206-6-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1389345509-27206-1-git-send-email-marcin.kraglak@tieto.com>
References: <1389345509-27206-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It allows user to create rfcomm server on bthost.
---
 emulator/bthost.c | 32 ++++++++++++++++++++++++++++++++
 emulator/bthost.h |  7 +++++++
 2 files changed, 39 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index f896616..bf63b2f 100644
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
 	uint8_t pin[16];
 	uint8_t pin_len;
@@ -248,6 +256,13 @@ void bthost_destroy(struct bthost *bthost)
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
 
@@ -1462,6 +1477,23 @@ void bthost_set_pin_code(struct bthost *bthost, const uint8_t *pin,
 	bthost->pin_len = pin_len;
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
index 7458d5e..2fc21b5 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -83,5 +83,12 @@ void bthost_add_l2cap_server(struct bthost *bthost, uint16_t psm,
 void bthost_set_pin_code(struct bthost *bthost, const uint8_t *pin,
 							uint8_t pin_len);
 
+typedef void (*bthost_rfcomm_connect_cb) (uint16_t handle, uint16_t cid,
+					uint8_t channel, void *user_data,
+					bool status);
+
+void bthost_add_rfcomm_server(struct bthost *bthost, uint8_t channel,
+			bthost_rfcomm_connect_cb func, void *user_data);
+
 void bthost_start(struct bthost *bthost);
 void bthost_stop(struct bthost *bthost);
-- 
1.8.3.1

