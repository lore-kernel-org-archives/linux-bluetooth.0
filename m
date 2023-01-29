Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF91FC54EED
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Jan 2023 21:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbjA2VwU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 29 Jan 2023 16:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbjA2VwR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 29 Jan 2023 16:52:17 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD78B20066
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Jan 2023 13:51:56 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-15eec491b40so12944219fac.12
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Jan 2023 13:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfpsJ7xIad5mBx7YraXTgyoeHT6w8su2AuDVdY0UXWo=;
        b=j0pBhYFl97wnX+HJ0bvZJIwWPimtiK0Jd1t9AmlXylr5FnNjBaWgRustN+UiH5QIca
         /bJsoVapWyyMpWfZb8ClIqt5CyR7yB3bIieAXqKbRXSYkks87mtlx3Zecv+p2j2ACx4g
         uDcSu1X3kd+S9A/1YOGmqid9oXkLc07r5luX8PozNQwlmckFmMT12mhGZhVKF6/IADzt
         ZXeGrJFEWkyqdmx91hEqAnDK/Oc1HnPNZdqBeqZvJF5sLbhRuNBh55Bk5aH8tYrczBjJ
         JY1zOTQ4Az4SYHAp2sxkQjQomGFbMGcUlgpY098tpXs53cGb71qsSpZYE5hfnbsSG4jr
         AFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfpsJ7xIad5mBx7YraXTgyoeHT6w8su2AuDVdY0UXWo=;
        b=Nao8eLueLYANKavqijR6vqkGpYh5rF8KytjiHSzgUxNIWhlK6JphxOnQkQcrZfvPH6
         z7bAcwpRhGaGNpeEkk8DZLCX1+QteM4YV+cj0Ix3xXmouUlkie7K9s8zQodN3vA0tR7t
         bf/7M/ePKQvRuqLCEjKTjqVNaMt0OkW62zuElIYQkFNNEB/VeWrRpcK7MYXTEN9gsJgY
         f2Y417w9XiZ6FNzDI/botzBanv1wgsu6RKqUSELciNqFx4AzdHEdJBDlV3kMHNwZ1jhR
         iiWC2Cble3ot7c/ErcxP6FHXfU3XAwD8xfl9Rrd1hfLm/qAS5yLxpEzobIyjJGEwqHQl
         Ql8w==
X-Gm-Message-State: AFqh2ko3ZvtbC68HKKGrPfJ79tA81uWYGpAl7SqjWo9CyIqXc/PtxIpB
        lPZgQfI0lvlb8bwHvgMKBnV2Fg==
X-Google-Smtp-Source: AMrXdXsIsxNguixouvunGvkwujT0GjwMcNzeVrDif1K+1TM+Af9HxNoqBmJKe0D/GV5l/wbv+ab98Q==
X-Received: by 2002:a05:6870:9c8f:b0:15f:5ccb:d294 with SMTP id pq15-20020a0568709c8f00b0015f5ccbd294mr18771707oab.34.1675029114714;
        Sun, 29 Jan 2023 13:51:54 -0800 (PST)
Received: from localhost (23-118-233-243.lightspeed.snantx.sbcglobal.net. [23.118.233.243])
        by smtp.gmail.com with ESMTPSA id mt14-20020a0568706b0e00b0014ff15936casm4467795oab.40.2023.01.29.13.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 13:51:54 -0800 (PST)
From:   Steev Klimaszewski <steev@kali.org>
To:     steev@kali.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Sven Peter <sven@svenpeter.dev>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 3/4] arm64: dts: qcom: sc8280xp: Enable BT
Date:   Sun, 29 Jan 2023 15:51:29 -0600
Message-Id: <20230129215136.5557-4-steev@kali.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230129215136.5557-3-steev@kali.org>
References: <20230129215136.5557-1-steev@kali.org>
 <20230129215136.5557-2-steev@kali.org>
 <20230129215136.5557-3-steev@kali.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 122afa03bb40..2d98687fb1ea 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1244,6 +1244,20 @@ spi3: spi@98c000 {
 				status = "disabled";
 			};
 
+			uart2: serial@988000 {
+				compatible = "qcom,geni-uart";
+				reg = <0 0x00988000 0 0x4000>;
+				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				clock-names = "se";
+				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
+				operating-points-v2 = <&qup_opp_table_100mhz>;
+				power-domains = <&rpmhpd SC8280XP_CX>;
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 0 &clk_virt SLAVE_QUP_CORE_0 0>,
+						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_0 0>;
+				interconnect-names = "qup-core", "qup-config";
+				status = "disabled";
+			};
+
 			i2c4: i2c@990000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x00990000 0 0x4000>;
-- 
2.39.0

