Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC54C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 17:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EB4660EE9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 17:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbhJRRa7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Oct 2021 13:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbhJRRa5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Oct 2021 13:30:57 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28238C06161C
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Oct 2021 10:28:46 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id v8so11129029pfu.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Oct 2021 10:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tNVd5nqsmkaPr48wbyHKgypDx1r3nVB4GCcN6zm3DF8=;
        b=BkIsPfFTqGZLgaKMf4iRVEzTqWL58NcRphEsC5dW6aQMD/tkn3zP7xGJXMokzMWJD5
         f7/Ws/+ivrsyMhznMi/zWcTAlx2ahQcCh/FW+TvjrrA0DyokWdF4tWN4rymqtQT7aErp
         Gndy3+gBQyXUMYVLOCox3QJIyXJeOIm71+5UmGjRRvFV5vnjdsm5lQWwo6NEe9NuL19j
         LEGu2NdV4hUGe6gC+G6O0zVEYq0Kc1liN4DyzAGbaGP6uA5spGNquoSOT7doknl3q4Y/
         kxiW6OteLcbEvRo7oPNmJ9HnYn/3bmaZ8xpvzCWOcivoTisMviyziu9MoUlFALuJsIox
         ygIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tNVd5nqsmkaPr48wbyHKgypDx1r3nVB4GCcN6zm3DF8=;
        b=IB7R3mQkijbwVSAjYPqTvDN2JPQuBYqUQXu3Fu7LkH7tAqKHIq4dtQZLjszMVhRkW7
         rIIIuEuY3KB5Nh7FkDALrswq+F89vS2zIlKm5JfsfvtkqjZNviRqF9gmb3/TVUof2ljf
         1CSkzWqSb5XjyqFFo56rKiqTKEHEt3hZn2Yz1NUq513cpSO771QrJctd4+sASENXByxR
         bOzxMaKhEO7z8qZNFB2YcSilYdU7DhtHl05ltMtzHYsPw+aCaIBcg2pI4/UMLkhG22OD
         6IhGOjMROGR7dce/A8uMmBeQWGGvPJ6cxg/SQ3cH8wuKKgLzwjhHqXKMomI++6SY1hoH
         s3lw==
X-Gm-Message-State: AOAM531no94AOeToBy8faS0pJNlQv+OJ4R77oJiFfyCE76rn1snHhFfh
        ECtpOIqpBXqEEeafnfS5dW7+s1oEpkybgg==
X-Google-Smtp-Source: ABdhPJyEAO6fZpH3c9eO7hfu4FwUvQvIgQgZWBsP/AvRdQDVEzyTucBIL6NZq1SUV4Qwcc18nhOp0w==
X-Received: by 2002:a63:ea58:: with SMTP id l24mr25055253pgk.334.1634578125519;
        Mon, 18 Oct 2021 10:28:45 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:a510:aebd:a4ae:453c])
        by smtp.gmail.com with ESMTPSA id fv9sm51156pjb.26.2021.10.18.10.28.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 10:28:45 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 9/9] peripheral: Fix unchecked return value
Date:   Mon, 18 Oct 2021 10:28:33 -0700
Message-Id: <20211018172833.534191-10-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211018172833.534191-1-hj.tedd.an@gmail.com>
References: <20211018172833.534191-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch fixes the unchecked return value(CWE-252) issues reported by
the Coverity.
---
 peripheral/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/peripheral/main.c b/peripheral/main.c
index 6ce729178..86b52236e 100644
--- a/peripheral/main.c
+++ b/peripheral/main.c
@@ -77,7 +77,8 @@ static void prepare_filesystem(void)
 
 		if (lstat(mount_table[i].target, &st) < 0) {
 			printf("Creating %s\n", mount_table[i].target);
-			mkdir(mount_table[i].target, 0755);
+			if (mkdir(mount_table[i].target, 0755) < 0)
+				perror("Failed to create dir");
 		}
 
 		printf("Mounting %s to %s\n", mount_table[i].fstype,
-- 
2.25.1

