Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BB3219A97;
	Tue,  8 Jul 2025 06:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751954564; cv=none; b=Md+SzceIQRB5qPuTFPWZlH0iZSDarkiVWNfKnWjZGSGaiF5g0Y9l00BNI745IfPe0u21XJBKJcNCLjU3iGLuF/gFkDI3Q1NyT+ppdEnKFfrA/A7RraAcSWayFeX4ivEqlar68vJKCyNfji1EGlnXtqlsmXho/TawAARFRFdbmhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751954564; c=relaxed/simple;
	bh=sGctqi73E2wqiZFaYszxlUL9QxQ3AG70NtaCwWg07TA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQEXH5xZSxfckieak3GoNF7i/hxOVvIXqKbgrPzjilY2l0/o6x16FzxMfH9+gz36f6FY0rdY8hHIDooGIZXZF0aPdkD0rsA+sthQBQIAoAmfzqrrkuLPFsTe10/TKYGSNjA8UtybTF0e/fKXC3SjjQknHBFEiXKgV/JQdHAoxBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=dkpPTDgY; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dkpPTDgY"
X-UUID: 2170f9c45bc111f0b1510d84776b8c0b-20250708
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=9PKHQ/mFxNZbAIae9wAVHTQfR/S1prWOZmagk8WbpsI=;
	b=dkpPTDgYztjfs7i8x6X4Csx1CX457znZun0OwPOS4JmS9BjOp1RUXHfrlCsNlTUqEBvznQ80LwK5Pnhjw+W1zsAhaDzSH1HSgvXZVxGuaNQZkIPN4c6TXbquRg1Z9pf+v4pBWx+gKHMc2juhSKl4BePofTQmN7/4/KRtQn8M8XY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:789c7101-5088-4cc5-9ad0-2399d40c317d,IP:0,UR
	L:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:25
X-CID-META: VersionHash:9eb4ff7,CLOUDID:0c07a082-cc21-4267-87cf-e75829fa6365,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:11|97|99|83|106|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2170f9c45bc111f0b1510d84776b8c0b-20250708
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <ot_zhangchao.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 268198922; Tue, 08 Jul 2025 14:02:29 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 8 Jul 2025 14:02:28 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 8 Jul 2025 14:02:27 +0800
From: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
CC: Sean Wang <sean.wang@mediatek.com>, Jiande Lu <jiande.lu@mediatek.com>,
	Deren Wu <deren.Wu@mediatek.com>, Chris Lu <chris.lu@mediatek.com>, Hao Qin
	<Hao.qin@mediatek.com>, Wallace Yu <Wallace.Yu@mediatek.com>, linux-bluetooth
	<linux-bluetooth@vger.kernel.org>, linux-kernel
	<linux-kernel@vger.kernel.org>, linux-arm-kernel
	<linux-arm-kernel@lists.infradead.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, devicetree
	<devicetree@vger.kernel.org>, Zhangchao Zhang
	<ot_zhangchao.zhang@mediatek.com>
Subject: [PATCH v6] dt-bindings: net: mediatek,mt7925-bluetooth.yaml
Date: Tue, 8 Jul 2025 14:01:49 +0800
Message-ID: <20250708060150.27375-3-ot_zhangchao.zhang@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250708060150.27375-1-ot_zhangchao.zhang@mediatek.com>
References: <20250708060150.27375-1-ot_zhangchao.zhang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Reset BT via BT_KILL_1V2_L hardware pin.

On the M.2 standard hardware pin interface, the MTK chip
has a pin called BT_KILL_1V2_L or W_DISABLE#2, it uses
function-level device reset (FLDR) to reset Bluetooth.
When it is pulled low, it can external shut down the BT
function, it is defined as 5 on the MT7925 chip, and is
defined as 248 on the device tree pio controller.

Signed-off-by: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
---
 .../bluetooth/mediatek,mt7925-bluetooth.yaml  | 55 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7925-bluetooth.yaml

diff --git a/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7925-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7925-bluetooth.yaml
new file mode 100644
index 000000000000..636b8b3d6a14
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7925-bluetooth.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/bluetooth/mediatek,mt7925-bluetooth.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bluetooth mediatek use BT_KILL_1V2_L hardware pin to reset BT
+
+maintainers:
+  - Sean Wang <sean.wang@mediatek.com>
+
+description:
+  MT7925 chip uses the USB bus to communicate with the host.
+  Two methods are used to reset Bluetooth. It provide hardware
+  pin, when an exception occurs, resetting Bluetooth by hardware
+  pin is more stable than resetting Bluetooth by software. If the
+  corresponding pin is not found in dts, bluetooth can also be
+  reset successfully.
+
+allOf:
+  - $ref: bluetooth-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt7925-bluetooth
+
+  "#gpio-cells":
+    const: 2
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      Default high level, this pin can external shut down the BT function
+      when this pin is pull low, at the same time, USB interface will be also
+      disabled. When this function is not required, external pull high is not
+      required. After 200ms, it is pulled high to 3.3v and the next probe is
+      performed. On typical M.2 key E modules this is the W_DISABLE2# pin.
+
+required:
+  - compatible
+  - "#gpio-cells"
+  - reset-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    bluetooth {
+      compatible = "mediatek,mt7925-bluetooth";
+      #gpio-cells = <2>;
+      reset-gpios = <&pio 248 GPIO_ACTIVE_LOW>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 5959513a7359..d104a5821f20 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14676,6 +14676,7 @@ L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/bluetooth/mediatek,bluetooth.txt
 F:	Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-bluetooth.yaml
+F:	Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7925-bluetooth.yaml
 F:	drivers/bluetooth/btmtkuart.c
 
 MEDIATEK BOARD LEVEL SHUTDOWN DRIVERS
-- 
2.46.0

