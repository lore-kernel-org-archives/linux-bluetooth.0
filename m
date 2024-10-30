Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA45194151;
	Wed, 30 Oct 2024 10:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730282905; cv=none; b=aAz8ZyHiIs7rMMN35ghSbSmyLQzyB4hRUX5vC10GTAM0UhHOpb9QImawTKdpj/yLhk/yxPoO7yqX3uvEEFnSeLyFQskFqmUUFUS1A3WLteR97GH25J5a1fYB7U7a6Rh6KcL4sOn/O32rxrx/XmjodkXnVal/bldDzSwemJ6WXFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730282905; c=relaxed/simple;
	bh=7Q+MTQAKucz7iLxuJeNISzJ9qykwouLo3OSjZDpUyFs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F7Ufz7Qrvx6jeGsK29M6NMBonhVPhGvIl1xyWJL+TGkSHAWbtgMeHEL4BKKO3lFwK3o17mg0JJExL47nnle1mKj8hAgN/p3TKS18feMbeMr1k7HUIEWK58PMLzRiUjosKUcf4cCf11LmBXo6f4bnE2pdGduZ/xXcMZ9vB51w4IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=TSC31qEP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="TSC31qEP"
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49UA89irC3852080, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730282889; bh=7Q+MTQAKucz7iLxuJeNISzJ9qykwouLo3OSjZDpUyFs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=TSC31qEPq6jIlmKGj1cXD/lxxj/Ke76wzyZjg1D1wt68W2Y9wguNt4kPeLZcrYDQD
	 Ci71n+V5nv6yBLWL5PM/rtwcEFLfW9l0UHAY+JHAQIJcOi/WNCgd5eDrnSepWJVPMn
	 54dxakyN2/M/agQCgWnebDBRJ/dKpbRjJTUuVQhhcCQBqyXkFTn7OYVQv+btMN4Ywc
	 njAE4trr9cw4KwGi/S4E84gy430BczMIOb10mNheoTrsV2yuaRkEyWTvddnWcsFSM1
	 E0GJYbYj7uhHp4az+IA495Ma7q0LQjtt9M+8TdrsiUwp2QShRZbjAKubDMpY7CHA1f
	 TbCjrXO1+qZMQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49UA89irC3852080
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 18:08:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 18:08:09 +0800
Received: from localhost.localhost (172.21.132.53) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 30 Oct
 2024 18:08:08 +0800
From: Hilda Wu <hildawu@realtek.com>
To: <marcel@holtmann.org>
CC: <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <max.chou@realtek.com>,
        <alex_lu@realsil.com.cn>, <kidman@realtek.com>
Subject: [PATCH] bluetooth: add quirk using packet size 60
Date: Wed, 30 Oct 2024 18:08:04 +0800
Message-ID: <20241030100804.2743115-1-hildawu@realtek.com>
X-Mailer: git-send-email 2.34.1
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

The RTL8852BE-VT supports USB alternate setting 6.
However, its descriptor does not report this capability to the host.
Therefore, a quirk is needed to bypass the RTL8852BE-VT's descriptor
and allow it to use USB ALT 6 directly.

Signed-off-by: Hilda Wu <hildawu@realtek.com>
---
 drivers/bluetooth/btrtl.c |  3 ++
 drivers/bluetooth/btrtl.h |  1 +
 drivers/bluetooth/btusb.c | 89 ++++++++++++++++++++++++++++++---------
 3 files changed, 73 insertions(+), 20 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 0bcb44cf7b31..b75f0b36a09b 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1312,6 +1312,9 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 		    btrtl_dev->project_id == CHIP_ID_8852C)
 			set_bit(HCI_QUIRK_USE_MSFT_EXT_ADDRESS_FILTER, &hdev->quirks);
 
+		if (btrtl_dev->project_id == CHIP_ID_8852BT)
+			btrealtek_set_flag(hdev, REALTEK_ALT6_FORCE);
+
 		hci_set_aosp_capable(hdev);
 		break;
 	default:
diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
index a2d9d34f9fb0..ffec2fca88ec 100644
--- a/drivers/bluetooth/btrtl.h
+++ b/drivers/bluetooth/btrtl.h
@@ -105,6 +105,7 @@ struct rtl_vendor_cmd {
 
 enum {
 	REALTEK_ALT6_CONTINUOUS_TX_CHIP,
+	REALTEK_ALT6_FORCE,
 
 	__REALTEK_NUM_FLAGS,
 };
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 514d593923ad..eca0b173232e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -804,6 +804,7 @@ struct qca_dump_info {
 #define BTUSB_USE_ALT3_FOR_WBS	15
 #define BTUSB_ALT6_CONTINUOUS_TX	16
 #define BTUSB_HW_SSR_ACTIVE	17
+#define BTUSB_ALT_CHANGED	18
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -2130,16 +2131,61 @@ static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
 	}
 }
 
