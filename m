Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6893EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 03:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 500A1611AE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 03:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237454AbhJFD7A (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Oct 2021 23:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237448AbhJFD5v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Oct 2021 23:57:51 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0487C0613AF
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Oct 2021 20:54:26 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i4so4606214lfv.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Oct 2021 20:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DZOpdA3eYjpudg4OpQFFkH8jLHw3BxsNdxzTMff7kgw=;
        b=Vqowca4UgiaC+fBXqBcu/uY1PBquzcLUSNLvI4m85X7UrokO3SMSU2VjgjwlLvMQmh
         qsx0PVYwuS97nctSczbW0/EPVJ0QBpI8npXxHwrFMaNxAVtaIlRSrtfDr/01lMkJFIzk
         NeLaREUo2x9NAHKctYTeKFJdcbLKG3DGrW4TE6vnxKsvxVRzGpwnzWZPAhbV6qTOP1TZ
         8albRcafCq9VIoNGF5i1EtEgCzTR7YeJxiTMPsw8rZxBFCSGpBQwXD+jrBjbyyQnVjnb
         ujZ8iI+IoHoh/d/5ZhPx+FNiAsGnS4MzGWDOWNQ3qbBfyZhavzipupkGO+MkveylWsCR
         B8HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DZOpdA3eYjpudg4OpQFFkH8jLHw3BxsNdxzTMff7kgw=;
        b=5jHf5125BNvY+E32iaBEbbZuouQPT3EzGyT0f/qd78HHs+4Owvmlsd7XU3SU0NObpU
         4rGj+YFe/0nWr185nLMlsQIgf0fhzJgRVKwltC9OdHzLEFsNOD5a5YHn6I97JYKt7xxV
         XUtJG5IR4DASBeTI3TGSYUj/l4ccgQkOsuHyPknVNfLcMzFP3HFkTRrQq1bWWy9gBzEM
         43pMAy3njhUtoDxuIr86+enJukUgnJ73kQpzoXWXtbjp+b/W1lEZWhCryr7N7r0L5JB2
         ZzjetNNd34vUEQ0ioCZ1IvBGpBoiyy3H2jHm+gII/SC7fR6JTfvxBGuI4vZAdK56incY
         BqOA==
X-Gm-Message-State: AOAM5334levZS0bj2xQDVJ3JeEVSe2rDdLr16bhcaPkSmLJ9G6vbJ5Ks
        +MU/HR43aDxd+UZ1MqX0h/EaOQ==
X-Google-Smtp-Source: ABdhPJzAuciR0Bs89UsVK2ICmqc78PA7gPD8wfVqylDag0DqJdI3Y1HguWHKaOEbTu8SD0HZCDgojQ==
X-Received: by 2002:a2e:480a:: with SMTP id v10mr25910067lja.268.1633492465108;
        Tue, 05 Oct 2021 20:54:25 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id s4sm2142967lfd.103.2021.10.05.20.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 20:54:24 -0700 (PDT)
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
Subject: [PATCH v1 15/15] WIP: arm64: dts: qcom: qrb5165-rb5: add bus-pwrseq property to pcie0
Date:   Wed,  6 Oct 2021 06:54:07 +0300
Message-Id: <20211006035407.1147909-16-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006035407.1147909-1-dmitry.baryshkov@linaro.org>
References: <20211006035407.1147909-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 326330f528fc..0c347cb6f8e0 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -689,6 +689,7 @@ wifi-therm@1 {
 
 &pcie0 {
 	status = "okay";
+	bus-pwrseq = <&qca_pwrseq 0>;
 };
 
 &pcie0_phy {
-- 
2.33.0

