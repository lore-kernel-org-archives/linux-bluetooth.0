Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C240DFA3745
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Oct 2022 20:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiJaUsT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Oct 2022 16:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiJaUsS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Oct 2022 16:48:18 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B247714007;
        Mon, 31 Oct 2022 13:48:17 -0700 (PDT)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id D575F850A1;
        Mon, 31 Oct 2022 21:48:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1667249295;
        bh=y3Jchs1x7msEIlsNuDfvU2xuhQ7bXPuYVZ5BM8fZcAM=;
        h=From:To:Cc:Subject:Date:From;
        b=AJdCjggYBybTPye8VrNRjih5pVJaMmnuCz68VtWmimo5fhOb71fhwv0CkYuRj6JTD
         XkIySMqhJ2nbGQjGVNeOLnMjbViIg2Lp2b6rPQY3miSUcEWUfnzlIqL+mhIrDovAwx
         f7bFY+YbtI+ei7Dy0V2LQ0npL/C+xQ0/JoL2y/ZWrwrOGD0qvJ2Qkl+HQOHnOyWokF
         sDhzffo/qS34U0yvC+fkEfjNF83D2CSQRGv0m8YTB8P9J1PAp/2zGrELolMa/9ouG0
         LZSxLLksiJmiLM2ikMtiVodLBRjInRA5eCxywZD2ukB8KP2gaWhVpilsUlrev7whGx
         yp/qH/KMDNfZw==
From:   Marek Vasut <marex@denx.de>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>,
        Hakan Jansson <hakan.jansson@infineon.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: net: broadcom-bluetooth: Add CYW4373A0 DT binding
Date:   Mon, 31 Oct 2022 21:48:03 +0100
Message-Id: <20221031204804.195267-1-marex@denx.de>
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

