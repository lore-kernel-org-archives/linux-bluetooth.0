Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B37286406;
	Fri,  6 Jun 2025 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749200809; cv=none; b=kgaiyycifjdSo0dIWkm3dC8muGVbzpCJUy8pq7SmBsOBggQjrXKGou0vEGcF9B5pqAXCNUeFfbhEtv1vS+hVpg+TzbaisMdxXWc1IrwhebZXb2tQ1Gm9vc7Sgq4XCST0q0A3zRqScAPfShiFuT2uy1M+wfAwWTpHi4ifbptDMdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749200809; c=relaxed/simple;
	bh=JOsKIBUlmRz0UKp81iF752YmgjWtILzfZs1mqglJcYk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i4RLm67XT5ChXtk/AZVFr2aQVjobd7ppP6YMJ4aB4dVtXkdjyU3uXQhlmI56dRV/Sauyeg90XUUDvAtxUm2G23OW6jJ2wn5mBoU3mR4l05/Jnnud9D7oBuQvajB/CRlFsVi1rdh9OoAOmA/jnhcBrh9O3nvKTmFM01JED/2qeOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=tno/NgNM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="tno/NgNM"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55696cjbE3110450, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749200798; bh=4DMjkI3NkAfLBpAIHb4mi49e9oMyaYlYo4DS/eYvlDE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=tno/NgNM/LxSHJOztjBptpDOnzYlxL2lR6LXoRC9krhC9BrlkV1iwJabOCSNYIz2h
	 I57mheqJygfhhkqXNXWHeOKOo9uiyvCrrHc4Itoi3IepNIbwqHc9ch655A35QRfNsh
	 va9PR++yqYQgS/Bgtl3adf8jutFm7+AMT+XQqq5uCVR7Wbxp71w/chv3jchS/xa759
	 R7Z/o6aTjR+IDJ5jqI3TuCOsWelmu1UkX1yyVGiTY40b2R5z8ESPi6DIrluQbwlywH
	 sVbSeo1tR5KH7llAPB6XmK2VZ/0uGhMRRGoYqqdPuAPhYiN/gNsDuByF0f0pfJLCUb
	 k+PmlgikckPPQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55696cjbE3110450
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Jun 2025 17:06:38 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Jun 2025 17:06:38 +0800
Received: from localhost.localhost (172.21.132.53) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 6 Jun
 2025 17:06:38 +0800
From: Hilda Wu <hildawu@realtek.com>
To: <marcel@holtmann.org>
CC: <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <max.chou@realtek.com>,
        <alex_lu@realsil.com.cn>
Subject: [PATCH v2 2/2] Bluetooth: btrtl: Add enhanced download support
Date: Fri, 6 Jun 2025 17:05:59 +0800
Message-ID: <20250606090559.896242-3-hildawu@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250606090559.896242-1-hildawu@realtek.com>
References: <20250606090559.896242-1-hildawu@realtek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)

