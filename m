Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE12C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Sep 2021 06:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D13460F92
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Sep 2021 06:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239500AbhIFGEq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Sep 2021 02:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239473AbhIFGEe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Sep 2021 02:04:34 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22602C061575
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Sep 2021 23:03:30 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id q13-20020a05620a038d00b003d38f784161so9890242qkm.8
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Sep 2021 23:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=n4Db1g8V13yhlIoYZHlELRgMzrffU04Ne3qI6LPD+r8=;
        b=tHRFJTpJhlg7x0MARzJ/stRRZS6fXrd+AW0/MkOd+pQ2u0Hntvg5eyQHkDt2a3gXsy
         9zmj+YDkTa/GV1ngK75qJ0b2EHAdelTtaAWb2B+5d4jiHu4Nzp5af1KvBg+n0t1dCd3r
         yknjPFM2Eh1xrAPxer3NrKrpOlQAeUPGxvnDzlvsEZaJySb+TFTW4z6BdDJjANoHlmYy
         /+AwvgWAyHHeSgAqz6JskN+lKhE0hbWFDUDelEyppZVwJ42L+k9Lla738hLg3RliL337
         JxaGf5nXn6e8OFYOdMiLxC8zq7KSu68MRXViS/oN6MABXlt2PfhjVfcJyA52Bm6ncRbx
         VJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=n4Db1g8V13yhlIoYZHlELRgMzrffU04Ne3qI6LPD+r8=;
        b=N04kuTlWOzvLtRcoDJWM/B/tVeO3NT7f2Xf1dUitSDxYGj3WXdM3p6zp3tqQ8to+If
         UNeZqlOOO98zds9vOBuUi17N2355h7KLwOhpBWErCzuaNz8sB2MUe/wuUiutZEL1lujJ
         DSIJTMQ2WnUr+0DINWx/pMMN7iHJdMLol6r3hwdTgb7HfeEVDtaiz9lkUazvcJyHiLoO
         UKUYzCPCtYLddOw4qkFkqyZEJKbCN6mK2pH/bgKTRrVTW8m4/sr7rRTGpeF2FQgBLFcv
         fnYTanqwkDb4RQqsJ8pTwyYyd+jFHHzlo+BTQywY+lqbjhGm8GcfuKvR5tLyZGQnAE6e
         J0xQ==
X-Gm-Message-State: AOAM532VHmNSqnAel6lqDDrQtJ28g9SLIVhOvpug20AGc7u04oRkVnAL
        8OM19BVSJLnbihZOA2t7CLPHUnYxyElC9xwlRrvS497fWvvQT5N+Pz1YGlwnL+BsN37oZ67Zjcl
        RMp2SV970wOB++6YyNg2qibfqGzAjWP8Y9/DLu6t8HU2C/66ooWrAyF/jdflVtdhDJHVhZlRV+N
        xT6A61uIQsZMU=
X-Google-Smtp-Source: ABdhPJxQTgcjwrB2cWSzMHWkFKONyAkmgpuA28YxdrsB3UQjsXHn2kFddEWmvn0HloMzOsKEdhmCUN4yqiVbHI6oRA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:d42:c8a9:b5b9:8c48])
 (user=howardchung job=sendgmr) by 2002:ad4:55eb:: with SMTP id
 bu11mr10565563qvb.57.1630908209316; Sun, 05 Sep 2021 23:03:29 -0700 (PDT)
Date:   Mon,  6 Sep 2021 14:03:17 +0800
In-Reply-To: <20210906140250.Bluez.v2.1.Id597e5ae87e680e6a744a8ed08d5000aacfce867@changeid>
Message-Id: <20210906140250.Bluez.v2.2.Id6fa258f1381f5913f06dfa27f3946339033cec3@changeid>
Mime-Version: 1.0
References: <20210906140250.Bluez.v2.1.Id597e5ae87e680e6a744a8ed08d5000aacfce867@changeid>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [Bluez PATCH v2 2/2] plugins/admin: create admin_policy_settings if
 not exists
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Shyh-In Hwang <josephsih@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

If admin_policy_settings is not found when loading, we should create one
instead of printing error.

Reviewed-by: Shyh-In Hwang <josephsih@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---
This patch has been tested with following steps:
rm /var/lib/bluetooth/admin_policy_settings and restart bluetoothd.
Check if the file is created.

(no changes since v1)

 plugins/admin.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/plugins/admin.c b/plugins/admin.c
index 82c00cabdb6b..8390f3c32bbd 100644
--- a/plugins/admin.c
+++ b/plugins/admin.c
@@ -67,7 +67,7 @@ static struct btd_admin_policy *admin_policy_new(struct btd_adapter *adapter)
 
 	admin_policy->adapter = adapter;
 	admin_policy->adapter_id = btd_adapter_get_index(adapter);
-	admin_policy->service_allowlist = NULL;
+	admin_policy->service_allowlist = queue_new();
 
 	return admin_policy;
 }
@@ -335,12 +335,8 @@ static void load_policy_settings(struct btd_admin_policy *admin_policy)
 	char *filename = ADMIN_POLICY_STORAGE;
 	struct stat st;
 
-	if (stat(filename, &st) < 0) {
-		btd_error(admin_policy->adapter_id,
-				"Failed to get file %s information",
-				filename);
-		return;
-	}
+	if (stat(filename, &st) < 0)
+		store_policy_settings(policy_data);
 
 	key_file = g_key_file_new();
 
-- 
2.33.0.153.gba50c8fa24-goog

