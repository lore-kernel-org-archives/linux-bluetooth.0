Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108B94411;
	Tue,  9 Jul 2024 02:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720490635; cv=none; b=F7J44IW8e9ds5kw7VLp9rk5hn1vXzva7QBV0SuCsI+5ATwPdGVrStLkS5TbCXu2vT1J3a40L/ma0T6NnKM0ja+15fgKElnlM0jxGJI6NTfzNpGb4cEOq4XZXLH0S2I8/uXUI69U2vhqDV9gddDTdtl7Lc04RKA+rIxGKNKts6M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720490635; c=relaxed/simple;
	bh=iUsJj+fHgoiQLZfTxvDfTJxFzJsbU1TAp9uLOmszgvk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kZTvCRmCEX1zN95vj9Rv1r0dY6mEjUg9mKapvkcLk/t1nnrlzdeXKW7pxRC6I1DjEk5kP00N64dSiy7jYtBf2qzHbLbfZuuQgAgCOuY7GVssflVtbMo5myEFTKDN4ozscPr4JSqihzxt8OUqqMBavGF7bH5+fGThqSAiuc3jxYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=LiPZlchU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="LiPZlchU"
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46923Vx44160571, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1720490611; bh=iUsJj+fHgoiQLZfTxvDfTJxFzJsbU1TAp9uLOmszgvk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=LiPZlchU8Sy+bdRsnVDbSkAPt6t/uEkGoP1nXV2oBmwiL+PXEf02ykaq9uRSXaYVW
	 XvRsu58I82JAz4XVufW22R2Guzg76DGHsfBQxFzH0QnuPUYc+z8/ABMYm0kskTtZ6j
	 FSFPIyDlZbYj/cHE2cqOlzTZz4lvZGHtdDIEpxRQxMpkFmLZybY/WQD3D3X4V37L4V
	 0/gvazfpAZcFJvBhYcyEz+PFBId+I1VuEK5u+rIlkKFAEgfQcAY5GXjYbqIopWG1SU
	 TqjErdDh3GHIqgitFOo0vtL3NGW6mC/QtsfFuzbV0Zb/kDroROUhrrqGz2TSdbSImh
	 +uwEgb4GPwQtA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46923Vx44160571
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jul 2024 10:03:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 10:03:31 +0800
Received: from localhost.localhost (172.21.132.53) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 9 Jul
 2024 10:03:30 +0800
From: Hilda Wu <hildawu@realtek.com>
To: <marcel@holtmann.org>
CC: <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alex_lu@realsil.com.cn>,
        <max.chou@realtek.com>, <kidman@realtek.com>, <apusaka@chromium.org>,
        <yinghsu@chromium.org>, <johnlai@google.com>
Subject: [PATCH v2] Bluetooth: btrtl: Fixup SCO header
Date: Tue, 9 Jul 2024 10:03:26 +0800
Message-ID: <20240709020326.4131686-1-hildawu@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

In some platform found unknown connection handle case when HFP. The
unknown connection handle may affect SCO audio sound quality.
The unknown connection handle case found in some Realtek chip.
This issue only occurs in (e)SCO, does not affect ACLs.

So validate SCO header, fixup the invalid connection handle and length
for avoiding influence SCO audio.

The following btmon excerpts are part of SCO packets in HCI log, The
following are the case to be fixup.

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
The packet 23331 was the invalid connection handle with wrong payload size
affected by the packet 23329 HCI SCO Data RX packet. It’s the packet that
needs to be processed.

Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
Signed-off-by: Hilda Wu <hildawu@realtek.com>
---
Change in v2:
 - Adjust implementation
 - Modify the commit log and title to make it more relevant to this commit
(Thanks to the reviewer for suggestion, which reminded us of a new method)
---
---
 drivers/bluetooth/btrtl.c |  5 +++++
 drivers/bluetooth/btrtl.h |  1 +
 drivers/bluetooth/btusb.c | 25 +++++++++++++++++++++----
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index f2f37143c454..d5d802837ec6 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -1300,6 +1300,11 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
 		    btrtl_dev->project_id == CHIP_ID_8852C)
 			set_bit(HCI_QUIRK_USE_MSFT_EXT_ADDRESS_FILTER, &hdev->quirks);
 
+		if (btrtl_dev->project_id == CHIP_ID_8822C ||
+		    btrtl_dev->project_id == CHIP_ID_8852A ||
+		    btrtl_dev->project_id == CHIP_ID_8852B)
+			btrealtek_set_flag(hdev, REALTEK_SCO_HDR_FIXUP);
+
 		hci_set_aosp_capable(hdev);
 		break;
 	default:
diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
index a2d9d34f9fb0..d10ce768fef1 100644
--- a/drivers/bluetooth/btrtl.h
+++ b/drivers/bluetooth/btrtl.h
@@ -105,6 +105,7 @@ struct rtl_vendor_cmd {
 
 enum {
 	REALTEK_ALT6_CONTINUOUS_TX_CHIP,
+	REALTEK_SCO_HDR_FIXUP,
 
 	__REALTEK_NUM_FLAGS,
 };
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2d5c971a59ad..617da3c2cb87 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1244,14 +1244,26 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
 	return err;
 }
 
-static bool btusb_validate_sco_handle(struct hci_dev *hdev,
+static bool btusb_validate_sco_hdr(struct hci_dev *hdev,
 				      struct hci_sco_hdr *hdr)
 {
 	__u16 handle;
 
-	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL))
-		// Can't validate, userspace controls everything.
+	struct btusb_data *data = hci_get_drvdata(hdev);
+	/* According to core spec Vol 4, Part B, 2.1.1 Controller descriptors,
+	 * there are payload sizes recommened below.
+	 */
+	u8 lens[7] = { 0, 24, 48, 72, 96, 144, 60 };
+
+	if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
+		handle = hci_handle(__le16_to_cpu(hdr->handle));
+		/* check if the packet payload size and handle are valid */
+		if (btrealtek_test_flag(data->hdev, REALTEK_SCO_HDR_FIXUP) &&
+		    data->isoc_altsetting <= 6 &&
+		    (lens[data->isoc_altsetting] != hdr->dlen || handle > 12))
+			return false;
 		return true;
+	}
 
 	/*
 	 * USB isochronous transfers are not designed to be reliable and may
@@ -1266,6 +1278,11 @@ static bool btusb_validate_sco_handle(struct hci_dev *hdev,
 	switch (hci_conn_lookup_type(hdev, handle)) {
 	case SCO_LINK:
 	case ESCO_LINK:
+		/* check if the packet payload size is valid */
+		if (btrealtek_test_flag(data->hdev, REALTEK_SCO_HDR_FIXUP) &&
+		    data->isoc_altsetting <= 6 &&
+		    lens[data->isoc_altsetting] != hdr->dlen)
+			return false;
 		return true;
 	default:
 		return false;
@@ -1309,7 +1326,7 @@ static int btusb_recv_isoc(struct btusb_data *data, void *buffer, int count)
 			hci_skb_expect(skb) = hdr->dlen;
 
 			if (skb_tailroom(skb) < hci_skb_expect(skb) ||
-			    !btusb_validate_sco_handle(data->hdev, hdr)) {
+			    !btusb_validate_sco_hdr(data->hdev, hdr)) {
 				kfree_skb(skb);
 				skb = NULL;
 
-- 
2.34.1

