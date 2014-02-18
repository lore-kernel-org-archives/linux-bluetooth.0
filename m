Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 4/6] emulator/bthost: Add function to send RFCOMM UIH frames from bthost
Date: Tue, 18 Feb 2014 08:50:53 +0100
Message-Id: <1392709855-32600-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1392709855-32600-1-git-send-email-marcin.kraglak@tieto.com>
References: <1392709855-32600-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will make RFCOMM UIH frame and fill with data passed by user.
It also adds bthost internal tracking of RFCOMM connections to store
cid and channel - user have to pass only conenction handle and channel.
---
 emulator/bthost.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 emulator/bthost.h |  4 +++
 2 files changed, 101 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 9bf9ad3..92c63cd 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -140,6 +140,7 @@ struct btconn {
 	uint8_t encr_mode;
 	uint16_t next_cid;
 	struct l2conn *l2conns;
+	struct rcconn *rcconns;
 	struct cid_hook *cid_hooks;
 	struct rfcomm_channel_hook *rfcomm_channel_hooks;
 	struct btconn *next;
@@ -153,6 +154,12 @@ struct l2conn {
 	struct l2conn *next;
 };
 
+struct rcconn {
+	uint8_t channel;
+	uint16_t scid;
+	struct rcconn *next;
+};
+
 struct l2cap_pending_req {
 	uint8_t ident;
 	bthost_l2cap_rsp_cb cb;
@@ -241,6 +248,13 @@ static void btconn_free(struct btconn *conn)
 		free(hook);
 	}
 
+	while (conn->rcconns) {
+		struct rcconn *rcconn = conn->rcconns;
+
+		conn->rcconns = rcconn->next;
+		free(rcconn);
+	}
+
 	while (conn->rfcomm_channel_hooks) {
 		struct rfcomm_channel_hook *hook = conn->rfcomm_channel_hooks;
 
@@ -299,6 +313,41 @@ static struct l2conn *bthost_add_l2cap_conn(struct bthost *bthost,
 	return l2conn;
 }
 
+static struct rcconn *bthost_add_rfcomm_conn(struct bthost *bthost,
+						struct btconn *conn,
+						struct l2conn *l2conn,
+						uint8_t channel)
+{
+	struct rcconn *rcconn;
+
+	rcconn = malloc(sizeof(*rcconn));
+	if (!rcconn)
+		return NULL;
+
+	memset(rcconn, 0, sizeof(*rcconn));
+
+	rcconn->channel = channel;
+	rcconn->scid = l2conn->scid;
+
+	rcconn->next = conn->rcconns;
+	conn->rcconns = rcconn;
+
+	return rcconn;
+}
+
+static struct rcconn *btconn_find_rfcomm_conn_by_channel(struct btconn *conn,
+								uint8_t chan)
+{
+	struct rcconn *rcconn;
+
+	for (rcconn = conn->rcconns; rcconn != NULL; rcconn = rcconn->next) {
+		if (rcconn->channel == chan)
+			return rcconn;
+	}
+
+	return NULL;
+}
+
 static struct l2conn *btconn_find_l2cap_conn_by_scid(struct btconn *conn,
 								uint16_t scid)
 {
@@ -1617,6 +1666,7 @@ static void rfcomm_sabm_recv(struct bthost *bthost, struct btconn *conn,
 
 	cb = bthost_find_rfcomm_cb_by_channel(bthost, chan);
 	if (!dlci || cb) {
+		bthost_add_rfcomm_conn(bthost, conn, l2conn, chan);
 		rfcomm_ua_send(bthost, conn, l2conn, 1, dlci);
 		if (cb && cb->func)
 			cb->func(conn->handle, l2conn->scid, cb->user_data,
@@ -1661,6 +1711,7 @@ static void rfcomm_ua_recv(struct bthost *bthost, struct btconn *conn,
 	type = RFCOMM_GET_TYPE(ua_hdr->control);
 
 	if (channel && conn_data && conn_data->channel == channel) {
+		bthost_add_rfcomm_conn(bthost, conn, l2conn, channel);
 		if (conn_data->cb)
 			conn_data->cb(conn->handle, l2conn->scid,
 						conn_data->user_data, true);
@@ -1672,6 +1723,8 @@ static void rfcomm_ua_recv(struct bthost *bthost, struct btconn *conn,
 	if (!conn_data || !RFCOMM_TEST_CR(type))
 		return;
 
+	bthost_add_rfcomm_conn(bthost, conn, l2conn, channel);
+
 	memset(buf, 0, sizeof(buf));
 
 	hdr = (struct rfcomm_hdr *) buf;
@@ -2174,6 +2227,50 @@ void bthost_add_rfcomm_channel_hook(struct bthost *bthost, uint16_t handle,
 	conn->rfcomm_channel_hooks = hook;
 }
 
+void bthost_send_rfcomm_data(struct bthost *bthost, uint16_t handle,
+					uint8_t channel, const void *data,
+					uint16_t len)
+{
+	struct btconn *conn;
+	struct rcconn *rcconn;
+	struct rfcomm_hdr *hdr;
+	uint8_t *uih_frame;
+	uint16_t uih_len;
+
+	conn = bthost_find_conn(bthost, handle);
+	if (!conn)
+		return;
+
+	rcconn = btconn_find_rfcomm_conn_by_channel(conn, channel);
+	if (!rcconn)
+		return;
+
+	if (len > 127)
+		uih_len = len + sizeof(struct rfcomm_cmd) + sizeof(uint8_t);
+	else
+		uih_len = len + sizeof(struct rfcomm_cmd);
+
+	uih_frame = malloc(uih_len);
+	if (!uih_frame)
+		return;
+
+	hdr = (struct rfcomm_hdr *) uih_frame;
+	hdr->address = RFCOMM_ADDR(1, channel * 2);
+	hdr->control = RFCOMM_CTRL(RFCOMM_UIH, 0);
+	if (len > 127) {
+		hdr->length  = RFCOMM_LEN16(cpu_to_le16(sizeof(*hdr) + len));
+		memcpy(uih_frame + sizeof(*hdr) + 1, data, len);
+	} else {
+		hdr->length  = RFCOMM_LEN8(sizeof(*hdr) + len);
+		memcpy(uih_frame + sizeof(*hdr), data, len);
+	}
+
+	uih_frame[uih_len - 1] = rfcomm_fcs((void *)hdr);
+	send_acl(bthost, handle, rcconn->scid, uih_frame, uih_len);
+
+	free(uih_frame);
+}
+
 void bthost_stop(struct bthost *bthost)
 {
 	if (bthost->smp_data) {
diff --git a/emulator/bthost.h b/emulator/bthost.h
index e922f0b..0d4594f 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -108,6 +108,10 @@ void bthost_add_rfcomm_channel_hook(struct bthost *bthost, uint16_t handle,
 					bthost_rfcomm_channel_hook_func_t func,
 					void *user_data);
 
+void bthost_send_rfcomm_data(struct bthost *bthost, uint16_t handle,
+					uint8_t channel, const void *data,
+					uint16_t len);
+
 void bthost_start(struct bthost *bthost);
 void bthost_stop(struct bthost *bthost);
 
-- 
1.8.3.1

