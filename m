Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1624FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Feb 2022 14:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347868AbiBCOMm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Feb 2022 09:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbiBCOMl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Feb 2022 09:12:41 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2F0C061714
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Feb 2022 06:12:41 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id i34so6320997lfv.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Feb 2022 06:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8OS2EXR2NmhkheT52GoPI7ffyRVjkCqLd4pzhN/lE8A=;
        b=ZTYJzXpG01tP3KqRecd4jmASRX+u/mOuveEaGvkMavNKb9DEuI/SX4Wceoi8v5GIvY
         JQN3CMLRNXJbddy3CRR7yIKvCrhchtLAMQ0uOw9vs+aJKuB9q72zJwMT6cB9cdwvvbIq
         +jMU8nBapfoCefjOuSEnzng+bTmKEPZWVtqYOx9ldt0dlhBoRQLvuxtRL4mZ6+BkRMl1
         dTSmbtDQe4IP1PhIBBza8UkPTd2V/l11F1CTgHTPXRZj5YZyGonE/Gcu0vC4K1sc7EEi
         +0MU04EdMhOR7qSJa6mF0zAUABLszNhjypLx/lngSV3Wpe054VBa9Da2Iop3IBHiXbC/
         Ujqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8OS2EXR2NmhkheT52GoPI7ffyRVjkCqLd4pzhN/lE8A=;
        b=OS2e829EbUtm2cwoEjp40Z3+TtjUM0yN5Cyeen91zzBEvkbFfrUT09Ry7foNT2ElQ6
         TR9ghj7X83UrTAjW+NBZoFj5BqMx59MJfh77dPwIuLl13cBCaH03NM6Gb27dFs9Y4Zle
         ns95hesjQWrgQusO8V7a736OEJf5z3mTGVXJeIifpxXcH0rzYmIVXJpSDojicRcgIX5V
         3vxQLULek7g7PvY9ltV5hTuyrSiAbUo/sUoboJ32/G0HTlbot90MXLzFha0ubL2Ne2Mh
         tcaztevfpfSpUiDQ8RdL3D16h+o4wmUKs3k+jjsa/QUG2t2mMgufzDPfa9ZorEg1doAY
         w/gw==
X-Gm-Message-State: AOAM530A65TwrZ6Ur0aj5M7yTc45A2PVC26a8LD86wLgrHvHQDBdq1WI
        apux3cwQV/BIl5ZlLCr0Ch6Z/AZSNREQJ7gS
X-Google-Smtp-Source: ABdhPJxCpH06+xDXUJuXzRNcbPCHOZ9LXwYBoL8qR0A4Kp6wX5AnTGJDrxEPjtCTi3szjflmT1YsZw==
X-Received: by 2002:a05:6512:10d6:: with SMTP id k22mr27818434lfg.243.1643897559620;
        Thu, 03 Feb 2022 06:12:39 -0800 (PST)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id q5sm5091612lfg.77.2022.02.03.06.12.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 06:12:39 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Allow mesh-io to use dbus when initializing
Date:   Thu,  3 Feb 2022 15:12:34 +0100
Message-Id: <20220203141234.710019-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some io implementations might want to either make calls to other D-Bus
services, or provide additional objects/interfaces that allow
applications to fine-tune their operation.
---
 mesh/main.c            |  9 ++++-----
 mesh/mesh-io-api.h     |  3 ++-
 mesh/mesh-io-generic.c |  4 +++-
 mesh/mesh-io-unit.c    |  2 +-
 mesh/mesh-io.c         |  5 +++--
 mesh/mesh-io.h         |  3 ++-
 mesh/mesh.c            | 12 +++++++-----
 mesh/mesh.h            |  9 +++++----
 8 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/mesh/main.c b/mesh/main.c
index dd99c3085..74b0f884e 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -76,10 +76,9 @@ static void do_debug(const char *str, void *user_data)
 	l_info("%s%s", prefix, str);
 }
 
