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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C17C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE154610CF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240499AbhHMMWs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240500AbhHMMWs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:22:48 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA4CC0617AE
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:22:21 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id p16-20020a05620a22b0b02903ca40d6cc81so6950540qkh.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ozoJ/YrolzTZriEgu1OutpE94ifPkZNg0KX/vpOM5/k=;
        b=Qi/BKAhrAqCmI7JCDs/U/gKZTs65o9rtb3Z7xufIbtEQxAFqQE4uV1slKVeGD09yk8
         szi1oC6Pq4/H4+LoilvFys+QJPf5tFwcsaNtVAXizj9F8Yw9SwxhgtO0OJ/aaQV22/UN
         raDVidMXzrzgN0DV+Olt2mVNpnxO5kMZ79CdcbhSDlc2CBMTgO19EqwKt4QIICYG+PN7
         aHRHWLxC5Jp6mLNi8n9TlEMhAWrO54zEreAApDtsahD3zGtqqyfWdb4aYfD0ixg4zFi0
         ZwdNGwFBgP6WWUbYZMTibWmXjB/gLkp7b+3VIiTR9dA7ainYUF472Yej7W12VwkaW8iC
         CaxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ozoJ/YrolzTZriEgu1OutpE94ifPkZNg0KX/vpOM5/k=;
        b=iJwy+2Qw+URohsNnOWztkVxS+HuwlBUIv4m1uzdzr0vZSH7E8YaLVmDDnxWrYLQH46
         F1Hmjq3w1YDpbsxd63hxiWm8SyyVBvN2J0Wzw+suWiBTJhfG3qWu6Q20tOzSrQszVW8K
         T9/Ax4qMiNjhittSgOY95rjtred1Mq0FleSZ5G3e6cPFrWGYRqrOIor+CMNnEJLKAW8L
         m+HixhHXuhvVpAVGaEmJqWeGZDnmYGDYeWKwprCxlMUyt6qN1/ge8cDRPQR0SNXZRbSj
         P/BCRDSdP6+P4T1t7ygVFzol8QFwkH7owO3mLniygKe95gkKoDjsnHbg4lElu1fBxkl0
         +Fyw==
X-Gm-Message-State: AOAM530znn3y+PKw5EGhaDfZqCiuW48s/rcdg8GvfYPFlVJQ9X38btID
        DLVrmxNilyGKmFnVKXb+ziGrOxzXCV+hjw7y+YWQb93tMicATaokF3REQpBWEnPCtznIixGXyBs
        KAnhhYv/SDtW4Tu9Vk4dPWTybf5QpoPGwd97fWXh8322C5ZeiJcl+x7AgwP7luW792ranuJ/q0S
        3E
X-Google-Smtp-Source: ABdhPJz8Lh1hWMHdk0ARZF3gxi3D14NQ3qtGCUYEh/eercKN0UUPDGiSnl+Bba930afzEfEqj9t9ZEGD3B6/
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a0c:8122:: with SMTP id
 31mr2398293qvc.26.1628857340419; Fri, 13 Aug 2021 05:22:20 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:30 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.45.I2b2dd01541d8410224c436889858ceeecb26c83d@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 45/62] tools/rfcomm: Inclusive language changes
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

"central" is preferred, as reflected in the BT core spec 5.3.
---

 tools/rfcomm.c   | 14 +++++++-------
 tools/rfcomm.rst |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/rfcomm.c b/tools/rfcomm.c
index 7ad7ca5ad6..51b397b6ef 100644
--- a/tools/rfcomm.c
+++ b/tools/rfcomm.c
@@ -37,7 +37,7 @@ static int rfcomm_raw_tty = 0;
 static int auth = 0;
 static int encryption = 0;
 static int secure = 0;
-static int master = 0;
+static int central = 0;
 static int linger = 0;
 
 static char *rfcomm_state[] = {
@@ -434,7 +434,7 @@ static void cmd_listen(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv
 	}
 
 	lm = 0;
-	if (master)
+	if (central)
 		lm |= RFCOMM_LM_CENTRAL;
 	if (auth)
 		lm |= RFCOMM_LM_AUTH;
@@ -646,7 +646,7 @@ static void usage(void)
 		"\t-A, --auth                     Enable authentication\n"
 		"\t-E, --encrypt                  Enable encryption\n"
 		"\t-S, --secure                   Secure connection\n"
-		"\t-M, --master                   Become the master of a piconet\n"
+		"\t-C, --central                  Become the central of a piconet\n"
 		"\t-L, --linger [seconds]         Set linger timeout\n"
 		"\t-a                             Show all devices (default)\n"
 		"\n");
@@ -668,7 +668,7 @@ static struct option main_options[] = {
 	{ "auth",	0, 0, 'A' },
 	{ "encrypt",	0, 0, 'E' },
 	{ "secure",	0, 0, 'S' },
-	{ "master",	0, 0, 'M' },
+	{ "central",	0, 0, 'C' },
 	{ "linger",	1, 0, 'L' },
 	{ 0, 0, 0, 0 }
 };
@@ -680,7 +680,7 @@ int main(int argc, char *argv[])
 
 	bacpy(&bdaddr, BDADDR_ANY);
 
-	while ((opt = getopt_long(argc, argv, "+i:rahAESML:", main_options, NULL)) != -1) {
+	while ((opt = getopt_long(argc, argv, "+i:rahAESCL:", main_options, NULL)) != -1) {
 		switch(opt) {
 		case 'i':
 			if (strncmp(optarg, "hci", 3) == 0)
@@ -713,8 +713,8 @@ int main(int argc, char *argv[])
 			secure = 1;
 			break;
 
-		case 'M':
-			master = 1;
+		case 'C':
+			central = 1;
 			break;
 
 		case 'L':
diff --git a/tools/rfcomm.rst b/tools/rfcomm.rst
index 3c1b8cd682..cd5daa674d 100644
--- a/tools/rfcomm.rst
+++ b/tools/rfcomm.rst
@@ -47,7 +47,7 @@ OPTIONS
 
 -S     Secure connection
 
--M     Become the master of a piconet
+-C     Become the central of a piconet
 
 -L <seconds>    Set linger timeout
 
-- 
2.33.0.rc1.237.g0d66db33f3-goog

