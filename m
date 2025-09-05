Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D22C1A9FB3;
	Fri,  5 Sep 2025 08:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757061708; cv=none; b=gH4r67zGJOs954H5prjVqAE3Ar6uS51qUcKd90qPA7JNhvGXvbguBbTnoudnhNt8bl1JV6o9YAtul/cwDfaTK87IQou/qoyK/DlgeazICYnaYHD72ueIVDuPZlJGAV9vHQ3pJKMF3VNG/tzlGIdRK4v+MGTNp4tVb+F/jK48Y3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757061708; c=relaxed/simple;
	bh=3pZb9xgMXEZ/1Hq+0KedlJVn2GKZrZmmfvhkxkgeyhc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W7UKASS2236Wo/dCF4tPCxgNc86hsEvRSS65perx0k2cVxjPHtDxrVgOmu0xPq+T4NtuxFVwASlFqVBO7+zx98sSBTgZ7ERKhxdeBflTWrk8Y2fSex781OpXKlOYlf4F4+a2vQDAYYAKGkiJiqH8CcI8EXdzSaGCRrctXOJUjGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=aDMa5Gcc; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aDMa5Gcc"
X-UUID: 238a26d08a3411f0b33aeb1e7f16c2b6-20250905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1JWIJLQsE75ESNF5yeSXNHEgKBXuHoOPiFdqBHhk0NE=;
	b=aDMa5Gcc8qZ4aGySC3ly6P+r6ClqH8GnrC0QstgvztU8LLQK+H7+59N4qFwIn5yNrD66e6j9swgZWly4WZ4f6sssrG+aA99K+8L3RFvzsa3okS/nRScYzBav8/cUYidVHXVroxKv8G5XhZjUZ3RrbVcg++naZy2yt9v9a+5I7/k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:b9a2600d-0c95-4104-aedf-02ae0bf61bdb,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:39e4faf7-ebfe-43c9-88c9-80cb93f22ca4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:-5,Content:0|15|50,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 238a26d08a3411f0b33aeb1e7f16c2b6-20250905
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <ot_zhangchao.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1944432617; Fri, 05 Sep 2025 16:41:38 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 5 Sep 2025 16:41:35 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 5 Sep 2025 16:41:34 +0800
From: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Luiz Von
 Dentz <luiz.dentz@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Sean Wang <sean.wang@mediatek.com>, Jiande Lu <jiande.lu@mediatek.com>,
	Deren Wu <deren.Wu@mediatek.com>, Chris Lu <chris.lu@mediatek.com>, Hao Qin
	<Hao.qin@mediatek.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel
	<linux-arm-kernel@lists.infradead.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Zhangchao Zhang
	<ot_zhangchao.zhang@mediatek.com>
Subject: [PATCH v7 1/1] Bluetooth: mediatek: add gpio pin to reset bt
Date: Fri, 5 Sep 2025 16:40:59 +0800
Message-ID: <20250905084059.26959-2-ot_zhangchao.zhang@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250905084059.26959-1-ot_zhangchao.zhang@mediatek.com>
References: <20250905084059.26959-1-ot_zhangchao.zhang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Makes the platform Bluetooth to be reset by hardware pin,
it provides two methods to do it for mediatek controller,
and it has been tested locally many times and can reset normally.

When an exception occurs, resetting Bluetooth by hardware pin
is more stable than resetting Bluetooth by software.
If the corresponding pin is not found in dts,
bluetooth can also be reset successfully.

Co-developed: Hao Qin <hao.qin@mediatek.com>
Co-developed: Chris Lu <chris.lu@mediatek.com>
Co-developed: Jiande Lu <jiande.lu@mediatek.com>
Signed-off-by: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
---
 drivers/bluetooth/btmtk.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 4390fd571dbd..29d6a93f255d 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -6,6 +6,8 @@
 #include <linux/firmware.h>
 #include <linux/usb.h>
 #include <linux/iopoll.h>
+#include <linux/gpio/consumer.h>
+#include <linux/of.h>
 #include <linux/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -359,11 +361,41 @@ int btmtk_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 EXPORT_SYMBOL_GPL(btmtk_set_bdaddr);
 
+static int btmtk_hw_gpio_reset(struct hci_dev *hdev, struct btmtk_data *reset_work)
+{
+	struct gpio_desc *reset_gpio;
+
+	/* Find device node*/
+	hdev->dev.of_node = of_find_compatible_node(NULL, NULL, "mediatek,mt7925-bluetooth");
+	reset_gpio = gpiod_get_optional(hdev->dev.of_node, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpio))
+		return PTR_ERR(reset_gpio);
+
+	if (!reset_gpio)
+		return -ENODEV;
+
+	if (test_and_set_bit(BTMTK_HW_RESET_ACTIVE, &reset_work->flags)) {
+		bt_dev_err(hdev, "last reset failed? Not resetting again");
+		gpiod_put(reset_gpio);
+		return -EBUSY;
+	}
+	gpiod_set_value_cansleep(reset_gpio, 0);
+	msleep(100);
+	gpiod_set_value_cansleep(reset_gpio, 1);
+	gpiod_put(reset_gpio);
+	return 0;
+}
+
 void btmtk_reset_sync(struct hci_dev *hdev)
 {
 	struct btmtk_data *reset_work = hci_get_priv(hdev);
 	int err;
 
+	/* Try hardware GPIO reset*/
+	err = btmtk_hw_gpio_reset(hdev, reset_work);
+	if (!err)
+		return;
+	/* Otherwise, do software reset */
 	hci_dev_lock(hdev);
 
 	err = hci_cmd_sync_queue(hdev, reset_work->reset_sync, NULL, NULL);
-- 
2.45.2

