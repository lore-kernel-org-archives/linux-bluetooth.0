Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C11C46467
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Jan 2023 23:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjASX6S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Jan 2023 18:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjASX6Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Jan 2023 18:58:16 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85553A103C
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jan 2023 15:58:10 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id z13so3866442plg.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jan 2023 15:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b48kmI/BztgRM+uAhPW4+zfV7sMkQU8z8Z1nGlrlajc=;
        b=W4yuWJzBa9lU6yIICkKEjfPnsfuGQN+FwJ9MxknRR+bC3Qx7XhqmM58nj79T3SPt6v
         4AriQ9rfNyLXyKMvOtpczRaXmtFM5ByDKXB4uffREQohNxHTcGaCKwdibgP6iJEycw9U
         LgA7tcLRd2O3Q4PCT3Su/itMo3TJIxbEyGE8CHbikuozguXZr14aFQxGKq0dcSNNCItk
         BN+NY3946yINCbK6sYH5FPU/d9JlHmn4LDqu07SHCLD542xezWHmL7sCey2eWwPuvsKz
         4cBPXl4PTN4pGdLBKb8I5FRE81c822310SvQkl6nhnH1uVlXDVKUrc68dh5P1vpnPkym
         j3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b48kmI/BztgRM+uAhPW4+zfV7sMkQU8z8Z1nGlrlajc=;
        b=QVcMUbRQym82Q1+V+VkaXPkH2c5ErW2tv+T6D1xmKdYDeoGJx2rX8FWUHWmIjDyNHL
         NyDIl9PkUt7/WoXaQmYHe/zGUfzpqyxB0c9BT5JTDLsMe/+FY/LrhKXfAhBFpViQjNSM
         dnjnqma9Vkq525IPMDnK4eIVT3WdAeAwh+WNqwjYRBeOC3n23H4Itd3k4SNKdnMnyxr2
         Rxl7ISpTtag1mYPzpaQ0+qVBjvB8A7x+iYP8wRjmESyBbR8hPFdPu3MAn6EidTj+5L9n
         ups6wdQFdcgfjFO+ZeQvhM0w5mINnjAXAEIRINSQE1fChbMcgQio/9hRnHdB6Ohm7ovU
         Sq1g==
X-Gm-Message-State: AFqh2krTdmHy34fxRXs/ATmDoUYIooqPWprs7kt47sdJNIL4dK+ufWgw
        TH1Mu8XpglfYgGPVVQFr0jXRGvUxZnafQw==
X-Google-Smtp-Source: AMrXdXuMqJpwa6aw7ZOvSBQYePlD2uDNc0qjNt2MnQIbNUXJ37Xa+cvnO7hw1EDwNbMbQzaAjOGG0w==
X-Received: by 2002:a17:903:108c:b0:194:d13d:64d8 with SMTP id u12-20020a170903108c00b00194d13d64d8mr2875763pld.27.1674172689487;
        Thu, 19 Jan 2023 15:58:09 -0800 (PST)
Received: from fedora.. (97-113-173-242.tukw.qwest.net. [97.113.173.242])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902d2ca00b0019460c34839sm14826373plc.185.2023.01.19.15.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 15:58:08 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ 06/12] mesh: Add storage of Mesh Private Beacon settings
Date:   Thu, 19 Jan 2023 15:57:49 -0800
Message-Id: <20230119235755.46002-7-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119235755.46002-1-brian.gix@gmail.com>
References: <20230119235755.46002-1-brian.gix@gmail.com>
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

