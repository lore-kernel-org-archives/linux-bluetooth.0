Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F89C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Feb 2022 11:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356776AbiBHLcm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Feb 2022 06:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245358AbiBHLOT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Feb 2022 06:14:19 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADC9C03FEC0;
        Tue,  8 Feb 2022 03:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644318859; x=1675854859;
  h=from:to:cc:subject:date:message-id;
  bh=7qcPX5mAFxlC0DRDNEQQXzFzZYYFYUFrOViWKGjD428=;
  b=Wkht6RhTw69j/TbeQpbtIMcDmb/yKfvNtOU34AbHuhxG0fmr87S40vZ0
   EP6TVMes/GPSZA7ot4bpvE2D7RI1kYA+dMWcQP/rTVl7okX0ZcnqbtHpi
   nJuGswLzXTRP5d1vUf2kfiRe99RkqusweUjH7qihgjRYxe51SkOjOiAC1
   U=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 08 Feb 2022 03:14:19 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 08 Feb 2022 03:14:17 -0800
X-QCInternal: smtphost
Received: from hyd-lablnx377.qualcomm.com ([10.204.178.226])
  by ironmsg02-blr.qualcomm.com with ESMTP; 08 Feb 2022 16:43:59 +0530
Received: by hyd-lablnx377.qualcomm.com (Postfix, from userid 4035820)
        id E224A213DB; Tue,  8 Feb 2022 16:43:58 +0530 (IST)
From:   Sai Teja Aluvala <quic_saluvala@quicinc.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        bjorn.andersson@linaro.org
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, quic_hemantg@quicinc.com,
        linux-arm-msm@vger.kernel.org, quic_bgodavar@quicinc.com,
        quic_rjliao@quicinc.com, quic_hbandi@quicinc.com,
        abhishekpandit@chromium.org, mcchou@chromium.org,
        Sai Teja Aluvala <quic_saluvala@quicinc.com>
Subject: [PATCH v2] arm64: dts: qcom: sc7280: setting the vddio supply for Bluetooth node on CRD
Date:   Tue,  8 Feb 2022 16:43:23 +0530
Message-Id: <1644318803-14950-1-git-send-email-quic_saluvala@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

setting the vddio supply for Bluetooth SoC WCN6750 node
on SC7280 crd board

Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280-crd.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
index cd2755c..53ea3b4 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
@@ -23,6 +23,10 @@
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

