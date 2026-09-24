Received: from va-2-42.ptr.blmpb.com (va-2-42.ptr.blmpb.com [209.127.231.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32A63B840B
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 03:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790221080; cv=none; b=LiRCx2dYxoUmmbgl/o3ltM7w30kOxy2oyFi0v9p466iW6/7Q7sm9+8ldBEIOSf5/+v6ahtCAi4q/y80oJW5zlr9ohXGBMcU4s4zSa1spr/MNE374tYNBAgGnwcW9Mt2JMMqDQwS0IP6DvQcsQUIeFlpGpwWsrtTIUEyhvXNFRVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790221080; c=relaxed/simple;
	bh=WVziZOeRMB1UGv0Gn9pcw9a2Xh3ImcBFEM8uUWubguU=;
	h=From:Mime-Version:References:Content-Type:To:In-Reply-To:Date:
	 Message-Id:Cc:Subject; b=lg7W2bmM7nrFwoS2xIYoyvajeHCGR6QppCrnvxjNcyuJQeqOeXV81Ud1KCrL0BrZT0RpvWJCy53dFD1s99AVNGUi8EwFERRP8qs9bQw+A/gVoTq56LCBkViTD8riGa7yIqrNqB8rCEDbgXDrwhIGnLyyR9BT+rYaPWW4qSPXQbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bedmex.com; spf=none smtp.mailfrom=bedmex.com; dkim=pass (2048-bit key) header.d=bedmex-com.20200927.dkim.feishu.cn header.i=@bedmex-com.20200927.dkim.feishu.cn header.b=VeUaH4zN; arc=none smtp.client-ip=209.127.231.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bedmex.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bedmex.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bedmex-com.20200927.dkim.feishu.cn header.i=@bedmex-com.20200927.dkim.feishu.cn header.b="VeUaH4zN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=bedmex-com.20200927.dkim.feishu.cn; t=1790221071;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=KCoaCi8bcR/IAcF7cKnD+rwEN3cnJDjyqTRrjsdnqY0=;
 b=VeUaH4zN1Y4Zwo8HP/m1EWzsaryv5xfxz54lzibBT3nt1fxmvwXztExh8w8JCqxAOTekQ0
 4mD/qAejnLBYXqBMiHPR/z1whxuW0jDIHu2i1ZsbAtUjr+yE1sP6UVsJZZdPZ00yZyrkYM
 r1LSTuHfatO5RJTpMFZVJ2X3T9PB0V5BwRdHsKd71IYNhkIIAoL75CgugBAzVne4MZO+ak
 Xxx45c+R+TFM2KFpFZMS/H8fgKJYnG6KPFoyKRwi1BewqZMT+RG2eLGbsHO6ORZFkExccm
 SGDpFtCxq8qpzoW+0hFb3V2vXUJifvh6HTXYQTkHrSyLc2By8APY451VpfqSfQ==
Content-Transfer-Encoding: 7bit
From: "Yanli Yang" <yanli.yang@bedmex.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Yanli Yang <yanli.yang@bedmex.com>
References: <179022103315.2.2907053891316619435.btaic-v4-cover@bedmex.com>
Received: from [127.0.1.1] ([36.141.79.164]) by smtp.feishu.cn with ESMTPS; Thu, 24 Sep 2026 11:37:48 +0800
Content-Type: text/plain; charset=UTF-8
To: <linux-bluetooth@vger.kernel.org>
In-Reply-To: <179022103315.2.2907053891316619435.btaic-v4-cover@bedmex.com>
Date: Thu, 24 Sep 2026 11:34:10 +0800
Message-Id: <179022103316.2.15731752558077917960.btaic-v4-2@bedmex.com>
X-Lms-Return-Path: <lba+26ab49b0d+6bbc6b+vger.kernel.org+yanli.yang@bedmex.com>
Cc: <marcel@holtmann.org>, <devicetree@vger.kernel.org>, <robh@kernel.org>, 
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, 
	<linux-kernel@vger.kernel.org>, <zhirunliu@aicsemi.com>, 
	<dijiaxu@aicsemi.com>, <chunqiuliu@aicsemi.com>, <liheng.wei@bedmex.com>, 
	<yanli.yang@bedmex.com>
Subject: [PATCH bluetooth-next v4 2/3] dt-bindings: net: bluetooth: Add AIC8800D80

Describe the AIC8800D80 Bluetooth SDIO firmware-loading function and
UART HCI interface. Link the UART node to its SDIO firmware provider
with the aic,firmware-sdio phandle.

The UART interface uses H4 at 1500000 baud with hardware flow control.
Include an example showing both nodes and their association. Add the
Bluetooth binding to MAINTAINERS.

Signed-off-by: Zhirun Liu <zhirunliu@aicsemi.com>
Signed-off-by: Dijia Xu <dijiaxu@aicsemi.com>
Signed-off-by: Chunqiu Liu <chunqiuliu@aicsemi.com>
Signed-off-by: Liheng Wei <liheng.wei@bedmex.com>
Signed-off-by: Yanli Yang <yanli.yang@bedmex.com>
---
 .../net/bluetooth/aic,aic8800d80-bt.yaml      | 84 +++++++++++++++++++
 MAINTAINERS                                   | 10 +++
 2 files changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/aic,aic8800d80-bt.yaml

diff --git a/Documentation/devicetree/bindings/net/bluetooth/aic,aic8800d80-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/aic,aic8800d80-bt.yaml
new file mode 100644
index 000000000000..76b94fd539e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/aic,aic8800d80-bt.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/bluetooth/aic,aic8800d80-bt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AIC AIC8800D80 Bluetooth
+
+maintainers:
+  - Zhirun Liu <zhirunliu@aicsemi.com>
+  - Dijia Xu <dijiaxu@aicsemi.com>
+  - Chunqiu Liu <chunqiuliu@aicsemi.com>
+  - Liheng Wei <liheng.wei@bedmex.com>
+  - Yanli Yang <yanli.yang@bedmex.com>
+
+description:
+  The AIC8800D80 is a Wi-Fi and Bluetooth combination chip. The Bluetooth
+  firmware is loaded through SDIO function 1, while Bluetooth HCI traffic uses
+  the H4 protocol over a UART interface with hardware flow control.
+
+properties:
+  compatible:
+    enum:
+      - aic,aic8800d80-bt
+      - aic,aic8800d80-bt-sdio
+
+  reg:
+    maxItems: 1
+
+  max-speed: false
+
+  aic,firmware-sdio:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the SDIO function used to load the Bluetooth firmware.
+
+required:
+  - compatible
+
+allOf:
+  - $ref: bluetooth-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          const: aic,aic8800d80-bt-sdio
+    then:
+      properties:
+        reg:
+          items:
+            - items:
+                - const: 1
+        aic,firmware-sdio: false
+      required:
+        - reg
+    else:
+      properties:
+        reg: false
+      required:
+        - aic,firmware-sdio
+      allOf:
+        - $ref: /schemas/serial/serial-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mmc {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        bt_sdio: bluetooth@1 {
+            compatible = "aic,aic8800d80-bt-sdio";
+            reg = <1>;
+        };
+    };
+
+    serial {
+        uart-has-rtscts;
+
+        bluetooth {
+            compatible = "aic,aic8800d80-bt";
+            aic,firmware-sdio = <&bt_sdio>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index af5a8b4b0bb5..20662fe78632 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -729,6 +729,16 @@ S:	Maintained
 F:	drivers/scsi/aha152x*
 F:	drivers/scsi/pcmcia/aha152x*
 
+AIC BLUETOOTH DRIVER
+M:	Zhirun Liu <zhirunliu@aicsemi.com>
+M:	Dijia Xu <dijiaxu@aicsemi.com>
+M:	Chunqiu Liu <chunqiuliu@aicsemi.com>
+M:	Liheng Wei <liheng.wei@bedmex.com>
+M:	Yanli Yang <yanli.yang@bedmex.com>
+L:	linux-bluetooth@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/bluetooth/aic,aic8800d80-bt.yaml
+
 AIC7XXX / AIC79XX SCSI DRIVER
 M:	Hannes Reinecke <hare@suse.com>
 L:	linux-scsi@vger.kernel.org
-- 
2.34.1
