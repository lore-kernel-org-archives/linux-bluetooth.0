Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42377C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Jun 2023 23:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjFAXdZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Jun 2023 19:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjFAXdW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Jun 2023 19:33:22 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EEB189
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Jun 2023 16:33:20 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b010338d82so8574565ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Jun 2023 16:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685662399; x=1688254399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=y0c4SjY8Vrb88l5DL8d5i62OqpQ8IbLKYgBK1H7pEeU=;
        b=McQImibNKacStuD/heEryN4927kYnI7uHPnEjaIyJUxw/UC8uDjO7H4j2K+GYjUSrL
         r8MGKZrhEkC29dY89R3Ukt8aqMVisnEVoeB4n/zueF/EbFnYF1Aor+s7Jo3QgQvIAolf
         O1zf15IOPuT315S+u1+C521SfzMNgRsIcxVYpYM/7Cb9mIACWHLuS5nKUHBCsA8pN5/O
         Jacek6mtnHr8Z1LYflvouX6lezYwKcuTeuwb2MDcsrtzYrG90QRLHL9SB1hOe60CVUwt
         4RwoXUUXsJojUM7D4hcabl8BsUZ2upTn8y4TWSKJ25XLXzeygnExyeTpgbZpunq7SO45
         2nOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685662399; x=1688254399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y0c4SjY8Vrb88l5DL8d5i62OqpQ8IbLKYgBK1H7pEeU=;
        b=l0W3X9+eQSOO4FHPTQj6veTfHNZU7D3EXL9sFLXCG4Gdj/Zd0X6YpAY9XjC5vvqkGy
         sxTU8N8dBKZnwxWzZURAf62CORqJNZqMQWsA3LnHPbj5kgvQcvMkzzFNeQxbOW3vCQ6q
         08dPg+pPLDdVJtbqFsdP0cDDPNGLNEbTv5c6F2WkGOPSF7TYLOtnrmVY5JHzFYwA8NKw
         vcPTDecnMoGoAb2lvIkTlDe5mYE5C5giyr3SUzZN6Cc0qCWWKuyTBzwOXOxPH+TD8mvg
         lYoyVG5pkOgiYfpVBrdXKIa49urcwjuDO8cOZq8lwOK+oBtWubUGIRL5H9eQ5PH0V1y0
         IWLg==
X-Gm-Message-State: AC+VfDx6RFipLos8m+rp+5WijFcPzHSzF3DuFZXQWTYcbaxHwMSxJU7d
        hVzQav8t9zVS9F21CZ/vbW8xScPhrSs=
X-Google-Smtp-Source: ACHHUZ4BfLBgaQmvxzZnddSxXgoTeiYYBClZH+w3WkgfpWEr4+5/yw3p1/VcVC4Ce14oH/YKEKGLVw==
X-Received: by 2002:a17:903:11d1:b0:1ac:b363:83a6 with SMTP id q17-20020a17090311d100b001acb36383a6mr782876plh.17.1685662398720;
        Thu, 01 Jun 2023 16:33:18 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902a50700b001ab0b2dad2fsm4051420plq.211.2023.06.01.16.33.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 16:33:18 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] monitor: Only print credentials if PID is set
Date:   Thu,  1 Jun 2023 16:33:16 -0700
Message-Id: <20230601233317.1419030-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If PID is not set don't print anything since this is likely a packet
originated by the kernel itself.
---
 monitor/packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 946ceb2c640d..6d73e5abfcbc 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -438,7 +438,7 @@ static void print_packet(struct timeval *tv, struct ucred *cred, char ident,
 			pos += n;
 	}
 
-	if (cred) {
+	if (cred && cred->pid) {
 		cred_pid(cred, pid_str, sizeof(pid_str));
 		n = sprintf(line + pos, "%s: %c %s", pid_str, ident,
 						label ? label : "");
-- 
2.40.1

