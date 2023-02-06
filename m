Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D544CC636D4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Feb 2023 00:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjBFAQt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Feb 2023 19:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBFAQp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Feb 2023 19:16:45 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE1A1B314
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Feb 2023 16:16:43 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id v15so1321638oie.9
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Feb 2023 16:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKiRpszv0N47m/cXAuiRNNzVQEfrL6MW3jLIbHTB504=;
        b=TlbYQv6qnoHjdMGbPXrdAuGLxHguRXl7Dugr+aI4+u7b637nYzjeEFbSkk5s+qv35k
         TsVlfH/K2tztLmYQ5e1dJwcyt6ONbZDCXqICapdReRHQv3/jQ/ZpmZz4WrghzAUAhO98
         ZgblXV9lWjGvF2z9tsXH+SXBqbCTDLd52NPMjKXMFcu1RsF25EMyB8I9+mVgLuByk8og
         8b5KeEgx/MMCDa8YnMnTA+/F+AujutRK3rP+3p+yeYqnnp27Uul2HWnqYI62qzr86tSA
         MaIq5YawCaBOw4tV0YzbPfWFVhjRvYlBizNAFjUFA2w5kGpnuwO3+vox3KNxuVgdsMRd
         DmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DKiRpszv0N47m/cXAuiRNNzVQEfrL6MW3jLIbHTB504=;
        b=zWxP/n83oL2O9sIen/NpogaGdVU+4PTe5dLJC5DmfvoraE8aaEqKepU6Nq1XbYTFuR
         YQvcKurunvFGhzZ2ZnbjyxMaGqw7cIhprcFzMg5Gf8GFG+2TUWmZ0IeKcgireKEbinVo
         cEmCWx/LZ9EY4W8VRPkkZwSiDov/iECk/Ubl3kMvT1Xv47lZZYE7fasBWjZ1c3CfiiE5
         4nEJv5OpQsQqLsCGDDDYdViBDJDfQJaEb3HOt2ACZtROmbkwktoT62KiSSzdg2stPEzm
         gKMZOj9qiOZnphKTdClGBbC1UomrujaxQhSCE+zvFl69hdGmpwQE+ih7nrZfqfeiNnjQ
         5u/g==
X-Gm-Message-State: AO0yUKU5iNbAWd49GpS9NNrxaqI1rDD1+JQntW4OPqJW+8dNrDVoJHVk
        b3KkdxTcSBvXDdqo09+tFzYMXg==
X-Google-Smtp-Source: AK7set/LrdMOh6Q4R4YhB9Kscv94BT84RuwAt4hkpDRbyy7i+SWv607skdHsaHeTWu2r9Eylly8qMw==
X-Received: by 2002:a05:6808:238c:b0:37b:38d:eac4 with SMTP id bp12-20020a056808238c00b0037b038deac4mr3009141oib.15.1675642602763;
        Sun, 05 Feb 2023 16:16:42 -0800 (PST)
Received: from localhost (23-118-233-243.lightspeed.snantx.sbcglobal.net. [23.118.233.243])
        by smtp.gmail.com with ESMTPSA id l16-20020a544510000000b003645b64d7b3sm3496098oil.4.2023.02.05.16.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 16:16:42 -0800 (PST)
From:   Steev Klimaszewski <steev@kali.org>
To:     Steev Klimaszewski <steev@kali.org>
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
        Sven Peter <sven@svenpeter.dev>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>
Subject: [RESEND PATCH v3 4/4] arm64: dts: qcom: thinkpad-x13s: Add bluetooth
Date:   Sun,  5 Feb 2023 18:16:34 -0600
Message-Id: <20230206001634.2566-5-steev@kali.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230206001634.2566-1-steev@kali.org>
References: <20230206001634.2566-1-steev@kali.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
Changes since v2:
 - Remove dead code and add TODO comment
 - Make dtbs_check happy with the pin definitions

Signed-off-by: Steev Klimaszewski <steev@kali.org>
---
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index f936b020a71d..d351411d3504 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -24,6 +24,8 @@ / {
 	aliases {
 		i2c4 = &i2c4;
 		i2c21 = &i2c21;
+		serial0 = &uart17;
+		serial1 = &uart2;
 	};
 
 	wcd938x: audio-codec {
@@ -712,6 +714,27 @@ &qup0 {
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
+		/* TODO: define regulators */
+
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
@@ -720,6 +743,12 @@ &qup2 {
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
 
@@ -980,6 +1009,19 @@ hastings_reg_en: hastings-reg-en-state {
 &tlmm {
 	gpio-reserved-ranges = <70 2>, <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
 
+	bt_en: bt-en-state {
+		hstp-sw-ctrl-pins {
+			pins = "gpio132";
+			function = "gpio";
+		};
+
+		hstp-bt-en-pins {
+			pins = "gpio133";
+			function = "gpio";
+			drive-strength = <16>;
+		};
+	};
+
 	edp_reg_en: edp-reg-en-state {
 		pins = "gpio25";
 		function = "gpio";
@@ -1001,6 +1043,27 @@ i2c4_default: i2c4-default-state {
 		bias-disable;
 	};
 
+	uart2_state: uart2-state {
+		cts-pins {
+			pins = "gpio122";
+			function = "qup2";
+			bias-disable;
+		};
+
+		rts-tx-pins {
+			pins = "gpio122", "gpio123";
+			function = "qup2";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		rx-pins {
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