Add an enhanced download mode for firmware format v3.
Use ACL to speed up firmware downloads.

Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
Signed-off-by: Hilda Wu <hildawu@realtek.com>
---
Change in V2:
- Move structure to btrtl.h
- Fix build warnings
---
 drivers/bluetooth/btrtl.c | 190 +++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btrtl.h |  20 ++++
 2 files changed, 208 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index d88a86b547d1..b871b2413265 100644
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
@@ -1310,6 +1312,163 @@ static int rtl_check_download_state(struct hci_dev *hdev,
 	return 0;
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
+	if (skb->len != sizeof(*ev)) {
+		bt_dev_err(hdev, "got invalid cmd complete, %u %zu", skb->len,
+			   sizeof(*ev));
+		goto err;
+	}
+	ev = (struct hci_rp_enhanced_download_mode *)skb->data;
+	if (ev->status) {
+		bt_dev_err(hdev, "got invalid status 0x%02x", ev->status);
+		goto err;
+	}
+	btrtl_dev->handle = le16_to_cpu(ev->handle);
+	btrtl_dev->acldata_pkt_len = le16_to_cpu(ev->acldata_pkt_len);
+	kfree_skb(skb);
+
+	bt_dev_info(hdev, "enhanced download mode enabled, handle %04x, acl %u",
+		    btrtl_dev->handle, btrtl_dev->acldata_pkt_len);
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
+	int frag_num = fw_len / RTL_FRAG_LEN + 1;
+	int frag_len = RTL_FRAG_LEN;
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
+
+	for (i = 0; i < frag_num; i++) {
+		index = j++;
+		if (index == 0x7f)
+			j = 1;
+
+		if (i == (frag_num - 1) && !is_v3_fw(btrtl_dev->fw_type)) {
+			index |= 0x80; /* data end */
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
+		if (skb->len != sizeof(*rp)) {
+			rtl_dev_err(hdev, "acl download fw event len mismatch");
+			ret = -EIO;
+			goto err;
+		}
+		rp = (struct rtl_acl_download_rp *)skb->data;
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
@@ -1394,6 +1553,7 @@ static int rtl_download_firmware_v3(struct hci_dev *hdev,
 	struct rtl_section_patch_image *image, *tmp;
 	struct rtl_rp_dl_v3 *rp;
 	struct sk_buff *skb;
+	u8 enh_dl = 0;
 	u8 *fw_data;
 	int fw_len;
 	int ret = 0;
@@ -1408,6 +1568,16 @@ static int rtl_download_firmware_v3(struct hci_dev *hdev,
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
@@ -1446,8 +1616,13 @@ static int rtl_download_firmware_v3(struct hci_dev *hdev,
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
+
 		kvfree(fw_data);
 		if (ret < 0) {
 			rtl_dev_err(hdev, "download firmware failed (%d)", ret);
@@ -1707,6 +1882,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 
 	INIT_LIST_HEAD(&btrtl_dev->patch_subsecs);
 	INIT_LIST_HEAD(&btrtl_dev->patch_images);
+	init_waitqueue_head(&btrtl_data->dlreq_wait_q);
 
 check_version:
 	ret = btrtl_read_chip_id(hdev, &chip_id);
@@ -2027,6 +2203,7 @@ EXPORT_SYMBOL_GPL(btrtl_shutdown_realtek);
 
 int btrtl_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 {
+	struct btrealtek_data *btrtl_data = hci_get_priv(hdev);
 	struct hci_event_hdr *hdr = (void *)skb->data;
 
 	if (skb->len > HCI_EVENT_HDR_SIZE && hdr->evt == 0xff &&
@@ -2035,6 +2212,15 @@ int btrtl_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 		    btrealtek_test_and_clear_flag(hdev, REALTEK_DOWNLOADING)) {
 			btrealtek_wake_up_flag(hdev, REALTEK_DOWNLOADING);
 			return 0;
+		} else if (skb->data[2] == 0x2a) {
+			if (btrtl_data->dlreq_status == HCI_REQ_PEND) {
+				btrtl_data->dlreq_result = 0;
+				btrtl_data->dlreq_status = HCI_REQ_DONE;
+				skb_pull(skb, sizeof(*hdr));
+				btrtl_data->dlreq_rsp = skb;
+				wake_up_interruptible(&btrtl_data->dlreq_wait_q);
+			}
+			return 0;
 		}
 	}
 
diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
index f6f03a5fefba..7f15b30680d7 100644
--- a/drivers/bluetooth/btrtl.h
+++ b/drivers/bluetooth/btrtl.h
@@ -203,8 +203,28 @@ struct btrealtek_data {
 	DECLARE_BITMAP(flags, __REALTEK_NUM_FLAGS);
 
 	struct rtl_dump_info rtl_dump;
+
+	wait_queue_head_t	dlreq_wait_q;
+	__u32                   dlreq_status;
+	__u32                   dlreq_result;
+	struct sk_buff          *dlreq_rsp;
 };
 
+struct rtl_acl_download_rp {
+	__u8 subevent;
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

