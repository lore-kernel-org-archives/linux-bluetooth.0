Return-Path: <SRS0=zqBl=2E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37576C43603
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Dec 2019 10:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4AD82073D
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Dec 2019 10:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hadrons.org header.i=@hadrons.org header.b="VQSPySAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfLNKZf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 14 Dec 2019 05:25:35 -0500
Received: from 2.152.178.181.dyn.user.ono.com ([2.152.178.181]:52840 "EHLO
        pulsar.hadrons.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfLNKZf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 14 Dec 2019 05:25:35 -0500
X-Greylist: delayed 2680 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Dec 2019 05:25:34 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hadrons.org
        ; s=201908; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:From:
        Reply-To:Subject:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
        In-Reply-To:References:X-Debbugs-Cc;
        bh=O+6zK36Lp6v8cdmn7UF9bspQ1Fl9waLiNt5pVH3F8EA=; b=VQSPySAuRO3CfGxmE5PErRHUqZ
        EMdFHky/WoRkpSqP7aX/1WSdC8OdlbuMCcqU2ayyHrE8lg2AH7BrmSAzhMMK5lQG3H64mE85jHiKD
        YhPkAIKcln8Kyz6fkD8c7YNXPHzmn8oaipnoD40OXJj7KYEWFGxAxHdMzu1DE4aUT6u3h3Qs5VgCn
        atoKRlYnrRimMrpWw14s2K2lT1gYy9pnGWs1/VbmFntPQMxNCtzMzbBedZ38e6SYCMwl2VFWlNvtu
        fXhkOE3wfT8UA2pYBuAp04t6+kaJGtMmLKIwMnGVuSuKxUMjetxXOmq6SC9NES5tmgB9TlmT1I/hT
        uIlDmaFA==;
Received: from guillem by pulsar.hadrons.org with local (Exim 4.92)
        (envelope-from <guillem@hadrons.org>)
        id 1ig40W-0005Ex-Jn
        for linux-bluetooth@vger.kernel.org; Sat, 14 Dec 2019 10:46:40 +0100
Date:   Sat, 14 Dec 2019 10:40:52 +0100
From:   Guillem Jover <guillem@hadrons.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/mainloop: Use connect() instead of bind() for
 sd_notify
Message-ID: <20191214094052.GA363763@thunder.hadrons.org>
Mail-Followup-To: Guillem Jover <guillem@hadrons.org>,
        linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

We are the client, so we should be using connect(2) instead of bind(2),
otherwise when using non-abstract Unix sockets we will get an error that
the address is already in use.

This breaks the notify support in dpkg's start-stop-daemon.
---
 src/shared/mainloop-notify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/mainloop-notify.c b/src/shared/mainloop-notify.c
index 89a880006..1de714a0e 100644
--- a/src/shared/mainloop-notify.c
+++ b/src/shared/mainloop-notify.c
@@ -91,7 +91,7 @@ void mainloop_notify_init(void)
 	if (addr.sun_path[0] == '@')
 		addr.sun_path[0] = '\0';
 
-	if (bind(notify_fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+	if (connect(notify_fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
 		close(notify_fd);
 		notify_fd = -1;
 		return;
-- 
2.24.1.658.g99f4b37f93

