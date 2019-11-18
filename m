Return-Path: <SRS0=idF9=ZK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DE0C432C0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 15:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8129D2195D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Nov 2019 15:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="OZLYLEnH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfKRPmB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Nov 2019 10:42:01 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33960 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbfKRPmA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Nov 2019 10:42:00 -0500
Received: by mail-lj1-f194.google.com with SMTP id 139so19493234ljf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2019 07:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=awYal+sTVPCmJsCIpMH2aH7rUwDfR0RFqVvtjnSCNa4=;
        b=OZLYLEnHqlXaneiVVyFPu2hzC7R/XE9+o/XJmUNCaewOX/sz4z6fXhv6j60mB6HfYG
         AOxL1mLNK2XTAJTOoQXN6wslrZsu7V5+VizfQL6Sn7R9VTVK9ePqgikd0JLCqxuVgszS
         gm2clp9rJARgKyjZzH4fTEPdjGT5FuJ1dzDO1+1F3xgT7rCFTnapPBSghdQ5vshh5v+i
         NnTzzj05Toz99XgvRB8ZQjAqGlriBOSwB7iBaF/9ac7vDn7f0Tnm+dx1o04chQcxyFv2
         ECBn0KLO+E11zDdSoRMFSBuK1qHu6+VvyRRpP7ebEVHXvYq93+pV5iG76fkG7pl9G/yK
         QASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=awYal+sTVPCmJsCIpMH2aH7rUwDfR0RFqVvtjnSCNa4=;
        b=lv3XWumaPJTjfgqcn9ZVsekJkrhvHwDImB8Ao/uYdsprsyU5eZpzVZq94D6LNu3aJ5
         hY5/g9WgYCknlmi/vVpRbdjXi/4kDBtzE+vWuXWOok3hwf11E8fhljkxWyW0WZcCoRmE
         cuBHddgacygCC/rCUtLxXsu5r6ZnBLlwIEuPuMjmUnY5D9K6xzy6KRXpUjt3UwOgWlNY
         6793Xza36QGMwJN5MRCO4XBtTIW42f0HYdR9z1SuijiUaBkifBbBvuxmRS8LHENnTbkI
         LzVFQhfbZFP36XYa95teQZts7NsJTkuwI7YhGHVfwir/iHQDaIqXevFi69XeRjS6xHTC
         LYTg==
X-Gm-Message-State: APjAAAXn9z8fjuqMGyH2yEr+tTDt18um8KQk42hpD3a7jusgXzUvF64Y
        rmxJa7nq9irusrMZ7DXGoqUdInI25ujV6w==
X-Google-Smtp-Source: APXvYqxuNXJieCvWlUnNkB+8rCv/M6RauiNVmrj3VHjMOTYlESOCez7C57eGtya7esoorbiwQKFCAQ==
X-Received: by 2002:a2e:b4da:: with SMTP id r26mr6069ljm.153.1574091717636;
        Mon, 18 Nov 2019 07:41:57 -0800 (PST)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id u4sm8584108ljj.87.2019.11.18.07.41.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 07:41:57 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] mesh: Inform application about model subscriptions
Date:   Mon, 18 Nov 2019 16:41:47 +0100
Message-Id: <20191118154147.3589-3-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191118154147.3589-1-michal.lowas-rzechonek@silvair.com>
References: <20191118154147.3589-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 doc/mesh-api.txt | 15 +++++++++
 mesh/model.c     | 87 +++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 23a958771..30b7452e2 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -100,6 +100,14 @@ Methods:
 					A 16-bit Company ID as defined by the
 					Bluetooth SIG
 
+				array{variant} Subscriptions
+
+					Addresses the model is subscribed to.
+
+					Each address is provided either as
+					uint16 for group addresses, or
+					as array{byte} for virtual labels.
+
 		PossibleErrors:
 			org.bluez.mesh.Error.InvalidArguments
 			org.bluez.mesh.Error.NotFound,
@@ -841,6 +849,13 @@ Methods:
 			A 16-bit Bluetooth-assigned Company Identifier of the
 			vendor as defined by Bluetooth SIG
 
+		array{variant} Subscriptions
+
+			Addresses the model is subscribed to.
+
+			Each address is provided either as uint16 for group
+			addresses, or as array{byte} for virtual labels.
+
 Properties:
 	uint8 Index [read-only]
 
diff --git a/mesh/model.c b/mesh/model.c
index a0c683691..b4e2c0600 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -295,6 +295,71 @@ static void config_update_model_bindings(struct mesh_node *node,
 	l_dbus_send(dbus, msg);
 }
 
