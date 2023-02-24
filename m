Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA7CC6FA8E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Feb 2023 23:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjBXXYG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Feb 2023 18:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjBXXYE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Feb 2023 18:24:04 -0500
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985EC231D4;
        Fri, 24 Feb 2023 15:23:47 -0800 (PST)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-17213c961dfso1371993fac.0;
        Fri, 24 Feb 2023 15:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALnkpz8ALlNTqOsurEtcPehgpRmTbr/BEiX5U4d+ylg=;
        b=EtSwvEl4wHMAYWoOnr6OlfOCj5VIPJX9tUA9ATsc/F2ZYx/XAT4GO+z2GEbdbXBCCB
         39uvCsULlJmHlGFJfk/YSR7DLC/htqkS3lhAzFHPrj7EZXGP/ZBXFz3nkie2ACMFthPZ
         gPb+5BXzNxhe4RBPCx+2GyyM0WLgNk5yxKPhy9lGuHq0i3h2sbfqQKQwF6up7b7Af7A5
         YGOBheos3F9B/Tdh9M1YL7Kqaw33eUP3JDsSTK1JmaI6RFgKbO8rnC/A9HDfEYLroWCH
         DKGKUBMeEC+McM+hsbrkAsy4gWqvQ+htRAgV8eqAnmgtM+Ig3d7QYq4kRZ/wwFIRYPKp
         iqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALnkpz8ALlNTqOsurEtcPehgpRmTbr/BEiX5U4d+ylg=;
        b=GxiPdt1alf1e1jOwLqEp1KgX7k3Cx5/x6XfLeB2o7nNX1E6BwQO8bfdhNOJbt9W0W3
         aIue1J0/ZuF2BHqOiDVcGiVujHu8czAp5sJCJqYm4NSBpna1bWXfi0yh71xrX1tXAtZg
         tc8t4EEGRfZ4mZm8FXOaXeTVxOSXs4SvikaqHa+991lNJNoyJS8647svSen5a8YwAkrX
         DGNiWGHSWKQGu1sOmL4wvb8S11dJLRftcmrxGc9PAq1QfYElOFwZ9dt6Ucau5ANS1adI
         K1atfTyf/MJok22qJer04il5BJdD54RGoOBBqY70KldnAdwLt77iLAk+I7EsXknaNdv+
         gs8g==
X-Gm-Message-State: AO0yUKWg9cSjdYhOQ9Hzj7glwHZEwavn2eOvS3CpdT4hCt9kEynafk9L
        2tmO39hNbiy+r0fYpFiavxRA0qCICgQ=
X-Google-Smtp-Source: AK7set+4l2GHkhtxjGmZf4wArC1qwF3lZiAbvPIz0e1IHuhEpBXL8gPl73rsRn2bqElTB3K4PyIQqA==
X-Received: by 2002:a05:6870:a54b:b0:172:21e9:21c7 with SMTP id p11-20020a056870a54b00b0017221e921c7mr8946638oal.40.1677281026056;
        Fri, 24 Feb 2023 15:23:46 -0800 (PST)
Received: from localhost.localdomain (76-244-6-13.lightspeed.rcsntx.sbcglobal.net. [76.244.6.13])
        by smtp.gmail.com with ESMTPSA id k22-20020a056870d39600b0016b0369f08fsm119706oag.15.2023.02.24.15.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 15:23:45 -0800 (PST)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        alistair@alistair23.me, anarsoul@gmail.com, luiz.dentz@gmail.com,
        johan.hedberg@gmail.com, marcel@holtmann.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 1/3 V2] dt-bindings: net: realtek-bluetooth: Add RTL8821CS
Date:   Fri, 24 Feb 2023 17:23:37 -0600
Message-Id: <20230224232339.124969-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230224232339.124969-1-macroalpha82@gmail.com>
References: <20230224232339.124969-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Add compatible string for RTL8821CS for existing Realtek Bluetooth
driver.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../bindings/net/realtek-bluetooth.yaml       | 23 +++++++++++--------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml b/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
index 143b5667abad..f91d06d629b9 100644
--- a/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
@@ -4,24 +4,29 @@
 $id: http://devicetree.org/schemas/net/realtek-bluetooth.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: RTL8723BS/RTL8723CS/RTL8822CS Bluetooth
+title: RTL8723BS/RTL8723CS/RTL8821CS/RTL8822CS Bluetooth
 
 maintainers:
   - Vasily Khoruzhick <anarsoul@gmail.com>
   - Alistair Francis <alistair@alistair23.me>
 
 description:
-  RTL8723CS/RTL8723CS/RTL8822CS is WiFi + BT chip. WiFi part is connected over
-  SDIO, while BT is connected over serial. It speaks H5 protocol with few
-  extra commands to upload firmware and change module speed.
+  RTL8723CS/RTL8723CS/RTL8821CS/RTL8822CS is a WiFi + BT chip. WiFi part
+  is connected over SDIO, while BT is connected over serial. It speaks
+  H5 protocol with few extra commands to upload firmware and change
+  module speed.
 
 properties:
   compatible:
-    enum:
-      - realtek,rtl8723bs-bt
-      - realtek,rtl8723cs-bt
-      - realtek,rtl8723ds-bt
-      - realtek,rtl8822cs-bt
+    oneOf:
+      - const: realtek,rtl8723bs-bt
+      - const: realtek,rtl8723cs-bt
+      - const: realtek,rtl8723ds-bt
+      - const: realtek,rtl8822cs-bt
+      - items:
+          - enum:
+              - realtek,rtl8821cs-bt
+          - const: realtek,rtl8822cs-bt
 
   device-wake-gpios:
     maxItems: 1
-- 
2.34.1

