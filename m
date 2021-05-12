Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1396C433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 22:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C710C611CC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 22:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhELWlQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 May 2021 18:41:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43647 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1392085AbhELVgN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 May 2021 17:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620855304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UYUG5IKlwMILhG+uEZ2REhn+yfaAmfuIR2TSkEbaCY0=;
        b=ddQQIcT0sLQQWLu91lXnSdDklL2/54kgxQs5aGccNVeNCWDDAlSF5Du5SblaRToDjhqBM5
        4XFEhRHw3M7xqDlAx6IqZnqzTztPbkOMrY6FH95nKzkxv6gy1GZqc66NOn9/EY7YwBM1/w
        n5MoVwecm6DbQplpk7s6l62putZV2Fs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-8bQLKqjDOsGeJRFyjMWOnw-1; Wed, 12 May 2021 17:34:57 -0400
X-MC-Unique: 8bQLKqjDOsGeJRFyjMWOnw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3A59801817
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 21:34:56 +0000 (UTC)
Received: from ivy-bridge (ovpn-112-130.rdu2.redhat.com [10.10.112.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C3AA5D9D7
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 21:34:56 +0000 (UTC)
Date:   Wed, 12 May 2021 17:35:23 -0400
From:   Steve Grubb <sgrubb@redhat.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [Bluez PATCH 1/6] Fix leak in mesh
Message-ID: <20210512173523.622e0ade@ivy-bridge>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org



The dir variable needs to be closed before leaving.

Signed-off-by: Steve Grubb <sgrubb@redhat.com>
---
 mesh/rpl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mesh/rpl.c b/mesh/rpl.c
index ac0f6b6f2..c53c6fbfd 100644
--- a/mesh/rpl.c
+++ b/mesh/rpl.c
@@ -143,8 +143,10 @@ static void get_entries(const char *iv_path, struct l_queue *rpl_list)
 		return;
 
 	iv_txt = basename(iv_path);
-	if (sscanf(iv_txt, "%08x", &iv_index) != 1)
+	if (sscanf(iv_txt, "%08x", &iv_index) != 1) {
+		closedir(dir);
 		return;
+	}
 
 	memset(seq_txt, 0, sizeof(seq_txt));
 
-- 
2.31.1