-static void mesh_ready_callback(void *user_data, bool success)
+static void mesh_ready_callback(bool success, struct l_dbus *dbus,
+								void *user_data)
 {
-	struct l_dbus *dbus = user_data;
-
 	l_info("mesh_ready_callback");
 	if (!success) {
 		l_error("Failed to start mesh");
@@ -102,8 +101,8 @@ static void request_name_callback(struct l_dbus *dbus, bool success,
 		return;
 	}
 
-	if (!mesh_init(storage_dir, mesh_conf_fname, io_type, io_opts,
-					mesh_ready_callback, dbus)) {
+	if (!mesh_init(dbus, storage_dir, mesh_conf_fname, io_type, io_opts,
+					mesh_ready_callback, NULL)) {
 		l_error("Failed to initialize mesh");
 		l_main_quit();
 	}
diff --git a/mesh/mesh-io-api.h b/mesh/mesh-io-api.h
index 61f79f224..7a50937da 100644
--- a/mesh/mesh-io-api.h
+++ b/mesh/mesh-io-api.h
@@ -11,7 +11,8 @@
 struct mesh_io_private;
 
 typedef bool (*mesh_io_init_t)(struct mesh_io *io, void *opts,
-				mesh_io_ready_func_t cb, void *user_data);
+				struct l_dbus *dbus, mesh_io_ready_func_t cb,
+				void *user_data);
 typedef bool (*mesh_io_destroy_t)(struct mesh_io *io);
 typedef bool (*mesh_io_caps_t)(struct mesh_io *io, struct mesh_io_caps *caps);
 typedef bool (*mesh_io_send_t)(struct mesh_io *io,
diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index 6c0b8f0fd..27cb4cf5f 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -27,6 +27,7 @@
 #include "mesh/mesh-io.h"
 #include "mesh/mesh-io-api.h"
 #include "mesh/mesh-io-generic.h"
+#include "mesh/dbus.h"
 
 struct mesh_io_private {
 	struct bt_hci *hci;
@@ -40,6 +41,7 @@ struct mesh_io_private {
 	uint16_t interval;
 	bool sending;
 	bool active;
+	struct l_dbus *dbus;
 };
 
 struct pvt_rx_reg {
@@ -429,7 +431,7 @@ static void read_info(int index, void *user_data)
 	hci_init(io);
 }
 
-static bool dev_init(struct mesh_io *io, void *opts,
+static bool dev_init(struct mesh_io *io, void *opts, struct l_dbus *dbus,
 				mesh_io_ready_func_t cb, void *user_data)
 {
 	if (!io || io->pvt)
diff --git a/mesh/mesh-io-unit.c b/mesh/mesh-io-unit.c
index f4b615ac8..a3cba747e 100644
--- a/mesh/mesh-io-unit.c
+++ b/mesh/mesh-io-unit.c
@@ -209,7 +209,7 @@ static void unit_up(void *user_data)
 	l_timeout_create_ms(1, get_name, pvt, NULL);
 }
 
-static bool unit_init(struct mesh_io *io, void *opt,
+static bool unit_init(struct mesh_io *io, void *opt, struct l_dbus *dbus,
 				mesh_io_ready_func_t cb, void *user_data)
 {
 	struct mesh_io_private *pvt;
diff --git a/mesh/mesh-io.c b/mesh/mesh-io.c
index 96891313a..dfd9e43d9 100644
--- a/mesh/mesh-io.c
+++ b/mesh/mesh-io.c
@@ -46,7 +46,8 @@ static bool match_by_type(const void *a, const void *b)
 }
 
 struct mesh_io *mesh_io_new(enum mesh_io_type type, void *opts,
-				mesh_io_ready_func_t cb, void *user_data)
+				struct l_dbus *dbus, mesh_io_ready_func_t cb,
+				void *user_data)
 {
 	const struct mesh_io_api *api = NULL;
 	struct mesh_io *io;
@@ -69,7 +70,7 @@ struct mesh_io *mesh_io_new(enum mesh_io_type type, void *opts,
 	io->type = type;
 	io->api = api;
 
-	if (!api->init(io, opts, cb, user_data))
+	if (!api->init(io, opts, dbus, cb, user_data))
 		goto fail;
 
 	if (!io_list)
diff --git a/mesh/mesh-io.h b/mesh/mesh-io.h
index 80ef3fa3e..8a4b2e8ee 100644
--- a/mesh/mesh-io.h
+++ b/mesh/mesh-io.h
@@ -74,7 +74,8 @@ typedef void (*mesh_io_recv_ext_func_t)(void *user_data,
 typedef void (*mesh_io_ready_func_t)(void *user_data, bool result);
 
 struct mesh_io *mesh_io_new(enum mesh_io_type type, void *opts,
-				mesh_io_ready_func_t cb, void *user_data);
+				struct l_dbus *dbus, mesh_io_ready_func_t cb,
+				void *user_data);
 void mesh_io_destroy(struct mesh_io *io);
 
 bool mesh_io_get_caps(struct mesh_io *io, struct mesh_io_caps *caps);
diff --git a/mesh/mesh.c b/mesh/mesh.c
index 62d650328..1d3451cf4 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -71,6 +71,7 @@ struct join_data{
 
 struct mesh_init_request {
 	mesh_ready_func_t cb;
+	struct l_dbus *dbus;
 	void *user_data;
 };
 
@@ -173,7 +174,7 @@ static void io_ready_callback(void *user_data, bool result)
 	if (result)
 		node_attach_io_all(mesh.io);
 
-	req->cb(req->user_data, result);
+	req->cb(result, req->dbus, req->user_data);
 
 	l_free(req);
 }
@@ -249,9 +250,9 @@ done:
 	l_settings_free(settings);
 }
 
-bool mesh_init(const char *config_dir, const char *mesh_conf_fname,
-					enum mesh_io_type type, void *opts,
-					mesh_ready_func_t cb, void *user_data)
+bool mesh_init(struct l_dbus *dbus, const char *config_dir,
+		const char *mesh_conf_fname, enum mesh_io_type type, void *opts,
+		mesh_ready_func_t cb, void *user_data)
 {
 	struct mesh_io_caps caps;
 	struct mesh_init_request *req;
@@ -280,9 +281,10 @@ bool mesh_init(const char *config_dir, const char *mesh_conf_fname,
 
 	req = l_new(struct mesh_init_request, 1);
 	req->cb = cb;
+	req->dbus = dbus;
 	req->user_data = user_data;
 
-	mesh.io = mesh_io_new(type, opts, io_ready_callback, req);
+	mesh.io = mesh_io_new(type, opts, dbus, io_ready_callback, req);
 	if (!mesh.io) {
 		l_free(req);
 		return false;
diff --git a/mesh/mesh.h b/mesh/mesh.h
index 0f77ebc58..6050cfa06 100644
--- a/mesh/mesh.h
+++ b/mesh/mesh.h
@@ -21,13 +21,14 @@
 
 enum mesh_io_type;
 
-typedef void (*mesh_ready_func_t)(void *user_data, bool success);
+typedef void (*mesh_ready_func_t)(bool success, struct l_dbus *dbus,
+							void *user_data);
 typedef void (*prov_rx_cb_t)(void *user_data, const uint8_t *data,
 								uint16_t len);
 
-bool mesh_init(const char *config_dir, const char *mesh_conf_fname,
-					enum mesh_io_type type, void *opts,
-					mesh_ready_func_t cb, void *user_data);
+bool mesh_init(struct l_dbus *dus, const char *config_dir,
+		const char *mesh_conf_fname, enum mesh_io_type type, void *opts,
+		mesh_ready_func_t cb, void *user_data);
 void mesh_cleanup(void);
 bool mesh_dbus_init(struct l_dbus *dbus);
 
-- 
2.25.1

