Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56820C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 20:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9E272240A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 20:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TM3P67qj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730361AbgKTUHc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Nov 2020 15:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730347AbgKTUHc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Nov 2020 15:07:32 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A86C0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 12:07:32 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 131so8911305pfb.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 12:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=e2hnhdDfJx56jcdkepK95+QfBU/VLT0jLXe4tjVzKSI=;
        b=TM3P67qjTgQmZtA5leof3ZRMHSv5yvmr1p1PpaJGq+fsSnrqY64BUi8Z2j75XzXY0W
         xt57ksYXmeYwDyhtwQ0TYF0hb0M4oLfMoUT0GKOYouKEvlgDVOpdCnM9Z3B+kTtZ51YB
         8BrwC91ZsFKp4xZfAyeWGc9r6/rkgHfr2y4SFK5lBS1+aG3x0259CJzzcfSGtUPYKOmK
         uwjF41TqvyeJVP+jYe1qCzEGRAv5cMxhTYem2PF4XDbNxuV7QxnPW9uvQOSJ3XbVUfxf
         ccd5UrXW1kbFJYFo0KvIeQ8uZB1Tvz6RkL1dOqiBuTSa43i0COK/ktigrqgIKVxRVr3c
         gG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=e2hnhdDfJx56jcdkepK95+QfBU/VLT0jLXe4tjVzKSI=;
        b=R1bZaewjFHNkZf8BKRhvo3/1+7FTq/GMpAV41E0gVvLHwZNN01s+9f4I9hPD2qe5B0
         A951p8y9qtF19wrD6MoDJpBtU7t8QlrOdCUCmuE18KfNnGEt2j0lDCdKkIcVSP7V6MPT
         7FJNjGbxzhAWRz7DNvEE1RY5EIiz39ohDYF8Ctuz7sCD4kdwkA5tAzsUOhhgBJSts0CL
         13PUBlO5qwCoHFJ+25od2Y91Bl/1D/jxk4/KykFDW9EUM5ZSXsaoJrAslv1xqOwPUgPr
         ckwiVc4tg5jlVrXssneGNpa7YNP88EQy8qXFq6XmpJd4nyRQv78FAs4roDHADgM4V6tf
         y9Ew==
X-Gm-Message-State: AOAM5306RgilmZ6x2pFjlH+/JzZdt+cVyn6+P56joUrnS4LPHW1eSA9s
        0y2SZapmKwGcL7UQfFvcuprQdf2ZEM72XA==
X-Google-Smtp-Source: ABdhPJyB8fhw555bQzFJBCcuEbE3DhHkY6rIgk1574JKglmQAip6msYHUd/5sHBvF+dhb4TQdhj5Ag==
X-Received: by 2002:a17:90b:e86:: with SMTP id fv6mr12614856pjb.196.1605902851724;
        Fri, 20 Nov 2020 12:07:31 -0800 (PST)
Received: from han1-mobl3.jf.net (c-73-164-224-32.hsd1.or.comcast.net. [73.164.224.32])
        by smtp.gmail.com with ESMTPSA id t5sm3979267pgt.15.2020.11.20.12.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 12:07:31 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Google-Original-From: Tedd Ho-Jeong An <tedd.an@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     tedd.an@intel.com
Subject: [PATCH 4/6] emulator: Fix the unchecked return value
Date:   Fri, 20 Nov 2020 12:07:10 -0800
Message-Id: <20201120200712.491219-4-tedd.an@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201120200712.491219-1-tedd.an@intel.com>
References: <20201120200712.491219-1-tedd.an@intel.com>
Reply-To: tedd.an@intel.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch fixes the unchecked return value.
---
 emulator/phy.c    | 10 ++++++++--
 emulator/server.c |  6 +++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/emulator/phy.c b/emulator/phy.c
index 4517ad107..2ae6ad3a2 100644
--- a/emulator/phy.c
+++ b/emulator/phy.c
@@ -115,7 +115,10 @@ static int create_rx_socket(void)
 	if (fd < 0)
 		return -1;
 
-	setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));
+	if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt)) < 0) {
+		close(fd);
+		return -1;
+	}
 
 	memset(&addr, 0, sizeof(addr));
 	addr.sin_family = AF_INET;
@@ -138,7 +141,10 @@ static int create_tx_socket(void)
 	if (fd < 0)
 		return -1;
 
-	setsockopt(fd, SOL_SOCKET, SO_BROADCAST, &opt, sizeof(opt));
+	if (setsockopt(fd, SOL_SOCKET, SO_BROADCAST, &opt, sizeof(opt)) < 0) {
+		close(fd);
+		return -1;
+	}
 
 	return fd;
 }
diff --git a/emulator/server.c b/emulator/server.c
index 3b07a7156..ceb417a40 100644
--- a/emulator/server.c
+++ b/emulator/server.c
@@ -322,7 +322,11 @@ static int open_tcp(void)
 		return -1;
 	}
 
-	setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));
+	if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt)) < 0) {
+		perror("Failed to set socket option");
+		close(fd);
+		return -1;
+	}
 
 	memset(&addr, 0, sizeof(addr));
 	addr.sin_family = AF_INET;
-- 
2.25.4

