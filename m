Return-Path: <SRS0=BnFh=AL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EF2C433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jun 2020 18:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C64CC2067D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Jun 2020 18:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgF3S4W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:56:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:57136 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgF3S4V (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Jun 2020 14:56:21 -0400
IronPort-SDR: pWWsIlSY9yYBQ9umrtm7QeRcT3/LwP88zlya5ei2kS7IvR4LMRCTHRJsg9XNQs8utGtw9hJwZ/
 Rm0A3l/dhXwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="231222957"
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="231222957"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2020 11:56:21 -0700
IronPort-SDR: H3VwgdpiP90NDUQW/Kkf8UERXuz4MoYIGKnnK2zDB8kdRRpqZ66IvLVraAWKwwCDpQ3A/wUAox
 DGK1UK+OJ4RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,298,1589266800"; 
   d="scan'208";a="355864259"
Received: from mlindstr-mobl1.amr.corp.intel.com (HELO ingas-nuc1.sea.intel.com) ([10.254.108.27])
  by orsmga001.jf.intel.com with ESMTP; 30 Jun 2020 11:56:21 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, michal.lowas-rzechonek@silvair.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ v2 3/4] tools/mesh-cfgclient: Add options to "Models" property
Date:   Tue, 30 Jun 2020 11:56:16 -0700
Message-Id: <20200630185617.14755-4-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200630185617.14755-1-inga.stotland@intel.com>
References: <20200630185617.14755-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds options dictionary to "Models" property to stay
in sync with mesh-api changes.
---
 tools/mesh-cfgclient.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index 0dd02fad8..59f079213 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -1448,14 +1448,26 @@ static void proxy_removed(struct l_dbus_proxy *proxy, void *user_data)
 	}
 }
 
+static void build_model(struct l_dbus_message_builder *builder, uint16_t mod_id,
+					bool pub_enable, bool sub_enable)
+{
+	l_dbus_message_builder_enter_struct(builder, "qa{sv}");
+	l_dbus_message_builder_append_basic(builder, 'q', &mod_id);
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+	append_dict_entry_basic(builder, "Subscribe", "b", &sub_enable);
+	append_dict_entry_basic(builder, "Publish", "b", &pub_enable);
+	l_dbus_message_builder_leave_array(builder);
+	l_dbus_message_builder_leave_struct(builder);
+}
+
 static bool mod_getter(struct l_dbus *dbus,
 				struct l_dbus_message *message,
 				struct l_dbus_message_builder *builder,
 				void *user_data)
 {
-	l_dbus_message_builder_enter_array(builder, "q");
-	l_dbus_message_builder_append_basic(builder, 'q', &app.ele.mods[0]);
-	l_dbus_message_builder_append_basic(builder, 'q', &app.ele.mods[1]);
+	l_dbus_message_builder_enter_array(builder, "(qa{sv})");
+	build_model(builder, app.ele.mods[0], false, false);
+	build_model(builder, app.ele.mods[1], false, false);
 	l_dbus_message_builder_leave_array(builder);
 
 	return true;
@@ -1466,7 +1478,7 @@ static bool vmod_getter(struct l_dbus *dbus,
 				struct l_dbus_message_builder *builder,
 				void *user_data)
 {
-	l_dbus_message_builder_enter_array(builder, "(qq)");
+	l_dbus_message_builder_enter_array(builder, "(qqa{sv})");
 	l_dbus_message_builder_leave_array(builder);
 
 	return true;
@@ -1517,9 +1529,10 @@ static void setup_ele_iface(struct l_dbus_interface *iface)
 	/* Properties */
 	l_dbus_interface_property(iface, "Index", 0, "y", ele_idx_getter,
 									NULL);
-	l_dbus_interface_property(iface, "VendorModels", 0, "a(qq)",
+	l_dbus_interface_property(iface, "VendorModels", 0, "a(qqa{sv})",
 							vmod_getter, NULL);
-	l_dbus_interface_property(iface, "Models", 0, "aq", mod_getter, NULL);
+	l_dbus_interface_property(iface, "Models", 0, "a(qa{sv})", mod_getter,
+									NULL);
 
 	/* Methods */
 	l_dbus_interface_method(iface, "DevKeyMessageReceived", 0,
-- 
2.26.2

