Return-Path: <jt@bougret.hpl.hp.com>
Date: Wed, 4 Aug 2004 18:33:35 -0700
To: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ mailing list <bluez-devel@lists.sourceforge.net>
Subject: [PATCH 2.6] link trigger for AODV and +
Message-ID: <20040805013335.GA13608@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
List-ID: <bluez-devel.lists.sourceforge.net>

	Hi Marcel,

	This is a patch I wrote a couple of months back, and I would
like to submit it for inclusion in the BlueZ stack. The reason I think
we should include that is that the patch has minimal footprint and
offer a feature unavailable by other means...

	The idea is that this patch add an event that is trigger when
a connection is likely to fail, but before the connection get
disconnected. This is similar to the TxDrop iwevent implemented for
802.11 (in Wireless Extensions).
	In many cases, you don't want to use LinkSupervisionTimeout,
because it disconnect the connection before you have time to take
corrective action (i.e. game over).
	The main use is for Ad-Hoc routing protocol (mesh) such as
AODV. In the litterature, this is called a "link trigger". I can give
you real world example of people using the TxDrop iwevent in AODV
implementations.
	Another example would be to use this event to generate a
warning to the user that his connection is about to drop. Because
LinkSupervisionTimeout is so large, most users would be able to use
this warning to get back into range or away from the interferer
without loosing the connection.
	I could go at lenght on why this is useful and why this is the
way to implement it, but I don't want to waste your time.

	Patch has been tested in kernel from 2.6.1 to 2.6.8. I also
have a patch for 2.4.X. Please apply...

	Regards,

	Jean

---------------------------------------------------------

diff -u -p linux/net/bluetooth/Kconfig.m1 linux/net/bluetooth/Kconfig
--- linux/net/bluetooth/Kconfig.m1	Tue Aug  3 11:00:19 2004
+++ linux/net/bluetooth/Kconfig	Tue Aug  3 11:05:54 2004
@@ -60,4 +60,14 @@ source "net/bluetooth/cmtp/Kconfig"
 source "net/bluetooth/hidp/Kconfig"
 
 source "drivers/bluetooth/Kconfig"
+ 
+config BT_WARNDELAY
+	bool "ACL delay warning"
+	depends on BT
+	help
+	  Trigger a HCI event is ACL transmit did not complete in a certain
+	  time. This is a "link trigger" used to optimise most Ad-Hoc
+	  routing protocols such as AODV, and can be used when you need to
+	  know very quickly if a L2CAP connection is going bad...
 
