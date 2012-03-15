Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv4 11/30] Bluetooth: A2MP: Build and Send msg helpers
Date: Thu, 15 Mar 2012 14:30:02 +0200
Message-Id: <1331814621-13905-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1331814621-13905-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1331814621-13905-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Helper function to build and send A2MP messages.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h |    7 ++++++
 net/bluetooth/a2mp.c         |   49 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index 0fe8ddd..995f1c0 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -24,6 +24,13 @@ struct amp_mgr {
 	unsigned long		flags;
 };
 
+struct a2mp_cmd {
+	__u8	code;
+	__u8	ident;
+	__le16	len;
+	__u8	data[0];
+} __packed;
+
 void amp_mgr_get(struct amp_mgr *mgr);
 int amp_mgr_put(struct amp_mgr *mgr);
 
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 63970b5..19a8ac3 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -16,6 +16,54 @@
 #include <net/bluetooth/l2cap.h>
 #include <net/bluetooth/a2mp.h>
 
+/* A2MP build & send command helper functions */
+static struct a2mp_cmd *__a2mp_build(u8 code, u8 ident, u16 len, void *data)
+{
+	struct a2mp_cmd *cmd;
+	int plen;
+
+	plen = sizeof(*cmd) + len;
+	cmd = kzalloc(plen, GFP_KERNEL);
+	if (!cmd)
+		return NULL;
+
+	cmd->code = code;
+	cmd->ident = ident;
+	cmd->len = cpu_to_le16(len);
+
+	memcpy(cmd->data, data, len);
+
+	return cmd;
+}
+
+static inline int __a2mp_send(struct amp_mgr *mgr, u8 *data, int len)
+{
+	struct l2cap_chan *chan = mgr->a2mp_chan;
+	struct kvec iv = { data, len };
+	struct msghdr msg;
+
+	memset(&msg, 0, sizeof(msg));
+
+	msg.msg_iov = (struct iovec *) &iv;
+	msg.msg_iovlen = 1;
+
+	return chan->ops->send(chan, &msg, len, 0);
+}
+
+static void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len,
+								void *data)
+{
+	struct a2mp_cmd *cmd;
+
+	cmd = __a2mp_build(code, ident, len, data);
+	if (!cmd)
+		return;
+
+	__a2mp_send(mgr, (u8 *)cmd, len + sizeof(*cmd));
+
+	kfree(cmd);
+}
+
 static void a2mp_chan_state_change_cb(void *data, int state, int err)
 {
 	struct l2cap_chan *chan = data;
@@ -44,6 +92,7 @@ static void a2mp_chan_close_cb(void *data)
 static struct l2cap_ops a2mp_chan_ops = {
 	.name		= "L2CAP A2MP channel",
 	.close		= a2mp_chan_close_cb,
+	.send		= l2cap_chan_send,
 	.state_change	= a2mp_chan_state_change_cb,
 };
 
-- 
1.7.9.1

