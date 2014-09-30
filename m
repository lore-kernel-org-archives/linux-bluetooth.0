Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] emulator/bthost: Add bthost_send_cid_v
Date: Tue, 30 Sep 2014 17:19:55 +0300
Message-Id: <1412086795-25000-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1412086795-25000-1-git-send-email-luiz.dentz@gmail.com>
References: <1412086795-25000-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 emulator/bthost.c | 12 ++++++++++++
 emulator/bthost.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 30a612e..59dde1e 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -604,6 +604,18 @@ void bthost_send_cid(struct bthost *bthost, uint16_t handle, uint16_t cid,
 	send_acl(bthost, handle, cid, data, len);
 }
 
+void bthost_send_cid_v(struct bthost *bthost, uint16_t handle, uint16_t cid,
+					const struct iovec *iov, int iovcnt)
+{
+	struct btconn *conn;
+
+	conn = bthost_find_conn(bthost, handle);
+	if (!conn)
+		return;
+
+	send_iov(bthost, handle, cid, iov, iovcnt);
+}
+
 bool bthost_l2cap_req(struct bthost *bthost, uint16_t handle, uint8_t code,
 				const void *data, uint16_t len,
 				bthost_l2cap_rsp_cb cb, void *user_data)
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 9d75e2c..62d415c 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -64,6 +64,8 @@ void bthost_add_cid_hook(struct bthost *bthost, uint16_t handle, uint16_t cid,
 
 void bthost_send_cid(struct bthost *bthost, uint16_t handle, uint16_t cid,
 					const void *data, uint16_t len);
+void bthost_send_cid_v(struct bthost *bthost, uint16_t handle, uint16_t cid,
+					const struct iovec *iov, int iovcnt);
 
 typedef void (*bthost_l2cap_rsp_cb) (uint8_t code, const void *data,
 						uint16_t len, void *user_data);
-- 
1.9.3

