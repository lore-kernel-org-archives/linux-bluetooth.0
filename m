Return-Path: <SRS0=wTyq=D2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D09CC433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Oct 2020 17:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 104F3222EA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Oct 2020 17:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpAZhP0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgJSRZd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Oct 2020 13:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgJSRZd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Oct 2020 13:25:33 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1659CC0613D0
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2020 10:25:33 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bf6so112404plb.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2020 10:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rdSQv0WqI8XOqcIsRkumiryUop8LX5S6l8HxLs9v6HM=;
        b=JpAZhP0cOQ0EvgO3bUuJg+8NtAUxG31mgTDoz29/fG1Z0gT8IWvZpt08F2pe7Pr85T
         LEG8tvjRMx9HobVcT2md3rfVRiXbEvAVscuefz1ifk5DUp8/T5lEjZ0MxSyRtqr9RbWD
         P3LQmL1RqDFtHbAwVByjPw2PwK869aJ5xyTgHeBhO+WhBvzTOi10lw0yXzHpM8IRCi00
         mklhJLoZ4j+PDqWMULRJHNoTePkbKC7XWwg2ApH2AmDSTKX3koQpDwWvBeoCTBvQfDEy
         Mr+OgDooQ1Gw2j7/imI5g7qs7qcuYJBpKtiAuJHtBuv8J2493uwtKPluU8CqjqHznPiw
         QJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rdSQv0WqI8XOqcIsRkumiryUop8LX5S6l8HxLs9v6HM=;
        b=hpiHSoQBp3k/gKp/IfjFVhEsHoXQ4GpS8A+fTA66ZblNL5+7nh4t9MRTqMm7PAQxLU
         T7FKBe9LyfKeJlg0LQlubDx1WzYdZAvG3XY4fyhOE2EJ/ZVvQ2gVPMfilfiWmlmyqTaq
         2QlkkKoHXwvGvwvG+rWo2tFub8A4iEIyyXapy2cyOzZvqCq3PKZurkKueBTQmgXDnDJZ
         GakoJsQrRZMA1WLIZ8g01u7e5LPQxlfoZDlajODfznGBKmBRlTPllNqj1qpTqC6R5PIh
         nAdVsmbMzp+eVo+kCf+Ec4INKsa68BMCYum5AeH2buxoI3BTGqq2ub8F1RfmkvzHAKdr
         WIZQ==
X-Gm-Message-State: AOAM532hNtEMyvAcPLnkQZv8PJcAkJbAeyE6ijcY02lw4Q6ts3qg3kwE
        9MEXkGDOCnXXvFoINid5j8N3Qp3iE6/Fuw==
X-Google-Smtp-Source: ABdhPJxaAQlD9guVgCqBGRvgWEKsIhMqa5tJ3m2azoo1HZeALYUrWI0BfWkiJmAeXeyn+owjKJyZ0Q==
X-Received: by 2002:a17:902:a9ca:b029:d5:dc92:9608 with SMTP id b10-20020a170902a9cab02900d5dc929608mr786360plr.41.1603128332291;
        Mon, 19 Oct 2020 10:25:32 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h6sm370103pfk.212.2020.10.19.10.25.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 10:25:31 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: A2MP: Fix not setting request ID
Date:   Mon, 19 Oct 2020 10:25:29 -0700
Message-Id: <20201019172529.1179996-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201019172529.1179996-1-luiz.dentz@gmail.com>
References: <20201019172529.1179996-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes not resetting of the request ID when sending
A2MP_GETAMPASSOC_RSP.

Fixes: Bluetooth: A2MP: Fix not initializing all members
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/a2mp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index da7fd7c8c2dc..7a1e0b785f45 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -381,10 +381,11 @@ static int a2mp_getampassoc_req(struct amp_mgr *mgr, struct sk_buff *skb,
 	hdev = hci_dev_get(req->id);
 	if (!hdev || hdev->amp_type == AMP_TYPE_BREDR || tmp) {
 		struct a2mp_amp_assoc_rsp rsp;
-		rsp.id = req->id;
 
 		memset(&rsp, 0, sizeof(rsp));
 
+		rsp.id = req->id;
+
 		if (tmp) {
 			rsp.status = A2MP_STATUS_COLLISION_OCCURED;
 			amp_mgr_put(tmp);
-- 
2.26.2

