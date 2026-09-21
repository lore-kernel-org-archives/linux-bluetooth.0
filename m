Received: from va-2-50.ptr.blmpb.com (va-2-50.ptr.blmpb.com [209.127.231.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0863BB119
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 07:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789975560; cv=none; b=M8vEResCRwASlKDa6ORXFLD5eq90aVZR6XChAh5Tj8fo3tUV5/3T1RVZSMXDhWGv1anXiqloh4nKAGNBb5SGOMDCFYnZq1fQXgcXxMae6adNTZObnkb5DPnl0k2UpC1FgII3IaNxzdPLqkPk0JfnHXMriyewk5N1C32H2NSbyTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789975560; c=relaxed/simple;
	bh=Bht4kS7a0YKfju6b6SvBnNOh+fngCEA2CP1LDySMZkk=;
	h=Subject:Cc:References:Content-Type:To:From:Date:Mime-Version:
	 Message-Id:In-Reply-To; b=XMvYNNffoguDOaGJ+X5gFqecfiiFD/P98IuSRbP9Gad6X09KWqLlLAq5V/jk4oBb9Wut3Czzco4KIh0uvSEpNUAvS1oIKAOBpGG763PGZPtcZPEJKNnJixJLYnnIDhHnFtImodUy71Mi1kEgRXHJOxkylX9RnNc+nZxiDEhXg2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bedmex.com; spf=none smtp.mailfrom=bedmex.com; dkim=pass (2048-bit key) header.d=bedmex-com.20200927.dkim.feishu.cn header.i=@bedmex-com.20200927.dkim.feishu.cn header.b=VJ21UlxU; arc=none smtp.client-ip=209.127.231.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bedmex.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bedmex.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bedmex-com.20200927.dkim.feishu.cn header.i=@bedmex-com.20200927.dkim.feishu.cn header.b="VJ21UlxU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=bedmex-com.20200927.dkim.feishu.cn; t=1789975553;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=JwS/7g2tod8NvUB+y6K9b/eDXPcQuadctRoEP4suMpE=;
 b=VJ21UlxUmKgSoQ3kXmRGNnsvWamd1Cm6GyosJ1IRO/RNid7yVZpqEoAA5PlppDGV/4DPej
 R0X8LoiLkJIPzZ3D7I3o5AUgM60DPc/UAPgpo0cAY6STXQI9urZzEsTkEYhLe+zjCHRJW1
 yudfD4hvrqTsTGWPsbCFHtN4UNQkTJXSJ+ouSfF3ei2vKbxqKBklwqXD1QE9MlH/GGYcJI
 Sc1wdy0XLzD7OLRjpep7XpdpEa2AOBvt3Fb36+GZhzziBMawXSJL45lqCeNVbud/yXZd2P
 KLUSk9QxieocTpkbOVahSA2NC7t0/3BdEQn2aIkgUogil928lmx73pIvjIa1bg==
Subject: [RFC PATCH v3 2/3] Bluetooth: dt-bindings: Add AIC8800D80
Received: from bmxpxe-virtual-desktop.. ([36.141.79.164]) by smtp.feishu.cn with ESMTPS; Mon, 21 Sep 2026 15:25:50 +0800
Cc: <marcel@holtmann.org>, <devicetree@vger.kernel.org>, <robh@kernel.org>, 
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, 
	<linux-kernel@vger.kernel.org>, <zhirunliu@aicsemi.com>, 
	<dijiaxu@aicsemi.com>, <chunqiuliu@aicsemi.com>, <liheng.wei@bedmex.com>, 
	<yanli.yang@bedmex.com>
X-Original-From: Yanli Yang <yanli.yang@bedmex.com>
X-Mailer: git-send-email 2.34.1
References: <cover.1789974593.git.yanli.yang@bedmex.com>
X-Lms-Return-Path: <lba+26ab0dbff+cc05f0+vger.kernel.org+yanli.yang@bedmex.com>
Content-Type: text/plain; charset=UTF-8
To: <linux-bluetooth@vger.kernel.org>
From: "Yanli Yang" <yanli.yang@bedmex.com>
Date: Mon, 21 Sep 2026 15:25:42 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <aff45beb52d4bcc99b0fdcb862b7b984ad737d92.1789974593.git.yanli.yang@bedmex.com>
In-Reply-To: <cover.1789974593.git.yanli.yang@bedmex.com>

Describe the AIC8800D80 Bluetooth SDIO firmware-loading function and
UART HCI interface. Link the UART node to its SDIO firmware provider
with the aic,firmware-sdio phandle.

Add the binding file to the AIC Bluetooth MAINTAINERS entry.

Signed-off-by: Zhirun Liu <zhirunliu@aicsemi.com>
Signed-off-by: Dijia Xu <dijiaxu@aicsemi.com>
Signed-off-by: Chunqiu Liu <chunqiuliu@aicsemi.com>
Signed-off-by: Liheng Wei <liheng.wei@bedmex.com>
Signed-off-by: Yanli Yang <yanli.yang@bedmex.com>
---
 .../net/bluetooth/aic,aic8800d80-bt.yaml      | 83 +++++++++++++++++++
 MAINTAINERS                                   | 10 +++
 2 files changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/bluetooth/aic,aic8800d80-bt.yaml

diff --git a/Documentation/devicetree/bindings/net/bluetooth/aic,aic8800d80-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/aic,aic8800d80-bt.yaml
new file mode 100644
index 000000000000..9c04ba62ecef
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/aic,aic8800d80-bt.yaml
@@ -0,0 +1,83 @@
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
+            - const: 1
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
