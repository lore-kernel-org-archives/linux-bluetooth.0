Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FC9C433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 22:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51193613E3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 22:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238978AbhELWmG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 May 2021 18:42:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22002 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237417AbhELVij (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 May 2021 17:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620855445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9EmV1kN1gTkpksgYyw/F2byguyMpsEcJHlN8hTupe2E=;
        b=YwMiho5+mBBliBs5cntj9aJK1XzVVi9PNqvV1lqjnnzy+rZuNC725R0sNhg7Dx8a4XrRiO
        NW71CQZoaL4JeHKeO9r9PlkSUaFkg+O2H+LnPYXO/8T8Y9zWPdZJDcZR1mBGFZaOIDQwx3
        gyVPlJYz2ovaZabgbxcmJQAuWclWa8k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-FYOhXDsbOQW-fAkoMUC04w-1; Wed, 12 May 2021 17:37:24 -0400
X-MC-Unique: FYOhXDsbOQW-fAkoMUC04w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75586107ACF2
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 21:37:23 +0000 (UTC)
Received: from ivy-bridge (ovpn-112-130.rdu2.redhat.com [10.10.112.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29D546086F
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 21:37:23 +0000 (UTC)
Date:   Wed, 12 May 2021 17:37:50 -0400
From:   Steve Grubb <sgrubb@redhat.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [Bluez PATCH 4/6] Fix leaks in profiles
Message-ID: <20210512173750.63ef39a5@ivy-bridge>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


g_new0 allocates memory that must be freed

Signed-off-by: Steve Grubb <sgrubb@redhat.com>
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

