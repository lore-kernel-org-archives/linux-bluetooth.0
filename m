Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4A8C77B61
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Apr 2023 18:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346506AbjD1Sqx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Apr 2023 14:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346101AbjD1Squ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Apr 2023 14:46:50 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA2A270A
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Apr 2023 11:46:48 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a516fb6523so2863595ad.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Apr 2023 11:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682707607; x=1685299607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hh7rTdclx+rMZsADTYgRxxv+iG2kixOgWMrPKtsLTdw=;
        b=dBk6cBnFHSfDHX5mSzbRQN8CcIaheooK6tCi4Fyer7OZaTZcR54GbPuPx2ia4Gun2u
         zhSpVnfX9hS7R3lJH+UmptUDfY0gdu2ent63fCAuRWuPv17CzwJeQft0RpyJwdP4lHgj
         BFrJyHsQn+blOcklCsjPOcdQSeQf4jJDw0PLTHLUpV1srO5C1hUYNQ6aaT9RVFUzz+me
         vXIszf8zCH5ePsiKhYzL+2t9TXj+7rTrZX4ZLEU0XvKHXpeJ491aCwliDqpe3Ry/4gL7
         8pU0qYujrjHDNLKFdvXL4/WPyg19Qa9n6sQDLOxDNB9bPLVT9eBLdKDExXItugJ9Q5Wh
         vecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682707607; x=1685299607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hh7rTdclx+rMZsADTYgRxxv+iG2kixOgWMrPKtsLTdw=;
        b=A94VrNTwIslSKd2Dz8JaTHvWOZqiKPr9dN7dcC2zARn//LDSprGK6SLnBtZ0ZuDNoh
         T7S3Rqiuc3e/T+J2OGOa156gLE9oh29NL6GOAe1dKdNH87c188SkB2Ms8aCp7mjoo75W
         dbMBZa18w2/64mk216wamxggNcUvt6yMM2CLG9i8nQfPy9PI4e+LhzwHcw8C/AKEaxiq
         t0kmr8TydV7Ri6FNlOC0Pt9HPmLJDUqtPYHD7wjuGx9NZq2eHBjdiRcQdx7xutBGrw66
         iM5zur9TPDZOtb8qcn7Od5/gQWWAvv0o+NKwNZaDazi0Y87At3YdgKvYrbCwPTlUJrk9
         gefg==
X-Gm-Message-State: AC+VfDzpvEZ+i9knCWImavOPrw1bgRrhtjaTf4swP74hr8RvtekJlwcW
        aH9Z+N21qWX4IbqcImPUXq+n3TOXMbg=
X-Google-Smtp-Source: ACHHUZ5L4a7felYjC4zCWJ9fgieMtqwYggPmoIOyxzVGdxduNycLP9Hc6oxOEiKmlcOkgXzvrUI7Ww==
X-Received: by 2002:a17:903:1250:b0:1a9:8907:ae4e with SMTP id u16-20020a170903125000b001a98907ae4emr6907857plh.9.1682707607638;
        Fri, 28 Apr 2023 11:46:47 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id bf9-20020a170902b90900b0019f9fd10f62sm13626366plb.70.2023.04.28.11.46.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 11:46:46 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v4 4/9] shared/tester: Add support for NULL PDUs
Date:   Fri, 28 Apr 2023 11:46:35 -0700
Message-Id: <20230428184640.849066-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230428184640.849066-1-luiz.dentz@gmail.com>
References: <20230428184640.849066-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for NULL PDUs which can be used to skip a round of
TX/RX.
---
 src/shared/tester.c | 6 +++++-
 src/shared/tester.h | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/shared/tester.c b/src/shared/tester.c
index 1feaba48335c..34f807556144 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -914,8 +914,12 @@ static bool test_io_send(struct io *io, void *user_data)
 
 	g_assert_cmpint(len, ==, iov->iov_len);
 
-	if (!test->iovcnt && test->io_complete_func)
+	if (!test->iovcnt && test->io_complete_func) {
 		test->io_complete_func(test->test_data);
+	} else if (test->iovcnt && !test->iov->iov_base) {
+		test_get_iov(test);
+		return test_io_send(io, user_data);
+	}
 
 	return false;
 }
diff --git a/src/shared/tester.h b/src/shared/tester.h
index 49610185a444..16f41022db2b 100644
--- a/src/shared/tester.h
+++ b/src/shared/tester.h
@@ -21,6 +21,8 @@
 		.iov_len = sizeof(data(args)), \
 	}
 
+#define IOV_NULL {}
+
 void tester_init(int *argc, char ***argv);
 int tester_run(void);
 
-- 
2.40.0

