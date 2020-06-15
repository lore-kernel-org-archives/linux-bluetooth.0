Return-Path: <SRS0=u3xs=74=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF27C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jun 2020 11:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C89A20679
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jun 2020 11:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="Ddtqm6Xj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgFOLLq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jun 2020 07:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgFOLLj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jun 2020 07:11:39 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC53C061A0E
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 04:11:38 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u25so2793166lfm.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 04:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZnuAcdMnPsU+0QvTurZJgPGJvDcvnFpgfhe3386GwoQ=;
        b=Ddtqm6XjHWO4ycilR0FE7p53PISdnhP9uJr3Mp61UaFY3sr7xHOKkO3ts4xWbOIafO
         968BpW9yDpwgGPuMWz08nnSrbgyI3GYClVKTOnLlu8gW8bvuKds5xxweiYktw+8zIOfk
         LkB8Ao0NU8yNArrNpLrFIbFDXzzzEeeWSkiSH1dyYeqxo+g7tMdt+/57i7FdEwWid+/5
         At0rztCRsIa/HUE7t0Fg61OpiFJateHacp/618WdKlLiJVljd4NwsrcbuBiunf2giR24
         LE8/wSnpjYN/u1hFoBXYX4HLdEMbVnj/ru29E3ruE9tc8u84r5r6hnLhfdwnI56dqLj3
         r9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZnuAcdMnPsU+0QvTurZJgPGJvDcvnFpgfhe3386GwoQ=;
        b=PkVoMYLewaCnR9fg/Q2kTgSarXo8efZdqSHiJe1Jw/xghcSL0FnA646niCxAGQwz15
         UVuOULP9Id/Ujlu5+fwKEDRNjhh0WV7MNJrp0ZNMP+ybQoVRWzEFdytyAzoy9YX3mWks
         +N1pBxgKkvQODoWHfVGHXBMEWI6FfCFZT3PsCOWg/RtXAUMO9rBqMil1PSN+5jeYu60L
         YieAY1P2bDmB+x+y9GBmj5Ahr1UAGhNGucz0PDcHCffEMTIU9RC4ff5kibEihPQlWsEC
         TenbW7YkOSlX0vrEx2UMr/DrSEWeuH2008r2iOSN0RCj8cVaIZ2o8Bx5dqjkoNamDn6i
         Fh5w==
X-Gm-Message-State: AOAM531C2NhOaWYpv8wNyqPmRfNdCWDIuKNqi/tYkBPBb6yK2NhWvwBw
        tWWmWlQ6Y5qj6BoSncYxE0u/KwFh6FdY+Q==
X-Google-Smtp-Source: ABdhPJxWoLzN6co+pgJNTGIZSY5uG4uZmay4PTbLu6gc8GP2hke/F8SCzsawYWAcEakcx7VkeYwmOQ==
X-Received: by 2002:a19:b01:: with SMTP id 1mr7158786lfl.54.1592219495655;
        Mon, 15 Jun 2020 04:11:35 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id r7sm3750891ljc.62.2020.06.15.04.11.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 04:11:35 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Fix updating CID, PID, VID & CRPL on node attach
Date:   Mon, 15 Jun 2020 13:11:52 +0200
Message-Id: <20200615111152.29089-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In 8a382262125787caf38a1f800ec8956a1bf71d85, we wanted to allow the
application to update certain composition fields. This patch makes it
work.
---
 mesh/node.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mesh/node.c b/mesh/node.c
index 10b44c8a5..6140fdf9f 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -1365,16 +1365,18 @@ static bool add_local_node(struct mesh_node *node, uint16_t unicast, bool kr,
 static void update_composition(struct mesh_node *node, struct mesh_node *attach)
 {
 	if (node->comp.cid != attach->comp.cid)
-		mesh_config_update_company_id(node->cfg, attach->comp.cid);
+		mesh_config_update_company_id(attach->cfg, node->comp.cid);
 
 	if (node->comp.pid != attach->comp.pid)
-		mesh_config_update_product_id(node->cfg, attach->comp.pid);
+		mesh_config_update_product_id(attach->cfg, node->comp.pid);
 
 	if (node->comp.vid != attach->comp.vid)
-		mesh_config_update_version_id(node->cfg, attach->comp.vid);
+		mesh_config_update_version_id(attach->cfg, node->comp.vid);
 
 	if (node->comp.crpl != attach->comp.crpl)
-		mesh_config_update_crpl(node->cfg, attach->comp.crpl);
+		mesh_config_update_crpl(attach->cfg, node->comp.crpl);
+
+	attach->comp = node->comp;
 }
 
 static bool check_req_node(struct managed_obj_request *req)
-- 
2.20.1

