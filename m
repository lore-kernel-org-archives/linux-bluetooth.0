Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFF4C25B0E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Aug 2022 19:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbiHPTEm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Aug 2022 15:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236114AbiHPTEl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Aug 2022 15:04:41 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573BF5D11B
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Aug 2022 12:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660676680; x=1692212680;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OYCG6APw2zW1Dw8v8EZcws1ZS3zMh17pmygHWx45glc=;
  b=I3C1bso3yiTc5G5bK5mG5+iPR+sk66mlshAk2PFYI8V5PSqsXyWna/Rb
   BzgJJg/l2xvcC53IgtfJu2hPxJx9M7FgbblqxHUgd9u9QR6R2a7QK2Ae1
   9zdIzSJo85cCJNzKcqCfFDSO78y83qBFlMjtk9Z9Tz3bX+HoQcHuqYUSc
   fAXcX5irSSIfx8Z7L1sOxVk76hNRDKfi6cYfAMYW1TJvqTX2CQXNoBWr5
   LO6pE8N9rPys3oBM1hjcmwM33jS3H0IJBphHIbaGM/FeUuD/GBv4apYEJ
   zmT1nlBIINnT+fQlJOW6o2xxQ8POCRHRHMSTX3qnn0lFSz1b5SuGEdKOr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="378596888"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="378596888"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 12:04:40 -0700
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="640152224"
Received: from frperuch-mobl1.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.23.122])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 12:04:39 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH v2] Bluetooth: Normalize HCI_OP_READ_ENC_KEY_SIZE cmdcmplt
Date:   Tue, 16 Aug 2022 12:04:34 -0700
Message-Id: <20220816190434.1015206-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The HCI_OP_READ_ENC_KEY_SIZE command is converted from using the
deprecated hci_request mechanism to use hci_send_cmd, with an
accompanying hci_cc_read_enc_key_size to handle it's return response.

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 net/bluetooth/hci_event.c | 92 +++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 47 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 938abe6352bf..2feb5af30d35 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -712,6 +712,47 @@ static u8 hci_cc_read_local_version(struct hci_dev *hdev, void *data,
 	return rp->status;
 }
 
+static u8 hci_cc_read_enc_key_size(struct hci_dev *hdev, void *data,
+				   struct sk_buff *skb)
+{
+	struct hci_rp_read_enc_key_size *rp = data;
+	struct hci_conn *conn;
+	u16 handle;
+	u8 status = rp->status;
+
+	bt_dev_dbg(hdev, "status 0x%2.2x", status);
+
+	handle = le16_to_cpu(rp->handle);
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_handle(hdev, handle);
+	if (!conn) {
+		status = 0xFF;
+		goto done;
+	}
+
+	/* While unexpected, the read_enc_key_size command may fail. The most
+	 * secure approach is to then assume the key size is 0 to force a
+	 * disconnection.
+	 */
+	if (status) {
+		bt_dev_err(hdev, "failed to read key size for handle %u",
+			   handle);
+		conn->enc_key_size = 0;
+	} else {
+		conn->enc_key_size = rp->key_size;
+		status = 0;
+	}
+
+	hci_encrypt_cfm(conn, 0);
+
+done:
+	hci_dev_unlock(hdev);
+
+	return status;
+}
+
 static u8 hci_cc_read_local_commands(struct hci_dev *hdev, void *data,
 				     struct sk_buff *skb)
 {
@@ -3534,47 +3575,6 @@ static void hci_remote_name_evt(struct hci_dev *hdev, void *data,
 	hci_dev_unlock(hdev);
 }
 
-static void read_enc_key_size_complete(struct hci_dev *hdev, u8 status,
-				       u16 opcode, struct sk_buff *skb)
-{
-	const struct hci_rp_read_enc_key_size *rp;
-	struct hci_conn *conn;
-	u16 handle;
-
-	BT_DBG("%s status 0x%02x", hdev->name, status);
-
-	if (!skb || skb->len < sizeof(*rp)) {
-		bt_dev_err(hdev, "invalid read key size response");
-		return;
-	}
-
-	rp = (void *)skb->data;
-	handle = le16_to_cpu(rp->handle);
-
-	hci_dev_lock(hdev);
-
-	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	if (!conn)
-		goto unlock;
-
-	/* While unexpected, the read_enc_key_size command may fail. The most
-	 * secure approach is to then assume the key size is 0 to force a
-	 * disconnection.
-	 */
-	if (rp->status) {
-		bt_dev_err(hdev, "failed to read key size for handle %u",
-			   handle);
-		conn->enc_key_size = 0;
-	} else {
-		conn->enc_key_size = rp->key_size;
-	}
-
-	hci_encrypt_cfm(conn, 0);
-
-unlock:
-	hci_dev_unlock(hdev);
-}
-
 static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 				   struct sk_buff *skb)
 {
@@ -3639,7 +3639,6 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 	/* Try reading the encryption key size for encrypted ACL links */
 	if (!ev->status && ev->encrypt && conn->type == ACL_LINK) {
 		struct hci_cp_read_enc_key_size cp;
-		struct hci_request req;
 
 		/* Only send HCI_Read_Encryption_Key_Size if the
 		 * controller really supports it. If it doesn't, assume
@@ -3650,12 +3649,9 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 			goto notify;
 		}
 
-		hci_req_init(&req, hdev);
-
 		cp.handle = cpu_to_le16(conn->handle);
-		hci_req_add(&req, HCI_OP_READ_ENC_KEY_SIZE, sizeof(cp), &cp);
-
-		if (hci_req_run_skb(&req, read_enc_key_size_complete)) {
+		if (hci_send_cmd(hdev, HCI_OP_READ_ENC_KEY_SIZE,
+				 sizeof(cp), &cp)) {
 			bt_dev_err(hdev, "sending read key size failed");
 			conn->enc_key_size = HCI_LINK_KEY_SIZE;
 			goto notify;
@@ -4037,6 +4033,8 @@ static const struct hci_cc {
 	       sizeof(struct hci_rp_read_local_amp_info)),
 	HCI_CC(HCI_OP_READ_CLOCK, hci_cc_read_clock,
 	       sizeof(struct hci_rp_read_clock)),
+	HCI_CC(HCI_OP_READ_ENC_KEY_SIZE, hci_cc_read_enc_key_size,
+	       sizeof(struct hci_rp_read_enc_key_size)),
 	HCI_CC(HCI_OP_READ_INQ_RSP_TX_POWER, hci_cc_read_inq_rsp_tx_power,
 	       sizeof(struct hci_rp_read_inq_rsp_tx_power)),
 	HCI_CC(HCI_OP_READ_DEF_ERR_DATA_REPORTING,
-- 
2.37.1

