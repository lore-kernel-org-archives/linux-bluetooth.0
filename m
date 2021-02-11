Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C08C433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Feb 2021 22:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9CD664E38
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Feb 2021 22:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhBKWXR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Feb 2021 17:23:17 -0500
Received: from mga07.intel.com ([134.134.136.100]:1741 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230108AbhBKWWm (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Feb 2021 17:22:42 -0500
IronPort-SDR: W3RNKm8+QM8tGHP5iX5POGbBaBwjox0xOJ2ZqtnH/gBU7gAhBPq72kCLZKwClnCP1Br0Ae3j2X
 D/RuZ5wxn/yQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="246392971"
X-IronPort-AV: E=Sophos;i="5.81,171,1610438400"; 
   d="scan'208";a="246392971"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 14:21:57 -0800
IronPort-SDR: KIm47ofDlTCCjMV8d3fAQWMQaUnHRzdkhPsxsfFwuQhvadnFciNUnh+gqkkOwf285xzcoGH0hV
 uFD9olfwkpXw==
X-IronPort-AV: E=Sophos;i="5.81,171,1610438400"; 
   d="scan'208";a="381070051"
Received: from binman-mobl4.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.251.152.23])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 14:21:57 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 2/4] mesh: Add validation of Device UUID value
Date:   Thu, 11 Feb 2021 14:21:41 -0800
Message-Id: <20210211222143.39986-3-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210211222143.39986-1-inga.stotland@intel.com>
References: <20210211222143.39986-1-inga.stotland@intel.com>
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

