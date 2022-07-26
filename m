Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BFDC00144
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Jul 2022 23:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239832AbiGZXB4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Jul 2022 19:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiGZXBy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Jul 2022 19:01:54 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAA0E088
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Jul 2022 16:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658876513; x=1690412513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wxxTtexmC0TaD7vhBr1ZQ4k2O9bsv+AJ9AlTXS7Z0JM=;
  b=akye7RcI8lDMD4ah7yQJ7DzAeeUv493A9WvDwLDFy4rMX8bNBSyMgZWo
   AN66+QD38c5AWPO8xiWiid9tgV7G4BakLVbLJOXdLvwd9Vt3JW6CHA7gu
   RGLwJU0pvM3RsPsvXtNVDT+OwWeGf9uwG+SrpC0EkkiVQE6XA4K/gDUjX
   BYpMWbHC5aQr5xMlPlfB8UynrN9tmiY4BsTBWvcf9CHt3kCBgusUUK4g8
   W9nyAqy2poV4dCeg/Pspk7uH0DiGMZ/sZm3yZzLFn9iQL/HjEGqdNNUnF
   bY+pf7kUvAnwzXR4AyuFgRt+r3WYctb01G1Ha/PDsnM6Iai6wmDaUDEah
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="274965145"
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="274965145"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 16:01:50 -0700
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="668098991"
Received: from srezaei-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.5.115])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 16:01:49 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v3 4/4] Bluetooth: Convert SCO configure_datapath to hci_sync
Date:   Tue, 26 Jul 2022 16:01:40 -0700
Message-Id: <20220726230140.205481-5-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220726230140.205481-1-brian.gix@intel.com>
References: <20220726230140.205481-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Recoding HCI cmds to offload SCO codec to use hci_sync mechanism rather
than deprecated hci_request mechanism.

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 net/bluetooth/hci_conn.c    | 85 ++++++++++++++++++++++++++++++++-----
 net/bluetooth/hci_request.c | 47 --------------------
 net/bluetooth/hci_request.h |  2 -
 3 files changed, 74 insertions(+), 60 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index f54864e19866..7823c13f3677 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -44,6 +44,11 @@ struct sco_param {
 	u8  retrans_effort;
 };
 
+struct conn_handle_t {
+	struct hci_conn *conn;
+	__u16 handle;
+};
+
 static const struct sco_param esco_param_cvsd[] = {
 	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x000a,	0x01 }, /* S3 */
 	{ EDR_ESCO_MASK & ~ESCO_2EV3, 0x0007,	0x01 }, /* S2 */
@@ -316,17 +321,59 @@ static bool find_next_esco_param(struct hci_conn *conn,
 	return conn->attempt <= size;
 }
 
-static bool hci_enhanced_setup_sync_conn(struct hci_conn *conn, __u16 handle)
+static int configure_datapath_sync(struct hci_dev *hdev, struct bt_codec *codec)
 {
-	struct hci_dev *hdev = conn->hdev;
+	int err;
+	__u8 vnd_len, *vnd_data = NULL;
+	struct hci_op_configure_data_path *cmd = NULL;
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
+	__hci_cmd_sync_status(hdev, HCI_CONFIGURE_DATA_PATH,
+			      sizeof(*cmd) + vnd_len, cmd, HCI_CMD_TIMEOUT);
+
+	cmd->direction = 0x01;
+	err = __hci_cmd_sync_status(hdev, HCI_CONFIGURE_DATA_PATH,
+			      sizeof(*cmd) + vnd_len, cmd, HCI_CMD_TIMEOUT);
+error:
+
+	kfree(cmd);
+	kfree(vnd_data);
+	return err;
+}
+
+static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
+{
+	struct conn_handle_t *conn_handle = data;
+	struct hci_conn *conn = conn_handle->conn;
+	__u16 handle = conn_handle->handle;
 	struct hci_cp_enhanced_setup_sync_conn cp;
 	const struct sco_param *param;
 
+	kfree(conn_handle);
+
 	bt_dev_dbg(hdev, "hcon %p", conn);
 
 	/* for offload use case, codec needs to configured before opening SCO */
 	if (conn->codec.data_path)
-		hci_req_configure_datapath(hdev, &conn->codec);
+		configure_datapath_sync(hdev, &conn->codec);
 
 	conn->state = BT_CONNECT;
 	conn->out = true;
@@ -344,7 +391,7 @@ static bool hci_enhanced_setup_sync_conn(struct hci_conn *conn, __u16 handle)
 	case BT_CODEC_MSBC:
 		if (!find_next_esco_param(conn, esco_param_msbc,
 					  ARRAY_SIZE(esco_param_msbc)))
-			return false;
+			return -EINVAL;
 
 		param = &esco_param_msbc[conn->attempt - 1];
 		cp.tx_coding_format.id = 0x05;
@@ -396,11 +443,11 @@ static bool hci_enhanced_setup_sync_conn(struct hci_conn *conn, __u16 handle)
 		if (lmp_esco_capable(conn->link)) {
 			if (!find_next_esco_param(conn, esco_param_cvsd,
 						  ARRAY_SIZE(esco_param_cvsd)))
-				return false;
+				return -EINVAL;
 			param = &esco_param_cvsd[conn->attempt - 1];
 		} else {
 			if (conn->attempt > ARRAY_SIZE(sco_param_cvsd))
-				return false;
+				return -EINVAL;
 			param = &sco_param_cvsd[conn->attempt - 1];
 		}
 		cp.tx_coding_format.id = 2;
@@ -423,7 +470,7 @@ static bool hci_enhanced_setup_sync_conn(struct hci_conn *conn, __u16 handle)
 		cp.out_transport_unit_size = 16;
 		break;
 	default:
-		return false;
+		return -EINVAL;
 	}
 
 	cp.retrans_effort = param->retrans_effort;
