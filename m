Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 02/10] Bluetooth: Fix checkpatch errors and some code style issues in bnep
Date: Mon, 21 Mar 2011 14:19:58 +0100
Message-ID: <1300713606-23523-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1300713606-23523-1-git-send-email-szymon.janc@tieto.com>
References: <1300713606-23523-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 net/bluetooth/bnep/bnep.h |  146 ++++++++++++++++++++++----------------------
 net/bluetooth/bnep/core.c |   37 +++++++-----
 2 files changed, 94 insertions(+), 89 deletions(-)

diff --git a/net/bluetooth/bnep/bnep.h b/net/bluetooth/bnep/bnep.h
index 7067254..d768e04 100644
--- a/net/bluetooth/bnep/bnep.h
+++ b/net/bluetooth/bnep/bnep.h
@@ -23,88 +23,88 @@
 #include <linux/crc32.h>
 #include <net/bluetooth/bluetooth.h>
 
-// Limits
-#define BNEP_MAX_PROTO_FILTERS     5
-#define BNEP_MAX_MULTICAST_FILTERS 20
-
-// UUIDs
-#define BNEP_BASE_UUID 0x0000000000001000800000805F9B34FB
-#define BNEP_UUID16    0x02
-#define BNEP_UUID32    0x04
-#define BNEP_UUID128   0x16
-
-#define BNEP_SVC_PANU  0x1115
-#define BNEP_SVC_NAP   0x1116
-#define BNEP_SVC_GN    0x1117
-
-// Packet types
-#define BNEP_GENERAL               0x00
-#define BNEP_CONTROL               0x01
-#define BNEP_COMPRESSED            0x02
-#define BNEP_COMPRESSED_SRC_ONLY   0x03
-#define BNEP_COMPRESSED_DST_ONLY   0x04
-
-// Control types
-#define BNEP_CMD_NOT_UNDERSTOOD    0x00
-#define BNEP_SETUP_CONN_REQ        0x01
-#define BNEP_SETUP_CONN_RSP        0x02
-#define BNEP_FILTER_NET_TYPE_SET   0x03
-#define BNEP_FILTER_NET_TYPE_RSP   0x04
-#define BNEP_FILTER_MULTI_ADDR_SET 0x05
-#define BNEP_FILTER_MULTI_ADDR_RSP 0x06
-
-// Extension types
-#define BNEP_EXT_CONTROL           0x00
-
-// Response messages
-#define BNEP_SUCCESS               0x00
-
-#define BNEP_CONN_INVALID_DST      0x01
-#define BNEP_CONN_INVALID_SRC      0x02
-#define BNEP_CONN_INVALID_SVC      0x03
-#define BNEP_CONN_NOT_ALLOWED      0x04
-
-#define BNEP_FILTER_UNSUPPORTED_REQ    0x01
-#define BNEP_FILTER_INVALID_RANGE      0x02
-#define BNEP_FILTER_INVALID_MCADDR     0x02
-#define BNEP_FILTER_LIMIT_REACHED      0x03
-#define BNEP_FILTER_DENIED_SECURITY    0x04
-
-// L2CAP settings
-#define BNEP_MTU         1691
-#define BNEP_PSM	 0x0f
-#define BNEP_FLUSH_TO    0xffff
-#define BNEP_CONNECT_TO  15
-#define BNEP_FILTER_TO   15
-
-// Headers
-#define BNEP_TYPE_MASK	 0x7f
-#define BNEP_EXT_HEADER	 0x80
+/* Limits */
+#define BNEP_MAX_PROTO_FILTERS		5
+#define BNEP_MAX_MULTICAST_FILTERS	20
+
+/* UUIDs */
+#define BNEP_BASE_UUID	0x0000000000001000800000805F9B34FB
+#define BNEP_UUID16	0x02
+#define BNEP_UUID32	0x04
+#define BNEP_UUID128	0x16
+
+#define BNEP_SVC_PANU	0x1115
+#define BNEP_SVC_NAP	0x1116
+#define BNEP_SVC_GN	0x1117
+
+/* Packet types */
+#define BNEP_GENERAL			0x00
+#define BNEP_CONTROL			0x01
+#define BNEP_COMPRESSED			0x02
+#define BNEP_COMPRESSED_SRC_ONLY	0x03
+#define BNEP_COMPRESSED_DST_ONLY	0x04
+
+/* Control types */
+#define BNEP_CMD_NOT_UNDERSTOOD		0x00
+#define BNEP_SETUP_CONN_REQ		0x01
+#define BNEP_SETUP_CONN_RSP		0x02
+#define BNEP_FILTER_NET_TYPE_SET	0x03
+#define BNEP_FILTER_NET_TYPE_RSP	0x04
+#define BNEP_FILTER_MULTI_ADDR_SET	0x05
+#define BNEP_FILTER_MULTI_ADDR_RSP	0x06
+
+/* Extension types */
+#define BNEP_EXT_CONTROL 0x00
+
+/* Response messages */
+#define BNEP_SUCCESS 0x00
+
+#define BNEP_CONN_INVALID_DST 0x01
+#define BNEP_CONN_INVALID_SRC 0x02
+#define BNEP_CONN_INVALID_SVC 0x03
+#define BNEP_CONN_NOT_ALLOWED 0x04
+
+#define BNEP_FILTER_UNSUPPORTED_REQ	0x01
+#define BNEP_FILTER_INVALID_RANGE	0x02
+#define BNEP_FILTER_INVALID_MCADDR	0x02
+#define BNEP_FILTER_LIMIT_REACHED	0x03
+#define BNEP_FILTER_DENIED_SECURITY	0x04
+
+/* L2CAP settings */
+#define BNEP_MTU	1691
+#define BNEP_PSM	0x0f
+#define BNEP_FLUSH_TO	0xffff
+#define BNEP_CONNECT_TO	15
+#define BNEP_FILTER_TO	15
+
+/* Headers */
+#define BNEP_TYPE_MASK	0x7f
+#define BNEP_EXT_HEADER	0x80
 
 struct bnep_setup_conn_req {
-	__u8  type;
-	__u8  ctrl;
-	__u8  uuid_size;
-	__u8  service[0];
+	__u8 type;
+	__u8 ctrl;
+	__u8 uuid_size;
+	__u8 service[0];
 } __packed;
 
 struct bnep_set_filter_req {
-	__u8  type;
-	__u8  ctrl;
+	__u8 type;
+	__u8 ctrl;
 	__be16 len;
-	__u8  list[0];
+	__u8 list[0];
 } __packed;
 
 struct bnep_control_rsp {
-	__u8  type;
-	__u8  ctrl;
+	__u8 type;
+	__u8 ctrl;
 	__be16 resp;
 } __packed;
 
 struct bnep_ext_hdr {
-	__u8  type;
-	__u8  len;
-	__u8  data[0];
+	__u8 type;
+	__u8 len;
+	__u8 data[0];
 } __packed;
 
 /* BNEP ioctl defines */
