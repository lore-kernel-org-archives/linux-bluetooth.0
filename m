Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CA7C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Mar 2021 23:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88DFA64F2B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Mar 2021 23:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382693AbhCBW4N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Mar 2021 17:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235798AbhCBC0q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Mar 2021 21:26:46 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A208C061756
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Mar 2021 18:26:00 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id m68so431737qkd.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Mar 2021 18:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=3lK7qtmb9qu0L14EO6BNTMVE9Evr9mpXrwy4rDRz9K8=;
        b=kE8LT6R4ASO7nop8zU93qTF8XyoX/9JvOK5Bb5d13BqEM/mxoqGGHyKN78lnxmITdV
         wM/IYhClOTzyL2NzLCn98dSz4XztnR6TQjqMZzhNyIFEPwbxfBxD9OaV/4RuOkDUbFDN
         sWn0/+FlI1VNp4H54IZq2GXEnjKLFFx/RuQFlmxL1o6jGHFuVdD1ezILwRcBQM/n0rYf
         i4nPWcgLeoUFyDNSaxpZ35SjhAWMbHofoFF3FjGC9fS/0OWrpay3OX4GPXEHjVWuDaLX
         PK+llIx44TZmnkTADxFEMEwLDGlukrLRuK8y3saJrroR6nHp93ALyIyDWmCXL7dut13R
         hFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=3lK7qtmb9qu0L14EO6BNTMVE9Evr9mpXrwy4rDRz9K8=;
        b=Btmhhhalh7VbBG87XvJP85AtF//yUGT/aPbXtxv9rZcQpt2EbtoA81GkG3cl9VK6nG
         EjPZoQo4UEq7D+1zJe+5QeZi6/qQwDSGKB/0hwNyKmtJJmiLARz53Y2yvaHTmlPx/Hk8
         MYAu9LMd9shDx0xvnbn3QRb8oaKqyIXAswIjtVfFsZpByLZ68iO1tK9k4rETVKOhJ2OX
         G/fbZT99A83g76Ft1w/k+JfRHKTDpxYAq/ZfrQSXq66ufkB57aC5N7Y6KWDM9eawsQbS
         lsRoVQCM89OBkwpO65wE5GU99oGjH4yKHuchRYK7DDIgXPYStGek7PeCVF67rl2GQLoJ
         Q/sQ==
X-Gm-Message-State: AOAM5320EPHGDZbQFYX7WdVNf1Lnu+hEAtbhATyipXG+lJuqGcpucWKh
        JvucXgq0+rcC3c+H8vhAecAu1rEGw9MZTl+aN1m63MkkJeBLVykG3BsZcXw2qas6k3H5JFwKoc6
        C3EzUbC2T5ZuHXofgPBC4scL2IFyBvz2ftdY64GAwQw3vOyNPwt1J/gdfVxkO5yb8pO2AVL4vAV
        nqf71FEwAg8e4=
X-Google-Smtp-Source: ABdhPJwpkHUDzbLSTlmahgkPJPYfMfpJHsvgHmRkAJ1mnJhhKaJRUhgfTYQLBNf/rbgP1LdkzfoPaalN+9p7ky4xsA==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:3d9c:9966:34a7:ca58])
 (user=howardchung job=sendgmr) by 2002:a0c:a954:: with SMTP id
 z20mr1702044qva.29.1614651959492; Mon, 01 Mar 2021 18:25:59 -0800 (PST)
Date:   Tue,  2 Mar 2021 10:25:51 +0800
Message-Id: <20210302102506.Bluez.1.I4b5a2f5249af5dbb7234c6831943dbd8de7c271c@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [Bluez PATCH] core: fix a typo in dev_connect
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Howard Chung <howardchung@google.com>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Based on the context, it should be 'at least' instead of 'at list'.

Reviewed-by: Alain Michaud <alainm@chromium.org>
---

 src/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index dfba6ee47d07..b99f6fbb04fd 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2105,7 +2105,7 @@ static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
 
 	if (dev->bredr_state.connected) {
 		/*
-		 * Check if services have been resolved and there is at list
+		 * Check if services have been resolved and there is at least
 		 * one connected before switching to connect LE.
 		 */
 		if (dev->bredr_state.svc_resolved &&
-- 
2.30.1.766.gb4fecdf3b7-goog

