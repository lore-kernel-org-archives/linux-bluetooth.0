Return-Path: <SRS0=z6V2=3H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8532C32771
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Jan 2020 20:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7180824683
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Jan 2020 20:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQH0eRHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgARUoa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 18 Jan 2020 15:44:30 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55294 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbgARUo3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 18 Jan 2020 15:44:29 -0500
Received: by mail-wm1-f65.google.com with SMTP id b19so10628759wmj.4
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Jan 2020 12:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WmfzQQ9glTtECKXJGB4meUhsJtHk+rGJ/Yy9lO2RAWU=;
        b=mQH0eRHMOQiCLits6AIRkx1REdqopgLCl8Lky5ImEtwzkhhm0n/jjaJwOXhXDLKFOY
         U+vx4HREoE1w16pRLxXUTkYJYwjYj653PLrgbyRclrFljZy6Bcyop+I17zbjAOhcv/hc
         5HiouzYgGG4UIZojpqU8dWxXN44d4/mody0x9dr7LPrSUSuiiLF9pUvazMaT1+McM4mA
         hBH7XLDNeY7fkeBAHwRLcdifXKDafuJvraxiixTmFMlG8017GIOHFD93bxT+iOuGFldR
         4Lvo3+XoAcxiaE1Jk91d446KvgVW4nsWo78zy+G+50PeclqWxSxVKp+tfKbGVDd60jjk
         PxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WmfzQQ9glTtECKXJGB4meUhsJtHk+rGJ/Yy9lO2RAWU=;
        b=bbk/0mb4nnHHg5d9z18lhJUopIsIzeuFC53um5fKiKAxnxqduUPRQ+RE2ypaPXk6Vz
         LkYRADuvsSjhc/XP4Z8drOUdRWVfUxwE65VnFaxCGJ7dCclzMrjbYthoENwXcoTqo7+d
         /iVsvVio+aoC93W/Cilypm6MoQ99Twfi/l5rU1v1At+5547kDrVJbA942v58CsgnmrDn
         KK6y2UX2DA95Jh2Ts/WWunXmqZLJhjNLsKvyThBhUSvKlrlD93W89WAjDsU7R2lgk5sZ
         jO4bfk977nSIFttuSs4a2LjFd1+s/6LwIXPKKycsLqecCPlJX1gCqujr7xkWDVEbpgfv
         AqkQ==
X-Gm-Message-State: APjAAAWvk+EkpGcVwaGxF6LdvKpI5RvSNTVLB0aDOUar5zVu9gmqPym/
        Iihj7P+L1N+B6Niqu5bBPBI/4w4c
X-Google-Smtp-Source: APXvYqyiM62MaJPB+lqIJpusUXnBRZgW8lKqjDaIivxkXvvxXmny/CCtI01Vf78m7GnAo5z1RM5qKw==
X-Received: by 2002:a1c:22c6:: with SMTP id i189mr11146070wmi.15.1579380268500;
        Sat, 18 Jan 2020 12:44:28 -0800 (PST)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl. [94.209.165.62])
        by smtp.gmail.com with ESMTPSA id h66sm17645051wme.41.2020.01.18.12.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 12:44:27 -0800 (PST)
From:   Marijn Suijten <marijns95@gmail.com>
X-Google-Original-From: Marijn Suijten
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.von.dentz@intel.com, Marijn Suijten <marijns95@gmail.com>
Subject: [BlueZ PATCH] shared: shell: Only omit consecutive duplicate history lines.
Date:   Sat, 18 Jan 2020 21:44:23 +0100
Message-Id: <20200118204423.494209-1-marijns95@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Marijn Suijten <marijns95@gmail.com>

Change rl_handler to append duplicate history, as long as it isn't
identical to the last line. It prevents consecutive duplicates while
still having an accurate overview of the most recent commands used,
mimicking most modern shells.

This addresses my only major gripe with bluetoothctl: pressing UP does
not retrieve the last typed command when it is a duplicate of something
else written (much) earlier in the history. It is especially noticeable
when needing the same command repeatedly.
---
 src/shared/shell.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index cfdcc76c4..2e094b8f1 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -681,6 +681,7 @@ int bt_shell_release_prompt(const char *input)
 static void rl_handler(char *input)
 {
 	wordexp_t w;
+	HIST_ENTRY *last;
 
 	if (!input) {
 		rl_insert_text("quit");
@@ -696,7 +697,9 @@ static void rl_handler(char *input)
 	if (!bt_shell_release_prompt(input))
 		goto done;
 
-	if (history_search(input, -1))
+	last = history_get(history_length + history_base - 1);
+	/* append only if input is different from previous command */
+	if (!last || strcmp(input, last->line))
 		add_history(input);
 
 	if (data.monitor)
-- 
2.25.0

