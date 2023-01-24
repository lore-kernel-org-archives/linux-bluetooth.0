Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8085C54EED
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Jan 2023 20:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbjAXU0v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Jan 2023 15:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbjAXU0g (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Jan 2023 15:26:36 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DD64A1E8
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 12:26:27 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id v23so15920852plo.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 12:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxFB/vGyvOLqHBHjxb1DG1dv0eiHN4kUObFXqXhRuYU=;
        b=IW3KlpXZK6kk20SnCBPv700MIunl2KQ8sZhk4vz/m4T6Sl5E7jVtZN/l8HeD8EA1i0
         R5dnEVf4zLP99ZHwaVZ0HwLd0QUDmF/zAVJ4oYaupElEUOhjS+rsDiYx6v45/e4roicY
         5b9nVOAGNdB/1UXJZpSax06F7hd/whItnpFKUF3cx4a8i6fK8XHedbzKX3FUiBKoLonJ
         +wu5N5eqN1y/b1X3QcH0SPonYGvmRcIAcpYR9i963x1fuYOiPDnkvrC3N9pvL9G24FN9
         uEn+PUQi4uNiSsgmEhyw2ywtbGmN6UxC+52T2OAEPL9E+Ai5mYpNQRQQoWv2UK0p7z/K
         vGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxFB/vGyvOLqHBHjxb1DG1dv0eiHN4kUObFXqXhRuYU=;
        b=J8FuQ47ZyQOqCegMo3osL/VXZxM9mNSUYN9uoUQzMzTa6IQtnyhZFZuuUdo+OrwHRI
         NQn40v2vwwcW+RJbYl9vi0YLwh6WyBpK5zxW/gHNrIjoglK9Zgp310fsnyPFdJCNp5XJ
         03So4etOwxfoACVAveFavoB6awfdsvaVM9YBoBydN1xBe2FcAwqaaQ8oL7onQnYFmvok
         NvG+HyrdW9wbQvnJCB1fKB8eaNFPSAuiLTO0bXux6LOOVZG4rOVsaLPB5S9zhcEEm05i
         cNrwd79oeRSvkUQvhmo2FooTUa0Kq9McRb7lAn9Rj7u/8rTFuv45ClqtlXtHo6ZOB2BF
         LcgA==
X-Gm-Message-State: AFqh2kogD69a2eU8HLC+YsSqQhziIW/6eUGCGetVYMgznREe0aBhLI+X
        LVXHUcu6TtYXLXxQFGZOl2CuJtSYN96bLg==
X-Google-Smtp-Source: AMrXdXuIONII86QtQgfNnza3TP6+p5GeLYzbn4hJm8o578lRHjjdaZ5nGnx9eNc6ZF2MTCxNBKfPFA==
X-Received: by 2002:a17:902:f682:b0:195:efa7:d54e with SMTP id l2-20020a170902f68200b00195efa7d54emr19874661plg.12.1674591986199;
        Tue, 24 Jan 2023 12:26:26 -0800 (PST)
Received: from fedora.. (97-126-124-199.tukw.qwest.net. [97.126.124.199])
        by smtp.gmail.com with ESMTPSA id ju21-20020a170903429500b0019600b78487sm2108099plb.33.2023.01.24.12.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 12:26:25 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ v4 06/13] mesh: Add storage of Mesh Private Beacon settings
Date:   Tue, 24 Jan 2023 12:26:09 -0800
Message-Id: <20230124202616.310544-7-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230124202616.310544-1-brian.gix@gmail.com>
References: <20230124202616.310544-1-brian.gix@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

If current storage does not exist in node.json, the Mesh Private
Beacon will be disabled.
---
 mesh/mesh-config-json.c | 48 +++++++++++++++++++++++++++++++++++++++++
 mesh/mesh-config.h      |  6 ++++++
 2 files changed, 54 insertions(+)

diff --git a/mesh/mesh-config-json.c b/mesh/mesh-config-json.c
index 8f321a731..c198627c6 100644
--- a/mesh/mesh-config-json.c
+++ b/mesh/mesh-config-json.c
@@ -1337,6 +1337,19 @@ static void parse_features(json_object *jconfig, struct mesh_config_node *node)
 			node->modes.beacon = mode;
 	}
 
