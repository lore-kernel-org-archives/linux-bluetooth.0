Return-Path: <SRS0=V5YL=WQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEAAC3A589
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Aug 2019 07:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D356238D1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Aug 2019 07:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="s32+ds7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbfHTH5F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Aug 2019 03:57:05 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:40791 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfHTH5E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Aug 2019 03:57:04 -0400
Received: by mail-wr1-f51.google.com with SMTP id c3so11332527wrd.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2019 00:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rUcEXM7xXOLaFstp8hbH8gO1qc9IUwpdbyKbNPOf0fs=;
        b=s32+ds7gKu8SgBqbMDwzRrei4xHP9NZuc+/rX6cW+zu37vSpZhgBnDRMulM+bnb2bf
         BXRYOISrksA3TMCYj5rNOcL9QifBLQ5RjEXK9dqqNAvgd2PKhaxoCa/tWOpV4/fgGx4U
         lc/YXDWn80qf0BqJ6gYUk0WjMi/6zmtLxu3w40MefvPo0tbjyBfFDJYhrqIY8S0/6pab
         0pJkKPALyBNKW7FJ29EP5wCMw7ywZp5zAqETk3IIWqqDWSTutJANK7kB9zHBuFsLQqtD
         jlVO8jvCJ0/GTBHjxtIFsLt5Ah+JhxrpiFpJNxmVt8kxsjedvdAvx9Ks+pN/W4Uj/22W
         d03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rUcEXM7xXOLaFstp8hbH8gO1qc9IUwpdbyKbNPOf0fs=;
        b=nCoSIVqdalpkH0HpdmLurNUPTckruxiS6+x/NfIS1EhGIYxuJu7E6KgrWGG+g90+TD
         rslZz3Va/eqUBoJRNxhaPSnN24ianoWwmrnyDW1aloKdruwW93uAZP90nYcPjuHlz7OE
         afkH4xrWd5fZG5PZ70czIjxqgcSF4xn8smOphChYy87kRpreyAe+ySHSfNS7hOmOw2Xo
         XsP0/AvXD4UGfxcH9zOQ+zGqULNv2dDD0Ks0vr6oxiP7RcqzH94qjtO7AoyofJ6bgH6N
         egSaFVNh7cnrjSeLplRqH0hSL21VZJw1X0kbTnZ4t0rKz6S4ptP850jlnGHENBBThr5N
         jyRw==
X-Gm-Message-State: APjAAAX3M6fgjZZVyYx8xEtOtmDzpnZwiG2YXnFVSNcvMENXvA8l7n3g
        oJigaC24ten0VBVJjbhaY0kF031Shps=
X-Google-Smtp-Source: APXvYqwptALvoHy04nM+g9WT/o2EZdiBLVFfF+jix0yVxf/EhNHIbhFiJ6CPBOUiIrA2hprD05h0xA==
X-Received: by 2002:adf:f507:: with SMTP id q7mr32381726wro.210.1566287821358;
        Tue, 20 Aug 2019 00:57:01 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id 39sm57584691wrc.45.2019.08.20.00.56.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 00:57:00 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Log D-Bus method call errors
Date:   Tue, 20 Aug 2019 09:56:54 +0200
Message-Id: <20190820075654.2195-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If a system is misconfigured, mesh daemon might not have permissions to
call application methods.

This patch causes mesh daemon to log such errors, instead of failing
silently.
---
 mesh/dbus.c    | 19 +++++++++++++++++++
 mesh/dbus.h    |  1 +
 mesh/manager.c | 18 ++++++++++--------
 mesh/mesh.c    |  4 ++--
 mesh/model.c   |  8 ++++----
 5 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/mesh/dbus.c b/mesh/dbus.c
index 6b9694ab7..453f11a68 100644
--- a/mesh/dbus.c
+++ b/mesh/dbus.c
@@ -143,3 +143,22 @@ void dbus_append_dict_entry_basic(struct l_dbus_message_builder *builder,
 	l_dbus_message_builder_leave_variant(builder);
 	l_dbus_message_builder_leave_dict(builder);
 }
+
+void dbus_call_reply(struct l_dbus_message *reply, void *user_data)
+{
+	struct l_dbus_message *msg = user_data;
+
+	if (l_dbus_message_is_error(reply)) {
+		const char *name = NULL;
+		const char *desc = NULL;
+
+		l_dbus_message_get_error(reply, &name, &desc);
+
+		l_error("Failed to call %s.%s on (%s)%s: %s %s",
+					l_dbus_message_get_interface(msg),
+					l_dbus_message_get_member(msg),
+					l_dbus_message_get_destination(msg),
+					l_dbus_message_get_path(msg),
+					name, desc);
+	}
+}
diff --git a/mesh/dbus.h b/mesh/dbus.h
index e7643a59d..fecc800a9 100644
--- a/mesh/dbus.h
+++ b/mesh/dbus.h
@@ -31,3 +31,4 @@ bool dbus_match_interface(struct l_dbus_message_iter *interfaces,
 							const char *match);
 struct l_dbus_message *dbus_error(struct l_dbus_message *msg, int err,
 						const char *description);
+void dbus_call_reply(struct l_dbus_message *reply, void *user_data);
diff --git a/mesh/manager.c b/mesh/manager.c
index cf4782c45..2a2e06780 100644
--- a/mesh/manager.c
+++ b/mesh/manager.c
@@ -114,7 +114,7 @@ static void send_add_failed(const char *owner, const char *path,
 						mesh_prov_status_str(status));
 	l_dbus_message_builder_finalize(builder);
 	l_dbus_message_builder_destroy(builder);
-	l_dbus_send(dbus, msg);
+	l_dbus_send_with_reply(dbus, msg, dbus_call_reply, msg, NULL);
 
 	free_pending_add_call();
 }
