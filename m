Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573FAC001DC
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jul 2023 22:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjGGWom (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jul 2023 18:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjGGWom (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jul 2023 18:44:42 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4298D10C
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jul 2023 15:44:41 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-76758b855edso174677285a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jul 2023 15:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688769880; x=1691361880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ADvqDfko4egt573z7+F2x034ETB5fF2C/fp4gxT2McM=;
        b=Ey64wEw+8/SkM6wySDpMvjvtqMvc6IVrKOyVrWQpB9cYfeBuHU7IPCS2Or6O8TKtEH
         Prcvlek8eYIyPIbTdRmSLIPd+Sw0sVZevaieNeZpRo7ngF2H+LSqH/H2iyvQrd6kvSmS
         R2GZH+ODW+pJ+FCWIDu1U2kvX2gW700vWENis/XEcz27jmiqZZp0rbODSJPnw1qJ4DOI
         QL5Mx06w3LOsYF1nJIJrqiz18qXNqBBv2IpMs3LW5+zcb6zVAmefbwvCPh1KZSdIx3gK
         usQtCjlWT1jy5j1aqWtCQP2cdslQBGZXBK79iNjcHpRg3YmLR1q0l5H2bzajNtW/uJWa
         iJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688769880; x=1691361880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADvqDfko4egt573z7+F2x034ETB5fF2C/fp4gxT2McM=;
        b=XbN6R1Nszu5ulr6TvGs6VkFPsiPAGapucYTQEgPSPNfpSxYRRcErwZeqh63aliriex
         7S2rRTOHPbpROFGDEpCoVC3VuZnUZ3I6BvniNRigvk6UBAkgQVkh1z3+b92yuO6fanve
         j6AZxRfVKRx9PkSm/B6xT+SfI2yTjtqwI43zcDRBfDP8LiIoRAoKP+Q8yR41facjc9RC
         Jda1XxzDLotKPcl9xpro5EY6+Er8xsrtKGrH2zkBttpnx83r9LihlOf/xWi4v18MwbXc
         45HGTi1TOsIVQEHpGAOmZuyZbwd7Wonn6PqcKmr5wGNjuV88A/ayCgDHSX3iYIcxvLqj
         SajQ==
X-Gm-Message-State: ABy/qLZ6OMvgaVFTV0F7PXOm5NMu38mIp5ACs/tw5u7WkJdvXOJVo1Rg
        bIADKDN88Ej4L99vJUzkwdPCpR8npNo=
X-Google-Smtp-Source: APBJJlE9AAozS8/HYByK/JlggCDlav7mkaoj1LqbWOtS7o8yp2ZqxkQidY+JEF/zRK+2WzlrtD1Dzg==
X-Received: by 2002:a05:620a:f03:b0:765:ac1b:9218 with SMTP id v3-20020a05620a0f0300b00765ac1b9218mr13711855qkl.22.1688769879776;
        Fri, 07 Jul 2023 15:44:39 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id z28-20020a05620a101c00b0076730d0b0b9sm2274482qkj.14.2023.07.07.15.44.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 15:44:39 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/4] advertising: Use bt_ad_set_max_len
Date:   Fri,  7 Jul 2023 15:44:33 -0700
Message-Id: <20230707224434.677627-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230707224434.677627-1-luiz.dentz@gmail.com>
References: <20230707224434.677627-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses bt_ad_set_max_len to properly set the maximum data length of
the bt_ad instances based on what the kernel returns.
---
 src/advertising.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/advertising.c b/src/advertising.c
index 0dceb14c3be4..6332ec8f9222 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1556,10 +1556,14 @@ static struct btd_adv_client *client_create(struct btd_adv_manager *manager,
 	if (!client->data)
 		goto fail;
 
+	bt_ad_set_max_len(client->data, manager->max_adv_len);
+
 	client->scan = bt_ad_new();
 	if (!client->scan)
 		goto fail;
 
+	bt_ad_set_max_len(client->scan, manager->max_scan_rsp_len);
+
 	client->manager = manager;
 	client->appearance = UINT16_MAX;
 	client->tx_power = ADV_TX_POWER_NO_PREFERENCE;
-- 
2.40.1

