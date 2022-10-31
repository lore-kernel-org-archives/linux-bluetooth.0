Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC72ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Oct 2022 23:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiJaXLD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Oct 2022 19:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiJaXKu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Oct 2022 19:10:50 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148F716597
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 16:10:38 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id io19so12043388plb.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 16:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+zPcZ5mS1uhVLvd0yX1s8m0lmHFPr55m+NTvn4ka+Mg=;
        b=XQhSmwISo/A9A/uJnReuME5uGNYWAMIyI6OYOHCkZoXHfCihmjdcB8X4hsuSuvdabm
         /NiaHp+bA/OWx+u/hu5ke+a1XvrJeKKCXKV8hqWp6ZusGRs9F3Zvw5AasV2GUnV5ZKR/
         7a6kTuNFBNHNYm5ewO9nIvIiRzFJrb6H67Wfv1TwAkOWaTFlJOWh8JJ4o0Ie+sfzhATQ
         mH99Yv0S1VMrrSfhCxjp4BK2S6TAu8O765fUEQH08lUNojTXc7BriB6LBHMsB3B9xC/3
         VXFekNPByvdKdyx+q7P88v5WifsjjG2XY144NTvfSsB0pGRZ3V49uKTt/biY7LnTWl3K
         9PLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zPcZ5mS1uhVLvd0yX1s8m0lmHFPr55m+NTvn4ka+Mg=;
        b=XEO0GnPwG6OziDnmDKGSOwTP8RFRj8Xwpqmr9Fl2dWljhe0yRIsdJRgOuJFoR/vZQ/
         nid4eSeeYPrFtLIYl3VrdZ551bJajjGZHApEO2URadb+GoeYT2pv2sKKMDFoj2ystSZZ
         raKyhslvS2rFC7aNDLP+LwAykUOfIyxRfJvTmule+yrCeGwYu03mJ9g3JZkTilKWxkrl
         q8JLxBeLVNSHNftGzIOFWa2xp2YJdFflSWrdEWC4MPFjrgnfjAzPsZiST7shv8Srtj++
         P/EzWl53o0lm6eE6pZA9BA3El6PTeJvExBayuEXfSdnPiHAfBoCPMJthuNeaJzwkzlbm
         81ug==
X-Gm-Message-State: ACrzQf032jquUqQzxT93J9DauqStI4Sp+jCCVXjusvDpUrvHO16e0usP
        CXZ/u9xLEQK7QZtogrgWC6GW1Lux9M4=
X-Google-Smtp-Source: AMsMyM4B9aVsZRrF6E07FEYmPPLydJEVk3vsJV+/brQZSz1Uc+7Sfrc1YJl6lXSoUfeh0uBX1Mc9dw==
X-Received: by 2002:a17:902:7786:b0:178:48c0:a083 with SMTP id o6-20020a170902778600b0017848c0a083mr16648853pll.125.1667257836971;
        Mon, 31 Oct 2022 16:10:36 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b7-20020aa78ec7000000b00561382a5a25sm5104265pfr.26.2022.10.31.16.10.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 16:10:36 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: L2CAP: Fix l2cap_global_chan_by_psm
Date:   Mon, 31 Oct 2022 16:10:33 -0700
Message-Id: <20221031231033.2718204-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221031231033.2718204-1-luiz.dentz@gmail.com>
References: <20221031231033.2718204-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

l2cap_global_chan_by_psm shall not return fixed channels as they are not
meant to be connected by (S)PSM.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/l2cap_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2978a34ea33f..cdddd2c779f2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1990,7 +1990,7 @@ static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm,
 		if (link_type == LE_LINK && c->src_type == BDADDR_BREDR)
 			continue;
 
-		if (c->psm == psm) {
+		if (c->chan_type != L2CAP_CHAN_FIXED && c->psm == psm) {
 			int src_match, dst_match;
 			int src_any, dst_any;
 
-- 
2.37.3

