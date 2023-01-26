Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E1CC61DA2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Jan 2023 16:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjAZQzj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Jan 2023 11:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjAZQzh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Jan 2023 11:55:37 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755DFCA16;
        Thu, 26 Jan 2023 08:55:36 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id f5-20020a9d5f05000000b00684c0c2eb3fso1037883oti.10;
        Thu, 26 Jan 2023 08:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2nhNJaNx4EjGYsesf7ElG2aqGx6cZUw+y/n9VNwAGo=;
        b=OD5v0d3VrjUDOEYFXI8PFPMRb9ymMpdJp6f7QOiMzF4msuipz/296w38iqC8p0tecl
         X5kZD+4ZxYVX0Xz/4bybAiisX+5N0L/ldO1m6AxtISf+tvCVhn+JmTqU07VBhTnnTI0X
         qh0yEKRpmOuRBc1xhSFcaqz68Mx+0Lo88oeotshrXjbS9g15aiPYktz37jsvQE6dpYLm
         3DDUKXGlXo7Eq5QHvl8b8My5I1ohI0MqKPoYrb7Lrmyt6QQ0KZwEyoxMOfF4QNHNpSeg
         e4cXxRmr/sprP3jUPJVr5JW7sct8WWi2oz8/p4NWH8GcwzCwJlBymvKCGj8Grv/ZQ1/i
         rXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2nhNJaNx4EjGYsesf7ElG2aqGx6cZUw+y/n9VNwAGo=;
        b=sgl0WOAYrhZNw5YhoRuHqnpGC+/Fh/nwvU+1p2wmRLvM6Q+2eD7OzWwTn7yV8NVpYE
         bTa7xRKcOd65DV9Z2mcRwpX6wyybjmYuk6T9+M+5k5i1nvZyAAgGEgXmZEoBl30lO1lo
         WHh9X9RnQ5D0tyKg0unqiQeT6Y2xU1X88aeay6qk2B+eBjVOq5ooylyOxsRNi/48O2ug
         RUUS+Is6MS7n8X7/lgxcAwa3e2dKof7NgA3UcjJSEoM+tH2d5wOOSa+xVPIhArUttq/m
         7h8LYEcTS49CEwG6XowugZMQK4NPJeAA53spqjRH027NTnnHfA32FWHuEcSB3ChKNA3y
         DrQA==
X-Gm-Message-State: AFqh2koHjmBBu8Trtoui7u4gu7GzV2UfxNvhM67EQbaAxqYQUanVJr2Y
        WfHlia7ATU/r1TSPBImXOmplN9QKOO4=
X-Google-Smtp-Source: AMrXdXv3EOgeBhUyc3iDIgqocijKwXJmo2M1s/1DaLCkTKMfy3Ri+QVZx6a7GC2zyF4p+PtFXJslJw==
X-Received: by 2002:a05:6830:11cc:b0:686:8a1b:cc4c with SMTP id v12-20020a05683011cc00b006868a1bcc4cmr14231510otq.0.1674752135725;
        Thu, 26 Jan 2023 08:55:35 -0800 (PST)
Received: from localhost.localdomain (76-244-6-13.lightspeed.rcsntx.sbcglobal.net. [76.244.6.13])
        by smtp.gmail.com with ESMTPSA id r10-20020a056830120a00b0066eab2ec808sm694798otp.1.2023.01.26.08.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 08:55:35 -0800 (PST)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devicetree@vger.kernel.org, alistair@alistair23.me,
        anarsoul@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, marcel@holtmann.org, johan.hedberg@gmail.com,
        luiz.dentz@gmail.com, max.chou@realtek.com, hildawu@realtek.com,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH RFC 1/2] dt-bindings: net: realtek-bluetooth: Add RTL8821CS
Date:   Thu, 26 Jan 2023 10:55:28 -0600
Message-Id: <20230126165529.1452252-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230126165529.1452252-1-macroalpha82@gmail.com>
References: <20230126165529.1452252-1-macroalpha82@gmail.com>
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
 Documentation/devicetree/bindings/net/realtek-bluetooth.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml b/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
index 143b5667abad..5af4731338c0 100644
--- a/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/realtek-bluetooth.yaml
@@ -21,6 +21,7 @@ properties:
       - realtek,rtl8723bs-bt
       - realtek,rtl8723cs-bt
       - realtek,rtl8723ds-bt
+      - realtek,rtl8821cs-bt
       - realtek,rtl8822cs-bt
 
   device-wake-gpios:
-- 
2.34.1

