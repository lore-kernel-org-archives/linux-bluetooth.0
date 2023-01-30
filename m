Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E03C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Jan 2023 23:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjA3Xwh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Jan 2023 18:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjA3Xwc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Jan 2023 18:52:32 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351EE2FCE0
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 15:52:31 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id on9-20020a17090b1d0900b002300a96b358so1355965pjb.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 15:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZ+WXA5rfXCyP9DEt+1qvSYNC29Vn7vTNiGQB7hCFIA=;
        b=NxbRHRGxvNJfzItG/ReXOKjfXafIVtThugLKGN2TKYFpSIjU1IGelpPrJu1smlAAKP
         xZYKNJioE68iwgtS6E9mN1fR7ANJaB/YH4D2H1jJYZNY8+jfcNpLHXRsivAX4ZVcl7Qb
         LdMmtEczZ9/dPHY2Ze50h0v9v6zbQPj1M0UOcJeCXZZ3vqQ6AMIHqJ3Z3xV8+xIFtNZ4
         eMiVOPz9s3XViCB/KW1B/0n49xgVklvX77nQaVGaWgz/UJv320tpYya7ByCrCxEWaMVu
         iIclg+a3GJ6etSLRcezkAFOKSWbHymL+YLJ7KVL+MfJAXPPsnZ0qHr2TFZI7LlVGkz2i
         7CnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZ+WXA5rfXCyP9DEt+1qvSYNC29Vn7vTNiGQB7hCFIA=;
        b=5tSNZycC3yPTzFfTgQ3uasHnA6wVli1XbPvBuuz9KEQhHslD2QKfG6jSctq31AZF43
         cTQoVFR+f4veeYC4pXkUkEDt7gaAmF4j0Y/bIefvYCBqGm8Spfelxu1yxTlB57pLD5oT
         FyuEVAEK+OMghTc7kU1gh35QJQ8K5MxaXFopvfm0JqRsnTavyKGIL8YWt1tXRL9Z8oil
         +n0Gwg3I8k+/BeUfm0r8so7m+sYTFdnU8uS1rXfvGU14V6oTg1TiH7pPX1fPKvFkNTiT
         T/rSdHJIy/azs9XWXX8X/k3W1dzV5n4qmxep9z98WIa8PVsix/Zkc1Kc8NahdXUV1IT1
         9NRA==
X-Gm-Message-State: AO0yUKXmYAlZD0VMZgeUOofQe1lmWMJJrb9JmV+RvE2ofk92sUKlDHIh
        b/09uv/vpErqLyS53ewOj5hlmuF5vGI4XQ==
X-Google-Smtp-Source: AK7set8BchfRM3l9QZwI1cYOZcwpW7aGOyWQkprTmG0ELEURdQHMe9q8VvuPdqs9nuvILY5VN748wA==
X-Received: by 2002:a05:6a21:3390:b0:bc:fe7e:cfd9 with SMTP id yy16-20020a056a21339000b000bcfe7ecfd9mr7160302pzb.18.1675122750116;
        Mon, 30 Jan 2023 15:52:30 -0800 (PST)
Received: from fedora.. (97-126-124-199.tukw.qwest.net. [97.126.124.199])
        by smtp.gmail.com with ESMTPSA id t191-20020a6381c8000000b004e8f7f23c4bsm2663948pgd.76.2023.01.30.15.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 15:52:29 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH BlueZ v5 14/14] tools/mesh-cfgtest: Support extended device composition
Date:   Mon, 30 Jan 2023 15:52:10 -0800
Message-Id: <20230130235210.94385-15-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230130235210.94385-1-brian.gix@gmail.com>
References: <20230130235210.94385-1-brian.gix@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Inga Stotland <inga.stotland@intel.com>

This adds support for extended device composition to account for
new fundamental models supported by bluetooth-meshd daemon.
Also, update to include explicit element locations and handle
different ordering of model IDs in the composition data.
---
 tools/mesh-cfgtest.c | 188 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 168 insertions(+), 20 deletions(-)

