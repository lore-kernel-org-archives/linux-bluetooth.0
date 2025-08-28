Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC03A277800;
	Thu, 28 Aug 2025 06:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756361096; cv=none; b=JNNrVou0GvIAcFkuyUED3Ic2MLLI2ZMMy5Egheh0iruTq9ZRLpaE6qynmMXL+Arhl0IGQ5C65rkHr1bbV1TviXOYqPKchMwrhR/CtsMa330nWrH0Z+6pWNv56ZATDDY69edftB2zcvVsuK0OnmEhRM1qks4CuihDxBRB1urL9KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756361096; c=relaxed/simple;
	bh=GxpKZ1h0F3WZVVQc/3bebFvOhHjVHmMV8Ch9ZImFlFM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uD13V4WL4abpng2BeA6YIe0GlhjqEiU1R3Yj519AZbWu9t9L2OFOFoXHxTuJodf1IcHWBeVfQVnMv7kJN5DpF3fc6yHxwnCFrN+1cOBRfsGOTKMJ1eyWcfAoBSEVjEHWiIUBHqo29yOQSGRabaygF0C76gkO2Pom4Rx50Ci4B3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=gG0Mm+qH; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="gG0Mm+qH"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57S64b2W21114281, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756361077; bh=18l9j6aWLanqOEzeNto6izS8CvM1R0PXmM6SwfZ9eSg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=gG0Mm+qH7Rqi1hTJQo3KjnShTWvVBaeciGqil1eFk+JxeElMVWyIAnOX/2HYpcM/z
	 TBLTPTxVuGcKS/CT7WeDFShmMhH9OOtPvx2OkNC+GIU7UjmwNSY7O80rRkJ9VRDSV2
	 iLpw/XEHbsjpjut0hYxSf9hrXSJfd/aYD5eP4RLzO3zVcvWQY8eyDIEtPMk1i37PRe
	 uBGpe+fLDuCxZra+fJhrV1VuoKmri8oB/6s+5v+hXhqZIACMWxWhO1dIwkCT4FPWTp
	 wIW8iSUQmBqtPnFlT8qV/uidPPhhk5O1sCnSwrB6UDiZMbOCzsNNV0ZcctLAt8jH6Q
	 GEI5AWTGKVQ3A==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57S64b2W21114281
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 14:04:37 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 28 Aug 2025 14:04:37 +0800
Received: from localhost.localhost (172.21.132.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 28 Aug 2025 14:04:36 +0800
From: Hilda Wu <hildawu@realtek.com>
To: <marcel@holtmann.org>
CC: <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alex_lu@realsil.com.cn>,
        <max.chou@realtek.com>
Subject: [PATCH v4 2/2] Bluetooth: btrtl: Add enhanced download support
Date: Thu, 28 Aug 2025 14:04:27 +0800
Message-ID: <20250828060427.1794237-2-hildawu@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828060427.1794237-1-hildawu@realtek.com>
References: <20250828060427.1794237-1-hildawu@realtek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTKEXHMBS05.realtek.com.tw (10.21.1.55)

From: Alex Lu <alex_lu@realsil.com.cn>

Add an enhanced download mode for firmware format v3.
Use ACL to speed up firmware downloads.

Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
Signed-off-by: Hilda Wu <hildawu@realtek.com>
---
Change in V4:
- Adjust and use skb_pull_data

Change in V3:
- Avoiding memory leak

Change in V2:
- Move structure to btrtl.h
- Fix build warnings
---
---
 drivers/bluetooth/btrtl.c | 188 +++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btrtl.h |  19 ++++
 2 files changed, 205 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index dbf087a8cc97..58c14c90345e 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -108,6 +108,8 @@ struct btrtl_device_info {
 	u32 opcode;
 	u8 fw_type;
 	u8 key_id;
+	u16 handle;
+	u16 acldata_pkt_len;
 	struct list_head patch_subsecs;
 	struct list_head patch_images;
 };
@@ -1314,6 +1316,163 @@ static int rtl_check_download_state(struct hci_dev *hdev,
 	return ret;
 }
 
+static int btrtl_enhanced_download_mode_enable(struct hci_dev *hdev,
+					struct btrtl_device_info *btrtl_dev)
+{
+	struct hci_rp_enhanced_download_mode *ev;
+	struct sk_buff *skb;
+	u16 opcode = 0xfc1f;
+	u8 val = 1;
+	int ret = -EINVAL;
+
+	skb = __hci_cmd_sync(hdev, opcode, 1, &val, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "send %04x error (%lu)", opcode, PTR_ERR(skb));
+		return -EIO;
+	}
+	ev = skb_pull_data(skb, sizeof(*ev));
+	if (!ev)
+		goto err;
+	if (ev->status) {
+		bt_dev_err(hdev, "got invalid status 0x%02x", ev->status);
+		goto err;
+	}
+	btrtl_dev->handle = le16_to_cpu(ev->handle);
+	btrtl_dev->acldata_pkt_len = le16_to_cpu(ev->acldata_pkt_len);
+	kfree_skb(skb);
+
+	bt_dev_dbg(hdev, "enhanced download mode enabled, handle %04x, acl %u",
+		   btrtl_dev->handle, btrtl_dev->acldata_pkt_len);
+
+	return 0;
+err:
+	kfree_skb(skb);
+	return ret;
+}
+
+static int rtl_acl_download_firmware(struct hci_dev *hdev,
+				     struct btrtl_device_info *btrtl_dev,
+				     const unsigned char *data, int fw_len)
+{
+	struct btrealtek_data *btrtl_data = hci_get_priv(hdev);
+	int frag_num;
+	int frag_len;
+	int ret = 0;
+	int i;
+	int j = 0;
+	struct sk_buff *skb;
+	struct rtl_acl_download_rp *rp;
+	u16 max_payload_len;
+	struct hci_acl_hdr *hdr;
+	u8 index;
+
+	if (is_v3_fw(btrtl_dev->fw_type))
+		j = 1;
+
+	btrtl_data->dlreq_status = 0;
+	btrtl_data->dlreq_result = 0;
+	btrtl_data->dlreq_rsp = NULL;
+	max_payload_len = (btrtl_dev->acldata_pkt_len - 1) & ~0x3;
+	frag_num = fw_len / max_payload_len + 1;
+	frag_len = max_payload_len;
+
+	for (i = 0; i < frag_num; i++) {
+		index = j++;
+		if (index == 0x7f)
+			j = 1;
+
+		if (i == (frag_num - 1)) {
+			if (!is_v3_fw(btrtl_dev->fw_type))
+				index |= 0x80; /* data end */
+			frag_len = fw_len % max_payload_len;
+		}
+		rtl_dev_dbg(hdev, "acl download fw (%d/%d). index = %d", i,
+			    frag_num, index);
+
+		skb = bt_skb_alloc(sizeof(*hdr) + 1 + frag_len, GFP_KERNEL);
+		if (!skb)
+			return -ENOMEM;
+		hdr = (struct hci_acl_hdr *)skb_put(skb, sizeof(*hdr));
+		hdr->handle = cpu_to_le16(btrtl_dev->handle | 0x8000);
+		hdr->dlen = cpu_to_le16(1 + frag_len);
+		*(u8 *)skb_put(skb, 1) = index;
+		memcpy(skb_put(skb, frag_len), data, frag_len);
+
+		hci_skb_pkt_type(skb) = HCI_ACLDATA_PKT;
+
+		btrtl_data->dlreq_status = HCI_REQ_PEND;
+
+		ret = hdev->send(hdev, skb);
+		if (ret < 0) {
+			bt_dev_err(hdev, "sending frame failed (%d)", ret);
+			goto err;
+		}
+
+		ret = wait_event_interruptible_timeout(btrtl_data->dlreq_wait_q,
+				btrtl_data->dlreq_status != HCI_REQ_PEND,
+				HCI_INIT_TIMEOUT);
+		if (ret == -ERESTARTSYS)
+			goto out;
+
+		switch (btrtl_data->dlreq_status) {
+		case HCI_REQ_DONE:
+			ret = -bt_to_errno(btrtl_data->dlreq_result);
+			break;
+
+		case HCI_REQ_CANCELED:
+			ret = -btrtl_data->dlreq_result;
+			break;
+
+		default:
+			ret = -ETIMEDOUT;
+			break;
+		}
+
+		btrtl_data->dlreq_status = 0;
+		btrtl_data->dlreq_result = 0;
+		skb = btrtl_data->dlreq_rsp;
+		btrtl_data->dlreq_rsp = NULL;
+
+		bt_dev_dbg(hdev, "end: err %d", ret);
+
+		if (ret < 0) {
+			bt_dev_err(hdev, "wait on complete err (%d)", ret);
+			goto err;
+		}
+
+		if (!skb)
+			return -ENODATA;
+
+		rp = skb_pull_data(skb, sizeof(*rp));
+		if (!rp) {
+			rtl_dev_err(hdev, "acl download fw event len mismatch");
+			ret = -EIO;
+			goto err;
+		}
+		if ((btrtl_dev->handle & 0xfff) != le16_to_cpu(rp->handle)) {
+			rtl_dev_err(hdev, "handle mismatch (%04x %04x)",
+				    btrtl_dev->handle & 0xfff,
+				    le16_to_cpu(rp->handle));
+			ret = -EINVAL;
+			goto err;
+		}
+		if (index != rp->index) {
+			rtl_dev_err(hdev, "index mismatch (%u, %u)", index,
+				    rp->index);
+			ret = -EINVAL;
+			goto err;
+		}
+
+		kfree_skb(skb);
+		data += frag_len;
+	}
+out:
+	return ret;
+err:
+	kfree_skb(skb);
+	return ret;
+}
+
 static int rtl_finalize_download(struct hci_dev *hdev,
 				 struct btrtl_device_info *btrtl_dev)
 {
@@ -1409,6 +1568,7 @@ static int rtl_download_firmware_v3(struct hci_dev *hdev,
 	int fw_len;
 	int ret = 0;
 	u8 i;
+	u8 enh_dl = 0;
 
 	if (btrtl_dev->fw_type == FW_TYPE_V3_2) {
 		ret = rtl_check_download_state(hdev, btrtl_dev);
@@ -1419,6 +1579,16 @@ static int rtl_download_firmware_v3(struct hci_dev *hdev,
 		}
 	}
 
+	switch (btrtl_dev->project_id) {
+	case CHIP_ID_8852C:
+	case CHIP_ID_8922D:
+		if (!btrtl_enhanced_download_mode_enable(hdev, btrtl_dev))
+			enh_dl = 1;
+		break;
+	default:
+		break;
+	}
+
 	list_for_each_entry_safe(image, tmp, &btrtl_dev->patch_images, list) {
 		rtl_dev_dbg(hdev, "image (%04x:%02x)", image->image_id,
 			    image->index);
@@ -1457,8 +1627,12 @@ static int rtl_download_firmware_v3(struct hci_dev *hdev,
 		rtl_dev_dbg(hdev, "fw_data %p, image buf %p, len %u", fw_data,
 			    image->image_data, image->image_len);
 
-		ret = rtl_download_firmware(hdev, btrtl_dev->fw_type, fw_data,
-					    fw_len);
+		if (enh_dl)
+			ret = rtl_acl_download_firmware(hdev, btrtl_dev,
+							fw_data, fw_len);
+		else
+			ret = rtl_download_firmware(hdev, btrtl_dev->fw_type,
+						    fw_data, fw_len);
 		kvfree(fw_data);
 		if (ret < 0) {
 			rtl_dev_err(hdev, "download firmware failed (%d)", ret);
@@ -1718,6 +1892,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 
 	INIT_LIST_HEAD(&btrtl_dev->patch_subsecs);
 	INIT_LIST_HEAD(&btrtl_dev->patch_images);
+	init_waitqueue_head(&btrtl_data->dlreq_wait_q);
 
 check_version:
 	ret = btrtl_read_chip_id(hdev, &chip_id);
@@ -2038,6 +2213,7 @@ EXPORT_SYMBOL_GPL(btrtl_shutdown_realtek);
 
 int btrtl_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 {
+	struct btrealtek_data *btrtl_data = hci_get_priv(hdev);
 	struct sk_buff *clone = skb_clone(skb, GFP_ATOMIC);
 	struct hci_event_hdr *hdr;
 	u8 *p;
@@ -2057,6 +2233,14 @@ int btrtl_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 		if (btrealtek_test_and_clear_flag(hdev, REALTEK_DOWNLOADING))
 			btrealtek_wake_up_flag(hdev, REALTEK_DOWNLOADING);
 		break;
+	case 0x2a:
+		if (btrtl_data->dlreq_status == HCI_REQ_PEND) {
+			btrtl_data->dlreq_result = 0;
+			btrtl_data->dlreq_status = HCI_REQ_DONE;
+			btrtl_data->dlreq_rsp = skb_get(clone);
+			wake_up_interruptible(&btrtl_data->dlreq_wait_q);
+		}
+		break;
 	}
 out:
 	consume_skb(clone);
diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
index e642a9da586c..54e4b9952142 100644
--- a/drivers/bluetooth/btrtl.h
+++ b/drivers/bluetooth/btrtl.h
@@ -203,8 +203,27 @@ struct btrealtek_data {
 	DECLARE_BITMAP(flags, __REALTEK_NUM_FLAGS);
 
 	struct rtl_dump_info rtl_dump;
+
+	wait_queue_head_t	dlreq_wait_q;
+	__u32                   dlreq_status;
+	__u32                   dlreq_result;
+	struct sk_buff          *dlreq_rsp;
 };
 
+struct rtl_acl_download_rp {
+	__u8 index;
+	__le16 handle;
+	__le32 loaded_len;
+} __packed;
+
+struct hci_rp_enhanced_download_mode {
+	__u8 status;
+	__u8 reserved1;
+	__le16 handle;
+	__le16 acldata_pkt_len;
+	__u8 reserved2;
+} __packed;
+
 #define btrealtek_set_flag(hdev, nr)					\
 	do {								\
 		struct btrealtek_data *realtek = hci_get_priv((hdev));	\
-- 
2.34.1

