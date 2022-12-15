Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6C9C3DA78
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Dec 2022 21:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiLOVLC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Dec 2022 16:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiLOVKp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Dec 2022 16:10:45 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1AC5F7C
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Dec 2022 13:10:43 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id f3so480408pgc.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Dec 2022 13:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJsP1JYOTVWNXZaAAf4aqeAwsVljV5PglWKu2WbNtNs=;
        b=qksuDV5s70pIDOLQbuzta6KXUN0qfb4UgqAl/Yu+70iyHmVcjlbBoH+ef2rQ0ZkJda
         WX88pVJv2HaGS1o9mP4uhvTebN8rGoxhjP0+OgmdoASayHVEuln7+GBenU2kCN32c1wn
         RLQNjq/KtHaN1yEL4zpzQjLM9EtA26p7yVDGCghZHaq8xPixZnBlNw61BNwTjFg+IyIV
         PzCBxV4G3FLVOnpEadHnHklLlf3CDIWKaXlAfFarLsw0OtO4vkPeD0wUySOFowWN94JP
         X8U1B/5Kxxa25tPjCFVWKgdmdZurkRxc8Nk/zy+YPC57NUNPEmn7EBhF8nRc3HnIYM4h
         X+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJsP1JYOTVWNXZaAAf4aqeAwsVljV5PglWKu2WbNtNs=;
        b=0hhu06FUo/OolriC2zGzQzhXgKNCTrsuc+pYfyS5EhUqk8qaQbQE+HQZroAJUL/33x
         gwAypXbowjccHH+p25aPJKpR1QZtgH6SY1qYnBOpNVnheYs9xoaiGr7Lkos4tvLeYzEq
         LvjKt5dKukGxkC+ap2E56J2I9b5Us2Oz8rmrzhJz/WDB1M08CKAsGBbyhpmf7kv3OAXs
         vStXLJBHgwAmug4p7YuZ4Wosco4NsU+AWvS9Fk0SqRd8vYo1uSo1UF6HPbN5lyEsE71d
         K86GADEaqw7CPsS69P1hdLP592IeNPB9NjJlHqFGlHpJ8j1F6jkCQtgMztaxfQ9T85A/
         GmsQ==
X-Gm-Message-State: ANoB5pmY2va9F47iRS2+EVmYCj6zneouWUvXlqKrak7bAOvO1ASLuoFV
        /KkUg6F0s4FF8uhqKFss+bo0w6hoE7z+EVQ4
X-Google-Smtp-Source: AA0mqf6q7cT5ihSQRsZzLmuRFvLGeIDXHiYxBsqJSC4yI6ofQmsjNsF4lMABwvbHcbJAp2t7VSupBg==
X-Received: by 2002:a05:6a00:796:b0:577:3523:bd23 with SMTP id g22-20020a056a00079600b005773523bd23mr30721586pfu.27.1671138642218;
        Thu, 15 Dec 2022 13:10:42 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id c20-20020aa79534000000b005779110635asm54908pfp.51.2022.12.15.13.10.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 13:10:41 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/5] client/player: Use bt_shell_echo to print transfer progress
Date:   Thu, 15 Dec 2022 13:10:35 -0800
Message-Id: <20221215211037.2686489-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221215211037.2686489-1-luiz.dentz@gmail.com>
References: <20221215211037.2686489-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses bt_shell_echo to print transfer progress.
---
 client/player.c    | 12 ++++--------
 src/shared/shell.c | 10 +++++-----
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/client/player.c b/client/player.c
index 1f10387f89ad..e73ed6ac925a 100644
--- a/client/player.c
+++ b/client/player.c
@@ -3000,11 +3000,11 @@ static bool transport_recv(struct io *io, void *user_data)
 		return true;
 	}
 
-	bt_shell_printf("[seq %d] recv: %u bytes\n", transport->seq, ret);
+	bt_shell_echo("[seq %d] recv: %u bytes", transport->seq, ret);
 
 	transport->seq++;
 
-	if (transport->fd) {
+	if (transport->fd >= 0) {
 		len = write(transport->fd, buf, ret);
 		if (len < 0)
 			bt_shell_printf("Unable to write: %s (%d)",
@@ -3378,7 +3378,6 @@ static int transport_send_seq(struct transport *transport, int fd, uint32_t num)
 
 	for (i = 0; i < num; i++, transport->seq++) {
 		ssize_t ret;
-		int queued;
 		int secs = 0, nsecs = 0;
 
 		ret = read(fd, buf, transport->mtu[1]);
@@ -3400,13 +3399,10 @@ static int transport_send_seq(struct transport *transport, int fd, uint32_t num)
 
 		elapsed_time(!transport->seq, &secs, &nsecs);
 
-		ioctl(transport->sk, TIOCOUTQ, &queued);
-
-		bt_shell_printf("[seq %d %d.%03ds] send: %zd bytes "
-				"(TIOCOUTQ %d bytes)\n",
+		bt_shell_echo("[seq %d %d.%03ds] send: %zd bytes ",
 				transport->seq, secs,
 				(nsecs + 500000) / 1000000,
-				ret, queued);
+				ret);
 	}
 
 	free(buf);
diff --git a/src/shared/shell.c b/src/shared/shell.c
index 3c0e61dbc414..3358b383e9e4 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -580,15 +580,15 @@ void bt_shell_echo(const char *fmt, ...)
 {
 	va_list args;
 	char *str;
-	int err;
+	int ret;
 
 	va_start(args, fmt);
-	err = vasprintf(&str, fmt, args);
-	if (!err)
-		err = asprintf(&str, COLOR_HIGHLIGHT "%s#" COLOR_OFF, str);
+	ret = vasprintf(&str, fmt, args);
+	if (ret >= 0)
+		ret = asprintf(&str, COLOR_HIGHLIGHT "%s " COLOR_OFF "#", str);
 	va_end(args);
 
-	if (err)
+	if (ret < 0)
 		return;
 
 	rl_save_prompt();
-- 
2.37.3

