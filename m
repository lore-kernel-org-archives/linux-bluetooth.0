Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>,
	<par-gunnar.p.hjalmdahl@stericsson.com>,
	<ulrik.lauren@stericsson.com>
Subject: [PATCH 2/4] Bluetooth: Add BT_SCO_PARAMETERS SCO socket option.
Date: Tue, 14 Jun 2011 15:57:05 +0200
Message-ID: <1308059827-15095-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1308059827-15095-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1308059827-15095-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add BT_SCO_PARAMETERS socket option used to specify parameters for (e)SCO link.
This allows user-space to implement custom negotiation of link parameters i.e.
using reference parameters for eSCO from HFP.

For simplicity, packet type does not use logic defined in BT spec rather than
standard on/off logic and voice settings specifies only air coding format.
Conversion to proper values is done internally.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
---
 include/net/bluetooth/bluetooth.h |   10 +++++++
 include/net/bluetooth/hci.h       |    2 +
 include/net/bluetooth/hci_core.h  |    5 +++-
 include/net/bluetooth/sco.h       |    1 +
 net/bluetooth/hci_conn.c          |   39 ++++++++++++++++++++------
 net/bluetooth/l2cap_core.c        |    4 +-
 net/bluetooth/mgmt.c              |    3 +-
 net/bluetooth/sco.c               |   55 ++++++++++++++++++++++++++++++++++++-
 8 files changed, 105 insertions(+), 14 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 7bccaf9..795174b 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -76,6 +76,16 @@ struct bt_power {
 #define BT_POWER_FORCE_ACTIVE_OFF 0
 #define BT_POWER_FORCE_ACTIVE_ON  1
 
+#define BT_SCO_PARAMETERS	10
+struct bt_sco_parameters {
+	__u32 tx_bandwidth;
+	__u32 rx_bandwidth;
+	__u16 max_latency;
+	__u16 voice_setting;
+	__u8  retrans_effort;
+	__u16 pkt_type;
+} __packed;
+
 #define BT_INFO(fmt, arg...) printk(KERN_INFO "Bluetooth: " fmt "\n" , ## arg)
 #define BT_ERR(fmt, arg...)  printk(KERN_ERR "%s: " fmt "\n" , __func__ , ## arg)
 #define BT_DBG(fmt, arg...)  pr_debug("%s: " fmt "\n" , __func__ , ## arg)
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 65345cd..07c3076 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -159,6 +159,8 @@ enum {
 
 #define SCO_ESCO_MASK  (ESCO_HV1 | ESCO_HV2 | ESCO_HV3)
 #define EDR_ESCO_MASK  (ESCO_2EV3 | ESCO_3EV3 | ESCO_2EV5 | ESCO_3EV5)
+#define ALL_ESCO_MASK  (SCO_ESCO_MASK | ESCO_EV3 | ESCO_EV4 | ESCO_EV5 | \
+			EDR_ESCO_MASK)
 
 /* ACL flags */
 #define ACL_START_NO_FLUSH	0x00
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index fe05946..5048472 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -274,6 +274,8 @@ struct hci_conn {
 	void		*sco_data;
 	void		*priv;
 
+	struct bt_sco_parameters	*sco_parameters;
+
 	struct hci_conn	*link;
 
 	void (*connect_cfm_cb)	(struct hci_conn *conn, u8 status);
@@ -436,7 +438,8 @@ void hci_conn_hash_flush(struct hci_dev *hdev);
 void hci_conn_check_pending(struct hci_dev *hdev);
 
 struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
-						__u8 sec_level, __u8 auth_type);
+				__u8 sec_level, __u8 auth_type,
+				struct bt_sco_parameters *sco_parameters);
 int hci_conn_check_link_mode(struct hci_conn *conn);
 int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
 int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type);
diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
index 1e35c43..4fa57bf 100644
--- a/include/net/bluetooth/sco.h
+++ b/include/net/bluetooth/sco.h
@@ -73,6 +73,7 @@ struct sco_conn {
 struct sco_pinfo {
 	struct bt_sock	bt;
 	__u32		flags;
+	struct bt_sco_parameters	param;
 	struct sco_conn	*conn;
 };
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e203622..b02e043 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -147,16 +147,21 @@ void hci_add_sco(struct hci_conn *conn, __u16 handle)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_add_sco cp;
+	struct bt_sco_parameters *p = conn->sco_parameters;
+	__u16 pkt_type;
 
 	BT_DBG("%p", conn);
 
+	/* HCI_Add_SCO_Connection uses shifted bitmask for packet type */
+	pkt_type = (p->pkt_type << 5) & conn->pkt_type;
+
 	conn->state = BT_CONNECT;
 	conn->out = 1;
 
 	conn->attempt++;
 
 	cp.handle   = cpu_to_le16(handle);
-	cp.pkt_type = cpu_to_le16(conn->pkt_type);
+	cp.pkt_type = cpu_to_le16(pkt_type);
 
 	hci_send_cmd(hdev, HCI_OP_ADD_SCO, sizeof(cp), &cp);
 }
@@ -165,23 +170,35 @@ void hci_setup_sync(struct hci_conn *conn, __u16 handle)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_setup_sync_conn cp;
+	struct bt_sco_parameters *p = conn->sco_parameters;
+	__u16 voice_setting;
+	__u16 pkt_type;
 
 	BT_DBG("%p", conn);
 
+	/*
+	 * Combine voice setting using device parameters and air coding
+	 * format set by user.
+	 */
+	voice_setting = (hdev->voice_setting & 0xfffc) |
+					(p->voice_setting & 0x0003);
+
+	/* Bits for EDR packets have inverted logic in BT spec. */
+	pkt_type = (p->pkt_type & conn->pkt_type) ^ EDR_ESCO_MASK;
+
 	conn->state = BT_CONNECT;
 	conn->out = 1;
 
 	conn->attempt++;
 
 	cp.handle   = cpu_to_le16(handle);
-	/* Bits for EDR packets have inverted logic in BT spec. */
-	cp.pkt_type = cpu_to_le16(conn->pkt_type ^ EDR_ESCO_MASK);
 
-	cp.tx_bandwidth   = cpu_to_le32(0x00001f40);
-	cp.rx_bandwidth   = cpu_to_le32(0x00001f40);
-	cp.max_latency    = cpu_to_le16(0xffff);
-	cp.voice_setting  = cpu_to_le16(hdev->voice_setting);
-	cp.retrans_effort = 0xff;
+	cp.tx_bandwidth   = cpu_to_le32(p->tx_bandwidth);
+	cp.rx_bandwidth   = cpu_to_le32(p->rx_bandwidth);
+	cp.max_latency    = cpu_to_le16(p->max_latency);
+	cp.voice_setting  = cpu_to_le16(voice_setting);
+	cp.retrans_effort = p->retrans_effort;
+	cp.pkt_type       = cpu_to_le16(pkt_type);
 
 	hci_send_cmd(hdev, HCI_OP_SETUP_SYNC_CONN, sizeof(cp), &cp);
 }
@@ -489,7 +506,9 @@ EXPORT_SYMBOL(hci_get_route);
 
 /* Create SCO, ACL or LE connection.
  * Device _must_ be locked */
-struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8 sec_level, __u8 auth_type)
+struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
+				__u8 sec_level, __u8 auth_type,
+				struct bt_sco_parameters *sco_parameters)
 {
 	struct hci_conn *acl;
 	struct hci_conn *sco;
@@ -554,6 +573,8 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 
 	hci_conn_hold(sco);
 
+	sco->sco_parameters = sco_parameters;
+
 	if (acl->state == BT_CONNECTED &&
 			(sco->state == BT_OPEN || sco->state == BT_CLOSED)) {
 		acl->power_save = 1;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 584a423..21380f8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1105,10 +1105,10 @@ int l2cap_chan_connect(struct l2cap_chan *chan)
 
 	if (chan->dcid == L2CAP_CID_LE_DATA)
 		hcon = hci_connect(hdev, LE_LINK, dst,
-					chan->sec_level, auth_type);
+					chan->sec_level, auth_type, NULL);
 	else
 		hcon = hci_connect(hdev, ACL_LINK, dst,
-					chan->sec_level, auth_type);
+					chan->sec_level, auth_type, NULL);
 
 	if (IS_ERR(hcon)) {
 		err = PTR_ERR(hcon);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d192089..b0ffb8c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1353,7 +1353,8 @@ static int pair_device(struct sock *sk, u16 index, unsigned char *data, u16 len)
 		auth_type = HCI_AT_DEDICATED_BONDING_MITM;
 	}
 
