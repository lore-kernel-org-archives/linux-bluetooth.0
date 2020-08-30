Return-Path: <SRS0=5eoE=CI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67688C433E2
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Aug 2020 13:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32A06206E3
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Aug 2020 13:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKyZ2eyT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgH3NHy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 Aug 2020 09:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbgH3NHx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 Aug 2020 09:07:53 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17769C061573
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2020 06:07:52 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bh1so1748230plb.12
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2020 06:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=WswOPChdhsXl9yL0PAanxx8W8jatho3LL/ArFA4MIY8=;
        b=IKyZ2eyTWjmDv8SIGocLuuLcvSfnE8GHJ6Xlz9H/IIUuOeEYTy8TH29C3qjxS8eHY5
         hN+ShtNUPjPsIN0wk2saJvDeRs0NLP7s0F0G8j4Y7AqXPAFvh72sIz0ta2MSgAUTTw32
         LpsgJnlt10vRU+QM5OMciTrMtH99OW9nl8Vc4Hdesd8AtMtug1nWja/JlaoFAr+HF8EV
         240OADuwwF/t5hfl3YM1kv+yhe2QLsCXyB3gToFf+HRQtirSPB2P0UkXWScL5R4OVoVv
         KMlWd8nzGhM7uRWt92GEW7qK2zFKPnAHKGJVzGb4iEK7QX0qysPevGbOW/rPy/vVd/2k
         nlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=WswOPChdhsXl9yL0PAanxx8W8jatho3LL/ArFA4MIY8=;
        b=Z1WcqD4ksGRzxocv5p4PsP9nqOEeR0sfOCfggkWFcsFH1MJNzoKgFF9xmaXMEyRHHE
         e6hlzrueuz9tWOcrJ4tu8U9rzE+C/8lZblI025dzjzWJlxHwlq8pQYNuIjhEMBnKL2Hj
         2Doy+1aH7LLNUsVqHLoa2Bk5z2d3lrbRoML0/0HqHBDE//6/zihPs/9Xync95Vca02UD
         xOwMWyr5c7+uVrIyxxh0hSTKrtVW3l58DExaUHRSXh8eeY00m72Sj2sQFaSMRDphqAqA
         6hn7AKW0rVyAh8KhSJiZSexYNAlDnlgV/6+wCJVCXfZE7V5gVrYVTvmm8FHGHT9utMR8
         ObdA==
X-Gm-Message-State: AOAM5335xtpM7qJ3VrcV8IWO2aCsf3UIZST825ZxukwFIDt7OYPnEak/
        0IKsciAZ9NQrCrIgLNV+eLdngjIYv2GgJ7Yx
X-Google-Smtp-Source: ABdhPJz38Ybn4jxAcCpy6pg5HQk8fPTPUJ+ETe1SYbwkSDCOO7/zeO2xRxzF2ZCKLDy4x6CupATldg==
X-Received: by 2002:a17:902:6ac9:: with SMTP id i9mr5631145plt.128.1598792872020;
        Sun, 30 Aug 2020 06:07:52 -0700 (PDT)
Received: from ubuntu ([59.64.129.39])
        by smtp.gmail.com with ESMTPSA id u22sm4418437pgi.85.2020.08.30.06.07.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Aug 2020 06:07:51 -0700 (PDT)
Date:   Sun, 30 Aug 2020 06:07:44 -0700
From:   zefang han <hanzefang@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] tools/hcidump: fix a out-of-bounds read in
 le_meta_ev_dump()
Message-ID: <20200830130744.GA10568@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Check whether the subevent code of le meta event is bigger than
the size of ev_le_meta_str.
---
 tools/parser/hci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/parser/hci.c b/tools/parser/hci.c
index 41f6fe087..acd41be83 100644
--- a/tools/parser/hci.c
+++ b/tools/parser/hci.c
@@ -3668,7 +3668,12 @@ static inline void le_meta_ev_dump(int level, struct frame *frm)
 	frm->len -= EVT_LE_META_EVENT_SIZE;
 
 	p_indent(level, frm);
-	printf("%s\n", ev_le_meta_str[subevent]);
+
+	if (subevent > LE_EV_NUM) {
+		printf("Unknown\n");
+	} else {
+		printf("%s\n", ev_le_meta_str[subevent]);
+	}
 
 	switch (mevt->subevent) {
 	case EVT_LE_CONN_COMPLETE:
-- 
2.17.1

