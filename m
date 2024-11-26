Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610831898FC;
	Tue, 26 Nov 2024 07:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732604762; cv=none; b=u+7aKZHIukxesp3uJcKwGINLgYVNXzj9MPUujzWZVT6cK7mXdA7ynG0Sf1NbaokbwEF0AR9CjKcC4H9gU8scE14attpDZjYhERWIyFJR7berwg0hE6caAKgL6IhRrGsovyEagKvrzKf9tA4PbJS8RQWRQl9B3oXlg/z2bzwz/ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732604762; c=relaxed/simple;
	bh=0tDDt6mdzrI9HIgeA9rdneXlh3XSrKVoiUse3OjmLes=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cOktvIZSBmvp7C66ISie6XUd4uK792jWPEymkMCwqyXdJwI3+FSWRBpcm5l0XQZcH6oynMZhZVsAUcTPtYmHvKdbshft2O9RTGe5V+jlnxm7ILmO6lS55MI99HVwXGnjN07G0FReqmfeILtzYLQkn69PfOBKt2jFzusQNumrOgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ET/2CrRv; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ET/2CrRv"
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AQ75oMeA648380, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732604750; bh=0tDDt6mdzrI9HIgeA9rdneXlh3XSrKVoiUse3OjmLes=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=ET/2CrRvQST7rpYPR8lk7G99e8ebEjqYjyF8FNde8BMYldpp8y6zQzYy41YauWX+N
	 vvL16PJOziAtMX3FBED8ZM3JgEOiTibUfKA8zYrxtEt9PBen7KWQ9kOo2JjhVsJNJU
	 uLEN0PK92By/bbcvrsd9JW40whofTy3rh6XDS0uYXafrSN6HP056kMnEnI6qqLCp8l
	 iTRa6UcWbaiwe5S6YJbB/FTSVX1zIdFcMzOfEeSFk6AC3Ygqjm5JdarvQ5jJbilYr6
	 nUOKC7Yj4kaLDcw5JKafNM3RkHFc73mzrjwdLVKxJ1Xa+rsBRSqX9bM+noXZJDHIaW
	 h9tSlvGVVCZ0A==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AQ75oMeA648380
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 15:05:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 26 Nov 2024 15:05:50 +0800
Received: from localhost.localhost (172.21.132.53) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 26 Nov
 2024 15:05:48 +0800
From: Hilda Wu <hildawu@realtek.com>
To: <marcel@holtmann.org>
CC: <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <max.chou@realtek.com>,
        <alex_lu@realsil.com.cn>, <kidman@realtek.com>
Subject: [PATCH v3] Bluetooth: add quirk using packet size 60
Date: Tue, 26 Nov 2024 15:05:42 +0800
Message-ID: <20241126070542.3828431-1-hildawu@realtek.com>
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

The btmon log below shows the case that WBS with the USB alternate
setting 6.

< HCI Command: Enhanced.. (0x01|0x003d) plen 59  #2123 [hci0] 82.701813
        Handle: 1 Address: 78:A7:EB:4C:53:4D (1MORE)
        Transmit bandwidth: 8000
        Receive bandwidth: 8000
        Max latency: 13
        Packet type: 0x0380
          3-EV3 may not be used
          2-EV5 may not be used
          3-EV5 may not be used
        Retransmission effort: Optimize for link quality (0x02)
< ACL Data TX: Handle 1 flags 0x00 dlen 22       #2124 [hci0] 82.701825
      Channel: 65 len 18 [PSM 3 mode Basic (0x00)] {chan 1}
      RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
         Address: 0x0b cr 1 dlci 0x02
         Control: 0xef poll/final 0
         Length: 14
         FCS: 0x9a
        0d 0a 2b 43 49 45 56 3a 20 32 2c 31 0d 0a 9a     ..+CIEV: 2,1..>
> HCI Event: Command Status (0x0f) plen 4        #2125 [hci0] 82.703812
      Enhanced Setup Synchronous Connection (0x01|0x003d) ncmd 2
        Status: Success (0x00)
