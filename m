Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458DA2A8D0;
	Fri, 27 Jun 2025 06:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751004065; cv=none; b=DPLReUizpnaBkwve3LIBTczn+q/LFZbbYs5NL7ejCF/pP5iUjvmA87hw84shOFz1kZKsUj/yv4B4FfVrthCANxQBS+rBJO+v1mzwMZSuJSRZKVbV4oES4HGNxl8qXEBmqoKH4FYJzo62j9sFrtfdfrzy8rMYiRn16++Jp5djgA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751004065; c=relaxed/simple;
	bh=voemzvAWLfQp6jD04lENr3YCH/ivpEANy4lakY3ery4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oi81Hhj2hbOyZ9DUAtqMHVkPK7ApXIN81wfPkNrpdAnk7DH7s7yVinZlV1kFzPzyuB67X6t66QhMdmVyJuof9l7TxJXoCkR2gXup2POyQBNZZbRoamSVeDw4ko97kR9aIcFmVAW7MJM13tem8FHYCCb+ON3xY5BJ1ucuMHCchK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=RM4ZEzkV; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RM4ZEzkV"
X-UUID: 18c4b61a531c11f0b910cdf5d4d8066a-20250627
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=14pd4QpWllGl8PV/mXJ+LzKhlaqqBqybi64T3zF9M/I=;
	b=RM4ZEzkVjmykKbHFOUa1izmJsF1SgZAKYvND2Kk6zIX2AwbwcWLvfUPoaoylCDkvDwGFs49OzBubX1t6+3787vo+ABGxtV74IPEn3N2shnLHB7vKCpqfVI7APJvQQVM2zpxo+f83lV+GXhOwFjemse50uUNiEZLFVeCd4B77Db8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:a1e19b59-e5ff-4ab9-a37c-79fb58794cc9,IP:0,UR
	L:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:25
X-CID-META: VersionHash:9eb4ff7,CLOUDID:42f09f73-15a7-4ae6-ad4b-94c27b45c266,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:11|97|99|83|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 18c4b61a531c11f0b910cdf5d4d8066a-20250627
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <ot_zhangchao.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2030193749; Fri, 27 Jun 2025 14:00:58 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 27 Jun 2025 14:00:56 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 27 Jun 2025 14:00:55 +0800
From: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
To: Marcel Holtmann <marcel@holtmann.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk=dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
CC: Sean Wang <sean.wang@mediatek.com>, Jiande Lu <jiande.lu@mediatek.com>,
	Deren Wu <deren.Wu@mediatek.com>, Chris Lu <chris.lu@mediatek.com>, Hao Qin
	<Hao.qin@mediatek.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel
	<linux-arm-kernel@lists.infradead.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, devicetree
	<devicetree@vger.kernel.org>, Zhangchao Zhang
	<ot_zhangchao.zhang@mediatek.com>
Subject: [PATCH v5 2/2] dt-bindings: net: mediatek,mt7925-bluetooth.yaml
Date: Fri, 27 Jun 2025 13:59:24 +0800
Message-ID: <20250627055924.7716-3-ot_zhangchao.zhang@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250627055924.7716-1-ot_zhangchao.zhang@mediatek.com>
References: <20250627055924.7716-1-ot_zhangchao.zhang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add hardware pins and compatible strings.

As a binding file for the MTK Bluetooth driver code,
it provides a set of compatible fields and hardware
pins for the driver to use.

Signed-off-by: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
---
 .../bluetooth/mediatek,mt7925-bluetooth.yaml  | 57 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7925-bluetooth.yaml

diff --git a/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7925-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7925-bluetooth.yaml
new file mode 100644
index 000000000000..230c24ada3b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7925-bluetooth.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/bluetooth/mediatek,mt7925-bluetooth.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bluetooth mediatek add gpio pin to reset bt
+
+maintainers:
+  - Sean Wang <sean.wang@mediatek.com>
+
+description:
+  7925 uses the USB bus to communicate with the host.
+  Two methods are used to reset Bluetooth.
+  Provide hardware pin, when an exception occurs,
+  resetting Bluetooth by hardware pin is more stable
+  than resetting Bluetooth by software.
+  If the corresponding pin is not found in dts,
+  bluetooth can also be reset successfully.
+
+allOf:
+  - $ref: bluetooth-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - mediatek,usb-bluetooth
+
+  gpio-controller:
+    description:
+      Marks the device node as s GPIO controller.
+
+  "#gpio-cells":
+    const: 2
+
+  reset-gpios:
+    maxItems: 1
+
+    description:
+      An active-high reset pin for the Bluetooth core; on typical M.2
+      key E modules this is the W_DISABLE2# pin.
+
+required:
+  - compatible
+  - "#gpio-cells"
+  - reset-gpios
+
+unevaluatedProperties: false
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+      bluetooth {
+        compatible = "mediatek,usb-bluetooth";
+        #gpio-cells = <2>;
+        reset-gpios = <&pio 248 GPIO_ACTIVE_HIGH>;
+      };
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

