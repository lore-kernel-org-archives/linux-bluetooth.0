Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30980EB64DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Jun 2023 20:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjFSUaj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Jun 2023 16:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjFSUai (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Jun 2023 16:30:38 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62783A3
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jun 2023 13:30:37 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b5422163f4so23512545ad.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jun 2023 13:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687206636; x=1689798636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T4/mMmUNrSITP62UEH321ZzDfclxkl4F6Eyk2fR6Nzw=;
        b=M2k9io6Vvf+ajtrw3/ddkQpgJ2mrVel9MYhs5/WPF1kkJueHJ+MYC2YLrj/TN1x2zR
         iiMR2d8wH/U9ElrRk1HnRWqLF5kKbcUd6Nh4k0TwdEi3ZmmmUG3WoewEOtbt8PhU6/Cb
         0mVzhf+a10lhvvuBpZp6fjv+Xntl5U5AIxuvMOgWq89S+T9EG+pEeUnFJ8dYez9S1EUM
         W7ATgcTLqzAV+U4i6xfbp1wJtmEU7L4lvlwDEA62VfQg+7p6BJD3m/zjXcKVs3yq7nIU
         bIuQESMni5xGypLBGlEldFyZ+qwH405v8K2sqbgZ7JrIOOXvDWKgoZzS5FihT74liS/l
         mkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687206636; x=1689798636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T4/mMmUNrSITP62UEH321ZzDfclxkl4F6Eyk2fR6Nzw=;
        b=ZdND5gOJ00aBDLhQxHskiTMgBdCaCth2UEqINIhYHj0A+bA0KIoJBvONOhncHMN8Un
         9u2Zymuu31jIXi/Nv8GzB92KLvekT9lXhC611taZmBUankuUU09BBCsm+nRYkvY596hx
         2En2Oe1p7g8bu1UydMWX7Ydf30CbDbk+sMvXcCMcDnc6bErD6TCpMfl2xaeFs++2cz9f
         tZ9HFDVvmpxbGYsm7ftwPTxrb2PZi1diLwPKGmhljQMhH4FV9PXqdx5radCaqelxBrfP
         icBLBxn3Zg7HBOEzvMB4J06tF9qYZa0Kt0+PKMwOaNp/FUpOkGKiBU/B2ZocSJi2Cu7/
         27XA==
X-Gm-Message-State: AC+VfDx8U4+zpUVF10aMUs9kIVLpCYs1He5tHFDEtdLyWnuOVKsV5tfP
        p8F1r5uu0T4aOUhvxgGsiSwe8NbFuXJDAQ==
X-Google-Smtp-Source: ACHHUZ6uxJUbxPEOGgwfRmOlLNabhIRr80lhyKkRVlgrLm70lgqYLQ/TS73WboB1FRJ/aUnXC12rJw==
X-Received: by 2002:a17:902:c40c:b0:1b5:3aed:b078 with SMTP id k12-20020a170902c40c00b001b53aedb078mr12753380plk.53.1687206636055;
        Mon, 19 Jun 2023 13:30:36 -0700 (PDT)
Received: from lvondent-mobl3.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id ju18-20020a170903429200b001b045c9ababsm202714plb.264.2023.06.19.13.30.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 13:30:34 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] client: Print integers decimal value
Date:   Mon, 19 Jun 2023 13:30:29 -0700
Message-Id: <20230619203032.6812-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230619203032.6812-1-luiz.dentz@gmail.com>
References: <20230619203032.6812-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This make the code print D-Bus integer iterators also in decimal format
in addition to hexadecimal.
---
 client/print.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/client/print.c b/client/print.c
index 798d22c7e..66439e541 100644
--- a/client/print.c
+++ b/client/print.c
@@ -127,15 +127,18 @@ void print_iter(const char *label, const char *name, DBusMessageIter *iter)
 		break;
 	case DBUS_TYPE_UINT32:
 		dbus_message_iter_get_basic(iter, &valu32);
-		bt_shell_printf("%s%s: 0x%08x\n", label, name, valu32);
+		bt_shell_printf("%s%s: 0x%08x (%d)\n", label, name, valu32,
+								valu32);
 		break;
 	case DBUS_TYPE_UINT16:
 		dbus_message_iter_get_basic(iter, &valu16);
-		bt_shell_printf("%s%s: 0x%04x\n", label, name, valu16);
+		bt_shell_printf("%s%s: 0x%04x (%d)\n", label, name, valu16,
+								valu16);
 		break;
 	case DBUS_TYPE_INT16:
 		dbus_message_iter_get_basic(iter, &vals16);
-		bt_shell_printf("%s%s: %d\n", label, name, vals16);
+		bt_shell_printf("%s%s: 0x%04x (%d)\n", label, name, vals16,
+								vals16);
 		break;
 	case DBUS_TYPE_BYTE:
 		dbus_message_iter_get_basic(iter, &byte);
-- 
2.40.1

