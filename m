Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FE2C433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 May 2021 13:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97287613E9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 May 2021 13:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbhENOA6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 May 2021 10:00:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30185 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232103AbhENOAz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 May 2021 10:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621000784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=a0lRKRvDYVida2zbVj/D+aF7YJ5mBOVQjb/Va8b16Ao=;
        b=OqeZftN064umynbEgSAbDA34xmYbh666G8gQnAuf+YR41yS66imbvZ3b10Hkzg+bCxUu7y
        2p2hEQIkeVbTWw0MNsinozchgKpQ6gsG2e4UFvmwtCEiJ/HZuudmLGElIZMpy/Wq3VyONF
        R3OBvKt1eVAHiAqIPPPAj+0qE0WHOJQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-quLEgV6pMfKSVviKEEXclg-1; Fri, 14 May 2021 09:59:42 -0400
X-MC-Unique: quLEgV6pMfKSVviKEEXclg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 840E080006E
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 May 2021 13:59:41 +0000 (UTC)
Received: from ivy-bridge (ovpn-117-226.rdu2.redhat.com [10.10.117.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3106718BB7
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 May 2021 13:59:41 +0000 (UTC)
Date:   Fri, 14 May 2021 10:00:09 -0400
From:   Steve Grubb <sgrubb@redhat.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [Bluez PATCH 4/6] Fix leaks in profiles
Message-ID: <20210514100009.72453e70@ivy-bridge>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


g_new0 allocates memory that must be freed

---
 profiles/audio/avrcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index c6a342ee3..58d30b24d 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3508,8 +3508,10 @@ static struct avrcp_player *create_ct_player(struct avrcp *session,
 	path = device_get_path(session->dev);
 
 	mp = media_player_controller_create(path, id);
-	if (mp == NULL)
+	if (mp == NULL) {
+		g_free(player);
 		return NULL;
+	}
 
 	media_player_set_callbacks(mp, &ct_cbs, player);
 	player->user_data = mp;
-- 
2.31.1