> HCI Event: Number of Complete.. (0x13) plen 5  #2126 [hci0] 82.710834
        Num handles: 1
        Handle: 1 Address: 78:A7:EB:4C:53:4D (1MORE)
        Count: 1
        #2124: len 22 (19 Kb/s)
        Latency: 9 msec (3-56 msec ~13 msec)
        Channel: 65 [PSM 3 mode Basic (0x00)] {chan 1}
        Channel Latency: 9 msec (4-27 msec ~15 msec)
> HCI Event: Synchronous Conne.. (0x2c) plen 17  #2127 [hci0] 82.741840
        Status: Success (0x00)
        Handle: 2
        Address: 78:A7:EB:4C:53:4D (1MORE)
        Link type: eSCO (0x02)
        Transmission interval: 0x0c
        Retransmission window: 0x04
        RX packet length: 60
        TX packet length: 60
        Air mode: Transparent (0x03)
@ RAW Open: btmon (privileged) version 2.22          {0x0002} 82.742580
@ RAW Close: btmon                                   {0x0002} 82.742594
> SCO Data RX: Handle 2 flags 0x00 dlen 60       #2128 [hci0] 82.764812
< ACL Data TX: Handle 1 flags 0x00 dlen 19       #2129 [hci0] 82.764994
      Channel: 65 len 15 [PSM 3 mode Basic (0x00)] {chan 1}
      RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
         Address: 0x0b cr 1 dlci 0x02
         Control: 0xef poll/final 0
         Length: 11
         FCS: 0x9a
        0d 0a 2b 56 47 53 3a 20 36 0d 0a 9a              ..+VGS: 6...  >
> HCI Event: Max Slots Change (0x1b) plen 3      #2130 [hci0] 82.765814
        Handle: 1 Address: 78:A7:EB:4C:53:4D (1MORE)
        Max slots: 1
< SCO Data TX: Handle 2 flags 0x00 dlen 60       #2131 [hci0] 82.765897
> HCI Event: Number of Complete.. (0x13) plen 5  #2132 [hci0] 82.771855
        Num handles: 1
        Handle: 1 Address: 78:A7:EB:4C:53:4D (1MORE)
        Count: 1
        #2129: len 19 (25 Kb/s)
        Latency: 6 msec (3-56 msec ~10 msec)
        Channel: 65 [PSM 3 mode Basic (0x00)] {chan 1}
        Channel Latency: 6 msec (4-27 msec ~11 msec)
< SCO Data TX: Handle 2 flags 0x00 dlen 60       #2133 [hci0] 82.773344
> SCO Data RX: Handle 2 flags 0x00 dlen 60       #2134 [hci0] 82.774836
> SCO Data RX: Handle 2 flags 0x00 dlen 60       #2135 [hci0] 82.774839
> SCO Data RX: Handle 2 flags 0x00 dlen 60       #2136 [hci0] 82.784840
< SCO Data TX: Handle 2 flags 0x00 dlen 60       #2137 [hci0] 82.787175
< SCO Data TX: Handle 2 flags 0x00 dlen 60       #2138 [hci0] 82.788282
> SCO Data RX: Handle 2 flags 0x00 dlen 60       #2139 [hci0] 82.794812
< SCO Data TX: Handle 2 flags 0x00 dlen 60       #2140 [hci0] 82.795797
> SCO Data RX: Handle 2 flags 0x00 dlen 60       #2141 [hci0] 82.804838
> SCO Data RX: Handle 2 flags 0x00 dlen 60       #2142 [hci0] 82.804840
< SCO Data TX: Handle 2 flags 0x00 dlen 60       #2143 [hci0] 82.808554

Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
Signed-off-by: Hilda Wu <hildawu@realtek.com>

