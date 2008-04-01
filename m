Return-Path: <cyrus@holtmann.org>
Message-ID: <47F25B30.8050108@access-company.com>
Date: Tue, 01 Apr 2008 17:56:32 +0200
From: Frederic Danis <frederic.danis@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <47EA7502.0@access-company.com>
In-Reply-To: <47EA7502.0@access-company.com>
Content-Type: multipart/mixed; boundary="------------080708050209040001040204"
Subject: Re: [Bluez-devel] HID certification using PTS
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080708050209040001040204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

> - when kernel (2.6.22) receives a VIRTUAL_CABLE_UNPLUG from PTS (tests 
> TC_HOS_HCR_BV_02_I and TC_HOS_HCR_BV_04_I) it does not close the L2CAP 
> channels as PTS waits for.
> I take a look in 2.6.22 sources, and it seems to me this disconnection 
> should happen, am I right ?
> Is it fixed in later kernel ?

Regarding this problem I wrote a patch in kernel that allows to poll the HIDP control socket and set it to IO_HUP when receiving the virtual cable unplug command.
I update the input service to watch the HIDP control socket and close l2cap sockets if IO_HUP is set on HIDP control socket.

Is it OK ?

Regards

Fred

-- 
-----------------------------------------------
It is not by improving the oil lamp that one invents the electric bulb!
-----------------------------------------------
Danis Frederic                   Access Company
Software engineer
Mail : mailto:frederic.danis@access-company.com
-----------------------------------------------

--------------080708050209040001040204
Content-Type: text/x-patch;
 name="hidp_socket.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hidp_socket.patch"

diff -Naur linux-2.6.24.4/net/bluetooth/hidp.orig/core.c linux-2.6.24.4/net/bluetooth/hidp/core.c
--- linux-2.6.24.4/net/bluetooth/hidp.orig/core.c	2008-03-24 19:49:18.000000000 +0100
+++ linux-2.6.24.4/net/bluetooth/hidp/core.c	2008-04-01 11:14:05.000000000 +0200
@@ -378,8 +378,12 @@
 		skb_queue_purge(&session->ctrl_transmit);
 		skb_queue_purge(&session->intr_transmit);
 
+		if (session->hidp_sock)
+			session->hidp_sock->sk->sk_shutdown = SHUTDOWN_MASK;
+
 		/* Kill session thread */
 		atomic_inc(&session->terminate);
+		hidp_schedule(session);
 		break;
 
 	case HIDP_CTRL_HARD_RESET:
@@ -743,7 +747,7 @@
 		hid->claimed |= HID_CLAIMED_INPUT;
 }
 
-int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock, struct socket *intr_sock)
+int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock, struct socket *intr_sock, struct socket *hidp_sock)
 {
 	struct hidp_session *session, *s;
 	int err;
@@ -809,6 +813,7 @@
 
 	session->ctrl_sock = ctrl_sock;
 	session->intr_sock = intr_sock;
+	session->hidp_sock = hidp_sock;
 	session->state     = BT_CONNECTED;
 
 	init_timer(&session->timer);
@@ -952,6 +957,24 @@
 	return err;
 }
 
+void hidp_remove_hidp_sock_ref(struct socket *hidp_sock)
+{
+	struct list_head *p;
+
+	down_read(&hidp_session_sem);
+
+	list_for_each(p, &hidp_session_list) {
+		struct hidp_session *session;
+
+		session = list_entry(p, struct hidp_session, list);
+
+		if (session->hidp_sock == hidp_sock)
+			session->hidp_sock = NULL;
+	}
+
+	up_read(&hidp_session_sem);
+}
+
 static int __init hidp_init(void)
 {
 	l2cap_load();
diff -Naur linux-2.6.24.4/net/bluetooth/hidp.orig/hidp.h linux-2.6.24.4/net/bluetooth/hidp/hidp.h
--- linux-2.6.24.4/net/bluetooth/hidp.orig/hidp.h	2008-03-24 19:49:18.000000000 +0100
+++ linux-2.6.24.4/net/bluetooth/hidp/hidp.h	2008-04-01 11:14:33.000000000 +0200
@@ -117,10 +117,11 @@
 	struct hidp_conninfo __user *ci;
 };
 
