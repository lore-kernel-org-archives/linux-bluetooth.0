Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-27.0 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4DCC07E96
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 06:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E15B61C59
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 06:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhGHG0N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Jul 2021 02:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhGHG0M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Jul 2021 02:26:12 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D57C061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jul 2021 23:23:31 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id x15-20020a170902e04fb02900f5295925dbso1536565plx.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jul 2021 23:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XQqRS0lanOdd0QqGLCcCybEElU8zxVKVl7sin01pi1s=;
        b=K7mZbhVjktcjxMZsvZ+ipOzarx/4gbsXUHzqq6dtzYXq//9J4gINY04Kg9BmR3mC5e
         be7vbt4tajHu66ZDDvD9lYtezvD3ZeCTBBFKaHuA9K+o/CpTH8IcrnC90RjGaBgc1QAO
         pM7fmwk7py7x5/EWUPKToLPSnRtyOO9BZV9MlEmsvAQ9EKvsZs8vs8pheGa4Xh/gkrxK
         d5oOblr2rzv6hrrhwBftgOXJ2/EnPzQ+qcVD8RXiuLJutOg0tZlvlQfXecuqkoqf5CRm
         qRpB7UELCpXWWeqD+RKFyKkHXeBchniLj6CF9nY26uFULIGQX8iL6QpynGPaqyTL3L0z
         yaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XQqRS0lanOdd0QqGLCcCybEElU8zxVKVl7sin01pi1s=;
        b=OIvzXSMfkMvASaA3I1mU9KyLOHdArnU4oZSCPFVOswSeEP8iJTIGd/Met4yoXPg8lH
         44RAVu1EMx/X5odNv7ZJC6T+eEoSjx7DCUysXoLzuGiV/lf+z+aOEYjZnXYbN0WKiF4c
         lmzT0E5eTTqq5Eo3HEQyvx6q43eHyj9jUZik4Cc1u+BiCBHO8fU7b0WEuHnJj3iCfOMI
         FyarvaN/WOmObFnDQ72k3pX3v9598OEP1sDvBwNiHeLHL0eFKXrO2x3b9I4nH91jtQbw
         miVaMroQAyb4vRXAA2w7/Gv+shd4E9jk++f7znG531kUusZ2HG0Hnyr0UZl7oH/AZ5MP
         UqVg==
X-Gm-Message-State: AOAM532L1XBJnLVvOdx5vJQBdI85Ge8Z1yYinY5E5GWdx02fF63Ir7yj
        gYTKh6j2dS75D2I5CvNP7eBiOSnVnwNQZCvGffSWxh5w96G3PJMTDXHlwQ3yzPO9g4HASewfU+K
        2cPrihX0bt1xxJoUzXlPBuk0RjJFPW5i6ELitlZgJF1lgGAQAQOZzJEpmmSQbR06Yp+7w3xThqv
        uLehhLkPMe+HA=
X-Google-Smtp-Source: ABdhPJxFluaBXKGF/ZuAnnWNBLavirHqbdd1Qt4alFOqlUiFA1wQTaAOkgUS01CudWsCJaB7dCOCfUBSfLo4rhehEg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:de70:7033:67f7:8d0b])
 (user=howardchung job=sendgmr) by 2002:a05:6a00:2293:b029:309:e87c:1f4a with
 SMTP id f19-20020a056a002293b0290309e87c1f4amr28753920pfe.36.1625725411084;
 Wed, 07 Jul 2021 23:23:31 -0700 (PDT)
Date:   Thu,  8 Jul 2021 14:23:02 +0800
In-Reply-To: <20210708062314.245754-1-howardchung@google.com>
Message-Id: <20210708142059.Bluez.v1.2.Ifd6e18068b54a0c9c8f8422ff502e46167d8b348@changeid>
Mime-Version: 1.0
References: <20210708062314.245754-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [Bluez PATCH v1 02/14] unit: add uuid unit tests
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

This adds uuid tests of bt_uuid_hash and bt_uuid_equal to
unit/test-uuid.c

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 unit/test-uuid.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/unit/test-uuid.c b/unit/test-uuid.c
index 0889630cfb34..ac613c5c2951 100644
--- a/unit/test-uuid.c
+++ b/unit/test-uuid.c
@@ -169,6 +169,34 @@ static void test_cmp(gconstpointer data)
 	tester_test_passed();
 }
 