+	if (json_object_object_get_ex(jconfig, "mpb", &jvalue)) {
+		mode = get_mode(jvalue);
+		if (mode <= MESH_MODE_UNSUPPORTED)
+			node->modes.mpb = mode;
+
+		if (node->modes.mpb == MESH_MODE_ENABLED) {
+			if (json_object_object_get_ex(jconfig, "mpbPeriod",
+								&jvalue))
+				node->modes.mpb_period =
+						json_object_get_int(jvalue);
+		}
+	}
+
 	if (!json_object_object_get_ex(jconfig, "relay", &jrelay))
 		return;
 
@@ -1576,6 +1589,18 @@ bool mesh_config_write_mode(struct mesh_config *cfg, const char *keyword,
 	return save_config(cfg->jnode, cfg->node_dir_path);
 }
 
+bool mesh_config_write_mode_ex(struct mesh_config *cfg, const char *keyword,
+							int value, bool save)
+{
+	if (!cfg)
+		return false;
+
+	if (save)
+		return mesh_config_write_mode(cfg, keyword, value);
+	else
+		return write_mode(cfg->jnode, keyword, value);
+}
+
 static bool write_relay_mode(json_object *jobj, uint8_t mode,
 					uint8_t count, uint16_t interval)
 {
@@ -1622,6 +1647,21 @@ bool mesh_config_write_relay_mode(struct mesh_config *cfg, uint8_t mode,
 	return save_config(cfg->jnode, cfg->node_dir_path);
 }
 
+bool mesh_config_write_mpb(struct mesh_config *cfg, uint8_t mode,
+								uint8_t period)
+{
+
+	if (!cfg || !write_mode(cfg->jnode, "mpb", mode))
+		return false;
+
+	if (mode) {
+		if (!write_int(cfg->jnode, "mpbPeriod", period))
+			return false;
+	}
+
+	return save_config(cfg->jnode, cfg->node_dir_path);
+}
+
 bool mesh_config_write_net_transmit(struct mesh_config *cfg, uint8_t cnt,
 							uint16_t interval)
 {
@@ -1746,6 +1786,14 @@ static struct mesh_config *create_config(const char *cfg_path,
 	if (!write_mode(jnode, "beacon", modes->beacon))
 		return NULL;
 
+	if (!write_mode(jnode, "mpb", modes->mpb))
+		return NULL;
+
+	if (modes->mpb) {
+		if (!write_int(jnode, "mpbPeriod", modes->mpb_period))
+			return NULL;
+	}
+
 	/* Sequence number */
 	json_object_object_add(jnode, sequenceNumber,
 					json_object_new_int(node->seq_number));
diff --git a/mesh/mesh-config.h b/mesh/mesh-config.h
index ed1b610de..3cb20b85d 100644
--- a/mesh/mesh-config.h
+++ b/mesh/mesh-config.h
@@ -60,6 +60,8 @@ struct mesh_config_modes {
 	uint8_t friend;
 	uint8_t proxy;
 	uint8_t beacon;
+	uint8_t mpb;
+	uint8_t mpb_period;
 };
 
 struct mesh_config_netkey {
@@ -140,9 +142,13 @@ bool mesh_config_write_seq_number(struct mesh_config *cfg, uint32_t seq,
 bool mesh_config_write_unicast(struct mesh_config *cfg, uint16_t unicast);
 bool mesh_config_write_relay_mode(struct mesh_config *cfg, uint8_t mode,
 					uint8_t count, uint16_t interval);
+bool mesh_config_write_mpb(struct mesh_config *cfg, uint8_t mode,
+								uint8_t period);
 bool mesh_config_write_ttl(struct mesh_config *cfg, uint8_t ttl);
 bool mesh_config_write_mode(struct mesh_config *cfg, const char *keyword,
 								int value);
+bool mesh_config_write_mode_ex(struct mesh_config *cfg, const char *keyword,
+							int value, bool save);
 bool mesh_config_comp_page_add(struct mesh_config *cfg, uint8_t page,
 						uint8_t *data, uint16_t size);
 void mesh_config_comp_page_del(struct mesh_config *cfg, uint8_t page);
-- 
2.39.1