-	conn = hci_connect(hdev, ACL_LINK, &cp->bdaddr, sec_level, auth_type);
+	conn = hci_connect(hdev, ACL_LINK, &cp->bdaddr, sec_level,
+							auth_type, NULL);
 	if (IS_ERR(conn)) {
 		err = PTR_ERR(conn);
 		goto unlock;
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index cb4fb78..c432428 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -177,6 +177,7 @@ static int sco_connect(struct sock *sk)
 {
 	bdaddr_t *src = &bt_sk(sk)->src;
 	bdaddr_t *dst = &bt_sk(sk)->dst;
+	struct bt_sco_parameters *param = &sco_pi(sk)->param;
 	struct sco_conn *conn;
 	struct hci_conn *hcon;
 	struct hci_dev  *hdev;
@@ -195,7 +196,8 @@ static int sco_connect(struct sock *sk)
 	else
 		type = SCO_LINK;
 
-	hcon = hci_connect(hdev, type, dst, BT_SECURITY_LOW, HCI_AT_NO_BONDING);
+	hcon = hci_connect(hdev, type, dst, BT_SECURITY_LOW, HCI_AT_NO_BONDING,
+									param);
 	if (IS_ERR(hcon)) {
 		err = PTR_ERR(hcon);
 		goto done;
@@ -401,10 +403,24 @@ static void sco_sock_close(struct sock *sk)
 
 static void sco_sock_init(struct sock *sk, struct sock *parent)
 {
+	struct sco_pinfo *pi = sco_pi(sk);
+
 	BT_DBG("sk %p", sk);
 
 	if (parent)
 		sk->sk_type = parent->sk_type;
+
+	pi->param.tx_bandwidth =   0x1f40; /* 8000 */
+	pi->param.rx_bandwidth =   0x1f40;
+	pi->param.max_latency =    0xffff; /* Don't care */
+
+	/* Only Air Coding Format matters here, other data will be
+	 * overriden by device settings during connection setup.
+	 */
+	pi->param.voice_setting  = 0x0000; /* CVSD */
+
+	pi->param.retrans_effort = 0xff;   /* Don't care */
+	pi->param.pkt_type       = ALL_ESCO_MASK;
 }
 
 static struct proto sco_proto = {
@@ -658,13 +674,37 @@ static int sco_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 static int sco_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
+	int len;
 	int err = 0;
+	struct bt_sco_parameters *param;
 
 	BT_DBG("sk %p", sk);
 
+	if (level != SOL_BLUETOOTH)
+		return -ENOPROTOOPT;
+
 	lock_sock(sk);
 
 	switch (optname) {
+	case BT_SCO_PARAMETERS:
+		/* We do not support changing SCO parameters during
+		 * connection.
+		 */
+		if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND) {
+			err = -EBUSY;
+			break;
+		}
+
+		param = &sco_pi(sk)->param;
+
+		len = min_t(unsigned int, sizeof(*param), optlen);
+		if (copy_from_user((char *) param, optval, len)) {
+			err = -EFAULT;
+			break;
+		}
+
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -734,18 +774,31 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname, char
 {
 	struct sock *sk = sock->sk;
 	int len, err = 0;
+	struct bt_sco_parameters *params;
 
 	BT_DBG("sk %p", sk);
 
 	if (level == SOL_SCO)
 		return sco_sock_getsockopt_old(sock, optname, optval, optlen);
 
+	if (level != SOL_BLUETOOTH)
+		return -ENOPROTOOPT;
+
 	if (get_user(len, optlen))
 		return -EFAULT;
 
 	lock_sock(sk);
 
 	switch (optname) {
+	case BT_SCO_PARAMETERS:
+		params = &sco_pi(sk)->param;
+
+		len = min_t(unsigned int, len, sizeof(*params));
+		if (copy_to_user(optval, (char *) params, len))
+			err = -EFAULT;
+
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
1.7.5.4

