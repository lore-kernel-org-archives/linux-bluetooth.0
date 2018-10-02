Return-Path: <SRS0=6kNt=MO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3A1C004D2
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Oct 2018 08:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036EB20645
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Oct 2018 08:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4QJm/X1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 036EB20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeJBPGv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:06:51 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:34915 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbeJBPGv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Oct 2018 11:06:51 -0400
Received: by mail-ed1-f49.google.com with SMTP id y19-v6so1291735edd.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Oct 2018 01:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=U7AZE5s41ZK4Xt42gbO3OUwGPM+BdCpniPs+ox/Z8fA=;
        b=o4QJm/X18zXdb/OD7xYNp0Z6HgsvnlQ9NV28TIf70YDZQACgaHFrFk4hE2KZ0eYnL3
         XBm1g4Jar4HT+yr2vq0V3PACSZEaWZ9UFoBhGi9xKXjjkHvsUSa9pWkU+DvOfzKOSdAn
         A5n6zGZ7XlmtPeVWrMhQ6zQF9BnC/wsxXH/YkzVncLUDIuHyoF7PZN2+k92yjPIF05z8
         kAMLbAJo786Zqfk8Oj/wQ5BGcP9yQUe70VOY6llLsT0ZcgHS9j4QFACyDfjGQg35abio
         buHN+FdOSZ+ycPVfMpPc9RFRaAW+3VQvttZJaAvdFd3F39mTryhPWt5M2iWOGehnjiO9
         QQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=U7AZE5s41ZK4Xt42gbO3OUwGPM+BdCpniPs+ox/Z8fA=;
        b=KAs+l6ZXYCQ18AziVJDVv2wgb0VS0etYmM/Y6wvuXe/m1DTJbUGINKl1xvFkQod4yW
         vlH2bUEeR9lLRj05WCxTP1FsnX2GKbc2bqsvpO3QP2LGyL037b7hHqj9DQyM5f0vHxJv
         RT/ot1MG6ClRuKh94Lbaqh59RsGXCeg/UGCSjAe9M1KLoxSOpgbq99hzBlUAYLvjxOBk
         POcxo9hvg8yq5oCNIvuHI7zFxPQ2zNCPybiWOOSOMkHa2v+YzNPNPFAU+btgNXn2TjYg
         4quNz+EpSq8pbZJJYswHtWn7icGOL1lQFKd5zCC01v2DcpfI8I24nItIxBvpYrb9wvK5
         hRLw==
X-Gm-Message-State: ABuFfoismlEjfs2TWu4E5dtDWm7gJF6azg6BHvhUTpzmkgMT11r/Zjt2
        tR8Q2EFfSTBsKpo8+LDcjiktivaw
X-Google-Smtp-Source: ACcGV62nx0RQAC49zRBl3T4fROmk8Wq8hfKfoqp/wQPNN20ZgBXBgJyJvrdQksYUvZ8cfivmNzKP9g==
X-Received: by 2002:a50:f573:: with SMTP id w48-v6mr23099055edm.230.1538468684890;
        Tue, 02 Oct 2018 01:24:44 -0700 (PDT)
Received: from vudentzs-t460s.fi.intel.com ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id r23-v6sm6215676edi.17.2018.10.02.01.24.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 01:24:44 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/3] shared/att: Reset fd when disconnected
Date:   Tue,  2 Oct 2018 11:24:40 +0300
Message-Id: <20181002082442.20802-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Set att->fd to -1 when considered disconnected.
---
v3: Pass btd_device instead of bt_att since the later may have been
disconnected already.

 src/shared/att.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/shared/att.c b/src/shared/att.c
index 8bf3f4611..04577eddd 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -570,6 +570,7 @@ static bool disconnect_cb(struct io *io, void *user_data)
 
 	io_destroy(att->io);
 	att->io = NULL;
+	att->fd = -1;
 
 	/* Notify request callbacks */
 	queue_remove_all(att->req_queue, NULL, NULL, disc_att_send_op);
-- 
2.17.1

