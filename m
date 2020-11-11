Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B335C4742C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 01:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC5AD205ED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 01:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/GoLZxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgKLBdM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgKKXG2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Nov 2020 18:06:28 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C310C061A49
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 15:04:34 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id z24so2504567pgk.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 15:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=V3N7kdL3t6+aPZZJFLnthlCjtlpwpOWNONCQrW7ZWzY=;
        b=o/GoLZxJxqkQkh+fmFx3KTmwX9Tx/q/ngp8oHJq6IPXbseRY+Eh+jAhW6E2RM04TF0
         egWvgDGyXeBuv+MZN/9bv0ji+t4QjJY1et9BBgNdvf9ibkdojEI9t4KluGuiZv7BwU3o
         /MzNNpM+8bQUu2Ck1ddEfsxLSaOJ3JH+V7XYuygISdUaKhzFU7Oj2ogkt2ceevUbzYOy
         JRVX7du8pX0Y7XuhvFv+nNiWPTK5lWCs01yBUR7Fe82bnjmTBZ0btx1CQRlBcMIcHn7V
         K3OMOKavihtJRAPQOJOR8zeYcZ5yPuO3pOTjiAAYGHJ+ttkkIaW8riWfTMb1RfQr8Luk
         UNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V3N7kdL3t6+aPZZJFLnthlCjtlpwpOWNONCQrW7ZWzY=;
        b=iGxivaznLUMvhK6B83+EqnQel3aqVqeDfpPhR9mZHAAJqtl9bNmIjLL1+B0shagwp1
         p/aIrzV4iXIOlEaQ5e91pe7VbAMY5F678TUWoQ9oKoIV0xb2nNcnVxl/dobOAMPEGIfO
         V+mYVqcZDThaPTy7HrB65K+ybaejggXn+52Bogt54B07L1VmvVp5YcSorIaOwltpFJWD
         TmwcKOqDE+lNz1UeGb0/v90/l4K3MlMscKCkm/RSiiVjAIzM/3d8HPsh49wKFsxoAJ9A
         qserIM/UzVhSazG7fJXBUoqZ4wsmG/1H+h16xC+zy9lOYLvMcqo3K1Un8eYA9Tq3jplc
         l1iw==
X-Gm-Message-State: AOAM531P8ZcfrrJExibpVkJk0KNlsB0y/ANoEzX9aEJCkx1CvMJoINpN
        JTsMf84s+yq6zZ9p5FQrduUC+EN9zQX2uw==
X-Google-Smtp-Source: ABdhPJx0Wjz/JnWFKBLFcxsKUC1iXFaU0d2+kDkVX6J+FxXCYOQIAjB148X73E8aXO0WUhwsSfW3jg==
X-Received: by 2002:a62:7ccd:0:b029:18b:9083:ae1b with SMTP id x196-20020a627ccd0000b029018b9083ae1bmr24108791pfc.27.1605135873435;
        Wed, 11 Nov 2020 15:04:33 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n27sm3867767pfq.59.2020.11.11.15.04.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 15:04:32 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 08/10] mgmt-tester: Update expected advertisement flags
Date:   Wed, 11 Nov 2020 15:04:19 -0800
Message-Id: <20201111230421.3364932-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111230421.3364932-1-luiz.dentz@gmail.com>
References: <20201111230421.3364932-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This updates the expected advertisement flags which now includes
MGMT_ADV_FLAG_CAN_SET_TX_POWER and MGMT_ADV_FLAG_HW_OFFLOAD.
---
 tools/mgmt-tester.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index bb8eb578c..0540efafc 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -6867,10 +6867,10 @@ static const struct generic_data set_appearance_success = {
 };
 
 static const uint8_t read_adv_features_rsp_3[] =  {
-	0xff, 0x03, 0x00, 0x00,	/* supported flags */
+	0xff, 0x0f, 0x00, 0x00,	/* supported flags */
 	0x1f,			/* max_adv_data_len */
 	0x1f,			/* max_scan_rsp_len */
-	0x05,			/* max_instances */
+	0x01,			/* max_instances */
 	0x00,			/* num_instances */
 };
 
-- 
2.26.2

