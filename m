Return-Path: <SRS0=oE9z=ZS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD25C432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Nov 2019 21:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC9C20866
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Nov 2019 21:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="antHw51r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfKZV2R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Nov 2019 16:28:17 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34124 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfKZV2R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Nov 2019 16:28:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id j18so3364067wmk.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Nov 2019 13:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=KwJ+s+xplYsNpGLUA409T+uPqrLU+gDVqRboFsrlUws=;
        b=antHw51rHtAwN8y9qw4AnJSoujiavy9XHd/CLYWnXmP3ogMhmxXq1GIctefD0cBzAl
         VvaiuLDAdoOPOlPENEDYuVPOOq/nGKw+Vm0QkdWCQ3FyTiqisykS2ccAOdVfLwEdRNBK
         f80oHKj3ReZsEWr3Hef3aVj1FMIsp2WzFGkenGSpAo46VVXt5JHfPCT/BTFdGtVWiOMc
         WPsOmV+OACL6PwAQlNfZgW2yz/Pa3JXyOtLIoAhtrFeI7N4os0vDHu3FmCAbdyZrNlIj
         bzS6+jIMVuN/LkHBNZBDxs5NwisnAMrQlY38mb36BXjZN7VNMWDtxMPo0yzbLnwoQWgw
         Xa6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=KwJ+s+xplYsNpGLUA409T+uPqrLU+gDVqRboFsrlUws=;
        b=SeYXZMyHJ5KgzLVLSBmLbAX0Wn8bUuFXGg1320U2VMOP7o+gQolF6h5ItQKHJB7h20
         mj/Jhp1o0RupOiWbKyZfabe70zKRy+FXigl39oMhulY9Hv01ZIySmFGVtMrQboFRP6IZ
         3SLMXCCtEo4XQ15GgEWfgR/00zNIxV3Lf+zOrevnUuwjYc+Y8fLz3eROL8yJ+1KBQwOJ
         8rhrSpRmI6NiQGcggs3aDlI73QFnPe4RfErejsUb0tJS8z2tNur6KvUte1sXRr3Kwv26
         zsl5u6wjOBxNysl5LND7cnYVqSqNEu3fInVhuZJMdAcX5na9+T3KUZ0TmwykH1eb5h+Z
         f32g==
X-Gm-Message-State: APjAAAWKVji/09pGXs3Cg0cF8YIIR9TBF/haRo3ddM146D+i6H3vCugn
        kcU+rCKYzgSNxdW3gfbwzoQyQA1i
X-Google-Smtp-Source: APXvYqyCPI5GJjXmEGDpY7xhd9CGswwRpKNcKFNoaJxwDetj4aTjXwLoJIHVaCo8a1VNsIsion/+yA==
X-Received: by 2002:a1c:b1d4:: with SMTP id a203mr957953wmf.160.1574803693376;
        Tue, 26 Nov 2019 13:28:13 -0800 (PST)
Received: from localhost.localdomain (ip-89-103-160-142.net.upcbroadband.cz. [89.103.160.142])
        by smtp.gmail.com with ESMTPSA id z2sm2395732wmf.47.2019.11.26.13.28.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2019 13:28:12 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] avctp: Set more descriptive name for uinput device
Date:   Tue, 26 Nov 2019 22:27:53 +0100
Message-Id: <20191126212753.18455-1-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 profiles/audio/avctp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 70a3e40b2..ae53587ad 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1181,8 +1181,7 @@ static int uinput_create(char *name)
 	}
 
 	memset(&dev, 0, sizeof(dev));
-	if (name)
-		strncpy(dev.name, name, UINPUT_MAX_NAME_SIZE - 1);
+	snprintf(dev.name, sizeof(dev.name), "Bluetooth Audio/Video Remote Control%s%s", name ? " " : "", name ? name : "");
 
 	dev.id.bustype = BUS_BLUETOOTH;
 	dev.id.vendor  = 0x0000;
-- 
2.11.0

