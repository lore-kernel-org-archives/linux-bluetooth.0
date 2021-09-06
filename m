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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C05C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Sep 2021 03:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11F2560F6E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Sep 2021 03:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238511AbhIFDlU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Sep 2021 23:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237574AbhIFDlT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Sep 2021 23:41:19 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8B6C061757
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Sep 2021 20:40:15 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id w2-20020a63fb42000000b00255da18df0cso4052982pgj.9
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Sep 2021 20:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vXuzu/Z+J0Wg0UNmJT6LQXT5ypiablE/lzNgTc8r25Q=;
        b=enPtM/sZghbPl3JcCkreMhTHldjB6RfV3sVA8Cwr68XFT7lOHMMmdlDHqSrwgwuJvC
         cIKgNSBW+q7QaCOC+Wr0LKEKoWkuFWpxcGVKdHqWOF2aFq8+kBsPC0KyW+ItkqXaADV9
         3CxbQ+tXki2BGvWei3It/e+OZU5pnbrFKwV8NxEmM26dAYGfCnK3+DMXm8DomIBXvNxE
         izY9wMPT51xv14Etj7LVlPV6aZlRlotc6MPFHqRPUTwrWv7ZhlcQ8CEouA3i3LxoM0aF
         HAJC/1F9LyVqfUUWWcPNjAOSCSy+8m80q7j7qKPhCqu0f0E9CzX2DDzpIQHMDvG2v8CP
         0J7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vXuzu/Z+J0Wg0UNmJT6LQXT5ypiablE/lzNgTc8r25Q=;
        b=U/Ndu0k6Du7iOeWL+TXCwE2ppfhnRD99/e66heqhC0XDz2FdkB87tEAFbEgnZhkU+1
         xBEK8+nGcTdOhpA5tEYdZiognohBc/9TlPZwfZIhndbhx6QCXRI1VIINX3/xzrid0Tp6
         f8V8bGSKpZHQhMTyf+x5IpQlU7knCKS0fid+FbtGuPC3oOyUmye7SnqkTG5DSe1PGKd0
         1DDGxcrutUJLoNr7/UqGrh8/bUQcJWsR8xipIrNqLjVxTNDlktn6dZ7r675ewtvlSXm3
         sa7rg2qOppZlPD1pWQQfT7SMCwwoZXgsIFTS3T9nrSBY1WootBwvXthA2rh1Oj7Vo23q
         zgPA==
X-Gm-Message-State: AOAM532cb9qa/Pv1FBkxwfoS98GhCbelolxMe1upAezjKKnFlxidXaW+
        iJjxGVezMn5A3Dt9G13NCjrIbHl0mkuBlxsEXSa8V+VelGsCnWNPosnMxfP7zm6zGPKbduE2yPj
        0aQEuUj94PB9hmVXJIJVbFj8mcbLc0HhmCz8o+zePHxd9VejsEM0CuM0dXQjioaDXL7EV0sM6fP
        8NmuEr0NmCprs=
X-Google-Smtp-Source: ABdhPJz2wsi4hRM0dsHhaC+DnX1ywf4N9gjlBEp+iNJiLhWaBA7Qd4scxj/ejh/QjSv474LpWV7cvDJMtyR8t/OxmQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:d42:c8a9:b5b9:8c48])
 (user=howardchung job=sendgmr) by 2002:a05:6a00:1404:b0:412:901a:3b36 with
 SMTP id l4-20020a056a00140400b00412901a3b36mr9889660pfu.52.1630899614326;
 Sun, 05 Sep 2021 20:40:14 -0700 (PDT)
Date:   Mon,  6 Sep 2021 11:40:06 +0800
In-Reply-To: <20210906113953.Bluez.v1.1.Id597e5ae87e680e6a744a8ed08d5000aacfce867@changeid>
Message-Id: <20210906113953.Bluez.v1.2.Id6fa258f1381f5913f06dfa27f3946339033cec3@changeid>
Mime-Version: 1.0
References: <20210906113953.Bluez.v1.1.Id597e5ae87e680e6a744a8ed08d5000aacfce867@changeid>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [Bluez PATCH v1 2/2] plugins/admin: create admin_policy_settings if
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

 plugins/admin.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/plugins/admin.c b/plugins/admin.c
index 9440581409fa..fe1d71acbb8f 100644
--- a/plugins/admin.c
+++ b/plugins/admin.c
@@ -67,7 +67,7 @@ static struct btd_admin_policy *admin_policy_new(struct btd_adapter *adapter)
 
 	admin_policy->adapter = adapter;
 	admin_policy->adapter_id = btd_adapter_get_index(adapter);
-	admin_policy->service_allowlist = NULL;
+	admin_policy->service_allowlist = queue_new();
 
 	return admin_policy;
 }
@@ -337,12 +337,8 @@ static void load_policy_settings(struct btd_admin_policy *admin_policy)
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