+static struct usb_host_interface *btusb_find_altsetting(struct btusb_data *data,
+							int alt)
+{
+	struct usb_interface *intf = data->isoc;
+	int i;
+
+	BT_DBG("Looking for Alt no :%d", alt);
+
+	if (!intf)
+		return NULL;
+
+	for (i = 0; i < intf->num_altsetting; i++) {
+		if (intf->altsetting[i].desc.bAlternateSetting == alt)
+			return &intf->altsetting[i];
+	}
+
+	return NULL;
+}
+
 static inline int __set_isoc_interface(struct hci_dev *hdev, int altsetting)
 {
 	struct btusb_data *data = hci_get_drvdata(hdev);
 	struct usb_interface *intf = data->isoc;
 	struct usb_endpoint_descriptor *ep_desc;
+	struct usb_host_interface *alt;
 	int i, err;
 
 	if (!data->isoc)
 		return -ENODEV;
 
+	/* For some Realtek chips, they actually have the altsetting 6, but its
+	 * altsetting descriptor is not exposed. We can activate altsetting 6 by
+	 * replacing the altsetting 5.
+	 */
+	if (altsetting == 6 && !btusb_find_altsetting(data, 6) &&
+	    btrealtek_test_flag(hdev, REALTEK_ALT6_FORCE)) {
+		alt = NULL;
+		for (i = 0; i < intf->num_altsetting; i++) {
+			if (intf->altsetting[i].desc.bAlternateSetting == 5) {
+				alt = &intf->altsetting[i];
+				break;
+			}
+		}
+		if (alt) {
+			for (i = 0; i < alt->desc.bNumEndpoints; i++) {
+				ep_desc = &alt->endpoint[i].desc;
+				if (usb_endpoint_is_isoc_out(ep_desc) ||
+				    usb_endpoint_is_isoc_in(ep_desc))
+					ep_desc->wMaxPacketSize = 63;
+			}
+			alt->desc.bAlternateSetting = 6;
+			set_bit(BTUSB_ALT_CHANGED, &data->flags);
+		}
+	}
+
 	err = usb_set_interface(data->udev, data->isoc_ifnum, altsetting);
 	if (err < 0) {
 		bt_dev_err(hdev, "setting interface failed (%d)", -err);
@@ -2151,6 +2197,27 @@ static inline int __set_isoc_interface(struct hci_dev *hdev, int altsetting)
 	data->isoc_tx_ep = NULL;
 	data->isoc_rx_ep = NULL;
 
+	/* Recover alt 5 desc if alt 0 is set. */
+	if (!altsetting && test_bit(BTUSB_ALT_CHANGED, &data->flags)) {
+		alt = NULL;
+		for (i = 0; i < intf->num_altsetting; i++) {
+			if (intf->altsetting[i].desc.bAlternateSetting == 6) {
+				alt = &intf->altsetting[i];
+				break;
+			}
+		}
+		if (alt) {
+			for (i = 0; i < alt->desc.bNumEndpoints; i++) {
+				ep_desc = &alt->endpoint[i].desc;
+				if (usb_endpoint_is_isoc_out(ep_desc) ||
+				    usb_endpoint_is_isoc_in(ep_desc))
+					ep_desc->wMaxPacketSize = 49;
+			}
+			alt->desc.bAlternateSetting = 5;
+			clear_bit(BTUSB_ALT_CHANGED, &data->flags);
+		}
+	}
+
 	for (i = 0; i < intf->cur_altsetting->desc.bNumEndpoints; i++) {
 		ep_desc = &intf->cur_altsetting->endpoint[i].desc;
 
@@ -2213,25 +2280,6 @@ static int btusb_switch_alt_setting(struct hci_dev *hdev, int new_alts)
 	return 0;
 }
 
-static struct usb_host_interface *btusb_find_altsetting(struct btusb_data *data,
-							int alt)
-{
-	struct usb_interface *intf = data->isoc;
-	int i;
-
-	BT_DBG("Looking for Alt no :%d", alt);
-
-	if (!intf)
-		return NULL;
-
-	for (i = 0; i < intf->num_altsetting; i++) {
-		if (intf->altsetting[i].desc.bAlternateSetting == alt)
-			return &intf->altsetting[i];
-	}
-
-	return NULL;
-}
-
 static void btusb_work(struct work_struct *work)
 {
 	struct btusb_data *data = container_of(work, struct btusb_data, work);
@@ -2269,7 +2317,8 @@ static void btusb_work(struct work_struct *work)
 			 * MTU >= 3 (packets) * 25 (size) - 3 (headers) = 72
 			 * see also Core spec 5, vol 4, B 2.1.1 & Table 2.1.
 			 */
-			if (btusb_find_altsetting(data, 6))
+			if (btusb_find_altsetting(data, 6) ||
+			    btrealtek_test_flag(hdev, REALTEK_ALT6_FORCE))
 				new_alts = 6;
 			else if (btusb_find_altsetting(data, 3) &&
 				 hdev->sco_mtu >= 72 &&
-- 
2.34.1

