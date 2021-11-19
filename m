Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FEFC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 08:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D33EC603E7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 08:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbhKSISE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 03:18:04 -0500
Received: from mga04.intel.com ([192.55.52.120]:1480 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234147AbhKSISE (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 03:18:04 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="233098362"
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="233098362"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 00:15:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="473468723"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga002.jf.intel.com with ESMTP; 19 Nov 2021 00:15:00 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v4 04/14] Bluetooth: Pass transport type in get_data_path_id
Date:   Fri, 19 Nov 2021 13:50:17 +0530
Message-Id: <20211119082027.12809-4-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119082027.12809-1-kiran.k@intel.com>
References: <20211119082027.12809-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

To support fetching of data path id for other transport types
like a2dp, le audio, pass an additional parameter to get_data_path_id
callback function.

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
 drivers/bluetooth/btintel.c      | 19 +++++++++++++++----
 drivers/bluetooth/hci_vhci.c     |  6 +++++-
 include/net/bluetooth/hci_core.h |  3 ++-
 net/bluetooth/hci_codec.c        |  9 ++++++---
 net/bluetooth/hci_conn.c         |  3 ++-
 net/bluetooth/hci_request.c      |  5 +++--
 net/bluetooth/hci_request.h      |  3 ++-
 7 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index c8c5c7007094..4b6d7ea08425 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2209,11 +2209,22 @@ static int btintel_get_codec_config_data(struct hci_dev *hdev,
 	return err;
 }
 
-static int btintel_get_data_path_id(struct hci_dev *hdev, __u8 *data_path_id)
+static int btintel_get_data_path_id(struct hci_dev *hdev, __u8 transport,
+				    __u8 *data_path_id)
 {
-	/* Intel uses 1 as data path id for all the usecases */
-	*data_path_id = 1;
-	return 0;
+	struct btintel_data *intel_data;
+
+	if (transport != HCI_TRANSPORT_SCO_ESCO)
+		return -EINVAL;
+
+	intel_data = hci_get_priv((hdev));
+
+	if (intel_data->use_cases.preset[0] & 0x03) {
+		/* Intel uses 1 as data path id for all the usecases */
+		*data_path_id = 1;
+		return 0;
+	}
+	return  -EOPNOTSUPP;
 }
 
 static int btintel_configure_offload(struct hci_dev *hdev)
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 49ac884d996e..57f4d016fa89 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -80,8 +80,12 @@ static int vhci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	return 0;
 }
 
-static int vhci_get_data_path_id(struct hci_dev *hdev, u8 *data_path_id)
+static int vhci_get_data_path_id(struct hci_dev *hdev, u8 transport,
+				 u8 *data_path_id)
 {
+	if (transport != HCI_TRANSPORT_SCO_ESCO)
+		return -EINVAL;
+
 	*data_path_id = 0;
 	return 0;
 }
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2560cfe80db8..b0c5eba20fd4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -617,7 +617,8 @@ struct hci_dev {
 	void (*cmd_timeout)(struct hci_dev *hdev);
 	bool (*wakeup)(struct hci_dev *hdev);
 	int (*set_quality_report)(struct hci_dev *hdev, bool enable);
-	int (*get_data_path_id)(struct hci_dev *hdev, __u8 *data_path);
+	int (*get_data_path_id)(struct hci_dev *hdev, __u8 transport,
+				__u8 *data_path);
 	int (*get_codec_config_data)(struct hci_dev *hdev, __u8 type,
 				     struct bt_codec *codec, __u8 *vnd_len,
 				     __u8 **vnd_data);
diff --git a/net/bluetooth/hci_codec.c b/net/bluetooth/hci_codec.c
index 1e486aca3002..33b341104105 100644
--- a/net/bluetooth/hci_codec.c
+++ b/net/bluetooth/hci_codec.c
@@ -259,12 +259,17 @@ int hci_get_supported_codecs(struct hci_dev *hdev, u8 type, char __user *optval,
 	struct bt_codec codec;
 	u8 num_codecs = 0, i, __user *ptr;
 	struct codec_list *c;
+	u8 data_path;
 
 	if (!hdev->get_data_path_id) {
 		err = -EOPNOTSUPP;
 		goto error;
 	}
 
+	err = hdev->get_data_path_id(hdev, type, &data_path);
+	if (err < 0)
+		goto error;
+
 	/* find total buffer size required to copy codec + capabilities */
 	hci_dev_lock(hdev);
 	list_for_each_entry(c, &hdev->local_codecs, list) {
@@ -301,9 +306,7 @@ int hci_get_supported_codecs(struct hci_dev *hdev, u8 type, char __user *optval,
 		codec.id = c->id;
 		codec.cid = c->cid;
 		codec.vid = c->vid;
-		err = hdev->get_data_path_id(hdev, &codec.data_path);
-		if (err < 0)
-			break;
+		codec.data_path = data_path;
 		codec.num_caps = c->num_caps;
 		if (copy_to_user(ptr, &codec, sizeof(codec))) {
 			err = -EFAULT;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index cd6e1cf7e396..ce87692272b5 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -317,7 +317,8 @@ static bool hci_enhanced_setup_sync_conn(struct hci_conn *conn, __u16 handle)
 
 	/* for offload use case, codec needs to configured before opening SCO */
 	if (conn->codec.data_path)
-		hci_req_configure_datapath(hdev, &conn->codec);
+		hci_req_configure_datapath(hdev, HCI_TRANSPORT_SCO_ESCO,
+					   &conn->codec);
 
 	conn->state = BT_CONNECT;
 	conn->out = true;
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 8b3205e4b23e..00460317dec0 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -2480,7 +2480,8 @@ static void config_data_path_complete(struct hci_dev *hdev, u8 status,
 	bt_dev_dbg(hdev, "status %u", status);
 }
 
-int hci_req_configure_datapath(struct hci_dev *hdev, struct bt_codec *codec)
+int hci_req_configure_datapath(struct hci_dev *hdev, u8 transport,
+			       struct bt_codec *codec)
 {
 	struct hci_request req;
 	int err;
@@ -2500,7 +2501,7 @@ int hci_req_configure_datapath(struct hci_dev *hdev, struct bt_codec *codec)
 		goto error;
 	}
 
-	err = hdev->get_data_path_id(hdev, &cmd->data_path_id);
+	err = hdev->get_data_path_id(hdev, transport, &cmd->data_path_id);
 	if (err < 0)
 		goto error;
 
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 5f8e8846ec74..e360085def98 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -111,7 +111,8 @@ void __hci_req_update_class(struct hci_request *req);
 /* Returns true if HCI commands were queued */
 bool hci_req_stop_discovery(struct hci_request *req);
 
-int hci_req_configure_datapath(struct hci_dev *hdev, struct bt_codec *codec);
+int hci_req_configure_datapath(struct hci_dev *hdev, u8 transport,
+			       struct bt_codec *codec);
 
 static inline void hci_req_update_scan(struct hci_dev *hdev)
 {
-- 
2.17.1

