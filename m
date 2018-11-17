Return-Path: <SRS0=7u80=N4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FB6C43441
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Nov 2018 06:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D5E2081C
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Nov 2018 06:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=augury.com header.i=@augury.com header.b="D4SEkSeU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D5E2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=augury.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbeKQQQG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Nov 2018 11:16:06 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33947 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbeKQQQG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Nov 2018 11:16:06 -0500
Received: by mail-wm1-f66.google.com with SMTP id f1-v6so2272384wmg.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Nov 2018 22:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=augury.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lKjUBvp8cZYpTdNf6HyoRHBaIh49PY7FXb3aWN7UQRg=;
        b=D4SEkSeUSiNCrMNaNv6uF6ipQCyAwAxQbcJjN4OMTI40Q3zbYgtl7u7DnqRkWMNWN6
         cNaz+ZP3i/rLX+JNeE5+eMwhQCzrVtOhnbEV7x3pUg47s4kRfGKb/ZPF0RnsQqwoZwuw
         1E9uhygZACIjzHNwflqNQM9zFkmCyOGIiUkTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lKjUBvp8cZYpTdNf6HyoRHBaIh49PY7FXb3aWN7UQRg=;
        b=HS6kVl1pGzxTdnewUv14aOWsxzKtQ2CQ3zIt7EMiVnnnULs+WqGny5SeVEbGuyGk7E
         oO7fADRV1GZb0bFegfpzu25i9U5iqvfERVigcC+pIyUfXNevZ2n7CqnhxDLTkpFMxB9J
         JPUwCcn5L49bJY/LRirTn/LAu4dEv0mT81OooyfshC2SJ6iah146g4Hf1SM3/+rZQhTi
         5BhOns78rn4xEqzvwm200H//8BGRveI3Wc7uVx6yTlgwh23umctp3/K8vaZl5+0AipX5
         FxIbmHhiH0Xuey+Snbx2yA1y/xoYL1HK2NSuvVZg6vwOeaAv7xSHa+eExBrHzrf1rr9z
         Oh2g==
X-Gm-Message-State: AA+aEWYFdnz2t+iAkdoxUjdY5aed0mME5oyq1+8l6CeDsQH7PYcOdvpu
        0FohCSLGpIniAjRm9B489P0T1jUun/jW9VsO0Zh3G+6parJVjSrk0KcIaOZX6VnmDP0hp/yQZ5i
        fCROlbbGlEmGwDTDimVd4GZjyoq8JqcnhE6bbOOdfkk4WfblijA+iNy7MInszafR2AApfEBATEc
        9dcjg=
X-Google-Smtp-Source: AFSGD/UpmwkF5Jyjs55KHJFosadL5/dmkRJeDA+9nFBtHMpKeZC0oTaNnNW0B04jyImRO8gesHjWlg==
X-Received: by 2002:a1c:4843:: with SMTP id v64mr263335wma.79.1542434431754;
        Fri, 16 Nov 2018 22:00:31 -0800 (PST)
Received: from localhost.localdomain (bzq-79-182-246-1.red.bezeqint.net. [79.182.246.1])
        by smtp.gmail.com with ESMTPSA id q11-v6sm26935130wrj.7.2018.11.16.22.00.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 22:00:30 -0800 (PST)
From:   Gal Ben-Haim <gbenhaim@augury.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Gal Ben-Haim <gbenhaim@augury.com>
Subject: [PATCH BlueZ] core: Catch SIGPIPE
Date:   Sat, 17 Nov 2018 08:00:24 +0200
Message-Id: <20181117060024.10390-1-gbenhaim@augury.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

bluetoothd receives a SIGPIPE and terminates if writing to a pipe that
was acquired by AcquireNotify and there are no readers. it can be
reproduced by terminating the reader process without closing the reader
end of the pipe.

Catching SIGPIPE will cause the write call to return an EPIPE error
which will be logged as "io_send: Broken pipe".
---
 src/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/main.c b/src/main.c
index 4716f5388..54cdb8d3f 100644
--- a/src/main.c
+++ b/src/main.c
@@ -533,6 +533,8 @@ static gboolean signal_handler(GIOChannel *channel, GIOCondition cond,
 	case SIGUSR2:
 		__btd_toggle_debug();
 		break;
+	case SIGPIPE:
+		break;
 	}
 
 	return TRUE;
@@ -549,6 +551,7 @@ static guint setup_signalfd(void)
 	sigaddset(&mask, SIGINT);
 	sigaddset(&mask, SIGTERM);
 	sigaddset(&mask, SIGUSR2);
+	sigaddset(&mask, SIGPIPE);
 
 	if (sigprocmask(SIG_BLOCK, &mask, NULL) < 0) {
 		perror("Failed to set signal mask");
-- 
2.19.1

