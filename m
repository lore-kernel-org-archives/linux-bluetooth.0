Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AC9C7EE33
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Feb 2023 16:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjB0Qai (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Feb 2023 11:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjB0Qaf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Feb 2023 11:30:35 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6C04EE9;
        Mon, 27 Feb 2023 08:30:35 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id q15so5605960oiw.11;
        Mon, 27 Feb 2023 08:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2f/vVHxyRFoilKJr+B3hBhPHEkdjVLFye93UcIisf+c=;
        b=RcvKZUMoYJ2UB+3CEB+mhjFJASl07ag2QH9ah4cXsrUvhc0fwcYK+oiDGDzJ9RDJ+i
         GWngexc4RuRt7BeyT2k/46+2fviAQAQ8tvcghoGk+YFkv4kmHw7W9mnod1AFXVC49qqG
         FMol9a0wjzel7wDm0b7G3H2XOmkHwV4CHJYBHFpOsnYIDbIXsfTv0ReM96XlVFY0JQV7
         pwl8aNtTHsoNyQequ3khtST88Per5eIXAmgItuffjGqIeKuuQ/UDneTRtQ9BENLTqe9S
         in6e/JEkC7SjmYR5nWp/tj7j9NsWi6aWDcRImaaVRZQcno+dqI+NgduJGNb1jI7d5xF6
         ET1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2f/vVHxyRFoilKJr+B3hBhPHEkdjVLFye93UcIisf+c=;
        b=0x14lwL/4ifx2cXXjQ+WaJjDUvwKOcf5XITPqc2nD+7I1uUVMdpb6H5Kj/IoiXcehS
         huFNY7CG0lrQI+42mlL0brTpxJml2w2notWwf2Q3NaPU3hoWVSPvREq7+W41CEliJ6Z3
         FYvTcmjhnzrQwA2WTUDLF400YrmcDNbWz8vlRP02MMAz/PunVMFZuvGYDwEFXwYD66FM
         qOYqMCrRqfC6irI04bw/6JGA2WRMhZVHA4cr/qpvevRYGzva/F5vjzOfJf+EPBqT5+GW
         3Myu6rRYkB/QsiWzxulBCpbqatgj9RxW/G5Ip3qiGokA3zSYbjNnxbEeBbNhY/rHZlMB
         M99w==
X-Gm-Message-State: AO0yUKVS4Vo4SoJZ39OWN5vL/6Mfr5J740RVZ71phTqNXc4DyrHLrssL
        BtoKddmnvmquMgsVpaIj88hzmc9M+NM=
X-Google-Smtp-Source: AK7set+Ye/eJbK6v4B8x0QSXQJ6t+HwZprvGQgxn5y0nvuWH3AOFlsvrzk26r7CGMXwlB5hFusX40g==
X-Received: by 2002:a05:6808:293:b0:384:a13:9516 with SMTP id z19-20020a056808029300b003840a139516mr5524507oic.30.1677515434370;
        Mon, 27 Feb 2023 08:30:34 -0800 (PST)
Received: from localhost.localdomain (76-244-6-13.lightspeed.rcsntx.sbcglobal.net. [76.244.6.13])
        by smtp.gmail.com with ESMTPSA id ex16-20020a056808299000b0037fcc1fd34bsm3267713oib.13.2023.02.27.08.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 08:30:34 -0800 (PST)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        alistair@alistair23.me, anarsoul@gmail.com, luiz.dentz@gmail.com,
        johan.hedberg@gmail.com, marcel@holtmann.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 3/3 V3] arm64: dts: rockchip: Update compatible for bluetooth
Date:   Mon, 27 Feb 2023 10:30:27 -0600
Message-Id: <20230227163027.130292-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230227163027.130292-1-macroalpha82@gmail.com>
References: <20230227163027.130292-1-macroalpha82@gmail.com>
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

