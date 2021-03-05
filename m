Return-Path: <SRS0=2LFz=ID=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66A9C433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 18:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FB6664EEE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 18:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhCESjr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Mar 2021 13:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhCEShk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Mar 2021 13:37:40 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6816C061756
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Mar 2021 10:37:39 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id z11so5227875lfb.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Mar 2021 10:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/bUlq/wPF3yJYJShp7VG2mRZDBWcT8EiKpB3if3AI6c=;
        b=vyJcEoVKHnVIlXU3QVkMKljvyvfYOTgX8mO06rqy+CaMtP+6ytqA/t/nBbWcJLSHLs
         cjdIngnDqEN00+ykNDyLiZhm2eo6cwPgSQrD/kB/BM9AoJx6UCb3HvIlgOd9EGVsgewl
         Pe6v3KEEbs0VG0gu6nmhB+3RWnrgOFunALUVBseHJ3gMk9/JG7N+r2hFfM8oY8/0z/K1
         kOSr3ckbONAKVh3bQy4KwLONzpHQGuNB1KurFLFd+9L3PbMYHf0fTvCpDjEVo+dfK/+s
         sPYC8H+WGJ7/xqK6mL+dEDqvxpUer+BBok0D0FPuwMxc/OZd/opK6KFhami6G9PqlTV+
         jBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/bUlq/wPF3yJYJShp7VG2mRZDBWcT8EiKpB3if3AI6c=;
        b=B+0gsAbNiZ81TbZ5pWumie/4X0IwHYbNFjegrUIABSRgIoCyTKhqBM5gz4TFu2LBi5
         477Elwqb9mu/E6T82zez/32aWgY5dhX9kgUIDD76fxI/gNMou639p56UUqVbi99qPxHj
         pz6aJ7qBHV5kc86xEmmLPkgZ62b/BVlRYWjx/6GmnMCF/a2YOjyKlgJ6gwkJBLmh5sZ/
         xSSwKXIaU7164G/1btrLAP5nRN7BUzcnAEe5aPg055kf8X5m/MBqq7OPTC+jFq8/3bpp
         e7ZbkMq/0B3RJD34ZLZk05ftOSDbYOylPlo0AAPSekwbH3qE7i52EKCW0ObOhj4Pt3cd
         +ppg==
X-Gm-Message-State: AOAM530qvyip/pO3+RUhqnWrJqLuppIn7opfC79mUSFQIvYx+9MWWYVA
        2jUloWhifm08bBCGDoKzCQ8uTg==
X-Google-Smtp-Source: ABdhPJzm7+WAI1pCsVfTV6gTabWD8HHIj3+AWaEZgNghLia5kOKkE5VvphxGiSb294nomX2AWIw19A==
X-Received: by 2002:a05:6512:303:: with SMTP id t3mr6436550lfp.196.1614969458136;
        Fri, 05 Mar 2021 10:37:38 -0800 (PST)
Received: from localhost.localdomain (c-d7cb225c.014-348-6c756e10.bbcust.telenor.se. [92.34.203.215])
        by smtp.gmail.com with ESMTPSA id o16sm400374lfo.166.2021.03.05.10.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 10:37:37 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org
Subject: [PATCH 1/2 v3] Bluetooth: btbcm: Rewrite bindings in YAML and add reset
Date:   Fri,  5 Mar 2021 19:37:35 +0100
Message-Id: <20210305183736.2123083-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This rewrites the Broadcom bluetooth bindings in YAML and
adds a GPIO handle for the BT_RST_N line as used on some
platforms.

The Ingenic UART binding was using this binding in its
example DTS fragment, however mistakenly using "vcc-supply"
for what is called "vbat-supply". The proper DTS files
and the code in the kernel all use "vbat-supply" so
fix up the example in this patch so we ge a clean
check.

Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Actually fold in the required fix.
ChangeLog v1->v2:
- Fix the error in the Ingenic UART binding example as
  part of adding this patch.
---
 .../bindings/net/broadcom-bluetooth.txt       |  56 ---------
 .../bindings/net/broadcom-bluetooth.yaml      | 117 ++++++++++++++++++
 .../bindings/serial/ingenic,uart.yaml         |   2 +-
 3 files changed, 118 insertions(+), 57 deletions(-)
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
diff --git a/Documentation/devicetree/bindings/serial/ingenic,uart.yaml b/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
index 559213899d73..7748d8c3bab8 100644
--- a/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/ingenic,uart.yaml
@@ -91,7 +91,7 @@ examples:
       bluetooth {
         compatible = "brcm,bcm4330-bt";
         reset-gpios = <&gpf 8 GPIO_ACTIVE_HIGH>;
-        vcc-supply = <&wlan0_power>;
+        vbat-supply = <&wlan0_power>;
         device-wakeup-gpios = <&gpf 5 GPIO_ACTIVE_HIGH>;
         host-wakeup-gpios = <&gpf 6 GPIO_ACTIVE_HIGH>;
         shutdown-gpios = <&gpf 4 GPIO_ACTIVE_LOW>;
-- 
2.29.2

