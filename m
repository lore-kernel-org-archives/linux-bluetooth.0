Received: from va-2-56.ptr.blmpb.com (va-2-56.ptr.blmpb.com [209.127.231.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C633EC804
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2026 09:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789897846; cv=none; b=BTbPTdcsQhYTHFMjmsSIpPG+JH0dm2KnvT3/SEqHiMlTy1xFstw7FCJSR9+Oy/5+KAaBNiJvNWEhc43KNJmFqBhK7L+b0YwRttq/iKi7HSzefUd1+tWrMP6pYnnjnxtYSkbRtzRa2WXWOe4yZw8HyvrXxA0/kfVLee2/qMXMl5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789897846; c=relaxed/simple;
	bh=Tyz5ZJvCOy8BqQiaWs3hhWSdVKs3wfSnm48+a+yjF8g=;
	h=Message-Id:In-Reply-To:To:Subject:Date:Mime-Version:From:
	 References:Content-Type:Cc; b=jxOtu+bH3neY37o7+2NFT7S4bFsHU34/KVNM57PYaDKemCbUMuhLuLTRMKmtAHr/b89PwPgx9QDRyeuhKzJLcdbd6sOR4FKsVZ/34nMhM0OsFZvREIXm+zdVG49+zv3Lu6lsubIKsgAKwzdr7jMT73WVJ68tSl1e9FqFN/YULwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bedmex.com; spf=none smtp.mailfrom=bedmex.com; dkim=pass (2048-bit key) header.d=bedmex-com.20200927.dkim.feishu.cn header.i=@bedmex-com.20200927.dkim.feishu.cn header.b=w8QQpqzE; arc=none smtp.client-ip=209.127.231.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bedmex.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bedmex.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bedmex-com.20200927.dkim.feishu.cn header.i=@bedmex-com.20200927.dkim.feishu.cn header.b="w8QQpqzE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=bedmex-com.20200927.dkim.feishu.cn; t=1789897836;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=uFLCAiwcrvOQJW9zFhS8aDXytY7kGWshXq0lVPXwDOI=;
 b=w8QQpqzEZB2AYM8JfATkp9LRTRoMLK6MstuVU5Wq0+CWr8XH7ZrvKoGQjkdbERULxGmySO
 mIjQXk4QqiaRx7KT9NG67EfKPnA9bnujYKetPzzgWuvETp26Fc7+lwJZW+JxTtmTBUu+Eo
 tY/FBhXpspqvKuldXtuqqLwuM/w9ZHO30YnyrksRG63G4Dl/FXpOYityiNFmUfkpFfi4hx
 56zX1ujozagFzqtxc5VVq3ApJleZ0gJpKY3yd7i/0lBcms1DT4NNQpKaXN7YhHQjwlE1z5
 f5rm1jwLTBVNGlvI78TRtWdQjXPBwmTSi7zhx2lLVg7QEJ7Qsm2MCH/vE0Rptw==
Message-Id: <a4304d4068002ca854d2aea5609ac8440935a8b2.1789897503.git.yanli.yang@bedmex.com>
In-Reply-To: <cover.1789897503.git.yanli.yang@bedmex.com>
To: <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Subject: [RFC PATCH v2 2/3] dt-bindings: net: bluetooth: Add AIC8800D80
Date: Sun, 20 Sep 2026 17:50:25 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Yanli Yang <yanli.yang@bedmex.com>
Received: from bmxpxe-virtual-desktop.. ([36.141.79.164]) by smtp.feishu.cn with ESMTPS; Sun, 20 Sep 2026 17:50:33 +0800
From: "Yanli Yang" <yanli.yang@bedmex.com>
X-Lms-Return-Path: <lba+26aafac6a+3af138+vger.kernel.org+yanli.yang@bedmex.com>
References: <cover.1789897503.git.yanli.yang@bedmex.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Cc: <marcel@holtmann.org>, <devicetree@vger.kernel.org>, <robh@kernel.org>, 
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, 
	<linux-kernel@vger.kernel.org>, <zhirunliu@aicsemi.com>, 
	<dijiaxu@aicsemi.com>, <chunqiuliu@aicsemi.com>, <liheng.wei@bedmex.com>, 
	<yanli.yang@bedmex.com>

Describe the AIC8800D80 Bluetooth SDIO firmware-loading function and
UART HCI interface. Link the UART node to its SDIO firmware provider
with the aic,firmware-sdio phandle.

The UART interface uses H4 at 1500000 baud with hardware flow control.
Include an example showing both nodes and their association.

Signed-off-by: Zhirun Liu <zhirunliu@aicsemi.com>
Signed-off-by: Dijia Xu <dijiaxu@aicsemi.com>
Signed-off-by: Chunqiu Liu <chunqiuliu@aicsemi.com>
Signed-off-by: Liheng Wei <liheng.wei@bedmex.com>
Signed-off-by: Yanli Yang <yanli.yang@bedmex.com>
---
 .../net/bluetooth/aic,aic8800d80-bt.yaml      | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/aic,aic8800d80-bt.yaml

diff --git a/Documentation/devicetree/bindings/net/bluetooth/aic,aic8800d80-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/aic,aic8800d80-bt.yaml
new file mode 100644
index 000000000000..d3ea780e85da
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/aic,aic8800d80-bt.yaml
@@ -0,0 +1,87 @@
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
+  max-speed: true
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
+          const: [[1]]
+        max-speed: false
+        aic,firmware-sdio: false
+      required:
+        - reg
+    else:
+      properties:
+        reg: false
+        max-speed:
+          const: 1500000
+      required:
+        - max-speed
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
+            max-speed = <1500000>;
+            aic,firmware-sdio = <&bt_sdio>;
+        };
+    };
-- 
2.34.1
