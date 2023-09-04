Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A60C71153
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Sep 2023 22:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239388AbjIDWMI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Sep 2023 18:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIDWMH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Sep 2023 18:12:07 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C34A9
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Sep 2023 15:12:02 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99357737980so280984866b.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Sep 2023 15:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google; t=1693865521; x=1694470321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FkFqWTL0Jd47n0sP0wy9R7v8p0d/aInwEtv/pW4v3Q=;
        b=DD/ClJZflDtp/2f8S/HrpUx7xSJIP8iOqQZ0wvwKK4kGbT6lS536InwVACFNssbD7o
         CIkQq8f4AWb0RDE9gobFDFlmTOMCdI95kwl8gXKt9lkDnuIZQkFlwqqSSNjbI0qccJCa
         hhOwsSxrOWB/zdaFS/E9RkL3mTiA3taQXjI3223ga2fJAoLDt2HFsgSYXqilErSgnPsY
         Tzut+/4McI7oLdLMSKBO2d+smJkPGl9RFUlLFAbHBd+SUt8ij1EUD2ABrSUqlab9l9/p
         fJIBmaIlYbU2thut2GkTlDSdq0v92Z4cjvZ2e56wi+p+JSjx1v5hKldHvyVEIBUZWboV
         mBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693865521; x=1694470321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FkFqWTL0Jd47n0sP0wy9R7v8p0d/aInwEtv/pW4v3Q=;
        b=Ui5GgWYg330hYrWqOn8OwqIef4pff2Pk/RAgm5CG/Q+uE8HQLjUhLYjdiSAOx58ny9
         DJKyw2GiMefipmqRJLvIKfqTYU+vvx9R1OzjRPKivpJPSKuaZB8fLw3dZ4oFkCoV691/
         IwYC6/OghPjNZ8aOjq5Pr8YgXP6c0YfpKB6Gq+a+2DhmGAir0a68X1hVHPmW+tKlhsDA
         bzgVr91MmvHwQhFIFi9uo8AXrNVA3OTfQeCOU4qVJ0yXtcP6mi5s2K0VL4edapORoKby
         3j7ifjIY9IuELCUC0wZdaUTQkssS8WdM9QbugKrzsJO7Es8/p8fV01goJCQC/GFqZxEF
         RGaw==
X-Gm-Message-State: AOJu0YxmGrVMl6oVAyTe4e6moOubnRn9o4HKjhi52rGs6OW1CiaiJjDf
        ExsTVqJoYC+4UYnHlQeyKCWZAg==
X-Google-Smtp-Source: AGHT+IGEnrtzRzPNnM00RY/+EBucUSgO/6PCzaxj80w8lTw5RfqEAF0mUsjC+sJHi2MdYAf8JlkcpA==
X-Received: by 2002:a17:906:519d:b0:9a2:96d2:b1e8 with SMTP id y29-20020a170906519d00b009a296d2b1e8mr8404425ejk.54.1693865520950;
        Mon, 04 Sep 2023 15:12:00 -0700 (PDT)
Received: from olheureu-ThinkPad-E560.local.ess-mail.com ([2a02:578:85b9:1300:6c89:e61f:b837:7d81])
        by smtp.gmail.com with ESMTPSA id z16-20020a170906715000b00993cc1242d4sm6692673ejj.151.2023.09.04.15.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 15:12:00 -0700 (PDT)
From:   Olivier L'Heureux <olivier.lheureux@mind.be>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        Olivier L'Heureux <olivier.lheureux@mind.be>
Subject: [PATCH 1/7] ARM: dts: stm32: Add Bluetooth (usart2) feature on stm32mp157x
Date:   Tue,  5 Sep 2023 00:11:52 +0200
Message-Id: <20230904221158.35425-2-olivier.lheureux@mind.be>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230904221158.35425-1-olivier.lheureux@mind.be>
References: <20230904221158.35425-1-olivier.lheureux@mind.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Christophe Roullier <christophe.roullier@st.com>

Add BT (usart2) config on stm32mp157x.

Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
Change-Id: I41cc7d60900e05d8bd4e3281abe170ef3fbbaee8
Reviewed-on: https://gerrit.st.com/c/mpu/oe/st/linux-stm32/+/237115
Reviewed-by: CITOOLS <MDG-smet-aci-reviews@list.st.com>
Reviewed-by: Eric FOURMONT <eric.fourmont-ext@st.com>
Tested-by: Eric FOURMONT <eric.fourmont-ext@st.com>

Cherry-picked for v5.13: dropped part of patch for absent
"stm32mp157f-dk2.dts".
---
 arch/arm/boot/dts/st/stm32mp157c-dk2.dts | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32mp157c-dk2.dts b/arch/arm/boot/dts/st/stm32mp157c-dk2.dts
index 4bef2300ed7c..680391433992 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-dk2.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-dk2.dts
@@ -102,5 +102,14 @@ &usart2 {
 	pinctrl-0 = <&usart2_pins_c>;
 	pinctrl-1 = <&usart2_sleep_pins_c>;
 	pinctrl-2 = <&usart2_idle_pins_c>;
-	status = "disabled";
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		shutdown-gpios = <&gpioz 6 GPIO_ACTIVE_HIGH>;
+		compatible = "brcm,bcm43438-bt";
+		max-speed = <3000000>;
+		vbat-supply = <&v3v3>;
+		vddio-supply = <&v3v3>;
+	};
 };
-- 
2.39.2

