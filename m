Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9994B26ED56;
	Wed, 10 Dec 2025 12:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765370091; cv=none; b=PPhz3XcWYz+22XvrrW4Ie9/5pI/GqutLB0itmCBb9lcgkveGxRXKWq3LVXQRbDTtif/UoaES+7BunDV2oOjhoAgeX8A5NFBTSDAH6sAeDUVWppovUyug08QDWvrDVWIrnQ5dIQcR/8hBfLDSqC9xtyQSr/EJrWSr2h7yMJf6uFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765370091; c=relaxed/simple;
	bh=krBviYPd0FilovWdB5ds5AQhToKV9PVhaLn1/ViUQKg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SoOZ4TfaGKNKQ1MY0MLbEhrcVnvfGN+eyuPS85FXlAz1z5PBxSoOrvpeL0p3hvgQzZukOdvtRZDmrp2d9nztV3JQx7N3DF90Ao3q4Lx3r7RyTArohO0FPxu0M9ZihXZ7q6P5ot6ywpD2kzhfOtiQ+s/YgXOGYNhI10uVLyQGsfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=m1sEHWIF; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="m1sEHWIF"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BACYX1v8003718, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1765370073; bh=PzM/ldyfz2FDib+WC1SN9Y9FHLkH8OlRf0LOeQb2G2o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=m1sEHWIFHkKPcu3YgyCjEIzOJUVxVft4Kd696lZrpYS0eIE39sIXO5nnbCW8Y/sqH
	 8d5jW8Fg1o8H60nbHWnPHSNPXn8Jc5uGhlSm/KNNBmmSpSZxwpfpI7ByA7C1YD8ZJ3
	 zdJSQdh+PeG3pAt9KYOYsRIk3S0azSobDB8Vvdwh2s3kiNJ9X5VJ3NULEW3eOlAa9y
	 bbTqxnDzYnQik2fb0vgjTL8Eqco2qS1CGbBRjGSobJe4BxpQGJ96Bdk1n8jK5gdE7X
	 WUZTi3SSdBCAUNzyQWsCbz3xmCzf2HUM+1u81CFmdbiJTNuh9DI5+7zrqHJ0DpiPqN
	 PdxWN3/1rrGXQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BACYX1v8003718
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Dec 2025 20:34:33 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 10 Dec 2025 20:34:33 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 10 Dec 2025 20:34:33 +0800
Received: from localhost.localhost (172.24.54.48) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server id
 15.2.1544.27 via Frontend Transport; Wed, 10 Dec 2025 20:34:32 +0800
From: Hilda Wu <hildawu@realtek.com>
To: <marcel@holtmann.org>
CC: <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alex_lu@realsil.com.cn>,
        <jason_mao@realsil.com.cn>, <zoey_zhou@realsil.com.cn>,
        <max.chou@realtek.com>
Subject: [PATCH v5 3/3] Bluetooth: btrtl: Add enhanced ACL-based fw download for v3
Date: Wed, 10 Dec 2025 20:34:07 +0800
Message-ID: <20251210123407.3971233-3-hildawu@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251210123407.3971233-1-hildawu@realtek.com>
References: <20251210123407.3971233-1-hildawu@realtek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

When firmware format v3 is used, enable a new download mode that uses
HCI ACL packets to accelerate firmware transfer, reducing load time.

Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
Signed-off-by: Zoey Zhou <zoey_zhou@realsil.com.cn>
Signed-off-by: Hilda Wu <hildawu@realtek.com>

---
Change in V5:
- Define relevant macros to increase readability

Change in V4:
- Adjust and use skb_pull_data

Change in V3:
- Avoiding memory leak

Change in V2:
- Move structure to btrtl.h
- Fix build warnings
---
 drivers/bluetooth/btrtl.c | 190 +++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btrtl.h |  19 ++++
 2 files changed, 207 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 313005f37e33..28ea8e71c880 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -39,6 +39,7 @@
 #define RTL_ROM_LMP_8922A	0x8922
 #define RTL_CONFIG_MAGIC	0x8723ab55
 
+#define RTL_VSC_OP_ENHANCE_DOWNLOAD	0xfc1f
 #define RTL_VSC_OP_DOWNLOAD_CMD		0xfc20
 #define RTL_VSC_OP_READ_VENDER		0xfc61
 #define RTL_VSC_OP_WRITE_VENDOR		0xfc62
@@ -120,6 +121,8 @@ struct btrtl_device_info {
 	u32 opcode;
 	u8 fw_type;
 	u8 key_id;
+	u16 handle;
+	u16 acldata_pkt_len;
 	struct list_head patch_subsecs;
 	struct list_head patch_images;
 };
@@ -1312,6 +1315,163 @@ static int rtl_check_download_state(struct hci_dev *hdev,
 	return ret;
 }
 
+static int btrtl_enhanced_download_mode_enable(struct hci_dev *hdev,
+					struct btrtl_device_info *btrtl_dev)
+{
+	struct hci_rp_enhanced_download_mode *ev;
+	struct sk_buff *skb;
+	u16 opcode = RTL_VSC_OP_ENHANCE_DOWNLOAD;
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
+		bt_dev_dbg(hdev, "acl download fw (%d/%d). index = %d", i,
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
@@ -1403,6 +1563,7 @@ static int rtl_download_firmware_v3(struct hci_dev *hdev,
 	struct rtl_section_patch_image *image, *tmp;
 	struct rtl_rp_dl_v3 *rp;
 	struct sk_buff *skb;
+	u8 enh_dl = 0;
 	u8 *fw_data;
 	int fw_len;
 	int ret = 0;
@@ -1417,6 +1578,16 @@ static int rtl_download_firmware_v3(struct hci_dev *hdev,
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
@@ -1455,8 +1626,13 @@ static int rtl_download_firmware_v3(struct hci_dev *hdev,
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
@@ -1718,6 +1894,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 
 	INIT_LIST_HEAD(&btrtl_dev->patch_subsecs);
 	INIT_LIST_HEAD(&btrtl_dev->patch_images);
+	init_waitqueue_head(&btrtl_data->dlreq_wait_q);
 
 check_version:
 	ret = btrtl_read_chip_id(hdev, &chip_id);
@@ -2052,6 +2229,7 @@ EXPORT_SYMBOL_GPL(btrtl_shutdown_realtek);
 
 int btrtl_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 {
+	struct btrealtek_data *btrtl_data = hci_get_priv(hdev);
 	struct sk_buff *clone = skb_clone(skb, GFP_ATOMIC);
 	struct hci_event_hdr *hdr;
 	u8 *p;
@@ -2071,6 +2249,14 @@ int btrtl_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
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
index dd4acdf29b2f..636c3cd63eb3 100644
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

