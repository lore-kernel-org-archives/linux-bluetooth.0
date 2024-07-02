Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C14C158D98;
	Tue,  2 Jul 2024 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719919867; cv=none; b=Hs9zJD4yfql/2yv7jhz/4We7vwg66eekLtxlPMGVw17oGOY7c1xZ7F/YR25QRmreSqrQUbDButT1TS5+KMkisodA++qilXTdq88mCXaI4FPdtF9gAQw8I64PM2njKD9vYPyQVUkSIPJGDYwao12CTIwOs2MR1/Oo1FyE4so4E7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719919867; c=relaxed/simple;
	bh=ZAYpEH/KIqTkwASKEJ/suUys0sWISrF2gWi0f3fqiSg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uoMywgiVdbpX6AJPbd3Kdv4v/+PC/psM29CRVLUHO0t9/fAYhdtW4Bo9k14TqkzQvj2rCnFkdDGKst3fjx1LMUswc5cmSt7VHshUAPGIRc1/5rRCQkvqpweL48IYSoEojrHMUw6N7JQVntM5AkwbaaxUpzaocWd3HFJkp0uT0YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JzoCcG7Q; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JzoCcG7Q"
X-UUID: 8cfc7314386611ef99dc3f8fac2c3230-20240702
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=FWnyYNQ5wR95Rp+oqiCiXRCwx+R4allhZp/0A/Rh0ww=;
	b=JzoCcG7Q9BHmMBx6sG1537J/ulTweAZy+CxRnvwK6lC6OPlOJzcGIWXHPylG0v3ZbOIWjY358ATdtosqsI6vKBBmNmBJ1epm1XWF+NsTEmpgJr/jREel6qiv5isZJS6HwFJoJnQGVdrPQEfKF6nZd6klZI2rB1PleJoKbjzLa4k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:1a9029fd-1bd3-4c7d-9bb6-fc7352666ecd,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:5f29d144-a117-4f46-a956-71ffeac67bfa,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 8cfc7314386611ef99dc3f8fac2c3230-20240702
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1100121487; Tue, 02 Jul 2024 19:30:57 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 2 Jul 2024 19:30:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 2 Jul 2024 19:30:55 +0800
From: Chris Lu <chris.lu@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Chris Lu <chris.lu@mediatek.com>
Subject: [PATCH v6 7/8] Bluetooth: btmtk: move btusb_recv_acl_mtk to btmtk.c
Date: Tue, 2 Jul 2024 19:30:50 +0800
Message-ID: <20240702113051.24372-8-chris.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240702113051.24372-1-chris.lu@mediatek.com>
References: <20240702113051.24372-1-chris.lu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--13.504400-8.000000
X-TMASE-MatchedRID: 8uWJ+nIttWBhb5jjEf4kMbbQFsbjObJeJCrNy6AbUJUKOjjtK9XSTTO2
	XEBW60nf09NQNrxIpFavXn8ZlTtgDJ1kCAHc+nBCtw+xHnsmQjMoteqd/zXaIy8zQZ2rR/OpxOt
	yU4RbwrVHkoFjm6yfTLl4SKZRXMQAJ97zn9JejhYOSj4RiINDESuMiCnnpzIK05ehwAGYD21l/q
	IDo7WPRWJceHs2Yfamu+tUW9pLem8pDniSMR+7FQKDWtq/hHcNjiWciALpTNMUtdRZTmEaIY90G
	xaR8c3t/ZoI2dvJSJkMXjQFbZmmFHS0x46LMJIabc297PAGtWZWOQQSa4vbHZsoi2XrUn/Jn6Kd
	MrRsL14qtq5d3cxkNZKaWZiSr+ARGuPVoCRcpeeYyoXbIQPAuRAdTx+FDmARBotK3XRYKQE=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.504400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: A66F2FF75DEAFF3C1558110FF0AE54A8EE2CCBC2C890DF263CF878255D1BF14B2000:8

Move btusb_recv_acl_mtk from btusb.c to btmtk.c which holds
vendor specific stuff and would make btusb.c clean.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Chris Lu <chris.lu@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 33 +++++++++++++++++++++++++++++++++
 drivers/bluetooth/btmtk.h |  7 +++++++
 drivers/bluetooth/btusb.c | 34 +---------------------------------
 3 files changed, 41 insertions(+), 33 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index f5ecb8227d3b..fe3b892f6c6e 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -930,6 +930,39 @@ int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 }
 EXPORT_SYMBOL_GPL(btmtk_usb_subsys_reset);
 
