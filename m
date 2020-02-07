Return-Path: <SRS0=kXS7=33=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03A4C2D0B1
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Feb 2020 05:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8785920720
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Feb 2020 05:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.b="RQt47fM6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgBGFKB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Feb 2020 00:10:01 -0500
Received: from mail-lf1-f45.google.com ([209.85.167.45]:33815 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgBGFKB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Feb 2020 00:10:01 -0500
Received: by mail-lf1-f45.google.com with SMTP id l18so677591lfc.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Feb 2020 21:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KqIIU72qYwQpWFzXjdRvYK00adq6+LoLiq7JtRvm0ro=;
        b=RQt47fM6d5DPkTAS/TSIon3idXYtqEP9Opkns0DBN+6V0jmZMW/KPi3j6lUgWvSdTy
         U5sQ/6a0kXOpXPE2IqH1vHxrFLUNvvVA96/yvMJuSs7dT1atZXhuBFUMvUx4cG90R8XR
         HxFCrUXtYCQHNb9vyKG2H6HZRTr/x1dcrjE+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KqIIU72qYwQpWFzXjdRvYK00adq6+LoLiq7JtRvm0ro=;
        b=S7TItwNIiFyH86fM/anzLhYmYksXWJCK4enPbCiHDrBS7XlUGP0o8atV4QfUS5JFA0
         lX2HjoMdWhUXkauTaqbjF/OUO6ktzFvttQAxHxCo/4NJLBsxttOl3SWKm7aBAfVGqSM4
         t2HlRMlNUCROOLTP30GtWWfkilCegU52FDovMTf8Np5a4+4mCIn6SbaGvkgpf0tXveYY
         LiMxPKjMwihBruMmIC46LlVaUaiDYqiukmj/vSUQtUm5mxlvy8Fa4mS7rK5LQ9+4YsES
         hzasxpdqgTO+ND11aVUXspR+qMDqUAelqwep6eRGNGq8TZsnjRbYB76t53VU9tETmyuX
         0o5g==
X-Gm-Message-State: APjAAAW41NzEl+pvF4cy3yc0trX41kdwKZIluK/v2rJaeIaXgLo/1i2N
        rBCsauBhikeduaQ+FlS4zGBM8IZGyy9NN1FF
X-Google-Smtp-Source: APXvYqyiasAW+SowTjr5sBIsJY8Iy9Mq1+Nm/edI6L6fnKXUqlJHtNE0PQAkE3NSpGXNEXkZyY0QYA==
X-Received: by 2002:ac2:5dc8:: with SMTP id x8mr3432032lfq.217.1581052197188;
        Thu, 06 Feb 2020 21:09:57 -0800 (PST)
Received: from virtualbox.ipredator.se (anon-49-167.vpn.ipredator.se. [46.246.49.167])
        by smtp.gmail.com with ESMTPSA id r12sm562214ljh.105.2020.02.06.21.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 21:09:56 -0800 (PST)
From:   Matt Ranostay <matt.ranostay@konsulko.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH RESEND] obex: report notification status on incoming message
Date:   Thu,  6 Feb 2020 21:08:56 -0800
Message-Id: <20200207050856.9249-1-matt.ranostay@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

To match doc/obex.txt on incoming message notification the respective
Status field should be set.
---
 obexd/client/map.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 550c5afb4..23be2d6b2 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -1914,6 +1914,7 @@ static void map_handle_notification(struct map_event *event, void *user_data)
 	switch (event->type) {
 	case MAP_ET_NEW_MESSAGE:
 		map_handle_new_message(map, event);
+		map_handle_status_changed(map, event, "notification");
 		break;
 	case MAP_ET_DELIVERY_SUCCESS:
 		map_handle_status_changed(map, event, "delivery-success");
-- 
2.20.1

