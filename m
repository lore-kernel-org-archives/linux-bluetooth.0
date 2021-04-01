Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E03C4361A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Apr 2021 10:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49C8761106
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Apr 2021 10:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbhDAK2M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Apr 2021 06:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbhDAK1u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Apr 2021 06:27:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5572DC061797
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Apr 2021 03:25:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l83so5282722ybf.22
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Apr 2021 03:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7Ua0WliPqrqCi5wQ2LPIjibksmzA56fcFfO1yAgxvpY=;
        b=Ls3jgrkiwN1iVOtLfboEMAF91oH9HdiyjI2dkZQd1KftC69D1+xE8PvUpgW8I0TLrl
         rERuQOqY7oy6xIDTk8/vGtrCpDbyfkvN8wdiZXzS2g8DbfT9B/hs3YLj1po/XUJyNbTR
         /M179qZlCa5tQ7hNOidB2WCYVa65Nwjz2b1H36hJM80/43UHrqBLQRS9GypM50VqCYOE
         WTmb78r6bt6TR2aJLlhYpofXnuRP3//yhFy52HGbfe9/s9vXQxGq20tyU5hMG/lUJoUY
         m1t1R/wcvEwTRJ/Brxld/mukI7VZWTjuLFJOPNNCkM/9kOMgherFALZK1uTeRUCrinwX
         fpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7Ua0WliPqrqCi5wQ2LPIjibksmzA56fcFfO1yAgxvpY=;
        b=H+8A++K7/ZiHviQ4xU4S1uuFIg5bRG+FpmPkuQUCzPguoWqGd4AmYawYfl0aZfCv9V
         FiEnU4zKrDblVvWJyLk7EVREVNZVhqNjjCEWmdmYvyumwK2qwtdwTL3pbfnJZ31ulS3V
         koDTRZ++nO55bA9mQllrLFWtXavPhCwoXG+etKncXc/6qiPcR/RXc6/I8+PlZi/BooIP
         8hnYZeL5VuzoDHdJA5EfrvMnAxQjYUrW7x12zft59mQE+ldlpDA6ZwLOE75rxTOibCnE
         e02xF3LBiY6L09hwhJUIoBKYzwSiy/5LXvVtjkUS3/YEft20EHm6OORfFfwu0L8LP0xT
         +K4A==
X-Gm-Message-State: AOAM533aR9JkEsafmuiyJw87FtGFI5W7YFDg3yVwcHuthBPyTc2CLD+N
        Z1k3ApbDjDQ9359V6mK33IZ2N84tGjmzocodak6BCaYTJXTy2vpZ0nSvVvU5HiCXPS+ARhtJePT
        9Q/hh0T7zA8Mvsto0x59HaRXOevEghZpyKkZJaV1H4CyvNwx1A4c1HFfZBaeA22YHwEOI5g4Zk7
        ShYMOd19C6loU=
X-Google-Smtp-Source: ABdhPJxlzfqgQoVOBQGvZodCQokQfmfPu6awgfesmE8yyGdu3witjlRL4evEuvOQEZIhxVVQJTuEtwn0QoVnDvmplQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ad88:abe:9fd5:a5fc])
 (user=howardchung job=sendgmr) by 2002:a25:6a83:: with SMTP id
 f125mr10235299ybc.120.1617272731442; Thu, 01 Apr 2021 03:25:31 -0700 (PDT)
Date:   Thu,  1 Apr 2021 18:24:43 +0800
In-Reply-To: <20210401102447.3958224-1-howardchung@google.com>
Message-Id: <20210401182328.Bluez.4.I6981df13b7eda6fd9e0a46f11211565a3826ec95@changeid>
Mime-Version: 1.0
References: <20210401102447.3958224-1-howardchung@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [Bluez PATCH 4/8] input/hog: block connection by policy
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Howard Chung <howardchung@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This blocks HoG connection if ServiceAllowList is set and some of the
mandatory services are not in the allowlist.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 profiles/input/hog.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index d50b823213b5..af4f73daf2b1 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -168,6 +168,27 @@ static void hog_remove(struct btd_service *service)
 	hog_device_free(dev);
 }
 
+static bool mandatory_services_are_allowed(struct btd_service *service)
+{
+	static const char * const mandatory_uuids[] = {DEVICE_INFORMATION_UUID,
+						BATTERY_UUID, HOG_UUID, NULL};
+	struct btd_device *device = btd_service_get_device(service);
+	struct btd_adapter *adapter = device_get_adapter(device);
+	struct btd_profile *p = btd_service_get_profile(service);
+
+	int i;
+
+	for (i = 0; mandatory_uuids[i] != NULL; i++) {
+		if (!btd_adapter_uuid_is_allowed(adapter, mandatory_uuids[i])) {
+			DBG("mandatory service %s is blocked by policy",
+							mandatory_uuids[i]);
+			return false;
+		}
+	}
+
+	return true;
+}
+
 static int hog_accept(struct btd_service *service)
 {
 	struct hog_device *dev = btd_service_get_user_data(service);
@@ -221,6 +242,7 @@ static struct btd_profile hog_profile = {
 	.accept		= hog_accept,
 	.disconnect	= hog_disconnect,
 	.auto_connect	= true,
+	.mandatory_services_are_allowed = mandatory_services_are_allowed,
 };
 
 static int hog_init(void)
-- 
2.31.0.291.g576ba9dcdaf-goog

