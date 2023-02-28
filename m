Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F01C7EE31
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Feb 2023 15:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjB1PWO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Feb 2023 10:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjB1PWM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Feb 2023 10:22:12 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266BE30B33;
        Tue, 28 Feb 2023 07:22:12 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1720600a5f0so11206546fac.11;
        Tue, 28 Feb 2023 07:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNwZxqp1M59lbObWhxH+qDHb6sQadQB3wcUdsvUzuDg=;
        b=boJodNHzF82rSDM7hSjyryImL1vLWP0H4Q4yv5ygE0dvjCuS3iyKMKUgNPVMR80U4e
         PbfweOHDwFQUW5tnTIzySam0pIaGIO4Pz7zDGky0ZCSiLoUOmg01C70qdLC7aWaN6Vrm
         lZeZSeb1b+CkTV/dA5FfVGpkCqQciTwFQq7dX9Pc5iPg2xJpDg4zaE4QdwrpUz84/+ga
         XbqeFnRZZqqlgGnUxpqT2ncYk5dcn/C428XV9fDeC3bpMZcgj55lbVqtNoQOHeZfmoqZ
         IfCnm49seyn1XMp3axRYgSgnBK5AQdqu0a6fU91uICbgfPd8JXBPk+Mzg3W1y4McAccA
         C2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNwZxqp1M59lbObWhxH+qDHb6sQadQB3wcUdsvUzuDg=;
        b=gaNhVxqMHQn4b0fUDpURfoSMZEk9VC780BfFifL5p9h1xCGvcFPgVova8kX35sl8so
         cAunaPJXHU3ksSLAX2F3Mtb6HX1Av31/yLDLFZtIBc0jigK2HyWIrw/oAsShZgnLbbAR
         dCj/dmZwT0cQFTiVhlLnBfQ5T50ONL6Ri/+FcOFJJFjFWVkvAZIrbKhh2uhk7vO28Iux
         /E6mQo5umOR2yftUn/HSqbYw/R5qbkgs8LOuei0mSVKFpwQ4Wj5G252MZBYgdiKjiwaZ
         JWtiynYmxbrcxXCcXMzsYFknVQu92IrIlt27wh3fkMZhlxCEAwoq7Crlp3TCGBUnH8GC
         6SiQ==
X-Gm-Message-State: AO0yUKUaSpkEaY+DiFW01KW/6aekSD5x2U8WwAUmdY9Jrw3Kmtliv4tF
        V3rew3w+YNu7AzAZLD5fKSE24vASqIc=
X-Google-Smtp-Source: AK7set9Y6B8ipvg8FwKex2pPzWjRmqyIyPVe8VjpBkfJ30VuzaGx0qO4maHeaaLWkEawdnj4S3/elg==
X-Received: by 2002:a05:6870:5826:b0:171:9676:8942 with SMTP id r38-20020a056870582600b0017196768942mr1635028oap.3.1677597731249;
        Tue, 28 Feb 2023 07:22:11 -0800 (PST)
Received: from localhost.localdomain (76-244-6-13.lightspeed.rcsntx.sbcglobal.net. [76.244.6.13])
        by smtp.gmail.com with ESMTPSA id yy23-20020a056871259700b0017264f96879sm3318321oab.17.2023.02.28.07.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 07:22:11 -0800 (PST)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        alistair@alistair23.me, anarsoul@gmail.com, luiz.dentz@gmail.com,
        johan.hedberg@gmail.com, marcel@holtmann.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 1/3 V4] dt-bindings: net: realtek-bluetooth: Add RTL8821CS
Date:   Tue, 28 Feb 2023 09:22:03 -0600
Message-Id: <20230228152205.133582-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228152205.133582-1-macroalpha82@gmail.com>
References: <20230228152205.133582-1-macroalpha82@gmail.com>
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
 .../bindings/net/realtek-bluetooth.yaml       | 24 ++++++++++++-------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml b/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
index 143b5667abad..8cc2b9924680 100644
--- a/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
@@ -4,24 +4,30 @@
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
+      - enum:
+          - realtek,rtl8723bs-bt
+          - realtek,rtl8723cs-bt
+          - realtek,rtl8723ds-bt
+          - realtek,rtl8822cs-bt
+      - items:
+          - enum:
+              - realtek,rtl8821cs-bt
+          - const: realtek,rtl8822cs-bt
 
   device-wake-gpios:
     maxItems: 1
-- 
2.34.1

