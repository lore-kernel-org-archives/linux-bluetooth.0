Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F73C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Dec 2022 12:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbiL2MKU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Dec 2022 07:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbiL2MKT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Dec 2022 07:10:19 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F6812AA2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Dec 2022 04:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672315818; x=1703851818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6H/f4geEDpDUU/tCA3RxOHudmVvQQmtkVh2+lS0whoc=;
  b=G++hkpmhQmz+KwIwz0+Wmadq5NTbPHHbycKiRIlUfvXtXxFpqV8qyQ90
   OZIAFsxuLtnXXFTWjZNaKQdCG6Eo/SRhp9fmsA0XXUEj0TBQ4Jbh6iRlE
   ktkEp8AY/rTGd7AkIeyKz6mdsiAGfJa419NyfNa4S/meAShhUQh5jmCFq
   GsBEkjUzx2w2yTQKlfi9y+1BWr7f2qXOeLBdavD6aRgbKwoBHBWVCi2Qs
   m2DFKOV6B0vugEU0p8Q7DxRC2DE/YH++RDw7Xpz8USqcXb45itVDY1S+a
   9Cx6mnerDsdgNzqUeSMyFYJ8817dFLBvg9SxoLsbsDWJE3QkhqGgPwJtm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="319744746"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="319744746"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 04:10:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="777680191"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="777680191"
Received: from tester-latitude-7480.iind.intel.com ([10.224.186.122])
  by orsmga004.jf.intel.com with ESMTP; 29 Dec 2022 04:10:16 -0800
From:   Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
Subject: [PATCH BlueZ v2 6/6] client/player: Add support for Metadata in BAP Profile
Date:   Thu, 29 Dec 2022 17:58:23 +0530
Message-Id: <20221229122821.340073-7-abhay.maheshbhai.maheta@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221229122821.340073-1-abhay.maheshbhai.maheta@intel.com>
References: <20221229122821.340073-1-abhay.maheshbhai.maheta@intel.com>
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
index 0f3b7dbe8..2d036a3f0 100644
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
 
 void endpoint_set_parameters(struct endpoint *ep)
@@ -2081,8 +2155,8 @@ void endpoint_set_parameters(struct endpoint *ep)
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

