Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DC4C433ED
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 10:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85EA8611CC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 10:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348571AbhERKkZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 May 2021 06:40:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:23240 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348564AbhERKkS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 May 2021 06:40:18 -0400
IronPort-SDR: AhVB5YF2PDcqgXFBcfsV93h3YVWP3hBuXdNfLH0TuoijrHjqlxalVMnWKYW3FOYZq6AFPfIfNT
 7/SwojNo9ANQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="187804836"
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="187804836"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 03:39:00 -0700
IronPort-SDR: PzA/jB0N6Wx3pxA5DdWctKy9YJOD4XBShrijKXHpoOfcX2WdJEwJKSUYRtQggQuUGPegDv0wz6
 O1LYZyWvs3jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="433017877"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga007.jf.intel.com with ESMTP; 18 May 2021 03:38:58 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v8 8/9] Bluetooth: Add support for HCI_Enhanced_Setup_Synchronous_Connection command
Date:   Tue, 18 May 2021 16:12:31 +0530
Message-Id: <20210518104232.5431-8-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210518104232.5431-1-kiran.k@intel.com>
References: <20210518104232.5431-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

< HCI Command: Enhanced Setup Synchronous Connection (0x01|0x003d) plen 59
        Handle: 256
        Transmit bandwidth: 8000
        Receive bandwidth: 8000
        Max latency: 13
        Packet type: 0x0380
          3-EV3 may not be used
          2-EV5 may not be used
          3-EV5 may not be used
        Retransmission effort: Optimize for link quality (0x02)
> HCI Event: Command Status (0x0f) plen 4
      Enhanced Setup Synchronous Connection (0x01|0x003d) ncmd 1
        Status: Success (0x00)
> HCI Event: Synchronous Connect Complete (0x2c) plen 17
        Status: Success (0x00)
        Handle: 257
        Address: CC:98:8B:92:04:FD (SONY Visual Products Inc.)
        Link type: eSCO (0x02)
        Transmission interval: 0x0c
        Retransmission window: 0x06
        RX packet length: 60
        TX packet length: 60
        Air mode: Transparent (0x03)

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---

Need implementation HCI_Enhanced_Setup_Synchronous_Command as it allows
setting of non-HCI data path

 include/net/bluetooth/bluetooth.h |   1 +
 include/net/bluetooth/hci.h       |  34 ++++++++++
 include/net/bluetooth/hci_core.h  |   7 +-
 net/bluetooth/hci_conn.c          | 104 +++++++++++++++++++++++++++++-
 net/bluetooth/hci_event.c         |  48 +++++++++++++-
 net/bluetooth/sco.c               |  11 +++-
 6 files changed, 198 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 0e8802d09068..4e58d275c72c 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -174,6 +174,7 @@ struct bt_codecs {
 } __packed;
 
 #define CODING_FORMAT_CVSD	0x02
+#define CODING_FORMAT_TRANS	0x03
 
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index bd666b114aea..af168f3c1f2e 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -878,6 +878,40 @@ struct hci_cp_logical_link_cancel {
 	__u8     flow_spec_id;
 } __packed;
 
+#define HCI_OP_ENHANCED_SETUP_SYNC_CONN		0x043D
+struct hci_coding_format {
+	__u8	id;
+	__le16	cid;
+	__le16	vid;
+} __packed;
+
+struct hci_cp_enhanced_setup_sync_conn {
+	__le16   handle;
+	__le32   tx_bandwidth;
+	__le32   rx_bandwidth;
+	struct	 hci_coding_format tx_coding_format;
+	struct	 hci_coding_format rx_coding_format;
+	__le16	 tx_codec_frame_size;
+	__le16	 rx_codec_frame_size;
+	__le32	 in_bandwidth;
+	__le32	 out_bandwidth;
+	struct	 hci_coding_format in_coding_format;
+	struct	 hci_coding_format out_coding_format;
+	__le16   in_coded_data_size;
+	__le16	 out_coded_data_size;
+	__u8	 in_pcm_data_format;
+	__u8	 out_pcm_data_format;
+	__u8	 in_pcm_sample_payload_msb_pos;
+	__u8	 out_pcm_sample_payload_msb_pos;
+	__u8	 in_data_path;
+	__u8	 out_data_path;
+	__u8	 in_trasnport_unit_size;
+	__u8	 out_trasnport_unit_size;
+	__le16   max_latency;
+	__le16   pkt_type;
+	__u8     retrans_effort;
+} __packed;
+
 struct hci_rp_logical_link_cancel {
 	__u8     status;
 	__u8     phy_handle;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 959585bafa8d..760d21a2134e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -712,6 +712,7 @@ struct hci_conn {
 	struct amp_mgr	*amp_mgr;
 
 	struct hci_conn	*link;
+	struct bt_codec codec;
 
 	void (*connect_cfm_cb)	(struct hci_conn *conn, u8 status);
 	void (*security_cfm_cb)	(struct hci_conn *conn, u8 status);
@@ -1094,6 +1095,7 @@ static inline struct hci_conn *hci_lookup_le_connect(struct hci_dev *hdev)
 
 int hci_disconnect(struct hci_conn *conn, __u8 reason);
 bool hci_setup_sync(struct hci_conn *conn, __u16 handle);
+bool hci_enhanced_setup_sync(struct hci_conn *conn, __u16 handle);
 void hci_sco_setup(struct hci_conn *conn, __u8 status);
 
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
@@ -1118,7 +1120,7 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 				 u8 sec_level, u8 auth_type,
 				 enum conn_reasons conn_reason);
 struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
-				 __u16 setting);
+				 __u16 setting, struct bt_codec *codec);
 int hci_conn_check_link_mode(struct hci_conn *conn);
 int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
 int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type,