+	  Just say N if you don't understand the above.
diff -u -p linux/include/net/bluetooth/hci.m1.h linux/include/net/bluetooth/hci.h
--- linux/include/net/bluetooth/hci.m1.h	Tue Aug  3 11:00:42 2004
+++ linux/include/net/bluetooth/hci.h	Tue Aug  3 11:02:08 2004
@@ -92,6 +92,7 @@ enum {
 #define HCISETACLMTU	_IOW('H', 227, int)
 #define HCISETSCOMTU	_IOW('H', 228, int)
 #define HCISETRAWVND	_IOW('H', 229, int)
+#define HCISETWARNDELAY	_IOW('H', 230, int)
 
 #define HCIINQUIRY	_IOR('H', 240, int)
 
@@ -563,6 +564,12 @@ struct hci_ev_si_security {
 	__u16    proto;
 	__u16    subproto;
 	__u8     incoming;
+} __attribute__ ((packed));
+
+#define HCI_EV_SI_WARNDELAY  	0x03
+struct hci_ev_si_warndelay {
+	__u16    handle;
+	__u32    delay;		/* ms */
 } __attribute__ ((packed));
 
 /* ---- HCI Packet structures ---- */
diff -u -p linux/include/net/bluetooth/hci_core.m1.h linux/include/net/bluetooth/hci_core.h
--- linux/include/net/bluetooth/hci_core.m1.h	Tue Aug  3 11:00:53 2004
+++ linux/include/net/bluetooth/hci_core.h	Tue Aug  3 11:02:08 2004
@@ -72,6 +72,9 @@ struct hci_dev {
 	__u16		pkt_type;
 	__u16		link_policy;
 	__u16		link_mode;
+#ifdef CONFIG_BT_WARNDELAY
+	unsigned long   warn_delay;
+#endif	/* CONFIG_BT_WARNDELAY */
 
 	unsigned long	quirks;
 
@@ -145,6 +148,10 @@ struct hci_conn {
 	unsigned long	 pend;
 	
 	unsigned int	 sent;
+#ifdef CONFIG_BT_WARNDELAY
+	unsigned long    last_ack;
+	struct timer_list warndelay_timer;
+#endif	/* CONFIG_BT_WARNDELAY */
 	
 	struct sk_buff_head data_q;
 
diff -u -p linux/net/bluetooth/hci_conn.m1.c linux/net/bluetooth/hci_conn.c
--- linux/net/bluetooth/hci_conn.m1.c	Tue Aug  3 11:01:12 2004
+++ linux/net/bluetooth/hci_conn.c	Tue Aug  3 11:02:08 2004
@@ -140,6 +140,35 @@ static void hci_conn_init_timer(struct h
 	conn->timer.data = (unsigned long)conn;
 }
 
+#ifdef CONFIG_BT_WARNDELAY
+static void hci_warndelay_timeout(unsigned long arg)
+{
+	struct hci_conn *conn = (void *)arg;
+	struct hci_dev  *hdev = conn->hdev;
+	struct hci_ev_si_warndelay ev;
+
+	/* We didn't receive the Tx ack in the expected time, generate
+	 * an event to user space. Jean II */
+
+	BT_DBG("conn %p state %d", conn, conn->state);
+
+	hci_dev_lock(hdev);
+
+	/* Send event to HCI sockets */
+	ev.handle = conn->handle;
+	ev.delay  = (jiffies - conn->last_ack) * 1000 / HZ;
+	hci_si_event(NULL, HCI_EV_SI_WARNDELAY,
+		     sizeof(ev), &ev);
+
+	/* Re-arm timer */
+	mod_timer(&(conn->warndelay_timer),
+		  jiffies + hdev->warn_delay);
+
+	hci_dev_unlock(hdev);
+	return;
+}
+#endif	/* CONFIG_BT_WARNDELAY */
+
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 {
 	struct hci_conn *conn;
@@ -157,6 +186,12 @@ struct hci_conn *hci_conn_add(struct hci
 
 	skb_queue_head_init(&conn->data_q);
 	hci_conn_init_timer(conn);
+#ifdef CONFIG_BT_WARNDELAY
+	/* This timer generates event on ACL stalls. Jean II */
+	init_timer(&conn->warndelay_timer);
+	conn->warndelay_timer.function = hci_warndelay_timeout;
+	conn->warndelay_timer.data = (unsigned long) conn;
+#endif	/* CONFIG_BT_WARNDELAY */
 
 	atomic_set(&conn->refcnt, 0);
 
@@ -179,6 +214,10 @@ int hci_conn_del(struct hci_conn *conn)
 	BT_DBG("%s conn %p handle %d", hdev->name, conn, conn->handle);
 
 	hci_conn_del_timer(conn);
+#ifdef CONFIG_BT_WARNDELAY
+	if(timer_pending(&(conn->warndelay_timer)))
+		del_timer(&(conn->warndelay_timer));
+#endif	/* CONFIG_BT_WARNDELAY */
 
 	if (conn->type == SCO_LINK) {
 		struct hci_conn *acl = conn->link;
diff -u -p linux/net/bluetooth/hci_core.m1.c linux/net/bluetooth/hci_core.c
--- linux/net/bluetooth/hci_core.m1.c	Tue Aug  3 11:01:25 2004
+++ linux/net/bluetooth/hci_core.c	Tue Aug  3 11:02:08 2004
@@ -677,6 +677,17 @@ int hci_dev_cmd(unsigned int cmd, void _
 		hdev->sco_pkts = *((__u16 *)&dr.dev_opt + 0);
 		break;
 
+#ifdef CONFIG_BT_WARNDELAY
+	case HCISETWARNDELAY:
+		/* This setting is "per interface". You may want to do
+		 * it "per connection", but that's much more messy.
+		 * To disable, set 0
+		 * The value is in ms, so convert it to jiffies.
+		 * Jean II */
+		hdev->warn_delay = (unsigned long) dr.dev_opt * HZ / 1000;
+		break;
+#endif	/* CONFIG_BT_WARNDELAY */
+
 	default:
 		err = -EINVAL;
 		break;
@@ -816,6 +827,9 @@ int hci_register_dev(struct hci_dev *hde
 	hdev->flags = 0;
 	hdev->pkt_type  = (HCI_DM1 | HCI_DH1 | HCI_HV1);
 	hdev->link_mode = (HCI_LM_ACCEPT);
+#ifdef CONFIG_BT_WARNDELAY
+	hdev->warn_delay = 0;		/* Disabled */
+#endif	/* CONFIG_BT_WARNDELAY */
 
 	tasklet_init(&hdev->cmd_task, hci_cmd_task,(unsigned long) hdev);
 	tasklet_init(&hdev->rx_task, hci_rx_task, (unsigned long) hdev);
@@ -1166,6 +1180,15 @@ static inline void hci_sched_acl(struct 
 			BT_DBG("skb %p len %d", skb, skb->len);
 			hci_send_frame(skb);
 			hdev->acl_last_tx = jiffies;
+
+#ifdef CONFIG_BT_WARNDELAY
+			/* Start the warndelay timer if not pending */
+			if ((conn->sent == 0) && (hdev->warn_delay != 0)) {
+				conn->last_ack = jiffies;
+				conn->warndelay_timer.expires = jiffies + hdev->warn_delay;
+				add_timer(&(conn->warndelay_timer));
+			}
+#endif	/* CONFIG_BT_WARNDELAY */
 
 			hdev->acl_cnt--;
 			conn->sent++;
diff -u -p linux/net/bluetooth/hci_event.m1.c linux/net/bluetooth/hci_event.c
--- linux/net/bluetooth/hci_event.m1.c	Tue Aug  3 11:01:36 2004
+++ linux/net/bluetooth/hci_event.c	Tue Aug  3 11:02:08 2004
@@ -679,6 +679,21 @@ static inline void hci_num_comp_pkts_evt
 		if (conn) {
 			conn->sent -= count;
 
+#ifdef CONFIG_BT_WARNDELAY
+			if ((count) && (conn->type == ACL_LINK) &&
+			    (hdev->warn_delay != 0)) {
+				if (conn->sent == 0) {
+					/* No pending packets, cancel */
+					del_timer(&(conn->warndelay_timer));
+				} else {
+					/* Pending packets, re-arm */
+					conn->last_ack = jiffies;
+					mod_timer(&(conn->warndelay_timer),
+						  jiffies + hdev->warn_delay);
+				}
+			}
+#endif	/* CONFIG_BT_WARNDELAY */
+
 			if (conn->type == SCO_LINK) {
 				if ((hdev->sco_cnt += count) > hdev->sco_pkts)
 					hdev->sco_cnt = hdev->sco_pkts;
diff -u -p linux/net/bluetooth/hci_sock.m1.c linux/net/bluetooth/hci_sock.c
--- linux/net/bluetooth/hci_sock.m1.c	Tue Aug  3 11:01:48 2004
+++ linux/net/bluetooth/hci_sock.c	Tue Aug  3 11:02:08 2004
@@ -241,6 +241,7 @@ static int hci_sock_ioctl(struct socket 
 	case HCISETLINKMODE:
 	case HCISETACLMTU:
 	case HCISETSCOMTU:
+	case HCISETWARNDELAY:
 		if (!capable(CAP_NET_ADMIN))
 			return -EACCES;
 		return hci_dev_cmd(cmd, argp);
