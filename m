Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFA8C77B61
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Apr 2023 20:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbjDYUrl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Apr 2023 16:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjDYUrk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Apr 2023 16:47:40 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B5616F29
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Apr 2023 13:47:39 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-51f6461af24so4856479a12.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Apr 2023 13:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682455658; x=1685047658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wOpfTKwf5WNulDcph/6pfu797qStjEdA6vB7rZiGCHw=;
        b=M1fVH05UK+25cK1gYaFdT+totsraj+m5CPd6Q6+pgQI0D471Q08HJxhq2hTj2p+EUl
         d2STdrmKPJOltqZ5yJwoCGbhUJdV+J2Adzc5QNeLpyQ+2e+GGQ0BzTfPc5D1OZsimvsa
         q/rU83NI0Om9hga/FS3m1tQP+7v6Ejx7C9cfiu0XaVwavW02m+CZluGk95i3a0+biOBu
         xBAMKChD4HTClxZRKOlKrLV8CBOaISRn6BVt9HQs99Vv9pkAKyZUXeYdOLkECjhjpsz3
         SPPMHvmRU9xmUSbqs07Jhz/UjPSGj5DSIyJoEK6eY7LVTV8CFRdv+9fppTdNrZUQodMx
         bHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682455658; x=1685047658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOpfTKwf5WNulDcph/6pfu797qStjEdA6vB7rZiGCHw=;
        b=kx2TzRTCgnobGVXx9q5czpppl0nR/UqZGFsNM6NeGKKg4S3Q3ufMSPVFUWy62hkQVK
         VsCuKy88VWrIFD+AcwP7DAeZecYGLcTUbLj08+Yd8J8XEA0Dzx8sxBDK2CO7L1ZXeRXp
         rW4fILh7Z1bdpwuGLUQ46KApcXyR4HGigxNbD/OCDM1rGPc2wysriPhAaq6MM+iYw1QC
         Quj5wGP4b8YsG9iqttJfaLe2yI7IpIxiNrLJUSZiD4ds7XJG1BIdNm8iEfFIwKxxPH05
         yULhpo1ArL/1kKleN3DK9Fmq6dFl6rUnBvmjw/tvwQeZFj54MUmAFl9FpPRhjThhGgor
         X5Kw==
X-Gm-Message-State: AAQBX9ceuH9kkNgi26KMxX2vcpN76TyD7J8NDE8gQqRAlfHZKHvaMpvb
        e8PHUaI/i2Ubcrh7quW1m4ytqRiZdMM=
X-Google-Smtp-Source: AKy350ZADk5WdAgd0l5ofvIg56w48GLQmJ3iSeLnQdhrz/reYt1JlovikQWYJk7QFToO50fzwWJLKQ==
X-Received: by 2002:a17:90b:4d8a:b0:246:ac0b:9d45 with SMTP id oj10-20020a17090b4d8a00b00246ac0b9d45mr17733034pjb.18.1682455658384;
        Tue, 25 Apr 2023 13:47:38 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id o5-20020a17090aac0500b0024677263e36sm8247454pjq.43.2023.04.25.13.47.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 13:47:37 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/7] shared/tester: Add support for NULL PDUs
Date:   Tue, 25 Apr 2023 13:47:26 -0700
Message-Id: <20230425204729.3943583-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230425204729.3943583-1-luiz.dentz@gmail.com>
References: <20230425204729.3943583-1-luiz.dentz@gmail.com>
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
index 1feaba48335c..61647eb0b176 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -914,8 +914,12 @@ static bool test_io_send(struct io *io, void *user_data)
 
 	g_assert_cmpint(len, ==, iov->iov_len);
 
-	if (!test->iovcnt && test->io_complete_func)
+	if (!test->iovcnt && test->io_complete_func) {
 		test->io_complete_func(test->test_data);
+	} else if (!test->iov->iov_base) {
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