---
Change:
V3: Fixed SubjectPrefix, use quirk instead of btrealtek_*_flag()
v2: Use btusb_find_altsetting replace duplicating logic, add tested log.
---
---
 drivers/bluetooth/btrtl.c |  3 ++
 drivers/bluetooth/btrtl.h |  1 +
 drivers/bluetooth/btusb.c | 86 ++++++++++++++++++++++++++++++---------
 3 files changed, 70 insertions(+), 20 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 83025f457ca0..7efd733f9e84 100644
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
index 279fe6c115fa..6acdff772ca5 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -814,6 +814,8 @@ struct qca_dump_info {
 #define BTUSB_USE_ALT3_FOR_WBS	15
 #define BTUSB_ALT6_CONTINUOUS_TX	16
 #define BTUSB_HW_SSR_ACTIVE	17
+#define BTUSB_ALT6_QUIRK	18
+#define BTUSB_ISOC_ALT_CHANGED	19
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -866,6 +868,7 @@ struct btusb_data {
 	unsigned int air_mode;
 	bool usb_alt6_packet_flow;
 	int isoc_altsetting;
+	u16 isoc_mps;
 	int suspend_count;
 
 	int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
@@ -2140,16 +2143,58 @@ static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
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
+	    test_bit(BTUSB_ALT6_QUIRK, &data->flags)) {
+		alt = btusb_find_altsetting(data, 5);
+		if (alt) {
+			data->isoc_mps = 49;
+			for (i = 0; i < alt->desc.bNumEndpoints; i++) {
+				ep_desc = &alt->endpoint[i].desc;
+				if (!usb_endpoint_xfer_isoc(ep_desc))
+					continue;
+				data->isoc_mps =
+					le16_to_cpu(ep_desc->wMaxPacketSize);
+				ep_desc->wMaxPacketSize = cpu_to_le16(63);
+			}
+			alt->desc.bAlternateSetting = 6;
+			set_bit(BTUSB_ISOC_ALT_CHANGED, &data->flags);
+		}
+	}
+
 	err = usb_set_interface(data->udev, data->isoc_ifnum, altsetting);
 	if (err < 0) {
 		bt_dev_err(hdev, "setting interface failed (%d)", -err);
@@ -2161,6 +2206,22 @@ static inline int __set_isoc_interface(struct hci_dev *hdev, int altsetting)
 	data->isoc_tx_ep = NULL;
 	data->isoc_rx_ep = NULL;
 
+	/* Recover alt 5 desc if alt 0 is set. */
+	if (!altsetting && test_bit(BTUSB_ISOC_ALT_CHANGED, &data->flags)) {
+		alt = btusb_find_altsetting(data, 6);
+		if (alt) {
+			for (i = 0; i < alt->desc.bNumEndpoints; i++) {
+				ep_desc = &alt->endpoint[i].desc;
+				if (!usb_endpoint_xfer_isoc(ep_desc))
+					continue;
+				ep_desc->wMaxPacketSize =
+					cpu_to_le16(data->isoc_mps);
+			}
+			alt->desc.bAlternateSetting = 5;
+			clear_bit(BTUSB_ISOC_ALT_CHANGED, &data->flags);
+		}
+	}
+
 	for (i = 0; i < intf->cur_altsetting->desc.bNumEndpoints; i++) {
 		ep_desc = &intf->cur_altsetting->endpoint[i].desc;
 
@@ -2223,25 +2284,6 @@ static int btusb_switch_alt_setting(struct hci_dev *hdev, int new_alts)
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
@@ -2279,7 +2321,8 @@ static void btusb_work(struct work_struct *work)
 			 * MTU >= 3 (packets) * 25 (size) - 3 (headers) = 72
 			 * see also Core spec 5, vol 4, B 2.1.1 & Table 2.1.
 			 */
-			if (btusb_find_altsetting(data, 6))
+			if (btusb_find_altsetting(data, 6) ||
+			    test_bit(BTUSB_ALT6_QUIRK, &data->flags))
 				new_alts = 6;
 			else if (btusb_find_altsetting(data, 3) &&
 				 hdev->sco_mtu >= 72 &&
@@ -2611,6 +2654,9 @@ static int btusb_setup_realtek(struct hci_dev *hdev)
 	if (btrealtek_test_flag(data->hdev, REALTEK_ALT6_CONTINUOUS_TX_CHIP))
 		set_bit(BTUSB_ALT6_CONTINUOUS_TX, &data->flags);
 
+	if (btrealtek_test_flag(data->hdev, REALTEK_ALT6_FORCE))
+		set_bit(BTUSB_ALT6_QUIRK, &data->flags);
+
 	return ret;
 }
 
-- 
2.34.1

