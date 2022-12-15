Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51E0C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Dec 2022 21:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiLOVLF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Dec 2022 16:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiLOVKp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Dec 2022 16:10:45 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8D6101A
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Dec 2022 13:10:44 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d82so434643pfd.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Dec 2022 13:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=68vaj7UUjIk/YKVH/9G5WtLzbSv+dwXmG0Wr1zSKcU8=;
        b=EYzfADYI2RDDn/mAWyJrVfNMg5Z2bpjh9D8FBVzuPm4c4MrpnCYehoYzMFhqICvuF1
         /auFW4IiG3ddmHesXnnANq6yikmfX+nJc17r9/zHFBeF2q50N+gdqKEjZRfaY9mqMIxV
         T8bAT2HOV+kDqsu6TBGt63b9ZyRYTxkrdv8Suy39on1yhwrCJZ35YOGscbPbmfPkomC5
         vY8gAkUzj1W1PLC94f8aTGN8cHJhr/ZhBPHVSAErdtuiiiqAe/PkSU9IoNvxYfcUnRjT
         OhVmM6Mq6YkE/FrWWzwOFKYtcI0lF4B/alpVyP3hQSKWw6a8Lu0xkixhLtbLI2IX4SgX
         agIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68vaj7UUjIk/YKVH/9G5WtLzbSv+dwXmG0Wr1zSKcU8=;
        b=HJO/iORyZOquxcFMCQu4xKrJ0vW4mDDzz6jYZjmSIXN49PmfL6pi/xZ/x/yQpt6AaI
         BZYU/Y2ZF9zDEryJI5DxUihtOVPOB17Gy6qrLNOL+mCnDIBEeYjmIYuLCt2WAaRhqAIQ
         oCwFrYhavlTWyDI5UdIqY+09m+lj+FNUdtdbGGeXthlNbugoC5HPAQvw7G2ESUZ8Dc28
         l/qGObq1vxvk3VbELWebUcjM0SsABQDoTZw8QcHvKJUMP3xE7sxGLMW4hdAgfPvulJGB
         u9kesoYsehEK/76d67etPpwSniE1O/HvW8E+3l0jFg67/gnq/eKnbQp0fYk78Kq/oQQ0
         ACvQ==
X-Gm-Message-State: ANoB5pm79jGUUMc5CGq3mhAQ0BWUo7ytzKi8CLTvAe+ycPpF3OHnZJ1B
        py7tnb4hnxKRixtt9StzDjaHI3IzeKvc1yjV
X-Google-Smtp-Source: AA0mqf5m0lz6TZWmkwX9dHxfxJTz2Wqr/JG6AFKYl+TwfySZ/JLuDyIsrMqP/cSSE1v3DsyamUI7Iw==
X-Received: by 2002:a05:6a00:d4f:b0:569:a128:674 with SMTP id n15-20020a056a000d4f00b00569a1280674mr27025195pfv.33.1671138643442;
        Thu, 15 Dec 2022 13:10:43 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id c20-20020aa79534000000b005779110635asm54908pfp.51.2022.12.15.13.10.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 13:10:42 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/5] client/player: Print transport progress
Date:   Thu, 15 Dec 2022 13:10:36 -0800
Message-Id: <20221215211037.2686489-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221215211037.2686489-1-luiz.dentz@gmail.com>
References: <20221215211037.2686489-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This uses bt_shell_echo to print out the transfer progress on the echo
area.
---
 client/player.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/client/player.c b/client/player.c
index e73ed6ac925a..6e33274d320d 100644
--- a/client/player.c
+++ b/client/player.c
@@ -25,6 +25,7 @@
 #include <sys/uio.h>
 #include <wordexp.h>
 #include <sys/timerfd.h>
+#include <sys/stat.h>
 
 #include <glib.h>
 
@@ -91,6 +92,7 @@ struct transport {
 	uint16_t mtu[2];
 	char *filename;
 	int fd;
+	struct stat stat;
 	struct io *io;
 	uint32_t seq;
 	struct io *timer_io;
@@ -3379,6 +3381,7 @@ static int transport_send_seq(struct transport *transport, int fd, uint32_t num)
 	for (i = 0; i < num; i++, transport->seq++) {
 		ssize_t ret;
 		int secs = 0, nsecs = 0;
+		off_t offset;
 
 		ret = read(fd, buf, transport->mtu[1]);
 		if (ret <= 0) {
@@ -3399,10 +3402,19 @@ static int transport_send_seq(struct transport *transport, int fd, uint32_t num)
 
 		elapsed_time(!transport->seq, &secs, &nsecs);
 
-		bt_shell_echo("[seq %d %d.%03ds] send: %zd bytes ",
+		if (!transport->seq && fstat(fd, &transport->stat) < 0) {
+			bt_shell_printf("fstat failed: %s (%d)",
+							strerror(errno), errno);
+			free(buf);
+			return -errno;
+		}
+
+		offset = lseek(fd, 0, SEEK_CUR);
+
+		bt_shell_echo("[seq %d %d.%03ds] send: %zd/%zd bytes",
 				transport->seq, secs,
 				(nsecs + 500000) / 1000000,
-				ret);
+				offset, transport->stat.st_size);
 	}
 
 	free(buf);
-- 
2.37.3

