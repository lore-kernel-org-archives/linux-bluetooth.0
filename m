Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <451664EC.6070603@brainhub.org>
Date: Sun, 24 Sep 2006 03:58:52 -0700
From: Andrey Jivsov <andrey@brainhub.org>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="------------030806010102020705000905"
Subject: [Bluez-devel] Microsoft IntelliMouse with kernel 2.6.18 and
 patch-2.6.18-mh1 is broken (fix provided)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------030806010102020705000905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I was happily running older version of kernel patch, I believe 
patch-2.6.15-mh2, which allowed me to enable additional buttons on 
Microsoft IntelliMouse Explorer for Bluetooth.

The only issues that I could not solve satisfactory is resumption from 
sleep, initial boot, and timeout, requiring me to reset the mouse every 
time by pressing small button on its bottom.

I decided to give a try to the latest kernel 2.6.18 with Fedora Core 5 
and patch-2.6.18-mh1 with latest bluez tools. The start was promising: 
unpatched kernel 2.6.18 with FC5 and bluez 2.25 enables IntelliMouse via 
Boot protocol with the resumption from sleep working! This is an 
improvement from earlier versions. This doesn't brong the closure, 
though, because the boot protocol lacks the support for scroll wheel and 
additional buttons.

So I upgraded to bluez 3.5 but this didn't make any difference.

I then patched the kernel with patch-2.6.18-mh1. This killed the mouse: 
the cursor would not move.

After many hours I finally was able to solve the problem by using the 
previous patch-2.6.15-mh2 against the 2.6.18 kernel. I am attaching that 
patch. Note that it will produce a few harmless warnings.

The good news is that this is the configuration that enables fully 
functional IntelliMouse.

Here is the rest of steps needed to fix the resumption from the sleep.

* set this in the rc.local:

     /usr/local/sbin/hcid
     /usr/local/bin/hidd -t 10 --connect 00:50:F2:E8:E0:71 --server
     /usr/local/sbin/hciconfig hci0 down
     usleep 500000
     /usr/local/sbin/hciconfig hci0 up


* Set this in the "sleep script":
    before sleep:
     /usr/local/bin/hidd --killall
     echo disable > /proc/acpi/ibm/bluetooth
     /sbin/rmmod hci_usb

   after sleep:
     /sbin/modprobe hci_usb
     echo enable > /proc/acpi/ibm/bluetooth

Sleep steps above may not be needed at all with your hardware and 
distribution.

Many people suggested to use "hidd --connect 00:50:F2:E8:E0:71" alone. 
It never work for me. hciconfig hci0 down/up made the difference.

I hope this helps.


--------------030806010102020705000905
Content-Type: text/plain;
 name="patch-2.6.18-mh1aj"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.6.18-mh1aj"

diff -ur --exclude-from=kernel-diff-exclude.txt linux-2.6.16.20-original/include/net/bluetooth/l2cap.h linux-2.6.16.20/include/net/bluetooth/l2cap.h
--- linux-2.6.16.20-original/include/net/bluetooth/l2cap.h	2006-06-05 10:18:23.000000000 -0700
+++ linux-2.6.16.20/include/net/bluetooth/l2cap.h	2006-06-09 16:29:48.000000000 -0700
@@ -76,32 +76,32 @@
 
 /* L2CAP structures */
 struct l2cap_hdr {
-	__u16      len;
-	__u16      cid;
+	__le16     len;
+	__le16     cid;
 } __attribute__ ((packed));
 #define L2CAP_HDR_SIZE		4
 
 struct l2cap_cmd_hdr {
 	__u8       code;
 	__u8       ident;
-	__u16      len;
+	__le16     len;
 } __attribute__ ((packed));
 #define L2CAP_CMD_HDR_SIZE	4
 
 struct l2cap_cmd_rej {
-	__u16      reason;
+	__le16     reason;
 } __attribute__ ((packed));
 
 struct l2cap_conn_req {
-	__u16      psm;
-	__u16      scid;
+	__le16     psm;
+	__le16     scid;
 } __attribute__ ((packed));
 
 struct l2cap_conn_rsp {
-	__u16      dcid;
-	__u16      scid;
-	__u16      result;
-	__u16      status;
+	__le16     dcid;
+	__le16     scid;
+	__le16     result;
+	__le16     status;
 } __attribute__ ((packed));
 
 /* connect result */
@@ -117,15 +117,15 @@
 #define L2CAP_CS_AUTHOR_PEND  0x0002
 
 struct l2cap_conf_req {
-	__u16      dcid;
-	__u16      flags;
+	__le16     dcid;
+	__le16     flags;
 	__u8       data[0];
 } __attribute__ ((packed));
 
 struct l2cap_conf_rsp {
-	__u16      scid;
-	__u16      flags;
-	__u16      result;
+	__le16     scid;
+	__le16     flags;
+	__le16     result;
 	__u8       data[0];
 } __attribute__ ((packed));
 
@@ -147,23 +147,23 @@
 #define L2CAP_CONF_MAX_SIZE	22
 
 struct l2cap_disconn_req {
-	__u16      dcid;
-	__u16      scid;
+	__le16     dcid;
+	__le16     scid;
 } __attribute__ ((packed));
 
 struct l2cap_disconn_rsp {
-	__u16      dcid;
-	__u16      scid;
+	__le16     dcid;
+	__le16     scid;
 } __attribute__ ((packed));
 
 struct l2cap_info_req {
-	__u16       type;
+	__le16      type;
 	__u8        data[0];
 } __attribute__ ((packed));
 
 struct l2cap_info_rsp {
-	__u16       type;
-	__u16       result;
+	__le16      type;
+	__le16      result;
 	__u8        data[0];
 } __attribute__ ((packed));
 
@@ -205,7 +205,8 @@
 
 struct l2cap_pinfo {
 	struct bt_sock	bt;
-	__u16		psm;
+	__le16		psm;
+	__le16		sport;
 	__u16		dcid;
 	__u16		scid;
 
@@ -221,8 +222,6 @@
 
 	__u8		ident;
 
-	__u16		sport;
-
 	struct l2cap_conn	*conn;
 	struct sock		*next_c;
 	struct sock		*prev_c;
Only in linux-2.6.16.20/: Module.symvers
diff -ur --exclude-from=kernel-diff-exclude.txt linux-2.6.16.20-original/net/bluetooth/bnep/bnep.h linux-2.6.16.20/net/bluetooth/bnep/bnep.h
--- linux-2.6.16.20-original/net/bluetooth/bnep/bnep.h	2006-06-05 10:18:23.000000000 -0700
+++ linux-2.6.16.20/net/bluetooth/bnep/bnep.h	2006-06-09 16:29:48.000000000 -0700
@@ -86,29 +86,29 @@
 #define BNEP_EXT_HEADER	 0x80
 
 struct bnep_setup_conn_req {
-	__u8  type;
-	__u8  ctrl;
-	__u8  uuid_size;
-	__u8  service[0];
+	__u8   type;
+	__u8   ctrl;
+	__u8   uuid_size;
+	__u8   service[0];
 } __attribute__((packed));
 
 struct bnep_set_filter_req {
-	__u8  type;
-	__u8  ctrl;
-	__u16 len;
-	__u8  list[0];
+	__u8   type;
+	__u8   ctrl;
+	__le16 len;
+	__u8   list[0];
 } __attribute__((packed));
 
 struct bnep_control_rsp {
-	__u8  type;
-	__u8  ctrl;
-	__u16 resp;
+	__u8   type;
+	__u8   ctrl;
+	__le16 resp;
 } __attribute__((packed));
 
 struct bnep_ext_hdr {
-	__u8  type;
-	__u8  len;
-	__u8  data[0];
+	__u8   type;
+	__u8   len;
+	__u8   data[0];
 } __attribute__((packed));
 
 /* BNEP ioctl defines */
diff -ur --exclude-from=kernel-diff-exclude.txt linux-2.6.16.20-original/net/bluetooth/hidp/core.c linux-2.6.16.20/net/bluetooth/hidp/core.c
--- linux-2.6.16.20-original/net/bluetooth/hidp/core.c	2006-06-05 10:18:23.000000000 -0700
+++ linux-2.6.16.20/net/bluetooth/hidp/core.c	2006-06-09 16:29:48.000000000 -0700
@@ -39,6 +39,7 @@
 #include <net/sock.h>
 
 #include <linux/input.h>
+#include "hid.h"
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/l2cap.h>
@@ -50,7 +51,7 @@
 #define BT_DBG(D...)
 #endif
 
-#define VERSION "1.1"
+#define VERSION "1.1-mh1"
 
 static DECLARE_RWSEM(hidp_session_sem);
 static LIST_HEAD(hidp_session_list);
@@ -124,6 +125,13 @@
 		else
 			strncpy(ci->name, "HID Boot Device", 128);
 	}
+
+	if (session->hid) {
+		ci->vendor  = session->hid->vendor;
+		ci->product = session->hid->product;
+		ci->version = session->hid->version;
+		strncpy(ci->name, session->hid->name, 128);
+	}
 }
 
 static int hidp_input_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
@@ -219,6 +227,29 @@
 	input_sync(dev);
 }
 
+static int hid_send_report(struct hid_device *device, unsigned char *data, int size)
+{
+	struct hidp_session *session = device->driver_data;
+	struct sk_buff *skb;
+
+	BT_DBG("session %p hid %p data %p size %d", session, device, data, size);
+
+	if (!(skb = alloc_skb(size + 1, GFP_ATOMIC))) {
+		BT_ERR("Can't allocate memory for new frame");
+		return -ENOMEM;
+	}
+
+	*skb_put(skb, 1) = 0xa2;
+	if (size > 0)
+		memcpy(skb_put(skb, size), data, size);
+
+	skb_queue_tail(&session->intr_transmit, skb);
+
+	hidp_schedule(session);
+
+	return 0;
+}
+
 static void hidp_idle_timeout(unsigned long arg)
 {
 	struct hidp_session *session = (struct hidp_session *) arg;
@@ -406,6 +437,9 @@
 		hidp_set_timer(session);
 		if (session->input)
 			hidp_input_report(session, skb);
+
+		if (session->hid)
+			hid_recv_report(session->hid, HID_INPUT_REPORT, skb->data, skb->len);
 	} else {
 		BT_DBG("Unsupported protocol header 0x%02x", hdr);
 	}
@@ -471,6 +505,11 @@
 		product = session->input->id.product;
 	}
 
+	if (session->hid) {
+		vendor  = session->hid->vendor;
+		product = session->hid->product;
+	}
+
 	daemonize("khidpd_%04x%04x", vendor, product);
 	set_user_nice(current, -15);
 	current->flags |= PF_NOFREEZE;
@@ -523,6 +562,11 @@
 		session->input = NULL;
 	}
 
+	if (session->hid) {
+		hid_unregister_device(session->hid);
+		hid_free_device(session->hid);
+	}
+
 	up_write(&hidp_session_sem);
 
 	kfree(session);
@@ -572,6 +616,33 @@
 	input_register_device(input);
 }
 
