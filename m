Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>,
	Johan Hedberg <johan.hedberg@intel.com>
Subject: [PATCH v11 06/10] Bluetooth: Parameters for outgoing SCO connections
Date: Mon, 19 Aug 2013 14:23:59 +0200
Message-Id: <1376915043-24531-7-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1376915043-24531-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1376915043-24531-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In order to establish a transparent SCO connection, the correct settings
must be specified in the Setup Synchronous Connection request. For that,
a setting field is added to ACL connection data to set up the desired
parameters. The patch also removes usage of hdev->voice_setting in CVSD
connection and makes use of T2 parameters for transparent data.

Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |    5 +++--
 net/bluetooth/hci_conn.c         |   24 +++++++++++++++++++-----
 net/bluetooth/sco.c              |    2 +-
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f403509..61ca2ce 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -320,6 +320,7 @@ struct hci_conn {
 	__u32		passkey_notify;
 	__u8		passkey_entered;
 	__u16		disc_timeout;
+	__u16		setting;
 	unsigned long	flags;
 
 	__u8		remote_cap;
@@ -584,8 +585,8 @@ struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle);
 
 struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
 			     __u8 dst_type, __u8 sec_level, __u8 auth_type);
-struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type,
-				 bdaddr_t *dst);
+struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
+				 __u16 setting);
 int hci_conn_check_link_mode(struct hci_conn *conn);
 int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
 int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 5f1f448..c0e56a5 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -185,13 +185,24 @@ void hci_setup_sync(struct hci_conn *conn, __u16 handle)
 	conn->attempt++;
 
 	cp.handle   = cpu_to_le16(handle);
-	cp.pkt_type = cpu_to_le16(conn->pkt_type);
 
 	cp.tx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
 	cp.rx_bandwidth   = __constant_cpu_to_le32(0x00001f40);
-	cp.max_latency    = __constant_cpu_to_le16(0xffff);
-	cp.voice_setting  = cpu_to_le16(hdev->voice_setting);
-	cp.retrans_effort = 0xff;
+	cp.voice_setting  = cpu_to_le16(conn->setting);
+
+	switch (conn->setting & SCO_AIRMODE_MASK) {
+	case SCO_AIRMODE_TRANSP:
+		cp.pkt_type = __constant_cpu_to_le16(EDR_ESCO_MASK &
+						     ~ESCO_2EV3);
+		cp.max_latency = __constant_cpu_to_le16(0x000d);
+		cp.retrans_effort = 0x02;
+		break;
+	case SCO_AIRMODE_CVSD:
+		cp.pkt_type = cpu_to_le16(conn->pkt_type);
+		cp.max_latency = __constant_cpu_to_le16(0xffff);
+		cp.retrans_effort = 0xff;
+		break;
+	}
 
 	hci_send_cmd(hdev, HCI_OP_SETUP_SYNC_CONN, sizeof(cp), &cp);
 }
@@ -560,7 +571,8 @@ static struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 	return acl;
 }
 
-struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst)
+struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
+				 __u16 setting)
 {
 	struct hci_conn *acl;
 	struct hci_conn *sco;
@@ -583,6 +595,8 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst)
 
 	hci_conn_hold(sco);
 
+	sco->setting = setting;
+
 	if (acl->state == BT_CONNECTED &&
 	    (sco->state == BT_OPEN || sco->state == BT_CLOSED)) {
 		set_bit(HCI_CONN_POWER_SAVE, &acl->flags);
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 3b3d24a..e82d792 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -176,7 +176,7 @@ static int sco_connect(struct sock *sk)
 	else
 		type = SCO_LINK;
 
-	hcon = hci_connect_sco(hdev, type, dst);
+	hcon = hci_connect_sco(hdev, type, dst, sco_pi(sk)->setting);
 	if (IS_ERR(hcon)) {
 		err = PTR_ERR(hcon);
 		goto done;
-- 
1.7.9.5

