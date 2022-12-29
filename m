Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18E2C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Dec 2022 12:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbiL2MKS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Dec 2022 07:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbiL2MKQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Dec 2022 07:10:16 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE021275F
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Dec 2022 04:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672315815; x=1703851815;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7+xnrGGRez2Bev/DDbODGIaUbbK425PBBXeEUroLNCM=;
  b=RxCAuAK4vGnA296hZpZ2s+0GFtbkx6/5y2Qz/qp+27oC8oF6wvTw55JU
   EQrizdLgJeifs+oxa3CdK+Uonk6udXyDlM0qOvNh5zTMtkQpBOs6xTzV6
   pdYEuiC1zB0EgagaqzNMhbsc7BSGpxpE+5ET8s9qz706RM3lxB61AX/KS
   5tOqTPEsFDBS6i6nEiLWTJI+Pm/qeuG62ssvixgWoEdaksgpEc5bDDgwP
   5bHzXBoIbIyoYlSJGMZHkNCK07UbZk+b5nKN+S/6lneZN+fHNJI4f57BX
   cThh4S3BrxCaKNZryvVTHbC0WUjugjAjx/pWhfkp2EF/vstJ6V4Oz8zMh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="319744742"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="319744742"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 04:10:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="777680182"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="777680182"
Received: from tester-latitude-7480.iind.intel.com ([10.224.186.122])
  by orsmga004.jf.intel.com with ESMTP; 29 Dec 2022 04:10:14 -0800
From:   Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
Subject: [PATCH BlueZ v2 5/6] client/player: Add support for Company ID, Vendor ID in BAP Profile
Date:   Thu, 29 Dec 2022 17:58:22 +0530
Message-Id: <20221229122821.340073-6-abhay.maheshbhai.maheta@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221229122821.340073-1-abhay.maheshbhai.maheta@intel.com>
References: <20221229122821.340073-1-abhay.maheshbhai.maheta@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds support for Company ID and Vendor Codec ID in  BAP profile.
This also adds handling of Vendor Specific Coding format for BAP
Profile.

Now it allows to enter zero codec capabilities.
In order to register zero codec capabilities, 0 shall be
entered when prompted.

[bluetooth]# endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb 0xff
[/local/endpoint/ep2] Enter Capabilities: 0
[/local/endpoint/ep2] Enter Company ID & Vendor ID: 0xaabbccdd
[/local/endpoint/ep2] Auto Accept (yes/no): y
[/local/endpoint/ep2] CIG (auto/value): a
[/local/endpoint/ep2] CIS (auto/value): a
Endpoint /local/endpoint/ep2 registered
---
 client/player.c | 131 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 114 insertions(+), 17 deletions(-)

diff --git a/client/player.c b/client/player.c
index eba233329..0f3b7dbe8 100644
--- a/client/player.c
+++ b/client/player.c
@@ -66,6 +66,8 @@ struct endpoint {
 	char *path;
 	char *uuid;
 	uint8_t codec;
+	uint16_t cid;
+	uint16_t vid;
 	struct iovec *caps;
 	bool auto_accept;
 	bool acquiring;
@@ -85,6 +87,7 @@ static GList *endpoints = NULL;
 static GList *local_endpoints = NULL;
 static GList *transports = NULL;
 static struct queue *ios = NULL;
+static bool is_cid_available = FALSE;
 
 struct transport {
 	GDBusProxy *proxy;
@@ -1815,7 +1818,8 @@ static void endpoint_free(void *data)
 	struct endpoint *ep = data;
 
 	if (ep->caps) {
-		g_free(ep->caps->iov_base);
+		if (ep->caps->iov_base)
+			g_free(ep->caps->iov_base);
 		g_free(ep->caps);
 	}
 
@@ -1865,10 +1869,32 @@ static gboolean endpoint_get_capabilities(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean endpoint_get_cid(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct endpoint *ep = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &ep->cid);
+
+	return TRUE;
+}
+
+static gboolean endpoint_get_vid(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct endpoint *ep = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &ep->vid);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable endpoint_properties[] = {
 	{ "UUID", "s", endpoint_get_uuid, NULL, NULL },
 	{ "Codec", "y", endpoint_get_codec, NULL, NULL },
 	{ "Capabilities", "ay", endpoint_get_capabilities, NULL, NULL },
+	{ "CompanyID", "q", endpoint_get_cid, NULL, NULL },
+	{ "VendorCodecID", "q", endpoint_get_vid, NULL, NULL },
 	{ }
 };
 
@@ -1886,12 +1912,20 @@ static void register_endpoint_setup(DBusMessageIter *iter, void *user_data)
 
 	g_dbus_dict_append_entry(&dict, "Codec", DBUS_TYPE_BYTE, &ep->codec);
 
-	g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &key,
+	g_dbus_dict_append_entry(&dict, "CompanyID", DBUS_TYPE_UINT16,
+					&ep->cid);
+
+	g_dbus_dict_append_entry(&dict, "VendorCodecID", DBUS_TYPE_UINT16,
+					&ep->vid);
+
+	if (ep->caps->iov_len) {
+		g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &key,
 					DBUS_TYPE_BYTE, &ep->caps->iov_base,
 					ep->caps->iov_len);
 
-	bt_shell_printf("Capabilities:\n");
-	bt_shell_hexdump(ep->caps->iov_base, ep->caps->iov_len);
+		bt_shell_printf("Capabilities:\n");
+		bt_shell_hexdump(ep->caps->iov_base, ep->caps->iov_len);
+	}
 
 	dbus_message_iter_close_container(iter, &dict);
 }
