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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751CDC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EECF610CF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240488AbhHMMW0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240480AbhHMMWZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:22:25 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FE4C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:59 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id gw9-20020a0562140f0900b0035decb1dfecso2021839qvb.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=g7z76tPdiJR+T+r8soE6IulOGhW6nRRXU9Iaaohscjs=;
        b=v42Sxq5J0QQtLc4nCPcDoKy5tMQhr+MqUgUcRTdcgGCcTSMd1wvBi2QavdLdDZtxja
         Zm836EeBuOLLS3dg9WPOLSGGvdJdgqyaH26C+hiLF0Sv2+Fnw7z4h1Z69ZGnwUrX4ft9
         mV08BTVLft61IkG7upU1zTPfMFly1Ri3FLZgtEl6g7pWfTyT4Ur6PdkI4WuHTECw7POc
         hCazR6cHGfKGSqYlToyrz6B2WVfRrk2hMSqsVXaMoey8Yv69BnNjkTX0PJkHkTpkqzXU
         LgJRjxewCnQj9TafvnBugPrBYWP5TGN8KpLzJHM5QYQ0Ncw3GjC39Tq5UzHhsE1IPM3Z
         ooPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g7z76tPdiJR+T+r8soE6IulOGhW6nRRXU9Iaaohscjs=;
        b=QbDgUP4/Ri25me6DIbbgf1JWnLLB6p/hSB0NFAtwFUASOopeAug0KCrCvySavTZlLB
         hf6jPblXyjyHbKQFpfY7dtvS6ZbJzIk4Oph+la/rLNdJN+G40D63YSx8R6ZukE5Ou9FI
         pOUdqPYw06L7/m0Ip04XZeLzNd74Ickm5WNBIs5oJf9w/ZOZZZpeQ7uLmtJmUfEiiW0b
         o8JIk1QpQkjc/wjbYeqQtoZuM2XYwIgD5yUoVQIGpssD7qa6ZZRE16W//XcLCK/chGJQ
         Q2zw/qLYfm/DQJr0X175f+DkaGuBANYX7UP32dYHJafe9TZTNgrgXctxtixCEM2I/Uj1
         KZlA==
X-Gm-Message-State: AOAM5309w9BKFSF4JCXF+qx6tqTM2DRYj2X1gAil70+35aZ7ILwQTART
        ofs8p+orVNcoeM9yUiRAT1h58hUsyLtScm0coJia8AqAzIodqzQo8u88y3Gdet5bzpkzovJ4Vfx
        43b16edi2GqqFkEHqlFK4o9K785y6RKQl0YEWRJWt47RBYjhEEkuZ31nZSOIEyY9bzhNwcINwXp
        94
X-Google-Smtp-Source: ABdhPJyZdOd5jDmIIqSIZRwXGF8rLf9y9YMuYjTs+lldSFQqcnEv3aMiN+0hGlTXx8WF+D2viVDGQjqDAtHn
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a05:6214:1142:: with SMTP id
 b2mr2431597qvt.0.1628857318440; Fri, 13 Aug 2021 05:21:58 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:24 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.39.Ibab5aa88a5eaa8b297bd30886166806cd6fd1327@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 39/62] tools/hci-tester: Inclusive language changes
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

"accept list" is preferred, as reflected in the BT core spec 5.3.
---

 tools/hci-tester.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/hci-tester.c b/tools/hci-tester.c
index 645d89e721..79193220fe 100644
--- a/tools/hci-tester.c
+++ b/tools/hci-tester.c
@@ -335,12 +335,12 @@ static void test_read_local_supported_codecs(const void *test_data)
 	test_command(BT_HCI_CMD_READ_LOCAL_CODECS);
 }
 
-static void test_le_read_white_list_size(const void *test_data)
+static void test_le_read_accept_list_size(const void *test_data)
 {
 	test_command(BT_HCI_CMD_LE_READ_ACCEPT_LIST_SIZE);
 }
 
-static void test_le_clear_white_list(const void *test_data)
+static void test_le_clear_accept_list(const void *test_data)
 {
 	test_command(BT_HCI_CMD_LE_CLEAR_ACCEPT_LIST);
 }
@@ -944,10 +944,10 @@ int main(int argc, char *argv[])
 	test_hci_local("Read Local Supported Codecs", NULL, NULL,
 				test_read_local_supported_codecs);
 
-	test_hci_local("LE Read White List Size", NULL, NULL,
-				test_le_read_white_list_size);
-	test_hci_local("LE Clear White List", NULL, NULL,
-				test_le_clear_white_list);
+	test_hci_local("LE Read Accept List Size", NULL, NULL,
+				test_le_read_accept_list_size);
+	test_hci_local("LE Clear Accept List", NULL, NULL,
+				test_le_clear_accept_list);
 	test_hci_local("LE Encrypt", NULL, NULL,
 				test_le_encrypt);
 	test_hci_local("LE Rand", NULL, NULL,
-- 
2.33.0.rc1.237.g0d66db33f3-goog

