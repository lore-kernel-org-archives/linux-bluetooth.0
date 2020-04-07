Return-Path: <SRS0=KN4I=5X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40CEC2BA1A
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 01:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5811620719
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 01:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="mLI/z2ax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgDGB3M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:29:12 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:36470 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgDGB3M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Apr 2020 21:29:12 -0400
Received: by mail-lf1-f41.google.com with SMTP id w145so1065937lff.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Apr 2020 18:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x3szywOcMtDHg15QiLa7lQMOVT2IEvzqqE6CTNlZ6bA=;
        b=mLI/z2axfsXGQyWxfQtRlaUDk3j8zJh+8ibhFf+kWWwwc2Fga+60wJjuZqAPaLff2a
         dHuuBlN9yzkrfSAnSDcfW0neCziCrQ/2FBdiSX8LwYa1/DvUfcxcdR7z74xlmvqYvokc
         HRlaLTysnhRW6l+yIO3LJaoTT1B+gbI6ApnFT1OCRF00kJY+vkQVvMPA2mV/1KT7Eud+
         YMpa7ydmrG6bdL4gU7P30x4kBlsZvt6jb5ln7j4Fnvc0FRlKZUxyGqMdKghnEOHOBjy5
         WPp2oa/qJQjTb2WeGnU06AUP1wo02Wtv7NzFX/Y0cGp1qgyN06OerDwLbqgDwCDvaFaq
         me6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x3szywOcMtDHg15QiLa7lQMOVT2IEvzqqE6CTNlZ6bA=;
        b=WxVzXgK/fkQj6d+QNYWw21dN+GzxM0dFhq2y/T5ggX0Z/kWT6+AkaCjlCym8W7sJNZ
         a3QDBqA3CfrxWIX5HW6eJY2rdj6anwEQQLUykJ/pzq6E0vq8LrQhnCbTQAoUZNTn+kG6
         7NUw+Awp27NEV/2xzcfuNxt0BT3mLoBLpMOLctZY8nWmIZJkZRAhM73aOr9rphiHeXdt
         nV1HpKiYhiyqxXT57ozQ5n4JgBiHw5I5Q+G2yunhdi0DiMdOW27Bl+XoVgC4/2KYNM5c
         Lnf0FwfVjpKBHxFrfMxjmXlk2+VCHhF9J/LysD/oDUaVk1VS1HSs0harDLJ8YetCavJi
         UQkQ==
X-Gm-Message-State: AGi0PuZKy5BFULJ4R3aZMk/0FGU85Em0fJo+KHRDl8Q2HpeUHp7Be5lH
        ObQI8AHvtW40ySlXueUuj6GuckGmW7E=
X-Google-Smtp-Source: APiQypJrUn2iUBHHkx4hcS42Orm8V96EUxZjGrQIUHsTT3zDioprBKYebL9iaEqP3TfHbduf5SsRNQ==
X-Received: by 2002:a05:6512:3b7:: with SMTP id v23mr14426342lfp.66.1586222950714;
        Mon, 06 Apr 2020 18:29:10 -0700 (PDT)
Received: from localhost.localdomain (45-11-60-42.ip4.greenlan.pl. [45.11.60.42])
        by smtp.gmail.com with ESMTPSA id c2sm13006109lfb.43.2020.04.06.18.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:29:10 -0700 (PDT)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] gatt: Fix AcquireWrite and AcquireNotify server support
Date:   Tue,  7 Apr 2020 03:29:06 +0200
Message-Id: <20200407012906.166736-1-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Register read handler only for notify IO and handle socket
disconnection in sock_io_read.
---
 src/gatt-database.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 483c84341..92e24e5f7 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -2358,7 +2358,7 @@ static bool sock_io_read(struct io *io, void *user_data)
 	ssize_t bytes_read;
 
 	bytes_read = read(fd, buf, sizeof(buf));
-	if (bytes_read < 0)
+	if (bytes_read <= 0)
 		return false;
 
 	send_notification_to_devices(chrc->service->app->database,
@@ -2379,8 +2379,6 @@ static struct io *sock_io_new(int fd, void *user_data)
 
 	io_set_close_on_destroy(io, true);
 
-	io_set_read_handler(io, sock_io_read, user_data, NULL);
-
 	io_set_disconnect_handler(io, sock_hup, user_data, NULL);
 
 	return io;
@@ -2537,6 +2535,7 @@ static void acquire_notify_reply(DBusMessage *message, void *user_data)
 	DBG("AcquireNotify success: fd %d MTU %u\n", fd, mtu);
 
 	chrc->notify_io = sock_io_new(fd, chrc);
+	io_set_read_handler(chrc->notify_io, sock_io_read, chrc, NULL);
 
 	__sync_fetch_and_add(&chrc->ntfy_cnt, 1);
 
-- 
2.25.1

