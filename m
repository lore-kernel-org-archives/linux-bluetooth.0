Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98880C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 10:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81E3760F21
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 10:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348427AbhICKyY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Sep 2021 06:54:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:35135 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235029AbhICKyN (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Sep 2021 06:54:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="206611736"
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="206611736"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 03:53:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="692090430"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga005.fm.intel.com with ESMTP; 03 Sep 2021 03:53:11 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        tedd.an@intel.com, luiz.von.dentz@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v14 07/12] Bluetooth: Add support for HCI_Enhanced_Setup_Synchronous_Connection command
Date:   Fri,  3 Sep 2021 16:28:08 +0530
Message-Id: <20210903105813.2440-7-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210903105813.2440-1-kiran.k@intel.com>
References: <20210903105813.2440-1-kiran.k@intel.com>
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

Notes:
    * changes in v14:
     - No changes
    
    * changes in v13:
      - No changes
    
    * changes in v12:
      - hci_dev_put needs to be called when done with hci_get_route
    
    * changes in v11:
      - Remove changes related to Kconfig
      - s/use_enhanced_sco_conn/enhanced_sco_capable/g
      - Minor review comments
    
    * changes in v10:
      - Fix typos and remove unwanted chunks
    * changes in v9:
      - Fix review comments, use bt_dev_dbg instead of BT_DBG

 include/net/bluetooth/bluetooth.h |   3 +-
 include/net/bluetooth/hci.h       |  34 ++++++++++
 include/net/bluetooth/hci_core.h  |   6 +-
 net/bluetooth/hci_conn.c          | 105 +++++++++++++++++++++++++++++-
 net/bluetooth/hci_event.c         |  39 +++++++++++
 net/bluetooth/sco.c               |  12 +++-
 6 files changed, 193 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 1a48b6732eef..f2df8bb108d9 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -173,7 +173,8 @@ struct bt_codecs {
 	struct bt_codec	codecs[];
 } __packed;
 
-#define CODING_FORMAT_CVSD	0x02
+#define CODING_FORMAT_CVSD		0x02
+#define CODING_FORMAT_TRANSPARENT	0x03
 
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 8f8664bec6f2..3426ee4f0fa5 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -873,6 +873,40 @@ struct hci_cp_logical_link_cancel {
 	__u8     flow_spec_id;
 } __packed;
 
+#define HCI_OP_ENHANCED_SETUP_SYNC_CONN		0x043d
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
+	__u8	 in_transport_unit_size;
+	__u8	 out_transport_unit_size;
+	__le16   max_latency;
+	__le16   pkt_type;
+	__u8     retrans_effort;
+} __packed;
+
 struct hci_rp_logical_link_cancel {
 	__u8     status;
 	__u8     phy_handle;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 655e2a119e7f..fdfdd3bdde16 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -713,6 +713,7 @@ struct hci_conn {
 	struct amp_mgr	*amp_mgr;
 
 	struct hci_conn	*link;
+	struct bt_codec codec;
 
 	void (*connect_cfm_cb)	(struct hci_conn *conn, u8 status);
 	void (*security_cfm_cb)	(struct hci_conn *conn, u8 status);
@@ -1121,7 +1122,7 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 				 u8 sec_level, u8 auth_type,
 				 enum conn_reasons conn_reason);
 struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
-				 __u16 setting);
+				 __u16 setting, struct bt_codec *codec);
 int hci_conn_check_link_mode(struct hci_conn *conn);
 int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
 int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type,
@@ -1458,6 +1459,9 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 /* Use LL Privacy based address resolution if supported */
 #define use_ll_privacy(dev) ((dev)->le_features[0] & HCI_LE_LL_PRIVACY)
 
+/* Use enhanced synchronous connection if command is supported */
+#define enhanced_sco_capable(dev) ((dev)->commands[29] & 0x08)
+
 /* Use ext scanning if set ext scan param and ext scan enable is supported */
 #define use_ext_scan(dev) (((dev)->commands[37] & 0x20) && \
 			   ((dev)->commands[37] & 0x40))
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 3ab60b75d865..b9c61fc9ff89 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -307,13 +307,103 @@ static bool find_next_esco_param(struct hci_conn *conn,
 	return conn->attempt <= size;
 }
 
