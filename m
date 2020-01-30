Return-Path: <SRS0=xtvM=3T=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C62C2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jan 2020 14:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A36F20678
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jan 2020 14:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="tiY41Aok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgA3Oeh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jan 2020 09:34:37 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36925 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbgA3Oeg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jan 2020 09:34:36 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so4322203wru.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jan 2020 06:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=DJ6Q57hGK1VsvuqVochs9G8UKuI8NFxmGEDJ9WKl60k=;
        b=tiY41AokQS+g+vYHbnd9StQRUZvWXjNza08Jy3AlCE1KJe2UTx6kZl7Ik0HQGTeSqg
         D073Cy/P3aRYfNcsGjYFU5fe5KOlFh0ah8OhGbRPXUz2fvWUnwnp3gALHSIbamRvWOmU
         NeKr9qJG+9+vFdpyt2jKWDRijAxLAc+zbEEXtVQimd+mcghPAg/egmrsc9fhEHoTyvSo
         jpjJRA+PR49ssX6pg6Uiw1+7xpIPihqnSMqDVJsZCwZmAULV5Nt2WxjnGqDBnQOrShFR
         /G/icBHU3ejgD4THo6NwHZeLcttJ9UVy5vozaVDfMGWoaqJZGDiKc88J463O5UhYo48i
         qXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DJ6Q57hGK1VsvuqVochs9G8UKuI8NFxmGEDJ9WKl60k=;
        b=mzQN2Ltm8gH772/h6etVlMg2k7FVKIJD0bnCyeswz/LWe1y/DEVeBpA0lpK+dI5JHr
         AY7f6TnJHw9Z105z9LDG5S/vF63aoNUZVAXDL1KRWf5q1mgXDY2cmxE2eIBXldJQBaDL
         HA2DxqEUdkHKQr55hFUIKJSV6cdNDMWYOAVwC8XBbvUwflIuZz7DUl6urZqLWNY8FTi+
         9XBA5/OBqrafUl9paWQKOiS5XKem+uoE9qKxUX5UNXly1/NjdzfUe2TuQ2nTY0DtIv4P
         jCBJgAT0tB2yTcbRf1ZVWO4F4nxuGT1mF25zOnxHHktGh+qrssMnzJds7VrxWbNyBN2m
         Zu1Q==
X-Gm-Message-State: APjAAAX2W7C2xP7iwtrQ+9+YhkWBwnDbVDhNFunSO34+GaA/m3TgrL2l
        4eyp3hSr80DS98m8ZfdD9vfxatVSy10rMw==
X-Google-Smtp-Source: APXvYqyDlgKRUMpvopsLMCkoa5oLJWAt1ACpe116BscWZn94ET4H6HHufV9Jq4VPgRSoQoWyLed4NQ==
X-Received: by 2002:a5d:6551:: with SMTP id z17mr6033796wrv.269.1580394873221;
        Thu, 30 Jan 2020 06:34:33 -0800 (PST)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id x10sm7353310wrv.60.2020.01.30.06.34.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 06:34:32 -0800 (PST)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/4] mesh: add cid/pid/vid setter
Date:   Thu, 30 Jan 2020 15:34:23 +0100
Message-Id: <20200130143425.5844-3-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200130143425.5844-1-jakub.witowski@silvair.com>
References: <20200130143425.5844-1-jakub.witowski@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds the setter for the CID PID and VID.
---
 mesh/mesh-config-json.c | 40 ++++++++++++++++++++++++++++++++--------
 mesh/mesh-config.h      |  2 ++
 2 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 5855149e3..0574c166e 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -1456,6 +1456,24 @@ static bool write_mode(json_object *jobj, const char *keyword, int value)
 	return true;
 }
 
+static bool write_comp_id(json_object *jobj, uint16_t cid, uint16_t pid,
+								uint16_t vid)
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
+	return true;
+}
+
 bool mesh_config_write_mode(struct mesh_config *cfg, const char *keyword,
 								int value)
 {
@@ -1595,16 +1613,10 @@ static struct mesh_config *create_config(const char *cfg_path,
 
 	jnode = json_object_new_object();
 
-	/* CID, PID, VID, crpl */
-	if (!write_uint16_hex(jnode, "cid", node->cid))
-		return NULL;
-
-	if (!write_uint16_hex(jnode, "pid", node->pid))
-		return NULL;
-
-	if (!write_uint16_hex(jnode, "vid", node->vid))
+	if (!write_comp_id(jnode, node->cid, node->pid, node->vid))
 		return NULL;
 
+	/* CRPL */
 	if (!write_uint16_hex(jnode, "crpl", node->crpl))
 		return NULL;
 
@@ -2052,6 +2064,18 @@ bool mesh_config_write_ttl(struct mesh_config *cfg, uint8_t ttl)
 	return save_config(cfg->jnode, cfg->node_dir_path);
 }
 
+bool mesh_config_write_comp_id(struct mesh_config *cfg, uint16_t cid,
+						uint16_t pid, uint16_t vid)
+{
+	if (!cfg)
+		return false;
+
+	if (!write_comp_id(cfg->jnode, cid, pid, vid))
+		return false;
+
+	return true;
+}
+
 static bool load_node(const char *fname, const uint8_t uuid[16],
 				mesh_config_node_func_t cb, void *user_data)
 {
diff --git a/mesh/mesh-config.h b/mesh/mesh-config.h
index a5b12bbad..9a5d6e57a 100644
--- a/mesh/mesh-config.h
+++ b/mesh/mesh-config.h
@@ -135,6 +135,8 @@ bool mesh_config_write_unicast(struct mesh_config *cfg, uint16_t unicast);
 bool mesh_config_write_relay_mode(struct mesh_config *cfg, uint8_t mode,
 					uint8_t count, uint16_t interval);
 bool mesh_config_write_ttl(struct mesh_config *cfg, uint8_t ttl);
+bool mesh_config_write_comp_id(struct mesh_config *cfg, uint16_t cid,
+						uint16_t pid, uint16_t vid);
 bool mesh_config_write_mode(struct mesh_config *cfg, const char *keyword,
 								int value);
 bool mesh_config_model_binding_add(struct mesh_config *cfg, uint16_t ele_addr,
-- 
2.20.1

