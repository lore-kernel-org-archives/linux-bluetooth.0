Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D58C77B73
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Apr 2023 19:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244959AbjD0TdE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Apr 2023 15:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245525AbjD0Tc5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Apr 2023 15:32:57 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED2110CB
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Apr 2023 12:32:55 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7606d6b3294so736653339f.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Apr 2023 12:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682623974; x=1685215974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wOpfTKwf5WNulDcph/6pfu797qStjEdA6vB7rZiGCHw=;
        b=cXK7ijYY3mLDfOuMozK3vBa7x5j5RHSTQB7wULcDkroR4yY+J20cUkMbzXnj7e7Kx3
         Gi0Ob3IWcNjB2vee5T7S7/lc8vq3s/Q0mcj1lxYXmzN1Pmgy1678/OlZhxJD18eDoWTL
         A1bjOmk6bzuqaEPOsjjwDNYbKlokvhJeFKYXrUsZ5gj+TwoPuTZearDOLUS/dakJmg8Y
         xKWLS4W1DSRd8+eQP+sQI+tIvr3NdhUER8M1Q6CQU2UKcRhuRunccF5hsUM7TNoh/dpT
         PF0Xv1dOTuz4TjBDBuPuFG3i5pWE9iPmR73S8xBHHiFqrbyFEWKJXh60moufnm0BGFKF
         P0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682623974; x=1685215974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOpfTKwf5WNulDcph/6pfu797qStjEdA6vB7rZiGCHw=;
        b=bloh//aZ9/JfP0pxYmoRVm4lewAFndjQSD5FvtZAVxgc0BtWPQUzX5TL/J5eKQ82SK
         HdutyaSQQgb0CcftCPKpVgkNNWjvuyPGxU0ogXjoz/JKtYvXADiWF7gfTj89jpW3myDl
         pu7TzpUu+Z52HKONp7GnFE34KW9D2jaN3O9DDN7be1auKyklHVORdnQ6HRuGtqVopWl+
         DyxHwkkKzNj0bx+H3/rO/CQvTkO75fCwC1m/H8SD3lEe52M/cHR/BpgwP/3lQWBSYmZ4
         L02NPxv3YupqeSWVVxl1ORGF15a3RQ5VgZw3kuizlUYxi6x81owFu2V1ZUKJFu3nzNwl
         iRvg==
X-Gm-Message-State: AC+VfDxIYFsI1ZwmCVYrK/qtrH7bNZqZkX8tNKaG+jxXtGNfAaqzCbHd
        NL7q2fz2iXi2Z0Ya3MnBG0J8cgALq5w=
X-Google-Smtp-Source: ACHHUZ77X892zXwwolICycG3Dwbk3efRn18O9Fvkh4aeveZq+ShJQ31+Y12JL+uZg44PePZ5M/CuvA==
X-Received: by 2002:a5d:8048:0:b0:760:3b22:9d0 with SMTP id b8-20020a5d8048000000b007603b2209d0mr1649183ior.19.1682623974475;
        Thu, 27 Apr 2023 12:32:54 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id n12-20020a056638264c00b00411baa5ec5asm3349898jat.154.2023.04.27.12.32.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 12:32:53 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 4/9] shared/tester: Add support for NULL PDUs
Date:   Thu, 27 Apr 2023 12:32:40 -0700
Message-Id: <20230427193245.323502-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427193245.323502-1-luiz.dentz@gmail.com>
References: <20230427193245.323502-1-luiz.dentz@gmail.com>
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