@@ -1950,6 +1984,21 @@ fail:
 
 }
 
+static void get_cid_vid(const char *input, uint32_t *id)
+{
+	char *endptr = NULL;
+	int value;
+
+	value = strtol(input, &endptr, 0);
+
+	if (!endptr || *endptr != '\0' || value > UINT32_MAX) {
+		bt_shell_printf("Invalid argument: %s\n", input);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	*id = (uint32_t)value;
+}
+
 static void endpoint_cis(const char *input, void *user_data)
 {
 	struct endpoint *ep = user_data;
@@ -2010,19 +2059,55 @@ static void endpoint_auto_accept(const char *input, void *user_data)
 	bt_shell_prompt_input(ep->path, "CIG (auto/value):", endpoint_cig, ep);
 }
 
+static void endpoint_set_id(const char *input, void *user_data)
+{
+	struct endpoint *ep = user_data;
+	uint32_t val;
+
+	get_cid_vid(input, &val);
+	ep->cid = (uint16_t)(val & 0x0000ffff);
+	ep->vid = (uint16_t)((val & 0xffff0000) >> 16);
+
+	bt_shell_prompt_input(ep->path, "Auto Accept (yes/no):",
+			endpoint_auto_accept, ep);
+}
+
+void endpoint_set_parameters(struct endpoint *ep)
+{
+	if (!(strcasecmp(ep->uuid, PAC_SINK_UUID)) ||
+		!(strcasecmp(ep->uuid, PAC_SOURCE_UUID))) {
+		if ((ep->codec == 0xff) && (is_cid_available == FALSE))
+			bt_shell_prompt_input(ep->path,
+				"Enter Company ID & Vendor ID:",
+				endpoint_set_id, ep);
+		else
+			bt_shell_prompt_input(ep->path, "Auto Accept (yes/no):",
+					endpoint_auto_accept, ep);
+	} else
+		bt_shell_prompt_input(ep->path, "Auto Accept (yes/no):",
+				endpoint_auto_accept, ep);
+}
+
 static void endpoint_set_capabilities(const char *input, void *user_data)
 {
 	struct endpoint *ep = user_data;
 
-	if (ep->caps)
+	if (ep->caps && ep->caps->iov_base) {
 		g_free(ep->caps->iov_base);
-	else
+		ep->caps = g_new0(struct iovec, 1);
+	} else
 		ep->caps = g_new0(struct iovec, 1);
 
 	ep->caps->iov_base = str2bytearray((char *) input, &ep->caps->iov_len);
 
-	bt_shell_prompt_input(ep->path, "Auto Accept (yes/no):",
-						endpoint_auto_accept, ep);
+	if (ep->caps->iov_len == 0x01 &&
+			(*(uint8_t *)(ep->caps->iov_base)) == 0x00) {
+		g_free(ep->caps->iov_base);
+		ep->caps->iov_base = NULL;
+		ep->caps->iov_len = 0x00;
+	}
+
+	endpoint_set_parameters(ep);
 }
 
 static char *uuid_generator(const char *text, int state)
@@ -2073,13 +2158,13 @@ static void cmd_register_endpoint(int argc, char *argv[])
 	ep = g_new0(struct endpoint, 1);
 	ep->uuid = g_strdup(argv[1]);
 	ep->codec = strtol(argv[2], &endptr, 0);
+	ep->cid = 0x0000;
+	ep->vid = 0x0000;
 	ep->path = g_strdup_printf("%s/ep%u", BLUEZ_MEDIA_ENDPOINT_PATH,
 					g_list_length(local_endpoints));
 	local_endpoints = g_list_append(local_endpoints, ep);
 
-	if (argc > 3)
-		endpoint_set_capabilities(argv[3], ep);
-	else {
+	if (argc == 3) {
 		const struct capabilities *cap;
 
 		cap = find_capabilities(ep->uuid, ep->codec);
@@ -2089,13 +2174,25 @@ static void cmd_register_endpoint(int argc, char *argv[])
 
 			/* Copy capabilities */
 			iov_append(&ep->caps, cap->data.iov_base,
-							cap->data.iov_len);
+					cap->data.iov_len);
 
-			bt_shell_prompt_input(ep->path, "Auto Accept (yes/no):",
-						endpoint_auto_accept, ep);
+			endpoint_set_parameters(ep);
 		} else
-			bt_shell_prompt_input(ep->path, "Enter capabilities:",
-						endpoint_set_capabilities, ep);
+			bt_shell_prompt_input(ep->path, "Enter Capabilities:",
+					endpoint_set_capabilities, ep);
+	} else if (argc == 4) {
+		endpoint_set_capabilities(argv[3], ep);
+	} else if (argc == 5) {
+		uint32_t val = 0;
+
+		get_cid_vid(argv[4], &val);
+		ep->cid = (uint16_t)(val & 0x0000ffff);
+		ep->vid = (uint16_t)((val & 0xffff0000) >> 16);
+		is_cid_available = TRUE;
+
+		endpoint_set_capabilities(argv[3], ep);
+
+		is_cid_available = FALSE;
 	}
 }
 
@@ -2638,7 +2735,7 @@ static const struct bt_shell_menu endpoint_menu = {
 	{ "show",         "<endpoint>", cmd_show_endpoint,
 						"Endpoint information",
 						endpoint_generator },
-	{ "register",     "<UUID> <codec> [capabilities...]",
+	{ "register",     "<UUID> <codec> [capabilities...] [Company ID]",
 						cmd_register_endpoint,
 						"Register Endpoint",
 						uuid_generator },
-- 
2.25.1

