Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [RFC 4/4] Bluetooth: Set link parameters for outgoing connections
Date: Wed, 28 Nov 2012 19:28:36 +0100
Message-Id: <1354127316-17431-5-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1354127316-17431-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1354127316-17431-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In order to establish the connection, the outgoing connection must also
request the codec. Here we need to set a bit in ACL connection flag to set up
the correct parameters if the ACL connection is not up yet.
---
 include/net/bluetooth/hci_core.h |    4 +++-
 net/bluetooth/hci_conn.c         |   24 +++++++++++++++++++-----
 net/bluetooth/l2cap_core.c       |    4 ++--
 net/bluetooth/mgmt.c             |    4 ++--
 net/bluetooth/sco.c              |    2 +-
 5 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index cb41552..e286196 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -438,6 +438,7 @@ enum {
 	HCI_CONN_SSP_ENABLED,
 	HCI_CONN_POWER_SAVE,
 	HCI_CONN_REMOTE_OOB,
+	HCI_CONN_SCO_TRANSP_DATA,
 };
 
 static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
@@ -585,7 +586,8 @@ void hci_chan_list_flush(struct hci_conn *conn);
 struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle);
 
 struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
-			     __u8 dst_type, __u8 sec_level, __u8 auth_type);
+			     __u8 dst_type, __u8 sec_level,
+			     __u8 auth_type, __u8 codec);
 int hci_conn_check_link_mode(struct hci_conn *conn);
 int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
 int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 25bfce0..1636dd5 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -179,9 +179,16 @@ void hci_setup_sync(struct hci_conn *conn, __u16 handle)
 
 	cp.tx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
 	cp.rx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
-	cp.max_latency    = __constant_cpu_to_le16(0xffff);
 	cp.voice_setting  = cpu_to_le16(hdev->voice_setting);
-	cp.retrans_effort = 0xff;
+
+	if (test_and_clear_bit(HCI_CONN_SCO_TRANSP_DATA, &conn->flags)) {
+		cp.voice_setting |= 3;
+		cp.max_latency    = __constant_cpu_to_le16(0x000d);
+		cp.retrans_effort = 0x02;
+	} else {
+		cp.max_latency    = __constant_cpu_to_le16(0xffff);
+		cp.retrans_effort = 0xff;
+	}
 
 	hci_send_cmd(hdev, HCI_OP_SETUP_SYNC_CONN, sizeof(cp), &cp);
 }
@@ -552,7 +559,8 @@ static struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 }
 
 static struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type,
-				bdaddr_t *dst, u8 sec_level, u8 auth_type)
+					bdaddr_t *dst, u8 sec_level,
+					u8 auth_type, u8 codec)
 {
 	struct hci_conn *acl;
 	struct hci_conn *sco;
@@ -575,6 +583,10 @@ static struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type,
 
 	hci_conn_hold(sco);
 
+	if (codec)
+		set_bit(HCI_CONN_SCO_TRANSP_DATA, &sco->flags);
+
+
 	if (acl->state == BT_CONNECTED &&
 	    (sco->state == BT_OPEN || sco->state == BT_CLOSED)) {
 		set_bit(HCI_CONN_POWER_SAVE, &acl->flags);
@@ -594,7 +606,8 @@ static struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type,
 
 /* Create SCO, ACL or LE connection. */
 struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
-			     __u8 dst_type, __u8 sec_level, __u8 auth_type)
+			     __u8 dst_type, __u8 sec_level, __u8 auth_type,
+			     __u8 codec)
 {
 	BT_DBG("%s dst %pMR type 0x%x", hdev->name, dst, type);
 
@@ -605,7 +618,8 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
 		return hci_connect_acl(hdev, dst, sec_level, auth_type);
 	case SCO_LINK:
 	case ESCO_LINK:
-		return hci_connect_sco(hdev, type, dst, sec_level, auth_type);
+		return hci_connect_sco(hdev, type, dst, sec_level, auth_type,
+				       codec);
 	}
 
 	return ERR_PTR(-EINVAL);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b52f66d..2ca70a4 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1690,10 +1690,10 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 
 	if (chan->dcid == L2CAP_CID_LE_DATA)
 		hcon = hci_connect(hdev, LE_LINK, dst, dst_type,
-				   chan->sec_level, auth_type);
+				   chan->sec_level, auth_type, 0);
 	else
 		hcon = hci_connect(hdev, ACL_LINK, dst, dst_type,
-				   chan->sec_level, auth_type);
+				   chan->sec_level, auth_type, 0);
 
 	if (IS_ERR(hcon)) {
 		err = PTR_ERR(hcon);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5d0ef75..d03405d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1917,10 +1917,10 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	if (cp->addr.type == BDADDR_BREDR)
 		conn = hci_connect(hdev, ACL_LINK, &cp->addr.bdaddr,
-				   cp->addr.type, sec_level, auth_type);
+				   cp->addr.type, sec_level, auth_type, 0);
 	else
 		conn = hci_connect(hdev, LE_LINK, &cp->addr.bdaddr,
-				   cp->addr.type, sec_level, auth_type);
+				   cp->addr.type, sec_level, auth_type, 0);
 
 	memset(&rp, 0, sizeof(rp));
 	bacpy(&rp.addr.bdaddr, &cp->addr.bdaddr);
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index be3e0b2..e86ae29 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -186,7 +186,7 @@ static int sco_connect(struct sock *sk)
 		type = SCO_LINK;
 
 	hcon = hci_connect(hdev, type, dst, BDADDR_BREDR, BT_SECURITY_LOW,
-			   HCI_AT_NO_BONDING);
+			   HCI_AT_NO_BONDING, sco_pi(sk)->codec);
 	if (IS_ERR(hcon)) {
 		err = PTR_ERR(hcon);
 		goto done;
-- 
1.7.9.5

