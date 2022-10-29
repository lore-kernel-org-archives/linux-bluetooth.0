Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADF0FA3740
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Oct 2022 16:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJ2Qp5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Oct 2022 12:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJ2Qpz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Oct 2022 12:45:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760EC5A80D
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Oct 2022 09:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667061953; x=1698597953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yNcyrOKx/NMurMj12nSKjrI+DwFcSuLotCeqyWNjdWA=;
  b=m/oztQ5m58H/OPLIHNHcNE37O+Nw8LSI8uegRK8m2ze+hZx+zFTLXB8u
   oMwtAcpAf+UDaJz8UHz8rQT4a7eW6t4B92AyZPJJtHRsok/dNKg3xuQky
   ZQ6V1I6inyP37YKMfxmKmzE3jpcj13XtXRwke1vN8h4ADgzD4KUPmpnW3
   dJZdIS3YPCDO+cUrbigNz3Wdedm2kwl9JFNH3t7NtC6j/JwYhMahZ8kwH
   FnmdRDGXRA0g6Nh5xyLga1rB2SN/XkxD6+dBtGr8VusbAYtZ4zO6NxzpX
   HymcU88L/PlOZ2w2wnhoQ8Hv5tYWMYfHwsMqLPI7suCDXXCIZ0jkl3/PJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="289074315"
X-IronPort-AV: E=Sophos;i="5.95,224,1661842800"; 
   d="scan'208";a="289074315"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2022 09:45:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10515"; a="666399495"
X-IronPort-AV: E=Sophos;i="5.95,224,1661842800"; 
   d="scan'208";a="666399495"
Received: from tester-latitude-7480.iind.intel.com ([10.224.186.120])
  by orsmga001.jf.intel.com with ESMTP; 29 Oct 2022 09:45:51 -0700
From:   Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     "Maheta, Abhay" <abhay.maheshbhai.maheta@intel.com>
Subject: [PATCH BlueZ 5/5] client/player: Add support for Metadata, CID, VID
Date:   Sat, 29 Oct 2022 22:34:08 +0530
Message-Id: <20221029170408.175533-6-abhay.maheshbhai.maheta@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221029170408.175533-1-abhay.maheshbhai.maheta@intel.com>
References: <20221029170408.175533-1-abhay.maheshbhai.maheta@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: "Maheta, Abhay" <abhay.maheshbhai.maheta@intel.com>

This adds support for Metadata, Company ID and Vendor Codec ID.
This also adds handling of Vendor Specific Coding format.
Now it allows to enter zero codec capabilities.
It allows to enter zero metadata as well.
In order to register zero codec capabilities and metadata
0 shall be entered when prompted.
---
 client/player.c | 185 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 175 insertions(+), 10 deletions(-)

diff --git a/client/player.c b/client/player.c
index 432408934..f4338416b 100644
--- a/client/player.c
+++ b/client/player.c
@@ -63,7 +63,10 @@ struct endpoint {
 	char *path;
 	char *uuid;
 	uint8_t codec;
+	uint16_t cid;
+	uint16_t vid;
 	struct iovec *caps;
+	struct iovec *meta;
 	bool auto_accept;
 	bool acquiring;
 	uint8_t cig;
@@ -1643,6 +1646,7 @@ struct endpoint_config {
 	GDBusProxy *proxy;
 	struct endpoint *ep;
 	struct iovec *caps;
+	struct iovec *meta;
 	uint8_t target_latency;
 	const struct codec_qos *qos;
 };
@@ -1653,6 +1657,7 @@ static void append_properties(DBusMessageIter *iter,
 	DBusMessageIter dict;
 	struct codec_qos *qos = (void *)cfg->qos;
 	const char *key = "Capabilities";
+	const char *meta = "Metadata";
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
 
@@ -1663,6 +1668,15 @@ static void append_properties(DBusMessageIter *iter,
 					DBUS_TYPE_BYTE, &cfg->caps->iov_base,
 					cfg->caps->iov_len);
 
+	if (cfg->meta->iov_len) {
+		g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &meta,
+					DBUS_TYPE_BYTE, &cfg->meta->iov_base,
+					cfg->meta->iov_len);
+
+		bt_shell_printf("Metadata:\n");
+		bt_shell_hexdump(cfg->meta->iov_base, cfg->meta->iov_len);
+	}
+
 	if (!qos)
 		goto done;
 
@@ -1756,6 +1770,9 @@ static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
 	iov_append(&cfg->caps, preset->data.iov_base, preset->data.iov_len);
 	cfg->target_latency = preset->latency;
 
+	/* Copy metadata */
+	iov_append(&cfg->meta, cfg->ep->meta->iov_base, cfg->ep->meta->iov_len);
+
 	if (preset->qos.phy)
 		/* Set QoS parameters */
 		cfg->qos = &preset->qos;
@@ -1899,10 +1916,17 @@ static void endpoint_free(void *data)
 	struct endpoint *ep = data;
 
 	if (ep->caps) {
-		g_free(ep->caps->iov_base);
+		if (ep->caps->iov_base)
+			g_free(ep->caps->iov_base);
 		g_free(ep->caps);
 	}
 
+	if (ep->meta) {
+		if (ep->meta->iov_base)
+			g_free(ep->meta->iov_base);
+		g_free(ep->meta);
+	}
+
 	if (ep->msg)
 		dbus_message_unref(ep->msg);
 
@@ -1949,10 +1973,52 @@ static gboolean endpoint_get_capabilities(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean endpoint_get_metadata(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct endpoint *ep = data;
+	DBusMessageIter array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_BYTE_AS_STRING, &array);
+
+	dbus_message_iter_append_fixed_array(&array, DBUS_TYPE_BYTE,
+				&ep->meta->iov_base,
+				ep->meta->iov_len);
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
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
+
 static const GDBusPropertyTable endpoint_properties[] = {
 	{ "UUID", "s", endpoint_get_uuid, NULL, NULL },
 	{ "Codec", "y", endpoint_get_codec, NULL, NULL },
 	{ "Capabilities", "ay", endpoint_get_capabilities, NULL, NULL },
+	{ "Metadata", "ay", endpoint_get_metadata, NULL, NULL },
+	{ "CompanyID", "q", endpoint_get_cid, NULL, NULL },
+	{ "VendorCodecID", "q", endpoint_get_vid, NULL, NULL },
 	{ }
 };
 
@@ -1961,6 +2027,7 @@ static void register_endpoint_setup(DBusMessageIter *iter, void *user_data)
 	struct endpoint *ep = user_data;
 	DBusMessageIter dict;
 	const char *key = "Capabilities";
+	const char *meta = "Metadata";
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &ep->path);
 
@@ -1970,12 +2037,29 @@ static void register_endpoint_setup(DBusMessageIter *iter, void *user_data)
 
 	g_dbus_dict_append_entry(&dict, "Codec", DBUS_TYPE_BYTE, &ep->codec);
 
-	g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &key,
+	g_dbus_dict_append_entry(&dict, "CompanyID", DBUS_TYPE_UINT16,
+							&ep->cid);
+
+	g_dbus_dict_append_entry(&dict, "VendorCodecID", DBUS_TYPE_UINT16,
+							&ep->vid);
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
+
+	if (ep->meta->iov_len) {
+		bt_shell_printf("Metadata:\n");
+		bt_shell_hexdump(ep->meta->iov_base, ep->meta->iov_len);
+
+		g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &meta,
+					DBUS_TYPE_BYTE, &ep->meta->iov_base,
+					ep->meta->iov_len);
+	}
 
 	dbus_message_iter_close_container(iter, &dict);
 }
