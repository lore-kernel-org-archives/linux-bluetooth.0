Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227E8C433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 22:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE2E2611CC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 22:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237920AbhELWlz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 May 2021 18:41:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41036 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1392467AbhELVhr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 May 2021 17:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620855399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZjFysPE72wEn02XDNwKNZXqJiKo5jA+rqapk3/wuO3M=;
        b=duGiZcS1jSiE6iYGhdQzXGjGlDPHG9NVOXm63wyS/6kwPOnucsvxbJPY+0mbJa/bb0nnUV
        SvoLNwo+WpDi11Set8IyeG9dyST5elJ1VjKVxjWYflpznP8dB1uWw8m2lb0eQ7V8Ovmk9I
        AFDCyKQB5Kha7LeThGzUInpWAzN0zKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-kBP6iXCWNvGspiPVhgejHw-1; Wed, 12 May 2021 17:36:35 -0400
X-MC-Unique: kBP6iXCWNvGspiPVhgejHw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B25A41020C37
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 21:36:34 +0000 (UTC)
Received: from ivy-bridge (ovpn-112-130.rdu2.redhat.com [10.10.112.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E68750AC6
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 21:36:34 +0000 (UTC)
Date:   Wed, 12 May 2021 17:37:01 -0400
From:   Steve Grubb <sgrubb@redhat.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [Bluez PATCH 3/6] Fix leaks in plugin
Message-ID: <20210512173701.4bd04817@ivy-bridge>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


g_file_get_contents allocates memory. It needs to be freed on any
function exit.

Signed-off-by: Steve Grubb <sgrubb@redhat.com>
---
 plugins/hostname.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/plugins/hostname.c b/plugins/hostname.c
index f7ab9e8bc..1a9513adb 100644
--- a/plugins/hostname.c
+++ b/plugins/hostname.c
@@ -213,11 +213,10 @@ static void read_dmi_fallback(void)
 		return;
 
 	type = atoi(contents);
+	g_free(contents);
 	if (type < 0 || type > 0x1D)
 		return;
 
-	g_free(contents);
-
 	/* from systemd hostname chassis list */
 	switch (type) {
 	case 0x3:
-- 
2.31.1

