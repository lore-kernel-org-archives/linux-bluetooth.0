Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC 13/15] Bluetooth: Fix style issues reported by checkpatch.pl
Date: Tue,  5 Apr 2011 23:11:26 -0300
Message-Id: <1302055888-28177-14-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1302055888-28177-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1302055888-28177-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/bluetooth.h |   33 ++++++++++++++++++---------------
 1 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 4375043..acf186d 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -1,4 +1,4 @@
-/* 
+/*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (C) 2000-2001 Qualcomm Incorporated
 
@@ -12,20 +12,20 @@
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
    IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR ANY
-   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES 
-   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN 
-   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF 
+   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES
+   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
    OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 
-   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS, 
-   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS 
+   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
+   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
    SOFTWARE IS DISCLAIMED.
 */
 
 #ifndef __BLUETOOTH_H
 #define __BLUETOOTH_H
 
-#include <asm/types.h>
+#include <linux/types.h>
 #include <asm/byteorder.h>
 #include <linux/list.h>
 #include <linux/poll.h>
@@ -91,8 +91,8 @@ typedef struct {
 	__u8 b[6];
 } __packed bdaddr_t;
 
-#define BDADDR_ANY   (&(bdaddr_t) {{0, 0, 0, 0, 0, 0}})
-#define BDADDR_LOCAL (&(bdaddr_t) {{0, 0, 0, 0xff, 0xff, 0xff}})
+#define BDADDR_ANY   (&(bdaddr_t) {{0, 0, 0, 0, 0, 0} })
+#define BDADDR_LOCAL (&(bdaddr_t) {{0, 0, 0, 0xff, 0xff, 0xff} })
 
 /* Copy, swap, convert BD Address */
 static inline int bacmp(bdaddr_t *ba1, bdaddr_t *ba2)
@@ -130,10 +130,11 @@ int  bt_sock_register(int proto, const struct net_proto_family *ops);
 int  bt_sock_unregister(int proto);
 void bt_sock_link(struct bt_sock_list *l, struct sock *s);
 void bt_sock_unlink(struct bt_sock_list *l, struct sock *s);
-int  bt_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len, int flags);
+int  bt_sock_recvmsg(struct kiocb *iocb, struct socket *sock,
+				struct msghdr *msg, size_t len, int flags);
 int  bt_sock_stream_recvmsg(struct kiocb *iocb, struct socket *sock,
 			struct msghdr *msg, size_t len, int flags);
-uint bt_sock_poll(struct file * file, struct socket *sock, poll_table *wait);
+uint bt_sock_poll(struct file *file, struct socket *sock, poll_table *wait);
 int  bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg);
 int  bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo);
 
@@ -157,20 +158,22 @@ static inline struct sk_buff *bt_skb_alloc(unsigned int len, gfp_t how)
 {
 	struct sk_buff *skb;
 
-	if ((skb = alloc_skb(len + BT_SKB_RESERVE, how))) {
+	skb = alloc_skb(len + BT_SKB_RESERVE, how);
+	if (skb) {
 		skb_reserve(skb, BT_SKB_RESERVE);
 		bt_cb(skb)->incoming  = 0;
 	}
 	return skb;
 }
 
-static inline struct sk_buff *bt_skb_send_alloc(struct sock *sk, unsigned long len, 
-							int nb, int *err)
+static inline struct sk_buff *bt_skb_send_alloc(struct sock *sk,
+					unsigned long len, int nb, int *err)
 {
 	struct sk_buff *skb;
 
 	release_sock(sk);
-	if ((skb = sock_alloc_send_skb(sk, len + BT_SKB_RESERVE, nb, err))) {
+	skb = sock_alloc_send_skb(sk, len + BT_SKB_RESERVE, nb, err);
+	if (skb) {
 		skb_reserve(skb, BT_SKB_RESERVE);
 		bt_cb(skb)->incoming  = 0;
 	}
-- 
1.7.4.1

