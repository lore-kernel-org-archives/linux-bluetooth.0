Return-Path: <SRS0=Gf0L=6V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67169C38A2A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 21:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39E03206D5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 21:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1q9NH+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgEGVDj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 May 2020 17:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgEGVDj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 May 2020 17:03:39 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65693C05BD43
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2020 14:03:39 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s20so2570736plp.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2020 14:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TE6TsRfPW2V6gcxJkLi/U5ycVzsXGYtxUITMegbiZhc=;
        b=j1q9NH+pgU7pIQFYxdqEvFYzp6f0327xcCRxoFQ+cfI2KqTy3ZjcffqvQcG40JUuYC
         PslJkv03IHTGJC+vO7gvjSoNNIMKuVIyzO3B382+ta7QPEo1jhilgJeVV+YHJqQ4yVnD
         Xp7KBEYlzEDSSsj3NzgGmwMXlqBl2vx24y8C1jtQlUy+rjIkb08laP5fZnfwCUMsnfMB
         BKQf61WXXlwVUjR7ou/m5sLNjljRskZjBP/Q2yuF2eJM3AatxHApsNUkMRo+uCzC9/e1
         YQ9teOwdOxoVPe4cjSwGUNmbRRu01p2XUoCLsikyvZdDFvz0Y1pSbF7nRngXQWms2kGx
         hIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TE6TsRfPW2V6gcxJkLi/U5ycVzsXGYtxUITMegbiZhc=;
        b=F99GRnh1wmvnKkzxX/sn7e8xLshWsEItUtTe3BeQ0ZFxwYhaNks2wpvdiEDf+9SxxR
         Is4JTnoSW5qEgc4uO7W2Yxu3vPl/0OgdHqS3U9IovMNCEx2cvyfYAYYnwl5JwiTm2743
         Z1TGmk+Fy4c0GcGjSSxzvIU/08febqkSC+jbR7mMC6Phk8FFGGN/YhhGJoXhTiKQPdTz
         wm+NbsoY3LzSuQ9CMDaxATVw2DUZI5IOjV/I6hKhGTJS0ZZcZvIEvW8XK09Uleta9upj
         9/kYteNeaiB9yCgXupdBSAowjLOJaDjlKGE2jfajhBp+aqLYh25GDxkqxCV30ZqCtL7Y
         S8ew==
X-Gm-Message-State: AGi0PuZ4OYUPc/ZvRbVpJ1lkgE2FmIDT0Af4uNmNcRr4/cTqp0Esk/o3
        B6tmmOx8btzQ39S5GSDRrBupAOT9cJA=
X-Google-Smtp-Source: APiQypLd0KbSVxeLUbjw12SUMfgQaNDeRSfm0HT60sf2U4FtAq8R/Be8IfJlYN2q+n+IlH4A6cF3ng==
X-Received: by 2002:a17:90a:3687:: with SMTP id t7mr2070343pjb.233.1588885418492;
        Thu, 07 May 2020 14:03:38 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id u12sm5777749pfc.15.2020.05.07.14.03.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:03:37 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] avrcp: Handle not implemented response to AVRCP_LIST_PLAYER_ATTRIBUTES
Date:   Thu,  7 May 2020 14:03:36 -0700
Message-Id: <20200507210336.2703338-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If remote device respond with ctype set to not implement don't continue
parsing the packet.
---
 profiles/audio/avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 6b3f685d2..773ccdb60 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2223,7 +2223,7 @@ static gboolean avrcp_list_player_attributes_rsp(struct avctp *conn,
 	uint8_t len, count = 0;
 	int i;
 
-	if (code == AVC_CTYPE_REJECTED)
+	if (code == AVC_CTYPE_REJECTED || code == AVC_CTYPE_NOT_IMPLEMENTED)
 		return FALSE;
 
 	len = pdu->params[0];
-- 
2.25.3

