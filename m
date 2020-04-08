Return-Path: <SRS0=PsJ4=5Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EC3C2D0F4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Apr 2020 20:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1EB20771
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Apr 2020 20:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="Ui0VDk8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgDHUxJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Apr 2020 16:53:09 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45819 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728913AbgDHUxJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Apr 2020 16:53:09 -0400
Received: by mail-lf1-f65.google.com with SMTP id f8so6202588lfe.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Apr 2020 13:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bg5r2aE6Owh4lWMBQuidSHBU9dZmz8nf0T5rM6l2dLo=;
        b=Ui0VDk8fWlTsv2t+9vHktdZeSpsqJvHtYZAMzz5BxBLuiyh9VSKxUWz3WPnsKBMgOY
         Gw8oZwh4wy7EdQtqcOeJO42NtnWENbKziaEyOAIsPHBVAq0TBZ0gjqrAQVVbVNHydzgN
         M0Vddx3kN9EJ1+RCHF0NJjPzsxIU1ceTvIASqqITMsbz29kw8515OqP++AyQJ5neLpzT
         o7tNZXGTdw0dSWZriTAGpfuT7h7fSnSQH9JLQHboRUQAZfeXo+B9556E/i1WXlZyywW7
         oeCtjOKyXJ8wPAKp+0azirSLp6MP9oyR9ANwbjjA2EYAkPajWkoszy/NlnqDBh52ui5E
         aCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bg5r2aE6Owh4lWMBQuidSHBU9dZmz8nf0T5rM6l2dLo=;
        b=ONwQChK9k3m8MwWlqfy8IJDBSXyZrUdhSIOSTyDTSpf3Qi+V8S+3/udapZqANao45/
         MUKtChlmJb+MJr3HELkFHwDAe94APaAMgCJzR7BRWBQ4w3XZohsSbpHduXkDRXXu8aah
         qJcqZfSklF+BcRA7yXbhuPo/q2/tSXN4FvpsSeYgCfwFFq5IUS6TuMgRIsKGScb6sAxI
         cZTiklEjuHoTtEn62G5LRgMjNb9HJPOYWirrr1zwdfJCNR6bYfQMBhnxtYFaC4fe8/9F
         AWoazZb7shhCM+TweuOuwUITDRRLyrUZYuUBPf3ln+rCpv/Dpuezt+vmPE6f8QYmQfZj
         cLjw==
X-Gm-Message-State: AGi0PuZyEt2D3Jb4G7Bzd4MyF1yBJXX3AMMRHlQofaFpE8MInsILJ8Jq
        VTXbNx/CxSLz76ob2QGiocRsCIbytk4=
X-Google-Smtp-Source: APiQypIb8VScyYlky5dYDI2jPjWLiiuZzJz0Gnyycbe6QV4bEMxZiGE7Qrdyvhf9c+w/z0YOof1D/g==
X-Received: by 2002:a19:c607:: with SMTP id w7mr5632824lff.32.1586379184485;
        Wed, 08 Apr 2020 13:53:04 -0700 (PDT)
Received: from kynes.internet.domowy (apn-37-7-76-34.dynamic.gprs.plus.pl. [37.7.76.34])
        by smtp.gmail.com with ESMTPSA id r24sm14168976ljn.25.2020.04.08.13.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 13:53:03 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?Przemys=C5=82aw=20Fierek?= 
        <przemyslaw.fierek@silvair.com>
Subject: [PATCH BlueZ 1/4] mesh: Fix invalid app_path on 'Join'
Date:   Wed,  8 Apr 2020 22:52:52 +0200
Message-Id: <20200408205255.45112-2-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200408205255.45112-1-michal.lowas-rzechonek@silvair.com>
References: <20200408205255.45112-1-michal.lowas-rzechonek@silvair.com>
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

