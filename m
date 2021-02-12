Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D99C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Feb 2021 21:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AA2E64E36
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Feb 2021 21:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhBLVni (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Feb 2021 16:43:38 -0500
Received: from mga06.intel.com ([134.134.136.31]:54934 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhBLVnh (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Feb 2021 16:43:37 -0500
IronPort-SDR: i+lfiDj45kL81G/e4m8HvMaKRwFwx3B0gqWitSF8o9AnVOqiQqW7eM1kfqH4p9OzbPXBdQT8qV
 tQb9+tD/foyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9893"; a="243967600"
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400"; 
   d="scan'208";a="243967600"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 13:42:54 -0800
IronPort-SDR: LA9pWhiVXV/LplR36mcgrrd02EAxua3hrBJXzISF8mrAQRZHyTESTKT+MXvuLTgN00xVZEtRhC
 9U+y+XZqy9Cw==
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400"; 
   d="scan'208";a="416116345"
Received: from dmoore1-mobl2.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.209.2.150])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 13:42:54 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2 2/4] mesh: Add validation of Device UUID value
Date:   Fri, 12 Feb 2021 13:42:42 -0800
Message-Id: <20210212214244.74995-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210212214244.74995-1-inga.stotland@intel.com>
References: <20210212214244.74995-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Validate that the value of Device UUID supplied in
CreateNetwork/Join/Import methods is compliant with RFC 4122.
---
 Makefile.am |  6 ++++--
 mesh/mesh.c | 18 +++++++++---------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index d0f979586..86f3409c3 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -134,7 +134,8 @@ ell_headers = ell/util.h \
 			ell/base64.h \
 			ell/asn1-private.h \
 			ell/cert-private.h \
-			ell/pem-private.h
+			ell/pem-private.h \
+			ell/uuid.h
 
 ell_sources = ell/private.h ell/missing.h \
 			ell/util.c \
@@ -169,7 +170,8 @@ ell_sources = ell/private.h ell/missing.h \
 			ell/gvariant-private.h \
 			ell/gvariant-util.c \
 			ell/siphash-private.h \
-			ell/siphash.c
+			ell/siphash.c \
+			ell/uuid.c
 
 ell_libell_internal_la_SOURCES = $(ell_headers) $(ell_sources)
 endif
diff --git a/mesh/mesh.c b/mesh/mesh.c
index f29e8b6be..62d650328 100644
--- a/mesh/mesh.c
+++ b/mesh/mesh.c
@@ -533,7 +533,7 @@ static struct l_dbus_message *join_network_call(struct l_dbus *dbus,
 						void *user_data)
 {
 	const char *app_path, *sender;
-	struct l_dbus_message_iter iter_uuid;
+	struct l_dbus_message_iter iter;
 	uint32_t n;
 
 	l_debug("Join network request");
@@ -543,14 +543,13 @@ static struct l_dbus_message *join_network_call(struct l_dbus *dbus,
 						"Provisioning in progress");
 
 	if (!l_dbus_message_get_arguments(msg, "oay", &app_path,
-								&iter_uuid))
+								&iter))
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
 
 	join_pending = l_new(struct join_data, 1);
 
-	if (!l_dbus_message_iter_get_fixed_array(&iter_uuid,
-						&join_pending->uuid, &n)
-								|| n != 16) {
+	if (!l_dbus_message_iter_get_fixed_array(&iter, &join_pending->uuid, &n)
+			|| n != 16 || !l_uuid_is_valid(join_pending->uuid)) {
 		l_free(join_pending);
 		join_pending = NULL;
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
@@ -785,8 +784,8 @@ static struct l_dbus_message *create_network_call(struct l_dbus *dbus,
 								&iter_uuid))
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
 
-	if (!l_dbus_message_iter_get_fixed_array(&iter_uuid, &uuid, &n)
-								|| n != 16)
+	if (!l_dbus_message_iter_get_fixed_array(&iter_uuid, &uuid, &n) ||
+					n != 16 || !l_uuid_is_valid(uuid))
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
 							"Bad device UUID");
 
@@ -835,8 +834,9 @@ static struct l_dbus_message *import_call(struct l_dbus *dbus,
 		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, NULL);
 
 	if (!l_dbus_message_iter_get_fixed_array(&iter_uuid, &uuid, &n) ||
-									n != 16)
-		return dbus_error(msg, MESH_ERROR_INVALID_ARGS, "Bad dev UUID");
+					n != 16 || !l_uuid_is_valid(uuid))
+		return dbus_error(msg, MESH_ERROR_INVALID_ARGS,
+							"Bad device UUID");
 
 	if (node_find_by_uuid(uuid))
 		return dbus_error(msg, MESH_ERROR_ALREADY_EXISTS,
-- 
2.26.2

