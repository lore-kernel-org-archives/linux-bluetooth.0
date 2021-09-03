Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC48C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 10:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 333CF60698
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 10:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349161AbhICKya (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Sep 2021 06:54:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:35162 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349239AbhICKyX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Sep 2021 06:54:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="206611738"
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="206611738"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 03:53:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="692090439"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga005.fm.intel.com with ESMTP; 03 Sep 2021 03:53:14 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        tedd.an@intel.com, luiz.von.dentz@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v14 08/12] Bluetooth: Configure codec for HFP offload use case
Date:   Fri,  3 Sep 2021 16:28:09 +0530
Message-Id: <20210903105813.2440-8-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210903105813.2440-1-kiran.k@intel.com>
References: <20210903105813.2440-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

For HFP offload use case, codec needs to be configured
before opening SCO connection. This patch sends
HCI_CONFIGURE_DATA_PATH command to configure doec before
opening SCO connection.

Signed-off-by: Kiran K <kiran.k@intel.com>
---

Notes:
    * changes in v14:
     - No changes
    
    * changes in v13(new patch):
     - Configure codec for HFP use case before opening
       SCO connection

 include/net/bluetooth/hci.h      |  8 ++++++
 include/net/bluetooth/hci_core.h |  3 ++
 net/bluetooth/hci_conn.c         |  4 +++
 net/bluetooth/hci_request.c      | 47 ++++++++++++++++++++++++++++++++
 net/bluetooth/hci_request.h      |  2 ++
 5 files changed, 64 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 3426ee4f0fa5..6def7a0fd5b7 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1286,6 +1286,14 @@ struct hci_rp_read_local_oob_ext_data {
 	__u8     rand256[16];
 } __packed;
 
+#define HCI_CONFIGURE_DATA_PATH	0x0c83
+struct hci_op_configure_data_path {
+	__u8	direction;
+	__u8	data_path_id;
+	__u8	vnd_len;
+	__u8	vnd_data[];
+} __packed;
+
 #define HCI_OP_READ_LOCAL_VERSION	0x1001
 struct hci_rp_read_local_version {
 	__u8     status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index fdfdd3bdde16..4c6485ac3e2c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -620,6 +620,9 @@ struct hci_dev {
 	bool (*prevent_wake)(struct hci_dev *hdev);
 	int (*set_quality_report)(struct hci_dev *hdev, bool enable);
 	int (*get_data_path_id)(struct hci_dev *hdev, __u8 *data_path);
+	int (*get_codec_config_data)(struct hci_dev *hdev, __u8 type,
+				     struct bt_codec *codec, __u8 *vnd_len,
+				     __u8 **vnd_data);
 };
 
 #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b9c61fc9ff89..43baadf5ec3e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -315,6 +315,10 @@ static bool hci_enhanced_setup_sync_conn(struct hci_conn *conn, __u16 handle)
 
 	bt_dev_dbg(hdev, "hcon %p", conn);
 
+	/* for offload use case, codec needs to configured before opening SCO */
+	if (conn->codec.data_path)
+		hci_req_configure_datapath(hdev, &conn->codec);
+
 	conn->state = BT_CONNECT;
 	conn->out = true;
 
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index f15626607b2d..47fb665277d4 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -3327,6 +3327,53 @@ bool hci_req_stop_discovery(struct hci_request *req)
 	return ret;
 }
 
+static void config_data_path_complete(struct hci_dev *hdev, u8 status,
+				      u16 opcode)
+{
+	bt_dev_dbg(hdev, "status %u", status);
+}
+
+int hci_req_configure_datapath(struct hci_dev *hdev, struct bt_codec *codec)
+{
+	struct hci_request req;
+	int err;
+	__u8 vnd_len, *vnd_data = NULL;
+	struct hci_op_configure_data_path *cmd = NULL;
+
+	hci_req_init(&req, hdev);
+
+	err = hdev->get_codec_config_data(hdev, ESCO_LINK, codec, &vnd_len,
+					  &vnd_data);
+	if (err < 0)
+		goto error;
+
+	cmd = kzalloc(sizeof(*cmd) + vnd_len, GFP_KERNEL);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto error;
+	}
+
+	err = hdev->get_data_path_id(hdev, &cmd->data_path_id);
+	if (err < 0)
+		goto error;
+
+	cmd->vnd_len = vnd_len;
+	memcpy(cmd->vnd_data, vnd_data, vnd_len);
+
+	cmd->direction = 0x00;
+	hci_req_add(&req, HCI_CONFIGURE_DATA_PATH, sizeof(*cmd) + vnd_len, cmd);
+
+	cmd->direction = 0x01;
+	hci_req_add(&req, HCI_CONFIGURE_DATA_PATH, sizeof(*cmd) + vnd_len, cmd);
+
+	err = hci_req_run(&req, config_data_path_complete);
+error:
+
+	kfree(cmd);
+	kfree(vnd_data);
+	return err;
+}
+
 static int stop_discovery(struct hci_request *req, unsigned long opt)
 {
 	hci_dev_lock(req->hdev);
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 39ee8a18087a..aaf608720243 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -101,6 +101,8 @@ void __hci_req_update_class(struct hci_request *req);
 /* Returns true if HCI commands were queued */
 bool hci_req_stop_discovery(struct hci_request *req);
 
+int hci_req_configure_datapath(struct hci_dev *hdev, struct bt_codec *codec);
+
 static inline void hci_req_update_scan(struct hci_dev *hdev)
 {
 	queue_work(hdev->req_workqueue, &hdev->scan_update);
-- 
2.17.1

