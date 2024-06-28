Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C6514F9F2;
	Fri, 28 Jun 2024 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719569810; cv=none; b=Ff1A+MKxeuWP/998JADTJXr9ZOZZknKZT5/i8Za5XdgSmdLeqbm2hM7p6UP5zLdndlDPGG5zW9oZxnN5xvBCdQvDR0UdokikcvaW65uRO6Y0KjaAIzvy3FwkUlyUY4i+znXkxuwGPzI/u9we9TvbC6gff6cV8WMa+vrUmPvNnKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719569810; c=relaxed/simple;
	bh=fZmvLXODQ03ph2wsHjKVKoGqymX7wXYTEx+36WyJzM4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q2VAPE9Vx7SBL7kLS0KaJ8YZHObO2SMHvXc+gKF4I0032LLKk0XruM5JAFv2yARHYz8Fxm79ajGz8ua7KxpQP3zOUfeBRIy+2yrgYUrO2lAyNpQn1JRjnLoI/4a2uSobq8xaon7Nz/1s36tFm2fiYpMHra1UqMBSZ5No9AqGXvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45SAGRH60248605, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 45SAGRH60248605
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jun 2024 18:16:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 28 Jun 2024 18:16:28 +0800
Received: from localhost.localhost (172.21.132.53) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 28 Jun
 2024 18:16:27 +0800
From: Hilda Wu <hildawu@realtek.com>
To: <marcel@holtmann.org>
CC: <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alex_lu@realsil.com.cn>,
        <max.chou@realtek.com>, <kidman@realtek.com>, <apusaka@chromium.org>,
        <yinghsu@chromium.org>, <johnlai@google.com>
Subject: [PATCH] Bluetooth: btrtl: fix duplicate SCO packet
Date: Fri, 28 Jun 2024 18:16:24 +0800
Message-ID: <20240628101624.3470355-1-hildawu@realtek.com>
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

In some platform found unknown connection handle case when HFP. The
unknown connection handle may affect SCO audio sound quality.
After investigation, it was found the value of the unknown connection
handle is actually a duplicated data.

The duplicate data affected the unknown connection handle in some
Realtek chip. This issue only occurs in (e)SCO, does not affect ACLs.

This commit is to filter out the duplicate packet for avoiding influence
SCO audio.

Below btmon trace gives a better idea of what we're filtering.
The following excerpts are part of SCO packets in the HCI log:

