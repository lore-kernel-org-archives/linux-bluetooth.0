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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810A5C433E9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Feb 2021 23:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B61C64E10
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Feb 2021 23:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhBPXeX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Feb 2021 18:34:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbhBPXeV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Feb 2021 18:34:21 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7CEC061756
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Feb 2021 15:33:41 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id s16so2464055plr.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Feb 2021 15:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rjRUuZ6S9CazXw1JtrK9M/ukL9kp/i3skiRIFM9vCfU=;
        b=AIT3VFj1IFDPqgAZ9uQK8XEHbfnCYptGNWBYVE5sNa8cbDfVc0mHDfUSxYBAwsVHLK
         b3ULuQlEBq468u7IvkxM+++Rs07c3HfdQDjIBfnZptG5U2Lg+I571JTbzNVyoT0UpzoO
         RNjdbEU9L+hd66O9RBRRCwE0GXEQz/AeFKm/qZ9dh5CTh6y8TbYO5YSxT7kMmztNaTSx
         8L9sHC1YQaRfTsOGADt4bxGWI7T+DUdTgF0wkibjZamLvHDxIxR0qtg+9u6+4SAFbCMm
         AfVVyYiQA32f5VRqoOZmSynRMB4cjwUvkTbYEfQTGTGIj9v9G4kYPDah2wnhHtTzDBIN
         JF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rjRUuZ6S9CazXw1JtrK9M/ukL9kp/i3skiRIFM9vCfU=;
        b=QMZftHYrWbkWCTx/RARLF/cTIPmsbzO6gVsPgCHQgHE2M6zgpWp8N4Q/tNZJI61ogw
         dKSqYm0+P1BVACzE6HD0fq+kvqYasxwHJCZshKYDsJ6qUkCW53cDZk2sH9gjuGb1ZcMe
         aX4xYiquTBAvDuVD6DQ7ZNB6A/pjufODIj0VgfneD4V4PS1h8ObWPgdk7BCWFvWhH/97
         a8eIN19J+hrb/shsWawPEV5DM/v7dbJVo8qAfcOgJx9Up25lbmnPrwoGAlMxmdfTH1wp
         UB/lucus6WihwuYfPT7IkV0w8F6YWt00ApoyveiVW83yFhIWUNDwNZ3FV8hyQi/YVgHt
         KUgg==
X-Gm-Message-State: AOAM53306bjyPRhGnpeHsiYvFdg9dsZxtCDAlmvAi96JijjApdaXc0qA
        5nauuXnlCKmdP9M20oJ/iFUTM+ZG+2o1eg==
X-Google-Smtp-Source: ABdhPJzLfiQH5aYw6J7H68+dD5DeEBlvJ/S5GT5hO3tHKNxoVbnjLzu+fy1CouOSHi4yXtPrBUOWEg==
X-Received: by 2002:a17:90a:9288:: with SMTP id n8mr6369904pjo.91.1613518420803;
        Tue, 16 Feb 2021 15:33:40 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h5sm99956pgv.87.2021.02.16.15.33.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 15:33:40 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] avdtp: Remove use of G_PRIORITY_LOW
Date:   Tue, 16 Feb 2021 15:33:37 -0800
Message-Id: <20210216233337.859955-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210216233337.859955-1-luiz.dentz@gmail.com>
References: <20210216233337.859955-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

G_PRIORITY_LOW was used in order to prioritize the AVDTP media transport
channel over the signalling channel but this has the side effect of
delaying the dispatching of other conditions such as HUP/NVAL, so now
that BtIO use G_PRIORITY_HIGH for its watches we no longer need to
deprioritize session_cb.
---
 profiles/audio/avdtp.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 9ddcd6464..088ca58b3 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -2378,19 +2378,10 @@ static void avdtp_connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		if (session->io_id)
 			g_source_remove(session->io_id);
 
-		/* This watch should be low priority since otherwise the
-		 * connect callback might be dispatched before the session
-		 * callback if the kernel wakes us up at the same time for
-		 * them. This could happen if a headset is very quick in
-		 * sending the Start command after connecting the stream
-		 * transport channel.
-		 */
-		session->io_id = g_io_add_watch_full(chan,
-						G_PRIORITY_LOW,
+		session->io_id = g_io_add_watch(chan,
 						G_IO_IN | G_IO_ERR | G_IO_HUP
 						| G_IO_NVAL,
-						(GIOFunc) session_cb, session,
-						NULL);
+						(GIOFunc) session_cb, session);
 
 		if (session->stream_setup)
 			set_disconnect_timer(session);
-- 
2.29.2