@@ -431,9 +478,9 @@ static bool hci_enhanced_setup_sync_conn(struct hci_conn *conn, __u16 handle)
 	cp.max_latency = __cpu_to_le16(param->max_latency);
 
 	if (hci_send_cmd(hdev, HCI_OP_ENHANCED_SETUP_SYNC_CONN, sizeof(cp), &cp) < 0)
-		return false;
+		return -EIO;
 
-	return true;
+	return 0;
 }
 
 static bool hci_setup_sync_conn(struct hci_conn *conn, __u16 handle)
@@ -490,8 +537,24 @@ static bool hci_setup_sync_conn(struct hci_conn *conn, __u16 handle)
 
 bool hci_setup_sync(struct hci_conn *conn, __u16 handle)
 {
-	if (enhanced_sync_conn_capable(conn->hdev))
-		return hci_enhanced_setup_sync_conn(conn, handle);
+	int result;
+	struct conn_handle_t *conn_handle;
+
+	if (enhanced_sync_conn_capable(conn->hdev)) {
+		conn_handle = kzalloc(sizeof(*conn_handle), GFP_KERNEL);
+
+		if (!conn_handle)
+			return false;
+
+		conn_handle->conn = conn;
+		conn_handle->handle = handle;
+		result = hci_cmd_sync_queue(conn->hdev, hci_enhanced_setup_sync,
+					    conn_handle, NULL);
+		if (result < 0)
+			kfree(conn_handle);
+
+		return result == 0;
+	}
 
 	return hci_setup_sync_conn(conn, handle);
 }
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index ef0a5ec067b6..d14e50951aec 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1975,53 +1975,6 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 	return 0;
 }
 
-static void config_data_path_complete(struct hci_dev *hdev, u8 status,
-				      u16 opcode)
-{
-	bt_dev_dbg(hdev, "status %u", status);
-}
-
-int hci_req_configure_datapath(struct hci_dev *hdev, struct bt_codec *codec)
-{
-	struct hci_request req;
-	int err;
-	__u8 vnd_len, *vnd_data = NULL;
-	struct hci_op_configure_data_path *cmd = NULL;
-
-	hci_req_init(&req, hdev);
-
-	err = hdev->get_codec_config_data(hdev, ESCO_LINK, codec, &vnd_len,
-					  &vnd_data);
-	if (err < 0)
-		goto error;
-
-	cmd = kzalloc(sizeof(*cmd) + vnd_len, GFP_KERNEL);
-	if (!cmd) {
-		err = -ENOMEM;
-		goto error;
-	}
-
-	err = hdev->get_data_path_id(hdev, &cmd->data_path_id);
-	if (err < 0)
-		goto error;
-
-	cmd->vnd_len = vnd_len;
-	memcpy(cmd->vnd_data, vnd_data, vnd_len);
-
-	cmd->direction = 0x00;
-	hci_req_add(&req, HCI_CONFIGURE_DATA_PATH, sizeof(*cmd) + vnd_len, cmd);
-
-	cmd->direction = 0x01;
-	hci_req_add(&req, HCI_CONFIGURE_DATA_PATH, sizeof(*cmd) + vnd_len, cmd);
-
-	err = hci_req_run(&req, config_data_path_complete);
-error:
-
-	kfree(cmd);
-	kfree(vnd_data);
-	return err;
-}
-
 void hci_request_setup(struct hci_dev *hdev)
 {
 	INIT_DELAYED_WORK(&hdev->adv_instance_expire, adv_timeout_expire);
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index faf6d9a51a91..41e0b84f2042 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -113,8 +113,6 @@ int hci_get_random_address(struct hci_dev *hdev, bool require_privacy,
 void __hci_req_update_class(struct hci_request *req);
 
 /* Returns true if HCI commands were queued */
-int hci_req_configure_datapath(struct hci_dev *hdev, struct bt_codec *codec);
-
 void __hci_req_update_scan(struct hci_request *req);
 
 int hci_update_random_address(struct hci_request *req, bool require_privacy,
-- 
2.37.1

