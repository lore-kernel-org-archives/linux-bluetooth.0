Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E22B27C872;
	Fri,  5 Sep 2025 08:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757061885; cv=none; b=PRcdJ6yOH0uJHr7uYhsDloVx+QjRzfvdum2bEYo9BtNqgtCIx5XW0+LSP77EaC34hlgfFy7ZwZ9ZrEGUpX2/yMSnC9tqpizsYwkETkHi/eF9EedjABjeiE97QqzVIqQHpGODAzwyX1RwP9e+aTQaWt23UGysiHSlA/HAF9QGnXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757061885; c=relaxed/simple;
	bh=tqWqvgyY54FRPvxQsfqgJjAndlGuMZHlA4sehEjC8VI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F3CLLHPHX0VGbFeSNYRRz7PE+q24b/fkaQ5pUxTxBkcJSTdR2MpCCKlYtEnhi7nYLEU0/ju0GLyfv3R8w4Cob4Hvccdta9o9FQqDdeYa3mu3Z72BbsGohoEzzezStXw1Bf2Bx1yUdsSf9hhEjtXePT71V0BqjM+/TRkRyf04wQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=lQbNGBaU; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="lQbNGBaU"
X-UUID: 8e3e6e8c8a3411f0bd5779446731db89-20250905
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=S8l7G2EepH8XkBBdvC2ecofLBYVddp2ctHowG/kpVt8=;
	b=lQbNGBaUvqfAFqj0PgRdoSz2VsrnlJRlyu9tAhwyKRYFrkQRKIp8dpvobrpLVvtJA61KEHhMI0j8mU5BIJmeqJA83FfRcsdf0t38o1f8+YKTDlvSASGc+KiXXim8r87h4qE/qRL56WQw+KqyTDhVHUnTt1dNIx4Vo3y3uXx/bjs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:a1d65ae8-45dd-47a8-aaa0-834d871d48e2,IP:0,UR
	L:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:25
X-CID-META: VersionHash:f1326cf,CLOUDID:6b227884-5317-4626-9d82-238d715c253f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:-5,Content:0|15|50,EDM:-3,IP:
	nil,URL:11|97|99|83|106|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8e3e6e8c8a3411f0bd5779446731db89-20250905
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <ot_zhangchao.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1224739942; Fri, 05 Sep 2025 16:44:37 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 5 Sep 2025 16:44:34 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 5 Sep 2025 16:44:33 +0800
From: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Von Dentz
	<luiz.dentz@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: Sean Wang <sean.wang@mediatek.com>, Jiande Lu <jiande.lu@mediatek.com>,
	Deren Wu <deren.Wu@mediatek.com>, Chris Lu <chris.lu@mediatek.com>, Hao Qin
	<Hao.qin@mediatek.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel
	<linux-arm-kernel@lists.infradead.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, devicetree
	<devicetree@vger.kernel.org>, Zhangchao Zhang
	<ot_zhangchao.zhang@mediatek.com>
Subject: [PATCH v7] dt-bindings: net: mediatek,mt7925-bluetooth.yaml
Date: Fri, 5 Sep 2025 16:44:33 +0800
Message-ID: <20250905084433.26999-1-ot_zhangchao.zhang@mediatek.com>
X-Mailer: git-send-email 2.46.0
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
 .../bluetooth/mediatek,mt7925-bluetooth.yaml  | 47 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7925-bluetooth.yaml

diff --git a/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7925-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7925-bluetooth.yaml
new file mode 100644
index 000000000000..dd24312735e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7925-bluetooth.yaml
@@ -0,0 +1,47 @@
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
+  MT7925 modules provides hardware pin called W_DISABLE#2 to reset Bluetotoh,
+  two methods are used to reset Bluetooth. When an exception occurs, resetting
+  Bluetooth by hardware pin is more stable than resetting Bluetooth by software.
+
+allOf:
+  - $ref: bluetooth-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt7925-bluetooth
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      This pin can is used to externally reset BT function. When pull low,
+      the Bluetooth and USB interface will be also disabled. After 100ms,
+      it is pulled high to 3.3V to re_enable the device and trigger the
+      next probe. This is typically used on M.2 key E modules.
+
+required:
+  - compatible
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
2.45.2

