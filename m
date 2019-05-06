Return-Path: <SRS0=wqlf=TG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DAEC04A6B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 May 2019 12:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856A12087F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 May 2019 12:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3JDS2KP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfEFMnW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 May 2019 08:43:22 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:35700 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfEFMnV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 May 2019 08:43:21 -0400
Received: by mail-ed1-f42.google.com with SMTP id p26so15190762edr.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 May 2019 05:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yru5Mim7gCiSXMH5rlHhnGEZ3k4INba5p6sq97QBk7Y=;
        b=F3JDS2KPYqAoPe4ESSjocsSyy/cEuXyWbS49q+xBv17d4X0k/ZbPoq104uOSUHFJmK
         Csu0j/c4NIqnLC+L6KrUyN8TfZtUL+ma+5qccmgHWpi5oEU4A8ovY9hh6L6tTVewIjk4
         u6FPw6Q5MqAd04MRooslUNw6bveXfxSzJzLtVmNzZD/TZXI4knPzApaGDvBNnhGt2uZX
         oWEjNgKJpMxQkUhmY0Ahrqp6bVcyF2py3q0g9liStilLZfNOU7dxDu/nvXBzGjH5h1xs
         x8nPyjqjUP7MxBFmhwuRyg2qMJ/Mmh8LyPbGEKzkKkqPhJR8ha52fvnCTDXkqtp2gkeo
         pUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yru5Mim7gCiSXMH5rlHhnGEZ3k4INba5p6sq97QBk7Y=;
        b=W7UO3j7HLUQ1msz5I3TQy5/jYEvgAnS2VBZxbxUirOdMiqFjIdYrivmqYiEtuG0/vu
         HfwBRWOV3ZQd/n+7tRKEhzb6uK60MROubc4jKnMw27Dzy2boRl/IDyD+GIfdlw5UT/q6
         hrAj9ch1jHKqeUchPtWrhUttE1aCcTSf2DNFXK75f3mZMnRev4BXi5Nrai03RT2kcYJ2
         CpiQoMZYUtosXcWrO8umfiEa+PdbHGN7Y4hPlZm6SG7ZY5OD90+ipm2t81a48PT1FviI
         8+neXiBafRNyzTg4LVqCdplTfAM5KqwFTfqLNaS3xPvYZHbdTQCrq8sIjbwEyT9hu7hb
         QOjg==
X-Gm-Message-State: APjAAAXhx5JhfREpKRtuP3aYDAcgiV9OTzGEPmS5CWo8ONTH5A/yEvfH
        R64S0ns1lMQZzaJEiBqdzMzFXWrWWeo=
X-Google-Smtp-Source: APXvYqxBmf7BkgYOyd8k3SmxIcgY57TWiILOrBdXE0AeQJwIbVCWuQlxeKsXNfvar7oRRORgbZ9k3Q==
X-Received: by 2002:a50:ab1d:: with SMTP id s29mr25835378edc.56.1557146599705;
        Mon, 06 May 2019 05:43:19 -0700 (PDT)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id h27sm1025816edb.66.2019.05.06.05.43.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 05:43:18 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 5/6] a2dp: Fix useless statement
Date:   Mon,  6 May 2019 15:43:09 +0300
Message-Id: <20190506124310.19151-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190506124310.19151-1-luiz.dentz@gmail.com>
References: <20190506124310.19151-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Checking for NULL path doesn't really matter since NULL is returned
anyway.
---
 profiles/audio/a2dp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index f89105a8d..b54c50315 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -2998,8 +2998,7 @@ struct btd_device *a2dp_setup_get_device(struct a2dp_setup *setup)
 const char *a2dp_setup_remote_path(struct a2dp_setup *setup)
 {
 	if (setup->rsep) {
-		if (setup->rsep->path)
-			return setup->rsep->path;
+		return setup->rsep->path;
 	}
 
 	return NULL;
-- 
2.20.1

