Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0F7C433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 22:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D31B4611CC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 22:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239174AbhELWmP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 May 2021 18:42:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53721 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238779AbhELVl5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 May 2021 17:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620855641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GGtK1vER/182zGYhGgmWhvzrHE3DX7UFf32Re0ZgrBk=;
        b=Dmo0wUegUGV/LE0bDquSLRD7mSaKbkuYUFTn3/HUb6gBu6ydz77ZlOabHsgbEOtViGu5mO
        D/uvFMsDrFpg5v0+sh/7WnWlhWJ86u5mKPz4vrrBBo6GjfdKGYJe7mGExDc+eI35EvaNb6
        p9OTigleECdaIva55wOCKIbz2bXiPyM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-p_j_LqWFMHyVskw6i75R7A-1; Wed, 12 May 2021 17:40:39 -0400
X-MC-Unique: p_j_LqWFMHyVskw6i75R7A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D4EEFC90
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 21:40:38 +0000 (UTC)
Received: from ivy-bridge (ovpn-112-130.rdu2.redhat.com [10.10.112.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C6B760CC6
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 21:40:38 +0000 (UTC)
Date:   Wed, 12 May 2021 17:41:05 -0400
From:   Steve Grubb <sgrubb@redhat.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [Bluez PATCH 5/6] Fix leaks in src
Message-ID: <20210512174105.3f3f82f2@ivy-bridge>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


g_key_file_get_string allocates memory that must be freed.

asprintf allocates memory that must be freed.

Signed-off-by: Steve Grubb <sgrubb@redhat.com>
---
 src/main.c         | 1 +
 src/shared/shell.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/src/main.c b/src/main.c
index c32bda7d4..94141b1e4 100644
--- a/src/main.c
+++ b/src/main.c
@@ -795,6 +795,7 @@ static void parse_config(GKeyFile *config)
 
 	parse_br_config(config);
 	parse_le_config(config);
+	g_free(str);
 }
 
 static void init_defaults(void)
diff --git a/src/shared/shell.c b/src/shared/shell.c
index c0de1640d..eed300631 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -611,6 +611,7 @@ void bt_shell_prompt_input(const char *label, const char *msg,
 		prompt->user_data = user_data;
 
 		queue_push_tail(data.prompts, prompt);
+		free(str);
 
 		return;
 	}
-- 
2.31.1

