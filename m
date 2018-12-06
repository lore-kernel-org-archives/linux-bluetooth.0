Return-Path: <SRS0=vk22=OP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE29C07E85
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Dec 2018 00:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C28B2082B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Dec 2018 00:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ko2gOJn6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C28B2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbeLFAAj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Dec 2018 19:00:39 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]:43670 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbeLFAAj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Dec 2018 19:00:39 -0500
Received: by mail-qk1-f176.google.com with SMTP id r71so13005855qkr.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Dec 2018 16:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=ISI1T9x4C7DYp5le1zxUDJcWtskratwQokhhbruJrk8=;
        b=ko2gOJn6XqIhm64DOAx9l13UOyB6e4sYVtWTLq5CfQNEc20H9kB7zdEDBymyURunJL
         Nie//48tgy4Mr8dc8Uuoogs5oExPVFRkZQRtt+xF6Y72P+c92AD9ARfxwVSd66AozelA
         RAcE1at7lIs3UQzUeIbBCC/X5wkZJV7KDlLYoZFfPNCPflRnjdbCAwtWnc+PD+zhZ8DE
         0jKC7o3PjuoLyW2dnrjLvRP5gBBcRTfbfPmIu3hv/C9Fo4KceVH114Xp3kazOs7azuID
         77LEwZ/GUPb2Y+njsecTCwN+GmIK5/CWyeNbCvR7bdrXnJHXXOClZUriusv9iCkRbBje
         tH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=ISI1T9x4C7DYp5le1zxUDJcWtskratwQokhhbruJrk8=;
        b=jWqC2YE0Z1JTygATBVeWwbfTHgtFCy1On/tWAJI/WbxStA2zSyhnnPpuZ4rjqJktQV
         90ZooyaybLn9Tnn/iyapLnEhpxOxjh5YnofpDW8BvVsOd38S7XOuoRqol+5e20K4cOIg
         a2uQP6KPgSDUbRhKeApIe/xatXhf8RNOD3EEzogdf82o0YUbgwMTYXRPx2lVJL5KpQRl
         6vwFVt2AKSlK93YB5CeiFHp9QPsYRyW8IbSoKgSADyySAYMCWu4pmhyNy/VsrZgGLpSm
         xOX7Mnp6XWf8u7142+NAYbGhwvhbve/GMob4SiTUBOCeuFAixHXojIo+7PfRnJUrgfEr
         /qMg==
X-Gm-Message-State: AA+aEWZxwExoKYETSYjfYWgE1P6GAqFOe0l/Ezi2egYQdf5UbuK+qDnk
        +jyfH3RtBJ4sxmyJr4OaxBhbOpRzgk0=
X-Google-Smtp-Source: AFSGD/V6SNlBsqUavSMNPH/UZaOljKXtIHBN1krSU0Gf03zfpE6CLjc+g3N07u1MK3n8bE3fdNbcQA==
X-Received: by 2002:a37:744:: with SMTP id 65mr24305836qkh.260.1544054437956;
        Wed, 05 Dec 2018 16:00:37 -0800 (PST)
Received: from localhost.localdomain ([189.23.210.178])
        by smtp.gmail.com with ESMTPSA id f189sm12317109qkb.4.2018.12.05.16.00.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 16:00:37 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] avrcp: Fix error creating media items
Date:   Wed,  5 Dec 2018 21:00:32 -0300
Message-Id: <20181206000033.14963-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Don't use item name in the object since it would need to be properly
escaped if the remote stack uses UID 0, instead just create the path
using the object pointer even  though it is invalid to have 0 as UID:

AVRCP 1.6.1, page 84:

  'The value of UID=0x0 is a special value used only to request
   the metadata for the currently playing media using the
   GetElementAttributes command and shall not be used for any item
   in a folder.'
---
 profiles/audio/player.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 048f98f96..ac23f720b 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -1800,11 +1800,11 @@ static struct media_item *media_folder_create_item(struct media_player *mp,
 	item->player = mp;
 	item->uid = uid;
 
-	if (uid > 0)
+	if (!uid && name[0] == '/')
+		item->path = g_strdup_printf("%s%s", mp->path, name);
+	else
 		item->path = g_strdup_printf("%s/item%" PRIu64 "",
 						folder->item->path, uid);
-	else
-		item->path = g_strdup_printf("%s%s", mp->path, name);
 
 	item->name = g_strdup(name);
 	item->type = type;
-- 
2.17.2