> SCO Data RX: Handle 11 flags 0x00 dlen 72      #23327 [hci0] 132.343418
        8c a3 55 4f 8a d5 56 e9 35 56 37 8d 55 87 53 55  ..UO..V.5V7.U.SU
        59 66 d5 57 1d b5 54 00 01 08 ad 00 00 e0 10 00  Yf.W..T.........
        00 00 85 c6 d5 60 e9 b5 52 94 6d 54 e4 9b 55 b1  .....`..R.mT..U.
        b6 d5 62 91 b5 57 84 6d 56 e4 5b 55 75 c6 d5 51  ..b..W.mV.[Uu..Q
        2d b5 53 9a 6d 54 a5 1b                          -.S.mT..
< SCO Data TX: Handle 11 flags 0x00 dlen 72      #23328 [hci0] 132.343600
        01 c8 ad 00 00 aa db ba aa a9 72 b4 d9 5d af 14  ..........r..]..
        53 0c 75 b0 a6 f3 8a 51 b3 54 17 b1 a6 d5 62 c5  S.u....Q.T....b.
        d5 6b 35 29 8d c5 1c 56 4c 24 96 9b 8d b5 d7 1a  .k5)...VL$......
        b2 8d bc da 3b 8c 46 ae 1d 4d a4 04 01 f8 ad 00  ....;.F..M......
        00 3d ec bb a9 98 8b 28                          .=.....(
> SCO Data RX: Handle 11 flags 0x00 dlen 72      #23329 [hci0] 132.353419
        55 55 c6 d5 62 29 b5 57 b2 6d 54 00 01 38 ad 00  UU..b).W.mT..8..
        00 e0 10 00 00 00 0b 00 d5 62 55 c6 57 b2 29 b5  .........bU.W.).
        00 01 6d 54 00 00 38 ad 00 00 e0 10 00 00 00 92  ..mT..8.........
        36 d5 5a ed b5 58 6c 6d 55 b3 1b 55 6b 26 d5 52  6.Z..XlmU..Uk&.R
        d1 b5 54 23 6d 56 82 db                          ..T#mV..
< SCO Data TX: Handle 11 flags 0x00 dlen 72      #23330 [hci0] 132.353581
        6d 5b be db 89 34 66 e9 fa 99 a6 6e e5 6d 9f 1a  m[...4f....n.m..
        1c 57 d2 66 92 63 98 99 a9 3b 8a 6c 3e 5b 5a 34  .W.f.c...;.l>[Z4
        a4 96 e2 21 21 8c f8 88 0f 3d e0 52 48 85 18 00  ...!!....=.RH...
        01 08 ad 00 00 0c eb ba a9 a8 28 ca 9a d0 3c 33  ..........(...<3
        45 4a f9 90 fb ca 4b 39                          EJ....K9
> SCO Data RX: Handle 2901 flags 0x0a dlen 54    #23331 [hci0] 132.373416
        d5 48 a9 b5 56 aa 6d 56 d2 db 55 75 36 d5 56 2d  .H..V.mV..Uu6.V-
        b5 57 5b 6d 54 00 0b 00 48 01 c8 ad 00 00 e0 10  .W[mT...H.......
        00 00 00 5e c6 d5 56 e1 b5 56 43 6d 55 ca db 55  ...^..V..VCmU..U
        7d c6 d5 5b 31 b5

This is HCI SCO data RX packets.
The packet 23327 was a normal HCI SCO data RX packet.
The packet 23329 was the abnormal HCI SCO data RX packet.
The packet 23331 was the invalid connection handle case but the packet is
affected by the packet 23329 abnormal HCI SCO Data RX packet.

So this patch expects to filter the packet 23329 SCO data RX packet
case. The packet 23329's connection handle (0x0B 00/11) and length
(0x48/72) is normal.
This btmon trace is SCO packets in USB alternate setting 3, payload
length is 72 bytes that consist of three SCO data packets.
The anomaly is due to the intermediate composed data.The duplicate
data in the intermediate composition data, but it affects packet
combination. Cause the system parses the next packet of the connection
handle mistake that shows unknown connection handle messages.

This commit can estimate and find out its abnormal rule to filter the
duplicate packet out for avoiding influence.
Check fragments and filter out the abnormal packet, and then it will
not affect the system parsing of the connection handle subsequent.

Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
Signed-off-by: Hilda Wu <hildawu@realtek.com>
---
 drivers/bluetooth/btrtl.c | 49 +++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btrtl.h |  7 ++++++
 drivers/bluetooth/btusb.c |  8 +++++++
 3 files changed, 64 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index f2f37143c454..f286654a8fae 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1300,6 +1300,11 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 		    btrtl_dev->project_id == CHIP_ID_8852C)
 			set_bit(HCI_QUIRK_USE_MSFT_EXT_ADDRESS_FILTER, &hdev->quirks);
 
+		if (btrtl_dev->project_id == CHIP_ID_8822C ||
+		    btrtl_dev->project_id == CHIP_ID_8852A ||
+		    btrtl_dev->project_id == CHIP_ID_8852B)
+			btrealtek_set_flag(hdev, REALTEK_SCO_CLEAN_DUPLICATE_DATA);
+
 		hci_set_aosp_capable(hdev);
 		break;
 	default:
@@ -1479,6 +1484,50 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
 }
 EXPORT_SYMBOL_GPL(btrtl_get_uart_settings);
 
+int btrtl_validate_isoc_data(u16 mps, struct sk_buff *skb)
+{
+	u8 *prev;
+	u8 tmp[8];
+	u32 *a;
+	u32 *b;
+	u16 i;
+	u8 *next;
+	u8 *start = skb->data;
+
+	for (i = 0; i < 2; i++) {
+		prev = start + i * mps;
+		next = prev + mps;
+
+		if (!memcmp(prev + 4, next + 2, 8))
+			continue;
+
+		/* Check the current fragment with the previous one.
+		 * If the current fragment is redundant but it is a little bit
+		 * different from the previous, drop it.
+		 * For example,
+		 * 04 00 48 55 4E CB 55 52 80 95 55 07 XX XX ...
+		 * 04 00 55 52 4E CB 55 07 80 95 XX XX XX XX ...
+		 */
+		memcpy(tmp, prev + 4, 8);
+		a = (u32 *)(tmp);
+		b = (u32 *)(tmp + 4);
+		*a = swahw32(*a);
+		*b = swahw32(*b);
+
+		if (next[0] == prev[0] && next[1] == prev[1] &&
+		    !memcmp(next + 2, tmp, 8)) {
+			if (i == 0)
+				memcpy(start + mps, start + 2 * mps, mps);
+			skb_trim(skb, 2 * mps);
+			hci_skb_expect(skb) = mps;
+			return -EILSEQ;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btrtl_validate_isoc_data);
+
 MODULE_AUTHOR("Daniel Drake <drake@endlessm.com>");
 MODULE_DESCRIPTION("Bluetooth support for Realtek devices ver " VERSION);
 MODULE_VERSION(VERSION);
diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
index a2d9d34f9fb0..3ddb691dff94 100644
--- a/drivers/bluetooth/btrtl.h
+++ b/drivers/bluetooth/btrtl.h
@@ -105,6 +105,7 @@ struct rtl_vendor_cmd {
 
 enum {
 	REALTEK_ALT6_CONTINUOUS_TX_CHIP,
+	REALTEK_SCO_CLEAN_DUPLICATE_DATA,
 
 	__REALTEK_NUM_FLAGS,
 };
@@ -148,6 +149,7 @@ int btrtl_get_uart_settings(struct hci_dev *hdev,
 			    unsigned int *controller_baudrate,
 			    u32 *device_baudrate, bool *flow_control);
 void btrtl_set_driver_name(struct hci_dev *hdev, const char *driver_name);
+int btrtl_validate_isoc_data(u16 mps, struct sk_buff *skb);
 
 #else
 
@@ -195,4 +197,9 @@ static inline void btrtl_set_driver_name(struct hci_dev *hdev, const char *drive
 {
 }
 
+static inline int btrtl_validate_isoc_data(u16 mps, struct sk_buff *skb)
+{
+	return -EILSEQ;
+}
+
 #endif
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2d7d47f9d007..2b66211eb02c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1317,6 +1317,14 @@ static int btusb_recv_isoc(struct btusb_data *data, void *buffer, int count)
 		}
 
 		if (!hci_skb_expect(skb)) {
+			if (btrealtek_test_flag(data->hdev, REALTEK_SCO_CLEAN_DUPLICATE_DATA) &&
+			    data->air_mode == HCI_NOTIFY_ENABLE_SCO_TRANSP &&
+			    test_bit(BTUSB_USE_ALT3_FOR_WBS, &data->flags) &&
+			    data->isoc_altsetting == 3 &&
+			    skb->len == 3 * data->isoc_rx_ep->wMaxPacketSize &&
+			    btrtl_validate_isoc_data(data->isoc_rx_ep->wMaxPacketSize, skb))
+				continue;
+
 			/* Complete frame */
 			hci_recv_frame(data->hdev, skb);
 			skb = NULL;
-- 
2.34.1

