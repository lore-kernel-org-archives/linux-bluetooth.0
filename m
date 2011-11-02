Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 04/20] Bluetooth: A2MP: build and send msg helpers
Date: Wed,  2 Nov 2011 16:02:32 +0200
Message-Id: <1320242568-372-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1320242568-372-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1320242568-372-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Helper function to build and send A2MP messages.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/a2mp.h |    7 ++++++
 net/bluetooth/a2mp.c         |   46 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
index a3938f9..7ead6a3 100644
--- a/include/net/bluetooth/a2mp.h
+++ b/include/net/bluetooth/a2mp.h
@@ -15,6 +15,13 @@
 #ifndef __A2MP_H
 #define __A2MP_H
 
+struct a2mp_cmd {
+	__u8	code;
+	__u8	ident;
+	__le16	len;
+	__u8	data[0];
+} __packed;
+
 struct a2mp_work_data_ready {
 	struct work_struct work;
 	struct sock *sk;
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index d0b15d8..2fe0004 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -21,6 +21,52 @@
 
 static struct workqueue_struct *a2mp_workqueue;
 
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
+static inline int __a2mp_send(struct socket *sock, u8 *data, int len)
+{
+	struct kvec iv = { data, len };
+	struct msghdr msg;
+
+	memset(&msg, 0, sizeof(msg));
+
+	return kernel_sendmsg(sock, &msg, &iv, 1, len);
+}
+
+static void a2mp_send(struct socket *a2mp_sock, u8 code, u8 ident, u16 len,
+								void *data)
+{
+	struct a2mp_cmd *cmd;
+
+	if (!a2mp_sock)
+		return;
+
+	cmd = __a2mp_build(code, ident, len, data);
+	if (!cmd)
+		return;
+
+	__a2mp_send(a2mp_sock, (u8 *)cmd, len + sizeof(*cmd));
+	kfree(cmd);
+}
+
 static void data_ready_worker(struct work_struct *w)
 {
 	struct a2mp_work_data_ready *work = (struct a2mp_work_data_ready *) w;
-- 
1.7.4.1

