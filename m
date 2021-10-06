Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A50C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 03:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DB30611C1
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 03:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237577AbhJFD51 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Oct 2021 23:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237532AbhJFD4Y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Oct 2021 23:56:24 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52423C0617A9
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Oct 2021 20:54:23 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id n8so4532929lfk.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Oct 2021 20:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/yFX2Zi7N+6O7NNekyBMBaaX61kWJ67YZ/rDfO9/pCo=;
        b=wbt/SYeVTpGchHAcroGs65Of1AQiUTTG33akfUx79AzYY7nm6RIYq5RhUXp+c9Jys4
         nXiObPAc9jCzAYIZ1poh6hdKRe+bj0bgMbS88p28gO6wqFmeLTYm4zuoD4+T3MhC6yjW
         ZepDlWf6ARy8vZhxqA1b3B0t0KcRz9417nhNZY94WNepBe4GPa6KVt65f7s9X/t4aZDk
         shoOxtV8sXrBvfORX2E4aaC1h8l1zuhYA8z4UiPS3Eu3WEKvzDt2tSUCWnrG0Jrlo5AG
         Qcx1rElX2rZ8uflS2LqYwzGzlTy4ej8i4J3tGxc/Gc0S07QUgsx8cN9arN3kElLOU6aF
         ypyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/yFX2Zi7N+6O7NNekyBMBaaX61kWJ67YZ/rDfO9/pCo=;
        b=lJoYzbDc1eOZxe+NgEkldRv4/EiEc9JX0kTlTAouVbGGmGxd8PoG/ScS8e4hbJJKrn
         Cl/BchjMDZHQboqdDWzMcDUnH/N5tv+OSGBcqQxI6jUOb3DbJwGyR2mglygOO989wdpB
         Co3iNLKgNeQWcG+mz81AsWc4HEoyjS+Wp9bAdnJjkGxGMjErPHgLBXhN5RVWWqeJL1Qo
         191zhfZupH0XEkpvyu9wvG0FSMTTS0Y2aJPyCClbu4K5ETvvrSGUcL9XkbVWDGliRVlO
         qozgna4oWeplmqf/AmilfUe1MSiOQO1I76HFfT9uC7Th3OvfRHFIw4cAObAlL3XG4bsU
         LIIg==
X-Gm-Message-State: AOAM533UKzJi/KGriXPdksk2/pKx8czje+J3/vF6oyJ1MjmGYcZS+fsP
        QA219+Qpqe7ktwnCgg6W2KP4TQ==
X-Google-Smtp-Source: ABdhPJwT5ag+B+NF1iSiO5FkQOo/yXhp0aFso0y+wwdL536y1fd1PVtCEaOvxXhyUrfGhnEPv5FIjg==
X-Received: by 2002:a05:6512:2341:: with SMTP id p1mr7186976lfu.204.1633492461726;
        Tue, 05 Oct 2021 20:54:21 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s4sm2142967lfd.103.2021.10.05.20.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 20:54:21 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v1 11/15] arm64: dts: qcom: sdm845-db845c: switch bt+wifi to qca power sequencer
Date:   Wed,  6 Oct 2021 06:54:03 +0300
Message-Id: <20211006035407.1147909-12-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006035407.1147909-1-dmitry.baryshkov@linaro.org>
References: <20211006035407.1147909-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Switch sdm845-db845c device tree to use new power sequencer driver
rather than separate regulators.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 21 ++++++++++++++-------
 arch/arm64/boot/dts/qcom/sdm845.dtsi       |  6 ++++++
 2 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 2d5533dd4ec2..a6a34a959a91 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -629,6 +629,16 @@ &qupv3_id_1 {
 	status = "okay";
 };
 
+&qca_pwrseq {
+	status = "okay";
+
+	vddio-supply = <&vreg_s4a_1p8>;
+
+	vddxo-supply = <&vreg_l7a_1p8>;
+	vddrf-supply = <&vreg_l17a_1p3>;
+	vddch0-supply = <&vreg_l25a_3p3>;
+};
+
 &sdhc_2 {
 	status = "okay";
 
@@ -916,10 +926,8 @@ &uart6 {
 	bluetooth {
 		compatible = "qcom,wcn3990-bt";
 
-		vddio-supply = <&vreg_s4a_1p8>;
-		vddxo-supply = <&vreg_l7a_1p8>;
-		vddrf-supply = <&vreg_l17a_1p3>;
-		vddch0-supply = <&vreg_l25a_3p3>;
+		bt-pwrseq = <&qca_pwrseq 1>;
+
 		max-speed = <3200000>;
 	};
 };
@@ -1036,9 +1044,8 @@ &wifi {
 	status = "okay";
 
 	vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
-	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
-	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
-	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
+
+	wifi-pwrseq = <&qca_pwrseq 0>;
 
 	qcom,snoc-host-cap-8bit-quirk;
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 6d7172e6f4c3..99117eaf617f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1046,6 +1046,12 @@ psci {
 		method = "smc";
 	};
 
+	qca_pwrseq: qca-pwrseq {
+		compatible = "qcom,wcn3990-pwrseq";
+		#pwrseq-cells = <1>;
+		status = "disabled";
+	};
+
 	soc: soc@0 {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.33.0

