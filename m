Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D78C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2079560F46
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240520AbhHMMXf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240354AbhHMMXe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:23:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101F3C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:23:08 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n20-20020a2540140000b0290593b8e64cd5so9022090yba.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xjAMHdWH+RljwloRpGWu9SopC3dgkKptTea/IQ7yf7M=;
        b=Gtcdzgy44y4wJcrnXnW2CGaCsLUJTjtTqIoDEPZ2/QzNF7o94S7SyDsfhgIY+P+5YH
         WcKrufGucppcxlizDK5vIx+I7Uq6zKj+m/H1k+jFjRtMAVjhFi3/TJ/jeF00J+XNcGJ9
         5lbkiEy2OgbsaOFB2EExsVwGkxeZ/DrPDUqDmMn7STOjtM6aJYy/X+G0PH1q1QpSsz9E
         KFkElQuZWf6RsJxBcuTQjdzDHmgONLNGAkIHlxR0fvYajyfcEw1+FIP2iMl0dW7TSnfW
         v6glZ907ZtkB4fvfrVMG8IBtdDUs7sx8XtPsFmsZgYZg6L95Q+XupC9sB7hbsSLYQB+/
         2mfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xjAMHdWH+RljwloRpGWu9SopC3dgkKptTea/IQ7yf7M=;
        b=KV93vjOg8uZIFXFZonyZjPyTUdbjz4HVk1jgVA3AMVwxmmNd78KX2IKXA0gTkz7e1r
         /Ug8ttQOISYnG1HNhnp9M/14OkSBeqYpcTiSeAWKTpWvVQaGw2k+Oj5ffrZRAyAN+Nl7
         f6kbpVi4bNCN5/15DyfR7W7Qle3VtgWfD2tQa66U7EsHi5q/Vpz5lQQYJvE7g83z5kwF
         91Y4tpKAwdfS3cvPuFHjna/HBB2sHHmiVdBbNYOWU3yIZf9YP9RaRKa5FHK20Yn+OO7T
         ordhpRwsXABSv7tTxeOcLgE1o05Hv7jKNJTfiBJ2rybKz5EJgJhK71KFnp36kwXnWRp5
         Xprg==
X-Gm-Message-State: AOAM530mAW0aDrmuH8cWtRPripm2JiwTHr/5K64xal3t6jcS0MwtjCyJ
        bPM8O0Ya5zAZiLtQJZCe3h3+9jYrF9k7jK4Hyl5RDyuiO6N+QHz+L8J0k9QzmG70K1+yvjLpR66
        mMywWToUyZylGF+ZklDA6vvlLihPtRlBpgZRakcdpZDspd/sECrVPxjj26czFciJuSQl47HeIr8
        d0
X-Google-Smtp-Source: ABdhPJzhX7gWODTFJPzIbXvexMrz/XLFTGHW7Hye3PBqmRA81TDd+nlsshL35RGNsf3OCNx7zRIb2glT5gN3
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a25:e7d0:: with SMTP id
 e199mr2699541ybh.203.1628857387202; Fri, 13 Aug 2021 05:23:07 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:43 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.58.I5f75c985c564568baf50026123c14690eb650456@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 58/62] doc/mesh: Inclusive language changes
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"flooding" is preferred, as reflected in
https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf
---

 doc/mesh-api.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index f2c6b9e5c2..ce651c8017 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -585,7 +585,7 @@ Methods:
 			org.bluez.mesh.Error.InvalidArguments
 
 	void SetKeyPhase(uint16 net_index, uint8 phase)
-		This method is used to set the master key update phase of the
+		This method is used to set the flooding key update phase of the
 		given subnet. When finalizing the procedure, it is important
 		to CompleteAppKeyUpdate() on all app keys that have been
 		updated during the procedure prior to setting phase 3.
-- 
2.33.0.rc1.237.g0d66db33f3-goog

