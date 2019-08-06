Return-Path: <SRS0=gGyw=WC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103C7C433FF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Aug 2019 13:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3724208C3
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Aug 2019 13:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBEjc5JG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfHFNrZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:47:25 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39560 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfHFNrZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Aug 2019 09:47:25 -0400
Received: by mail-lf1-f68.google.com with SMTP id x3so7410993lfn.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Aug 2019 06:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rvJot3sdFzlXVa95YJ5H7OOgZwYquxrO4qKP13c7uwY=;
        b=BBEjc5JGpZodXuCK4ydLwMAfFRV0kDM+1QwrUj8hucrDMmHNqgojTX+AM/xRUlQ4zw
         iLNGuxCIqEtv7Ey+IAYzh3DcpidxweDpHTzLlrZF3j89s+xdlxnzoeXkXHB/Mk5c0lzE
         t0sIc1kWZkgfNnLZ8nmSx4ip3R0BpbeDBoJG4YRWyJFVgpQa6aGi/65FuWbENmdjwe+C
         gfV2Xb9hw8DJDfc9H9AEgyjCdMJb46KWYsxE19MoL/CN4whzOInS/AMWwuNtsz5bGBxb
         QFzkSC0Imb+/7nd7aIiM+7p59t5a2n/RT+OTsvjFAL4U7hRWQMvxnVtp/6dQ9g//uf3Y
         z1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rvJot3sdFzlXVa95YJ5H7OOgZwYquxrO4qKP13c7uwY=;
        b=IzQDTLhGWmZmF/qEUISo74OdIxQ6ZkE6PqlaXojhebPLtmn8a1ZlVPc8zeEIwCbjVC
         12XgVL6ZnRkoh+M6onh5GxMO2G6hZmsLDqPvof78qRHTfPThUXiDT8c0G3eI1LtgMMhf
         v2+aGgUAnTqpo74oBUdbqSPpN88bdIId8TkmLHUhNLFxYPJieF6vd0MPmdM5WUFsWl6q
         47W2YAwKUfA2BWKThOfjKUYTdSFVk2M5FV3E0AjEYsucI3MN84NgdrlxDrm6vw7oy9uf
         PKpuqSm+CdSXEC1mWHVUkePrWyhP0Eo+pvUyqjaSiFzbOx/tbyZ4VYdvDNY38gJ+Aul1
         kJ/A==
X-Gm-Message-State: APjAAAV6VUmjUyZRjVA7G1jB+Hfl/C25pJ98Foqtg37CXUs/+PVaSzaA
        keJYEOGpudURqGfXPJ4DgPjU3ghv
X-Google-Smtp-Source: APXvYqxCjc2YN3osb48NgGL+OEc0KKamsz0lm4jEp5BC5/H2zCyshl/tvoWNxczBkSY0CYa9kZjzeg==
X-Received: by 2002:a19:8c57:: with SMTP id i23mr2464534lfj.192.1565099242721;
        Tue, 06 Aug 2019 06:47:22 -0700 (PDT)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id f17sm1694400lfa.67.2019.08.06.06.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 06:47:21 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Janc <szymon.janc@codecoup.pl>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] advertising: reply in RegisterAdvertisement on success
Date:   Tue,  6 Aug 2019 15:47:06 +0200
Message-Id: <20190806134706.21453-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

RegisterAdvertisement method handler sends a reply message on all kind
of errors. It makes waiting for a reply and checking it very useful on
the caller side. There are errors like InvalidArguments, AlreadyExists,
etc. defined.

A missing reply on RegisterAdvertisement success was causing
dbus_pending_call_block() to block caller and was resulting in the
org.freedesktop.DBus.Error.NoReply after a timeout.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
Hi,

I'm writing my first BlueZ app using C language and I run into this
timeout + org.freedesktop.DBus.Error.NoReply problem. I found this fix
and tested it successfully.

I can see that many methods handler do the same, e.g.:
UnregisterAdvertisement, RegisterProfile and UnregisterApplication.

Let me know if you see any problem with this patch/fix.
---
 src/advertising.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/advertising.c b/src/advertising.c
index 3ed13766c..43591ae42 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1190,7 +1190,7 @@ static DBusMessage *register_advertisement(DBusConnection *conn,
 
 	queue_push_tail(manager->clients, client);
 
-	return NULL;
+	return dbus_message_new_method_return(msg);
 }
 
 static DBusMessage *unregister_advertisement(DBusConnection *conn,
-- 
2.21.0

