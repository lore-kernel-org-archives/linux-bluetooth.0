Return-Path: <SRS0=GeDB=5Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D5FC2BB85
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 19:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB082074F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 19:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="uolOy8Fa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgDITro (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:47:44 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41218 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbgDITrn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Apr 2020 15:47:43 -0400
Received: by mail-lj1-f196.google.com with SMTP id n17so976082lji.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2020 12:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bg5r2aE6Owh4lWMBQuidSHBU9dZmz8nf0T5rM6l2dLo=;
        b=uolOy8FakFx62tm/bMyKXYeALvKl8tiWRYlxoneVdebkqKa5wItoKQ0sGfhXFyplkW
         1AD67AjDqmQR6J8O5Ox1HxvB/7UM05SNOqIezbrjDQv1scfGgBL1RrBNXGQyGaRVgfRh
         ylYQNBu4jqGA5Jm49MP902uJS1LywC+iVndgVYHSInphFmlISWijKJq7Z6NFgesdB7wP
         eDad2uIVsmfrxKmUS7ErYIAfu0iAG8c7x8z3oAf/waUeOL+BoZQSMCeDNqy1Wz/hGglS
         6iwvPG9iajpyz/ISj5zNsCAy83zGQ4P//plHH61Y4DN5URAMhBtPMm1oqGlbL/SSkHxS
         Arkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bg5r2aE6Owh4lWMBQuidSHBU9dZmz8nf0T5rM6l2dLo=;
        b=RY2eoa7ZeJFDCk9R8OrWDDNiLIjKSa3jCaeJ+Uf4IVfer7jLInUMjRAxTIXn91Y1Pk
         xF8W1UsRbMAfGScwI4kAuRQ6dLvocdrv+DLb/dg+4PvlC2vX+TUNw0q4ZMV8L6/m/9hY
         2trBMVIUYD/m3D6kg5aRjxzY+e38Q/3m7/RpIRlnPBjzWvdIqTgZnpDwMk8xtRgyon2F
         MFhjbGLsky2sFGC3+Ls7ZN4DS0eKeFA34EXsJ1AuQGPBy7cZt0TVmosp6vUsRzzd2cJE
         Pt3a5s6ovLMUsNho0iRj1z46FCp+fsGVLF+FqHrq954UI+mMmHm08xQTJD+LaqJsWEva
         VSaQ==
X-Gm-Message-State: AGi0PuZ3+iXyUbu08vCgR/QQwYZufYEDF7EL0fWZmmzs9F8sSE890+bf
        6b4FHCtpNoPEyUctzvxkm/nrwOgngbk=
X-Google-Smtp-Source: APiQypJTVvEq+9+Ozy5iX4NdrRMAjTaV22mHb9lYB4ypH6FaV3/zA0saqWA3UNcNrCZhsdxU2AmdXg==
X-Received: by 2002:a2e:9a87:: with SMTP id p7mr864312lji.61.1586461661748;
        Thu, 09 Apr 2020 12:47:41 -0700 (PDT)
Received: from kynes.internet.domowy (apn-37-7-76-34.dynamic.gprs.plus.pl. [37.7.76.34])
        by smtp.gmail.com with ESMTPSA id l13sm15915895ljc.84.2020.04.09.12.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 12:47:41 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?Przemys=C5=82aw=20Fierek?= 
        <przemyslaw.fierek@silvair.com>
Subject: [PATCH BlueZ v2 1/4] mesh: Fix invalid app_path on 'Join'
Date:   Thu,  9 Apr 2020 21:47:30 +0200
Message-Id: <20200409194733.18039-2-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200409194733.18039-1-michal.lowas-rzechonek@silvair.com>
References: <20200409194733.18039-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Przemysław Fierek <przemyslaw.fierek@silvair.com>

This patch fixes invalid app_path on 'Join' method call - the daemon
tried to use the value of app_root API argument, while it should use
path discovered by scanning result of GetManagedObjects() call.
---
 mesh/mesh.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mesh/mesh.c b/mesh/mesh.c
index 9b3768b69..a9d5d5dea 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -72,7 +72,6 @@ struct join_data{
 	struct l_dbus_message *msg;
 	struct mesh_agent *agent;
 	char *sender;
-	const char *app_path;
 	struct mesh_node *node;
 	uint32_t disc_watch;
 	uint8_t *uuid;
@@ -445,7 +444,7 @@ static bool prov_complete_cb(void *user_data, uint8_t status,
 		return false;
 
 	owner = join_pending->sender;
-	path = join_pending->app_path;
+	path = node_get_app_path(join_pending->node);
 
 	if (status == PROV_ERR_SUCCESS &&
 	    !node_add_pending_local(join_pending->node, info))
@@ -551,7 +550,6 @@ static struct l_dbus_message *join_network_call(struct l_dbus *dbus,
 
 	join_pending->sender = l_strdup(sender);
 	join_pending->msg = l_dbus_message_ref(msg);
-	join_pending->app_path = app_path;
 
 	/* Try to create a temporary node */
 	node_join(app_path, sender, join_pending->uuid, node_init_cb);
-- 
2.26.0

