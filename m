Return-Path: <SRS0=Btsr=QG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5546C282D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jan 2019 13:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B2320833
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Jan 2019 13:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6wT61LV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731199AbfA3Nyl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:54:41 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:41764 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731180AbfA3Nyk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Jan 2019 08:54:40 -0500
Received: by mail-ed1-f51.google.com with SMTP id a20so19034399edc.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Jan 2019 05:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=gYlEabMAXZxuCpuB6JgfWU70BTH7pLk+pLbwi0NCc/M=;
        b=V6wT61LVQegTnUjawkA5qhYCbxzAILhTKLDPvyH3nG39RPhS7eyJt7P7c8b5nvAvxD
         68CxxJq6Fi/hEqIZBT+DyOtDTPMNzqF86idLxBUatZ4q9VOKvRai4akA6QDP/6g7t80f
         Q+yxgMLFyuVO1FFugnEN8N0gEla7iKGDmuHrl6rXgJle0RRFotV4q2fID6GKLNNhmsh5
         QmLggh5en/s4EEcSdOh1+t0S71WgmTXQzzrjHrMzntEMC3yQqS+F5lRKw+QWatDC6cYN
         ob1a/Uw7P8sbjlnIxMdpls4Lp9kb6fAwwx56clRYGyAbvq72SORrE0De9QGXD3ziMNiT
         S/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=gYlEabMAXZxuCpuB6JgfWU70BTH7pLk+pLbwi0NCc/M=;
        b=nUe6Jrm/sPrlVkJSt8m0exEmfpOwjXl/EASD3q8dE5qsyMp+T3GvaZDN3hj1hxb7np
         VFIGXs41SZtuRUVRmZZxsDcpGT8oUDe6lSB719c/LNjuc3VbG/DMA58r0qkgGgg0PptF
         u8FuJN3zrI+tKfkaulwSZSeW90mMLbkzR2gOJOjVSXbvnLXb7mRtkKXWXBwJFYjqzrX7
         KMroDb9mucL1VmW1WHXNYEu9qmh7xCE0lowZgKiwx3l5QrWGTr89JpJda4DyF/NPsG3B
         A4hiMm8PPOg+vfy9JbU/Au+nNwDKI8qqPH06vpk4WOlx8DzHJrLMoU8/CksB+DnzDMfv
         25Mw==
X-Gm-Message-State: AJcUukeI4IP6VTmKhoVdpWgfJ/BYA3l+FR8JVZIh0vQ9VXWBzEp0z7ZR
        pZ8Lq1+0EaXyp7h22wbnkX2WvH+B
X-Google-Smtp-Source: ALg8bN5jcbLc+besv/lIfY3g0OSjoEH1AHTN3Ne+4PAQe/gShNwcdxogs5XIK0zooZ2sQVOwUMmY7w==
X-Received: by 2002:a17:906:345a:: with SMTP id d26mr15750849ejb.133.1548856478624;
        Wed, 30 Jan 2019 05:54:38 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id s19sm325045eja.52.2019.01.30.05.54.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 05:54:37 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 8/8] client: Don't expose pointer value in attribute path
Date:   Wed, 30 Jan 2019 15:54:24 +0200
Message-Id: <20190130135424.2091-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190130135424.2091-1-luiz.dentz@gmail.com>
References: <20190130135424.2091-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Instead use the position in the list to create a unique path:

[bluetooth]# register-service 0x1820
[NEW] Primary Service (Handle 0x0000)
	/org/bluez/app/service0
	0x1820
	Internet Protocol Support
---
 client/gatt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index 8e06e793f..06364a820 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -1449,7 +1449,8 @@ void gatt_register_service(DBusConnection *conn, GDBusProxy *proxy,
 	service = g_new0(struct service, 1);
 	service->conn = conn;
 	service->uuid = g_strdup(argv[1]);
-	service->path = g_strdup_printf("%s/service%p", APP_PATH, service);
+	service->path = g_strdup_printf("%s/service%u", APP_PATH,
+					g_list_length(local_services));
 	service->primary = primary;
 
 	if (argc > 2)
@@ -2330,7 +2331,8 @@ void gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy,
 	chrc = g_new0(struct chrc, 1);
 	chrc->service = service;
 	chrc->uuid = g_strdup(argv[1]);
-	chrc->path = g_strdup_printf("%s/chrc%p", service->path, chrc);
+	chrc->path = g_strdup_printf("%s/chrc%u", service->path,
+					g_list_length(service->chrcs));
 	chrc->flags = g_strsplit(argv[2], ",", -1);
 	chrc->authorization_req = attr_authorization_flag_exists(chrc->flags);
 
@@ -2600,7 +2602,8 @@ void gatt_register_desc(DBusConnection *conn, GDBusProxy *proxy,
 	desc = g_new0(struct desc, 1);
 	desc->chrc = g_list_last(service->chrcs)->data;
 	desc->uuid = g_strdup(argv[1]);
-	desc->path = g_strdup_printf("%s/desc%p", desc->chrc->path, desc);
+	desc->path = g_strdup_printf("%s/desc%u", desc->chrc->path,
+					g_list_length(desc->chrc->descs));
 	desc->flags = g_strsplit(argv[2], ",", -1);
 
 	if (argc > 3)
-- 
2.17.2

