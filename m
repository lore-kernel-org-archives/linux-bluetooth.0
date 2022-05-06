Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC835C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 May 2022 22:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444780AbiEFWgg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 May 2022 18:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444776AbiEFWgf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 May 2022 18:36:35 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB2E562C2
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 May 2022 15:32:49 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id e3so9555245ios.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 May 2022 15:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DWzlXByRiJK1GiKVTGwA5BAMQgPbPfK30A7wefmRXjI=;
        b=hFhLFnIhhLSjSJ7tykaepmYL61H/XKeaAXTk0PXuWBCF2mvc5twJxvP22Mjo9KfXDv
         qJBAJD91FS30Hco6hR1magC+YPmYhS2q3JcMjkPIs2Tv2ZTFngnM5G8HC8J3ZXsqlVKL
         WPZpKlPcBnjFBum6vqsv3JXmOrEafcYtLWbkw9M9u3eNH2X8cswe4sGfQkWEwnHzgQJ1
         vwvkkoCXl0lafQ3H7p+cduU8NMswT8ReqIb7pmyl5FLlWB23Q3dN/GWCcRSPwJGamH1z
         ykdJ/al6ShooLZJUXc/1yZeXF8qS/X+BX6bcIrY1TLvnuLsmY6vDA/bCr+B8CLYqZwvg
         4KPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DWzlXByRiJK1GiKVTGwA5BAMQgPbPfK30A7wefmRXjI=;
        b=4Q1KBkdXA8pfc4cn9YpGFTmPiTOyofXd2HhYAS4TTFjAG4oH1vPs0b1VqQbcL1yD8q
         loVpR0xly0hqLFDSG3YjY3lzLN6pDlRgozcA6mZjlaO8cOx+7noHKF17pBiw9d5A092f
         swyv6gIqGlNYEEUekbDL7iy09/sAM+Pfd34BkuEAHbkp++dtcAwnANJlrXaSfxSj/Zd8
         NqINRYOxEdKnn2jVD0YyPF08zQuUu875IoGBlufg6U9/f3gZ2rfQCNZIj8kGU6/CrFy1
         nBccwbDy35GAb6fZ2xUAZbkqEUtWkFOZyEGERwQb1YIJIjwAoKmlFxAjAYrPTnp1GONH
         gRdA==
X-Gm-Message-State: AOAM531lVxh0OIC5AgVBY6SokVSlbe37ORmfw2vF48sP6tcjs3hvn2D4
        aQ8+ySnZkNV98uNl6WZMp+VTXANE9t8=
X-Google-Smtp-Source: ABdhPJynw8MZskoCQpe97JgXM9gxSVuq5fHtB/fw28fxg53d31tUI82QdkP3mYOLi2CBoCFosIkM3w==
X-Received: by 2002:a02:694d:0:b0:32b:3dd2:2e4a with SMTP id e74-20020a02694d000000b0032b3dd22e4amr2436165jac.15.1651876368817;
        Fri, 06 May 2022 15:32:48 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x20-20020a056638249400b0032b3a7817d3sm1647254jat.151.2022.05.06.15.32.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 15:32:48 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 BlueZ 2/8] shared/util: Decode BlueZ Experimental ISO Socket UUID
Date:   Fri,  6 May 2022 15:32:39 -0700
Message-Id: <20220506223245.3950871-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506223245.3950871-1-luiz.dentz@gmail.com>
References: <20220506223245.3950871-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds BlueZ experimental ISO Socket UUID to uuid128_table so it is
decoded by the likes of btmon.
---
 src/shared/util.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index 33196bf8b..b74a005ce 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -1149,6 +1149,8 @@ static const struct {
 	{ "330859bc-7506-492d-9370-9a6f0614037f",
 		"BlueZ Experimental Bluetooth Quality Report" },
 	{ "a6695ace-ee7f-4fb9-881a-5fac66c629af", "BlueZ Offload Codecs"},
+	{ "6fbaf188-05e0-496a-9885-d6ddfdb4e03e",
+		"BlueZ Experimental ISO Socket"},
 	{ }
 };
 
-- 
2.35.1

