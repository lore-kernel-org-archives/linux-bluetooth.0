Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935C5C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Mar 2023 17:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjCORhH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Mar 2023 13:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCORhG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Mar 2023 13:37:06 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E1723300;
        Wed, 15 Mar 2023 10:37:05 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id d22-20020a9d5e16000000b0069b5252ced7so828309oti.13;
        Wed, 15 Mar 2023 10:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678901824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQsibjwoLRXCJBBiCNwIELq0yYn7Rphfllokp35YPhM=;
        b=dbbbo1zkyDl2vUAlk7x12kg3a9JNjsRkLmMZfYgrJhI2x2mu2CGdG/iZJIS46+Dyq1
         bZhW17/cTtkTLXhBYn1jnwlSprKhOHKQze6By7EJxe5WHH/UgD3jmgA5B+T8hZvDfaoQ
         xx/jejf1CAC4C+yUZedRrO/Kvl6uYnQpxFRpB70kXu+pf4wEgOke6CQou50HBXTRW/2S
         7y4Sxp2AswnPlCHrLBAZmYTsAOsmotsLhrN2Ct0ANMHOSBAWD9GIY1oMzMefoucw4uwz
         DE5Gtk0bpL+62ByVaPC55j6dJQwowRRhC4Qn8l4nNv5B+VqO94AVF+SmdLI2wQpr/BbG
         55Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678901824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQsibjwoLRXCJBBiCNwIELq0yYn7Rphfllokp35YPhM=;
        b=Ixcw7yOsgfgptPM9EBUMLWicPPwzZ13st6eaL8/l/9717/LizyKmA5dzaYr9fev4id
         6LO/bTSBdWLdZcYhxkilVbOHlvbIVhia4VAgVlnVPRyjJpO7c8nBmp/5WQm/K9MnysTe
         6eH1o77sDGQyv83l0xFuLmknVJN8JcUrOB6YzudGU6NQ/XdO1pywn+8RR+XMspW/iOZC
         3T3whtTmIXDCa7qCuW7pdyhAsL1VB/0J13nCplt2tY7nI7i6Vd5dqV54s8nLTxZ55HMC
         Kx3Xpa/a2tD9sK2LPk4A7PFHgoZ8YXCregBnfJ1+bkI4eYvr7jBgH3ypACUxxTKHTZ+R
         Q9PQ==
X-Gm-Message-State: AO0yUKUu0l4+wWFQ21VbfbZY86hgZf2lKBvP7si2T7Jk+xGsv51Tfz+T
        kiHyGI9qI/OJcS51fmMptT1VtEWPivk=
X-Google-Smtp-Source: AK7set/d0UBs6z8jXZJOU7WorYGwNKFayanHAXK1jdGZCV+f+2KnVx/L9+n2sUofgr62DhmkECLWPg==
X-Received: by 2002:a05:6830:576:b0:699:45ab:52f7 with SMTP id f22-20020a056830057600b0069945ab52f7mr2083030otc.14.1678901824330;
        Wed, 15 Mar 2023 10:37:04 -0700 (PDT)
Received: from localhost.localdomain (76-244-6-13.lightspeed.rcsntx.sbcglobal.net. [76.244.6.13])
        by smtp.gmail.com with ESMTPSA id a23-20020a9d3e17000000b0068abc8e786fsm2562044otd.10.2023.03.15.10.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 10:37:04 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        alistair@alistair23.me, anarsoul@gmail.com, luiz.dentz@gmail.com,
        johan.hedberg@gmail.com, marcel@holtmann.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 1/3 V5] dt-bindings: net: realtek-bluetooth: Add RTL8821CS
Date:   Wed, 15 Mar 2023 12:36:55 -0500
Message-Id: <20230315173657.28692-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315173657.28692-1-macroalpha82@gmail.com>
References: <20230315173657.28692-1-macroalpha82@gmail.com>
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
index 143b5667abad..506ea9b17668 100644
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
+          - const: realtek,rtl8723bs-bt
 
   device-wake-gpios:
     maxItems: 1
-- 
2.34.1

