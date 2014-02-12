Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] emulator/bthost: Add function to send RFCOMM UIH frames from bthost
Date: Wed, 12 Feb 2014 12:41:39 +0100
Message-Id: <1392205301-4204-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1392205301-4204-1-git-send-email-marcin.kraglak@tieto.com>
References: <1392205301-4204-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will make RFCOMM UIH frame and fill with data passed by user.
---
 emulator/bthost.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 emulator/bthost.h |  3 +++
 2 files changed, 46 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 92ae08a..6f3e538 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -2174,6 +2174,49 @@ void bthost_add_channel_hook(struct bthost *bthost, uint16_t handle,
 	conn->channel_hooks = hook;
 }
 
+void bthost_send_uih(struct bthost *bthost, uint16_t handle, uint16_t cid,
+			uint8_t channel, const void *data, uint16_t len)
+{
+	struct btconn *conn;
+	struct l2conn *l2conn;
+	struct rfcomm_hdr *hdr;
+	uint8_t *uih_frame;
+	uint16_t uih_len;
+
+	conn = bthost_find_conn(bthost, handle);
+	if (!conn)
+		return;
+
+	l2conn = btconn_find_l2cap_conn_by_scid(conn, cid);
+	if (!l2conn || l2conn->psm != 0x0003)
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
+	hdr = (struct rfcomm_hdr *)uih_frame;
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
+	send_acl(bthost, handle, cid, uih_frame, uih_len);
+
+	free(uih_frame);
+}
+
 void bthost_stop(struct bthost *bthost)
 {
 	if (bthost->smp_data) {
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 730d004..e278517 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -107,6 +107,9 @@ void bthost_add_channel_hook(struct bthost *bthost, uint16_t handle,
 					bthost_channel_hook_func_t func,
 					void *user_data);
 
+void bthost_send_uih(struct bthost *bthost, uint16_t handle, uint16_t cid,
+			uint8_t channel, const void *data, uint16_t len);
+
 void bthost_start(struct bthost *bthost);
 void bthost_stop(struct bthost *bthost);
 
-- 
1.8.3.1