@@ -114,10 +114,10 @@ struct bnep_ext_hdr {
 #define BNEPGETCONNINFO	_IOR('B', 211, int)
 
 struct bnep_connadd_req {
-	int   sock;       // Connected socket
+	int   sock;		/* Connected socket */
 	__u32 flags;
 	__u16 role;
-	char  device[16]; // Name of the Ethernet device
+	char  device[16];	/* Name of the Ethernet device */
 };
 
 struct bnep_conndel_req {
@@ -148,7 +148,7 @@ int bnep_del_connection(struct bnep_conndel_req *req);
 int bnep_get_connlist(struct bnep_connlist_req *req);
 int bnep_get_conninfo(struct bnep_conninfo *ci);
 
-// BNEP sessions
+/* BNEP sessions */
 struct bnep_session {
 	struct list_head list;
 
@@ -173,7 +173,7 @@ void bnep_sock_cleanup(void);
 
 static inline int bnep_mc_hash(__u8 *addr)
 {
-	return (crc32_be(~0, addr, ETH_ALEN) >> 26);
+	return crc32_be(~0, addr, ETH_ALEN) >> 26;
 }
 
 #endif
diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 940b4e1..0a2e76b 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -131,7 +131,8 @@ static int bnep_ctrl_set_netfilter(struct bnep_session *s, __be16 *data, int len
 		return -EILSEQ;
 
 	n = get_unaligned_be16(data);
-	data++; len -= 2;
+	data++;
+	len -= 2;
 
 	if (len < n)
 		return -EILSEQ;
@@ -176,7 +177,8 @@ static int bnep_ctrl_set_mcfilter(struct bnep_session *s, u8 *data, int len)
 		return -EILSEQ;
 
 	n = get_unaligned_be16(data);
-	data += 2; len -= 2;
+	data += 2;
+	len -= 2;
 
 	if (len < n)
 		return -EILSEQ;
@@ -198,8 +200,10 @@ static int bnep_ctrl_set_mcfilter(struct bnep_session *s, u8 *data, int len)
 		for (; n > 0; n--) {
 			u8 a1[6], *a2;
 
-			memcpy(a1, data, ETH_ALEN); data += ETH_ALEN;
-			a2 = data; data += ETH_ALEN;
+			memcpy(a1, data, ETH_ALEN);
+			data += ETH_ALEN;
+			a2 = data;
+			data += ETH_ALEN;
 
 			BT_DBG("mc filter %s -> %s",
 				batostr((void *) a1), batostr((void *) a2));
@@ -231,7 +235,8 @@ static int bnep_rx_control(struct bnep_session *s, void *data, int len)
 	u8  cmd = *(u8 *)data;
 	int err = 0;
 
-	data++; len--;
+	data++;
+	len--;
 
 	switch (cmd) {
 	case BNEP_CMD_NOT_UNDERSTOOD:
@@ -315,7 +320,8 @@ static inline int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 
 	dev->stats.rx_bytes += skb->len;
 
-	type = *(u8 *) skb->data; skb_pull(skb, 1);
+	type = *(u8 *) skb->data;
+	skb_pull(skb, 1);
 
 	if ((type & BNEP_TYPE_MASK) >= sizeof(__bnep_rx_hlen))
 		goto badframe;
@@ -370,14 +376,14 @@ static inline int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 
 	case BNEP_COMPRESSED_DST_ONLY:
 		memcpy(__skb_put(nskb, ETH_ALEN), skb_mac_header(skb),
-		       ETH_ALEN);
+								ETH_ALEN);
 		memcpy(__skb_put(nskb, ETH_ALEN + 2), s->eh.h_source,
-		       ETH_ALEN + 2);
+								ETH_ALEN + 2);
 		break;
 
 	case BNEP_GENERAL:
 		memcpy(__skb_put(nskb, ETH_ALEN * 2), skb_mac_header(skb),
-		       ETH_ALEN * 2);
+								ETH_ALEN * 2);
 		put_unaligned(s->eh.h_proto, (__be16 *) __skb_put(nskb, 2));
 		break;
 	}
@@ -481,7 +487,7 @@ static int bnep_session(void *arg)
 	while (!atomic_read(&s->killed)) {
 		set_current_state(TASK_INTERRUPTIBLE);
 
-		// RX
+		/* RX */
 		while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
 			skb_orphan(skb);
 			bnep_rx_frame(s, skb);
@@ -490,7 +496,7 @@ static int bnep_session(void *arg)
 		if (sk->sk_state != BT_CONNECTED)
 			break;
 
-		// TX
+		/* TX */
 		while ((skb = skb_dequeue(&sk->sk_write_queue)))
 			if (bnep_tx_frame(s, skb))
 				break;
@@ -558,8 +564,8 @@ int bnep_add_connection(struct bnep_connadd_req *req, struct socket *sock)
 
 	/* session struct allocated as private part of net_device */
 	dev = alloc_netdev(sizeof(struct bnep_session),
-			   (*req->device) ? req->device : "bnep%d",
-			   bnep_net_setup);
+				(*req->device) ? req->device : "bnep%d",
+				bnep_net_setup);
 	if (!dev)
 		return -ENOMEM;
 
@@ -574,7 +580,7 @@ int bnep_add_connection(struct bnep_connadd_req *req, struct socket *sock)
 	s = netdev_priv(dev);
 
 	/* This is rx header therefore addresses are swapped.
-	 * ie eh.h_dest is our local address. */
+	 * ie. eh.h_dest is our local address. */
 	memcpy(s->eh.h_dest,   &src, ETH_ALEN);
 	memcpy(s->eh.h_source, &dst, ETH_ALEN);
 	memcpy(dev->dev_addr, s->eh.h_dest, ETH_ALEN);
@@ -600,9 +606,8 @@ int bnep_add_connection(struct bnep_connadd_req *req, struct socket *sock)
 	SET_NETDEV_DEVTYPE(dev, &bnep_type);
 
 	err = register_netdev(dev);
-	if (err) {
+	if (err)
 		goto failed;
-	}
 
 	__bnep_link_session(s);
 
-- 
1.7.0.4

