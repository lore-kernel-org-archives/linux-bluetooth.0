Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [RFC v2 4/5] Bluetooth: Set parameters for outgoing connections
Date: Tue, 11 Dec 2012 17:53:51 +0100
Message-Id: <1355244832-2729-5-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1355244832-2729-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1355244832-2729-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In order to establish the connection, the outgoing connection must also
request the codec. Here we need to set a bit in ACL connection flag to set up
the desired parameters if ACL is not up yet.
---
 include/net/bluetooth/hci_core.h |    3 +++
 net/bluetooth/hci_conn.c         |   21 ++++++++++++++++-----
 net/bluetooth/sco.c              |    4 ++--
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index cb5d131..7b9902a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -438,6 +438,7 @@ enum {
 	HCI_CONN_SSP_ENABLED,
 	HCI_CONN_POWER_SAVE,
 	HCI_CONN_REMOTE_OOB,
+	HCI_CONN_SCO_T2_SETTINGS,
 };
 
 static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
@@ -586,6 +587,8 @@ struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle);
 
 struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
 			     __u8 dst_type, __u8 sec_level, __u8 auth_type);
+struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
+				 u8 sec_level, u8 auth_type, u8 codec);
 int hci_conn_check_link_mode(struct hci_conn *conn);
 int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
 int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 25bfce0..4bba2fb 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -179,9 +179,16 @@ void hci_setup_sync(struct hci_conn *conn, __u16 handle)
 
 	cp.tx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
 	cp.rx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
-	cp.max_latency    = __constant_cpu_to_le16(0xffff);
 	cp.voice_setting  = cpu_to_le16(hdev->voice_setting);
-	cp.retrans_effort = 0xff;
+
+	if (test_and_clear_bit(HCI_CONN_SCO_T2_SETTINGS, &conn->flags)) {
+		cp.voice_setting |= 3;
+		cp.max_latency    = __constant_cpu_to_le16(0x000d);
+		cp.retrans_effort = 0x02;
+	} else {
+		cp.max_latency    = __constant_cpu_to_le16(0xffff);
+		cp.retrans_effort = 0xff;
+	}
 
 	hci_send_cmd(hdev, HCI_OP_SETUP_SYNC_CONN, sizeof(cp), &cp);
 }
@@ -551,8 +558,9 @@ static struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 	return acl;
 }
 
-static struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type,
-				bdaddr_t *dst, u8 sec_level, u8 auth_type)
+struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type,
+					bdaddr_t *dst, u8 sec_level,
+					u8 auth_type, u8 codec)
 {
 	struct hci_conn *acl;
 	struct hci_conn *sco;
@@ -575,6 +583,9 @@ static struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type,
 
 	hci_conn_hold(sco);
 
+	if (codec)
+		set_bit(HCI_CONN_SCO_T2_SETTINGS, &sco->flags);
+
 	if (acl->state == BT_CONNECTED &&
 	    (sco->state == BT_OPEN || sco->state == BT_CLOSED)) {
 		set_bit(HCI_CONN_POWER_SAVE, &acl->flags);
@@ -605,7 +616,7 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
 		return hci_connect_acl(hdev, dst, sec_level, auth_type);
 	case SCO_LINK:
 	case ESCO_LINK:
-		return hci_connect_sco(hdev, type, dst, sec_level, auth_type);
+		return hci_connect_sco(hdev, type, dst, sec_level, auth_type, 0);
 	}
 
 	return ERR_PTR(-EINVAL);
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 6a957a3..bee0b5c 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -176,8 +176,8 @@ static int sco_connect(struct sock *sk)
 	else
 		type = SCO_LINK;
 
-	hcon = hci_connect(hdev, type, dst, BDADDR_BREDR, BT_SECURITY_LOW,
-			   HCI_AT_NO_BONDING);
+	hcon = hci_connect_sco(hdev, type, dst, BT_SECURITY_LOW,
+			       HCI_AT_NO_BONDING, sco_pi(sk)->mode);
 	if (IS_ERR(hcon)) {
 		err = PTR_ERR(hcon);
 		goto done;
-- 
1.7.9.5

