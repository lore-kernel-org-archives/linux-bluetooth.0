Return-Path: <SRS0=QcUl=BD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC60AC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jul 2020 14:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8B7C2065C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jul 2020 14:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=heine.so header.i=@heine.so header.b="uDjBSJ1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgGXODe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgGXODe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Jul 2020 10:03:34 -0400
Received: from mail.heine.tech (mail.heine.tech [IPv6:2a01:4f8:1c0c:5073::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAE6C0619D3
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2020 07:03:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9CF6F18195B;
        Fri, 24 Jul 2020 16:03:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heine.so; s=dkim;
        t=1595599412; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding; bh=cEfrmMdVZeDh7tMtlkG2VgNmjYIH82n1oXbtmmXnWH0=;
        b=uDjBSJ1tAN7zYO8hP+Wl/lIAP/XPUo9hEbhX2QaAKYTiUSiifceShxCy48CAgdw/xFfW7z
        8arwTjPqPi9+dVoLuST93TbV3Saf73sw+SCmMTTO0FjClSaFV6GoFlosGOzN7xcsOWe8xJ
        4ef8YHy6+wahy4Dl6qsuBTtYMwNShOA=
From:   Michael Nosthoff <committed@heine.so>
To:     linux-bluetooth@vger.kernel.org
Cc:     Michael Nosthoff <committed@heine.so>
Subject: [PATCH BlueZ v2] main: add missing comma after AlwaysPairable
Date:   Fri, 24 Jul 2020 16:03:06 +0200
Message-Id: <20200724140305.111507-1-committed@heine.so>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Commit 1880b2990866 ("core: Add AlwaysPairable to main.conf") added a new
key to supported_options but didn't add a comma. This leads to the
following error message on startup if the key 'PairableTimeout' is pesent:

Unknown key PairableTimeout for group General in /etc/bluetooth/main.conf

This probably also leads to ignoring the setting.

Fixes: 1880b2990866 ("core: Add AlwaysPairable to main.conf")
---
 src/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/main.c b/src/main.c
index ec7a9fbd7..2c083de67 100644
--- a/src/main.c
+++ b/src/main.c
@@ -79,7 +79,7 @@ static const char *supported_options[] = {
 	"Name",
 	"Class",
 	"DiscoverableTimeout",
-	"AlwaysPairable"
+	"AlwaysPairable",
 	"PairableTimeout",
 	"DeviceID",
 	"ReverseServiceDiscovery",
-- 
2.25.1

