Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75302C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Nov 2021 04:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F07E60F6E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Nov 2021 04:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhKLEEs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Nov 2021 23:04:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhKLEEr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Nov 2021 23:04:47 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9666DC061766
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Nov 2021 20:01:57 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id l28-20020a25b31c000000b005c27dd4987bso12541854ybj.18
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Nov 2021 20:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CLFR7UsLmEgGUiePnQAwLRnpCGFNapaKEPNLe90f3zc=;
        b=ZF6gdKrOEQHhozKxRkraOPvfK1a1HBRsJoFwX6TjkxEBmdtt9Qk6Zc5WtSfAo6oPL5
         +4jDh1sWiqd7udnE3XNgYrRawlis8fANgng/K61zfsvSpemvoOXSjHCcMOgzyN++BKvU
         TWBG7tixzuwW3/96KZ2fJQf87rI8pjTH2kwjocRSrR3DAka40JjObtVHMMmtnIjl3XD1
         7QDEv7rnAvURTvhWEX5oameXyYAHmhy9F7DBEcs5HJHVDww8K/06xXxyt2PVDnFHPHj8
         mLokKHJ6/DX3/gtMTsdjkSNJU7psd6cahgSCfymroB/+z34mt1BOiPofueglppfS4pce
         E9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CLFR7UsLmEgGUiePnQAwLRnpCGFNapaKEPNLe90f3zc=;
        b=J/ly49GgIGLZnaZZLrhxRwiduBPFn+cDviivb78W7IQ0cBf6oy8ZB7K7Vi+Bymi3TE
         KnHpjeA2T5+tT1rEaZxc4XCXIG95YoJcyKnYx/JEH9lpqZLE7hB0ae5NjfGAAVMjOfN8
         or+Ty5ysFd/fzj9uGJqXytP7ckta0WlsYUEWvM9MZ+75W9gh6xJw1iuKfl28RPNHmCwj
         POBhmFgMq7QUuMYpltsRiUtRiXC+9wxtzC8Dld/ZdtuPl4ecc9uxES9ETq451U/+pk6P
         sLhEfhhr1g1tbAwJ3hue6KIRIzGUFxqZ3bntYlta7aDR2CJA8dRLH5rCClnZHtkLnHhO
         ybbg==
X-Gm-Message-State: AOAM530NNArmSD8N8n2Z7ObLKnmw0eVZNrRjPzyOJXT1iG9uYIhp04gF
        ajMW+i9UzBsT+SANdzpuCJMJ3oOUBHuWVJ1KTRZvpVfHiZdteEUuzAO8dYlIO3FFAvYaZEHzXtu
        NK/L9Gb4v0jQp03N7ExvGu7UzNF2QgtwXn54dplVqYeDuUVkygGoyrtRSra7e/30P/EEzV0hkci
        PxVdCCDV1kxBI=
X-Google-Smtp-Source: ABdhPJymPwPbSh9sUsZwNbl+bekmbq/PDpzWUlo1rStasbp+k+a7EWlrxmwKeY9KuU3n2i4lBXvx7LXgM7pyYT9LjA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:6513:63fe:a628:1001])
 (user=howardchung job=sendgmr) by 2002:a25:d743:: with SMTP id
 o64mr13623586ybg.81.1636689716581; Thu, 11 Nov 2021 20:01:56 -0800 (PST)
Date:   Fri, 12 Nov 2021 12:01:49 +0800
Message-Id: <20211112120136.Bluez.v1.1.Ie043f3613eba798be6f87213a6737c447634a71f@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [Bluez PATCH v1] admin: fix devices not reset
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

When |admin_policy_remove| is called, we set |devices| to NULL but never
set it back until |admin_init|. This makes admin lost track of current
registered device interface, so the next |admin_policy_removed| will not
be able to unregister those interfaces.

Reviewed-by: Archie Pusaka <apusaka@chromium.org>
---
tested with the following commands
0. device X is paired
1. rmmod btusb
2. modprobe btusb
3. [bluetoothctl] remove device X
Verify |remove_device_data| is called by looking log.

 plugins/admin.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/plugins/admin.c b/plugins/admin.c
index a8e7d2cd7898..0787e8381ed7 100644
--- a/plugins/admin.c
+++ b/plugins/admin.c
@@ -496,6 +496,9 @@ static int admin_policy_adapter_probe(struct btd_adapter *adapter)
 {
 	const char *adapter_path;
 
+	if (!devices)
+		devices = queue_new();
+
 	if (policy_data) {
 		btd_warn(policy_data->adapter_id,
 						"Policy data already exists");
@@ -623,7 +626,6 @@ static int admin_init(void)
 	DBG("");
 
 	dbus_conn = btd_get_dbus_connection();
-	devices = queue_new();
 
 	return btd_register_adapter_driver(&admin_policy_driver);
 }
-- 
2.34.0.rc1.387.gb447b232ab-goog

