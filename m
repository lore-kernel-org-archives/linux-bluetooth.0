Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B184C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Jan 2023 23:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjA3Xw2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Jan 2023 18:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjA3XwZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Jan 2023 18:52:25 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0AA2E0E3
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 15:52:23 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id cq16-20020a17090af99000b0022c9791ac39so4862321pjb.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 15:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxFB/vGyvOLqHBHjxb1DG1dv0eiHN4kUObFXqXhRuYU=;
        b=mCOO3eNsXneMFaYGGZReT72ttRw2CTaOFdGfRHEI5d7S1GyXWdS5Rp5qEsLllkBnmc
         uXrFtp7+PQgegL7sxIkJBH9OAVeBt2pPCmvCvbsuldlzJnk5nbxoVL8ptialVPBliatQ
         /B0qQsRD2TxIznY3UU4t0Npjs+bo4br3IVv7rXdycpx9vGhFzykEqJIogtwL8Cnx+Brc
         1hNIUYnTKEG1uE01XbEUo6rfit4dW6ZSJ/jYG6pU7hMzv6fIhWLKAozxgln6FGAV9vDA
         kkvL7mHhDMgGKS67HWV7Cck2AEFN6DxO6BcqwYzQgeZGXozUXmhQWE/bj5o/vUbbVi2z
         GxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxFB/vGyvOLqHBHjxb1DG1dv0eiHN4kUObFXqXhRuYU=;
        b=JqCQp1RZG3UrC0am2aaGmY9zfXdUUqIKkfUwowztWa5lykh9m3xvvzdXvpLOgibDu+
         g24zFLC6dt/9InrQEyl2MWqRBm0ZM96wGiJUHq8TZ5uKIK1zBNqlZyCjq4gCW0DOI4RW
         h4gEdEaO9yiG3vWljs9cRVG8IErMcKUL2CT+psmpa8R4iwlFdUVQQuz2/wg01D3h7F+I
         L5QEjPhyoWbDjW3CpiOn/GhnZKgApSWpo47q0ozEc5+lDL/EewP3tA1BqRaMr88KYhu4
         1Mn9/evaIVn9AXVr3QzEApPrMYLRDAoGfnw5UkQU8mwqeg/ZZkMVJV62Ow4VkSTvPV2e
         jy8w==
X-Gm-Message-State: AO0yUKUYKhcXTjVtx3Sv6An/BvquHDI5cZvLj69vBzgeKg0WtvTHpbLZ
        jNxJdXeXKGkXz7YXwkXBOYbAEFYtbOa2sQ==
X-Google-Smtp-Source: AK7set9+HIi2TWHSAq4x/ccDMJII2/04tdx3FujHApOicgk0hxTAowBLvgtX5mldnFsDJAvdtpx28g==
X-Received: by 2002:a17:90a:1952:b0:22c:3edd:7e48 with SMTP id 18-20020a17090a195200b0022c3edd7e48mr16028677pjh.32.1675122742664;
        Mon, 30 Jan 2023 15:52:22 -0800 (PST)
Received: from fedora.. (97-126-124-199.tukw.qwest.net. [97.126.124.199])
        by smtp.gmail.com with ESMTPSA id t191-20020a6381c8000000b004e8f7f23c4bsm2663948pgd.76.2023.01.30.15.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 15:52:22 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH BlueZ v5 06/14] mesh: Add storage of Mesh Private Beacon settings
Date:   Mon, 30 Jan 2023 15:52:02 -0800
Message-Id: <20230130235210.94385-7-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230130235210.94385-1-brian.gix@gmail.com>
References: <20230130235210.94385-1-brian.gix@gmail.com>
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

