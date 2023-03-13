Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8F4C6FD19
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Mar 2023 20:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjCMUBn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Mar 2023 16:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjCMUB1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Mar 2023 16:01:27 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F718ABD0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 13:00:54 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id v21so4127369ple.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 13:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678737652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5gnBYurJj/sSwz4sdRExHzQWEjr2nz2b5D6grz7/PWs=;
        b=QbsimPPmBOfQXDu25wN+6YhaNfLr97B5N47f8JLMOu4XN3ImfkMVeym//uco+tw1mk
         LVHvrfmLg0cZ6ZrEi+KqKnw83jgZ0nwSMs9fG8gpO/qzpPwaqMuJSu8ahC9VF371FZxG
         6RnhdKevWMoo785vpyLe4I+1kRB20Oyd6tiV+xkkCDLj8UOhIFnRL2UDoWxGuxxHm8Jg
         fjvCEyNot3ZpolqSLiUqcxWGfflNNiL+EjHvk4RqZWhJ30Qc4Tzlkf78SW1tNcgdKE4E
         PbQJPXjqk03CMYfud0CMD094cKhAgCO3l4CY+BQtVvhT4ALr5XRxen78GS7YG6FpXdFQ
         ZbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678737652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5gnBYurJj/sSwz4sdRExHzQWEjr2nz2b5D6grz7/PWs=;
        b=0YvBTEmsz/BncQVyajLG+zIJ9q1P6eb/OMxHW6jTDFDjN02V8ujlg/4lqFCXnbinvC
         QfrH0gIyXo/0N2jh9Gp7nETGJ05gEQPygFbEJ9PhAKd27ZJgaojv+ASKYo9usf3WXV56
         ZYuqYpTjp+qQ6RYgJl6j65w6/OfPTP1V1jskEm33wWklk0UvjombwOMfBZlYhLzcXL72
         qP2kOc+zHRJ9R4PTyvado/tD30LFqAvS2pQzAgfMDgU7hVRvdHz172mdtK8cYMe+pFOp
         oAk6dXfwoplyT6qVi7Fh+CqW372DSYbADSAbWbqjprli+VmYICNyboDMCgr5O10ZfsBq
         k+2w==
X-Gm-Message-State: AO0yUKUy2uTuoR/nnTA4OO4oUOFclbGW/FKWM2dFrAd5gAZj7dp3LQ+8
        nOSvPBGm84FtBvjbG9sV9SIpF5MoLDg=
X-Google-Smtp-Source: AK7set/Bz0uWm9MOWU747Xw3zioKXnkBQEcHOMNkE3oNSoitELfLqwRCAeHWMP3wMVzizDIB0U878A==
X-Received: by 2002:a17:903:18e:b0:19a:75b8:f4ff with SMTP id z14-20020a170903018e00b0019a75b8f4ffmr43730971plg.35.1678737651832;
        Mon, 13 Mar 2023 13:00:51 -0700 (PDT)
Received: from zbook.. (97-113-12-200.tukw.qwest.net. [97.113.12.200])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902d3c500b0019fcece6847sm227519plb.227.2023.03.13.13.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 13:00:51 -0700 (PDT)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, brian.gix@gmail.com, inga.stotland@intel.com
Subject: [PATCH BlueZ v2 1/2] mesh: Fix uninitialized memory usage
Date:   Mon, 13 Mar 2023 13:00:47 -0700
Message-Id: <20230313200048.50855-1-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When attempting to cancel an unknown Scan request structure must be
NULL initialized.
---
 mesh/manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/manager.c b/mesh/manager.c
index e16dbc513..0c98721bf 100644
--- a/mesh/manager.c
+++ b/mesh/manager.c
@@ -709,7 +709,7 @@ static struct l_dbus_message *start_scan_call(struct l_dbus *dbus,
 	req = l_queue_remove_if(scans, by_node_svr, &new_req);
 
 	if (!req)
-		req = l_malloc(sizeof(new_req));
+		req = l_new(struct scan_req, 1);
 
 	if (req->timeout) {
 		l_timeout_remove(req->timeout);
-- 
2.39.2

