Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447E2C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Feb 2022 05:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237561AbiBYFfl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Feb 2022 00:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbiBYFfk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Feb 2022 00:35:40 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6F11B4027;
        Thu, 24 Feb 2022 21:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645767309; x=1677303309;
  h=from:to:cc:subject:date:message-id;
  bh=K/ZmoVmGsoJHp14aeR2Uuw0XLgHND2lgxjfjAK/d/VY=;
  b=hLV8EZbAUxAjuNt255hv/p71wW77Nm0/AZG6PtO0vH4OnJn151VsusmZ
   iuQKebAHo4hMEPPKozQKeKBDdD4Q6Kgq5xrOonnro4ZVV3YktPPrZch3e
   QwigbEWkLdHlL4umqcpMhvCex2KNPz+khpbrBwsMEf+H3YjrvT3yuuv2H
   k=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 24 Feb 2022 21:35:09 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 24 Feb 2022 21:35:07 -0800
X-QCInternal: smtphost
Received: from hyd-lablnx377.qualcomm.com ([10.204.178.226])
  by ironmsg02-blr.qualcomm.com with ESMTP; 25 Feb 2022 11:04:49 +0530
Received: by hyd-lablnx377.qualcomm.com (Postfix, from userid 4035820)
        id E06BA21673; Fri, 25 Feb 2022 11:04:47 +0530 (IST)
From:   Sai Teja Aluvala <quic_saluvala@quicinc.com>
To:     gross@kernel.org, robh+dt@kernel.org, bjorn.andersson@linaro.org,
        krzysztof.kozlowski@canonical.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-bluetooth@vger.kernel.org,
        quic_hemantg@quicinc.com, quic_bgodavar@quicinc.com,
        quic_rjliao@quicinc.com, mcchou@chromium.org,
        Sai Teja Aluvala <quic_saluvala@quicinc.com>
Subject: [PATCH v3] arm64: dts: qcom: sc7280: Add IO regulator handler in SC7280 CRD based platforms
Date:   Fri, 25 Feb 2022 11:04:45 +0530
Message-Id: <1645767286-13890-1-git-send-email-quic_saluvala@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add IO regulator handler in SC7280 CRD based platforms.
As IO regulator varies in different SC7280 platforms
updating this handler in individual platform bluetooth node.

Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>
---
V3: Updated commit text to reflect the change
v2: updated reviewer comments.
v1: intial patch 
---
 arch/arm64/boot/dts/qcom/sc7280-crd.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
index e2efbdd..6cbbddc 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
@@ -35,6 +35,10 @@
 	};
 };
 
+&bluetooth {
+	vddio-supply = <&vreg_l18b_1p8>;
+};
+
 ap_tp_i2c: &i2c0 {
 	status = "okay";
 	clock-frequency = <400000>;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc.

