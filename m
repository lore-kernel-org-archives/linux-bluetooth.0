Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D05DC4167B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Dec 2022 15:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbiL2P5a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Dec 2022 10:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbiL2P5A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Dec 2022 10:57:00 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74752116E
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Dec 2022 07:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672329397; x=1703865397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3TySbwrHONNGg+EYSbfIHfqgQP/xxGxHTZhV6i7oIsQ=;
  b=QGaUjyYP4ztN57uchQT/97kiE6dPGKnBHXAAgQN5Z6i6UOJiNG/EifLy
   0ri7paegHkEq7Z56HWTjE2RyDxopjMbGIfWnCmU+u55YJXZSiFoFHxQGM
   zH7pJsE8nAc3TakdipRqt6oWywH6YG5fAtIQQQfs1733T9tlAShqSLzIq
   bj9AVt08+4pDDfrIuo7K+gmvGdkmbGgdMaSAXWv8JPLsP8uqlD7X6kxWY
   yUDj9ksG5EsgAZIyYvqzWljoKeDMRJvccqGSzwP1+QD1hd+uPXf733YdN
   8EFoxUbx47p7mcrOgJiX+j0Wsa7JnnpgNjyXYXc0hkcIHEYTOa25mx/SM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="321139831"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="321139831"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 07:56:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="686024654"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="686024654"
Received: from tester-latitude-7480.iind.intel.com ([10.224.186.122])
  by orsmga001.jf.intel.com with ESMTP; 29 Dec 2022 07:56:35 -0800
From:   Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>,
        Abhay Maheta <mabhay125@gmail.com>
Subject: [PATCH BlueZ v3 6/6] client/player: Add support for Metadata in BAP Profile
Date:   Thu, 29 Dec 2022 21:23:05 +0530
Message-Id: <20221229155257.341327-7-abhay.maheshbhai.maheta@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221229155257.341327-1-abhay.maheshbhai.maheta@intel.com>
References: <20221229155257.341327-1-abhay.maheshbhai.maheta@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds support for Metadata in BAP profile.
In order to register zero Metadata, 0 shall be
entered when prompted.

[bluetooth]# endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Enter Metadata: 0
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] CIG (auto/value): a
[/local/endpoint/ep0] CIS (auto/value): a
Capabilities:
  03 01 ff 00 02 02 03 02 03 03 05 04 1e 00 f0 00  ................
Endpoint /local/endpoint/ep0 registered
---
 client/player.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 4 deletions(-)

