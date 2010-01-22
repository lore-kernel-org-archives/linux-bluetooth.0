Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Fix hidp_parse using invalid user-space memory
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-ghTqf5lYH+JoXWPj4ZT2"
Date: Fri, 22 Jan 2010 11:03:46 +0000
Message-ID: <1264158226.30904.1.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-ghTqf5lYH+JoXWPj4ZT2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Heya,

As discussed on IRC, saw that there was a problem with report parsing
using the invalid user-space memory.

The patch below fixes this but the code in the ioctl handler is a bit
gruesome, ideas welcome.

A similar fix needs to be applied to the compat ioctl code as well.

Cheers

--=-ghTqf5lYH+JoXWPj4ZT2
Content-Disposition: attachment; filename="0001-Fix-hidp_parse-using-invalid-user-space-memory.patch"
Content-Type: text/x-patch; name="0001-Fix-hidp_parse-using-invalid-user-space-memory.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From c0a8ea435f17d235d59570c1e29e9d2ac66857d9 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Fri, 22 Jan 2010 10:57:27 +0000
Subject: [PATCH] Fix hidp_parse using invalid user-space memory

When connecting to a Bluetooth HID device, the report descriptor
is passed from user-space to kernel space. But due to recent changes
in the HID layer, the data is only copied and used (in hidp_parse())
after the HIDPCONNADD ioctl has returned.

This patch makes sure that the data is copied from user-space during
the ioctl call, and is freed after the call to hidp_parse().

Fixes intermittent Bluetooth HID connection failures.
---
 net/bluetooth/hidp/core.c |   35 ++++++++++++++++++++++++-----------
 net/bluetooth/hidp/sock.c |    9 ++++++++-
 2 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 40879ed..05a4016 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -704,25 +704,20 @@ static int hidp_parse(struct hid_device *hid)
 {
 	struct hidp_session *session = hid->driver_data;
 	struct hidp_connadd_req *req = session->req;
-	unsigned char *buf;
 	int ret;
 
-	buf = kmalloc(req->rd_size, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	if (copy_from_user(buf, req->rd_data, req->rd_size)) {
-		kfree(buf);
-		return -EFAULT;
+	if (!req->rd_data) {
+		printk(KERN_WARNING "hidp_parse() called with a report\n");
+		return -EINVAL;
 	}
 
-	ret = hid_parse_report(session->hid, buf, req->rd_size);
-
-	kfree(buf);
+	ret = hid_parse_report(session->hid, req->rd_data, req->rd_size);
 
 	if (ret)
 		return ret;
 
+	kfree(req->rd_data);
+
 	session->req = NULL;
 
 	return 0;
@@ -812,6 +807,7 @@ failed:
 int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock, struct socket *intr_sock)
 {
 	struct hidp_session *session, *s;
+	unsigned char *buf;
 	int err;
 
 	BT_DBG("");
@@ -828,6 +824,8 @@ int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock,
 
 	down_write(&hidp_session_sem);
 
+	buf = NULL;
+
 	s = __hidp_get_session(&bt_sk(ctrl_sock->sk)->dst);
 	if (s && s->state == BT_CONNECTED) {
 		err = -EEXIST;
@@ -854,9 +852,22 @@ int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock,
 	session->idle_to = req->idle_to;
 
 	if (req->rd_size > 0) {
+		buf = kmalloc(req->rd_size, GFP_KERNEL);
+		if (!buf) {
+			err = -ENOMEM;
+			goto purge;
+		}
+		if (copy_from_user(buf, req->rd_data, req->rd_size)) {
+			err = -EFAULT;
+			goto purge;
+		}
+		req->rd_data = buf;
+
 		err = hidp_setup_hid(session, req);
 		if (err && err != -ENODEV)
 			goto purge;
+	} else {
+		req->rd_data = NULL;
 	}
 
 	if (!session->hid) {
@@ -901,6 +912,8 @@ unlink:
 	}
 
 purge:
+	if (buf)
+		kfree(buf);
 	skb_queue_purge(&session->ctrl_transmit);
 	skb_queue_purge(&session->intr_transmit);
 
diff --git a/net/bluetooth/hidp/sock.c b/net/bluetooth/hidp/sock.c
index 9cfef68..7151a34 100644
--- a/net/bluetooth/hidp/sock.c
+++ b/net/bluetooth/hidp/sock.c
@@ -63,6 +63,7 @@ static int hidp_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long
 	struct hidp_conninfo ci;
 	struct socket *csock;
 	struct socket *isock;
+	__u8 *rd_data_user, *rd_data_kernel;
 	int err;
 
 	BT_DBG("cmd %x arg %lx", cmd, arg);
@@ -74,6 +75,7 @@ static int hidp_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long
 
 		if (copy_from_user(&ca, argp, sizeof(ca)))
 			return -EFAULT;
+		rd_data_user = ca.rd_data;
 
 		csock = sockfd_lookup(ca.ctrl_sock, &err);
 		if (!csock)
@@ -93,13 +95,18 @@ static int hidp_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long
 
 		err = hidp_add_connection(&ca, csock, isock);
 		if (!err) {
+			/* Save the kernel address for rd_data,
+			 * and set the original user space address back */
+			rd_data_kernel = ca.rd_data;
+			ca.rd_data = rd_data_user;
 			if (copy_to_user(argp, &ca, sizeof(ca)))
 				err = -EFAULT;
+			/* And set the kernel address back again for us to use */
+			ca.rd_data = rd_data_kernel;
 		} else {
 			sockfd_put(csock);
 			sockfd_put(isock);
 		}
-
 		return err;
 
 	case HIDPCONNDEL:
-- 
1.6.6


--=-ghTqf5lYH+JoXWPj4ZT2--

