Return-Path: <SRS0=v5pE=ZW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D490C432C3
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Nov 2019 19:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5299A20880
	for <linux-bluetooth@archiver.kernel.org>; Sat, 30 Nov 2019 19:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bonstra.fr.eu.org header.i=@bonstra.fr.eu.org header.b="m+pSkbMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfK3Tro (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 30 Nov 2019 14:47:44 -0500
Received: from vault.bonstra.fr.eu.org ([51.158.68.104]:41388 "EHLO
        vault.bonstra.fr.eu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbfK3Tro (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 30 Nov 2019 14:47:44 -0500
Received: from val.bonstra.fr.eu.org (unknown [192.168.128.2])
        by vault.bonstra.fr.eu.org (Postfix) with ESMTP id BACC1BFB8E;
        Sat, 30 Nov 2019 19:47:42 +0000 (UTC)
Received: from localhost.localdomain (vlad.gr1 [IPv6:fd7b:45cc:aa3d::3])
        by val.bonstra.fr.eu.org (Postfix) with ESMTPSA id 0C94564C19;
        Sat, 30 Nov 2019 20:47:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bonstra.fr.eu.org;
        s=dkim1; t=1575143261; x=1576352861;
        bh=fqwZp4emGYLlyQ0o+53kk6KDHW9jOpE2pSUA1m6BOFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=m+pSkbMle/lyEcsF2njM2TUzIh31rTgkWAfoUHa+fOhI6fUEie5AWwhu6cC+7c14S
         sNIybLja6cYkGcqH6fmfWjqq1t7DCeRHbK3ltJwrgodn5gnrrhBcDgyBUHu93E1jbI
         8nyBaH7J2pTzDWVCrOf59qmJCG4URO2EqN7E1rPwceqavhKIQT08irhSQ58T+TC/CH
         kYjytQj5Of1Pha4ZDff7U/E4XK0uzwZG40DRFv/s5pLSD02Uutb9u8hjPWcsRxVcGU
         0J0KXW8AuYZBJTYj/4SclJ4UQLdNag8hamXVnWNX64l1Fd0pMIBd6WG7Fwg9UdY2gt
         3DX2Pgw5IQcCw==
From:   Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: net: bluetooth: add DT bindings for Realtek controllers
Date:   Sat, 30 Nov 2019 20:47:17 +0100
Message-Id: <20191130194719.112335-2-bonstra@bonstra.fr.eu.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130194719.112335-1-bonstra@bonstra.fr.eu.org>
References: <20191130194719.112335-1-bonstra@bonstra.fr.eu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The rtl_bt driver already supports some Realtek controllers on ACPI
platforms.
This commit adds bindings for DT-only platforms.

Signed-off-by: Hugo Grostabussiat <bonstra@bonstra.fr.eu.org>
---
 .../bindings/net/realtek-bluetooth.yaml       | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/realtek-bluetooth.yaml

diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml b/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
new file mode 100644
index 000000000000..6b62e5132c90
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/realtek-bluetooth.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek Bluetooth controllers device tree bindings
+
+description: |
+  Device tree bindings for serial attached Realtek Bluetooth controllers.
+
+maintainers:
+  - Marcel Holtmann <marcel@holtmann.org>
+  - Johan Hedberg <johan.hedberg@gmail.com>
+
+properties:
+  compatible:
+    items:
+      - const: realtek,rt8723bs-bt
+
+  powerdown-gpios:
+    description: GPIO line controlling the power down (BT_DIS#) signal
+    maxItems: 1
+
+  device-wake-gpios:
+    description: GPIO line controlling the device wakeup (BT_WAKE) signal
+    maxItems: 1
+
+  host-wake-gpios:
+    description: GPIO line sampling the host wakeup (BT_HOST_WAKE) signal
+    maxItems: 1
+
+  firmware-name:
+    description: |
+      Name of the configuration file to load in addition to firmware
+    $ref: http://devicetree.org/schemas/types.yaml#/definitions/string
+
+required:
+  - compatible
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    uart1 {
+      bluetooth {
+        compatible = "realtek,rtl8723bs-bt";
+        powerdown-gpios = <&r_pio 0 4 GPIO_ACTIVE_LOW>;
+        host-wake-gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>;
+        device-wake-gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>;
+        firmware-name = "rtl8723bs_config-teres_a64_i.bin";
+      };
+    };
-- 
2.24.0

