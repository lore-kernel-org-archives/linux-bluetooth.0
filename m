Return-Path: <SRS0=oxy1=EJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 582F1C4742C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Nov 2020 12:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6B4522264
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Nov 2020 12:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lDUD5G3B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgKCMJt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Nov 2020 07:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbgKCMJt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Nov 2020 07:09:49 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600FCC0613D1
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2020 04:09:47 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id i2so18794940ljg.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2020 04:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wV6Ly4OTVMIHuO3QgeFv/pV+xSUgjDASQ2+fZhKE0+w=;
        b=lDUD5G3BKbsO7njFX973jlMkuFWjh80WIMfdBSol37Y6t1X0Bb+jVGR1APjJpfXtZD
         1GWznh0ZEeQkSOPtWBHJM3b3zwqO+n6tUQaYWSWNUwLWm0+PAaI1ooow9FWkENUow2At
         HbBICEJVdFfszyoMKS6GHpkglzIfW8knjXi7c6L7pLuLwLsiOs+AdUkdu/Sugyb3DrnK
         33EYZaq7FlquURV5ZKFYnZWmdN9Bcqf1qJ4oKLHxYhE2ecCFvGFzK5eRhylmnOLLXoNF
         5lzvkU1T+qVcel5YtGr5A0td/tTFYgRoLuItbfGvjICxj0PBG0zmWOQyyfLaHtN13ghy
         PKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wV6Ly4OTVMIHuO3QgeFv/pV+xSUgjDASQ2+fZhKE0+w=;
        b=H07a/3aT5eoP891zVCaD65/qNl3KNYosR8zCp4eddd7ugNzPwtNSYlswn7O4Uzdza+
         RV+SEkavhoU0JMB/81Eg8ApYbK3jwBe8eGyiBcI0qYTz8NRbKRmU9zBsMSYGtq0H+HAp
         ItkTtGwYgf0aPTVniHZvMbV4PpZ0yW/mcLjI/yfWg+IuikgkKm7TCbRU/sn/dj/UaPsn
         MpSobFES5UHpPpERmnsnurWXaFPEDHDDPvBSv0VIeFjCTnF/eUEnsvATDcrvWwtKqaq6
         wLDmhwhDT8fPuj/cWZ6idKlrK0wss68twcPbobHBNfNM3LroEDVjnwDpIdkrMlAH8aUZ
         z/aA==
X-Gm-Message-State: AOAM5335x1ERLd9NeuWt6MON97MBqQ42txE+gK9jZ2pKUtKxX/YKPNyq
        4egh+YQB7/cod3CN7ZyTteXimg0i4pct00t9
X-Google-Smtp-Source: ABdhPJzP8QkebpLumvWNek0wptLkNxKJKP5M8iwRa97pDBpiEMCZ6DJAVA0MWItt8ZuCfpPOuMyvcQ==
X-Received: by 2002:a2e:8350:: with SMTP id l16mr698947ljh.128.1604405385766;
        Tue, 03 Nov 2020 04:09:45 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id p18sm4155723ljn.127.2020.11.03.04.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 04:09:45 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: btbcm: Rewrite bindings i YAML and add reset
Date:   Tue,  3 Nov 2020 13:09:42 +0100
Message-Id: <20201103120943.1289277-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This rewrites the Broadcom bluetooth bindings in YAML and
adds a GPIO handle for the BT_RST_N line as used on some
platforms.

Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/net/broadcom-bluetooth.txt       |  56 ---------
 .../bindings/net/broadcom-bluetooth.yaml      | 117 ++++++++++++++++++
 2 files changed, 117 insertions(+), 56 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
 create mode 100644 Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml

diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
deleted file mode 100644
index a7d57ba5f2ac..000000000000
--- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
+++ /dev/null
@@ -1,56 +0,0 @@
-Broadcom Bluetooth Chips
----------------------
-
-This documents the binding structure and common properties for serial
-attached Broadcom devices.
-
-Serial attached Broadcom devices shall be a child node of the host UART
-device the slave device is attached to.
-
-Required properties:
-
- - compatible: should contain one of the following:
-   * "brcm,bcm20702a1"
-   * "brcm,bcm4329-bt"
-   * "brcm,bcm4330-bt"
-   * "brcm,bcm43438-bt"
-   * "brcm,bcm4345c5"
-   * "brcm,bcm43540-bt"
-   * "brcm,bcm4335a0"
-
-Optional properties:
-
- - max-speed: see Documentation/devicetree/bindings/serial/serial.yaml
- - shutdown-gpios: GPIO specifier, used to enable the BT module
- - device-wakeup-gpios: GPIO specifier, used to wakeup the controller
- - host-wakeup-gpios: GPIO specifier, used to wakeup the host processor.
-                      deprecated, replaced by interrupts and
-                      "host-wakeup" interrupt-names
- - clocks: 1 or 2 clocks as defined in clock-names below, in that order
- - clock-names: names for clock inputs, matching the clocks given
-   - "extclk": deprecated, replaced by "txco"
-   - "txco": external reference clock (not a standalone crystal)
-   - "lpo": external low power 32.768 kHz clock
- - vbat-supply: phandle to regulator supply for VBAT
- - vddio-supply: phandle to regulator supply for VDDIO
- - brcm,bt-pcm-int-params: configure PCM parameters via a 5-byte array
-    - sco-routing: 0 = PCM, 1 = Transport, 2 = Codec, 3 = I2S
-    - pcm-interface-rate: 128KBps, 256KBps, 512KBps, 1024KBps, 2048KBps
-    - pcm-frame-type: short, long
-    - pcm-sync-mode: slave, master
-    - pcm-clock-mode: slave, master
- - interrupts: must be one, used to wakeup the host processor
- - interrupt-names: must be "host-wakeup"
-
-Example:
-
-&uart2 {
-       pinctrl-names = "default";
-       pinctrl-0 = <&uart2_pins>;
-
-       bluetooth {
-               compatible = "brcm,bcm43438-bt";
-               max-speed = <921600>;
-               brcm,bt-pcm-int-params = [01 02 00 01 01];
-       };
-};
diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml b/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
new file mode 100644
index 000000000000..bdd6ca617e23
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
@@ -0,0 +1,117 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/broadcom-bluetooth.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom Bluetooth Chips
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description:
+  This binding describes Broadcom UART-attached bluetooth chips.
+
+properties:
+  compatible:
+    enum:
+      - brcm,bcm20702a1
+      - brcm,bcm4329-bt
+      - brcm,bcm4330-bt
+      - brcm,bcm43438-bt
+      - brcm,bcm4345c5
+      - brcm,bcm43540-bt
+      - brcm,bcm4335a0
+
+  shutdown-gpios:
+    maxItems: 1
+    description: GPIO specifier for the line BT_REG_ON used to
+      power on the BT module
+
+  reset-gpios:
+    maxItems: 1
+    description: GPIO specifier for the line BT_RST_N used to
+      reset the BT module. This should be marked as
+      GPIO_ACTIVE_LOW.
+
+  device-wakeup-gpios:
+    maxItems: 1
+    description: GPIO specifier for the line BT_WAKE used to
+      wakeup the controller. This is using the BT_GPIO_0
+      pin on the chip when in use.
+
+  host-wakeup-gpios:
+    maxItems: 1
+    deprecated: true
+    description: GPIO specifier for the line HOST_WAKE used
+      to wakeup the host processor. This is using he BT_GPIO_1
+      pin on the chip when in use. This is deprecated and replaced
+      by interrupts and "host-wakeup" interrupt-names
+
+  clocks:
+    maxItems: 2
+    description: 1 or 2 clocks as defined in clock-names below,
+      in that order
+
+  clock-names:
+    description: Names of the 1 to 2 supplied clocks
+    items:
+      - const: txco
+      - const: lpo
+      - const: extclk
+
+  vbat-supply:
+    description: phandle to regulator supply for VBAT
+
+  vddio-supply:
+    description: phandle to regulator supply for VDDIO
+
+  brcm,bt-pcm-int-params:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    minItems: 5
+    maxItems: 5
+    description: |-
+      configure PCM parameters via a 5-byte array:
+       sco-routing: 0 = PCM, 1 = Transport, 2 = Codec, 3 = I2S
+       pcm-interface-rate: 128KBps, 256KBps, 512KBps, 1024KBps, 2048KBps
+       pcm-frame-type: short, long
+       pcm-sync-mode: slave, master
+       pcm-clock-mode: slave, master
+
+  interrupts:
+    items:
+      - description: Handle to the line HOST_WAKE used to wake
+          up the host processor. This uses the BT_GPIO_1 pin on
+          the chip when in use.
+
+  interrupt-names:
+    items:
+      - const: host-wakeup
+
+  max-speed: true
+  current-speed: true
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    uart {
+        uart-has-rtscts;
+
+        bluetooth {
+            compatible = "brcm,bcm4330-bt";
+            max-speed = <921600>;
+            brcm,bt-pcm-int-params = [01 02 00 01 01];
+            shutdown-gpios = <&gpio 30 GPIO_ACTIVE_HIGH>;
+            device-wakeup-gpios = <&gpio 7 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&gpio 9 GPIO_ACTIVE_LOW>;
+            interrupt-parent = <&gpio>;
+            interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };
-- 
2.26.2

