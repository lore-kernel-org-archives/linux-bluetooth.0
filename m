Return-Path: <SRS0=LhHL=ZR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53292C432C3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Nov 2019 12:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1B92082F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Nov 2019 12:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="X3DzPUtN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfKYMb5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Nov 2019 07:31:57 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:37532 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfKYMb5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Nov 2019 07:31:57 -0500
Received: by mail-wr1-f49.google.com with SMTP id t1so17785868wrv.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Nov 2019 04:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=H4f2v1Y5QMjApH1PO0ujUMuMjKOZQVOHcOSbloc/w0Q=;
        b=X3DzPUtNsVdE8Ba/bfOpWqUaycObKDWihozYEzoP+EbiaAu+ouiqvBSrNIQ842HJLB
         YTzuttfSSFwMhpwc9Gz2W8XAb+PzSPHbOTo1M91Q03nHC7X1l+Nsd5E/eZ5BO3nD9mjB
         5O0djlpVEMJFSchy48G9jlLhOtGGDTPcT6uUptddxdY2anSIOzRcK3RWUkH0VnWiSPRu
         HyA57wdv/IYxBIbfEC8GSnoTfnZE9ZzCkXrlWsgZmu19jWzD5gbF2fq4/jRWyJbjvY/j
         Tvl68J28li8Xcf0/xqIuLoYtgB4cp8F+YuieHBQvMX4VmUUU2BNaqr+qAVubLokXGaZJ
         uq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H4f2v1Y5QMjApH1PO0ujUMuMjKOZQVOHcOSbloc/w0Q=;
        b=hfN9sArwdi189zcqKlayCVEm097gpHzMFVV/fS9T/rIRurL305COoUQYXZ4kG0dEAW
         vYkVHFsaspVIqm3uVPmetPT4v0DDWhdKcA84IPSvgxPL4/gTAANkx2XcCvaXP9kEnbYB
         FQFXr8udP20CL5CjMGyTzjBDOIQyfhlFFIFmOwfD0/HdxrgMo60Mv+1zTbJYKnMrn4Sq
         d1kacpdgZ6ozBWWXwK2zE6A8Tx0NgD3C81uyTgBzMmVbOilpWa/2J9hAwuaOEZ7gfaRc
         lOSeLJG8O7VRhiaPIJaTxAt0G4fQvZqLTiuxCAbXQYP0HO66h6onSO/fEwVI27NaWBN4
         0OLw==
X-Gm-Message-State: APjAAAVuZShZMsjFuTLsbFOp1Uca9T9K8c4jtjysmbOaW0fhvDMER/cx
        mUdqwRoF4f71ERhLEytKwZR8kGlPLxXK0Q==
X-Google-Smtp-Source: APXvYqx1mXBATuhS1wh7R6cd8kA8Y6b1e2jgfBpSXHAvPzBzyZcaPQPdJOLkgQR/6/YwqDgVbpWovQ==
X-Received: by 2002:adf:dfc6:: with SMTP id q6mr33135302wrn.235.1574685114380;
        Mon, 25 Nov 2019 04:31:54 -0800 (PST)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id w4sm10257553wrs.1.2019.11.25.04.31.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 04:31:53 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/3] mesh: Inform application about model subscriptions
Date:   Mon, 25 Nov 2019 13:31:42 +0100
Message-Id: <20191125123142.25599-4-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20191125123142.25599-1-michal.lowas-rzechonek@silvair.com>
References: <20191125123142.25599-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 doc/mesh-api.txt | 15 +++++++++
 mesh/model.c     | 87 +++++++++++++++++++++++++++++++++++++++++++++++-
 test/test-join   | 13 ++++++++
 test/test-mesh   | 25 ++++++++------
 4 files changed, 128 insertions(+), 12 deletions(-)

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
diff --git a/test/test-join b/test/test-join
index fb7b0d640..6dfb2e8c3 100644
--- a/test/test-join
+++ b/test/test-join
@@ -327,6 +327,19 @@ class Model():
 			print('Model publication period ', end='')
 			print(self.pub_period, end='')
 			print(' ms')
+		if 'Subscriptions' in config:
+			self.print_subscriptions(config.get('Subscriptions'))
+
+	def print_subscriptions(self, subscriptions):
+		print('Model subscriptions ', end='')
+		for sub in subscriptions:
+			if isinstance(sub, int):
+				print('%04x' % sub, end=' ')
+
+			if isinstance(sub, list):
+				label = uuid.UUID(bytes=b''.join(sub))
+				print(label, end=' ')
+		print()
 
 class OnOffServer(Model):
 	def __init__(self, model_id):
diff --git a/test/test-mesh b/test/test-mesh
index c67bb65fb..5777fcebc 100755
--- a/test/test-mesh
+++ b/test/test-mesh
@@ -128,6 +128,7 @@ import dbus.exceptions
 
 from threading import Timer
 import time
+import uuid
 
 try:
   from gi.repository import GLib
@@ -628,17 +629,19 @@ class Model():
 			print('Model publication period ', end='')
 			print(self.pub_period, end='')
 			print(' ms')
-
-	def print_bindings(self):
-		print(set_cyan('Model'), set_cyan('%03x' % self.model_id),
-						set_cyan('is bound to: '))
-
-		if len(self.bindings) == 0:
-			print(set_cyan('** None **'))
-			return
-
-		for b in self.bindings:
-			print(set_green('%03x' % b) + ' ')
+		if 'Subscriptions' in config:
+			print('Model subscriptions ', end='')
+			self.print_subscriptions(config.get('Subscriptions'))
+			print()
+
+	def print_subscriptions(self, subscriptions):
+		for sub in subscriptions:
+			if isinstance(sub, int):
+				print('%04x' % sub, end=' ')
+
+			if isinstance(sub, list):
+				label = uuid.UUID(bytes=b''.join(sub))
+				print(label, end=' ')
 
 ########################
 # On Off Server Model
-- 
2.19.1

