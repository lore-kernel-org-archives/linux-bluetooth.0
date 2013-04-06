Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo@padovan.org>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH v4 07/16] Bluetooth: hidp: move hidp_schedule() to core.c
Date: Sat,  6 Apr 2013 20:28:43 +0200
Message-Id: <1365272932-571-8-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1365272932-571-1-git-send-email-dh.herrmann@gmail.com>
References: <1365166670-3271-1-git-send-email-dh.herrmann@gmail.com>
 <1365272932-571-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no reason to keep this helper in the header file. No other file
depends on it so move it into hidp/core.c where it belongs.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hidp/core.c | 9 +++++++++
 net/bluetooth/hidp/hidp.h | 9 ---------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index e01a924..cef1021 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -59,6 +59,15 @@ static unsigned char hidp_keycode[256] = {
 
 static unsigned char hidp_mkeyspat[] = { 0x01, 0x01, 0x01, 0x01, 0x01, 0x01 };
 
+static inline void hidp_schedule(struct hidp_session *session)
+{
+	struct sock *ctrl_sk = session->ctrl_sock->sk;
+	struct sock *intr_sk = session->intr_sock->sk;
+
+	wake_up_interruptible(sk_sleep(ctrl_sk));
+	wake_up_interruptible(sk_sleep(intr_sk));
+}
+
 static struct hidp_session *__hidp_get_session(bdaddr_t *bdaddr)
 {
 	struct hidp_session *session;
diff --git a/net/bluetooth/hidp/hidp.h b/net/bluetooth/hidp/hidp.h
index 57a6191..c844420 100644
--- a/net/bluetooth/hidp/hidp.h
+++ b/net/bluetooth/hidp/hidp.h
@@ -174,15 +174,6 @@ struct hidp_session {
 	int waiting_for_startup;
 };
 
-static inline void hidp_schedule(struct hidp_session *session)
-{
-	struct sock *ctrl_sk = session->ctrl_sock->sk;
-	struct sock *intr_sk = session->intr_sock->sk;
-
-	wake_up_interruptible(sk_sleep(ctrl_sk));
-	wake_up_interruptible(sk_sleep(intr_sk));
-}
-
 /* HIDP init defines */
 extern int __init hidp_init_sockets(void);
 extern void __exit hidp_cleanup_sockets(void);
-- 
1.8.2

