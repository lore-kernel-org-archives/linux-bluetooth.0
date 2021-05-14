Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012F8C433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 May 2021 13:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D331C61461
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 May 2021 13:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbhENOAZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 May 2021 10:00:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53469 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232176AbhENOAY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 May 2021 10:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621000752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=N4Y3fCMw9Zj84kXaFrDFxx83fftLWa+skQMiN44niN8=;
        b=QFpxByB5R76aoFuRCvziVLr2U7cEV19hUSfEt+qOWFJ9iHiIii7pWNaDuvZ8FbJN0dGgZp
        vByvFe7wg2ZRD1tzr0oLtWaIp6zwhVz20SMcN+ifLCxQGEYS75eFpyCRzB0psq+FrFQWby
        p+IpJRfvq5CcB7sKbA9zIiFmpwbM3AE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-M82wqapjP-y9E56qHjO-rQ-1; Fri, 14 May 2021 09:59:10 -0400
X-MC-Unique: M82wqapjP-y9E56qHjO-rQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCBD4107ACC7
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 May 2021 13:59:09 +0000 (UTC)
Received: from ivy-bridge (ovpn-117-226.rdu2.redhat.com [10.10.117.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7182F19CB1
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 May 2021 13:59:09 +0000 (UTC)
Date:   Fri, 14 May 2021 09:59:38 -0400
From:   Steve Grubb <sgrubb@redhat.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [Bluez PATCH 3/6] Fix leaks in plugin
Message-ID: <20210514095938.19256b85@ivy-bridge>
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

