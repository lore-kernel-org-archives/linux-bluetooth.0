Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD79EC6FA86
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Sep 2022 14:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiIXOXK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 24 Sep 2022 10:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiIXOXJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 24 Sep 2022 10:23:09 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4941CA99E8;
        Sat, 24 Sep 2022 07:23:07 -0700 (PDT)
Received: from g550jk.fritz.box (212095005231.public.telering.at [212.95.5.231])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 0F805C0C33;
        Sat, 24 Sep 2022 14:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1664029354; bh=EGEQk47etgfby3MwL6kaa8c9zClOyk0rfXJQBVnRfuY=;
        h=From:To:Cc:Subject:Date;
        b=VZ5wqPcZE4+SfBOG0OM16NIYFKR4E/+cW4l/zf9vcJqGOQ731chJhl6+Im1rMNAKy
         /vWt+hdLvUpHgRfIO3cpA2ZTppnP/N/xNO7aPqXwNxuoAf064x5KRctamZ2E8mS76I
         UHuXhbo/9kKMOU7YaZWfxbfhHC3/Ytou+Vy8Gg8o=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-bluetooth@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: bluetooth: broadcom: add BCM43430A0 & BCM43430A1
Date:   Sat, 24 Sep 2022 16:21:55 +0200
Message-Id: <20220924142154.14217-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Document the compatible string for BCM43430A0 bluetooth used in lg-lenok
and BCM43430A1 used in asus-sparrow.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v3:
* pick up tags
* resend

 Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml b/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
index 445b2a553625..d8d56076d656 100644
--- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml
@@ -19,6 +19,8 @@ properties:
       - brcm,bcm4329-bt
       - brcm,bcm4330-bt
       - brcm,bcm4334-bt
+      - brcm,bcm43430a0-bt
+      - brcm,bcm43430a1-bt
       - brcm,bcm43438-bt
       - brcm,bcm4345c5
       - brcm,bcm43540-bt
-- 
2.37.3

