Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBFCC25B50
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Jan 2023 19:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjATTrp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Jan 2023 14:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjATTro (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Jan 2023 14:47:44 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2718CE7E
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jan 2023 11:47:43 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so10033564pjg.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jan 2023 11:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b48kmI/BztgRM+uAhPW4+zfV7sMkQU8z8Z1nGlrlajc=;
        b=RlAmG8kzgcYe2iBvDZYJqNezC2/ar7qUwvB/hC3ZkHgq4LPQL0r7WlsKEbB7AY6lR5
         KNkFf9zc2WtXpXrc74UDq2RM1kJWANUUiB8bqiLXaJTuw6IogJOFecdi50OVznr2LVp9
         1eicY1+i7UPsQMjIal52EoYKqkS/Lovom2XIhU9uXBvNPLwgz0uAJ/a8sL0iQvTBHU39
         kIk+9G6OA8ltOrdqxt6XqA677xiNkvOazSvyCs+M4ZNbgPhXVGyvNbMQkyu3gGzfUmpZ
         CaYLhkwZ18tgMp1iv4uVxL8BoD+UD5k5PFJaTFZYyoc4x/shtY0TLsRgwMwE//mpk/LN
         2H+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b48kmI/BztgRM+uAhPW4+zfV7sMkQU8z8Z1nGlrlajc=;
        b=vpe2+L9CixEGF0mpyGQSwx2NjxLdzUPEpmaRzmC6l/NPTUu9KCfpFJkcCAaAAw+tus
         c/9k8UydCvYU1iQKn0GziUJ0u0NZA1+XOIORfL3iguxEodbucrXDuFEhDNWr6ahf/dQN
         zU5MYziyzey14ZyGfOWUJEiRK3pVWXK96btkSqo3friuwwFKIBfpceoM6ixOSxpGN7jv
         1TDqK5IQnhGOjST5FevZ4n6uNRy0VlO64HxZhyVdOLMkrbVtcRWkPVW3nOgsvaeb3BBt
         ID/01z4JZMx77f9dUvfV/DMjLM6IiRMcrM7NQTmh3lZkRaquz61aHFzeJesyeldWz0os
         Id8w==
X-Gm-Message-State: AFqh2kpDCwqWHCcWRZDp7Rcg+EkSpwZP5Xer58xHo3F9TnH1SbFeJ9A1
        wmLrGLc+ZRQY9syXut/mDSqbgrnEBIJIoQ==
X-Google-Smtp-Source: AMrXdXuXuK92aTyAxyB0wegeWwhAnfPDRj/FvVN5KQ+LeXDjuNMrvZcuOZw7VtGFG2miAs3mT7kH4w==
X-Received: by 2002:a17:902:efc3:b0:194:45d0:3b21 with SMTP id ja3-20020a170902efc300b0019445d03b21mr16319342plb.4.1674244062084;
        Fri, 20 Jan 2023 11:47:42 -0800 (PST)
Received: from fedora.. (174-21-24-126.tukw.qwest.net. [174.21.24.126])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090322cd00b001896af10ca7sm5149967plg.134.2023.01.20.11.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 11:47:41 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ v2 06/11] mesh: Add storage of Mesh Private Beacon settings
Date:   Fri, 20 Jan 2023 11:47:26 -0800
Message-Id: <20230120194731.90065-7-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120194731.90065-1-brian.gix@gmail.com>
References: <20230120194731.90065-1-brian.gix@gmail.com>
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
2.39.0

