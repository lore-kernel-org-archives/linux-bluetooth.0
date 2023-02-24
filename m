Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F58C64ED8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Feb 2023 23:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjBXXYI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Feb 2023 18:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjBXXYE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Feb 2023 18:24:04 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62BE305CA;
        Fri, 24 Feb 2023 15:23:48 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1729bdcca99so1259137fac.12;
        Fri, 24 Feb 2023 15:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2f/vVHxyRFoilKJr+B3hBhPHEkdjVLFye93UcIisf+c=;
        b=WqcUrpJHyMd+DOpqLUAY26fI/ntqOLcXGXmVAEQ1CtlMgxgMxuBXEgLob50LuZSO5j
         t0ScwxeHCX+fLeR49iM27ekm8HCiNs7h81oah4QyAk1IMXj6TFMQswKGzasnBwZekOH3
         FVAhWr4Tc0SEGzmnzpW9v7cYGtNu+i4RlAEHUxcCrs3m+O35foj9pefCGZnOzOXScUE2
         IUFZRoylJ+KLKBIgVrZeJmKmlFJ0sMVF5aJ7sRIxP0RqclypWRjsB3KW/RtrDeufZZvK
         JuAvvjnQBuN19iOon7+BRGVjVOYq/IrmAGsXvGxmkrpznce8jc3FKdaorllUl0x1B4jo
         tzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2f/vVHxyRFoilKJr+B3hBhPHEkdjVLFye93UcIisf+c=;
        b=5uxelF1zeZ0VcZeEhM9+OEkqysZjB7S9thV9RAr6EhXhVsXRCR8dVNstpMsyHvAG9L
         nZFy3fQ6KskSpxkiYqzQsnZ/aVNCTir+Rh+TJc1Scqp8S2uPvl0zQGiDdV2ruqvjCFvn
         2vbmufEbri5vwzyxVMl+tVJN9wGeqx2h/bwDVp41S9GI2+GnX3xaKtDZ6+KYuvrC1+O3
         9LMRL3a0WccCBl9UEX1+yXmdzkoO8ZV4ihUaB6Z4YJPQ8RMBdFOForKYnWJSeuUA7dBd
         Q1QH4uXdotUlPGxEEcEVdkAjBfBVdQAtp4Sqs2LiYSNs9lMjq54Hsr/vEhtpvnyi3Q2L
         W+9A==
X-Gm-Message-State: AO0yUKWCAYfLTzYTNCzPq8O4m0dM3KMwlgrtTeZnwamy/7u1kaBoZNk3
        5JEW54ZqLLFgLgn1XCBhzrcKRfWEMrg=
X-Google-Smtp-Source: AK7set8C1egSTfnJAP1SL8dAmi9WqnexME0wh4BKjbOYt1RbkKQwYW5BEpVydoralYI7E1k4RlKwEQ==
X-Received: by 2002:a05:6870:e9a1:b0:16a:b45a:e2d9 with SMTP id r33-20020a056870e9a100b0016ab45ae2d9mr12176536oao.7.1677281027757;
        Fri, 24 Feb 2023 15:23:47 -0800 (PST)
Received: from localhost.localdomain (76-244-6-13.lightspeed.rcsntx.sbcglobal.net. [76.244.6.13])
        by smtp.gmail.com with ESMTPSA id k22-20020a056870d39600b0016b0369f08fsm119706oag.15.2023.02.24.15.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 15:23:47 -0800 (PST)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        alistair@alistair23.me, anarsoul@gmail.com, luiz.dentz@gmail.com,
        johan.hedberg@gmail.com, marcel@holtmann.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 3/3 V2] arm64: dts: rockchip: Update compatible for bluetooth
Date:   Fri, 24 Feb 2023 17:23:39 -0600
Message-Id: <20230224232339.124969-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230224232339.124969-1-macroalpha82@gmail.com>
References: <20230224232339.124969-1-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Chris Morgan <macromorgan@hotmail.com>

Update the compatible for the Realtek RTL8821CS bluetooth node.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3566-anbernic-rgxx3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-anbernic-rgxx3.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-anbernic-rgxx3.dtsi
index 41262a69d33e..8fadd8afb190 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-anbernic-rgxx3.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-anbernic-rgxx3.dtsi
@@ -716,7 +716,7 @@ &uart1 {
 	status = "okay";
 
 	bluetooth {
-		compatible = "realtek,rtl8821cs-bt";
+		compatible = "realtek,rtl8821cs-bt", "realtek,rtl8822cs-bt";
 		device-wake-gpios = <&gpio4 4 GPIO_ACTIVE_HIGH>;
 		enable-gpios = <&gpio4 3 GPIO_ACTIVE_HIGH>;
 		host-wake-gpios = <&gpio4 5 GPIO_ACTIVE_HIGH>;
-- 
2.34.1

