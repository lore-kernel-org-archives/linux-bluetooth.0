Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 03/17] Bluetooth: A2MP: Build and Send msg helpers
Date: Tue, 29 May 2012 13:59:03 +0300
Message-Id: <1338289158-25655-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1338289158-25655-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1337351150-20526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1338289158-25655-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Helper function to build and send A2MP messages.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h |    7 +++++++
 net/bluetooth/a2mp.c         |   46 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index ff47540..654df60 100644
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
index 3c241c2..53f49a0 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -17,6 +17,52 @@
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
+static void a2mp_send(struct amp_mgr *mgr, u8 code, u8 ident, u16 len,
+		      void *data)
+{
+	struct l2cap_chan *chan = mgr->a2mp_chan;
+	struct a2mp_cmd *cmd;
+	u16 total_len = len + sizeof(*cmd);
+	struct kvec iv;
+	struct msghdr msg;
+
+	cmd = __a2mp_build(code, ident, len, data);
+	if (!cmd)
+		return;
+
+	iv.iov_base = cmd;
+	iv.iov_len = total_len;
+
+	memset(&msg, 0, sizeof(msg));
+
+	msg.msg_iov = (struct iovec *) &iv;
+	msg.msg_iovlen = 1;
+
+	l2cap_chan_send(chan, &msg, total_len, 0);
+
+	kfree(cmd);
+}
+
 static struct l2cap_ops a2mp_chan_ops = {
 	.name = "L2CAP A2MP channel",
 };
-- 
1.7.9.5

