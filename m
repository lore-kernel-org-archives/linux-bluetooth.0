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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30227C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1471760F46
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240477AbhHMMWE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240473AbhHMMWE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:22:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE44C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p71-20020a25424a0000b029056092741626so8938350yba.19
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mV/a07kESpiok3ffMQFxsbU4zefr2YbKZwOmfiHNvKU=;
        b=e9MWzrAUDDlTtAJ3jj+LtUNiFx+GgV88UPB3xH2PzlmtgAK/Jb/ImTnBgVAj3mT7de
         zkIW7oqS14FHbV6ERA7f1QdyV0EhD2LFWz50lBvgPYRUzM3FzxdDtHJnrNLClbufz5kZ
         /O98VTbY0SUzMrnKfzRTklJRXpsswRSr1PP5lqamZ58d9i0ysyZDd8Z+kCmLaHHoV58T
         /2EDJyyDaVMsE0v5jHtpxW4/zUbv/S1GvNYfjcrBZoYZPaiudytrpcfR8+j58Y8p9t2Z
         VbHZbhJhbsdOzcJDV8OinsmsHI0AUmbEDB/oDXmB5ALwTBxz30Hx2L8YX/w//Gk0njtm
         bZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mV/a07kESpiok3ffMQFxsbU4zefr2YbKZwOmfiHNvKU=;
        b=mA6RArVbqW67vP9/Yh5F0dsXW/BKNqs0wkoE4HPIiWZyY8F3yfWORoUylp5uTdjU7g
         7F0Eiz87sxl288DJ+Sr2D5SarkbmhYfTJ5XwVa5kZLKIQ/SUKvSKq+gq2cES7qI/0u18
         SEvmj01k/E0gnUqmXd1u4+6u4IM+1/lDlOGQhgPctNmK182KT6FncWi4dKMhawShbOq6
         ZJ8Fs1af5DZHOn1penLrgsk3NCOSceYS8Oqhf+PKAZ9Bh9Wfb1TcrWfpT3Alk2IshVCi
         rJfaNizvn3fHbzxdDqcxA2lVzc6MnAwyFvs8Us3bs2Dd9C+7cusnPMqG+d38kA1KgPEs
         vJ1w==
X-Gm-Message-State: AOAM533BW+8Hd5hPhIfVHBO2ErX0ftbHICeT4Kgg+V/JaI0LeDVJ4NNC
        7ybShl8Myy7uddHPBUeJXa9hdlxZU05iEWQ3brBM60cmgzh6NcBc+eIJui/TwWRQmeRpGCZr+fZ
        MSZqmLd0ZcQpAnwsrPTb3VCBnxWkraAtjfHFyMsPrMkXrakS6lMPgFoPWXY7uEFcfo3XVbmvIUf
        sm
X-Google-Smtp-Source: ABdhPJwW0w0+51cQoHokgPShgRGn4KWBT4IhpH1j+0na+eCvm4d8MiC74DXJ1AwtJ2lOWaCjwe72o+tE3OsN
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a25:1056:: with SMTP id
 83mr2679013ybq.52.1628857296961; Fri, 13 Aug 2021 05:21:36 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:18 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.33.Icc03248573f06536dd4fa98d04510491d07538ed@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 33/62] tools/parser: Inclusive language in struct member
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

"central" is preferred, as reflected in the BT core spec 5.3.
---

 tools/parser/csr.c      | 4 ++--
 tools/parser/ericsson.c | 2 +-
 tools/parser/lmp.c      | 2 +-
 tools/parser/parser.h   | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/parser/csr.c b/tools/parser/csr.c
index c112e138b1..36efc46332 100644
--- a/tools/parser/csr.c
+++ b/tools/parser/csr.c
@@ -564,13 +564,13 @@ void csr_dump(int level, struct frame *frm)
 			switch (type) {
 			case 0x0f:
 				frm->handle =  ((uint8_t *) frm->ptr)[17];
-				frm->master = 0;
+				frm->central = 0;
 				frm->len--;
 				lmp_dump(level, frm);
 				return;
 			case 0x10:
 				frm->handle = ((uint8_t *) frm->ptr)[17];
-				frm->master = 1;
+				frm->central = 1;
 				frm->len--;
 				lmp_dump(level, frm);
 				return;
diff --git a/tools/parser/ericsson.c b/tools/parser/ericsson.c
index 09b7cec68f..b2807eca59 100644
--- a/tools/parser/ericsson.c
+++ b/tools/parser/ericsson.c
@@ -29,7 +29,7 @@ void ericsson_dump(int level, struct frame *frm)
 		raw_dump(level, frm);
 	}
 
-	frm->master = !(buf[0] & 0x01);
+	frm->central = !(buf[0] & 0x01);
 	frm->handle = buf[1] | (buf[2] << 8);
 
 	buf[5] = (buf[5] << 1) | (buf[3] & 0x01);
diff --git a/tools/parser/lmp.c b/tools/parser/lmp.c
index e99902b0e6..8c5a228c03 100644
--- a/tools/parser/lmp.c
+++ b/tools/parser/lmp.c
@@ -1141,7 +1141,7 @@ void lmp_dump(int level, struct frame *frm)
 		opcode += tmp << 7;
 	}
 
-	printf("LMP(%c): %s(%c): ", frm->master ? 's' : 'r',
+	printf("LMP(%c): %s(%c): ", frm->central ? 's' : 'r',
 				opcode2str(opcode), tid ? 's' : 'm');
 
 	if (opcode > 123)
diff --git a/tools/parser/parser.h b/tools/parser/parser.h
index c5d9cf9a6d..5f65f16894 100644
--- a/tools/parser/parser.h
+++ b/tools/parser/parser.h
@@ -26,7 +26,7 @@ struct frame {
 	uint32_t	len;
 	uint16_t	dev_id;
 	uint8_t		in;
-	uint8_t		master;
+	uint8_t		central;
 	uint16_t	handle;
 	uint16_t	cid;
 	uint16_t	num;
-- 
2.33.0.rc1.237.g0d66db33f3-goog

