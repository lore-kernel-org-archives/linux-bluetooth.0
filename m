Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145D81547E8;
	Mon, 18 Nov 2024 08:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731920294; cv=none; b=pTxGeZdzbSLNBGjHgBzNAnxGVgRYihUvEEbX3/uNZCaVxWB//uSpijQuAg9rMop/PTauF9MLufR3BMfPz+UdVwAK50nqDPpG9P8nxB2Q2pkMu08YDRTjlytY3pUvYzeyQErqzj1Cyfng2gz+LHFNIe4bFQadY43hdUOD/T3QR6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731920294; c=relaxed/simple;
	bh=fVGcv5NHUTodxydSx4548Ah1LtAP0wAXvss061Rv5ks=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q6P3HxBMw3ICB1pFyEblCphkFvvVZGVIwKau6at4PRy/TAXjTDTaGT5wfMbge+VZA17qzNNxomHxJ7v8fsJkGy07SCMYDgk2gJrsjeppyWIuCrZ2g63vjf+Lh10Om6cU5l6+bhWdiIsvN8POdf6g1Lj7dpjaE6YCHGqykWvwnt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=HcNJDjga; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="HcNJDjga"
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AI8w1Yu9426099, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731920281; bh=fVGcv5NHUTodxydSx4548Ah1LtAP0wAXvss061Rv5ks=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=HcNJDjgaFbBY67fmr2232wAzTK00sH/4TkYMfwEdwMSgrut40xoZxCoSmGTlCL5KE
	 xSWAwTC19gdlN5eQwjaa+JFmjkyQxM/tRdmT31zQjOY5JuxWmYt7+/7CqtMxu49Zu1
	 d/rwT5p/rOOmOuuykhh44lWg/RhRIKjXsBQRt4QQijNhjtnmR5q1MCDQLwWlB28mfd
	 8GSgxVkx5bVTFAAJQpCh7wibRYQVrYJj4uxtI8TC06RZGJFC9vwt5EhSpGxInLJ27H
	 7l7ez+bdBPO5j30TMz+3I6w2AnqGsTS2iFMN6PRSNv5Lbd5ftBcYFHZOXOmthXU7Bk
	 l78LsFmvX0PJA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AI8w1Yu9426099
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 16:58:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 18 Nov 2024 16:58:02 +0800
Received: from localhost.localhost (172.21.132.53) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 18 Nov
 2024 16:58:01 +0800
From: Hilda Wu <hildawu@realtek.com>
To: <marcel@holtmann.org>
CC: <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <max.chou@realtek.com>,
        <alex_lu@realsil.com.cn>, <kidman@realtek.com>
Subject: [PATCH v2] bluetooth: add quirk using packet size 60
Date: Mon, 18 Nov 2024 16:57:57 +0800
Message-ID: <20241118085757.3678244-1-hildawu@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

The RTL8852BE-VT supports USB alternate setting 6.
However, its descriptor does not report this capability to the host.
Therefore, a quirk is needed to bypass the RTL8852BE-VT's descriptor
and allow it to use USB ALT 6 directly.

The btmon log below shows the case that WBS with the USB alternate
setting 6.

> ACL Data RX: Handle 2 flags 0x02 dlen 18       #5338 [hci0] 91.977373
      Channel: 70 len 14 [PSM 3 mode Basic (0x00)] {chan 3}
      RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
         Address: 0x09 cr 0 dlci 0x02
         Control: 0xff poll/final 1
         Length: 9
         FCS: 0x5c
         Credits: 4
        41 54 2b 42 43 53 3d 32 0d 5c                    AT+BCS=2.\    >
< ACL Data TX: Handle 2 flags 0x00 dlen 15       #5339 [hci0] 91.978294
      Channel: 64 len 11 [PSM 3 mode Basic (0x00)] {chan 3}
      RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
         Address: 0x0b cr 1 dlci 0x02
         Control: 0xff poll/final 1
         Length: 6
         FCS: 0x86
         Credits: 1
        0d 0a 4f 4b 0d 0a 86                             ..OK...       >
< HCI Command: Enhanced.. (0x01|0x003d) plen 59  #5340 [hci0] 91.978326
        Handle: 2
        Transmit bandwidth: 8000
        Receive bandwidth: 8000
        Max latency: 13
        Packet type: 0x0380
          3-EV3 may not be used
          2-EV5 may not be used
          3-EV5 may not be used
        Retransmission effort: Optimize for link quality (0x02)
> HCI Event: Command Status (0x0f) plen 4        #5341 [hci0] 91.981723
      Enhanced Setup Synchronous Connection (0x01|0x003d) ncmd 2
        Status: Success (0x00)
