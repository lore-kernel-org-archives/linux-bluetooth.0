Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779DC38DEC;
	Fri, 26 Sep 2025 10:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758881467; cv=none; b=lVUd/qNmemF2WRVUqebVYxdbUXGk3Qsl4x7o4yZdelpfiq/lK3hY/cXkqm4gy4ZKeLEqY63bUJu0UX/fkbV4J4jdLjH9wPTPqnNFfVfuAFWsG70fXbyWaPFVaItC0me0H9AZl1BurM+LkUCdVyLZZs0LGxiF4mMFl8bfsM+QV78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758881467; c=relaxed/simple;
	bh=Em0SlgY4fGTNNNCgpLDDkO1H4m/u3MwuWWF7DgCiX9k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JYLaoxkDeJvpBPJb2MRQZxoqckpa/y/UiLGjgWH3rqhkkFbnIUueO1TjFPvCLBEBlWayyRXEvk+JjEoYOW6E55BGf7VRnorg7Hoxb9hBG7GBoIktJVlxaCGPKc7n0vTYYP28zcR4+3tb2BRDdu/Q4UZWF86gVIzHzcRxo0ItljQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=sD1ZH08U; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sD1ZH08U"
X-UUID: 1440be3a9ac111f0b33aeb1e7f16c2b6-20250926
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=nahzOWRsnAxDDWbnoY7+EEzku1ZXFizlLixWhDklayU=;
	b=sD1ZH08UQWFLI0+88n+/vkigrs7enZS3ZZNARiJnPAMZSOxFVqKn2nF0+0IeqFJFAMqMuc0biRbIg6JzfAgjeeCWJSPhLhPFhaFD/3Kusv2TvkLnBGpvN5kJu0Ml5J+R6Hzyd3wejmce/dx9EpdA3caBwScrP4NhHvQToWIXITQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:015f70c3-5c3d-4b77-affb-0638d9b8f23f,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:d0f3b6e9-2ff9-4246-902c-2e3f7acb03c4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1440be3a9ac111f0b33aeb1e7f16c2b6-20250926
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <ot_zhangchao.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1994878395; Fri, 26 Sep 2025 18:10:50 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Sep 2025 18:10:48 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Fri, 26 Sep 2025 18:10:47 +0800
From: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: Krzysztof Kozlowski <krzk@kernel.org>, Sean Wang <sean.wang@mediatek.com>,
	Deren Wu <deren.Wu@mediatek.com>, Chris Lu <chris.lu@mediatek.com>, Hao Qin
	<Hao.qin@mediatek.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel
	<linux-arm-kernel@lists.infradead.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Zhangchao Zhang
	<ot_zhangchao.zhang@mediatek.com>
Subject: [PATCH v9] Bluetooth: mediatek: add gpio pin to reset bt
Date: Fri, 26 Sep 2025 18:10:46 +0800
Message-ID: <20250926101046.26559-1-ot_zhangchao.zhang@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Support the platform Bluetooth to be reset by hardware pin,
when a Bluetooth exception occurs, attempt to reset the
Bluetooth module using the hardware reset pin, as this
method is generally more stable and reliable than a
software reset. If the hardware reset pin is not specified
in the device tree, fall back to the existing software
reset mechanism to ensure backward compatibility.

Co-developed: Sean Wang <Sean.Wang@mediatek.com>
Co-developed: Hao Qin <hao.qin@mediatek.com>
Co-developed: Chris Lu <chris.lu@mediatek.com>
Signed-off-by: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>

V8-->V9 modifications:
-Corrected the if judgment in the patch from data->rest_gpio
   to data->reset_gpio.

V7-->V8 modifications:
-Currently, the universal reset GPIO can be found by configuring DTS.
   USB bus can get the device node and reset GPIO in the probe phase.
   It is fully compatible with other vendors' methods of getting reset
   GPIO. Therefore, the previous complex methods of adding the compatible
   string in btmtk.c to get GPIO is discarded. Abi files and yaml files
   are no longer needed. When a Bluetooth exception occurs, the existence
   of GPIO will be determined first. This change improves the robustness
   of Bluetooth recovery on platforms that support hardware reset, while
   maintaining support for platforms that do not.

V6-->V7 modifications:
-Change the gpio_direction_output interface to the gpiod_set_value_cansleep
   and gpiod_put interface.
-Remove the schedule_delayed_work asynchronous operation.
-Delete the #gpio-cell attribute in the yaml file, remove the #gpio-cell
   in the required field, and simplify the contents of the descriptions.

V5-->V6 modifications:
-Add specific revisions in the changes from v4 to v5.
-Add hardware pin title and descriptions to dt-binding submission
   information.
-Modify the title descriptions in the dt-binding file.
-Add 7925 what is it.
-Wrap the descriptions of MT7925 chip uses the USB bus appropriately.
-Change the compatible string to mediatek,mt7925-bluetooth in
   the dt-binding file and driver code.
-Drop gpio-controlelr properties in the dt-binding file.
-Modify the descriptions of the reset-gpios
   properties in the dt-binding file.
-Change the node information of reset-gpios in bluetooth
   from high level valid to low level valid.

V4-->V5 modifications:
-Correct the spelling error of word provides mentioned in V1.
-Drop the xhci0 node and status property in the dt-binding file.
-Modify the bt_reset tag node to bluetooth in the dt-binding file.
-Add #gpio-cell descriptions to properties, nodes and requests.
-Make a separate patch for the changes to dt-binding.

V3-->V4 modifications:
-Modify submission information why use hardware pin to reset Bluetooth.
-Write historical commit information into the cover letter.
-Modify dt binding format information and
   the explanation text in the dt-binding file.

V2-->V3 modifications:
-Changed the capitalization of co-developer names,
   using the correct capitalization of abbreviations and full
   name, and corrected obvious spelling errors.
-Add a revision history.
-Remove the "BT Driver" in the prefix.
-Add the bt-binding document, include inforamtion related to reset
   pin and compatibility matching.
-Add a comment before the schedule_delayed_work function call,
   although schedule_delayed_work is asynchronous, there is no risk.
   Even if it is not completed within 200ms, it will only postpone
   the subsequent probe and will not have any impact.
-Add a comment before the btmtk_reset_by_gpio function call,
   if the compatibility filed or pin cannot be found in the dts
   files, it can still reset bluetooth using software reset.

V2 modifications:
-Modify gpio to GPIO, SW to software,
   and fix other obvious spelling errors.
---
 drivers/bluetooth/btusb.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index ef44817cad34..f972332840f5 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2745,6 +2745,19 @@ static int btusb_mtk_reset(struct hci_dev *hdev, void *rst_data)
 	btusb_stop_traffic(data);
 	usb_kill_anchored_urbs(&data->tx_anchor);
 
+	/* Toggle the hard reset line. The MediaTek device is going to
+	 * yank itself off the USB and then replug. The cleanup is handled
+	 * correctly on the way out (standard USB disconnect), and the new
+	 * device is detected cleanly and bound to the driver again like
+	 * it should be.
+	 */
+	if (data->reset_gpio) {
+		gpiod_set_value_cansleep(data->reset_gpio, 1);
+		msleep(200);
+		gpiod_set_value_cansleep(data->reset_gpio, 0);
+		return 0;
+	}
+
 	err = btmtk_usb_subsys_reset(hdev, btmtk_data->dev_id);
 
 	usb_queue_reset_device(data->intf);
-- 
2.45.2