-int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock, struct socket *intr_sock);
+int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock, struct socket *intr_sock, struct socket *hidp_sock);
 int hidp_del_connection(struct hidp_conndel_req *req);
 int hidp_get_connlist(struct hidp_connlist_req *req);
 int hidp_get_conninfo(struct hidp_conninfo *ci);
+void hidp_remove_hidp_sock_ref(struct socket *hidp_sock);
 
 /* HIDP session defines */
 struct hidp_session {
@@ -128,6 +129,7 @@
 
 	struct socket *ctrl_sock;
 	struct socket *intr_sock;
+	struct socket *hidp_sock;
 
 	bdaddr_t bdaddr;
 
diff -Naur linux-2.6.24.4/net/bluetooth/hidp.orig/sock.c linux-2.6.24.4/net/bluetooth/hidp/sock.c
--- linux-2.6.24.4/net/bluetooth/hidp.orig/sock.c	2008-03-24 19:49:18.000000000 +0100
+++ linux-2.6.24.4/net/bluetooth/hidp/sock.c	2008-04-01 11:15:33.000000000 +0200
@@ -56,6 +56,8 @@
 	sock_orphan(sk);
 	sock_put(sk);
 
+	hidp_remove_hidp_sock_ref(sock);
+
 	return 0;
 }
 
@@ -96,7 +98,7 @@
 			return -EBADFD;
 		}
 
-		err = hidp_add_connection(&ca, csock, isock);
+		err = hidp_add_connection(&ca, csock, isock, sock);
 		if (!err) {
 			if (copy_to_user(argp, &ca, sizeof(ca)))
 				err = -EFAULT;
@@ -229,7 +231,7 @@
 	.getname	= sock_no_getname,
 	.sendmsg	= sock_no_sendmsg,
 	.recvmsg	= sock_no_recvmsg,
-	.poll		= sock_no_poll,
+	.poll		= bt_sock_poll,
 	.listen		= sock_no_listen,
 	.shutdown	= sock_no_shutdown,
 	.setsockopt	= sock_no_setsockopt,

--------------080708050209040001040204
Content-Type: text/x-patch;
 name="virtual_cable_unplug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="virtual_cable_unplug.patch"

Index: device.c
===================================================================
RCS file: /cvsroot/bluez/utils/input/device.c,v
retrieving revision 1.71
diff -a -u -r1.71 device.c
--- device.c	14 Mar 2008 18:44:00 -0000	1.71
+++ device.c	1 Apr 2008 15:42:26 -0000
@@ -78,8 +78,10 @@
 	char			*path;
 	int			ctrl_sk;
 	int			intr_sk;
+	int			hidp_sk;
 	guint			ctrl_watch;
 	guint			intr_watch;
+	guint			hidp_watch;
 };
 
 GSList *devices = NULL;
@@ -524,8 +526,10 @@
 			DBUS_TYPE_INVALID);
 
 	g_source_remove(idev->ctrl_watch);
+	g_source_remove(idev->hidp_watch);
 	idev->ctrl_watch = 0;
 	idev->intr_watch = 0;
+	idev->hidp_watch = 0;
 
 	/* Close control channel */
 	if (idev->ctrl_sk > 0) {
@@ -533,6 +537,12 @@
 		idev->ctrl_sk = -1;
 	}
 
+	/* Close hidp channel */
+	if (idev->hidp_sk > 0) {
+		close(idev->hidp_sk);
+		idev->hidp_sk = -1;
+	}
+
 	return FALSE;
 
 }
@@ -551,8 +561,10 @@
 			DBUS_TYPE_INVALID);
 
 	g_source_remove(idev->intr_watch);
+	g_source_remove(idev->hidp_watch);
 	idev->intr_watch = 0;
 	idev->ctrl_watch = 0;
+	idev->hidp_watch = 0;
 
 	/* Close interrupt channel */
 	if (idev->intr_sk > 0) {
@@ -560,6 +572,47 @@
 		idev->intr_sk = -1;
 	}
 