> HCI Event: Number of Complete.. (0x13) plen 5  #5342 [hci0] 91.982705
        Num handles: 1
        Handle: 2
        Count: 1
> HCI Event: Synchronous Conne.. (0x2c) plen 17  #5343 [hci0] 92.015758
        Status: Success (0x00)
        Handle: 3
        Address: 78:A7:EB:4C:53:4D (OUI 78-A7-EB)
        Link type: eSCO (0x02)
        Transmission interval: 0x0c
        Retransmission window: 0x04
        RX packet length: 60
        TX packet length: 60
        Air mode: Transparent (0x03)
@ MGMT Open: bt_main_th.. (privileged) version 1.22  {0x0003} 92.016366
@ MGMT Command: Unknown (0x0101) plen 11             {0x0003} 92.016374
        00 00 78 a7 eb 4c 53 4d 00 01 02                 ..x..LSM...   >
@ MGMT Close: bt_main_thread                         {0x0003} 92.016409
< ACL Data TX: Handle 2 flags 0x00 dlen 22       #5344 [hci0] 92.017651
      Channel: 64 len 18 [PSM 3 mode Basic (0x00)] {chan 3}
      RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
         Address: 0x0b cr 1 dlci 0x02
         Control: 0xef poll/final 0
         Length: 14
         FCS: 0x9a
        0d 0a 2b 43 49 45 56 3a 20 32 2c 32 0d 0a 9a     ..+CIEV: 2,2..>
...
> SCO Data RX: Handle 3 flags 0x00 dlen 60       #5349 [hci0] 92.037778
< SCO Data TX: Handle 3 flags 0x00 dlen 60       #5350 [hci0] 92.038218
> HCI Event: Max Slots Change (0x1b) plen 3      #5351 [hci0] 92.040758
        Handle: 2
        Max slots: 1
> HCI Event: Number of Complete.. (0x13) plen 5  #5352 [hci0] 92.041760
        Num handles: 1
        Handle: 2
        Count: 1
> HCI Event: Number of Complete.. (0x13) plen 5  #5353 [hci0] 92.044784
        Num handles: 1
        Handle: 2
        Count: 1
> SCO Data RX: Handle 3 flags 0x00 dlen 60       #5354 [hci0] 92.047706
< SCO Data TX: Handle 3 flags 0x00 dlen 60       #5355 [hci0] 92.048226
> SCO Data RX: Handle 3 flags 0x00 dlen 60       #5356 [hci0] 92.057706
< SCO Data TX: Handle 3 flags 0x00 dlen 60       #5357 [hci0] 92.058179
...
> SCO Data RX: Handle 3 flags 0x00 dlen 60       #5362 [hci0] 92.067775
> SCO Data RX: Handle 3 flags 0x00 dlen 60       #5363 [hci0] 92.067780
< SCO Data TX: Handle 3 flags 0x00 dlen 60       #5364 [hci0] 92.068288
< SCO Data TX: Handle 3 flags 0x00 dlen 60       #5365 [hci0] 92.068322
> SCO Data RX: Handle 3 flags 0x00 dlen 60       #5366 [hci0] 92.077733
< SCO Data TX: Handle 3 flags 0x00 dlen 60       #5367 [hci0] 92.078263

Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
Signed-off-by: Hilda Wu <hildawu@realtek.com>

---
Change:
v2: Use btusb_find_altsetting replace duplicating logic, add tested log.
---
---
 drivers/bluetooth/btrtl.c |  3 ++
 drivers/bluetooth/btrtl.h |  1 +
 drivers/bluetooth/btusb.c | 82 +++++++++++++++++++++++++++++----------
 3 files changed, 66 insertions(+), 20 deletions(-)

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
index 279fe6c115fa..0a2107baf18a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -814,6 +814,7 @@ struct qca_dump_info {
 #define BTUSB_USE_ALT3_FOR_WBS	15
 #define BTUSB_ALT6_CONTINUOUS_TX	16
 #define BTUSB_HW_SSR_ACTIVE	17
+#define BTUSB_ISOC_ALT_CHANGED	18
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -866,6 +867,7 @@ struct btusb_data {
 	unsigned int air_mode;
 	bool usb_alt6_packet_flow;
 	int isoc_altsetting;
+	u16 isoc_mps;
 	int suspend_count;
 
 	int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
@@ -2140,16 +2142,58 @@ static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
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
@@ -2161,6 +2205,22 @@ static inline int __set_isoc_interface(struct hci_dev *hdev, int altsetting)
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
 
@@ -2223,25 +2283,6 @@ static int btusb_switch_alt_setting(struct hci_dev *hdev, int new_alts)
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
@@ -2279,7 +2320,8 @@ static void btusb_work(struct work_struct *work)
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