@@ -159,7 +159,7 @@ static bool add_cmplt(void *user_data, uint8_t status,
 	l_dbus_message_builder_finalize(builder);
 	l_dbus_message_builder_destroy(builder);
 
-	l_dbus_send(dbus, msg);
+	l_dbus_send_with_reply(dbus, msg, dbus_call_reply, msg, NULL);
 
 	free_pending_add_call();
 
@@ -175,8 +175,10 @@ static void mgr_prov_data (struct l_dbus_message *reply, void *user_data)
 	if (pending != add_pending)
 		return;
 
-	if (l_dbus_message_is_error(reply))
+	if (l_dbus_message_is_error(reply)) {
+		dbus_call_reply(reply, pending->msg);
 		return;
+	}
 
 	if (!l_dbus_message_get_arguments(reply, "qq", &net_idx, &primary))
 		return;
@@ -189,7 +191,6 @@ static void mgr_prov_data (struct l_dbus_message *reply, void *user_data)
 static bool add_data_get(void *user_data, uint8_t num_ele)
 {
 	struct add_data *pending = user_data;
-	struct l_dbus_message *msg;
 	struct l_dbus *dbus;
 	const char *app_path;
 	const char *sender;
@@ -201,12 +202,13 @@ static bool add_data_get(void *user_data, uint8_t num_ele)
 	app_path = node_get_app_path(add_pending->node);
 	sender = node_get_owner(add_pending->node);
 
-	msg = l_dbus_message_new_method_call(dbus, sender, app_path,
+	pending->msg = l_dbus_message_new_method_call(dbus, sender, app_path,
 						MESH_PROVISIONER_INTERFACE,
 						"RequestProvData");
 
-	l_dbus_message_set_arguments(msg, "y", num_ele);
-	l_dbus_send_with_reply(dbus, msg, mgr_prov_data, add_pending, NULL);
+	l_dbus_message_set_arguments(pending->msg, "y", num_ele);
+	l_dbus_send_with_reply(dbus, pending->msg, mgr_prov_data, add_pending,
+									NULL);
 
 	add_pending->num_ele = num_ele;
 
@@ -362,7 +364,7 @@ static void prov_beacon_recv(void *user_data, struct mesh_io_recv_info *info,
 	l_dbus_message_builder_finalize(builder);
 	l_dbus_message_builder_destroy(builder);
 
-	l_dbus_send(dbus, msg);
+	l_dbus_send_with_reply(dbus, msg, dbus_call_reply, msg, NULL);
 }
 
 static struct l_dbus_message *start_scan_call(struct l_dbus *dbus,
diff --git a/mesh/mesh.c b/mesh/mesh.c
index b660a7ef2..9bd644cab 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -303,7 +303,7 @@ static void send_join_failed(const char *owner, const char *path,
 						"JoinFailed");
 
 	l_dbus_message_set_arguments(msg, "s", mesh_prov_status_str(status));
-	l_dbus_send(dbus_get_bus(), msg);
+	l_dbus_send_with_reply(dbus_get_bus(), msg, dbus_call_reply, msg, NULL);
 
 	free_pending_join_call(true);
 }
@@ -343,7 +343,7 @@ static bool prov_complete_cb(void *user_data, uint8_t status,
 
 	l_dbus_message_set_arguments(msg, "t", l_get_be64(token));
 
-	l_dbus_send(dbus, msg);
+	l_dbus_send_with_reply(dbus, msg, dbus_call_reply, msg, NULL);
 
 	free_pending_join_call(false);
 
diff --git a/mesh/model.c b/mesh/model.c
index 8f3d67ecf..328a0756d 100644
--- a/mesh/model.c
+++ b/mesh/model.c
@@ -251,7 +251,7 @@ static void config_update_model_pub_period(struct mesh_node *node,
 	l_dbus_message_builder_leave_array(builder);
 	l_dbus_message_builder_finalize(builder);
 	l_dbus_message_builder_destroy(builder);
-	l_dbus_send(dbus, msg);
+	l_dbus_send_with_reply(dbus, msg, dbus_call_reply, msg, NULL);
 }
 
 static void append_dict_uint16_array(struct l_dbus_message_builder *builder,
@@ -292,7 +292,7 @@ static void config_update_model_bindings(struct mesh_node *node,
 	l_dbus_message_builder_leave_array(builder);
 	l_dbus_message_builder_finalize(builder);
 	l_dbus_message_builder_destroy(builder);
-	l_dbus_send(dbus, msg);
+	l_dbus_send_with_reply(dbus, msg, dbus_call_reply, msg, NULL);
 }
 
 static void forward_model(void *a, void *b)
@@ -764,7 +764,7 @@ static void send_dev_key_msg_rcvd(struct mesh_node *node, uint8_t ele_idx,
 	l_dbus_message_builder_finalize(builder);
 	l_dbus_message_builder_destroy(builder);
 
-	l_dbus_send(dbus, msg);
+	l_dbus_send_with_reply(dbus, msg, dbus_call_reply, msg, NULL);
 }
 
 static void send_msg_rcvd(struct mesh_node *node, uint8_t ele_idx, bool is_sub,
@@ -797,7 +797,7 @@ static void send_msg_rcvd(struct mesh_node *node, uint8_t ele_idx, bool is_sub,
 
 	l_dbus_message_builder_finalize(builder);
 	l_dbus_message_builder_destroy(builder);
-	l_dbus_send(dbus, msg);
+	l_dbus_send_with_reply(dbus, msg, dbus_call_reply, msg, NULL);
 }
 
 bool mesh_model_rx(struct mesh_node *node, bool szmict, uint32_t seq0,
-- 
2.19.1