diff --git a/client/player.c b/client/player.c
index ff1ff209c..58a05ad13 100644
--- a/client/player.c
+++ b/client/player.c
@@ -69,6 +69,7 @@ struct endpoint {
 	uint16_t cid;
 	uint16_t vid;
 	struct iovec *caps;
+	struct iovec *meta;
 	bool auto_accept;
 	bool acquiring;
 	uint8_t cig;
@@ -1558,6 +1559,7 @@ struct endpoint_config {
 	GDBusProxy *proxy;
 	struct endpoint *ep;
 	struct iovec *caps;
+	struct iovec *meta;
 	uint8_t target_latency;
 	const struct codec_qos *qos;
 };
@@ -1568,6 +1570,7 @@ static void append_properties(DBusMessageIter *iter,
 	DBusMessageIter dict;
 	struct codec_qos *qos = (void *)cfg->qos;
 	const char *key = "Capabilities";
+	const char *meta = "Metadata";
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
 
@@ -1578,6 +1581,15 @@ static void append_properties(DBusMessageIter *iter,
 					DBUS_TYPE_BYTE, &cfg->caps->iov_base,
 					cfg->caps->iov_len);
 
+	if (cfg->meta->iov_len) {
+		g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &meta,
+				DBUS_TYPE_BYTE, &cfg->meta->iov_base,
+				cfg->meta->iov_len);
+
+		bt_shell_printf("Metadata:\n");
+		bt_shell_hexdump(cfg->meta->iov_base, cfg->meta->iov_len);
+	}
+
 	if (!qos)
 		goto done;
 
@@ -1675,6 +1687,9 @@ static DBusMessage *endpoint_select_properties_reply(struct endpoint *ep,
 	iov_append(&cfg->caps, preset->data.iov_base, preset->data.iov_len);
 	cfg->target_latency = preset->target_latency;
 
+	/* Copy metadata */
+	iov_append(&cfg->meta, cfg->ep->meta->iov_base, cfg->ep->meta->iov_len);
+
 	if (preset->qos.phy)
 		/* Set QoS parameters */
 		cfg->qos = &preset->qos;
@@ -1823,6 +1838,12 @@ static void endpoint_free(void *data)
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
 
@@ -1869,6 +1890,24 @@ static gboolean endpoint_get_capabilities(const GDBusPropertyTable *property,
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
 static gboolean endpoint_get_cid(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -1893,6 +1932,7 @@ static const GDBusPropertyTable endpoint_properties[] = {
 	{ "UUID", "s", endpoint_get_uuid, NULL, NULL },
 	{ "Codec", "y", endpoint_get_codec, NULL, NULL },
 	{ "Capabilities", "ay", endpoint_get_capabilities, NULL, NULL },
+	{ "Metadata", "ay", endpoint_get_metadata, NULL, NULL },
 	{ "CompanyID", "q", endpoint_get_cid, NULL, NULL },
 	{ "VendorCodecID", "q", endpoint_get_vid, NULL, NULL },
 	{ }
@@ -1903,6 +1943,7 @@ static void register_endpoint_setup(DBusMessageIter *iter, void *user_data)
 	struct endpoint *ep = user_data;
 	DBusMessageIter dict;
 	const char *key = "Capabilities";
+	const char *meta = "Metadata";
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &ep->path);
 
@@ -1927,6 +1968,15 @@ static void register_endpoint_setup(DBusMessageIter *iter, void *user_data)
 		bt_shell_hexdump(ep->caps->iov_base, ep->caps->iov_len);
 	}
 
+	if (ep->meta->iov_len) {
+		bt_shell_printf("Metadata:\n");
+		bt_shell_hexdump(ep->meta->iov_base, ep->meta->iov_len);
+
+		g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_STRING, &meta,
+				DBUS_TYPE_BYTE, &ep->meta->iov_base,
+				ep->meta->iov_len);
+	}
+
 	dbus_message_iter_close_container(iter, &dict);
 }
 
@@ -2059,6 +2109,30 @@ static void endpoint_auto_accept(const char *input, void *user_data)
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
+			endpoint_auto_accept, ep);
+}
+
+
 static void endpoint_set_id(const char *input, void *user_data)
 {
 	struct endpoint *ep = user_data;
@@ -2068,8 +2142,8 @@ static void endpoint_set_id(const char *input, void *user_data)
 	ep->cid = (uint16_t)(val & 0x0000ffff);
 	ep->vid = (uint16_t)((val & 0xffff0000) >> 16);
 
-	bt_shell_prompt_input(ep->path, "Auto Accept (yes/no):",
-			endpoint_auto_accept, ep);
+	bt_shell_prompt_input(ep->path, "Enter Metadata:",
+			 endpoint_set_metadata, ep);
 }
 
 static void endpoint_set_parameters(struct endpoint *ep)
@@ -2081,8 +2155,8 @@ static void endpoint_set_parameters(struct endpoint *ep)
 				"Enter Company ID & Vendor ID:",
 				endpoint_set_id, ep);
 		else
-			bt_shell_prompt_input(ep->path, "Auto Accept (yes/no):",
-					endpoint_auto_accept, ep);
+			bt_shell_prompt_input(ep->path, "Enter Metadata:",
+					endpoint_set_metadata, ep);
 	} else
 		bt_shell_prompt_input(ep->path, "Auto Accept (yes/no):",
 				endpoint_auto_accept, ep);
-- 
2.25.1

