Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3237AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Feb 2022 14:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbiBCOjY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Feb 2022 09:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbiBCOjX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Feb 2022 09:39:23 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E46BC061714
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Feb 2022 06:39:22 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id o12so6337705lfg.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Feb 2022 06:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xKcm422GVZ36PMQK4Jexo+ClnOR5QzLy9+qhPg+Ncl4=;
        b=a2aKx/+6r8crYKqPyu7yO7FfUcNKTWp/czZQgGyADBuozIfXSpjfvQZpvK3xBbhHV6
         qe364N7mYOr1tl5tv4szp8uTeqbK1onOAGa3ZLdG44yWgN56KxV0Hda+nFVVXUYzg2vJ
         j1cOlRLe1fWmB1sm7YMULrIBPfHF1J1cKz2MRR/HZcY1LM0e0Gg1/aCewsyH5sI95/WZ
         ip2X4YrvlNi9jrX8FeZkARadTsbOmIySk2c4qWi7Q2ij4owBBAiNQpbTgJjKtzHjCn9X
         OMJw5AeVcaWuJ0k8uMRIAKPho14mhGXHFuAOFIt+0Mxo29K2bdg+Y9d+jkim1PQK763d
         wxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xKcm422GVZ36PMQK4Jexo+ClnOR5QzLy9+qhPg+Ncl4=;
        b=Qw9yVbkF+ph+WeVHDk1Fdp5xDR4s5xOzLKULZEqfZIndJhkKT7lBmmpRsDJsB9T2+e
         byBfEUdsT4n1BJfLcFePl9DQQ7Pb3y/Slc4bXazXRyb4eQv3ucg63i1kl/plB4aiMj11
         5Fod5Uz9quwXnI5MSX0nRZwNagO9wkS9hbOJrB7FA+0x4vhgpioKDAPVguXOqDxracT9
         52FIZFu+ARPrIpKYBmNZKi3OvOxa/89oT1583tTW7CUkhRmdP9ZCgSR2DsDZAXiQTE4B
         vF14+APAhKJKEblKDWPLLV6mVsBg3gu3F0plwLuOM8boxPQLeJFYpa3Mz7DsZpVmeDJe
         1bnw==
X-Gm-Message-State: AOAM532dH6lKJVL/7u2wsFwbr3ovCGDN2HSdo3ozFaM3QTEEYUhBoONn
        NEzWGakACcneSA5XLvP7V2eXKn8+BRKYTR+O
X-Google-Smtp-Source: ABdhPJxBH1N4clbmNl1vAOocsaGJPVKK/CyvsPVvRAXigXqGqSPPVsuC15eDcsvvx8eZdwfnjONftA==
X-Received: by 2002:a05:6512:2347:: with SMTP id p7mr26886478lfu.123.1643899160691;
        Thu, 03 Feb 2022 06:39:20 -0800 (PST)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id x9sm4521271lfn.282.2022.02.03.06.39.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 06:39:20 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Remove unused io caps
Date:   Thu,  3 Feb 2022 15:39:14 +0100
Message-Id: <20220203143914.746965-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/mesh-io-api.h     |  2 --
 mesh/mesh-io-generic.c | 14 --------------
 mesh/mesh-io-unit.c    | 14 --------------
 mesh/mesh-io.c         | 10 ----------
 mesh/mesh-io.h         |  7 -------
 mesh/mesh.c            |  4 ----
 6 files changed, 51 deletions(-)

diff --git a/mesh/mesh-io-api.h b/mesh/mesh-io-api.h
index 7a50937da..a20d470fc 100644
--- a/mesh/mesh-io-api.h
+++ b/mesh/mesh-io-api.h
@@ -14,7 +14,6 @@ typedef bool (*mesh_io_init_t)(struct mesh_io *io, void *opts,
 				struct l_dbus *dbus, mesh_io_ready_func_t cb,
 				void *user_data);
 typedef bool (*mesh_io_destroy_t)(struct mesh_io *io);
-typedef bool (*mesh_io_caps_t)(struct mesh_io *io, struct mesh_io_caps *caps);
 typedef bool (*mesh_io_send_t)(struct mesh_io *io,
 					struct mesh_io_send_info *info,
 					const uint8_t *data, uint16_t len);