+int btmtk_usb_recv_acl(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btmtk_data *data = hci_get_priv(hdev);
+	u16 handle = le16_to_cpu(hci_acl_hdr(skb)->handle);
+
+	switch (handle) {
+	case 0xfc6f:		/* Firmware dump from device */
+		/* When the firmware hangs, the device can no longer
+		 * suspend and thus disable auto-suspend.
+		 */
+		usb_disable_autosuspend(data->udev);
+
+		/* We need to forward the diagnostic packet to userspace daemon
+		 * for backward compatibility, so we have to clone the packet
+		 * extraly for the in-kernel coredump support.
+		 */
+		if (IS_ENABLED(CONFIG_DEV_COREDUMP)) {
+			struct sk_buff *skb_cd = skb_clone(skb, GFP_ATOMIC);
+
+			if (skb_cd)
+				btmtk_process_coredump(hdev, skb_cd);
+		}
+
+		fallthrough;
+	case 0x05ff:		/* Firmware debug logging 1 */
+	case 0x05fe:		/* Firmware debug logging 2 */
+		return hci_recv_diag(hdev, skb);
+	}
+
+	return hci_recv_frame(hdev, skb);
+}
+EXPORT_SYMBOL_GPL(btmtk_usb_recv_acl);
+
 int btmtk_usb_setup(struct hci_dev *hdev)
 {
 	struct btmtk_data *btmtk_data = hci_get_priv(hdev);
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index fe41528ae509..47193b867b9f 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -191,6 +191,8 @@ void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id, u32 fw_ver,
 
 int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id);
 
+int btmtk_usb_recv_acl(struct hci_dev *hdev, struct sk_buff *skb);
+
 int btmtk_usb_setup(struct hci_dev *hdev);
 
 int btmtk_usb_shutdown(struct hci_dev *hdev);
@@ -239,6 +241,11 @@ static int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id)
 	return -EOPNOTSUPP;
 }
 
+static int btmtk_usb_recv_acl(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	return -EOPNOTSUPP;
+}
+
 static int btmtk_usb_setup(struct hci_dev *hdev)
 {
 	return -EOPNOTSUPP;
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index d61a1d02e3e3..5de50c835964 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2690,38 +2690,6 @@ static int btusb_mtk_shutdown(struct hci_dev *hdev)
 	return btmtk_usb_shutdown(hdev);
 }
 
-static int btusb_recv_acl_mtk(struct hci_dev *hdev, struct sk_buff *skb)
-{
-	struct btusb_data *data = hci_get_drvdata(hdev);
-	u16 handle = le16_to_cpu(hci_acl_hdr(skb)->handle);
-
-	switch (handle) {
-	case 0xfc6f:		/* Firmware dump from device */
-		/* When the firmware hangs, the device can no longer
-		 * suspend and thus disable auto-suspend.
-		 */
-		usb_disable_autosuspend(data->udev);
-
-		/* We need to forward the diagnostic packet to userspace daemon
-		 * for backward compatibility, so we have to clone the packet
-		 * extraly for the in-kernel coredump support.
-		 */
-		if (IS_ENABLED(CONFIG_DEV_COREDUMP)) {
-			struct sk_buff *skb_cd = skb_clone(skb, GFP_ATOMIC);
-
-			if (skb_cd)
-				btmtk_process_coredump(hdev, skb_cd);
-		}
-
-		fallthrough;
-	case 0x05ff:		/* Firmware debug logging 1 */
-	case 0x05fe:		/* Firmware debug logging 2 */
-		return hci_recv_diag(hdev, skb);
-	}
-
-	return hci_recv_frame(hdev, skb);
-}
-
 #ifdef CONFIG_PM
 /* Configure an out-of-band gpio as wake-up pin, if specified in device tree */
 static int marvell_config_oob_wake(struct hci_dev *hdev)
@@ -3827,7 +3795,7 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->set_bdaddr = btmtk_set_bdaddr;
 		set_bit(HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN, &hdev->quirks);
 		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
-		data->recv_acl = btusb_recv_acl_mtk;
+		data->recv_acl = btmtk_usb_recv_acl;
 	}
 
 	if (id->driver_info & BTUSB_SWAVE) {
-- 
2.18.0

