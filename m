Return-Path: <SRS0=OtUJ=N7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE61C41538
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Nov 2018 10:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A8220671
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Nov 2018 10:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRMI3TZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A8220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbeKTVIe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:08:34 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41727 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbeKTVIe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Nov 2018 16:08:34 -0500
Received: by mail-ed1-f68.google.com with SMTP id z28so1460556edi.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Nov 2018 02:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=hVWDEZTwAs0KIDLaSYrjFiNHLZVKxKQh8wu3PgMIOl8=;
        b=nRMI3TZKlpPzuD4TiesuZUdgqwvUU+N9OAYFiLGarwvPoty75oZWR2utVZKrszzV5W
         KiDhMVlUfLrtWgFhBCwp+JJxDtEq9tX0ZLaQV90Fh0wuPCIV6K32+4QZz4Kp9edvVqb+
         f42UaygwRIiOaRYhymBAjFo4nDpha1Zd2T6WknHDawQrcDsYtzDvSjhghqMQ24ZUziIx
         I2JArFbwmrKaWXgJu6xHR31N6GAj6RFUY9Wu7ZCawD9dwV7TRLNa/JqSSwKIUbwkQT4l
         pW4qgP1v3XJu938180qouHYchEhnX8DsOTSVQtWXmmRnJMmoW2w+MG7KYcKMpAjndaDV
         +xrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=hVWDEZTwAs0KIDLaSYrjFiNHLZVKxKQh8wu3PgMIOl8=;
        b=uWIHaUA5F848i6gIZCMlZE/hkYA+6qpJkQhKLYHgYIP17REhI9H/hvhc3rwFTo5Wq6
         r6ClP0IgckuTcM0cZuanwUf42AY1D0ok1ljLQyDmTw6vHYjoaG8DSrz51dYEUt+v9Tdl
         N+sdseRW/voripJOdwlUDxpyVCAwpYNJV2fjCcuvgvDpUG6cbfUNbKvWqQMNhUJ7+9Oa
         zNnmAcy56yrWzNeibXa/cE7kJFQVjOMmelYMaIbYCo0aBZP7mbZcQ8CqnGtG61aI8PQe
         zPURe5dFFlbYZCcdy171saYOKTBeJTetIb7t9nQinIumBohEnwXTp7sH80shcMihvcRn
         nzwQ==
X-Gm-Message-State: AGRZ1gJgzEhxgmYlaMTKtFMISWfrPLMRpUlANWg+q8GyG5jhmHcF5C4y
        5QNRnsFSuAIbzvp13iApzU1OUEm5
X-Google-Smtp-Source: AJdET5eL+eebN5fbUZZZu+VA1eYXNA3e+4gKBEy1jnXIkLpDfzt4tDL8G9dOba2NoHNXTA03dqeMgQ==
X-Received: by 2002:a17:906:3b8c:: with SMTP id u12-v6mr1591929ejf.143.1542710403986;
        Tue, 20 Nov 2018 02:40:03 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id b42-v6sm14020900edd.81.2018.11.20.02.40.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 02:40:03 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/5] doc/gatt-api: Restrict supported file descriptors
Date:   Tue, 20 Nov 2018 12:39:56 +0200
Message-Id: <20181120103959.23502-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181120103959.23502-1-luiz.dentz@gmail.com>
References: <20181120103959.23502-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Only support sockets with AcquireWrite/AcquireNotify since pipe don't
work with sendmsg therefore MSG_NOSIGNAL cannot be used.
---
 doc/gatt-api.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index be4c60c6f..8dda60b8a 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -100,9 +100,9 @@ Methods		array{byte} ReadValue(dict options)
 
 		fd, uint16 AcquireWrite(dict options) [optional]
 
-			Acquire file descriptor and MTU for writing. Usage of
-			WriteValue will be locked causing it to return
-			NotPermitted error.
+			Acquire file descriptor and MTU for writing. Only
+			sockets are supported. Usage of WriteValue will be
+			locked causing it to return NotPermitted error.
 
 			For server the MTU returned shall be equal or smaller
 			than the negotiated MTU.
@@ -130,9 +130,9 @@ Methods		array{byte} ReadValue(dict options)
 
 		fd, uint16 AcquireNotify(dict options) [optional]
 
-			Acquire file descriptor and MTU for notify. Usage of
-			StartNotify will be locked causing it to return
-			NotPermitted error.
+			Acquire file descriptor and MTU for notify. Only
+			sockets are support. Usage of StartNotify will be locked
+			causing it to return NotPermitted error.
 
 			For server the MTU returned shall be equal or smaller
 			than the negotiated MTU.
-- 
2.17.2

