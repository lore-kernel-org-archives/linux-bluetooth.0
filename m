Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A9FC43462
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 May 2021 14:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59EE461461
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 May 2021 14:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbhENOB2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 May 2021 10:01:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22656 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232874AbhENOB2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 May 2021 10:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621000816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=v6osFm+1KnEbk9hihyDBsCIdRPUiSKzamlUA7gQCF2Q=;
        b=hDyMEEJ2Gg7g+RRLcGukLmx0jSGcbhpSmVDqvEM/xcadKUsWKsyUUrY5LplrCEi2urwpAg
        LzYoUJlX35eWdKmDN+rkH80nRG4up/BetIfxEkbH2vcjzmJZ5/7RYZiGf1t5uQfCpiNy0H
        rhORGW+gccj+jRl1M3gTNdXqrxe+BA0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-_QATd1pLODuf5XgETqjFxA-1; Fri, 14 May 2021 10:00:14 -0400
X-MC-Unique: _QATd1pLODuf5XgETqjFxA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1280D107ACE6
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 May 2021 14:00:14 +0000 (UTC)
Received: from ivy-bridge (ovpn-117-226.rdu2.redhat.com [10.10.117.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B745E5C3E6
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 May 2021 14:00:13 +0000 (UTC)
Date:   Fri, 14 May 2021 10:00:42 -0400
From:   Steve Grubb <sgrubb@redhat.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [Bluez PATCH 5/6] Fix leaks in src
Message-ID: <20210514100042.4fdd13a5@ivy-bridge>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


g_key_file_get_string allocates memory that must be freed.

asprintf allocates memory that must be freed.

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