diff --git a/tools/mesh-cfgtest.c b/tools/mesh-cfgtest.c
index 116ab7f16..739d1d972 100644
--- a/tools/mesh-cfgtest.c
+++ b/tools/mesh-cfgtest.c
@@ -38,14 +38,21 @@
 #define MAX_CRPL_SIZE	0x7fff
 #define CFG_SRV_MODEL	0x0000
 #define CFG_CLI_MODEL	0x0001
+#define RMT_PROV_SRV_MODEL 0x0004
+#define RMT_PROV_CLI_MODEL 0x0005
+#define PVT_BEACON_SRV_MODEL 0x0008
 #define DEFAULT_IV_INDEX 0x0000
 
-#define IS_CONFIG_MODEL(x) ((x) == CFG_SRV_MODEL || (x) == CFG_CLI_MODEL)
+#define IS_CONFIG_MODEL(x) (((x) == (CFG_SRV_MODEL)) ||		\
+				((x) == (CFG_CLI_MODEL)) ||		\
+				((x) == (RMT_PROV_SRV_MODEL)) ||	\
+				((x) == (RMT_PROV_CLI_MODEL)))
 
 struct meshcfg_el {
 	const char *path;
 	uint8_t index;
-	uint16_t mods[2];
+	uint16_t location;
+	uint16_t mods[4];
 	uint32_t vmods[2];
 };
 
@@ -77,6 +84,11 @@ struct msg_data {
 	uint8_t data[MAX_MSG_LEN];
 };
 