@@ -1439,6 +1441,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 /* Use LL Privacy based address resolution if supported */
 #define use_ll_privacy(dev) ((dev)->le_features[0] & HCI_LE_LL_PRIVACY)
 
+/* Use enhanced synchronous connection if command is supported */
+#define use_enhanced_sco_conn(dev) ((dev)->commands[29] & 0x08)
+
 /* Use ext scanning if set ext scan param and ext scan enable is supported */
 #define use_ext_scan(dev) (((dev)->commands[37] & 0x20) && \
 			   ((dev)->commands[37] & 0x40))
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 88ec08978ff4..e2435b5abeca 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -307,6 +307,96 @@ static bool find_next_esco_param(struct hci_conn *conn,
 	return conn->attempt <= size;
 }
 
+bool hci_enhanced_setup_sync(struct hci_conn *conn, __u16 handle)
+{
+	struct hci_dev *hdev = conn->hdev;
+	struct hci_cp_enhanced_setup_sync_conn cp;
+	const struct sco_param *param;
+
+	BT_DBG("hcon %p", conn);
+
+	conn->state = BT_CONNECT;
+	conn->out = true;
+
+	conn->attempt++;
+
+	memset(&cp, 0x00, sizeof(cp));
+
+	cp.handle   = cpu_to_le16(handle);
+
+	cp.tx_bandwidth   = cpu_to_le32(0x00001f40);
+	cp.rx_bandwidth   = cpu_to_le32(0x00001f40);
+
+	switch (conn->codec.id) {
+	case CODING_FORMAT_CVSD:
+		if (lmp_esco_capable(conn->link)) {
+			if (conn->attempt > ARRAY_SIZE(esco_param_cvsd))
+				return false;
+			param = &esco_param_cvsd[conn->attempt - 1];
+		} else {
+			if (conn->attempt > ARRAY_SIZE(sco_param_cvsd))
+				return false;
+			param = &sco_param_cvsd[conn->attempt - 1];
+		}
+		cp.tx_coding_format.id = 2;
+		cp.rx_coding_format.id = 2;
+		cp.tx_codec_frame_size = __cpu_to_le16(60);
+		cp.rx_codec_frame_size = __cpu_to_le16(60);
+		cp.in_bandwidth = __cpu_to_le32(16000);
+		cp.out_bandwidth = __cpu_to_le32(16000);
+		cp.in_coding_format.id = 4;
+		cp.out_coding_format.id = 4;
+		cp.in_coded_data_size = __cpu_to_le16(16);
+		cp.out_coded_data_size = __cpu_to_le16(16);
+		cp.in_pcm_data_format = 2;
+		cp.out_pcm_data_format = 2;
+		cp.in_pcm_sample_payload_msb_pos = 0;
+		cp.out_pcm_sample_payload_msb_pos = 0;
+		cp.in_data_path = conn->codec.data_path;
+		cp.out_data_path = conn->codec.data_path;
+		cp.in_trasnport_unit_size = 16;
+		cp.out_trasnport_unit_size = 16;
+		break;
+
+	case CODING_FORMAT_TRANS:
+		if (conn->attempt > ARRAY_SIZE(esco_param_msbc))
+			return false;
+
+		param = &esco_param_msbc[conn->attempt - 1];
+		cp.tx_coding_format.id = 0x03;
+		cp.rx_coding_format.id = 0x03;
+		cp.tx_codec_frame_size = __cpu_to_le16(60);
+		cp.rx_codec_frame_size = __cpu_to_le16(60);
+		cp.in_bandwidth = __cpu_to_le32(0x1f40);
+		cp.out_bandwidth = __cpu_to_le32(0x1f40);
+		cp.in_coding_format.id = 0x03;
+		cp.out_coding_format.id = 0x03;
+		cp.in_coded_data_size = __cpu_to_le16(16);
+		cp.out_coded_data_size = __cpu_to_le16(16);
+		cp.in_pcm_data_format = 2;
+		cp.out_pcm_data_format = 2;
+		cp.in_pcm_sample_payload_msb_pos = 0;
+		cp.out_pcm_sample_payload_msb_pos = 0;
+		cp.in_data_path = conn->codec.data_path;
+		cp.out_data_path = conn->codec.data_path;
+		cp.in_trasnport_unit_size = 1;
+		cp.out_trasnport_unit_size = 1;
+		break;
+
+	default:
+		return false;
+	}
+
+	cp.retrans_effort = param->retrans_effort;
+	cp.pkt_type = __cpu_to_le16(param->pkt_type);
+	cp.max_latency = __cpu_to_le16(param->max_latency);
+
+	if (hci_send_cmd(hdev, HCI_OP_ENHANCED_SETUP_SYNC_CONN, sizeof(cp), &cp) < 0)
+		return false;
+
+	return true;
+}
+
 bool hci_setup_sync(struct hci_conn *conn, __u16 handle)
 {
 	struct hci_dev *hdev = conn->hdev;
@@ -424,8 +514,12 @@ void hci_sco_setup(struct hci_conn *conn, __u8 status)
 	BT_DBG("hcon %p", conn);
 
 	if (!status) {
-		if (lmp_esco_capable(conn->hdev))
-			hci_setup_sync(sco, conn->handle);
+		if (lmp_esco_capable(conn->hdev)) {
+			if (use_enhanced_sco_conn(conn->hdev))
+				hci_enhanced_setup_sync(sco, conn->handle);
+			else
+				hci_setup_sync(sco, conn->handle);
+		}
 		else
 			hci_add_sco(sco, conn->handle);
 	} else {
@@ -1319,7 +1413,7 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 }
 
 struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
-				 __u16 setting)
+				 __u16 setting, struct bt_codec *codec)
 {
 	struct hci_conn *acl;
 	struct hci_conn *sco;
@@ -1344,6 +1438,10 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	hci_conn_hold(sco);
 
 	sco->setting = setting;
+	sco->codec.id = codec->id;
+	sco->codec.cid = codec->cid;
+	sco->codec.vid = codec->vid;
+	sco->codec.data_path = codec->data_path;
 
 	if (acl->state == BT_CONNECTED &&
 	    (sco->state == BT_OPEN || sco->state == BT_CLOSED)) {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4241ae310fcb..94c64e2c11e4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2236,6 +2236,41 @@ static void hci_cs_setup_sync_conn(struct hci_dev *hdev, __u8 status)
 	hci_dev_unlock(hdev);
 }
 
+static void hci_cs_enhanced_setup_sync_conn(struct hci_dev *hdev, __u8 status)
+{
+	struct hci_cp_enhanced_setup_sync_conn *cp;
+	struct hci_conn *acl, *sco;
+	__u16 handle;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x", status);
+
+	if (!status)
+		return;
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_ENHANCED_SETUP_SYNC_CONN);
+	if (!cp)
+		return;
+
+	handle = __le16_to_cpu(cp->handle);
+
+	BT_DBG("%s handle 0x%4.4x", hdev->name, handle);
+
+	hci_dev_lock(hdev);
+
+	acl = hci_conn_hash_lookup_handle(hdev, handle);
+	if (acl) {
+		sco = acl->link;
+		if (sco) {
+			sco->state = BT_CLOSED;
+
+			hci_connect_cfm(sco, status);
+			hci_conn_del(sco);
+		}
+	}
+
+	hci_dev_unlock(hdev);
+}
+
 static void hci_cs_sniff_mode(struct hci_dev *hdev, __u8 status)
 {
 	struct hci_cp_sniff_mode *cp;
@@ -3715,6 +3750,10 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cs_setup_sync_conn(hdev, ev->status);
 		break;
 
+	case HCI_OP_ENHANCED_SETUP_SYNC_CONN:
+		hci_cs_enhanced_setup_sync_conn(hdev, ev->status);
+		break;
+
 	case HCI_OP_SNIFF_MODE:
 		hci_cs_sniff_mode(hdev, ev->status);
 		break;
@@ -4401,8 +4440,13 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev,
 		if (conn->out) {
 			conn->pkt_type = (hdev->esco_type & SCO_ESCO_MASK) |
 					(hdev->esco_type & EDR_ESCO_MASK);
-			if (hci_setup_sync(conn, conn->link->handle))
-				goto unlock;
+			if (use_enhanced_sco_conn(hdev)) {
+				if (hci_enhanced_setup_sync(conn, conn->link->handle))
+					goto unlock;
+			} else {
+				if (hci_setup_sync(conn, conn->link->handle))
+					goto unlock;
+			}
 		}
 		fallthrough;
 
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index d59f30fc4b9f..19d8ee11eed5 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -240,7 +240,7 @@ static int sco_connect(struct sock *sk)
 	}
 
 	hcon = hci_connect_sco(hdev, type, &sco_pi(sk)->dst,
-			       sco_pi(sk)->setting);
+			       sco_pi(sk)->setting, &sco_pi(sk)->codec);
 	if (IS_ERR(hcon)) {
 		err = PTR_ERR(hcon);
 		goto done;
@@ -865,6 +865,15 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 		}
 
 		sco_pi(sk)->setting = voice.setting;
+		hdev = hci_get_route(&sco_pi(sk)->dst, &sco_pi(sk)->src,
+				     BDADDR_BREDR);
+		if (!hdev) {
+			err = -EBADFD;
+			break;
+		}
+		if (use_enhanced_sco_conn(hdev) &&
+		    voice.setting == BT_VOICE_TRANSPARENT)
+			sco_pi(sk)->codec.id = CODING_FORMAT_TRANS;
 		break;
 
 	case BT_PKT_STATUS:
-- 
2.17.1

