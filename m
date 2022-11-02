Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A122EC4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Nov 2022 16:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbiKBQt2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Nov 2022 12:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiKBQtL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Nov 2022 12:49:11 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF06205C6;
        Wed,  2 Nov 2022 09:47:25 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id D167F8503A;
        Wed,  2 Nov 2022 17:47:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1667407643;
        bh=zZK8b+WEl44ryH/vzEeeFlr2BW5xUck1u3VSwxfIrEg=;
        h=From:To:Cc:Subject:Date:From;
        b=lPhw6E/0E0fGPtt4mCG9jHIEIvW2sFhvPstrylcrzGu3Ow/gowkfwhE/IM4jIX6Wi
         7FNpiPBEfFBFZG/pkqSg8fqj39EAKH9b0K1s3Yar93kubhsXpesJI+SgZEG1k3HG/x
         FRfucf3a6Mn6oWatA0pFRlYwuuNZcIKqD6zln3UPa5beeG/CREGx8GdJnEqvbiK3R7
         4PT1mzGxmlWAgqfUBY/rQ3JucLLAeXYB6NO1iNW5GuAx1PduKmSnNIy00No87qk3vw
         Q+PFTIlPLYWcFn6Bdmtwr6ckngu4+f9/1TTveUfYzsh+LYb3NHLOslNOrAoo/RM0KJ
         NFdmGOjOGBSxg==
From:   Marek Vasut <marex@denx.de>
To:     linux-bluetooth@vger.kernel.org
Cc:     pbrobinson@gmail.com, Marek Vasut <marex@denx.de>,
        Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hakan Jansson <hakan.jansson@infineon.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: net: broadcom-bluetooth: Add CYW4373A0 DT binding
Date:   Wed,  2 Nov 2022 17:47:04 +0100
Message-Id: <20221102164705.14538-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

CYW4373A0 is a Wi-Fi + Bluetooth combo device from Cypress.
This chip is present e.g. on muRata 2AE module. Extend the
binding with its DT compatible.

Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Hakan Jansson <hakan.jansson@infineon.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
To: linux-bluetooth@vger.kernel.org
---
V2: - Add RB from Linus
    - Add AB from Rob
---
 Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml b/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
index 445b2a5536259..e0c8abc274134 100644
--- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
@@ -24,6 +24,7 @@ properties:
       - brcm,bcm43540-bt
       - brcm,bcm4335a0
       - brcm,bcm4349-bt
+      - cypress,cyw4373a0-bt
       - infineon,cyw55572-bt
 
   shutdown-gpios:
-- 
2.35.1