+static void append_dict_subs_array(struct l_dbus_message_builder *builder,
+						struct l_queue *subs,
+						struct l_queue *virts,
+						const char *key)
+{
+	const struct l_queue_entry *entry;
+
+	l_dbus_message_builder_enter_dict(builder, "sv");
+	l_dbus_message_builder_append_basic(builder, 's', key);
+	l_dbus_message_builder_enter_variant(builder, "av");
+	l_dbus_message_builder_enter_array(builder, "v");
+
+	if (!subs)
+		goto virts;
+
+	for (entry = l_queue_get_entries(subs); entry; entry = entry->next) {
+		uint16_t grp = L_PTR_TO_UINT(entry->data);
+
+		l_dbus_message_builder_enter_variant(builder, "q");
+		l_dbus_message_builder_append_basic(builder,'q',
+									&grp);
+		l_dbus_message_builder_leave_variant(builder);
+	}
+
+virts:
+	if (!virts)
+		goto done;
+
+	for (entry = l_queue_get_entries(virts); entry; entry = entry->next) {
+		const struct mesh_virtual *virt = entry->data;
+
+		l_dbus_message_builder_enter_variant(builder, "ay");
+		dbus_append_byte_array(builder, virt->label,
+							sizeof(virt->label));
+		l_dbus_message_builder_leave_variant(builder);
+
+	}
+
+done:
+	l_dbus_message_builder_leave_array(builder);
+	l_dbus_message_builder_leave_variant(builder);
+	l_dbus_message_builder_leave_dict(builder);
+}
+
+static void config_update_model_subscriptions(struct mesh_node *node,
+							struct mesh_model *mod)
+{
+	struct l_dbus *dbus = dbus_get_bus();
+	struct l_dbus_message *msg;
+	struct l_dbus_message_builder *builder;
+
+	msg = create_config_update_msg(node, mod->ele_idx, mod->id,
+								&builder);
+	if (!msg)
+		return;
+
+	append_dict_subs_array(builder, mod->subs, mod->virtuals,
+							"Subscriptions");
+
+	l_dbus_message_builder_leave_array(builder);
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+	l_dbus_send(dbus, msg);
+}
+
 static void forward_model(void *a, void *b)
 {
 	struct mesh_model *mod = a;
@@ -1381,6 +1446,10 @@ int mesh_model_sub_add(struct mesh_node *node, uint16_t addr, uint32_t id,
 	if (!mod)
 		return status;
 
+	if (!mod->cbs)
+		/* External models */
+		config_update_model_subscriptions(node, mod);
+
 	return add_sub(node_get_net(node), mod, group, b_virt, dst);
 }
 
@@ -1417,7 +1486,7 @@ int mesh_model_sub_ovr(struct mesh_node *node, uint16_t addr, uint32_t id,
 		}
 	}
 
-	status = mesh_model_sub_add(node, addr, id, group, b_virt, dst);
+	status = add_sub(node_get_net(node), mod, group, b_virt, dst);
 
 	if (status != MESH_STATUS_SUCCESS) {
 		/* Adding new group failed, so revert to old lists */
@@ -1440,6 +1509,10 @@ int mesh_model_sub_ovr(struct mesh_node *node, uint16_t addr, uint32_t id,
 		l_queue_destroy(virtuals, unref_virt);
 	}
 
+	if (!mod->cbs)
+		/* External models */
+		config_update_model_subscriptions(node, mod);
+
 	return status;
 }
 
@@ -1475,6 +1548,10 @@ int mesh_model_sub_del(struct mesh_node *node, uint16_t addr, uint32_t id,
 	if (l_queue_remove(mod->subs, L_UINT_TO_PTR(grp)))
 		mesh_net_dst_unreg(node_get_net(node), grp);
 
+	if (!mod->cbs)
+		/* External models */
+		config_update_model_subscriptions(node, mod);
+
 	return MESH_STATUS_SUCCESS;
 }
 
@@ -1497,6 +1574,10 @@ int mesh_model_sub_del_all(struct mesh_node *node, uint16_t addr, uint32_t id)
 	l_queue_clear(mod->subs, NULL);
 	l_queue_clear(mod->virtuals, unref_virt);
 
+	if (!mod->cbs)
+		/* External models */
+		config_update_model_subscriptions(node, mod);
+
 	return MESH_STATUS_SUCCESS;
 }
 
@@ -1691,6 +1772,10 @@ void model_build_config(void *model, void *msg_builder)
 								&period);
 	}
 
+	if (l_queue_length(mod->subs) || l_queue_length(mod->virtuals))
+		append_dict_subs_array(builder, mod->subs, mod->virtuals,
+							"Subscriptions");
+
 	l_dbus_message_builder_leave_array(builder);
 	l_dbus_message_builder_leave_struct(builder);
 }
-- 
2.19.1

