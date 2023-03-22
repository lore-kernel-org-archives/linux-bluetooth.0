Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133B9C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Mar 2023 01:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjCVBPP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Mar 2023 21:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCVBOv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Mar 2023 21:14:51 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC30052F72
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Mar 2023 18:14:48 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id f19-20020a9d5f13000000b00693ce5a2f3eso9575967oti.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Mar 2023 18:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1679447688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aL/N9AV3WhGqQ+Vb9bYix0gGfCvLXKt0K6k2QBL/KxM=;
        b=aJjrv5RzCRlgZ56o2/+n2nWWuZ96bMUoY++1xmdw0KnkyVlj9GTrI6MhJc13w2vKNV
         S6ll7BCqmgfDtSEWnVK/HZapj4kW4jmOxM3qjlt1k9VTas68WF3NeFR/vmeVGxMuzZSx
         idnxS8UB8mO6rhBO0qEKRAIsv+MAUko9PdtIiGxxkkR1vVKmcp0UrUuY1lJU2UFDiDxo
         KWJfsdG3EgQYkdM3Z5TkFo5O+JtqB0chaGqGMSuCIWVq1iykEE7ORAUdPLdQxoYGZ9lg
         mzeyd2ZjQrfxwOT7BBkIxhcsDtSUgy7Uj93EiwZEE6fFF8WSK074s8hIoWxBf8KUqMAm
         BZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679447688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aL/N9AV3WhGqQ+Vb9bYix0gGfCvLXKt0K6k2QBL/KxM=;
        b=ds4WRKVv9OS9MhFgpHv/7wn/VeN3BLAt+Z0Rh83rUtGja2MvO1XNcQlvO+Dj6ako/p
         RCila5V4+fqSoJWOJ9y64WGee+0TOD5V0lssttgMvU8PtnGGa6Shu+BZ+7QxCEGSiFuV
         ay5h12LK2rlWxQaP/XHzdYrIX2+dTl/fe5q+XIMEwqjlVR7Ix78eVRzDx720R0a8JcRQ
         8gq2iZqdSNN3akAsipb2QUQLA8SGcM9FL6hhrEASlXfyvtX/5AS/MOpML3vLDqLtylH7
         xDMPeKzmy+4N0OUqNaXBZehvObqqFf8zEBdAyuDX7YyLzAVxJ2xPX4MsxLD+dGUDPiCe
         hEfQ==
X-Gm-Message-State: AO0yUKVO4JPYcHrzGwHd0GyTLvKkPXRyY0rSAYHGSNcKT3opNRDJPmlK
        ZlH6Jf8htqrJ6oNERhL04Ja0Bg==
X-Google-Smtp-Source: AK7set9K1MSbCV1ueihm5z69nVjnORAmEu3Xc9pzp+x6xd3F+89wz1dITK3sA8Vnh8KYCZdkJzoDGQ==
X-Received: by 2002:a9d:615a:0:b0:699:221e:b07d with SMTP id c26-20020a9d615a000000b00699221eb07dmr233302otk.11.1679447688094;
        Tue, 21 Mar 2023 18:14:48 -0700 (PDT)
Received: from localhost (23-118-233-243.lightspeed.snantx.sbcglobal.net. [23.118.233.243])
        by smtp.gmail.com with ESMTPSA id o23-20020a9d6d17000000b0069d80ce577asm5778527otp.18.2023.03.21.18.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 18:14:47 -0700 (PDT)
From:   Steev Klimaszewski <steev@kali.org>
To:     Steev Klimaszewski <steev@kali.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
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
        Sven Peter <sven@svenpeter.dev>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>,
        Brian Masney <bmasney@redhat.com>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v7 3/4] arm64: dts: qcom: sc8280xp: Define uart2
Date:   Tue, 21 Mar 2023 20:14:41 -0500
Message-Id: <20230322011442.34475-4-steev@kali.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322011442.34475-1-steev@kali.org>
References: <20230322011442.34475-1-steev@kali.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

Add the definition for uart2 for sc8280xp devices.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Steev Klimaszewski <steev@kali.org>
Reviewed-by: Brian Masney <bmasney@redhat.com>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
---
Changes since v6:
 * No changes

Changes since v5:
 * Add sentence to git commit description.
 * Add Johan's R-b

Changes since v4:
 * None

Changes since v3:
 * Fix commit message changelog

Changes since v2:
 * No changes since v2

Changes since v1:
 * change subject line, move node, and add my s-o-b
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 05544a6c1b21..f1d0e8d5edd2 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1209,6 +1209,20 @@ spi2: spi@988000 {
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
 			i2c3: i2c@98c000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0 0x0098c000 0 0x4000>;
-- 
2.39.2

