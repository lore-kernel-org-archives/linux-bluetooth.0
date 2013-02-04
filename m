Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v3 4/5] Bluetooth: Parameters for outgoing SCO connections
Date: Mon,  4 Feb 2013 14:56:27 +0100
Message-Id: <1359986188-24432-4-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1359986188-24432-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1359986188-24432-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In order to establish a transparent SCO connection, the correct settings must
be specified in the SetupSynchronousConnection request. For that, a bit is set
in ACL connection flags to set up the desired parameters. If this bit is not
set, a legacy SCO connection will be requested.
This patch uses T2 settings.

Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
---
 include/net/bluetooth/hci_core.h |    3 +++
 net/bluetooth/hci_conn.c         |   29 +++++++++++++++++++----------
 net/bluetooth/sco.c              |    3 +--
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f3be454..4a216e5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -443,6 +443,7 @@ enum {
 	HCI_CONN_SSP_ENABLED,
 	HCI_CONN_POWER_SAVE,
 	HCI_CONN_REMOTE_OOB,
+	HCI_CONN_SCO_TRANSPARENT,
 };
 
 static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
@@ -590,6 +591,8 @@ struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle);
 
 struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
 			     __u8 dst_type, __u8 sec_level, __u8 auth_type);
+struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
+				 u8 mode);
 int hci_conn_check_link_mode(struct hci_conn *conn);
 int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
 int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 25bfce0..504367e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -175,13 +175,22 @@ void hci_setup_sync(struct hci_conn *conn, __u16 handle)
 	conn->attempt++;
 
 	cp.handle   = cpu_to_le16(handle);
-	cp.pkt_type = cpu_to_le16(conn->pkt_type);
 
 	cp.tx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
 	cp.rx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
-	cp.max_latency    = __constant_cpu_to_le16(0xffff);
-	cp.voice_setting  = cpu_to_le16(hdev->voice_setting);
-	cp.retrans_effort = 0xff;
+
+	if (test_and_clear_bit(HCI_CONN_SCO_TRANSPARENT, &conn->flags)) {
+		cp.pkt_type       = __constant_cpu_to_le16(EDR_ESCO_MASK &
+							   ~ESCO_2EV3);
+		cp.max_latency    = __constant_cpu_to_le16(0x000d);
+		cp.voice_setting  = __constant_cpu_to_le16(0x0003);
+		cp.retrans_effort = 0x02;
+	} else {
+		cp.pkt_type       = cpu_to_le16(conn->pkt_type);
+		cp.max_latency    = __constant_cpu_to_le16(0xffff);
+		cp.voice_setting  = cpu_to_le16(hdev->voice_setting);
+		cp.retrans_effort = 0xff;
+	}
 
 	hci_send_cmd(hdev, HCI_OP_SETUP_SYNC_CONN, sizeof(cp), &cp);
 }
@@ -551,13 +560,13 @@ static struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 	return acl;
 }
 
-static struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type,
-				bdaddr_t *dst, u8 sec_level, u8 auth_type)
+struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
+				 u8 mode)
 {
 	struct hci_conn *acl;
 	struct hci_conn *sco;
 
-	acl = hci_connect_acl(hdev, dst, sec_level, auth_type);
+	acl = hci_connect_acl(hdev, dst, BT_SECURITY_LOW, HCI_AT_NO_BONDING);
 	if (IS_ERR(acl))
 		return acl;
 
@@ -575,6 +584,9 @@ static struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type,
 
 	hci_conn_hold(sco);
 
+	if (mode)
+		set_bit(HCI_CONN_SCO_TRANSPARENT, &sco->flags);
+
 	if (acl->state == BT_CONNECTED &&
 	    (sco->state == BT_OPEN || sco->state == BT_CLOSED)) {
 		set_bit(HCI_CONN_POWER_SAVE, &acl->flags);
@@ -603,9 +615,6 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
 		return hci_connect_le(hdev, dst, dst_type, sec_level, auth_type);
 	case ACL_LINK:
 		return hci_connect_acl(hdev, dst, sec_level, auth_type);
-	case SCO_LINK:
-	case ESCO_LINK:
-		return hci_connect_sco(hdev, type, dst, sec_level, auth_type);
 	}
 
 	return ERR_PTR(-EINVAL);
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 7fbb4c4..1d79a2e 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -176,8 +176,7 @@ static int sco_connect(struct sock *sk)
 	else
 		type = SCO_LINK;
 
-	hcon = hci_connect(hdev, type, dst, BDADDR_BREDR, BT_SECURITY_LOW,
-			   HCI_AT_NO_BONDING);
+	hcon = hci_connect_sco(hdev, type, dst, sco_pi(sk)->mode);
 	if (IS_ERR(hcon)) {
 		err = PTR_ERR(hcon);
 		goto done;
-- 
1.7.9.5

