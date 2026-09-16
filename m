Received: from va-2-20.ptr.blmpb.com (va-2-20.ptr.blmpb.com [209.127.231.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1F437C908
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 02:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789611975; cv=none; b=h6G4AULCGTseddmWgMa7zxm908qHhx6dATlHgzPGBt1y8PE7DUnIs8rgO/bru02Rhyd+a27/r7XbclDfF0j92FZrr6MyWeaFZCpH0b/MBh/NskNzR4A/1yNgN0uthxQMobl7WwxN7KJHEBfc/vw40gG4zo6Yp70JQBXRCZSjxwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789611975; c=relaxed/simple;
	bh=KSN16rEHfzku6Exs8W9LY777q733JeEOvEtmXoygkJU=;
	h=Cc:Subject:References:To:Mime-Version:Date:Message-Id:In-Reply-To:
	 Content-Type:From; b=eY+7UDvSsQ2u+xbrrTek9oN2KAnvzYxCF4Nja/dyaubJ25ICbfe9bNeGUecPUhqvjMB90BwSrgPKcdXVySc3I0WNfbllNJ9cKXHkwwbZbuKrTqPsMqnzEfmJrXNKH/rLXPm9988ftWLao4LC2II8uFkPmVJGDggM+NxwU3jhb+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bedmex.com; spf=none smtp.mailfrom=bedmex.com; dkim=pass (2048-bit key) header.d=bedmex-com.20200927.dkim.feishu.cn header.i=@bedmex-com.20200927.dkim.feishu.cn header.b=Mq8hDzWM; arc=none smtp.client-ip=209.127.231.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bedmex.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bedmex.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bedmex-com.20200927.dkim.feishu.cn header.i=@bedmex-com.20200927.dkim.feishu.cn header.b="Mq8hDzWM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=bedmex-com.20200927.dkim.feishu.cn; t=1789611964;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=U/xau0P0qxfGnCm2fD+HA7kaoUEUyD0MsiRMZUEM8qA=;
 b=Mq8hDzWMhG9vvMys7c2/QNrYpDGEqbUbjEUHxZovVSm54ltM2C2cCgXw4ytuwkLYnJel/Q
 PuzMos+Em37XtQAD6ji1jQEk+n5tKAR2apqG2xmT9wDCtinjXSYF+AeJJjHWuuGNeYYs09
 cbKKdNBbCqHhmiQVjwEiaxFjcuYC4jrJIpbRp6SxX7IDggux7ihYH62woiIPP2kcb5WJdg
 B7KzXEM9qY3giBLj0/IHI3lnFAN/HHcIwvYeXC4lTZMLYudRGbuPY1xC/QKKTOWM4itots
 1ZiA3ZTx3qvreSyGnYayXgiHdQmHxVwWyK8XjWN/aCCxunUJAyKjqgPtZ4qe3g==
Cc: <marcel@holtmann.org>, <luiz.dentz@gmail.com>, 
	<devicetree@vger.kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>, 
	<conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>, 
	<zhirunliu@aicsemi.com>, <dijiaxu@aicsemi.com>, <chunqiuliu@aicsemi.com>, 
	<liheng.wei@bedmex.com>, <yanli.yang@bedmex.com>
Subject: [RFC PATCH bluetooth-next 2/3] dt-bindings: net: bluetooth: Add AIC8800D80
References: <178954773705.2.3446471521233620446@bedmex.com>
Content-Transfer-Encoding: 7bit
To: <linux-bluetooth@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Yanli Yang <yanli.yang@bedmex.com>
Received: from [127.0.1.1] ([36.141.79.164]) by smtp.feishu.cn with ESMTPS; Thu, 17 Sep 2026 10:26:01 +0800
Date: Wed, 16 Sep 2026 16:35:39 +0800
X-Lms-Return-Path: <lba+26aab4fba+75745d+vger.kernel.org+yanli.yang@bedmex.com>
Message-Id: <178954773705.2.9742714830438825480@bedmex.com>
In-Reply-To: <178954773705.2.3446471521233620446@bedmex.com>
Content-Type: text/plain; charset=UTF-8
From: "Yanli Yang" <yanli.yang@bedmex.com>

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
index 000000000000..6fabb226cf15
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
+          const: 1
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