-bool hci_setup_sync(struct hci_conn *conn, __u16 handle)
+static bool hci_enhanced_setup_sync_conn(struct hci_conn *conn, __u16 handle)
+{
+	struct hci_dev *hdev = conn->hdev;
+	struct hci_cp_enhanced_setup_sync_conn cp;
+	const struct sco_param *param;
+
+	bt_dev_dbg(hdev, "hcon %p", conn);
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
+	case CODING_FORMAT_TRANSPARENT:
+		if (!find_next_esco_param(conn, esco_param_msbc,
+					  ARRAY_SIZE(esco_param_msbc)))
+			return false;
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
+		cp.in_transport_unit_size = 1;
+		cp.out_transport_unit_size = 1;
+		break;
+
+	case CODING_FORMAT_CVSD:
+		if (lmp_esco_capable(conn->link)) {
+			if (!find_next_esco_param(conn, esco_param_cvsd,
+						  ARRAY_SIZE(esco_param_cvsd)))
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
+		cp.in_transport_unit_size = 16;
+		cp.out_transport_unit_size = 16;
+		break;
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
+static bool hci_setup_sync_conn(struct hci_conn *conn, __u16 handle)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_setup_sync_conn cp;
 	const struct sco_param *param;
 
-	BT_DBG("hcon %p", conn);
+	bt_dev_dbg(hdev, "hcon %p", conn);
 
 	conn->state = BT_CONNECT;
 	conn->out = true;
@@ -359,6 +449,14 @@ bool hci_setup_sync(struct hci_conn *conn, __u16 handle)
 	return true;
 }
 
+bool hci_setup_sync(struct hci_conn *conn, __u16 handle)
+{
+	if (enhanced_sco_capable(conn->hdev))
+		return hci_enhanced_setup_sync_conn(conn, handle);
+
+	return hci_setup_sync_conn(conn, handle);
+}
+
 u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
 		      u16 to_multiplier)
 {
@@ -1324,7 +1422,7 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 }
 
 struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
-				 __u16 setting)
+				 __u16 setting, struct bt_codec *codec)
 {
 	struct hci_conn *acl;
 	struct hci_conn *sco;
@@ -1349,6 +1447,7 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	hci_conn_hold(sco);
 
 	sco->setting = setting;
+	sco->codec = *codec;
 
 	if (acl->state == BT_CONNECTED &&
 	    (sco->state == BT_OPEN || sco->state == BT_CLOSED)) {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b1062f5cf488..b48e24629fa4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2278,6 +2278,41 @@ static void hci_cs_setup_sync_conn(struct hci_dev *hdev, __u8 status)
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
+	bt_dev_dbg(hdev, "handle 0x%4.4x", handle);
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
@@ -3764,6 +3799,10 @@ static void hci_cmd_status_evt(struct hci_dev *hdev, struct sk_buff *skb,
 		hci_cs_setup_sync_conn(hdev, ev->status);
 		break;
 
+	case HCI_OP_ENHANCED_SETUP_SYNC_CONN:
+		hci_cs_enhanced_setup_sync_conn(hdev, ev->status);
+		break;
+
 	case HCI_OP_SNIFF_MODE:
 		hci_cs_sniff_mode(hdev, ev->status);
 		break;
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 727b766488db..004bce2b5eca 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -253,7 +253,7 @@ static int sco_connect(struct hci_dev *hdev, struct sock *sk)
 		return -EOPNOTSUPP;
 
 	hcon = hci_connect_sco(hdev, type, &sco_pi(sk)->dst,
-			       sco_pi(sk)->setting);
+			       sco_pi(sk)->setting, &sco_pi(sk)->codec);
 	if (IS_ERR(hcon))
 		return PTR_ERR(hcon);
 
@@ -889,6 +889,16 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 		}
 
 		sco_pi(sk)->setting = voice.setting;
+		hdev = hci_get_route(&sco_pi(sk)->dst, &sco_pi(sk)->src,
+				     BDADDR_BREDR);
+		if (!hdev) {
+			err = -EBADFD;
+			break;
+		}
+		if (enhanced_sco_capable(hdev) &&
+		    voice.setting == BT_VOICE_TRANSPARENT)
+			sco_pi(sk)->codec.id = CODING_FORMAT_TRANSPARENT;
+		hci_dev_put(hdev);
 		break;
 
 	case BT_PKT_STATUS:
-- 
2.17.1

