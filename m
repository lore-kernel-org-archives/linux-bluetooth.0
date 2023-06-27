Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2DBEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jun 2023 08:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjF0IQh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jun 2023 04:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjF0IQ0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jun 2023 04:16:26 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D05826AB
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 01:16:12 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f766777605so5633806e87.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jun 2023 01:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687853770; x=1690445770;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NKYCzO30p3CfM15O+HnQkgKCwJC3L8nVgasQMiwytMc=;
        b=L+Ba8kZzAvoW9rOZRCbcExHEQdRcSD0u9/08ipPkP6Nx4VIpkxfpg07UBFffH3Q94y
         FYA0K0EMH8Vu0QlUpozyl5S3KszOBSvO8z9WMPElD/h5vp4+iry+nD4Xlh31mEFiQUY7
         U3yqb2C2PyNd7wc+fD3m9NIQ6XZTGXKF2I/dMGB3848H75F/mrgT8s0u9QqMz+DZX4Hd
         zYEdFxHJx149CVXRp3fQzxIpxVPxRjtHs1pswiDyVwKSfz0TAIw3dkqViqFp7PpLIia3
         y5VCQ0IVFTbCM8PmJLTWRLtNFzj9ZQraJDoPzvIOnJX986KYkCP6hcgJC8zU0AB4Wk0+
         AXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687853770; x=1690445770;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NKYCzO30p3CfM15O+HnQkgKCwJC3L8nVgasQMiwytMc=;
        b=OBPn4Ts9SIX87LH1TD25aapGbETkX6O/MEquqzBcWtYtPAjTphE9eGRKy5h0yRqLIf
         phyrkoEEQOTgMkpCjwpKLw3/q0YCfnxTMsNlVVILeUK25p21E/eTbrmATJkphIs3V62L
         P2VHsLwRfuAuBxQdEOVqjIKTUUb8F4Ab3JsT4lpmUF41rE0iG5FqEPTOkR3zTbcJgBJS
         rUCIW0DqEhLtbQYWzz+r7mwYb6Y9b1xLWD0LqMDsflw+mr5yldVazzYQdMb3AkeiL1EJ
         qQUT6FRGZIpqUEId+/1PP9jtZ3jcFdBlbDBolbIpxAVeflvXRdrcpHOXur9bx4B0oIPw
         5UXw==
X-Gm-Message-State: AC+VfDx+n6XFt9KIlgEWfLqbTslA1yxvpmLxkrmOLMH+p+LS/6cLqBos
        Va9/xyfAKJvQmKcjflucry7stA==
X-Google-Smtp-Source: ACHHUZ5UPAmAdebNT5QrLSKqgB0AygVdakqXqFCOobyHd6YHonqV8YRcXuBXtU1vnT8yWryia1+t9Q==
X-Received: by 2002:a19:5e47:0:b0:4f3:b708:f554 with SMTP id z7-20020a195e47000000b004f3b708f554mr16973278lfi.47.1687853770077;
        Tue, 27 Jun 2023 01:16:10 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m21-20020a7bcb95000000b003faabd8fcb8sm3922480wmi.46.2023.06.27.01.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 01:16:09 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 27 Jun 2023 10:15:58 +0200
