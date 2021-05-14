Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568D8C43460
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 May 2021 13:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3722E6145B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 May 2021 13:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbhENN6y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 May 2021 09:58:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48481 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232114AbhENN6x (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 May 2021 09:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621000662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=H0eclNxPJZBfPG3O5+ehiD13CJ+j8Rf0rSP/Wknwajg=;
        b=baqwAIJ1f6LKKDcFdRjyKfFfe/jOvZs48plNmjnnaDmecSVoju2jAwwyYL++J0irbu/2Tk
        DmybQaQBjJ0wKFPBFHckiqMuF7AGy7Z+KZw6TRy/bbUPdqPQCRFSQor0ewrll4SCRISiOQ
        pDAeKd5cuzKD4PzunC3lwei+DLwxj2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-yEA6ospLPqeFu-lxKntRyw-1; Fri, 14 May 2021 09:57:40 -0400
X-MC-Unique: yEA6ospLPqeFu-lxKntRyw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73F32192377C
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 May 2021 13:57:39 +0000 (UTC)
Received: from ivy-bridge (ovpn-117-226.rdu2.redhat.com [10.10.117.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2E061001B2C
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 May 2021 13:57:38 +0000 (UTC)
Date:   Fri, 14 May 2021 09:58:07 -0400
From:   Steve Grubb <sgrubb@redhat.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [Bluez PATCH 1/6] Fix leak in mesh
Message-ID: <20210514095807.62f40ff5@ivy-bridge>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


The dir variable needs to be closed before leaving.

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