+static inline void hidp_setup_hid(struct hidp_session *session, struct hidp_connadd_req *req)
+{
+	struct hid_device *hid = session->hid;
+	bdaddr_t src, dst;
+
+	baswap(&src, &bt_sk(session->ctrl_sock->sk)->src);
+	baswap(&dst, &bt_sk(session->ctrl_sock->sk)->dst);
+
+	hid->driver_data = session;
+
+	hid->parser_version = req->parser;
+	hid->country_code   = req->country;
+
+	hid->bus     = BUS_BLUETOOTH;
+	hid->vendor  = req->vendor;
+	hid->product = req->product;
+	hid->version = req->version;
+
+	strncpy(hid->name, req->name, 128);
+	strncpy(hid->phys, batostr(&src), 64);
+	strncpy(hid->uniq, batostr(&dst), 64);
+
+	hid->send = hid_send_report;
+
+	hid_register_device(hid);
+}
+
 int hidp_add_connection(struct hidp_connadd_req *req, struct socket *ctrl_sock, struct socket *intr_sock)
 {
 	struct hidp_session *session, *s;
@@ -588,10 +659,30 @@
 		return -ENOMEM;
 	memset(session, 0, sizeof(struct hidp_session));
 
-	session->input = input_allocate_device();
-	if (!session->input) {
-		kfree(session);
-		return -ENOMEM;
+	if (req->rd_size > 0) {
+		unsigned char *buf = kmalloc(req->rd_size, GFP_KERNEL);
+
+		if (!buf) {
+			kfree(session);
+			return -ENOMEM;
+		}
+
+		if (copy_from_user(buf, req->rd_data, req->rd_size)) {
+			kfree(buf);
+			kfree(session);
+			return -EFAULT;
+		}
+
+		session->hid = hid_alloc_device(buf, req->rd_size);
+		kfree(buf);
+	}
+
+	if (!session->hid) {
+		session->input = input_allocate_device();
+		if (!session->input) {
+			kfree(session);
+			return -EBADR;
+		}
 	}
 
 	down_write(&hidp_session_sem);
@@ -627,6 +718,9 @@
 	if (session->input)
 		hidp_setup_input(session, req);
 
+	if (session->hid)
+		hidp_setup_hid(session, req);
+
 	__hidp_link_session(session);
 
 	hidp_set_timer(session);
@@ -660,6 +754,9 @@
 failed:
 	up_write(&hidp_session_sem);
 
+	if (session->hid)
+		hid_free_device(session->hid);
+
 	kfree(session->input);
 	kfree(session);
 	return err;
Only in linux-2.6.16.20/net/bluetooth/hidp: hid.c
Only in linux-2.6.16.20/net/bluetooth/hidp: hid.h
diff -ur --exclude-from=kernel-diff-exclude.txt linux-2.6.16.20-original/net/bluetooth/hidp/hidp.h linux-2.6.16.20/net/bluetooth/hidp/hidp.h
--- linux-2.6.16.20-original/net/bluetooth/hidp/hidp.h	2006-06-05 10:18:23.000000000 -0700
+++ linux-2.6.16.20/net/bluetooth/hidp/hidp.h	2006-06-09 16:29:48.000000000 -0700
@@ -86,7 +86,7 @@
 	int   intr_sock;	// Connteted interrupt socket
 	__u16 parser;
 	__u16 rd_size;
-	__u8 *rd_data;
+	__u8  __user *rd_data;
 	__u8  country;
 	__u8  subclass;
 	__u16 vendor;
@@ -143,7 +143,8 @@
 	unsigned char keys[8];
 	unsigned char leds;
 
-	struct input_dev *input;
+	struct input_dev  *input;
+	struct hid_device *hid;
 
 	struct timer_list timer;
 
diff -ur --exclude-from=kernel-diff-exclude.txt linux-2.6.16.20-original/net/bluetooth/hidp/Makefile linux-2.6.16.20/net/bluetooth/hidp/Makefile
--- linux-2.6.16.20-original/net/bluetooth/hidp/Makefile	2006-06-05 10:18:23.000000000 -0700
+++ linux-2.6.16.20/net/bluetooth/hidp/Makefile	2006-06-09 16:29:48.000000000 -0700
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_BT_HIDP) += hidp.o
 
-hidp-objs := core.o sock.o
+hidp-objs := core.o sock.o hid.o
diff -ur --exclude-from=kernel-diff-exclude.txt linux-2.6.16.20-original/net/bluetooth/l2cap.c linux-2.6.16.20/net/bluetooth/l2cap.c
--- linux-2.6.16.20-original/net/bluetooth/l2cap.c	2006-06-05 10:18:23.000000000 -0700
+++ linux-2.6.16.20/net/bluetooth/l2cap.c	2006-06-09 16:29:48.000000000 -0700
@@ -213,7 +213,8 @@
 	struct sock *sk;
 	struct hlist_node *node;
 	sk_for_each(sk, node, &l2cap_sk_list.head)
-		if (l2cap_pi(sk)->sport == psm && !bacmp(&bt_sk(sk)->src, src))
+		if (l2cap_pi(sk)->sport == (__le16 __force) psm &&
+				!bacmp(&bt_sk(sk)->src, src))
 			goto found;
 	sk = NULL;
 found:
@@ -232,7 +233,7 @@
 		if (state && sk->sk_state != state)
 			continue;
 
-		if (l2cap_pi(sk)->psm == psm) {
+		if (l2cap_pi(sk)->psm == (__le16 __force) psm) {
 			/* Exact match. */
 			if (!bacmp(&bt_sk(sk)->src, src))
 				break;
@@ -447,8 +448,8 @@
 	} else {
 		/* Save source address */
 		bacpy(&bt_sk(sk)->src, &la->l2_bdaddr);
-		l2cap_pi(sk)->psm   = la->l2_psm;
-		l2cap_pi(sk)->sport = la->l2_psm;
+		l2cap_pi(sk)->psm   = (__le16 __force) la->l2_psm;
+		l2cap_pi(sk)->sport = (__le16 __force) la->l2_psm;
 		sk->sk_state = BT_BOUND;
 	}
 
@@ -560,7 +561,7 @@
 
 	/* Set destination address and psm */
 	bacpy(&bt_sk(sk)->dst, &la->l2_bdaddr);
-	l2cap_pi(sk)->psm = la->l2_psm;
+	l2cap_pi(sk)->psm = (__le16 __force) la->l2_psm;
 
 	if ((err = l2cap_do_connect(sk)))
 		goto done;
@@ -689,7 +690,7 @@
 	else
 		bacpy(&la->l2_bdaddr, &bt_sk(sk)->src);
 
-	la->l2_psm = l2cap_pi(sk)->psm;
+	la->l2_psm = (unsigned short __force) l2cap_pi(sk)->psm;
 	return 0;
 }
 
@@ -721,7 +722,7 @@
 	lh->len = __cpu_to_le16(len + (hlen - L2CAP_HDR_SIZE));
 
 	if (sk->sk_type == SOCK_DGRAM)
-		put_unaligned(l2cap_pi(sk)->psm, (u16 *) skb_put(skb, 2));
+		put_unaligned(l2cap_pi(sk)->psm, (__le16 *) skb_put(skb, 2));
 
 	if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count)) {
 		err = -EFAULT;
@@ -1248,15 +1249,15 @@
 
 	switch (opt->len) {
 	case 1:
-		*val = *((u8 *) opt->val);
+		*val = *((__u8 *) opt->val);
 		break;
 
 	case 2:
-		*val = __le16_to_cpu(*((u16 *)opt->val));
+		*val = __le16_to_cpu(*((__le16 *) opt->val));
 		break;
 
 	case 4:
-		*val = __le32_to_cpu(*((u32 *)opt->val));
+		*val = __le32_to_cpu(*((__le32 *) opt->val));
 		break;
 
 	default:
@@ -1268,7 +1269,7 @@
 	return len;
 }
 
-static inline void l2cap_parse_conf_req(struct sock *sk, void *data, int len)
+static inline void l2cap_parse_conf_req(struct sock *sk, void *data, u16 len)
 {
 	int type, hint, olen; 
 	unsigned long val;
@@ -1315,15 +1316,15 @@
 
 	switch (len) {
 	case 1:
-		*((u8 *) opt->val)  = val;
+		*((__u8 *) opt->val)  = val;
 		break;
 
 	case 2:
-		*((u16 *) opt->val) = __cpu_to_le16(val);
+		*((__le16 *) opt->val) = __cpu_to_le16(val);
 		break;
 
 	case 4:
-		*((u32 *) opt->val) = __cpu_to_le32(val);
+		*((__le32 *) opt->val) = __cpu_to_le32(val);
 		break;
 
 	default:
@@ -1402,12 +1403,12 @@
 	int result = 0, status = 0;
 
 	u16 dcid = 0, scid = __le16_to_cpu(req->scid);
-	u16 psm  = req->psm;
+	__le16 psm  = req->psm;
 
 	BT_DBG("psm 0x%2.2x scid 0x%4.4x", psm, scid);
 
 	/* Check if we have socket listening on psm */
-	parent = l2cap_get_sock_by_psm(BT_LISTEN, psm, conn->src);
+	parent = l2cap_get_sock_by_psm(BT_LISTEN, (u16 __force) psm, conn->src);
 	if (!parent) {
 		result = L2CAP_CR_BAD_PSM;
 		goto sendresp;
@@ -1529,7 +1530,7 @@
 static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u8 *data)
 {
 	struct l2cap_conf_req *req = (struct l2cap_conf_req *) data;
-	u16 dcid, flags;
+	u16 dcid, flags, cmd_len = __le16_to_cpu(cmd->len);
 	u8 rsp[64];
 	struct sock *sk;
 	int result;
@@ -1542,7 +1543,7 @@
 	if (!(sk = l2cap_get_chan_by_scid(&conn->chan_list, dcid)))
 		return -ENOENT;
 
-	l2cap_parse_conf_req(sk, req->data, cmd->len - sizeof(*req));
+	l2cap_parse_conf_req(sk, req->data, cmd_len - sizeof(*req));
 
 	if (flags & 0x0001) {
 		/* Incomplete config. Send empty response. */
@@ -1721,6 +1722,7 @@
 	u8 *data = skb->data;
 	int len = skb->len;
 	struct l2cap_cmd_hdr cmd;
+	u16 cmd_len;
 	int err = 0;
 
 	l2cap_raw_recv(conn, skb);
@@ -1730,11 +1732,11 @@
 		data += L2CAP_CMD_HDR_SIZE;
 		len  -= L2CAP_CMD_HDR_SIZE;
 
-		cmd.len = __le16_to_cpu(cmd.len);
+		cmd_len = __le16_to_cpu(cmd.len);
 
-		BT_DBG("code 0x%2.2x len %d id 0x%2.2x", cmd.code, cmd.len, cmd.ident);
+		BT_DBG("code 0x%2.2x len %d id 0x%2.2x", cmd.code, cmd_len, cmd.ident);
 
-		if (cmd.len > len || !cmd.ident) {
+		if (cmd_len > len || !cmd.ident) {
 			BT_DBG("corrupted command");
 			break;
 		}
@@ -1769,7 +1771,7 @@
 			break;
 
 		case L2CAP_ECHO_REQ:
-			l2cap_send_cmd(conn, cmd.ident, L2CAP_ECHO_RSP, cmd.len, data);
+			l2cap_send_cmd(conn, cmd.ident, L2CAP_ECHO_RSP, cmd_len, data);
 			break;
 
 		case L2CAP_ECHO_RSP:
@@ -1798,8 +1800,8 @@
 			l2cap_send_cmd(conn, cmd.ident, L2CAP_COMMAND_REJ, sizeof(rej), &rej);
 		}
 
-		data += cmd.len;
-		len  -= cmd.len;
+		data += cmd_len;
+		len  -= cmd_len;
 	}
 
 	kfree_skb(skb);

diff -uNr --exclude-from=kernel-diff-exclude.txt linux-2.6.16.20-original/net/bluetooth/hidp/hid.c linux-2.6.16.20/net/bluetooth/hidp/hid.c
--- linux-2.6.16.20-original/net/bluetooth/hidp/hid.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.16.20/net/bluetooth/hidp/hid.c	2006-06-09 23:06:08.000000000 -0700
@@ -0,0 +1,1686 @@
+/*
+ *
+ *  Human Interface Device driver (HID)
+ *
+ *  Copyright (C) 1999  Andreas Gal
+ *  Copyright (C) 2000-2001  Vojtech Pavlik <vojtech@suse.cz>
+ *  Copyright (C) 2003-2004  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/list.h>
+#include <asm/unaligned.h>
+#include <asm/byteorder.h>
+#include <linux/input.h>
+
+#include "hid.h"
+
+/* Applications from HID Usage Tables 4/8/99 Version 1.1 */
+/* We ignore a few input applications that are not widely used */
+#define IS_INPUT_APPLICATION(a) (((a >= 0x00010000) && (a <= 0x00010008)) || ( a == 0x00010080) || ( a == 0x000c0001))
+static void hidinput_hid_event(struct hid_device *, struct hid_field *, struct hid_usage *, __s32);
+static void hidinput_report_event(struct hid_device *hid, struct hid_report *report);
+
+/*
+ * Register a new report for a device.
+ */
+
+static struct hid_report *hid_register_report(struct hid_device *device, unsigned type, unsigned id)
+{
+	struct hid_report_enum *report_enum = device->report_enum + type;
+	struct hid_report *report;
+
+	if (report_enum->report_id_hash[id])
+		return report_enum->report_id_hash[id];
+
+	if (!(report = kmalloc(sizeof(struct hid_report), GFP_KERNEL)))
+		return NULL;
+	memset(report, 0, sizeof(struct hid_report));
+
+	if (id != 0)
+		report_enum->numbered = 1;
+
+	report->id = id;
+	report->type = type;
+	report->size = 0;
+	report->device = device;
+	report_enum->report_id_hash[id] = report;
+
+	list_add_tail(&report->list, &report_enum->report_list);
+
+	return report;
+}
+
+/*
+ * Register a new field for this report.
+ */
+
+static struct hid_field *hid_register_field(struct hid_report *report, unsigned usages, unsigned values)
+{
+	struct hid_field *field;
+
+	if (report->maxfield == HID_MAX_FIELDS) {
+		dbg("too many fields in report");
+		return NULL;
+	}
+
+	if (!(field = kmalloc(sizeof(struct hid_field) + usages * sizeof(struct hid_usage)
+		+ values * sizeof(unsigned), GFP_KERNEL))) return NULL;
+
+	memset(field, 0, sizeof(struct hid_field) + usages * sizeof(struct hid_usage)
+		+ values * sizeof(unsigned));
+
+	report->field[report->maxfield++] = field;
+	field->usage = (struct hid_usage *)(field + 1);
+	field->value = (unsigned *)(field->usage + usages);
+	field->report = report;
+
+	return field;
+}
+
+/*
+ * Open a collection. The type/usage is pushed on the stack.
+ */
+
+static int open_collection(struct hid_parser *parser, unsigned type)
+{
+	struct hid_collection *collection;
+	unsigned usage;
+
+	usage = parser->local.usage[0];
+
+	if (parser->collection_stack_ptr == HID_COLLECTION_STACK_SIZE) {
+		dbg("collection stack overflow");
+		return -1;
+	}
+
+	if (parser->device->maxcollection == parser->device->collection_size) {
+		collection = kmalloc(sizeof(struct hid_collection) *
+				     parser->device->collection_size * 2,
+				     GFP_KERNEL);
+		if (collection == NULL) {
+			dbg("failed to reallocate collection array");
+			return -1;
+		}
+		memcpy(collection, parser->device->collection,
+		       sizeof(struct hid_collection) *
+		       parser->device->collection_size);
+		memset(collection + parser->device->collection_size, 0,
+		       sizeof(struct hid_collection) *
+		       parser->device->collection_size);
+		kfree(parser->device->collection);
+		parser->device->collection = collection;
+		parser->device->collection_size *= 2;
+	}
+
+	parser->collection_stack[parser->collection_stack_ptr++] =
+		parser->device->maxcollection;
+
+	collection = parser->device->collection + 
+		parser->device->maxcollection++;
+	collection->type = type;
+	collection->usage = usage;
+	collection->level = parser->collection_stack_ptr - 1;
+	
+	if (type == HID_COLLECTION_APPLICATION)
+		parser->device->maxapplication++;
+
+	return 0;
+}
+
+/*
+ * Close a collection.
+ */
+
+static int close_collection(struct hid_parser *parser)
+{
+	if (!parser->collection_stack_ptr) {
+		dbg("collection stack underflow");
+		return -1;
+	}
+	parser->collection_stack_ptr--;
+	return 0;
+}
+
+/*
+ * Climb up the stack, search for the specified collection type
+ * and return the usage.
+ */
+
+static unsigned hid_lookup_collection(struct hid_parser *parser, unsigned type)
+{
+	int n;
+	for (n = parser->collection_stack_ptr - 1; n >= 0; n--)
+		if (parser->device->collection[parser->collection_stack[n]].type == type)
+			return parser->device->collection[parser->collection_stack[n]].usage;
+	return 0; /* we know nothing about this usage type */
+}
+
+/*
+ * Add a usage to the temporary parser table.
+ */
+
+static int hid_add_usage(struct hid_parser *parser, unsigned usage)
+{
+	if (parser->local.usage_index >= HID_MAX_USAGES) {
+		dbg("usage index exceeded");
+		return -1;
+	}
+	parser->local.usage[parser->local.usage_index] = usage;
+	parser->local.collection_index[parser->local.usage_index] =
+		parser->collection_stack_ptr ? 
+		parser->collection_stack[parser->collection_stack_ptr - 1] : 0;
+	parser->local.usage_index++;
+	return 0;
+}
+
+/*
+ * Register a new field for this report.
+ */
+
+static int hid_add_field(struct hid_parser *parser, unsigned report_type, unsigned flags)
+{
+	struct hid_report *report;
+	struct hid_field *field;
+	int usages;
+	unsigned offset;
+	int i;
+
+	if (!(report = hid_register_report(parser->device, report_type, parser->global.report_id))) {
+		dbg("hid_register_report failed");
+		return -1;
+	}
+
+	if (parser->global.logical_maximum < parser->global.logical_minimum) {
+		dbg("logical range invalid %d %d", parser->global.logical_minimum, parser->global.logical_maximum);
+		return -1;
+	}
+	usages = parser->local.usage_index;
+
+	offset = report->size;
+	report->size += parser->global.report_size * parser->global.report_count;
+
+	if (usages == 0)
+		return 0; /* ignore padding fields */
+
+	if ((field = hid_register_field(report, usages, parser->global.report_count)) == NULL)
+		return 0;
+
+	field->physical = hid_lookup_collection(parser, HID_COLLECTION_PHYSICAL);
+	field->logical = hid_lookup_collection(parser, HID_COLLECTION_LOGICAL);
+	field->application = hid_lookup_collection(parser, HID_COLLECTION_APPLICATION);
+
+	for (i = 0; i < usages; i++) {
+		field->usage[i].hid = parser->local.usage[i];
+		field->usage[i].collection_index =
+			parser->local.collection_index[i];
+	}
+
+	field->maxusage = usages;
+	field->flags = flags;
+	field->report_offset = offset;
+	field->report_type = report_type;
+	field->report_size = parser->global.report_size;
+	field->report_count = parser->global.report_count;
+	field->logical_minimum = parser->global.logical_minimum;
+	field->logical_maximum = parser->global.logical_maximum;
+	field->physical_minimum = parser->global.physical_minimum;
+	field->physical_maximum = parser->global.physical_maximum;
+	field->unit_exponent = parser->global.unit_exponent;
+	field->unit = parser->global.unit;
+
+	return 0;
+}
+
+/*
+ * Read data value from item.
+ */
+
+static __inline__ __u32 item_udata(struct hid_item *item)
+{
+	switch (item->size) {
+		case 1: return item->data.u8;
+		case 2: return item->data.u16;
+		case 4: return item->data.u32;
+	}
+	return 0;
+}
+
+static __inline__ __s32 item_sdata(struct hid_item *item)
+{
+	switch (item->size) {
+		case 1: return item->data.s8;
+		case 2: return item->data.s16;
+		case 4: return item->data.s32;
+	}
+	return 0;
+}
+
+/*
+ * Process a global item.
+ */
+
+static int hid_parser_global(struct hid_parser *parser, struct hid_item *item)
+{
+	switch (item->tag) {
+
+		case HID_GLOBAL_ITEM_TAG_PUSH:
+
+			if (parser->global_stack_ptr == HID_GLOBAL_STACK_SIZE) {
+				dbg("global enviroment stack overflow");
+				return -1;
+			}
+
+			memcpy(parser->global_stack + parser->global_stack_ptr++,
+				&parser->global, sizeof(struct hid_global));
+			return 0;
+
+		case HID_GLOBAL_ITEM_TAG_POP:
+
+			if (!parser->global_stack_ptr) {
+				dbg("global enviroment stack underflow");
+				return -1;
+			}
+
+			memcpy(&parser->global, parser->global_stack + --parser->global_stack_ptr,
+				sizeof(struct hid_global));
+			return 0;
+
+		case HID_GLOBAL_ITEM_TAG_USAGE_PAGE:
+			parser->global.usage_page = item_udata(item);
+			return 0;
+
+		case HID_GLOBAL_ITEM_TAG_LOGICAL_MINIMUM:
+			parser->global.logical_minimum = item_sdata(item);
+			return 0;
+
+		case HID_GLOBAL_ITEM_TAG_LOGICAL_MAXIMUM:
+			if (parser->global.logical_minimum < 0)
+				parser->global.logical_maximum = item_sdata(item);
+			else
+				parser->global.logical_maximum = item_udata(item);
+			return 0;
+
+		case HID_GLOBAL_ITEM_TAG_PHYSICAL_MINIMUM:
+			parser->global.physical_minimum = item_sdata(item);
+			return 0;
+
+		case HID_GLOBAL_ITEM_TAG_PHYSICAL_MAXIMUM:
+			if (parser->global.physical_minimum < 0)
+				parser->global.physical_maximum = item_sdata(item);
+			else
+				parser->global.physical_maximum = item_udata(item);
+			return 0;
+
+		case HID_GLOBAL_ITEM_TAG_UNIT_EXPONENT:
+			parser->global.unit_exponent = item_sdata(item);
+			return 0;
+
+		case HID_GLOBAL_ITEM_TAG_UNIT:
+			parser->global.unit = item_udata(item);
+			return 0;
+
+		case HID_GLOBAL_ITEM_TAG_REPORT_SIZE:
+			if ((parser->global.report_size = item_udata(item)) > 32) {
+				dbg("invalid report_size %d", parser->global.report_size);
+				return -1;
+			}
+			return 0;
+
+		case HID_GLOBAL_ITEM_TAG_REPORT_COUNT:
+			if ((parser->global.report_count = item_udata(item)) > HID_MAX_USAGES) {
+				dbg("invalid report_count %d", parser->global.report_count);
+				return -1;
+			}
+			return 0;
+
+		case HID_GLOBAL_ITEM_TAG_REPORT_ID:
+			if ((parser->global.report_id = item_udata(item)) == 0) {
+				dbg("report_id 0 is invalid");
+				return -1;
+			}
+			return 0;
+
+		default:
+			dbg("unknown global tag 0x%x", item->tag);
+			return -1;
+	}
+}
+
+/*
+ * Process a local item.
+ */
+
+static int hid_parser_local(struct hid_parser *parser, struct hid_item *item)
+{
+	__u32 data;
+	unsigned n;
+
+	if (item->size == 0) {
+		dbg("item data expected for local item");
+		return -1;
+	}
+
+	data = item_udata(item);
+
+	switch (item->tag) {
+
+		case HID_LOCAL_ITEM_TAG_DELIMITER:
+
+			if (data) {
+				/*
+				 * We treat items before the first delimiter
+				 * as global to all usage sets (branch 0).
+				 * In the moment we process only these global
+				 * items and the first delimiter set.
+				 */
+				if (parser->local.delimiter_depth != 0) {
+					dbg("nested delimiters");
+					return -1;
+				}
+				parser->local.delimiter_depth++;
+				parser->local.delimiter_branch++;
+			} else {
+				if (parser->local.delimiter_depth < 1) {
+					dbg("bogus close delimiter");
+					return -1;
+				}
+				parser->local.delimiter_depth--;
+			}
+			return 1;
+
+		case HID_LOCAL_ITEM_TAG_USAGE:
+
+			if (parser->local.delimiter_branch > 1) {
+				dbg("alternative usage ignored");
+				return 0;
+			}
+
+			if (item->size <= 2)
+				data = (parser->global.usage_page << 16) + data;
+
+			dbg("usage item %d (item size %d)", data, item->size);
+
+			return hid_add_usage(parser, data);
+
+		case HID_LOCAL_ITEM_TAG_USAGE_MINIMUM:
+
+			if (parser->local.delimiter_branch > 1) {
+				dbg("alternative usage ignored");
+				return 0;
+			}
+
+			if (item->size <= 2)
+				data = (parser->global.usage_page << 16) + data;
+
+			parser->local.usage_minimum = data;
+			return 0;
+
+		case HID_LOCAL_ITEM_TAG_USAGE_MAXIMUM:
+
+			if (parser->local.delimiter_branch > 1) {
+				dbg("alternative usage ignored");
+				return 0;
+			}
+
+			if (item->size <= 2)
+				data = (parser->global.usage_page << 16) + data;
+
+			dbg("usage range %d-%d (item size %d)", parser->local.usage_minimum, data, item->size);
+
+			for (n = parser->local.usage_minimum; n <= data; n++) {
+				if (hid_add_usage(parser, n)) {
+					dbg("hid_add_usage failed");
+					return -1;
+				}
+			}
+			return 0;
+
+		default:
+
+			dbg("unknown local item tag 0x%x", item->tag);
+			return 0;
+	}
+	return 0;
+}
+
+/*
+ * Process a main item.
+ */
+
+static int hid_parser_main(struct hid_parser *parser, struct hid_item *item)
+{
+	__u32 data;
+	int ret;
+
+	data = item_udata(item);
+
+	switch (item->tag) {
+		case HID_MAIN_ITEM_TAG_BEGIN_COLLECTION:
+			ret = open_collection(parser, data & 0xff);
+			break;
+		case HID_MAIN_ITEM_TAG_END_COLLECTION:
+			ret = close_collection(parser);
+			break;
+		case HID_MAIN_ITEM_TAG_INPUT:
+			ret = hid_add_field(parser, HID_INPUT_REPORT, data);
+			break;
+		case HID_MAIN_ITEM_TAG_OUTPUT:
+			ret = hid_add_field(parser, HID_OUTPUT_REPORT, data);
+			break;
+		case HID_MAIN_ITEM_TAG_FEATURE:
+			ret = hid_add_field(parser, HID_FEATURE_REPORT, data);
+			break;
+		default:
+			dbg("unknown main item tag 0x%x", item->tag);
+			ret = 0;
+	}
+
+	memset(&parser->local, 0, sizeof(parser->local));	/* Reset the local parser environment */
+
+	return ret;
+}
+
+/*
+ * Process a reserved item.
+ */
+
+static int hid_parser_reserved(struct hid_parser *parser, struct hid_item *item)
+{
+	dbg("reserved item type, tag 0x%x", item->tag);
+	return 0;
+}
+
+/*
+ * Free a report and all registered fields. The field->usage and
+ * field->value table's are allocated behind the field, so we need
+ * only to free(field) itself.
+ */
+
+static void hid_free_report(struct hid_report *report)
+{
+	unsigned n;
+
+	for (n = 0; n < report->maxfield; n++)
+		kfree(report->field[n]);
+	kfree(report);
+}
+
+/*
+ * Free a device structure, all reports, and all fields.
+ */
+
+void hid_free_device(struct hid_device *device)
+{
+	unsigned i,j;
+
+	if (!device)
+		return;
+
+	for (i = 0; i < HID_REPORT_TYPES; i++) {
+		struct hid_report_enum *report_enum = device->report_enum + i;
+
+		for (j = 0; j < 256; j++) {
+			struct hid_report *report = report_enum->report_id_hash[j];
+			if (report)
+				hid_free_report(report);
+		}
+	}
+
+	if (device->rdesc)
+		kfree(device->rdesc);
+	kfree(device);
+}
+
+/*
+ * Fetch a report description item from the data stream. We support long
+ * items, though they are not used yet.
+ */
+
+static u8 *fetch_item(__u8 *start, __u8 *end, struct hid_item *item)
+{
+	u8 b;
+
+	if ((end - start) <= 0)
+		return NULL;
+
+	b = *start++;
+
+	//memset(item, 0, sizeof(*item));
+
+	item->type = (b >> 2) & 3;
+	item->tag  = (b >> 4) & 15;
+
+	if (item->tag == HID_ITEM_TAG_LONG) {
+
+		item->format = HID_ITEM_FORMAT_LONG;
+
+		if ((end - start) < 2)
+			return NULL;
+
+		item->size = *start++;
+		item->tag  = *start++;
+
+		if ((end - start) < item->size) 
+			return NULL;
+
+		item->data.longdata = start;
+		start += item->size;
+		return start;
+	} 
+
+	item->format = HID_ITEM_FORMAT_SHORT;
+	item->size = b & 3;
+
+	switch (item->size) {
+
+		case 0:
+			return start;
+
+		case 1:
+			if ((end - start) < 1)
+				return NULL;
+			item->data.u8 = *start++;
+			dbg("size 1 data %d", item->data.u8);
+			return start;
+
+		case 2:
+			if ((end - start) < 2) 
+				return NULL;
+			item->data.u16 = le16_to_cpu(get_unaligned((__u16*)start));
+			dbg("size 2 data %d (%d)", item->data.u16,
+				be16_to_cpu(get_unaligned((__u16*)start)));
+			//item->data.u16 = be16_to_cpu(get_unaligned((__u16*)start));
+			start = (__u8 *)((__u16 *)start + 1);
+			return start;
+
+		case 3:
+			item->size++;
+			if ((end - start) < 4)
+				return NULL;
+			item->data.u32 = le32_to_cpu(get_unaligned((__u32*)start));
+			start = (__u8 *)((__u32 *)start + 1);
+			return start;
+	}
+
+	return NULL;
+}
+
+/*
+ * Parse a report description into a hid_device structure. Reports are
+ * enumerated, fields are attached to these reports.
+ */
+
+struct hid_device *hid_alloc_device(u8 *data, int size)
+{
+	struct hid_device *device;
+	struct hid_parser *parser;
+	struct hid_item item;
+	u8 *end, *start = data;
+	unsigned i;
+	static int (*dispatch_type[])(struct hid_parser *parser,
+				      struct hid_item *item) = {
+		hid_parser_main,
+		hid_parser_global,
+		hid_parser_local,
+		hid_parser_reserved
+	};
+
+	if (!(device = kmalloc(sizeof(struct hid_device), GFP_KERNEL)))
+		return NULL;
+	memset(device, 0, sizeof(struct hid_device));
+
+	if (!(device->collection = kmalloc(sizeof(struct hid_collection) *
+				   HID_DEFAULT_NUM_COLLECTIONS, GFP_KERNEL))) {
+		kfree(device);
+		return NULL;
+	}
+	memset(device->collection, 0, sizeof(struct hid_collection) *
+	       HID_DEFAULT_NUM_COLLECTIONS);
+	device->collection_size = HID_DEFAULT_NUM_COLLECTIONS;
+
+	for (i = 0; i < HID_REPORT_TYPES; i++)
+		INIT_LIST_HEAD(&device->report_enum[i].report_list);
+
+	if (!(device->rdesc = (__u8 *)kmalloc(size, GFP_KERNEL))) {
+		kfree(device->collection);
+		kfree(device);
+		return NULL;
+	}
+	memcpy(device->rdesc, start, size);
+	device->rsize = size;
+
+	if (!(parser = kmalloc(sizeof(struct hid_parser), GFP_KERNEL))) {
+		kfree(device->rdesc);
+		kfree(device->collection);
+		kfree(device);
+		return NULL;
+	}
+	memset(parser, 0, sizeof(struct hid_parser));
+	parser->device = device;
+
+	end = start + size;
+	while ((start = fetch_item(start, end, &item)) != 0) {
+
+		if (item.format != HID_ITEM_FORMAT_SHORT) {
+			dbg("unexpected long global item");
+			kfree(device->collection);
+			hid_free_device(device);
+			kfree(parser);
+			return NULL;
+		}
+
+		if (dispatch_type[item.type](parser, &item)) {
+			dbg("item %u %u %u %u parsing failed",
+				item.format, (unsigned)item.size, (unsigned)item.type, (unsigned)item.tag);
+			kfree(device->collection);
+			hid_free_device(device);
+			kfree(parser);
+			return NULL;
+		}
+
+		if (start == end) {
+			if (parser->collection_stack_ptr) {
+				dbg("unbalanced collection at end of report description");
+				kfree(device->collection);
+				hid_free_device(device);
+				kfree(parser);
+				return NULL;
+			}
+			if (parser->local.delimiter_depth) {
+				dbg("unbalanced delimiter at end of report description");
+				kfree(device->collection);
+				hid_free_device(device);
+				kfree(parser);
+				return NULL;
+			}
+			kfree(parser);
+			return device;
+		}
+	}
+
+	dbg("item fetching failed at offset %d", (int)(end - start));
+	kfree(device->collection);
+	hid_free_device(device);
+	kfree(parser);
+	return NULL;
+}
+
+/*
+ * Convert a signed n-bit integer to signed 32-bit integer. Common
+ * cases are done through the compiler, the screwed things has to be
+ * done by hand.
+ */
+
+static __inline__ __s32 snto32(__u32 value, unsigned n)
+{
+	switch (n) {
+		case 8:  return ((__s8)value);
+		case 16: return ((__s16)value);
+		case 32: return ((__s32)value);
+	}
+	return value & (1 << (n - 1)) ? value | (-1 << n) : value;
+}
+
+/*
+ * Convert a signed 32-bit integer to a signed n-bit integer.
+ */
+
+static __inline__ __u32 s32ton(__s32 value, unsigned n)
+{
+	__s32 a = value >> (n - 1);
+	if (a && a != -1)
+		return value < 0 ? 1 << (n - 1) : (1 << (n - 1)) - 1;
+	return value & ((1 << n) - 1);
+}
+
+/*
+ * Extract/implement a data field from/to a report.
+ */
+
+static __inline__ __u32 extract(__u8 *report, unsigned offset, unsigned n)
+{
+	report += (offset >> 5) << 2; offset &= 31;
+	return (le64_to_cpu(get_unaligned((__u64*)report)) >> offset) & ((1 << n) - 1);
+}
+
+static __inline__ void implement(__u8 *report, unsigned offset, unsigned n, __u32 value)
+{
+	report += (offset >> 5) << 2; offset &= 31;
+	put_unaligned((get_unaligned((__u64*)report)
+		& cpu_to_le64(~((((__u64) 1 << n) - 1) << offset)))
+		| cpu_to_le64((__u64)value << offset), (__u64*)report);
+}
+
+/*
+ * Search an array for a value.
+ */
+
+static __inline__ int search(__s32 *array, __s32 value, unsigned n)
+{
+	while (n--) {
+		if (*array++ == value)
+			return 0;
+	}
+	return -1;
+}
+
+static void hid_process_event(struct hid_device *hid, struct hid_field *field, struct hid_usage *usage, __s32 value)
+{
+	hid_dump_input(usage, value);
+	hidinput_hid_event(hid, field, usage, value);
+}
+
+/*
+ * Analyse a received field, and fetch the data from it. The field
+ * content is stored for next report processing (we do differential
+ * reporting to the layer).
+ */
+
+static void hid_input_field(struct hid_device *hid, struct hid_field *field, __u8 *data)
+{
+	unsigned n;
+	unsigned count = field->report_count;
+	unsigned offset = field->report_offset;
+	unsigned size = field->report_size;
+	__s32 min = field->logical_minimum;
+	__s32 max = field->logical_maximum;
+	__s32 value[count]; /* WARNING: gcc specific */
+
+	for (n = 0; n < count; n++) {
+
+			value[n] = min < 0 ? snto32(extract(data, offset + n * size, size), size) :
+						    extract(data, offset + n * size, size);
+
+			if (!(field->flags & HID_MAIN_ITEM_VARIABLE) /* Ignore report if ErrorRollOver */
+			    && value[n] >= min && value[n] <= max
+			    && field->usage[value[n] - min].hid == HID_UP_KEYBOARD + 1)
+				return;
+	}
+
+	for (n = 0; n < count; n++) {
+
+		if (HID_MAIN_ITEM_VARIABLE & field->flags) {
+
+			if (field->flags & HID_MAIN_ITEM_RELATIVE) {
+				if (!value[n])
+					continue;
+			} else {
+				if (value[n] == field->value[n])
+					continue;
+			}	
+			hid_process_event(hid, field, &field->usage[n], value[n]);
+			continue;
+		}
+
+		if (field->value[n] >= min && field->value[n] <= max
+			&& field->usage[field->value[n] - min].hid
+			&& search(value, field->value[n], count))
+				hid_process_event(hid, field, &field->usage[field->value[n] - min], 0);
+
+		if (value[n] >= min && value[n] <= max
+			&& field->usage[value[n] - min].hid
+			&& search(field->value, value[n], count))
+				hid_process_event(hid, field, &field->usage[value[n] - min], 1);
+	}
+
+	memcpy(field->value, value, count * sizeof(__s32));
+}
+
+int hid_recv_report(struct hid_device *hid, int type, u8 *data, int size)
+{
+	struct hid_report_enum *report_enum = hid->report_enum + type;
+	struct hid_report *report;
+	int n, rsize;
+
+	if (!hid)
+		return -ENODEV;
+
+	if (!size) {
+		dbg("empty report");
+		return -1;
+	}
+
+#ifdef DEBUG_DATA
+	printk(KERN_DEBUG __FILE__ ": report (size %u) (%snumbered)\n", len, report_enum->numbered ? "" : "un");
+#endif
+
+	n = 0;				/* Normally report number is 0 */
+	if (report_enum->numbered) {	/* Device uses numbered reports, data[0] is report number */
+		n = *data++;
+		size--;
+	}
+
+#ifdef DEBUG_DATA
+	{
+		int i;
+		printk(KERN_DEBUG __FILE__ ": report %d (size %u) = ", n, size);
+		for (i = 0; i < size; i++)
+			printk(" %02x", data[i]);
+		printk("\n");
+	}
+#endif
+
+	if (!(report = report_enum->report_id_hash[n])) {
+		dbg("undefined report_id %d received", n);
+		return -1;
+	}
+
+	rsize = ((report->size - 1) >> 3) + 1;
+
+	if (size < rsize) {
+		dbg("report %d is too short, (%d < %d)", report->id, size, rsize);
+		return -1;
+	}
+
+	for (n = 0; n < report->maxfield; n++)
+		hid_input_field(hid, report->field[n], data);
+
+	hidinput_report_event(hid, report);
+
+	return 0;
+}
+
+/*
+ * Output the field into the report.
+ */
+
+static void hid_output_field(struct hid_field *field, __u8 *data)
+{
+	unsigned count = field->report_count;
+	unsigned offset = field->report_offset;
+	unsigned size = field->report_size;
+	unsigned n;
+
+	for (n = 0; n < count; n++) {
+		if (field->logical_minimum < 0)	/* signed values */
+			implement(data, offset + n * size, size, s32ton(field->value[n], size));
+		 else				/* unsigned values */
+			implement(data, offset + n * size, size, field->value[n]);
+	}
+}
+
+/*
+ * Create a report.
+ */
+
+static void hid_output_report(struct hid_report *report, __u8 *data)
+{
+	unsigned n;
+
+	if (report->id > 0)
+		*data++ = report->id;
+
+	for (n = 0; n < report->maxfield; n++)
+		hid_output_field(report->field[n], data);
+}
+
+/*
+ * Set a field value. The report this field belongs to has to be
+ * created and transferred to the device, to set this value in the
+ * device.
+ */
+
+static int hid_set_field(struct hid_field *field, unsigned offset, __s32 value)
+{
+	unsigned size = field->report_size;
+
+	hid_dump_input(field->usage + offset, value);
+
+	if (offset >= field->report_count) {
+		dbg("offset (%d) exceeds report_count (%d)", offset, field->report_count);
+		hid_dump_field(field, 8);
+		return -1;
+	}
+	if (field->logical_minimum < 0) {
+		if (value != snto32(s32ton(value, size), size)) {
+			dbg("value %d is out of range", value);
+			return -1;
+		}
+	}
+	field->value[offset] = value;
+	return 0;
+}
+
+static int hid_find_field(struct hid_device *hid, unsigned int type, unsigned int code, struct hid_field **field)
+{
+	struct hid_report_enum *report_enum = hid->report_enum + HID_OUTPUT_REPORT;
+	struct list_head *list = report_enum->report_list.next;
+	int i, j;
+
+	while (list != &report_enum->report_list) {
+		struct hid_report *report = (struct hid_report *) list;
+		list = list->next;
+		for (i = 0; i < report->maxfield; i++) {
+			*field = report->field[i];
+			for (j = 0; j < (*field)->maxusage; j++)
+				if ((*field)->usage[j].type == type && (*field)->usage[j].code == code)
+					return j;
+		}
+	}
+	return -1;
+}
+
+#if 0
+/*
+ * Find a report with a specified HID usage.
+ */
+
+static int hid_find_report_by_usage(struct hid_device *hid, __u32 wanted_usage, struct hid_report **report, int type)
+{
+	struct hid_report_enum *report_enum = hid->report_enum + type;
+	struct list_head *list = report_enum->report_list.next;
+	int i, j;
+
+	while (list != &report_enum->report_list) {
+		*report = (struct hid_report *) list;
+		list = list->next;
+		for (i = 0; i < (*report)->maxfield; i++) {
+			struct hid_field *field = (*report)->field[i];
+			for (j = 0; j < field->maxusage; j++)
+				if (field->logical == wanted_usage)
+					return j;
+		}
+	}
+	return -1;
+}
+
+static int hid_find_field_in_report(struct hid_report *report, __u32 wanted_usage, struct hid_field **field)
+{
+	int i, j;
+
+	for (i = 0; i < report->maxfield; i++) {
+		*field = report->field[i];
+		for (j = 0; j < (*field)->maxusage; j++)
+			if ((*field)->usage[j].hid == wanted_usage)
+				return j;
+	}
+
+	return -1;
+}
+#endif
+
+static int hid_submit_report(struct hid_device *hid, struct hid_report *report)
+{
+	unsigned char buf[32];
+	int rsize;
+
+	rsize = ((report->size - 1) >> 3) + 1 + (report->id > 0);
+	if (rsize > sizeof(buf))
+		return -EIO;
+
+	hid_output_report(report, buf);
+
+	if (hid->send)
+		hid->send(hid, buf, rsize);
+
+	return 0;
+}
+
+/*
+ * Initialize all reports
+ */
+
+static void hid_init_reports(struct hid_device *hid)
+{
+	struct hid_report_enum *report_enum;
+	struct hid_report *report;
+	struct list_head *list;
+	int len;
+
+	report_enum = hid->report_enum + HID_INPUT_REPORT;
+	list = report_enum->report_list.next;
+	while (list != &report_enum->report_list) {
+		report = (struct hid_report *) list;
+		hid_submit_report(hid, report);
+		list = list->next;
+	}
+
+	report_enum = hid->report_enum + HID_FEATURE_REPORT;
+	list = report_enum->report_list.next;
+	while (list != &report_enum->report_list) {
+		report = (struct hid_report *) list;
+		hid_submit_report(hid, report);
+		list = list->next;
+	}
+
+	report_enum = hid->report_enum + HID_INPUT_REPORT;
+	list = report_enum->report_list.next;
+	while (list != &report_enum->report_list) {
+		report = (struct hid_report *) list;
+		len = ((report->size - 1) >> 3) + 1 + report_enum->numbered;
+		list = list->next;
+	}
+}
+
+
+#define unk	KEY_UNKNOWN
+
+static unsigned char hid_keyboard[256] = {
+	  0,  0,  0,  0, 30, 48, 46, 32, 18, 33, 34, 35, 23, 36, 37, 38,
+	 50, 49, 24, 25, 16, 19, 31, 20, 22, 47, 17, 45, 21, 44,  2,  3,
+	  4,  5,  6,  7,  8,  9, 10, 11, 28,  1, 14, 15, 57, 12, 13, 26,
+	 27, 43, 43, 39, 40, 41, 51, 52, 53, 58, 59, 60, 61, 62, 63, 64,
+	 65, 66, 67, 68, 87, 88, 99, 70,119,110,102,104,111,107,109,106,
+	105,108,103, 69, 98, 55, 74, 78, 96, 79, 80, 81, 75, 76, 77, 71,
+	 72, 73, 82, 83, 86,127,116,117,183,184,185,186,187,188,189,190,
+	191,192,193,194,134,138,130,132,128,129,131,137,133,135,136,113,
+	115,114,unk,unk,unk,121,unk, 89, 93,124, 92, 94, 95,unk,unk,unk,
+	122,123, 90, 91, 85,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,
+	unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,
+	unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,
+	unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,
+	unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,
+	 29, 42, 56,125, 97, 54,100,126,164,166,165,163,161,115,114,113,
+	150,158,159,128,136,177,178,176,142,152,173,140,unk,unk,unk,unk
+};
+
+static struct {
+	__s32 x;
+	__s32 y;
+} hid_hat_to_axis[] = {{ 0, 0}, { 0,-1}, { 1,-1}, { 1, 0}, { 1, 1}, { 0, 1}, {-1, 1}, {-1, 0}, {-1,-1}};
+
+static struct input_dev *find_input(struct hid_device *hid, struct hid_field *field)
+{
+	struct list_head *lh;
+	struct hid_input *hidinput;
+
+	list_for_each (lh, &hid->inputs) {
+		int i;
+
+		hidinput = list_entry(lh, struct hid_input, list);
+
+		if (! hidinput->report)
+			continue;
+
+		for (i = 0; i < hidinput->report->maxfield; i++)
+			if (hidinput->report->field[i] == field)
+				return hidinput->input;
+	}
+
+	/* Assume we only have one input and use it */
+	if (!list_empty(&hid->inputs)) {
+		hidinput = list_entry(hid->inputs.next, struct hid_input, list);
+		return hidinput->input;
+	}
+
+	/* This is really a bug */
+	return NULL;
+}
+
+static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_field *field,
+				     struct hid_usage *usage)
+{
+	struct input_dev *input = hidinput->input;
+	struct hid_device *device = input->private;
+	int max;
+	int is_abs = 0;
+	unsigned long *bit;
+
+	switch (usage->hid & HID_USAGE_PAGE) {
+
+		case HID_UP_KEYBOARD:
+
+			set_bit(EV_REP, input->evbit);
+			usage->type = EV_KEY; bit = input->keybit; max = KEY_MAX;
+
+			if ((usage->hid & HID_USAGE) < 256) {
+				if (!(usage->code = hid_keyboard[usage->hid & HID_USAGE]))
+					return;
+				clear_bit(usage->code, bit);
+			} else
+				usage->code = KEY_UNKNOWN;
+
+			break;
+
+		case HID_UP_BUTTON:
+
+			usage->code = ((usage->hid - 1) & 0xf) + 0x100;
+			usage->type = EV_KEY; bit = input->keybit; max = KEY_MAX;
+
+			switch (field->application) {
+				case HID_GD_GAMEPAD:  usage->code += 0x10;
+				case HID_GD_JOYSTICK: usage->code += 0x10;
+				case HID_GD_MOUSE:    usage->code += 0x10; break;
+				default:
+					if (field->physical == HID_GD_POINTER)
+						usage->code += 0x10;
+					break;
+			}
+			break;
+
+		case HID_UP_GENDESK:
+
+			if ((usage->hid & 0xf0) == 0x80) {	/* SystemControl */
+				switch (usage->hid & 0xf) {
+					case 0x1: usage->code = KEY_POWER;  break;
+					case 0x2: usage->code = KEY_SLEEP;  break;
+					case 0x3: usage->code = KEY_WAKEUP; break;
+					default:  usage->code = KEY_UNKNOWN; break;
+				}
+				usage->type = EV_KEY; bit = input->keybit; max = KEY_MAX;
+				break;
+			}
+
+			usage->code = usage->hid & 0xf;
+
+			if (field->report_size == 1) {
+				usage->code = BTN_MISC;
+				usage->type = EV_KEY; bit = input->keybit; max = KEY_MAX;
+				break;
+			}
+
+			if (field->flags & HID_MAIN_ITEM_RELATIVE) {
+				usage->type = EV_REL; bit = input->relbit; max = REL_MAX;
+				break;
+			}
+
+			usage->type = EV_ABS; bit = input->absbit; max = ABS_MAX;
+
+			if (usage->hid == HID_GD_HATSWITCH) {
+				usage->code = ABS_HAT0X;
+				usage->hat_min = field->logical_minimum;
+				usage->hat_max = field->logical_maximum;
+			}
+			break;
+
+		case HID_UP_LED:
+
+			usage->code = (usage->hid - 1) & 0xf;
+			usage->type = EV_LED; bit = input->ledbit; max = LED_MAX;
+			break;
+
+		case HID_UP_DIGITIZER:
+
+			switch (usage->hid & 0xff) {
+
+				case 0x30: /* TipPressure */
+
+					if (!test_bit(BTN_TOUCH, input->keybit)) {
+						device->quirks |= HID_QUIRK_NOTOUCH;
+						set_bit(EV_KEY, input->evbit);
+						set_bit(BTN_TOUCH, input->keybit);
+					}
+					usage->type = EV_ABS; bit = input->absbit; max = ABS_MAX;
+					usage->code = ABS_PRESSURE;
+					clear_bit(usage->code, bit);
+					break;
+
+				case 0x32: /* InRange */
+
+					usage->type = EV_KEY; bit = input->keybit; max = KEY_MAX;
+					switch (field->physical & 0xff) {
+						case 0x21: usage->code = BTN_TOOL_MOUSE; break;
+						case 0x22: usage->code = BTN_TOOL_FINGER; break;
+						default: usage->code = BTN_TOOL_PEN; break;
+					}
+					break;
+
+				case 0x3c: /* Invert */
+
+					usage->type = EV_KEY; bit = input->keybit; max = KEY_MAX;
+					usage->code = BTN_TOOL_RUBBER;
+					clear_bit(usage->code, bit);
+					break;
+
+				case 0x33: /* Touch */
+				case 0x42: /* TipSwitch */
+				case 0x43: /* TipSwitch2 */
+
+					device->quirks &= ~HID_QUIRK_NOTOUCH;
+					usage->type = EV_KEY; bit = input->keybit; max = KEY_MAX;
+					usage->code = BTN_TOUCH;
+					clear_bit(usage->code, bit);
+					break;
+
+				case 0x44: /* BarrelSwitch */
+
+					usage->type = EV_KEY; bit = input->keybit; max = KEY_MAX;
+					usage->code = BTN_STYLUS;
+					clear_bit(usage->code, bit);
+					break;
+
+				default:  goto unknown;
+			}
+			break;
+
+		case HID_UP_CONSUMER:	/* USB HUT v1.1, pages 56-62 */
+
+			set_bit(EV_REP, input->evbit);
+			switch (usage->hid & HID_USAGE) {
+				case 0x000: usage->code = 0; break;
+				case 0x034: usage->code = KEY_SLEEP;		break;
+				case 0x036: usage->code = BTN_MISC;		break;
+				case 0x08a: usage->code = KEY_WWW;		break;
+				case 0x095: usage->code = KEY_HELP;		break;
+
+				case 0x0b0: usage->code = KEY_PLAY;		break;
+				case 0x0b1: usage->code = KEY_PAUSE;		break;
+				case 0x0b2: usage->code = KEY_RECORD;		break;
+				case 0x0b3: usage->code = KEY_FASTFORWARD;	break;
+				case 0x0b4: usage->code = KEY_REWIND;		break;
+				case 0x0b5: usage->code = KEY_NEXTSONG;		break;
+				case 0x0b6: usage->code = KEY_PREVIOUSSONG;	break;
+				case 0x0b7: usage->code = KEY_STOPCD;		break;
+				case 0x0b8: usage->code = KEY_EJECTCD;		break;
+				case 0x0cd: usage->code = KEY_PLAYPAUSE;	break;
+				case 0x0e0: is_abs = 1;
+					    usage->code = ABS_VOLUME;		break;
+				case 0x0e2: usage->code = KEY_MUTE;		break;
+				case 0x0e5: usage->code = KEY_BASSBOOST;	break;
+				case 0x0e9: usage->code = KEY_VOLUMEUP;		break;
+				case 0x0ea: usage->code = KEY_VOLUMEDOWN;	break;
+
+				case 0x183: usage->code = KEY_CONFIG;		break;
+				case 0x18a: usage->code = KEY_MAIL;		break;
+				case 0x192: usage->code = KEY_CALC;		break;
+				case 0x194: usage->code = KEY_FILE;		break;
+				case 0x21a: usage->code = KEY_UNDO;		break;
+				case 0x21b: usage->code = KEY_COPY;		break;
+				case 0x21c: usage->code = KEY_CUT;		break;
+				case 0x21d: usage->code = KEY_PASTE;		break;
+
+				case 0x221: usage->code = KEY_FIND;		break;
+				case 0x223: usage->code = KEY_HOMEPAGE;		break;
+				case 0x224: usage->code = KEY_BACK;		break;
+				case 0x225: usage->code = KEY_FORWARD;		break;
+				case 0x226: usage->code = KEY_STOP;		break;
+				case 0x227: usage->code = KEY_REFRESH;		break;
+				case 0x22a: usage->code = KEY_BOOKMARKS;	break;
+
+				default:    usage->code = KEY_UNKNOWN;		break;
+			}
+
+			if (is_abs) {
+			        usage->type = EV_ABS; bit = input->absbit; max = ABS_MAX;
+			} else  {
+				usage->type = EV_KEY; bit = input->keybit; max = KEY_MAX;
+			}
+			break;
+
+		case HID_UP_HPVENDOR:	/* Reported on a Dutch layout HP5308 */
+
+			set_bit(EV_REP, input->evbit);
+			switch (usage->hid & HID_USAGE) {
+				case 0x021: usage->code = KEY_PRINT;		break;
+				case 0x070: usage->code = KEY_HP;		break;
+				case 0x071: usage->code = KEY_CAMERA;		break;
+				case 0x072: usage->code = KEY_SOUND;		break;
+				case 0x073: usage->code = KEY_QUESTION;		break;
+
+				case 0x080: usage->code = KEY_EMAIL;		break;
+				case 0x081: usage->code = KEY_CHAT;		break;
+				case 0x082: usage->code = KEY_SEARCH;		break;
+				case 0x083: usage->code = KEY_CONNECT;	        break;
+				case 0x084: usage->code = KEY_FINANCE;		break;
+				case 0x085: usage->code = KEY_SPORT;		break;
+				case 0x086: usage->code = KEY_SHOP;		break;
+
+				default:    usage->code = KEY_UNKNOWN;		break;
+
+			}
+
+			usage->type = EV_KEY; bit = input->keybit; max = KEY_MAX;
+			break;
+			
+		case HID_UP_PID:
+
+			usage->type = EV_FF; bit = input->ffbit; max = FF_MAX;
+			
+			switch(usage->hid & HID_USAGE) {
+				case 0x26: set_bit(FF_CONSTANT, input->ffbit); break;
+				case 0x27: set_bit(FF_RAMP,     input->ffbit); break;
+				case 0x28: set_bit(FF_CUSTOM,   input->ffbit); break;
+				case 0x30: set_bit(FF_SQUARE,   input->ffbit);
+				           set_bit(FF_PERIODIC, input->ffbit); break;
+				case 0x31: set_bit(FF_SINE,     input->ffbit);
+				           set_bit(FF_PERIODIC, input->ffbit); break;
+				case 0x32: set_bit(FF_TRIANGLE, input->ffbit);
+				           set_bit(FF_PERIODIC, input->ffbit); break;
+				case 0x33: set_bit(FF_SAW_UP,   input->ffbit);
+				           set_bit(FF_PERIODIC, input->ffbit); break;
+				case 0x34: set_bit(FF_SAW_DOWN, input->ffbit);
+				           set_bit(FF_PERIODIC, input->ffbit); break;
+				case 0x40: set_bit(FF_SPRING,   input->ffbit); break;
+				case 0x41: set_bit(FF_DAMPER,   input->ffbit); break;
+				case 0x42: set_bit(FF_INERTIA , input->ffbit); break;
+				case 0x43: set_bit(FF_FRICTION, input->ffbit); break;
+				case 0x7e: usage->code = FF_GAIN;       break;
+				case 0x83:  /* Simultaneous Effects Max */
+					input->ff_effects_max = (field->value[0]);
+					dbg("Maximum Effects - %d", input->ff_effects_max);
+					break;
+				case 0x98:  /* Device Control */
+					usage->code = FF_AUTOCENTER;    break;
+				case 0xa4:  /* Safety Switch */
+					usage->code = BTN_DEAD;
+					bit = input->keybit;
+					usage->type = EV_KEY;
+					max = KEY_MAX;
+					dbg("Safety Switch Report");
+					break;
+				case 0x9f: /* Device Paused */
+				case 0xa0: /* Actuators Enabled */
+					dbg("Not telling the input API about ");
+					resolv_usage(usage->hid);
+					return;
+			}
+			break;
+		default:
+		unknown:
+			resolv_usage(usage->hid);
+
+			if (field->report_size == 1) {
+
+				if (field->report->type == HID_OUTPUT_REPORT) {
+					usage->code = LED_MISC;
+					usage->type = EV_LED; bit = input->ledbit; max = LED_MAX;
+					break;
+				}
+
+				usage->code = BTN_MISC;
+				usage->type = EV_KEY; bit = input->keybit; max = KEY_MAX;
+				break;
+			}
+
+			if (field->flags & HID_MAIN_ITEM_RELATIVE) {
+				usage->code = REL_MISC;
+				usage->type = EV_REL; bit = input->relbit; max = REL_MAX;
+				break;
+			}
+
+			usage->code = ABS_MISC;
+			usage->type = EV_ABS; bit = input->absbit; max = ABS_MAX;
+			break;
+	}
+
+	set_bit(usage->type, input->evbit);
+	if ((usage->type == EV_REL)
+			&& (device->quirks & HID_QUIRK_2WHEEL_MOUSE_HACK)
+			&& (usage->code == REL_WHEEL)) {
+		set_bit(REL_HWHEEL, bit);
+	}
+
+	while (usage->code <= max && test_and_set_bit(usage->code, bit)) {
+		usage->code = find_next_zero_bit(bit, max + 1, usage->code);
+	}
+
+	if (usage->code > max)
+		return;
+
+	if (usage->type == EV_ABS) {
+		int a = field->logical_minimum;
+		int b = field->logical_maximum;
+
+		if ((device->quirks & HID_QUIRK_BADPAD) && (usage->code == ABS_X || usage->code == ABS_Y)) {
+			a = field->logical_minimum = 0;
+			b = field->logical_maximum = 255;
+		}
+		
+		input->absmin[usage->code] = a;
+		input->absmax[usage->code] = b;
+		input->absfuzz[usage->code] = 0;
+		input->absflat[usage->code] = 0;
+
+		if (field->application == HID_GD_GAMEPAD || field->application == HID_GD_JOYSTICK) {
+			input->absfuzz[usage->code] = (b - a) >> 8;
+			input->absflat[usage->code] = (b - a) >> 4;
+		}
+	}
+
+	if (usage->hat_min != usage->hat_max) {
+		int i;
+		for (i = usage->code; i < usage->code + 2 && i <= max; i++) {
+			input->absmax[i] = 1;
+			input->absmin[i] = -1;
+			input->absfuzz[i] = 0;
+			input->absflat[i] = 0;
+		}
+		set_bit(usage->code + 1, input->absbit);
+	}
+}
+
+static void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct hid_usage *usage, __s32 value)
+{
+	struct input_dev *input = find_input(hid, field);
+	unsigned long *quirks = &hid->quirks;
+
+	if (!input)
+		return;
+
+	if ((hid->quirks & HID_QUIRK_2WHEEL_MOUSE_HACK)
+			&& (usage->code == BTN_BACK)) {
+		if (value)
+			hid->quirks |= HID_QUIRK_2WHEEL_MOUSE_HACK_ON;
+		else
+			hid->quirks &= ~HID_QUIRK_2WHEEL_MOUSE_HACK_ON;
+		return;
+	}
+	if ((hid->quirks & HID_QUIRK_2WHEEL_MOUSE_HACK_ON)
+			&& (usage->code == REL_WHEEL)) {
+		input_event(input, usage->type, REL_HWHEEL, value);
+		return;
+	}
+
+	if (usage->hat_min != usage->hat_max) {
+		if (usage->hat_max - usage->hat_min + 1 != 0)
+			value = (value - usage->hat_min) * 8 / (usage->hat_max - usage->hat_min + 1) + 1;
+		if (value < 0 || value > 8) value = 0;
+		input_event(input, usage->type, usage->code    , hid_hat_to_axis[value].x);
+		input_event(input, usage->type, usage->code + 1, hid_hat_to_axis[value].y);
+		return;
+	}
+
+	if (usage->hid == (HID_UP_DIGITIZER | 0x003c)) { /* Invert */
+		*quirks = value ? (*quirks | HID_QUIRK_INVERT) : (*quirks & ~HID_QUIRK_INVERT);
+		return;
+	}
+
+	if (usage->hid == (HID_UP_DIGITIZER | 0x0032)) { /* InRange */
+		if (value) {
+			input_event(input, usage->type, (*quirks & HID_QUIRK_INVERT) ? BTN_TOOL_RUBBER : usage->code, 1);
+			return;
+		}
+		input_event(input, usage->type, usage->code, 0);
+		input_event(input, usage->type, BTN_TOOL_RUBBER, 0);
+		return;
+	}
+
+	if (usage->hid == (HID_UP_DIGITIZER | 0x0030) && (*quirks & HID_QUIRK_NOTOUCH)) { /* Pressure */
+		int a = field->logical_minimum;
+		int b = field->logical_maximum;
+		input_event(input, EV_KEY, BTN_TOUCH, value > a + ((b - a) >> 3));
+	}
+
+	if (usage->hid == (HID_UP_PID | 0x83UL)) { /* Simultaneous Effects Max */
+		input->ff_effects_max = value;
+		dbg("Maximum Effects - %d", input->ff_effects_max);
+		return;
+	}
+	if (usage->hid == (HID_UP_PID | 0x7fUL)) {
+		dbg("PID Pool Report");
+		return;
+	}
+
+	if((usage->type == EV_KEY) && (usage->code == 0)) /* Key 0 is "unassigned", not KEY_UKNOWN */
+		return;
+
+	input_event(input, usage->type, usage->code, value);
+
+	if ((field->flags & HID_MAIN_ITEM_RELATIVE) && (usage->type == EV_KEY))
+		input_event(input, usage->type, usage->code, 0);
+}
+
+static void hidinput_report_event(struct hid_device *hid, struct hid_report *report)
+{
+	struct list_head *lh;
+	struct hid_input *hidinput;
+
+	list_for_each (lh, &hid->inputs) {
+		hidinput = list_entry(lh, struct hid_input, list);
+		input_sync(hidinput->input);
+	}
+}
+
+static int hidinput_input_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
+{
+	struct hid_device *hid = dev->private;
+	struct hid_field *field = NULL;
+	int offset;
+
+	if ((offset = hid_find_field(hid, type, code, &field)) == -1) {
+		warn("event field not found");
+		return -1;
+	}
+
+	hid_set_field(field, offset, value);
+
+	return hid_submit_report(hid, field->report);
+}
+
+
+static char *hid_types[] = {"Device", "Pointer", "Mouse", "Device", "Joystick",
+				"Gamepad", "Keyboard", "Keypad", "Multi-Axis Controller"};
+
+/*
+ * Register the input device; print a message.
+ * Configure the input layer interface
+ * Read all reports and initialize the absolute field values.
+ */
+
+int hid_register_device(struct hid_device *hid)
+{
+	struct hid_report_enum *report_enum;
+	struct hid_report *report;
+	struct list_head *list;
+	struct hid_input *hidinput = NULL;
+	struct input_dev *input_dev;
+	int i, j, k;
+	char *c;
+
+	if (!hid)
+		return -ENODEV;
+
+	hid_init_reports(hid);
+
+	INIT_LIST_HEAD(&hid->inputs);
+
+	for (i = 0; i < hid->maxcollection; i++)
+		if (hid->collection[i].type == HID_COLLECTION_APPLICATION &&
+		    IS_INPUT_APPLICATION(hid->collection[i].usage))
+			break;
+
+	if (i == hid->maxcollection)
+		return -1;
+
+	for (k = HID_INPUT_REPORT; k <= HID_OUTPUT_REPORT; k++) {
+		report_enum = hid->report_enum + k;
+		list = report_enum->report_list.next;
+		while (list != &report_enum->report_list) {
+			report = (struct hid_report *) list;
+
+			if (!report->maxfield)
+				continue;
+
+			if (!hidinput) {
+				hidinput = kzalloc(sizeof(*hidinput), GFP_KERNEL);
+				input_dev = input_allocate_device();
+				if (!hidinput || !input_dev) {
+					kfree(hidinput);
+					input_free_device(input_dev);
+					err("Out of memory during hid input probe");
+					return -1;
+				}
+
+				input_dev->private = hid;
+				input_dev->event = hidinput_input_event;
+
+				input_dev->name = hid->name;
+				input_dev->phys = hid->phys;
+				input_dev->uniq = hid->uniq;
+				input_dev->id.bustype = hid->bus;
+				input_dev->id.vendor  = hid->vendor;
+				input_dev->id.product = hid->product;
+				input_dev->id.version = hid->version;
+				input_dev->dev = NULL;
+
+				hidinput->input = input_dev;
+				list_add_tail(&hidinput->list, &hid->inputs);
+			}
+
+			for (i = 0; i < report->maxfield; i++)
+				for (j = 0; j < report->field[i]->maxusage; j++)
+					hidinput_configure_usage(hidinput, report->field[i],
+								 report->field[i]->usage + j);
+
+			if (hid->quirks & HID_QUIRK_MULTI_INPUT) {
+				/* This will leave hidinput NULL, so that it
+				 * allocates another one if we have more inputs on
+				 * the same interface. Some devices (e.g. Happ's
+				 * UGCI) cram a lot of unrelated inputs into the
+				 * same interface. */
+				hidinput->report = report;
+				input_register_device(hidinput->input);
+				hidinput = NULL;
+			}
+
+			list = list->next;
+		}
+	}
+
+	/* This only gets called when we are a single-input (most of the
+	 * time). IOW, not a HID_QUIRK_MULTI_INPUT. The hid_ff_init() is
+	 * only useful in this case, and not for multi-input quirks. */
+	if (hidinput)
+		input_register_device(hidinput->input);
+
+	c = "Device";
+	for (i = 0; i < hid->maxcollection; i++) {
+		if (hid->collection[i].type == HID_COLLECTION_APPLICATION &&
+				(hid->collection[i].usage & HID_USAGE_PAGE) == HID_UP_GENDESK &&
+				(hid->collection[i].usage & 0xffff) < ARRAY_SIZE(hid_types)) {
+			c = hid_types[hid->collection[i].usage & 0xffff];
+			break;
+		}
+	}
+
+	dbg("HID: Bluetooth %s %04x:%04x [%s]", c, hid->vendor, hid->product, hid->name);
+
+	return 0;
+}
+
+void hid_unregister_device(struct hid_device *hid)
+{
+	struct list_head *lh, *next;
+	struct hid_input *hidinput;
+
+	if (!hid)
+		return;
+
+	list_for_each_safe (lh, next, &hid->inputs) {
+		hidinput = list_entry(lh, struct hid_input, list);
+		input_unregister_device(hidinput->input);
+		list_del(&hidinput->list);
+		kfree(hidinput);
+	}
+}
diff -uNr --exclude-from=kernel-diff-exclude.txt linux-2.6.16.20-original/net/bluetooth/hidp/hid.h linux-2.6.16.20/net/bluetooth/hidp/hid.h
--- linux-2.6.16.20-original/net/bluetooth/hidp/hid.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.16.20/net/bluetooth/hidp/hid.h	2006-06-09 17:49:01.000000000 -0700
@@ -0,0 +1,350 @@
+/*
+ *
+ *  Human Interface Device driver (HID)
+ *
+ *  Copyright (C) 1999  Andreas Gal
+ *  Copyright (C) 2000-2001  Vojtech Pavlik <vojtech@suse.cz>
+ *  Copyright (C) 2003-2004  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#ifndef __HID_H
+#define __HID_H
+
+#ifdef DEBUG
+#define dbg(format, arg...) printk(KERN_DEBUG "%s: " format "\n" , __FILE__ , ## arg)
+#else
+#define dbg(format, arg...) do {} while (0)
+#endif
+
+#define err(format, arg...) printk(KERN_ERR "%s: " format "\n" , __FILE__ , ## arg)
+#define info(format, arg...) printk(KERN_INFO "%s: " format "\n" , __FILE__ , ## arg)
+#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n" , __FILE__ , ## arg)
+
+/*
+ * We parse each description item into this structure. Short items data
+ * values are expanded to 32-bit signed int, long items contain a pointer
+ * into the data area.
+ */
+
+struct hid_item {
+	unsigned  format;
+	__u8      size;
+	__u8      type;
+	__u8      tag;
+	union {
+	    __u8   u8;
+	    __s8   s8;
+	    __u16  u16;
+	    __s16  s16;
+	    __u32  u32;
+	    __s32  s32;
+	    __u8  *longdata;
+	} data;
+};
+
+/*
+ * HID report item format
+ */
+
+#define HID_ITEM_FORMAT_SHORT	0
+#define HID_ITEM_FORMAT_LONG	1
+
+/*
+ * Special tag indicating long items
+ */
+
+#define HID_ITEM_TAG_LONG	15
+
+/*
+ * HID report descriptor item type (prefix bit 2,3)
+ */
+
+#define HID_ITEM_TYPE_MAIN		0
+#define HID_ITEM_TYPE_GLOBAL		1
+#define HID_ITEM_TYPE_LOCAL		2
+#define HID_ITEM_TYPE_RESERVED		3
+
+/*
+ * HID report descriptor main item tags
+ */
+
+#define HID_MAIN_ITEM_TAG_INPUT			8
+#define HID_MAIN_ITEM_TAG_OUTPUT		9
+#define HID_MAIN_ITEM_TAG_FEATURE		11
+#define HID_MAIN_ITEM_TAG_BEGIN_COLLECTION	10
+#define HID_MAIN_ITEM_TAG_END_COLLECTION	12
+
+/*
+ * HID report descriptor main item contents
+ */
+
+#define HID_MAIN_ITEM_CONSTANT		0x001
+#define HID_MAIN_ITEM_VARIABLE		0x002
+#define HID_MAIN_ITEM_RELATIVE		0x004
+#define HID_MAIN_ITEM_WRAP		0x008	
+#define HID_MAIN_ITEM_NONLINEAR		0x010
+#define HID_MAIN_ITEM_NO_PREFERRED	0x020
+#define HID_MAIN_ITEM_NULL_STATE	0x040
+#define HID_MAIN_ITEM_VOLATILE		0x080
+#define HID_MAIN_ITEM_BUFFERED_BYTE	0x100
+
+/*
+ * HID report descriptor collection item types
+ */
+
+#define HID_COLLECTION_PHYSICAL		0
+#define HID_COLLECTION_APPLICATION	1
+#define HID_COLLECTION_LOGICAL		2
+
+/*
+ * HID report descriptor global item tags
+ */
+
+#define HID_GLOBAL_ITEM_TAG_USAGE_PAGE		0
+#define HID_GLOBAL_ITEM_TAG_LOGICAL_MINIMUM	1
+#define HID_GLOBAL_ITEM_TAG_LOGICAL_MAXIMUM	2
+#define HID_GLOBAL_ITEM_TAG_PHYSICAL_MINIMUM	3
+#define HID_GLOBAL_ITEM_TAG_PHYSICAL_MAXIMUM	4
+#define HID_GLOBAL_ITEM_TAG_UNIT_EXPONENT	5
+#define HID_GLOBAL_ITEM_TAG_UNIT		6
+#define HID_GLOBAL_ITEM_TAG_REPORT_SIZE		7
+#define HID_GLOBAL_ITEM_TAG_REPORT_ID		8
+#define HID_GLOBAL_ITEM_TAG_REPORT_COUNT	9
+#define HID_GLOBAL_ITEM_TAG_PUSH		10
+#define HID_GLOBAL_ITEM_TAG_POP			11
+
+/*
+ * HID report descriptor local item tags
+ */
+
+#define HID_LOCAL_ITEM_TAG_USAGE		0
+#define HID_LOCAL_ITEM_TAG_USAGE_MINIMUM	1
+#define HID_LOCAL_ITEM_TAG_USAGE_MAXIMUM	2
+#define HID_LOCAL_ITEM_TAG_DESIGNATOR_INDEX	3
+#define HID_LOCAL_ITEM_TAG_DESIGNATOR_MINIMUM	4
+#define HID_LOCAL_ITEM_TAG_DESIGNATOR_MAXIMUM	5
+#define HID_LOCAL_ITEM_TAG_STRING_INDEX		7
+#define HID_LOCAL_ITEM_TAG_STRING_MINIMUM	8
+#define HID_LOCAL_ITEM_TAG_STRING_MAXIMUM	9
+#define HID_LOCAL_ITEM_TAG_DELIMITER		10
+
+/*
+ * HID usage tables
+ */
+
+#define HID_USAGE_PAGE		0xffff0000
+
+#define HID_UP_GENDESK 		0x00010000
+#define HID_UP_KEYBOARD 	0x00070000
+#define HID_UP_LED 		0x00080000
+#define HID_UP_BUTTON 		0x00090000
+#define HID_UP_ORDINAL 		0x000a0000
+#define HID_UP_CONSUMER		0x000c0000
+#define HID_UP_DIGITIZER 	0x000d0000
+#define HID_UP_PID 		0x000f0000
+#define HID_UP_HPVENDOR         0xff7f0000
+
+#define HID_USAGE		0x0000ffff
+
+#define HID_GD_POINTER		0x00010001
+#define HID_GD_MOUSE		0x00010002
+#define HID_GD_JOYSTICK		0x00010004
+#define HID_GD_GAMEPAD		0x00010005
+#define HID_GD_HATSWITCH	0x00010039
+
+/*
+ * HID report types --- Ouch! HID spec says 1 2 3!
+ */
+
+#define HID_INPUT_REPORT	0
+#define HID_OUTPUT_REPORT	1
+#define HID_FEATURE_REPORT	2
+
+/*
+ * HID device quirks.
+ */
+
+#define HID_QUIRK_INVERT		0x001
+#define HID_QUIRK_NOTOUCH		0x002
+#define HID_QUIRK_IGNORE		0x004
+#define HID_QUIRK_NOGET			0x008
+#define HID_QUIRK_HIDDEV		0x010
+#define HID_QUIRK_BADPAD		0x020
+#define HID_QUIRK_MULTI_INPUT		0x040
+#define HID_QUIRK_2WHEEL_MOUSE_HACK	0x080
+#define HID_QUIRK_2WHEEL_MOUSE_HACK_ON	0x100
+
+/*
+ * This is the global environment of the parser. This information is
+ * persistent for main-items. The global environment can be saved and
+ * restored with PUSH/POP statements.
+ */
+
+struct hid_global {
+	unsigned usage_page;
+	__s32    logical_minimum;
+	__s32    logical_maximum;
+	__s32    physical_minimum;
+	__s32    physical_maximum;
+	__s32    unit_exponent;
+	unsigned unit;
+	unsigned report_id;
+	unsigned report_size;
+	unsigned report_count;
+};
+
+/*
+ * This is the local environment. It is persistent up the next main-item.
+ */
+
+#define HID_MAX_DESCRIPTOR_SIZE		4096
+#define HID_MAX_USAGES			1024
+#define HID_DEFAULT_NUM_COLLECTIONS	16
+
+struct hid_local {
+	unsigned usage[HID_MAX_USAGES]; /* usage array */
+	unsigned collection_index[HID_MAX_USAGES]; /* collection index array */
+	unsigned usage_index;
+	unsigned usage_minimum;
+	unsigned delimiter_depth;
+	unsigned delimiter_branch;
+};
+
+/*
+ * This is the collection stack. We climb up the stack to determine
+ * application and function of each field.
+ */
+
+struct hid_collection {
+	unsigned type;
+	unsigned usage;
+	unsigned level;
+};
+
+struct hid_usage {
+	unsigned  hid;			/* hid usage code */
+	unsigned  collection_index;	/* index into collection array */
+	__u16     code;			/* input driver code */
+	__u8      type;			/* input driver type */
+	__s8	  hat_min;		/* hat switch fun */
+	__s8	  hat_max;		/* ditto */
+};
+
+struct hid_field {
+	unsigned  physical;		/* physical usage for this field */
+	unsigned  logical;		/* logical usage for this field */
+	unsigned  application;		/* application usage for this field */
+	struct hid_usage *usage;	/* usage table for this function */
+	unsigned  maxusage;		/* maximum usage index */
+	unsigned  flags;		/* main-item flags (i.e. volatile,array,constant) */
+	unsigned  report_offset;	/* bit offset in the report */
+	unsigned  report_size;		/* size of this field in the report */
+	unsigned  report_count;		/* number of this field in the report */
+	unsigned  report_type;		/* (input,output,feature) */
+	__s32    *value;		/* last known value(s) */
+	__s32     logical_minimum;
+	__s32     logical_maximum;
+	__s32     physical_minimum;
+	__s32     physical_maximum;
+	__s32     unit_exponent;
+	unsigned  unit;
+	struct hid_report *report;	/* associated report */
+	unsigned index;			/* index into report->field[] */
+};
+
+#define HID_MAX_FIELDS 64
+
+struct hid_report {
+	struct list_head list;
+	unsigned id;					/* id of this report */
+	unsigned type;					/* report type */
+	struct hid_field *field[HID_MAX_FIELDS];	/* fields of the report */
+	unsigned maxfield;				/* maximum valid field index */
+	unsigned size;					/* size of the report (bits) */
+	struct hid_device *device;			/* associated device */
+};
+
+struct hid_report_enum {
+	unsigned numbered;
+	struct list_head report_list;
+	struct hid_report *report_id_hash[256];
+};
+
+#define HID_REPORT_TYPES 3
+
+struct hid_input {
+	struct list_head list;
+	struct hid_report *report;
+	struct input_dev *input;
+};
+
+struct hid_device {						/* device report descriptor */
+	 __u8 *rdesc;
+	unsigned rsize;
+	struct hid_collection *collection;			/* List of HID collections */
+	unsigned collection_size;				/* Number of allocated hid_collections */
+	unsigned maxcollection;					/* Number of parsed collections */
+	unsigned maxapplication;				/* Number of applications */
+	unsigned parser_version;				/* HID parser version */
+	unsigned country_code;					/* HID country code */
+	struct hid_report_enum report_enum[HID_REPORT_TYPES];
+
+	unsigned long quirks;					/* Various quirks the device can pull on us */
+
+	struct list_head inputs;				/* The list of inputs */
+
+	char name[128];						/* Device name */
+	char phys[64];						/* Device physical location */
+	char uniq[64];						/* Device unique identifier (serial #) */
+
+	unsigned short bus;
+	unsigned short vendor;
+	unsigned short product;
+	unsigned short version;
+
+	void *driver_data;
+
+	int (*send)(struct hid_device *device, unsigned char *data, int size);
+};
+
+#define HID_GLOBAL_STACK_SIZE 4
+#define HID_COLLECTION_STACK_SIZE 4
+
+struct hid_parser {
+	struct hid_global     global;
+	struct hid_global     global_stack[HID_GLOBAL_STACK_SIZE];
+	unsigned              global_stack_ptr;
+	struct hid_local      local;
+	unsigned              collection_stack[HID_COLLECTION_STACK_SIZE];
+	unsigned              collection_stack_ptr;
+	struct hid_device    *device;
+};
+
+#define hid_dump_input(a,b)	do { } while (0)
+#define hid_dump_device(c)	do { } while (0)
+#define hid_dump_field(a,b)	do { } while (0)
+#define resolv_usage(a)		do { } while (0)
+
+struct hid_device *hid_alloc_device(u8 *data, int size);
+void hid_free_device(struct hid_device *device);
+int hid_register_device(struct hid_device *device);
+void hid_unregister_device(struct hid_device *device);
+int hid_recv_report(struct hid_device *hid, int type, u8 *data, int size);
+
+#endif /* __HID_H */

--- linux-2.6.18/Makefile	2006-09-23 20:10:38.000000000 -0700
+++ linux-2.6.18-mh1/Makefile	2006-09-23 19:55:32.000000000 -0700
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 18
-EXTRAVERSION =
+EXTRAVERSION = -mh1aj
 NAME=Avast! A bilge rat!
 
 # *DOCUMENTATION*


--------------030806010102020705000905
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------030806010102020705000905
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------030806010102020705000905--
