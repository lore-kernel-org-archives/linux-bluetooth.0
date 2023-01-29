Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0E6C05027
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Jan 2023 21:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbjA2Vwc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 29 Jan 2023 16:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbjA2Vw1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 29 Jan 2023 16:52:27 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5499D1E9DB
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Jan 2023 13:52:00 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id o66so8627147oia.6
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Jan 2023 13:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yz+FkVg3d7pGHf5kpyEB9/wRCprKyRRYjM/y0EJ+DBw=;
        b=NO5FmqzTPfKQGSAJFuNQXcl2/Qwzk4V6Re/JvCoc2IjaRyulashjR8KWmE/UTwsoDd
         HIVdOJs4TwzSlKFcRg+FdezQD/LAA/vlBxIgoIvrBqC2qLNt+7KYcL7J+Xytu95sr/wo
         tRMx8V5RFrb6ew1gunJew1xwXwyEXUluGp/U7OIfTuTsUDeO74pms6YH6GQALgwbZAeP
         xTD0onQAafrw0xKMlb6ufLPIAHACOQje2ciSL2/3Ya3gVY2sK9oeiLKp/oVAu4QS404C
         Jqn12RYLi22IaL8XBhDhE95svQpiib+eCMduXy1lPLD4to1P/6d4KURs+RwHFJHkgBw4
         hTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yz+FkVg3d7pGHf5kpyEB9/wRCprKyRRYjM/y0EJ+DBw=;
        b=gr74FKcCfktMDn6yNRdyufrW3DxKA8iFbtfYZcEB3JwnI4IOhWcRPOUjCPn+nuZID8
         GjhRUgFX/DAGbpAvhDuRPxTwkQ1yXhwTRqqQ8+KgiGIBs20GzIuxURS2A89eOXGMfUxO
         Kl/YQhIIy04srSiUIHTl2qLYchRhzOSabmLnHeNNdFUB3fumqcZjJooERwTzLg8z4+VR
         GVcwpSDFT9KFLndOwu4tmvaX/uHokfbrxgsdfV084qaxX6j5njrlVBYHNyPmC68ZTFZh
         yBRJFyzU95VoNl2HJlxqQuVjDQa3QWSmzowjU++ugUxDcerXcFUc5+Q5B/QrYd+ha8je
         Lx3Q==
X-Gm-Message-State: AFqh2kom759Y61UuriSPNUbVhB0DD4Bx59+qTeunPvF7/cJ8W9ZCVTTr
        wTRq8M1Vo+ygkYxRsyCitrmziQ==
X-Google-Smtp-Source: AMrXdXvoNs3Xkmc83sz5OAeNDxC7M6qRfUCSu1WdB6CBf96rnsNfFOfqoKDQXJVDudUDlt65txNtvA==
X-Received: by 2002:a05:6808:1144:b0:35e:6a80:5e17 with SMTP id u4-20020a056808114400b0035e6a805e17mr30085582oiu.56.1675029119998;
        Sun, 29 Jan 2023 13:51:59 -0800 (PST)
Received: from localhost (23-118-233-243.lightspeed.snantx.sbcglobal.net. [23.118.233.243])
        by smtp.gmail.com with ESMTPSA id f12-20020a9d7b4c000000b00660e833baddsm4667139oto.29.2023.01.29.13.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 13:51:59 -0800 (PST)
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
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: qcom: thinkpad-x13s: Add bluetooth
Date:   Sun, 29 Jan 2023 15:51:30 -0600
Message-Id: <20230129215136.5557-5-steev@kali.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230129215136.5557-4-steev@kali.org>
References: <20230129215136.5557-1-steev@kali.org>
 <20230129215136.5557-2-steev@kali.org>
 <20230129215136.5557-3-steev@kali.org>
 <20230129215136.5557-4-steev@kali.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Signed-off-by: Steev Klimaszewski <steev@kali.org>
---
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index e51f93476b8d..a9d653e02a2b 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -25,6 +25,8 @@ / {
 	aliases {
 		i2c4 = &i2c4;
 		i2c21 = &i2c21;
+		serial0 = &uart17;
+		serial1 = &uart2;
 	};
 
 	wcd938x: audio-codec {
@@ -886,6 +888,32 @@ &qup0 {
 	status = "okay";
 };
 
+&uart2 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_state>;
+
+	bluetooth {
+		compatible = "qcom,wcn6855-bt";
+
+/*
+		vddio-supply = <&vreg_s4a_1p8>;
+		vddxo-supply = <&vreg_l7a_1p8>;
+		vddrf-supply = <&vreg_l17a_1p3>;
+		vddch0-supply = <&vreg_l25a_3p3>;
+		vddch1-supply = <&vreg_l23a_3p3>;
+*/
+		max-speed = <3200000>;
+
+		enable-gpios = <&tlmm 133 GPIO_ACTIVE_HIGH>;
+		swctrl-gpios = <&tlmm 132 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_en>;
+	};
+};
+
 &qup1 {
 	status = "okay";
 };
@@ -894,6 +922,12 @@ &qup2 {
 	status = "okay";
 };
 
+&uart17 {
+	compatible = "qcom,geni-debug-uart";
+
+	status = "okay";
+};
+
 &remoteproc_adsp {
 	firmware-name = "qcom/sc8280xp/LENOVO/21BX/qcadsp8280.mbn";
 
@@ -1154,6 +1188,19 @@ hastings_reg_en: hastings-reg-en-state {
 &tlmm {
 	gpio-reserved-ranges = <70 2>, <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
 
+	bt_en: bt-en-state {
+		hstp-sw-ctrl {
+			pins = "gpio132";
+			function = "gpio";
+		};
+
+		hstp-bt-en {
+			pins = "gpio133";
+			function = "gpio";
+			drive-strength = <16>;
+		};
+	};
+
 	edp_reg_en: edp-reg-en-state {
 		pins = "gpio25";
 		function = "gpio";
@@ -1175,6 +1222,27 @@ i2c4_default: i2c4-default-state {
 		bias-disable;
 	};
 
+	uart2_state: uart2-state {
+		cts {
+			pins = "gpio122";
+			function = "qup2";
+			bias-disable;
+		};
+
+		rts-tx {
+			pins = "gpio122", "gpio123";
+			function = "qup2";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		rx {
+			pins = "gpio124";
+			function = "qup2";
+			bias-pull-up;
+		};
+	};
+
 	i2c21_default: i2c21-default-state {
 		pins = "gpio81", "gpio82";
 		function = "qup21";
-- 
2.39.0

