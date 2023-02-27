Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DAAC7EE36
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Feb 2023 16:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjB0Qaj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Feb 2023 11:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjB0Qag (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Feb 2023 11:30:36 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E1F1D935;
        Mon, 27 Feb 2023 08:30:35 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id bp19so2879407oib.4;
        Mon, 27 Feb 2023 08:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAWhW5/ZnWeHEgpd0MyQefc2epsEeOvOGaibb4+S/Vk=;
        b=qL2SUOx8PeNpTXVu+f52nmeJL6R8pZRkKLzh1AHBRTAMZai+ZekvT8aiIeb2q1FCcw
         yek2PZ3YHEmLYh8E1QI1zHldFcdY/+DZPIqcE1RTtJnqssm7utvIm7Ihi8RXGWVXHFrx
         rSLoc6MRKyArAb2q3BJJPwHFHo4FMrDxjuDYRWOtZR9zm4e5WD9jWMkCFLUoQF06sMvb
         hSYgt8ouMIVejwZy13CSoDh6pZzryPY6wEwuGv4/ZhyROc9gjJaAQn2FoNX3I9WCVD9i
         pd6BBBZ51/r5WNE6W+h9hVlz2KnxcaEhtW7Iy9nT690DeEUu8kl/jKTDz3hfdpd4fvP/
         RQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAWhW5/ZnWeHEgpd0MyQefc2epsEeOvOGaibb4+S/Vk=;
        b=aG5WDB3Oo/kOzF9ooV1OZsOS5MCzNx1qSeTKA9oTlLp6H2ktPGvy9aFxOob++DT9k5
         XVIl001cYXE9CigfNQgZjV/brXfSeR3b5A3vf1NObq2kyvuYkeIBgbYdS7QnLPnuLBo/
         17KwgEIuVaJM9ZZU4bS8+G2stevGyeoWcaQmCD66Ir0S+62jdfzdD9dXNJDz+jiofMOM
         Jk0rEjfSChvzfykUN7KdhWymYF1C840V8xcOsZD2n8H+MWO5gnJFF6YAkvFnKSh3KgAU
         GpeR1ypY9CZT/YaUfT57WIC77x35uTh9+tSsJ5wyYQHwDZHtP3Id9qJkg1d4sZuoa3Of
         R45A==
X-Gm-Message-State: AO0yUKXGDKv+9WqNFGNxkdd2+0GLknKl9oFxHn6sjFDyru12o5h9HZ6p
        D7rc07rFzaYeS+BHiupd5x5ms7A0lx4=
X-Google-Smtp-Source: AK7set8MAAPsyxbCcn+KGnghPgtS15u+x3K++bHUAQn4v6dHOQphWDyh24Fogc0pw/iteaRUlCRScA==
X-Received: by 2002:a05:6808:8ea:b0:37e:aa97:4660 with SMTP id d10-20020a05680808ea00b0037eaa974660mr12136016oic.16.1677515433231;
        Mon, 27 Feb 2023 08:30:33 -0800 (PST)
Received: from localhost.localdomain (76-244-6-13.lightspeed.rcsntx.sbcglobal.net. [76.244.6.13])
        by smtp.gmail.com with ESMTPSA id ex16-20020a056808299000b0037fcc1fd34bsm3267713oib.13.2023.02.27.08.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 08:30:32 -0800 (PST)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        alistair@alistair23.me, anarsoul@gmail.com, luiz.dentz@gmail.com,
        johan.hedberg@gmail.com, marcel@holtmann.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 1/3 V3] dt-bindings: net: realtek-bluetooth: Add RTL8821CS
Date:   Mon, 27 Feb 2023 10:30:25 -0600
Message-Id: <20230227163027.130292-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230227163027.130292-1-macroalpha82@gmail.com>
References: <20230227163027.130292-1-macroalpha82@gmail.com>
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
 .../bindings/net/realtek-bluetooth.yaml       | 25 ++++++++++++-------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml b/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
index 143b5667abad..198c5dd1f257 100644
--- a/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
@@ -4,24 +4,31 @@
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
+      - items:
+          - enum:
+              - realtek,rtl8723bs-bt
+              - realtek,rtl8723cs-bt
+              - realtek,rtl8723ds-bt
+              - realtek,rtl8822cs-bt
+      - items:
+          - enum:
+              - realtek,rtl8821cs-bt
+          - const: realtek,rtl8822cs-bt
 
   device-wake-gpios:
     maxItems: 1
-- 
2.34.1