+static void test_hash(gconstpointer data)
+{
+	const struct uuid_test_data *test_data = data;
+	bt_uuid_t uuid1, uuid2;
+	guint uuid_h1, uuid_h2;
+
+	g_assert(bt_string_to_uuid(&uuid1, test_data->str) == 0);
+	g_assert(bt_string_to_uuid(&uuid2, test_data->str128) == 0);
+
+	uuid_h1 = bt_uuid_hash(&uuid1);
+	uuid_h2 = bt_uuid_hash(&uuid2);
+
+	g_assert(uuid_h1 == uuid_h2);
+	tester_test_passed();
+}
+
+static void test_equal(gconstpointer data)
+{
+	const struct uuid_test_data *test_data = data;
+	bt_uuid_t uuid1, uuid2;
+
+	g_assert(bt_string_to_uuid(&uuid1, test_data->str) == 0);
+	g_assert(bt_string_to_uuid(&uuid2, test_data->str128) == 0);
+
+	g_assert(bt_uuid_equal(&uuid1, &uuid2) == 1);
+	tester_test_passed();
+}
+
 static const struct uuid_test_data compress[] = {
 	{
 		.str = "00001234-0000-1000-8000-00805f9b34fb",
@@ -226,26 +254,46 @@ int main(int argc, char *argv[])
 	tester_add("/uuid/base", &uuid_base, NULL, test_uuid, NULL);
 	tester_add("/uuid/base/str", &uuid_base, NULL, test_str, NULL);
 	tester_add("/uuid/base/cmp", &uuid_base, NULL, test_cmp, NULL);
+	tester_add("/uuid/base/hash", &uuid_base, NULL, test_hash, NULL);
+	tester_add("/uuid/base/equal", &uuid_base, NULL, test_equal, NULL);
 
 	tester_add("/uuid/sixteen1", &uuid_sixteen1, NULL, test_uuid, NULL);
 	tester_add("/uuid/sixteen1/str", &uuid_sixteen1, NULL, test_str, NULL);
 	tester_add("/uuid/sixteen1/cmp", &uuid_sixteen1, NULL, test_cmp, NULL);
+	tester_add("/uuid/sixteen1/hash", &uuid_sixteen1, NULL, test_hash,
+									NULL);
+	tester_add("/uuid/sixteen1/equal", &uuid_sixteen1, NULL, test_equal,
+									NULL);
 
 	tester_add("/uuid/sixteen2", &uuid_sixteen2, NULL, test_uuid, NULL);
 	tester_add("/uuid/sixteen2/str", &uuid_sixteen2, NULL, test_str, NULL);
 	tester_add("/uuid/sixteen2/cmp", &uuid_sixteen2, NULL, test_cmp, NULL);
+	tester_add("/uuid/sixteen2/hash", &uuid_sixteen2, NULL, test_hash,
+									NULL);
+	tester_add("/uuid/sixteen2/equal", &uuid_sixteen2, NULL, test_equal,
+									NULL);
 
 	tester_add("/uuid/thirtytwo1", &uuid_32_1, NULL, test_uuid, NULL);
 	tester_add("/uuid/thirtytwo1/str", &uuid_32_1, NULL, test_str, NULL);
 	tester_add("/uuid/thirtytwo1/cmp", &uuid_32_1, NULL, test_cmp, NULL);
+	tester_add("/uuid/thirtytwo1/hash", &uuid_32_1, NULL, test_hash, NULL);
+	tester_add("/uuid/thirtytwo1/equal", &uuid_32_1, NULL, test_equal,
+									NULL);
 
 	tester_add("/uuid/thirtytwo2", &uuid_32_2, NULL, test_uuid, NULL);
 	tester_add("/uuid/thritytwo2/str", &uuid_32_2, NULL, test_str, NULL);
 	tester_add("/uuid/thirtytwo2/cmp", &uuid_32_2, NULL, test_cmp, NULL);
+	tester_add("/uuid/thirtytwo2/hash", &uuid_32_2, NULL, test_hash, NULL);
+	tester_add("/uuid/thirtytwo2/equal", &uuid_32_2, NULL, test_equal,
+									NULL);
 
 	tester_add("/uuid/onetwentyeight", &uuid_128, NULL, test_uuid, NULL);
 	tester_add("/uuid/onetwentyeight/str", &uuid_128, NULL, test_str, NULL);
 	tester_add("/uuid/onetwentyeight/cmp", &uuid_128, NULL, test_cmp, NULL);
+	tester_add("/uuid/onetwentyeight/hash", &uuid_128, NULL, test_hash,
+									NULL);
+	tester_add("/uuid/onetwentyeight/equal", &uuid_128, NULL, test_equal,
+									NULL);
 
 	for (i = 0; malformed[i]; i++) {
 		char *testpath;
-- 
2.32.0.93.g670b81a890-goog

