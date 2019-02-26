Return-Path: <SRS0=ehmo=RB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDDFC43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Feb 2019 13:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868CD21848
	for <linux-bluetooth@archiver.kernel.org>; Tue, 26 Feb 2019 13:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=invoxia-com.20150623.gappssmtp.com header.i=@invoxia-com.20150623.gappssmtp.com header.b="QDTMVcNb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfBZNPv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:15:51 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39265 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfBZNPu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Feb 2019 08:15:50 -0500
Received: by mail-wm1-f68.google.com with SMTP id z84so2218181wmg.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Feb 2019 05:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=invoxia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=xVjOQUTmA5jPyi8lex0uuNq99GYTW/7i1eQxnT9mM54=;
        b=QDTMVcNbGtzilmAjZGcZqMQRqgL7Es9cB3jZfR3vXsxLQjmXoGCfRltmX7q+k4Qqkk
         Z5x4I70EixXiLifUXPXfITJerhfeEPDyrFS0oF/HXRYMUkjzuTs8y6f1Tz5XFU0nH5Qj
         Cc717AAkZSka2Wu4wNmYccmBAtl37dNdRdoWkKEuu3dSW98mD+UcAHVTH1LFj0YwtPfP
         Iqsh5+jWFT3/j+hV681GFYD5BpwhIQzOWbzmteK6ABTgGUMazV6HoR3pRQ9f31n2F8Ph
         2FKUgwYgUcwA1N0CFSiKSPbT5BmQWlNUyp8ggdNX9DTWUivGbFHGqZM1PQLGdoWJAE7Y
         IcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xVjOQUTmA5jPyi8lex0uuNq99GYTW/7i1eQxnT9mM54=;
        b=RzZMFUELCUJ0Q2eC1Valoq5dfDKc/zYkfCMOdjN2uKVwU/9vjr90ZzGHtFw5WaCcCK
         mFPouvD87piNZ/UJrc8XDo/viyUNzjdmhvQnt5EqtGhHwETG79IvgmSkPnvpqFsyZJKs
         YFXwStLXOLUl5bG1dO3mxA6hFDB4r31sHJEf9vAT0x3O6yMjKr+ebsjkEDK0d0jUGlfK
         0C8B4Zlk+9pKMZkgs3vnxzK2malH7jwxfPwgxQF9vstRPdRkkkJk3XqR7a9A59LeWME8
         Uwu0PTDxGvhYkSYkb7j/jRZWhYQFnQ54j5a28/427O7IIruQcEResU4n/vuvMNIEYd/p
         647A==
X-Gm-Message-State: AHQUAuZGDKrGrzsv7U2fbhtuyO1SRln1BlBa/x/K4etCPDWwATJKh2oj
        6uVqw8ytQ3yGD5AjZXjM7dqd39imWS0=
X-Google-Smtp-Source: AHgI3IbfMn9KtTOe2EQmASQ/qrtV4z1a9vYV71QwTbxp9oQQyPdBl1HjU199sEhYke4SKiwffratSQ==
X-Received: by 2002:a1c:2358:: with SMTP id j85mr2479597wmj.130.1551186948479;
        Tue, 26 Feb 2019 05:15:48 -0800 (PST)
Received: from amolinux.invoxia.net (89-158-71-12.rev.numericable.fr. [89.158.71.12])
        by smtp.gmail.com with ESMTPSA id i16sm9883407wru.16.2019.02.26.05.15.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Feb 2019 05:15:47 -0800 (PST)
From:   arnaud.mouiche@invoxia.com
To:     linux-bluetooth@vger.kernel.org
Cc:     Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Subject: [PATCH] tools/hciattach: TI: Increase the HCI request timeout value
Date:   Tue, 26 Feb 2019 14:15:14 +0100
Message-Id: <1551186914-24803-1-git-send-email-arnaud.mouiche@invoxia.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>

When playing with a TI CC2564c module linked to a RaspberryPI with a
FTDI UART/USB adapter, the 15ms timeout is not sufficient.
---
 tools/hciattach_ti.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/hciattach_ti.c b/tools/hciattach_ti.c
index 1838394..cb97b06 100644
--- a/tools/hciattach_ti.c
+++ b/tools/hciattach_ti.c
@@ -254,7 +254,7 @@ static int brf_send_command_socket(int fd, struct bts_action_send *send_action)
 	rq.rparam = response;
 	rq.rlen   = sizeof(response);
 
-	if (hci_send_req(fd, &rq, 15) < 0) {
+	if (hci_send_req(fd, &rq, 100) < 0) {
 		perror("Cannot send hci command to socket");
 		return -1;
 	}
-- 
2.7.4