+struct exp_rsp {
+	uint8_t test_id;
+	void *rsp;
+};
+
 struct key_data {
 	uint16_t idx;
 	bool update;
@@ -140,7 +152,9 @@ static struct meshcfg_app client_app = {
 		{
 			.path = cli_ele_path_00,
 			.index = PRIMARY_ELE_IDX,
-			.mods = {CFG_SRV_MODEL, CFG_CLI_MODEL},
+			.location = 0x0001,
+			.mods = {CFG_SRV_MODEL, CFG_CLI_MODEL,
+				 RMT_PROV_SRV_MODEL, PVT_BEACON_SRV_MODEL},
 			.vmods = {0xffffffff, 0xffffffff}
 		}
 	}
@@ -158,13 +172,16 @@ static struct meshcfg_app server_app = {
 		{
 			.path = srv_ele_path_00,
 			.index = PRIMARY_ELE_IDX,
-			.mods = {CFG_SRV_MODEL, 0xffff},
+			.location = 0x0001,
+			.mods = {CFG_SRV_MODEL, RMT_PROV_SRV_MODEL,
+						PVT_BEACON_SRV_MODEL, 0xffff},
 			.vmods = {0xffffffff, 0xffffffff}
 		},
 		{
 			.path = srv_ele_path_01,
 			.index = PRIMARY_ELE_IDX + 1,
-			.mods = {0x1000, 0xffff},
+			.location = 0x0002,
+			.mods = {0x1000, 0xffff, 0xffff, 0xffff},
 			.vmods = {0x5F10001, 0xffffffff}
 		}
 	}
@@ -262,6 +279,11 @@ static struct msg_data test_add_appkey_rsp = {
 	.data = {0x80, 0x03, 0x00, 0x01, 0x20, 0x00}
 };
 
+static struct exp_rsp test_add_appkey_expected = {
+	.test_id = 1,
+	.rsp = &test_add_appkey_rsp,
+};
+
 static struct key_data test_add_appkey_req = {
 	.idx = 0x002,
 	.update = false
@@ -285,6 +307,11 @@ static struct msg_data test_set_ttl_rsp = {
 	.data = { 0x80, 0x0E, 0x7}
 };
 
+static struct exp_rsp test_set_ttl_expected = {
+	.test_id = 2,
+	.rsp = &test_set_ttl_rsp
+};
+
 static struct msg_data test_set_ttl_req = {
 	.len = 3,
 	.data = { 0x80, 0x0D, 0x7}
@@ -295,27 +322,42 @@ static struct msg_data test_bind_rsp = {
 	.data = { 0x80, 0x3E, 0x00, 0xCE, 0x0B, 0x01, 0x00, 0x00, 0x10},
 };
 
+static struct exp_rsp test_bind_expected = {
+	.test_id = 3,
+	.rsp = &test_bind_rsp
+};
+
 static struct msg_data test_bind_req = {
 	.len = 8,
 	.data = { 0x80, 0x3D, 0xCE, 0x0B, 0x01, 0x00, 0x00, 0x10}
 };
 
-
 static struct msg_data test_bind_inv_mod_rsp = {
 	.len = 9,
 	.data = { 0x80, 0x3E, 0x02, 0xCE, 0x0B, 0x01, 0x00, 0x00, 0x11},
 };
 
+static struct exp_rsp test_bind_inv_mod_expected = {
+	.test_id = 4,
+	.rsp = &test_bind_inv_mod_rsp
+};
+
 static struct msg_data test_bind_inv_mod_req = {
 	.len = 8,
 	.data = { 0x80, 0x3D, 0xCE, 0x0B, 0x01, 0x00, 0x00, 0x11}
 };
 
 static struct msg_data test_dev_comp_rsp = {
-	.len = 28,
-	.data = { 0x02, 0x00, 0xf1, 0x05, 0x02, 0x00, 0x01, 0x00, 0xff, 0x7f,
-			0x05, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00,
-			0x00, 0x01, 0x01, 0x00, 0x10, 0xf1, 0x05, 0x01, 0x00}
+	.len = 32,
+	.data = { 0x02, 0x00, 0xf1, 0x05, 0x02, 0x00, 0x01, 0x00,
+		0xff, 0x7f, 0x05, 0x00,
+		0x01, 0x00, 0x03, 0x00, 0x00, 0x00, 0x04, 0x00, 0x08, 0x00,
+		0x02, 0x00, 0x01, 0x01, 0x00, 0x10, 0xf1, 0x05, 0x01, 0x00}
+};
+
+static struct exp_rsp test_dev_comp_expected = {
+	.test_id = 5,
+	.rsp = &test_dev_comp_rsp
 };
 
 static struct msg_data test_dev_comp_req = {
@@ -955,11 +997,101 @@ static bool ele_idx_getter(struct l_dbus *dbus,
 	return true;
 }
 
+static bool location_getter(struct l_dbus *dbus,
+				struct l_dbus_message *message,
+				struct l_dbus_message_builder *builder,
+				void *user_data)
+{
+	struct meshcfg_el *ele = user_data;
+
+	l_dbus_message_builder_append_basic(builder, 'q', &ele->location);
+
+	return true;
+}
+
+static bool find_model(uint8_t *buf, uint32_t len, uint8_t *mod, uint8_t sz)
+{
+	bool found = false;
+
+	while (len >= sz) {
+		if (!memcmp(buf, mod, sz)) {
+			/* Disallow duplicates */
+			if (found)
+				return false;
+
+			found = true;
+		}
+
+		buf += sz;
+		len -= sz;
+	}
+
+	return found;
+}
+
+static bool check_device_composition(struct msg_data *rsp, uint32_t len,
+								uint8_t *data)
+{
+	uint32_t cnt;
+
+	if (len != rsp->len)
+		return false;
+
+	if (!memcmp(data, rsp->data, len))
+		return true;
+
+	/* Allow for a different ordering of model IDs */
+
+	/* First, check that the fixed length data matches */
+	if (memcmp(data, rsp->data, 12))
+		return false;
+
+	cnt = 12;
+	data += 12;
+
+	while (cnt < len) {
+		uint8_t s, v, i;
+
+		if ((len - cnt) < 4)
+			return false;
+
+		/* Check element index, location and model count */
+		if (memcmp(data, rsp->data + cnt, 4))
+			return false;
+
+		s = data[2];
+		v = data[3];
+
+		if ((cnt + s * 2 + v * 4) > len)
+			return false;
+
+		data += 4;
+		cnt += 4;
+
+		for (i = 0; i < s; i++) {
+			if (!find_model(&rsp->data[cnt], s * 2, data, 2))
+				return false;
+			data += 2;
+		}
+
+		cnt += s * 2;
+
+		for (i = 0; i < v; i++) {
+			if (!find_model(&rsp->data[cnt], v * 4, data, 4))
+				return false;
+			data += 4;
+		}
+
+		cnt += v * 4;
+	}
+
+	return true;
+}
+
 static struct l_dbus_message *dev_msg_recv_call(struct l_dbus *dbus,
 						struct l_dbus_message *msg,
 						void *user_data)
 {
-	struct msg_data *rsp;
 	struct l_dbus_message_iter iter;
 	uint16_t src, idx;
 	uint8_t *data;
@@ -983,7 +1115,7 @@ static struct l_dbus_message *dev_msg_recv_call(struct l_dbus *dbus,
 		uint32_t i;
 
 		for (i = 0; i < n; i++)
-			printf("%x ", data[i]);
+			printf("%02x ", data[i]);
 		printf("\n");
 	}
 
@@ -999,9 +1131,24 @@ static struct l_dbus_message *dev_msg_recv_call(struct l_dbus *dbus,
 			l_tester_pre_setup_failed(tester);
 		}
 	} else {
-		rsp = l_tester_get_data(tester);
+		struct exp_rsp *exp = l_tester_get_data(tester);
+		bool res = false;
+
+		if (exp && exp->rsp) {
+			if (exp->test_id == 5)
+				/* Check device composition */
+				res = check_device_composition(exp->rsp, n,
+									data);
+			else {
+				struct msg_data *rsp = exp->rsp;
+
+				if (n == rsp->len &&
+						!memcmp(data, rsp->data, n))
+					res = true;
+			}
+		}
 
-		if (rsp && rsp->len == n && !memcmp(data, rsp->data, n))
+		if (res)
 			l_idle_oneshot(test_success, NULL, NULL);
 		else
 			l_idle_oneshot(test_fail, NULL, NULL);
@@ -1019,7 +1166,8 @@ static void setup_ele_iface(struct l_dbus_interface *iface)
 							vmod_getter, NULL);
 	l_dbus_interface_property(iface, "Models", 0, "a(qa{sv})", mod_getter,
 									NULL);
-
+	l_dbus_interface_property(iface, "Location", 0, "q", location_getter,
+									NULL);
 	/* Methods */
 	l_dbus_interface_method(iface, "DevKeyMessageReceived", 0,
 				dev_msg_recv_call, "", "qbqay", "source",
@@ -1411,23 +1559,23 @@ int main(int argc, char *argv[])
 
 	l_tester_add_full(tester, "Config AppKey Add: Success",
 			&test_add_appkey, init_test, create_appkey, add_appkey,
-				NULL, NULL, 2, &test_add_appkey_rsp, NULL);
+				NULL, NULL, 2, &test_add_appkey_expected, NULL);
 
 	tester_add_with_response("Config Default TTL Set: Success",
 					&test_set_ttl_req, send_cfg_msg,
-							&test_set_ttl_rsp);
+						&test_set_ttl_expected);
 
 	tester_add_with_response("Config Get Device Composition: Success",
 					&test_dev_comp_req, send_cfg_msg,
-							&test_dev_comp_rsp);
+						&test_dev_comp_expected);
 
 	tester_add_with_response("Config Bind: Success",
 					&test_bind_req, send_cfg_msg,
-							&test_bind_rsp);
+						&test_bind_expected);
 
 	tester_add_with_response("Config Bind: Error Invalid Model",
 					&test_bind_inv_mod_req, send_cfg_msg,
-							&test_bind_inv_mod_rsp);
+						&test_bind_inv_mod_expected);
 
 	l_tester_start(tester, done_callback);
 
-- 
2.39.1

