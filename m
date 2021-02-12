Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A8FC433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Feb 2021 21:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95B2B64E26
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Feb 2021 21:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbhBLVnw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Feb 2021 16:43:52 -0500
Received: from mga06.intel.com ([134.134.136.31]:54931 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhBLVnv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Feb 2021 16:43:51 -0500
IronPort-SDR: /uOSKMuITm+C/kAKDCYqQkvL5ZgMPgiw023EIYBvmleRitpuLaAVqghbFlBzYFKOt00r4Q3hhM
 PH5e9FMpWb5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9893"; a="243967606"
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400"; 
   d="scan'208";a="243967606"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 13:42:56 -0800
IronPort-SDR: NwLjTnredWlXWi9+NEH5rGhSgGHMEYyima0yKhQmdJ7nIuADVHAFK/kSdK84TeIwicCgI+ONLt
 jKGFIUb/MYLw==
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400"; 
   d="scan'208";a="416116354"
Received: from dmoore1-mobl2.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.209.2.150])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 13:42:56 -0800
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2 4/4] tools/mesh-cfg-client:
Date:   Fri, 12 Feb 2021 13:42:44 -0800
Message-Id: <20210212214244.74995-5-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210212214244.74995-1-inga.stotland@intel.com>
References: <20210212214244.74995-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Make sure that the values of Device UUID supplied in
CreateNetwork and AddRemoteNode methods are compliant with
RFC 4122.
Also, use a compliant value for Mesh UUID.
---
 tools/mesh-cfgclient.c | 6 +++---
 tools/mesh/mesh-db.c   | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index 28465a679..1eeed2a1a 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -731,7 +731,7 @@ static void create_net_setup(struct l_dbus_message *msg, void *user_data)
 	struct l_dbus_message_builder *builder;
 
 	/* Generate random UUID */
-	l_getrandom(app.uuid, sizeof(app.uuid));
+	l_uuid_v4(app.uuid);
 
 	builder = l_dbus_message_builder_new(msg);
 
@@ -899,7 +899,7 @@ static void cmd_import_node(int argc, char *argv[])
 
 	/* Device UUID */
 	req->data1 = l_util_from_hexstring(argv[1], &sz);
-	if (!req->data1 || sz != 16) {
+	if (!req->data1 || sz != 16 || !l_uuid_is_valid(req->data1)) {
 		l_error("Failed to generate UUID array from %s", argv[1]);
 		goto fail;
 	}
@@ -1298,7 +1298,7 @@ static void add_node_setup(struct l_dbus_message *msg, void *user_data)
 	struct l_dbus_message_builder *builder;
 
 	uuid = l_util_from_hexstring(str, &sz);
-	if (!uuid || sz != 16) {
+	if (!uuid || sz != 16 || !l_uuid_is_valid(uuid)) {
 		l_error("Failed to generate UUID array from %s", str);
 		return;
 	}
diff --git a/tools/mesh/mesh-db.c b/tools/mesh/mesh-db.c
index d86913006..46f0c6075 100644
--- a/tools/mesh/mesh-db.c
+++ b/tools/mesh/mesh-db.c
@@ -1407,7 +1407,7 @@ bool mesh_db_create(const char *fname, const uint8_t token[8],
 	if (!add_u8_8(jcfg, "token", token))
 		goto fail;
 
-	l_getrandom(uuid, 16);
+	l_uuid_v4(uuid);
 
 	if (!add_u8_16(jcfg, "uuid", uuid))
 		goto fail;
-- 
2.26.2