@@ -2094,19 +2178,93 @@ static void endpoint_auto_accept(const char *input, void *user_data)
 	bt_shell_prompt_input(ep->path, "CIG (auto/value):", endpoint_cig, ep);
 }
 
+static void endpoint_set_metadata(const char *input, void *user_data)
+{
+	struct endpoint *ep = user_data;
+
+	if (ep->meta && ep->meta->iov_base) {
+		g_free(ep->meta->iov_base);
+		ep->meta->iov_base = NULL;
+	} else
+		ep->meta = g_new0(struct iovec, 1);
+
+	ep->meta->iov_base = str2bytearray((char *) input, &ep->meta->iov_len);
+
+	if (ep->meta->iov_len == 0x01 && (*(uint8_t *)(ep->meta->iov_base)) ==
+			0x00) {
+		g_free(ep->meta->iov_base);
+		ep->meta->iov_base = NULL;
+		ep->meta->iov_len = 0x00;
+	}
+
+	bt_shell_prompt_input(ep->path, "Auto Accept (yes/no):",
+					endpoint_auto_accept, ep);
+}
+
+static void endpoint_set_vid(const char *input, void *user_data)
+{
+	struct endpoint *ep = user_data;
+	char *endptr = NULL;
+	int value;
+
+	value = strtol(input, &endptr, 0);
+
+	if (!endptr || *endptr != '\0' || value > UINT16_MAX) {
+		bt_shell_printf("Invalid argument: %s\n", input);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	ep->vid = value;
+
+	bt_shell_prompt_input(ep->path, "Enter Metadata:",
+					endpoint_set_metadata, ep);
+}
+
+static void endpoint_set_cid(const char *input, void *user_data)
+{
+	struct endpoint *ep = user_data;
+	char *endptr = NULL;
+	int value;
+
+	value = strtol(input, &endptr, 0);
+
+	if (!endptr || *endptr != '\0' || value > UINT16_MAX) {
+		bt_shell_printf("Invalid argument: %s\n", input);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	ep->cid = value;
+
+	bt_shell_prompt_input(ep->path, "Vendor Codec ID:",
+					endpoint_set_vid, ep);
+}
+
 static void endpoint_set_capabilities(const char *input, void *user_data)
 {
 	struct endpoint *ep = user_data;
 
-	if (ep->caps)
+	if (ep->caps && ep->caps->iov_base) {
 		g_free(ep->caps->iov_base);
-	else
+		ep->caps->iov_base = NULL;
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
+	if (ep->codec == 0xff) {
+		bt_shell_prompt_input(ep->path, "Enter Company ID:",
+						endpoint_set_cid, ep);
+	} else {
+		bt_shell_prompt_input(ep->path, "Enter Metadata:",
+						endpoint_set_metadata, ep);
+	}
 }
 
 static char *uuid_generator(const char *text, int state)
@@ -2175,8 +2333,15 @@ static void cmd_register_endpoint(int argc, char *argv[])
 			iov_append(&ep->caps, cap->data.iov_base,
 							cap->data.iov_len);
 
-			bt_shell_prompt_input(ep->path, "Auto Accept (yes/no):",
-						endpoint_auto_accept, ep);
+			if (ep->codec == 0xff) {
+				bt_shell_prompt_input(ep->path,
+						"Enter Company ID:",
+						endpoint_set_cid, ep);
+			} else {
+				bt_shell_prompt_input(ep->path,
+						"Enter Metadata:",
+						endpoint_set_metadata, ep);
+			}
 		} else
 			bt_shell_prompt_input(ep->path, "Enter capabilities:",
 						endpoint_set_capabilities, ep);
-- 
2.25.1

