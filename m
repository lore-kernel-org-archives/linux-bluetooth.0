Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B339C273FE;
	Tue,  8 Jul 2025 12:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751978742; cv=none; b=aGbjQDLNZkcRJFAm1TJlue+Bt8W2pzL5j8aKXi5s39Y+RYBUSZ6qJwzU12KO9r8R8FRm+Vn7Wn4FEdOWXUR41IJXDXSmMTfNPs7Kb6ozaBM3M7zSRS9ikvOdf2WNnVwgJhUmseT3AH1jqhzs0oi6T5mxhiSmIHe5/5XSwfcQrH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751978742; c=relaxed/simple;
	bh=FC/4CSFkoPaYDJUorAH5XRDvSX/s+8L4p3t6b43iqHQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bw3oG4tvwJ8Dx2FpH5Rye1orCTPRGw6vHhWM7V50kI60ULAMHF+d5Gyj+IrlaUyxurLBSGHxVxJlbGKrHxOUk1R4p5Gz7UuWJ4AhIcFfzq7N3mZWjwmeqFuuc8EeJ52nh5mT4TniwjdKDUZkBIckJ+MS7gquYxVkN79JdMSDV0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=TjxA/leP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="TjxA/leP"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 568CjSHd93728234, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1751978728; bh=Ayt2uKOoMCwJnGboOBdkkrGSeAQY8TKuSKbNCV/fncs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=TjxA/lePrL+l2ehhws2LNha0vybetdB7ofSZ8Z7/fs3/x3R/CnGAuq7HWkCjUc00N
	 ADK9/NStWJb/AN0vBMoVbvaPS+3Nb+IU4Axeyyj2y++WmhjDACoJyDuiSmrzndhwUt
	 FHbK2OgLftrk1peLVzWhz+nvyawn4IQkENCpRpIFyclLvMP9w2VzSTLUU1B4m0p4J+
	 KH2+cIy3MOwAwBkqYoKceocFoTg/frBTsAUaijYsty2hLiFzdlWHWp8X1+MiF8rswv
	 7/y5Ta4HHmnrbhD/P+NMjBctWxwVdN2tWtBPdZB+WT8Io7e2RvAdMGhebwHdKu6Xle
	 4hpG6cCE4ltKQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 568CjSHd93728234
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Jul 2025 20:45:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Jul 2025 20:45:57 +0800
Received: from localhost.localhost (172.21.132.53) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 8 Jul
 2025 20:45:54 +0800
From: Hilda Wu <hildawu@realtek.com>
To: <marcel@holtmann.org>
CC: <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alex_lu@realsil.com.cn>,
        <max.chou@realtek.com>
Subject: [PATCH v3 2/2] Bluetooth: btrtl: Add enhanced download support
Date: Tue, 8 Jul 2025 20:45:16 +0800
Message-ID: <20250708124516.2836881-2-hildawu@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708124516.2836881-1-hildawu@realtek.com>
References: <20250708124516.2836881-1-hildawu@realtek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Add an enhanced download mode for firmware format v3.
Use ACL to speed up firmware downloads.

Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
Signed-off-by: Hilda Wu <hildawu@realtek.com>
---
Change in V3:
- Avoiding memory leak

Change in V2:
- Move structure to btrtl.h
- Fix build warnings
---
---
 drivers/bluetooth/btrtl.c | 193 +++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btrtl.h |  20 ++++
 2 files changed, 211 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index af28f5355aa1..27df5e439e89 100644
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
@@ -1705,6 +1880,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 
 	INIT_LIST_HEAD(&btrtl_dev->patch_subsecs);
 	INIT_LIST_HEAD(&btrtl_dev->patch_images);
+	init_waitqueue_head(&btrtl_data->dlreq_wait_q);
 
 check_version:
 	ret = btrtl_read_chip_id(hdev, &chip_id);
@@ -2025,6 +2201,7 @@ EXPORT_SYMBOL_GPL(btrtl_shutdown_realtek);
 
 int btrtl_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 {
+	struct btrealtek_data *btrtl_data = hci_get_priv(hdev);
 	struct hci_event_hdr *hdr = (void *)skb->data;
 
 	if (skb->len > HCI_EVENT_HDR_SIZE && hdr->evt == 0xff &&
@@ -2032,6 +2209,18 @@ int btrtl_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 		if (skb->data[2] == 0x77 &&
 		    btrealtek_test_and_clear_flag(hdev, REALTEK_DOWNLOADING)) {
 			btrealtek_wake_up_flag(hdev, REALTEK_DOWNLOADING);
+			/* skb should be free here. */
+			kfree_skb(skb);
+			return 0;
+		} else if (skb->data[2] == 0x2a) {
+			if (btrtl_data->dlreq_status == HCI_REQ_PEND) {
+				btrtl_data->dlreq_result = 0;
+				btrtl_data->dlreq_status = HCI_REQ_DONE;
+				skb_pull(skb, sizeof(*hdr));
+				btrtl_data->dlreq_rsp = skb_get(skb);
+				wake_up_interruptible(&btrtl_data->dlreq_wait_q);
+			}
+			kfree_skb(skb);
 			return 0;
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