+	/* Close hidp channel */
+	if (idev->hidp_sk > 0) {
+		close(idev->hidp_sk);
+		idev->hidp_sk = -1;
+	}
+
+	return FALSE;
+}
+
+static gboolean hidp_watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
+{
+	struct device *idev = data;
+
+	if (cond & (G_IO_HUP | G_IO_ERR)) {
+		g_io_channel_close(chan);
+	}
+
+	dbus_connection_emit_signal(idev->conn,
+			idev->path,
+			INPUT_DEVICE_INTERFACE,
+			"Disconnected",
+			DBUS_TYPE_INVALID);
+
+	g_source_remove(idev->intr_watch);
+	g_source_remove(idev->ctrl_watch);
+	idev->intr_watch = 0;
+	idev->ctrl_watch = 0;
+	idev->hidp_watch = 0;
+
+	/* Close interrupt channel */
+	if (idev->intr_sk > 0) {
+		close(idev->intr_sk);
+		idev->intr_sk = -1;
+	}
+
+	/* Close control channel */
+	if (idev->ctrl_sk > 0) {
+		close(idev->ctrl_sk);
+		idev->ctrl_sk = -1;
+	}
+
 	return FALSE;
 }
 
@@ -620,12 +673,10 @@
 
 	err = ioctl(ctl, HIDPCONNADD, &req);
 cleanup:
-	close(ctl);
-
 	if (req.rd_data)
 		free(req.rd_data);
 
-	return err;
+	return ctl;
 }
 
 static gboolean interrupt_connect_cb(GIOChannel *chan,
@@ -663,13 +714,14 @@
 	}
 
 	idev->intr_sk = isk;
-	err = hidp_connadd(&idev->src, &idev->dst,
+	idev->hidp_sk = hidp_connadd(&idev->src, &idev->dst,
 			idev->ctrl_sk, idev->intr_sk, idev->name);
-	if (err < 0)
+	if (idev->hidp_sk < 0)
 		goto failed;
 
 	idev->intr_watch = create_watch(idev->intr_sk, intr_watch_cb, idev);
 	idev->ctrl_watch = create_watch(idev->ctrl_sk, ctrl_watch_cb, idev);
+	idev->hidp_watch = create_watch(idev->hidp_sk, hidp_watch_cb, idev);
 	dbus_connection_emit_signal(idev->conn,
 			idev->path,
 			INPUT_DEVICE_INTERFACE,
@@ -802,10 +854,15 @@
 		idev->intr_sk = -1;
 	}
 
-	ctl = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HIDP);
-	if (ctl < 0) {
-		error("Can't open HIDP control socket");
-		return -errno;
+	if (idev->hidp_sk >= 0) {
+		ctl = idev->hidp_sk;
+		idev->hidp_sk = -1;
+	} else {
+		ctl = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HIDP);
+		if (ctl < 0) {
+			error("Can't open HIDP control socket");
+			return -errno;
+		}
 	}
 
 	memset(&ci, 0, sizeof(ci));
@@ -1181,6 +1238,9 @@
 	 * to access the D-Bus data assigned to this path
 	 * because the object path data was destroyed.
 	 */
+	if (idev->hidp_watch)
+		g_source_remove(idev->hidp_watch);
+
 	if (idev->ctrl_watch)
 		g_source_remove(idev->ctrl_watch);
 
@@ -1364,8 +1424,15 @@
 		fake->disconnect = fake_hid_disconnect;
 		fake->priv = fake_hid;
 		err = fake_hid_connadd(fake, idev->intr_sk, fake_hid);
-	} else
-		err = hidp_connadd(src, dst, idev->ctrl_sk, idev->intr_sk, idev->name);
+	} else {
+		idev->hidp_sk = hidp_connadd(src, dst, idev->ctrl_sk, idev->intr_sk, idev->name);
+		if (idev->hidp_sk < 0) {
+			err = idev->hidp_sk;
+		} else {
+			err = 0;
+			idev->hidp_watch = create_watch(idev->hidp_sk, hidp_watch_cb, idev);
+		}
+	}
 	if (err < 0)
 		goto error;
 

--------------080708050209040001040204
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--------------080708050209040001040204
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------080708050209040001040204--
