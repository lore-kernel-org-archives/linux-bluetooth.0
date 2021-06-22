Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E59C48BE5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jun 2021 01:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 425F96128C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jun 2021 01:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhFVBDt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jun 2021 21:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhFVBDt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jun 2021 21:03:49 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EAEC061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 18:01:33 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id c8so1240901pfp.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 18:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vzLaaZ5H0lCVkV5bKu9NLFhOs+p3vCv4D/N9onvfrTA=;
        b=l+266sVcMV+pYG553UYko1mDa/5W/XutL+mTCceKm7J3BL1gMG9m3eewPj5S1IIWwr
         EPwg6qt8BAq5D58vxUQpPcpLgtyAINPfzRBvOWSsoeUQJIOXrJb37Txk3tcBeaTcx9pN
         IaKQuAUMovC9cqemOntDiVBujRz7/6Wga57HYsyHVj1xOXPJguK98l30OJAfkLJ6DDLM
         F1CvJk8rkilPeHxpsUD9rnfuADD5z4MEd+B44LsO3HxZPt7jU6CwNZ5blMhAasnHJsxO
         eu12xsrYu8CQMZ9PdnvD4llItYYoEvpzqT4y4/vLASlNdsDJdrVNvkidjjopT68JOJ/u
         jh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vzLaaZ5H0lCVkV5bKu9NLFhOs+p3vCv4D/N9onvfrTA=;
        b=GT8f4xI99QjwPGog54kCVOMV8XUJaubbpRvn+tY61QD2edR25LLRrSH8fFIAwYr34V
         hZy6Ge1y60RHg03RH1zz/CPiIjLZR6UE5JIqXfPg1+AX7qJ8AfyNitukIMyrT9EreQtj
         JpUA0tE2f+BUVKYT8/P4RQ9UvIcIaPNHmxrTYdhgkX9EP4GTIa/ey9UuxcTFrHLnYR60
         z8QUERCWSOU4X9nYSDYMTbvnKK70fYGRUFfq6qyIAzo5q5p5bcrqrQOkWwInk//qAYg3
         CE2uimyeV9/lBlbKoPU4sqMAYcLyWt9aFIro8tvI9SlTw9WWGyANAmNh1wHWQWnAGV5A
         gh/w==
X-Gm-Message-State: AOAM530B6kEagegVMcYEbzCniwj9PLLewvH/Ve6q1BcYVyOn9KGnPyDG
        99ZP0NNd1CfU9TCyOW9qUYRGEJ69FkU=
X-Google-Smtp-Source: ABdhPJxzGwJNop8901c4IYGx8+DXLEPBANxxo9zVwWeSfS9QHmkLgXu/WoyMUlyIbEwyAppBdf9Vow==
X-Received: by 2002:a63:5019:: with SMTP id e25mr1179617pgb.280.1624323693208;
        Mon, 21 Jun 2021 18:01:33 -0700 (PDT)
Received: from han1-mobl3.hsd1.or.comcast.net ([2601:1c0:6a01:d830::512a])
        by smtp.gmail.com with ESMTPSA id f28sm17970120pgb.12.2021.06.21.18.01.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 18:01:32 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 2/5] monitor: Add Unknown Advertising ID error code
Date:   Mon, 21 Jun 2021 18:01:28 -0700
Message-Id: <20210622010131.427059-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210622010131.427059-1-hj.tedd.an@gmail.com>
References: <20210622010131.427059-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds Unknown Advertising ID error code (0x42)
---
 monitor/bt.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/monitor/bt.h b/monitor/bt.h
index ac4f976fc..d60bbdb20 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -3657,6 +3657,7 @@ struct bt_hci_evt_le_req_peer_sca_complete {
 #define BT_HCI_ERR_INVALID_PARAMETERS		0x12
 #define BT_HCI_ERR_UNSPECIFIED_ERROR		0x1f
 #define BT_HCI_ERR_CONN_FAILED_TO_ESTABLISH	0x3e
+#define BT_HCI_ERR_UNKNOWN_ADVERTISING_ID	0x42
 
 struct bt_l2cap_hdr {
 	uint16_t len;
-- 
2.26.3

