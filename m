Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7BBC7618D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Mar 2023 17:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjCORhJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Mar 2023 13:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjCORhH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Mar 2023 13:37:07 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39373233C2;
        Wed, 15 Mar 2023 10:37:06 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id d22-20020a9d5e16000000b0069b5252ced7so828338oti.13;
        Wed, 15 Mar 2023 10:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678901825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/9Vp2rjSvwwPz/8jyevs3pjUOOzExCmwYfnGqWJt1o=;
        b=DVXeSurI2s0jk03wKyF78GKCPeNlKbbH8KqxStbUCbohz5DxG2rYDV5LDCsw/A/qoM
         jHwzZJn7Uzh14SREUZvVI7+oY5Wa5SVd2c39/jb9oeoBsowrDUpJ9Kysls0Kjx71OC21
         8TUcIJ9a0zb+rzyeo7xoD9cqXnJeIeQuMgJWHNCgMwhm2+q0VnTZ2eI3wuRNnOoWhyR/
         njVj3Jb8e88WhHrgUsPhhhFmubxYDmOtykekkYfvvC1fdUJgUoJY1oufHtwrbDIvv2Tb
         HsxhywJWe964l5iLh5uE7M3VfiQ57AjvkFr4ou2GQ5eRYFsJ9F79C0+b4MNt75hkUj0F
         oJ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678901825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/9Vp2rjSvwwPz/8jyevs3pjUOOzExCmwYfnGqWJt1o=;
        b=1Nax9f1w8XvynXMbNhBXWZrQXuDRTPdBWx8R3zF5hYb+VrR/wynXdgh4ZnJiAEt8/z
         +X+9GV2y2enGLv03F2jcuSKchM+SLJjj2FLw5Q1Eb/9KYwMPgKRPTT79RqolrsE3P9e9
         JO3j6CdcgUsIUJUvhCPpbL1fpInXJ89VUnYOZm0lEKaF2MUZOzkWOCqabIvptbg/81c2
         LKrXq0PF0/R6qkXlGp1do6VDENEmym0ZvBp5uJnqJ4NGshWt5pzc2c+po8BCQbqMSSbQ
         hDeQ2PMvZ/ggfQiJ20xz2ol8nPOtHJETJSR7vri661rQfHIlpijfpaddrZMLr9u9UbhP
         Qx+w==
X-Gm-Message-State: AO0yUKWjcuUHHAEtyaviatzJHvylqsd9fCaYK723ID4m71J1kLkLiZB+
        QGO/uz9nmLaiPhqHvUpTxiBzfzjOHLk=
X-Google-Smtp-Source: AK7set89mOu5hazfJAwp3mKSvz1N/coT+ZLHY4Tb4tHaZS7gYI1pxVxb711XbbZoXjSpu0zYcXR3Wg==
X-Received: by 2002:a9d:620e:0:b0:68d:6fa6:19ba with SMTP id g14-20020a9d620e000000b0068d6fa619bamr8928487otj.9.1678901825420;
        Wed, 15 Mar 2023 10:37:05 -0700 (PDT)
Received: from localhost.localdomain (76-244-6-13.lightspeed.rcsntx.sbcglobal.net. [76.244.6.13])
        by smtp.gmail.com with ESMTPSA id a23-20020a9d3e17000000b0068abc8e786fsm2562044otd.10.2023.03.15.10.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 10:37:05 -0700 (PDT)
From:   Chris Morgan <macroalpha82@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        alistair@alistair23.me, anarsoul@gmail.com, luiz.dentz@gmail.com,
        johan.hedberg@gmail.com, marcel@holtmann.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 3/3 V5] arm64: dts: rockchip: Update compatible for bluetooth
Date:   Wed, 15 Mar 2023 12:36:57 -0500
Message-Id: <20230315173657.28692-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230315173657.28692-1-macroalpha82@gmail.com>
References: <20230315173657.28692-1-macroalpha82@gmail.com>
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
index 41262a69d33e..ad43fa199ca5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-anbernic-rgxx3.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-anbernic-rgxx3.dtsi
@@ -716,7 +716,7 @@ &uart1 {
 	status = "okay";
 
 	bluetooth {
-		compatible = "realtek,rtl8821cs-bt";
+		compatible = "realtek,rtl8821cs-bt", "realtek,rtl8723bs-bt";
 		device-wake-gpios = <&gpio4 4 GPIO_ACTIVE_HIGH>;
 		enable-gpios = <&gpio4 3 GPIO_ACTIVE_HIGH>;
 		host-wake-gpios = <&gpio4 5 GPIO_ACTIVE_HIGH>;
-- 
2.34.1

