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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A183C4320A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 23:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55B1E610CD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Aug 2021 23:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbhHRXHU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Aug 2021 19:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbhHRXHT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Aug 2021 19:07:19 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BF6C061764
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Aug 2021 16:06:43 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id l11so2814110plk.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Aug 2021 16:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HBZCoiCk+JOmNE3ZRucCUftLrXX07D4MGuX7ME8FdRo=;
        b=GrifvGUZABGntKqCYhN92ESMqm892Z8Qox9G4DaVT7X07LRlPqMIrQN2b5dZZ0UP17
         YCGQR09+sGm+PfVIzOdIfQ8COOI2mOXzQ6bebgBr3DCoj1xtvf2XCxY8c+ROBVAkWu9D
         HHzslwWSBcQDZIxeLGwfD+R+aQGCWno7Voh30BgtsVsC/uJbZquiR1YbmFXDwHgFlzdI
         Li4hyUxnBhRcXRHVQSjnSL9uAeFjn708si3R5d3PyPUs62SGAgeBKDk99EOPJ42dQyb+
         N3+yIzfHrkRLogup71TGpT9woju+5IIzHCs9cCNqA+eyN5KDpInxQaCSxb7VJMeAjGt3
         werA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HBZCoiCk+JOmNE3ZRucCUftLrXX07D4MGuX7ME8FdRo=;
        b=kBBkAQcwdDKFRlx353RclNS4tkkhWrzoTfAheqTD6tZtmIYNLv0J8XFX72odmupYOg
         KObnLbkT9FaNWk6KH9x9kYpfVKWTGwKCYRDCNu+PzWlwM+V73mLYjxry3G5EW2hKEuhF
         9tw+M1tk0zxNbF6LaZRk8cqo6RYuoCB0hyOfwvwSW9prhC0RnQiS5rjEd5OPKAnQifJ9
         E+BV1eJe26XRE8bhzYIcXKMySNathRoVdIO7zRG5SXohCKmyf4hGyDbHLrEakBwZJ2ia
         Khz/Hmh3jItZM9mHA2tV2vh0SP7Y9YVdmk8ysETbcK4FnfplaWTHM97UNfD623uyksxG
         VULw==
X-Gm-Message-State: AOAM531pSB+ofhHNwB7tdz2pSpFF/VIPiKpFPBvrtvxY0Lng59pixi5e
        /PA3QO0s+1d6k7i58TzH20g/VcpAnGM=
X-Google-Smtp-Source: ABdhPJw1XtOm5nyGUI2DpgEf0q2qqyL5W65bwWRGiqva3//rzYaAnO+x2WRR6acZ/JTkc2/5FcMRkw==
X-Received: by 2002:a17:90a:4b07:: with SMTP id g7mr11609383pjh.48.1629328003167;
        Wed, 18 Aug 2021 16:06:43 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b6sm842830pgs.94.2021.08.18.16.06.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 16:06:42 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 1/3] btdev: Fix sending terminate advertising event to the wrong device
Date:   Wed, 18 Aug 2021 16:06:39 -0700
Message-Id: <20210818230641.168705-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The device where the event should be sent is the same that had created
not the connection one.
---
 emulator/btdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 6e1d3c346..cd0cfa45f 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5118,7 +5118,7 @@ static void ext_adv_term(void *data, void *user_data)
 
 	/* if connectable bit is set the send adv terminate */
 	if (conn && adv->type & 0x01) {
-		adv_set_terminate(conn->dev, 0x00, adv->handle, conn->handle,
+		adv_set_terminate(adv->dev, 0x00, adv->handle, conn->handle,
 									0x00);
 		le_ext_adv_free(adv);
 	}
-- 
2.31.1

