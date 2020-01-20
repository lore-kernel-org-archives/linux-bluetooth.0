Return-Path: <SRS0=TohX=3J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9442FC2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Jan 2020 16:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6258D217F4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Jan 2020 16:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="i6NCIIVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgATQLZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Jan 2020 11:11:25 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:51858 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATQLZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Jan 2020 11:11:25 -0500
Received: by mail-wm1-f49.google.com with SMTP id d73so157005wmd.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jan 2020 08:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Q345sRkXB8jCpvGazeS2vquZ1v6LwwTS+aDG6XXw6h8=;
        b=i6NCIIVcpKCiKdulIp8QvS7QaoNJ81keYe7jTSmRtEYv4IR4C9wYUY2k8AcmxK1OmD
         /a7vYxIq9ulOEX6Ojb4SizVtj1boraIsSm+og1r3LEqtnxjqw4HWMLvMh1reRWtJOSrV
         gVuErUU84C6KL7WNjq5fAhA+AVB+vHsD6c0rZLSfPJHoTstCEYUiKShwH8VthwbqmD0Z
         8YlMhTno+oBks6L1RKKbGswu9iGMzki9XssNxHJbEsZIgYhB+0nvFvwx+/1xrstNHtKM
         ZbZ9GF3kwGXTGfOjiystXu2+iYWH6JOvP860OuORUbTLmPS7nc3GYtrQ+GUDXEhewjZU
         iA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q345sRkXB8jCpvGazeS2vquZ1v6LwwTS+aDG6XXw6h8=;
        b=XP5ZiHud3mUBUMYYSA3TyNci9faMeAcgKM7YJDRtLcPLZDZwSajBS9tLS8mDBZ+Mq+
         L7oC5ToZs+LDHv3Zuvey62ugyFNy5ph87geL7CTaErkxbHGwRBpKs9RRPOs7aYwOtvqg
         dUB+Ggb3HYinPSD0fvpMf7NlwQGn1D21CmmmWGmN5lx9cwL4pUJu5hDyf2CjesPa/eBs
         9A/PmYR4EVcUoCILbn1Avt+R/+bcmaT0HEHRNrPVlShhm7Z5XQsHddUDOMDbB5Vq/QYr
         JbatqX26k+0uhtlY/ih2KSFbGGmSzxwM6orBmmRRlp0lMeCIdZJTqsFQDjXvDFPMrSTq
         +yQw==
X-Gm-Message-State: APjAAAWCU/zDnXQlFU6ZJYZ9fUy7ylG6rj5Dvo7u/x3O/qVyzJ7ZhX4y
        99GwX4TbjJkUHSze7UW38VhOtDPLLhWObg==
X-Google-Smtp-Source: APXvYqwpYRN2/FDpphkeavOWDGYZp2Es/i8fgU2BWdCN24xvls5zrPPvLym+78Px3GdvBih4rk6IFA==
X-Received: by 2002:a1c:541b:: with SMTP id i27mr71457wmb.137.1579536683814;
        Mon, 20 Jan 2020 08:11:23 -0800 (PST)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id 16sm22564602wmi.0.2020.01.20.08.11.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 08:11:23 -0800 (PST)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] mesh: add composition data setter
Date:   Mon, 20 Jan 2020 17:11:13 +0100
Message-Id: <20200120161114.6757-3-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200120161114.6757-1-jakub.witowski@silvair.com>
References: <20200120161114.6757-1-jakub.witowski@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/mesh-config-json.c | 46 +++++++++++++++++++++++++++++++----------
 mesh/mesh-config.h      |  2 ++
 2 files changed, 37 insertions(+), 11 deletions(-)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 5855149e3..ee42cf7df 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -1456,6 +1456,27 @@ static bool write_mode(json_object *jobj, const char *keyword, int value)
 	return true;
 }
 
+static bool write_comp(json_object *jobj, uint16_t cid, uint16_t pid,
+						uint16_t vid, uint16_t crpl)
+{
+	if (!jobj)
+		return false;
+
+	if (!write_uint16_hex(jobj, "cid", cid))
+		return false;
+
+	if (!write_uint16_hex(jobj, "pid", pid))
+		return false;
+
+	if (!write_uint16_hex(jobj, "vid", vid))
+		return false;
+
+	if (!write_uint16_hex(jobj, "crpl", crpl))
+		return false;
+
+	return true;
+}
+
 bool mesh_config_write_mode(struct mesh_config *cfg, const char *keyword,
 								int value)
 {
@@ -1595,17 +1616,8 @@ static struct mesh_config *create_config(const char *cfg_path,
 
 	jnode = json_object_new_object();
 
-	/* CID, PID, VID, crpl */
-	if (!write_uint16_hex(jnode, "cid", node->cid))
-		return NULL;
-
-	if (!write_uint16_hex(jnode, "pid", node->pid))
-		return NULL;
-
-	if (!write_uint16_hex(jnode, "vid", node->vid))
-		return NULL;
-
-	if (!write_uint16_hex(jnode, "crpl", node->crpl))
+	/* CID, PID, VID, CRPL */
+	if (!write_comp(jnode, node->cid, node->pid, node->vid, node->crpl))
 		return NULL;
 
 	/* Features: relay, LPN, friend, proxy*/
@@ -2052,6 +2064,18 @@ bool mesh_config_write_ttl(struct mesh_config *cfg, uint8_t ttl)
 	return save_config(cfg->jnode, cfg->node_dir_path);
 }
 
+bool mesh_config_write_comp(struct mesh_config *cfg, uint16_t cid, uint16_t pid,
+						uint16_t vid, uint16_t crpl)
+{
+	if (!cfg)
+		return false;
+
+	if (!write_comp(cfg->jnode, cid, pid, vid, crpl))
+		return false;
+
+	return true;
+}
+
 static bool load_node(const char *fname, const uint8_t uuid[16],
 				mesh_config_node_func_t cb, void *user_data)
 {
diff --git a/mesh/mesh-config.h b/mesh/mesh-config.h
index a5b12bbad..5a003b95c 100644
--- a/mesh/mesh-config.h
+++ b/mesh/mesh-config.h
@@ -135,6 +135,8 @@ bool mesh_config_write_unicast(struct mesh_config *cfg, uint16_t unicast);
 bool mesh_config_write_relay_mode(struct mesh_config *cfg, uint8_t mode,
 					uint8_t count, uint16_t interval);
 bool mesh_config_write_ttl(struct mesh_config *cfg, uint8_t ttl);
+bool mesh_config_write_comp(struct mesh_config *cfg, uint16_t cid, uint16_t pid,
+						uint16_t vid, uint16_t crpl);
 bool mesh_config_write_mode(struct mesh_config *cfg, const char *keyword,
 								int value);
 bool mesh_config_model_binding_add(struct mesh_config *cfg, uint16_t ele_addr,
-- 
2.20.1

