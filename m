Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6CFC64EC7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Feb 2023 15:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjB1PWQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Feb 2023 10:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjB1PWO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Feb 2023 10:22:14 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A6D30B1E;
        Tue, 28 Feb 2023 07:22:13 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-172334d5c8aso11229940fac.8;
        Tue, 28 Feb 2023 07:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2f/vVHxyRFoilKJr+B3hBhPHEkdjVLFye93UcIisf+c=;
        b=S6cPNFB5zYJW4TTwflJkilbf7vs6laanJ9Lcs7sV3ZfQ/Ho8yCEo7EESQb4JYfuPhO
         APqELxQqSo2x7yxpSZ6+RmQE3LHlAqjXBB2bxfgXIpNAejje4ObQ/8FxfK0khYO1q+64
         FZzRMaen+CTH5e+6ZMWSOTRvRDXQjplaxUNe+H4ox3RcJePwVN3p5HvuzuOCr/LGfJKG
         FobaqXL2CpT0AzXiyPpvtdbPO9iM9Wp5Pcv11dWBLLRXnn3qanZsxhHyBvz/O/xp5pWG
         1Lr2AZvE+gnb4ykxxERXfJq72jAYUHtLv8mK8z5Z7PfGWb75d8iFSrzOtObqmcXfJmtv
         qGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2f/vVHxyRFoilKJr+B3hBhPHEkdjVLFye93UcIisf+c=;
        b=BXfQ9rWA5XkPWioTNaLdlSN/0dEw7P56lgI6xKWRVSdOZNJINzl4KtusdOCiuSspqB
         +qp5mvBm0YocE5KFERhtcV+DLbtaFur9Su2KJPRKGWXwxVNOUh2zeKnwiKPZDAdGaPUq
         UNbvkfUWmYjOqMG3SxCMSahc6tWYTzLv8PtCr42rKIyYmhNKn13PIvR/EkL8grMCgsmv
         B12nxkJxdZYxpJpAd4lfeegSsBBII947P7bEXiD6JhKyy6bIhYhr6JV/WS7vOFQ5PVnn
         iKKFvnneQ3fAqguJiuN9WT9kE71e7aTqhEgr9mJKykTkTQjievS8q1N3i3+clTggTSUi
         rp6w==
X-Gm-Message-State: AO0yUKXjSkLgC0G5XRpdlKXhnmWv4X4WSUfj3AIyQDq67W+6dLABflVJ
        r9aWcXKqcPjS5dnkef1BYmWvtlaGYbc=
X-Google-Smtp-Source: AK7set+Bs6M0s35NU/ug9ooCav68C1qAncO8z5TCo9kcefJhAI97/M1BsGJ6XHjEPDCTLsf1Rn+nLQ==
X-Received: by 2002:a05:6870:3486:b0:172:4278:13c9 with SMTP id n6-20020a056870348600b00172427813c9mr1627973oah.10.1677597732618;
        Tue, 28 Feb 2023 07:22:12 -0800 (PST)
Received: from localhost.localdomain (76-244-6-13.lightspeed.rcsntx.sbcglobal.net. [76.244.6.13])
        by smtp.gmail.com with ESMTPSA id yy23-20020a056871259700b0017264f96879sm3318321oab.17.2023.02.28.07.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 07:22:12 -0800 (PST)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        alistair@alistair23.me, anarsoul@gmail.com, luiz.dentz@gmail.com,
        johan.hedberg@gmail.com, marcel@holtmann.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 3/3 V4] arm64: dts: rockchip: Update compatible for bluetooth
Date:   Tue, 28 Feb 2023 09:22:05 -0600
Message-Id: <20230228152205.133582-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230228152205.133582-1-macroalpha82@gmail.com>
References: <20230228152205.133582-1-macroalpha82@gmail.com>
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