@@ -29,7 +28,6 @@ typedef bool (*mesh_io_tx_cancel_t)(struct mesh_io *io, const uint8_t *pattern,
 struct mesh_io_api {
 	mesh_io_init_t		init;
 	mesh_io_destroy_t	destroy;
-	mesh_io_caps_t		caps;
 	mesh_io_send_t		send;
 	mesh_io_register_t	reg;
 	mesh_io_deregister_t	dereg;
diff --git a/mesh/mesh-io-generic.c b/mesh/mesh-io-generic.c
index 27cb4cf5f..a9d7f8ae5 100644
--- a/mesh/mesh-io-generic.c
+++ b/mesh/mesh-io-generic.c
@@ -473,19 +473,6 @@ static bool dev_destroy(struct mesh_io *io)
 	return true;
 }
 
-static bool dev_caps(struct mesh_io *io, struct mesh_io_caps *caps)
-{
-	struct mesh_io_private *pvt = io->pvt;
-
-	if (!pvt || !caps)
-		return false;
-
-	caps->max_num_filters = 255;
-	caps->window_accuracy = 50;
-
-	return true;
-}
-
 static void send_cancel_done(const void *buf, uint8_t size,
 							void *user_data)
 {
@@ -893,7 +880,6 @@ static bool recv_deregister(struct mesh_io *io, const uint8_t *filter,
 const struct mesh_io_api mesh_io_generic = {
 	.init = dev_init,
 	.destroy = dev_destroy,
-	.caps = dev_caps,
 	.send = send_tx,
 	.reg = recv_register,
 	.dereg = recv_deregister,
diff --git a/mesh/mesh-io-unit.c b/mesh/mesh-io-unit.c
index a3cba747e..4e754c77e 100644
--- a/mesh/mesh-io-unit.c
+++ b/mesh/mesh-io-unit.c
@@ -284,19 +284,6 @@ static bool unit_destroy(struct mesh_io *io)
 	return true;
 }
 
-static bool unit_caps(struct mesh_io *io, struct mesh_io_caps *caps)
-{
-	struct mesh_io_private *pvt = io->pvt;
-
-	if (!pvt || !caps)
-		return false;
-
-	caps->max_num_filters = 255;
-	caps->window_accuracy = 50;
-
-	return true;
-}
-
 static bool simple_match(const void *a, const void *b)
 {
 	return a == b;
@@ -527,7 +514,6 @@ static bool recv_deregister(struct mesh_io *io, const uint8_t *filter,
 const struct mesh_io_api mesh_io_unit = {
 	.init = unit_init,
 	.destroy = unit_destroy,
-	.caps = unit_caps,
 	.send = send_tx,
 	.reg = recv_register,
 	.dereg = recv_deregister,
diff --git a/mesh/mesh-io.c b/mesh/mesh-io.c
index dfd9e43d9..8c860f28f 100644
--- a/mesh/mesh-io.c
+++ b/mesh/mesh-io.c
@@ -102,16 +102,6 @@ void mesh_io_destroy(struct mesh_io *io)
 	}
 }
 
-bool mesh_io_get_caps(struct mesh_io *io, struct mesh_io_caps *caps)
-{
-	io = l_queue_find(io_list, match_by_io, io);
-
-	if (io && io->api && io->api->caps)
-		return io->api->caps(io, caps);
-
-	return false;
-}
-
 bool mesh_io_register_recv_cb(struct mesh_io *io, const uint8_t *filter,
 				uint8_t len, mesh_io_recv_func_t cb,
 				void *user_data)
diff --git a/mesh/mesh-io.h b/mesh/mesh-io.h
index 8a4b2e8ee..43215b7b0 100644
--- a/mesh/mesh-io.h
+++ b/mesh/mesh-io.h
@@ -57,11 +57,6 @@ struct mesh_io_send_info {
 	} u;
 };
 
-struct mesh_io_caps {
-	uint8_t max_num_filters;
-	uint8_t window_accuracy;
-};
-
 typedef void (*mesh_io_recv_func_t)(void *user_data,
 					struct mesh_io_recv_info *info,
 					const uint8_t *data, uint16_t len);
@@ -78,8 +73,6 @@ struct mesh_io *mesh_io_new(enum mesh_io_type type, void *opts,
 				void *user_data);
 void mesh_io_destroy(struct mesh_io *io);
 
-bool mesh_io_get_caps(struct mesh_io *io, struct mesh_io_caps *caps);
-
 bool mesh_io_register_recv_cb(struct mesh_io *io, const uint8_t *filter,
 					uint8_t len, mesh_io_recv_func_t cb,
 					void *user_data);
diff --git a/mesh/mesh.c b/mesh/mesh.c
index 1d3451cf4..4c6fa94a9 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -57,7 +57,6 @@ struct bt_mesh {
 	uint16_t algorithms;
 	uint16_t req_index;
 	uint8_t friend_queue_sz;
-	uint8_t max_filters;
 	bool initialized;
 };
 
@@ -254,7 +253,6 @@ bool mesh_init(struct l_dbus *dbus, const char *config_dir,
 		const char *mesh_conf_fname, enum mesh_io_type type, void *opts,
 		mesh_ready_func_t cb, void *user_data)
 {
-	struct mesh_io_caps caps;
 	struct mesh_init_request *req;
 
 	if (mesh.io)
@@ -291,8 +289,6 @@ bool mesh_init(struct l_dbus *dbus, const char *config_dir,
 	}
 
 	l_debug("io %p", mesh.io);
-	mesh_io_get_caps(mesh.io, &caps);
-	mesh.max_filters = caps.max_num_filters;
 
 	pending_queue = l_queue_new();
 
-- 
2.25.1

