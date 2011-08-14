Return-Path: <cyrus@holtmann.org>
From: ilia.kolominsky@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Ilia Kolomisnky <iliak@ti.com>
Subject: [PATCH v2 bluetooth-next] Added ioctl flow specification command on HCI socket
Date: Sun, 14 Aug 2011 15:43:13 +0300
Message-Id: <1313325793-27866-1-git-send-email-iliak@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ilia Kolomisnky <iliak@ti.com>

While it is possible to send flow specification HCI command
from the user space directly via the send api of HCI socket,
a more specific approach is preferable over the opaque
HCI command, since it will allow for centralized mangament of
flow specifiaction requests for different l2cap flows over
the same acl link in future. This feature was used successfully
for solving the qos A2DP issue in piconet with concurent file
transfer.

Signed-off-by: Ilia Kolomisnky <iliak@ti.com>
---
 include/net/bluetooth/hci.h      |   38 ++++++++++++++++++----
 include/net/bluetooth/hci_core.h |    3 ++
 net/bluetooth/hci_conn.c         |    1 +
 net/bluetooth/hci_core.c         |   63 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |   37 ++++++++++++++++++++++
 net/bluetooth/hci_sock.c         |    2 +
 6 files changed, 137 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index be30aab..f0f90d5 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -109,6 +109,8 @@ enum {
 #define HCISETLINKMODE	_IOW('H', 226, int)
 #define HCISETACLMTU	_IOW('H', 227, int)
 #define HCISETSCOMTU	_IOW('H', 228, int)
+#define HCISETFLOWSPEC _IOW('H', 229, int)
+
 
 #define HCIBLOCKADDR	_IOW('H', 230, int)
 #define HCIUNBLOCKADDR	_IOW('H', 231, int)
@@ -264,6 +266,13 @@ enum {
 #define HCI_LK_SMP_IRK			0x82
 #define HCI_LK_SMP_CSRK			0x83
 
+/* Flow specification definitions */
+#define HCI_FS_SERVICETYPE_NO_TRAFFIC  0x00
+#define HCI_FS_SERVICETYPE_BEST_EFFORT 0x01
+#define HCI_FS_SERVICETYPE_GUARANTEED  0x02
+#define HCI_FS_DIR_OUTGOING 0x0
+#define HCI_FS_DIR_INCOMING 0x1
+
 /* -----  HCI Commands ---- */
 #define HCI_OP_NOP			0x0000
 
@@ -478,6 +487,21 @@ struct hci_cp_exit_sniff_mode {
 	__le16   handle;
 } __packed;
 
+#define HCI_OP_SET_FLOW_SPEC		0x0807
+struct hci_qos {
+	__u8     service_type;
+	__u32    token_rate;
+	__u32    peak_bandwidth;
+	__u32    latency;
+	__u32    delay_variation;
+} __packed;
+struct hci_cp_flowspec {
+	__le16	handle;
+	__u8	flags;
+	__u8	flowdir;
+	struct hci_qos	flowspec;
+} __packed;
+
 #define HCI_OP_ROLE_DISCOVERY		0x0809
 struct hci_cp_role_discovery {
 	__le16   handle;
@@ -869,13 +893,6 @@ struct hci_ev_remote_version {
 } __packed;
 
 #define HCI_EV_QOS_SETUP_COMPLETE	0x0d
-struct hci_qos {
-	__u8     service_type;
-	__u32    token_rate;
-	__u32    peak_bandwidth;
-	__u32    latency;
-	__u32    delay_variation;
-} __packed;
 struct hci_ev_qos_setup_complete {
 	__u8     status;
 	__le16   handle;
@@ -1299,4 +1316,11 @@ struct hci_inquiry_req {
 };
 #define IREQ_CACHE_FLUSH 0x0001
 
+struct hci_flowspec_req {
+	__u16			dev_id;
+	__u16			handle;
+	__u8			flowdir;
+	struct hci_qos	flowspec;
+} __packed;
+
 #endif /* __HCI_H */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c41e275..5232d98 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -291,6 +291,8 @@ struct hci_conn {
 
 	struct hci_conn	*link;
 
+	struct hci_qos qos_info;
+
 	void (*connect_cfm_cb)	(struct hci_conn *conn, u8 status);
 	void (*security_cfm_cb)	(struct hci_conn *conn, u8 status);
 	void (*disconn_cfm_cb)	(struct hci_conn *conn, u8 reason);
@@ -541,6 +543,7 @@ int hci_get_conn_list(void __user *arg);
 int hci_get_conn_info(struct hci_dev *hdev, void __user *arg);
 int hci_get_auth_info(struct hci_dev *hdev, void __user *arg);
 int hci_inquiry(void __user *arg);
+int hci_set_flowspec(void __user *arg);
 
 struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int hci_blacklist_clear(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index fa6820e..6de7ec6 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -359,6 +359,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 	switch (type) {
 	case ACL_LINK:
 		conn->pkt_type = hdev->pkt_type & ACL_PTYPE_MASK;
+		conn->qos_info.service_type = HCI_FS_SERVICETYPE_BEST_EFFORT;
 		break;
 	case SCO_LINK:
 		if (lmp_esco_capable(hdev))
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3b39198..1ff1317 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -305,6 +305,15 @@ static void hci_encrypt_req(struct hci_dev *hdev, unsigned long opt)
 	hci_send_cmd(hdev, HCI_OP_WRITE_ENCRYPT_MODE, 1, &encrypt);
 }
 
+static void hci_setflowspec_req(struct hci_dev *hdev, unsigned long opt)
+{
+	BT_DBG("%s ", hdev->name);
+
+	/* Set flow specification */
+	hci_send_cmd(hdev, HCI_OP_SET_FLOW_SPEC,
+			sizeof(struct hci_cp_flowspec), (void*) opt);
+}
+
 static void hci_linkpol_req(struct hci_dev *hdev, unsigned long opt)
 {
 	__le16 policy = cpu_to_le16(opt);
@@ -495,6 +504,60 @@ done:
 	return err;
 }
 
+
+int hci_set_flowspec(void __user *arg)
+{
+	struct hci_flowspec_req req;
+	struct hci_dev *hdev;
+	struct hci_conn *conn;
+	struct hci_cp_flowspec cp_req;
+	int err;
+
+	if (copy_from_user(&req, arg, sizeof(req)))
+		return -EFAULT;
+
+	hdev = hci_dev_get(req.dev_id);
+	if (!hdev) {
+		return -ENODEV;
+	}
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, req.handle);
+	if (!conn || conn->state != BT_CONNECTED) {
+		hci_dev_unlock(hdev);
+		hci_dev_put(hdev);
+		return -EPERM;
+	}
+	hci_dev_unlock(hdev);
+
+	cp_req.handle = cpu_to_le16(req.handle);
+	cp_req.flags = 0;
+	cp_req.flowdir = req.flowdir;
+	cp_req.flowspec.delay_variation =
+			cpu_to_le32(req.flowspec.delay_variation);
+	cp_req.flowspec.latency = cpu_to_le32(req.flowspec.latency);
+	cp_req.flowspec.peak_bandwidth = cpu_to_le32(req.flowspec.peak_bandwidth);
+	cp_req.flowspec.service_type = req.flowspec.service_type;
+	cp_req.flowspec.token_rate = cpu_to_le32(req.flowspec.token_rate);
+
+	err = hci_request(hdev, hci_setflowspec_req,
+			(unsigned long)&cp_req, msecs_to_jiffies(HCI_CMD_TIMEOUT));
+
+	if ( !err )
+	{
+		hci_dev_lock(hdev);
+		conn = hci_conn_hash_lookup_handle(hdev, req.handle);
+		if (conn) {
+			err = copy_to_user(&((struct hci_flowspec_req *)arg)->flowspec,
+					&conn->qos_info, sizeof(conn->qos_info)) ? -EFAULT : 0;
+		}
+	}
+
+	hci_dev_put(hdev);
+	return err;
+}
+
 /* ---- HCI ioctl helpers ---- */
 
 int hci_dev_open(__u16 dev)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a40170e..5804024 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -949,6 +949,16 @@ static inline void hci_cc_write_le_host_supported(struct hci_dev *hdev,
 	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_EXT_FEATURES, sizeof(cp), &cp);
 }
 
+static void hci_cc_set_flow_spec(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	__u8 status = *((__u8 *) skb->data);
+
+	BT_DBG("%s status 0x%x", hdev->name, status);
+	if (status) {
+		hci_req_complete(hdev, HCI_OP_SET_FLOW_SPEC, status);
+	}
+}
+
 static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 {
 	BT_DBG("%s status 0x%x", hdev->name, status);
@@ -1775,6 +1785,29 @@ static inline void hci_remote_version_evt(struct hci_dev *hdev, struct sk_buff *
 static inline void hci_qos_setup_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	BT_DBG("%s", hdev->name);
+	struct hci_ev_qos_setup_complete *ev = (void *) skb->data;
+	struct hci_conn *conn;
+
+	BT_DBG("%s status %d", hdev->name, ev->status);
+
+	if (!ev->status) {
+		hci_dev_lock(hdev);
+
+		conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
+		if (conn) {
+			conn->qos_info.delay_variation =
+					le32_to_cpu(ev->qos.delay_variation);
+			conn->qos_info.latency = le32_to_cpu(ev->qos.latency);
+			conn->qos_info.peak_bandwidth =
+					le32_to_cpu(ev->qos.peak_bandwidth);
+			conn->qos_info.service_type = ev->qos.service_type;
+			conn->qos_info.token_rate = le32_to_cpu(ev->qos.token_rate);
+		}
+
+		hci_dev_unlock(hdev);
+	}
+
+	hci_req_complete(hdev, HCI_OP_SET_FLOW_SPEC, ev->status);
 }
 
 static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
@@ -1959,6 +1992,10 @@ static inline void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *sk
 		hci_cc_write_le_host_supported(hdev, skb);
 		break;
 
+	case HCI_OP_SET_FLOW_SPEC:
+		hci_cc_set_flow_spec(hdev, skb);
+		break;
+
 	default:
 		BT_DBG("%s opcode 0x%x", hdev->name, opcode);
 		break;
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index ff02cf5..48b13e6 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -298,6 +298,8 @@ static int hci_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned long a
 
 	case HCIINQUIRY:
 		return hci_inquiry(argp);
+	case HCISETFLOWSPEC:
+		return hci_set_flowspec(argp);
 
 	default:
 		lock_sock(sk);
-- 
1.7.1