Subject: [PATCH v2 5/5] arm64: dts: qcom: sm8550-qrd: add bluetooth support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-topic-sm8550-upstream-bt-v2-5-98b0043d31a4@linaro.org>
References: <20230620-topic-sm8550-upstream-bt-v2-0-98b0043d31a4@linaro.org>
In-Reply-To: <20230620-topic-sm8550-upstream-bt-v2-0-98b0043d31a4@linaro.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1926;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=KySBmP9dGxG5IltGtai2AUWCcupms4WbJYVY2a5iftc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkmprC7LKuKQP5lEnWMlwQNfkscjbmRXDGgpsEkAFO
 IxxCBGyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZJqawgAKCRB33NvayMhJ0c0mEA
 CSX5Cq1063oGxde+A1fOmlMP6bKKBH6leth2l0fopZRTKgSlexd2KsE2Q36Wk4KeBHmcWz1T59DiMY
 xgYqjUBMaJS4jXiZ+EznmPkvPaHOwdTaG1WDLNkP/PoNn++6rCZ7aazev6k0EcHvQs2OD8EHXSGrQq
 nBefTd0QNIqDgI3MCsRWQHyHcLDIhlYjALvMbYwuzWRYIU11p6bNImUQy/4qyjYlijLP9KmuFys7XI
 bB2W6XAB/LJy1TnYOc9NCmwi9z7weOCj6F627uMug1JdX4sgUHMTWQy0U23xSYWr9Sey5NIkRS2FoL
 wdBlEHtmyrqqvEMbYq3tR2HyqDRPIpE8QVBt3tQeWPxGa4TktcpRM2+unvKCvne0vDm7E5JJZcHZEZ
 mqiMkcHw1UUHuKLH5w6vfKDT6i4i5PtRlL8tzh8caL/E5h0jdaHT9UFSQm7NnzLA8XmB9/KuuELxIU
 5K48w7nZojT+lyMf4o+xGGUsb8sAnpfC19wVqLTpm7pW5qrjRXf0XTJXcv0IYMVTSzzgWXKgPqFis7
 kga2dx+f65fR2FqrOH5JWWMNfIsNjycTPWVdFMOupkLhuvevsiM360Ew4g6MEmHTsIEZDfoclsxMPE
 gPVxFIdAFUadqN2vnX4NQaKoZyX9q2IMwAjympQqELx18xZxbmq81qKJBt3Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Enable the WCN7850 bluetooth over the UART14 link.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 43 +++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index 8669d29144bb..8f4b07475ca9 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -22,6 +22,7 @@ / {
 
 	aliases {
 		serial0 = &uart7;
+		serial1 = &uart14;
 	};
 
 	wcd938x: audio-codec {
@@ -529,6 +530,10 @@ &qupv3_id_0 {
 	status = "okay";
 };
 
+&qupv3_id_1 {
+	status = "okay";
+};
+
 &remoteproc_adsp {
 	firmware-name = "qcom/sm8550/adsp.mbn",
 			"qcom/sm8550/adsp_dtb.mbn";
@@ -576,6 +581,21 @@ wcd_tx: codec@0,3 {
 &tlmm {
 	gpio-reserved-ranges = <32 8>;
 
+	bt_default: bt-default-state {
+		bt-en-pins {
+			pins = "gpio81";
+			function = "gpio";
+			drive-strength = <16>;
+			bias-disable;
+		};
+
+		sw-ctrl-pins {
+			pins = "gpio82";
+			function = "gpio";
+			bias-pull-down;
+		};
+	};
+
 	sde_dsi_active: sde-dsi-active-state {
 		pins = "gpio133";
 		function = "gpio";
@@ -617,6 +637,29 @@ &uart7 {
 	status = "okay";
 };
 
+&uart14 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn7850-bt";
+
+		vddio-supply = <&vreg_l15b_1p8>;
+		vddaon-supply = <&vreg_s4e_0p95>;
+		vdddig-supply = <&vreg_s4e_0p95>;
+		vddrfa0p8-supply = <&vreg_s4e_0p95>;
+		vddrfa1p2-supply = <&vreg_s4g_1p25>;
+		vddrfa1p9-supply = <&vreg_s6g_1p86>;
+
+		max-speed = <3200000>;
+
+		enable-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
+		swctrl-gpios = <&tlmm 82 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-0 = <&bt_default>;
+		pinctrl-names = "default";
+	};
+};
+
 &ufs_mem_hc {
 	reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
 	vcc-supply = <&vreg_l17b_2p5>;

-- 
2.34.1

