Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF01C77B7E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Apr 2023 19:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244984AbjD0Tdg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Apr 2023 15:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245543AbjD0TdG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Apr 2023 15:33:06 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8428610CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Apr 2023 12:33:03 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7606d460da7so210527039f.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Apr 2023 12:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682623982; x=1685215982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Zf1jMK3UJ9SfKs4kbWstHqgU/7a87nWIjklSePkN28=;
        b=cnSfbB4s2VVd29iIziPZNEUwis+SgRWUpef8OcmERCBQ+bKn4BKCLcwwPnzpU6KDus
         h/KeOuQqyfbVWGSPw0a5/FJbVKPpx0KJRERg1lBI8qO3lFYgewc/enC1u1svHMMBkElE
         UJdup1rMa4IAkM4zvwiZVgMPsvVJUkJIYMv1kHKRj4qROV11e4rG4DPC7+fP1W73HqPG
         EGZZenvPz3vpyFFDNJeg07YJDsSLAKNH7vmfHUVJmwvRAekMCIQ40V5w69S9IXdpsUKs
         usg+RW6LVZTOccnLe+v4iHdML74ctSu+kuE4o2YGxEeUyRPddvHk9N46y/NCxVQ8XqQ+
         Z6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682623982; x=1685215982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Zf1jMK3UJ9SfKs4kbWstHqgU/7a87nWIjklSePkN28=;
        b=U+O8FCRvZmAQ8VnvoB8j8p0bOgMddzAau/nv5GjIKArg4iqL5O1SZthD9V3ZzoHvQB
         RXCpa7ya2ixYj5/g3ypFMAT/phtAxrxqSbzfR0JrCPbB3L6mlWGjhKDfa5R64sEYR+vW
         MXOZJmQc7y11TDKWcuhPF8acUE0ERBT2KSH0uIohYK1QQ2gesLq95Mu9G/18ipalDvC9
         vG1dEix2bT+oIXwGJerpASu5rWf4Yc6NMf7jLTtSdzR90RPpF6BCqXpgP3ptvOq8dsMp
         THY2230d3Y1iLXGf2TmzNUfK75he3/xhGLrozSjygBsLajQEeOV9vvSd6lXOmyLvXghD
         hKTA==
X-Gm-Message-State: AC+VfDwJhzVGw/2GIJ9VAY6gX5qvNFWSiL2JovaznC4fWbtCOyKWGTMe
        ptwGUuAxk91yZjasIAV9ENsKPeo805g=
X-Google-Smtp-Source: ACHHUZ6tEv3ATUakdwB4TapHy3QIPonmspz8mY+CCA1+RQ/Ci4HcDGjpvOLBeB1vJLvTEh4UFVhUMg==
X-Received: by 2002:a5e:db45:0:b0:763:5f1b:2f6f with SMTP id r5-20020a5edb45000000b007635f1b2f6fmr1917286iop.7.1682623982242;
        Thu, 27 Apr 2023 12:33:02 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id n12-20020a056638264c00b00411baa5ec5asm3349898jat.154.2023.04.27.12.33.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 12:33:00 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 8/9] shared/util: Fix runtime error
Date:   Thu, 27 Apr 2023 12:32:44 -0700
Message-Id: <20230427193245.323502-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427193245.323502-1-luiz.dentz@gmail.com>
References: <20230427193245.323502-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following errors:

src/shared/util.c:271:2: runtime error: null pointer passed as argument
2, which is declared to never be null
---
 src/shared/util.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/shared/util.c b/src/shared/util.c
index d31daacc4b93..9a4a8d77abce 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -268,7 +268,8 @@ void *util_iov_push_mem(struct iovec *iov, size_t len, const void *data)
 	if (!p)
 		return NULL;
 
-	memcpy(p, data, len);
+	if (data)
+		memcpy(p, data, len);
 
 	return p;
 }
-- 
2.40.0

