Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 2/4] Bluetooth: clean up rfcomm code
Date: Fri, 26 Nov 2010 17:22:43 +0200
Message-Id: <1290784965-4508-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1290784965-4508-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1290784965-4508-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Remove extra spaces, assignments in if statement, zeroing static
variables.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
---
 include/net/bluetooth/rfcomm.h |   18 +++++++++---------
 net/bluetooth/rfcomm/core.c    |    8 ++++----
 net/bluetooth/rfcomm/sock.c    |    5 +++--
 net/bluetooth/rfcomm/tty.c     |   28 ++++++++++++++++------------
 4 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index 71047bc..6eac4a7 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -1,5 +1,5 @@
-/* 
-   RFCOMM implementation for Linux Bluetooth stack (BlueZ).
+/*
+   RFCOMM implementation for Linux Bluetooth stack (BlueZ)
    Copyright (C) 2002 Maxim Krasnyansky <maxk@qualcomm.com>
    Copyright (C) 2002 Marcel Holtmann <marcel@holtmann.org>
 
@@ -11,13 +11,13 @@
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
 
@@ -105,7 +105,7 @@
 struct rfcomm_hdr {
 	u8 addr;
 	u8 ctrl;
-	u8 len;    // Actual size can be 2 bytes
+	u8 len;    /* Actual size can be 2 bytes */
 } __packed;
 
 struct rfcomm_cmd {
@@ -228,7 +228,7 @@ struct rfcomm_dlc {
 /* ---- RFCOMM SEND RPN ---- */
 int rfcomm_send_rpn(struct rfcomm_session *s, int cr, u8 dlci,
 			u8 bit_rate, u8 data_bits, u8 stop_bits,
-			u8 parity, u8 flow_ctrl_settings, 
+			u8 parity, u8 flow_ctrl_settings,
 			u8 xon_char, u8 xoff_char, u16 param_mask);
 
 /* ---- RFCOMM DLCs (channels) ---- */
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index fa642aa..c1e2bba 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -41,7 +41,7 @@
 #include <linux/slab.h>
 
 #include <net/sock.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -51,10 +51,10 @@
 
 #define VERSION "1.11"
 
-static int disable_cfc = 0;
+static int disable_cfc;
+static int l2cap_ertm;
 static int channel_mtu = -1;
 static unsigned int l2cap_mtu = RFCOMM_MAX_L2CAP_MTU;
-static int l2cap_ertm = 0;
 
 static struct task_struct *rfcomm_thread;
 
@@ -1901,7 +1901,7 @@ static inline void rfcomm_check_connection(struct rfcomm_session *s)
 
 	BT_DBG("%p state %ld", s, s->state);
 
-	switch(sk->sk_state) {
+	switch (sk->sk_state) {
 	case BT_CONNECTED:
 		s->state = BT_CONNECT;
 
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 0207bd6..66cc1f0 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -45,7 +45,7 @@
 #include <net/sock.h>
 
 #include <asm/system.h>
-#include <asm/uaccess.h>
+#include <linux/uaccess.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -888,7 +888,8 @@ static int rfcomm_sock_shutdown(struct socket *sock, int how)
 
 	BT_DBG("sock %p, sk %p", sock, sk);
 
-	if (!sk) return 0;
+	if (!sk)
+		return 0;
 
 	lock_sock(sk);
 	if (!sk->sk_shutdown) {
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
index a9b81f5..2575c2d 100644
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -58,9 +58,9 @@ struct rfcomm_dev {
 
 	bdaddr_t		src;
 	bdaddr_t		dst;
-	u8 			channel;
+	u8			channel;
 
-	uint 			modem_status;
+	uint			modem_status;
 
 	struct rfcomm_dlc	*dlc;
 	struct tty_struct	*tty;
@@ -69,7 +69,7 @@ struct rfcomm_dev {
 
 	struct device		*tty_dev;
 
-	atomic_t 		wmem_alloc;
+	atomic_t		wmem_alloc;
 
 	struct sk_buff_head	pending;
 };
@@ -431,7 +431,8 @@ static int rfcomm_release_dev(void __user *arg)
 
 	BT_DBG("dev_id %d flags 0x%x", req.dev_id, req.flags);
 
-	if (!(dev = rfcomm_dev_get(req.dev_id)))
+	dev = rfcomm_dev_get(req.dev_id);
+	if (!dev)
 		return -ENODEV;
 
 	if (dev->flags != NOCAP_FLAGS && !capable(CAP_NET_ADMIN)) {
@@ -470,7 +471,8 @@ static int rfcomm_get_dev_list(void __user *arg)
 
 	size = sizeof(*dl) + dev_num * sizeof(*di);
 
-	if (!(dl = kmalloc(size, GFP_KERNEL)))
+	dl = kmalloc(size, GFP_KERNEL);
+	if (!dl)
 		return -ENOMEM;
 
 	di = dl->dev_info;
@@ -513,7 +515,8 @@ static int rfcomm_get_dev_info(void __user *arg)
 	if (copy_from_user(&di, arg, sizeof(di)))
 		return -EFAULT;
 
-	if (!(dev = rfcomm_dev_get(di.id)))
+	dev = rfcomm_dev_get(di.id);
+	if (!dev)
 		return -ENODEV;
 
 	di.flags   = dev->flags;
@@ -561,7 +564,8 @@ static void rfcomm_dev_data_ready(struct rfcomm_dlc *dlc, struct sk_buff *skb)
 		return;
 	}
 
-	if (!(tty = dev->tty) || !skb_queue_empty(&dev->pending)) {
+	tty = dev->tty;
+	if (!tty || !skb_queue_empty(&dev->pending)) {
 		skb_queue_tail(&dev->pending, skb);
 		return;
 	}
@@ -796,7 +800,8 @@ static int rfcomm_tty_write(struct tty_struct *tty, const unsigned char *buf, in
 
 		memcpy(skb_put(skb, size), buf + sent, size);
 
-		if ((err = rfcomm_dlc_send(dlc, skb)) < 0) {
+		err = rfcomm_dlc_send(dlc, skb);
+		if (err < 0) {
 			kfree_skb(skb);
 			break;
 		}
@@ -892,7 +897,7 @@ static void rfcomm_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
 
 	/* Parity on/off and when on, odd/even */
 	if (((old->c_cflag & PARENB) != (new->c_cflag & PARENB)) ||
-			((old->c_cflag & PARODD) != (new->c_cflag & PARODD)) ) {
+			((old->c_cflag & PARODD) != (new->c_cflag & PARODD))) {
 		changes |= RFCOMM_RPN_PM_PARITY;
 		BT_DBG("Parity change detected.");
 	}
@@ -937,11 +942,10 @@ static void rfcomm_tty_set_termios(struct tty_struct *tty, struct ktermios *old)
 	/* POSIX does not support 1.5 stop bits and RFCOMM does not
 	 * support 2 stop bits. So a request for 2 stop bits gets
 	 * translated to 1.5 stop bits */
-	if (new->c_cflag & CSTOPB) {
+	if (new->c_cflag & CSTOPB)
 		stop_bits = RFCOMM_RPN_STOP_15;
-	} else {
+	else
 		stop_bits = RFCOMM_RPN_STOP_1;
-	}
 
 	/* Handle number of data bits [5-8] */
 	if ((old->c_cflag & CSIZE) != (new->c_cflag & CSIZE))
-- 
1.7.1

