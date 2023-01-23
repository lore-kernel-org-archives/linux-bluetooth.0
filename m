Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CD9C54EAA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Jan 2023 19:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjAWTtM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Jan 2023 14:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbjAWTtB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Jan 2023 14:49:01 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B7C3250A
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jan 2023 11:48:48 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id p24so12490796plw.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jan 2023 11:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxFB/vGyvOLqHBHjxb1DG1dv0eiHN4kUObFXqXhRuYU=;
        b=EG5V9woxCDgChsQbUtxN89Q/eai9B8k23FLXUTD0zdb6M4kJYsGbAbdew66tbvceTi
         op9Zoy4rFvx6lD/Eeds3aD1U0bi+hOoPh5XCd6maZiVCI4m4uCpm2xPK6+BkFb4DT4Vm
         54ZfimYYvKnOEAoT5fILXCfctHFRrYCqgzGppQFMgbTUGpx0vxk7dK/i7wUXyBfZ9ZPF
         mfGueMs/YeQy/uZp1ty9sW3NPizXtAcd2QHWgr0GkbMqSO5OH/fPp50/74RajjH5IoXp
         +2MwmEdhtwas816f9voo0+dFzHxHi8teZFYSUUgCzz39WjYT1Q74CFBiH4cis19Xtddu
         iE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MxFB/vGyvOLqHBHjxb1DG1dv0eiHN4kUObFXqXhRuYU=;
        b=BpdIifqhRUBOGCyMBQE+ChqaIhopwrkKsC2lKr6lbTS94goyyw/BNag53Vfa94e+pB
         DIjtBUSw3X7w4ARIm9hRjEsbHjnU2anxYQ3sYHxQgpa/K/iRwzMASIRq1fHUD9dW27oM
         HihMyVu/kcvXKWQf6a4rm3Er6SwOICiTfFnnd5toK8FPCzsoliiSwzysPGM5n2Tqyond
         vQ4k/tHnuWSDl6Z6FebScncGv8vu7/PpC3Y2HstwKj8OtfIM2IFX4wyMUkB8y6TcsRNi
         rFLoeB1U8DY3CO5M+ZZmyuGufgtI0wAI6YwORtS1isl/Q7KbNWwIBhQMRBLxzMrSNDCM
         0y7A==
X-Gm-Message-State: AFqh2kqZt+azVjV7Q0G7FINv7B51NWxc9aUIQHcmxPdZV/zYJW/RewN7
        ox0beydjlHbAtZrWXQxyaeFefv3fd91CoA==
X-Google-Smtp-Source: AMrXdXsNu+lTVetuE1TCibjqZMQuJw3wECK09jIltk3jpP3DL5sF1KbrHabbx7croidmkP6KiSOc3g==
X-Received: by 2002:a17:902:7881:b0:192:bb38:c412 with SMTP id q1-20020a170902788100b00192bb38c412mr25080056pll.44.1674503327979;
        Mon, 23 Jan 2023 11:48:47 -0800 (PST)
Received: from fedora.. (97-126-124-199.tukw.qwest.net. [97.126.124.199])
        by smtp.gmail.com with ESMTPSA id jj5-20020a170903048500b0017d97d13b18sm97068plb.65.2023.01.23.11.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 11:48:47 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com
Subject: [PATCH BlueZ v3 06/11] mesh: Add storage of Mesh Private Beacon settings
Date:   Mon, 23 Jan 2023 11:48:19 -0800
Message-Id: <20230123194824.257351-7-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230123194824.257351-1-brian.gix@gmail.com>
References: <20230123194824.257351-1-brian.gix@gmail.com>
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

