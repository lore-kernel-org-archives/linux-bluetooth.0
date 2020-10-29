Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6A5C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 21:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 048B02087D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 21:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j2y3+G/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgJ2VX6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 17:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgJ2VX6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 17:23:58 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996BEC0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 14:23:57 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id r4so2993877pgl.20
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 14:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=UoIMXWRFpejcO05qLbJiVgVogYNdnHT7PedX9Ri9C5A=;
        b=j2y3+G/mhrlGfKKizsIDm+YkuYTK7xjxRFGcKUOQFycrJvedyPJSmzH4YrycS2+4nq
         0xF642tevRD29KBB2XNERKwvEWQDbosBluuDs2kXXosY/QNrM919CEdld4V6ubK0byti
         abFwVvDhRTONvay1uO0MM9VJ6TJGn3u85Gg83L/DjzRyRo3VFsMxjManAHIklBHD7QMz
         7opOuz+FcXsa+veyTG5ZhA/Mv9p94QMWv++j2HUYp2nE1J8I/UPdBuJwEnnZwaEpwJxz
         3r9U8NNDqroYfNNAf7ET83g6WuuLCLk6+eyiqt6vbWQDZytMMZd0m/sT6KuW1f0TAw83
         bvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UoIMXWRFpejcO05qLbJiVgVogYNdnHT7PedX9Ri9C5A=;
        b=M3fpsSqm0iNdFebbsJYNQVCh4Y8JFmCvBwsJJRFm/cz+aIa2CbR0ILpuwlz5N/ExYq
         OJk9h0OC34wJW6SM6UxRl9f41aBoEWAWGZ16E1vCZFg2MvUiHQN6vnqyOFRNhvfVjxkO
         S8iKwZdEuYNStv4hmHpc28PKimYmsj6IiTsCmc8HAQrRRI9kH/uktnJBFY3JNV2hf5kM
         lY+swr5wlLS+xDIdQs6KAZsrBNizK5e3SufqprsjzXaTNNXVf4c6e8sYRRad7shdlP43
         cyzz63+wGbqCA/e7gWBNMhWQqixfSbD5hRz8JrS8Sjq0BqNwfgAzN46prMdKNU8UJL8I
         Vd8w==
X-Gm-Message-State: AOAM530frerHSfJwXpmeJU7zYj+j4PTeZVWOxOM/NcV1EE0zqZ+tuzeh
        BTZY+36pKiJJ9iC2TiUS3Ygo2OtRhW75YEq7qOYc
X-Google-Smtp-Source: ABdhPJwih2HQ0TOxFjxNzlqdt66zpMiq4i92b4ybDzC+RY61/096iUUunMw/wpgPveaxhGZUjlKmzbYPhKseayqN6pbN
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:aa7:9255:0:b029:158:ca2e:3f33 with
 SMTP id 21-20020aa792550000b0290158ca2e3f33mr6362844pfp.59.1604006637132;
 Thu, 29 Oct 2020 14:23:57 -0700 (PDT)
Date:   Thu, 29 Oct 2020 14:23:31 -0700
In-Reply-To: <20201029212336.3283410-1-danielwinkler@google.com>
Message-Id: <20201029141832.Bluez.v5.6.Ia49df7ccded97ceb4ff1d1b0decc49d03d088a84@changeid>
Mime-Version: 1.0
References: <20201029212336.3283410-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [Bluez PATCH v5 06/10] advertising: Use new mgmt interface for
 advertising add
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.von.dentz@intel.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch allows bluetoothd to use the new extended advertising add
mgmt interface if it is available. The new interface will be used by
default, as it allows the client to set advertising intervals, and tx
power if the controller and kernel support extended advertising.

Each new registered advertisement will submit two requests to kernel;
the first sets the advertising parameters for the advertising instance,
and the second sets the advertising data and scan response for the
instance.

The parameters MGMT request will return the tx power selected by the
controller (if applicable), which is propagated to the client via a dbus
Set method.

Note: This patch also fixes a small bug in the packet monitor, where the
tx power value 0xff is considered as "Host has no preference". However,
the spec states this value to be 0x7f. It is corrected in this patch

This change has been tested extensively on Hatch (extended advertising)
and Kukui (no extended advertising) chromebooks. Manual tests do the
following:
- Configure advertisement with custom intervals, tx power with valid and
  invalid values and combinations
- Ensure that with valid parameters, they are propagated and set in hci
  requests. With invalid parameters, ensure that the registration fails.

Automatic tests verify 25 advertising usage scenarios involving single
and multi-advertising registration, over-registration, parameter
validation, etc. These tests don't test new intervals and tx power, but
validate that the new MGMT interface does not regress compatibility in
these 25 scenarios.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---

Changes in v5: None
Changes in v4:
- Moved optional params into flags field
- Use returned max data length in adv data length check

Changes in v3:
- Added selected tx power to MGMT params response

Changes in v2:
- Cleaned fail path in add_adv_params_callback

 lib/mgmt.h        |  32 +++++++
 monitor/packet.c  |   4 +-
 src/advertising.c | 223 ++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 242 insertions(+), 17 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 6aa0f5f88..7ab4fb797 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -503,6 +503,10 @@ struct mgmt_rp_add_advertising {
 #define MGMT_ADV_FLAG_SEC_1M		(1 << 7)
 #define MGMT_ADV_FLAG_SEC_2M		(1 << 8)
 #define MGMT_ADV_FLAG_SEC_CODED		(1 << 9)
+#define MGMT_ADV_PARAM_DURATION		(1 << 12)
+#define MGMT_ADV_PARAM_TIMEOUT		(1 << 13)
+#define MGMT_ADV_PARAM_INTERVALS	(1 << 14)
+#define MGMT_ADV_PARAM_TX_POWER		(1 << 15)
 
 #define MGMT_OP_REMOVE_ADVERTISING	0x003F
 struct mgmt_cp_remove_advertising {
@@ -700,6 +704,34 @@ struct mgmt_rp_remove_adv_monitor {
 	uint16_t monitor_handle;
 } __packed;
 
+#define MGMT_OP_ADD_EXT_ADV_PARAMS		0x0054
+struct mgmt_cp_add_ext_adv_params {
+	uint8_t		instance;
+	uint32_t	flags;
+	uint16_t	duration;
+	uint16_t	timeout;
+	uint32_t	min_interval;
+	uint32_t	max_interval;
+	int8_t		tx_power;
+} __packed;
+struct mgmt_rp_add_ext_adv_params {
+	uint8_t	instance;
+	int8_t	tx_power;
+	uint8_t	max_adv_data_len;
+	uint8_t	max_scan_rsp_len;
+} __packed;
+
+#define MGMT_OP_ADD_EXT_ADV_DATA		0x0055
+struct mgmt_cp_add_ext_adv_data {
+	uint8_t	instance;
+	uint8_t	adv_data_len;
+	uint8_t	scan_rsp_len;
+	uint8_t	data[0];
+} __packed;
+struct mgmt_rp_add_ext_adv_data {
+	uint8_t	instance;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
diff --git a/monitor/packet.c b/monitor/packet.c
index d83552f74..615c180f8 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -6979,8 +6979,8 @@ static void le_set_ext_adv_params_cmd(const void *data, uint8_t size)
 	print_peer_addr_type("Peer address type", cmd->peer_addr_type);
 	print_addr("Peer address", cmd->peer_addr, cmd->peer_addr_type);
 	print_adv_filter_policy("Filter policy", cmd->filter_policy);
-	if (cmd->tx_power == 0xff)
-		print_field("TX power: Host has no preference (0xff)");
+	if (cmd->tx_power == 0x7f)
+		print_field("TX power: Host has no preference (0x7f)");
 	else
 		print_power_level(cmd->tx_power, NULL);
 
diff --git a/src/advertising.c b/src/advertising.c
index 25d8ba770..428cd9562 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -82,6 +82,7 @@ struct btd_adv_client {
 	uint32_t min_interval;
 	uint32_t max_interval;
 	int8_t tx_power;
+	mgmt_request_func_t refresh_done_func;
 };
 
 struct dbus_obj_match {
@@ -788,19 +789,9 @@ static uint8_t *generate_scan_rsp(struct btd_adv_client *client,
 	return bt_ad_generate(client->scan, len);
 }
 
-static int refresh_adv(struct btd_adv_client *client, mgmt_request_func_t func,
-						unsigned int *mgmt_id)
+static int get_adv_flags(struct btd_adv_client *client)
 {
-	struct mgmt_cp_add_advertising *cp;
-	uint8_t param_len;
-	uint8_t *adv_data;
-	size_t adv_data_len;
-	uint8_t *scan_rsp;
-	size_t scan_rsp_len = -1;
 	uint32_t flags = 0;
-	unsigned int mgmt_ret;
-
-	DBG("Refreshing advertisement: %s", client->path);
 
 	if (client->type == AD_TYPE_PERIPHERAL) {
 		flags = MGMT_ADV_FLAG_CONNECTABLE;
@@ -812,6 +803,26 @@ static int refresh_adv(struct btd_adv_client *client, mgmt_request_func_t func,
 
 	flags |= client->flags;
 
+	return flags;
+}
+
+static int refresh_legacy_adv(struct btd_adv_client *client,
+				mgmt_request_func_t func,
+				unsigned int *mgmt_id)
+{
+	struct mgmt_cp_add_advertising *cp;
+	uint8_t param_len;
+	uint8_t *adv_data;
+	size_t adv_data_len;
+	uint8_t *scan_rsp;
+	size_t scan_rsp_len = -1;
+	uint32_t flags = 0;
+	unsigned int mgmt_ret;
+
+	DBG("Refreshing advertisement: %s", client->path);
+
+	flags = get_adv_flags(client);
+
 	adv_data = generate_adv_data(client, &flags, &adv_data_len);
 	if (!adv_data || (adv_data_len > calc_max_adv_len(client, flags))) {
 		error("Advertising data too long or couldn't be generated.");
@@ -864,6 +875,75 @@ static int refresh_adv(struct btd_adv_client *client, mgmt_request_func_t func,
 	return 0;
 }
 
+static void add_adv_params_callback(uint8_t status, uint16_t length,
+				    const void *param, void *user_data);
+
+static int refresh_extended_adv(struct btd_adv_client *client,
+				mgmt_request_func_t func, unsigned int *mgmt_id)
+{
+	struct mgmt_cp_add_ext_adv_params cp;
+	uint32_t flags = 0;
+	uint16_t included_params = 0;
+	unsigned int mgmt_ret = 0;
+
+	DBG("Refreshing advertisement parameters: %s", client->path);
+
+	flags = get_adv_flags(client);
+
+	memset(&cp, 0, sizeof(cp));
+	cp.instance = client->instance;
+
+	/* Not all advertising instances will use all possible parameters. The
+	 * included_params bit field tells the kernel which parameters are
+	 * relevant, and sensible defaults will be used for the rest
+	 */
+
+	if (client->duration) {
+		cp.duration = client->duration;
+		flags |= MGMT_ADV_PARAM_DURATION;
+	}
+
+	if (client->min_interval && client->max_interval) {
+		cp.min_interval = client->min_interval;
+		cp.max_interval = client->max_interval;
+		flags |= MGMT_ADV_PARAM_INTERVALS;
+	}
+
+	if (client->tx_power != ADV_TX_POWER_NO_PREFERENCE) {
+		cp.tx_power = client->tx_power;
+		flags |= MGMT_ADV_PARAM_TX_POWER;
+	}
+
+	cp.flags = htobl(flags);
+
+	mgmt_ret = mgmt_send(client->manager->mgmt, MGMT_OP_ADD_EXT_ADV_PARAMS,
+			client->manager->mgmt_index, sizeof(cp), &cp,
+			add_adv_params_callback, client, NULL);
+
+	if (!mgmt_ret) {
+		error("Failed to request extended advertising parameters");
+		return -EINVAL;
+	}
+
+	/* Store callback, called after we set advertising data */
+	client->refresh_done_func = func;
+
+	if (mgmt_id)
+		*mgmt_id = mgmt_ret;
+
+
+	return 0;
+}
+
+static int refresh_advertisement(struct btd_adv_client *client,
+			mgmt_request_func_t func, unsigned int *mgmt_id)
+{
+	if (client->manager->extended_add_cmds)
+		return refresh_extended_adv(client, func, mgmt_id);
+
+	return refresh_legacy_adv(client, func, mgmt_id);
+}
+
 static gboolean client_discoverable_timeout(void *user_data)
 {
 	struct btd_adv_client *client = user_data;
@@ -874,7 +954,7 @@ static gboolean client_discoverable_timeout(void *user_data)
 
 	bt_ad_clear_flags(client->data);
 
-	refresh_adv(client, NULL, NULL);
+	refresh_advertisement(client, NULL, NULL);
 
 	return FALSE;
 }
@@ -1070,7 +1150,8 @@ static void properties_changed(GDBusProxy *proxy, const char *name,
 			continue;
 
 		if (parser->func(iter, client)) {
-			refresh_adv(client, NULL, NULL);
+			refresh_advertisement(client, NULL, NULL);
+
 			break;
 		}
 	}
@@ -1133,6 +1214,112 @@ done:
 	add_client_complete(client, status);
 }
 
+static void add_adv_params_callback(uint8_t status, uint16_t length,
+					  const void *param, void *user_data)
+{
+	struct btd_adv_client *client = user_data;
+	const struct mgmt_rp_add_ext_adv_params *rp = param;
+	struct mgmt_cp_add_ext_adv_data *cp = NULL;
+	uint8_t param_len;
+	uint8_t *adv_data = NULL;
+	size_t adv_data_len;
+	uint8_t *scan_rsp = NULL;
+	size_t scan_rsp_len = -1;
+	uint32_t flags = 0;
+	unsigned int mgmt_ret;
+	dbus_int16_t tx_power;
+
+	if (status)
+		goto fail;
+
+	if (!param || length < sizeof(*rp)) {
+		status = MGMT_STATUS_FAILED;
+		goto fail;
+	}
+
+	DBG("Refreshing advertisement data: %s", client->path);
+
+	/* Update tx power held by client */
+	tx_power = rp->tx_power;
+	if (tx_power != ADV_TX_POWER_NO_PREFERENCE)
+		g_dbus_proxy_set_property_basic(client->proxy, "TxPower",
+				DBUS_TYPE_INT16, &tx_power, NULL, NULL, NULL);
+
+	client->instance = rp->instance;
+
+	flags = get_adv_flags(client);
+
+	adv_data = generate_adv_data(client, &flags, &adv_data_len);
+	if (!adv_data || (adv_data_len > rp->max_adv_data_len)) {
+		error("Advertising data too long or couldn't be generated.");
+		goto fail;
+	}
+
+	scan_rsp = generate_scan_rsp(client, &flags, &scan_rsp_len);
+	if ((!scan_rsp && scan_rsp_len) ||
+			scan_rsp_len > rp->max_scan_rsp_len) {
+		error("Scan data couldn't be generated.");
+		goto fail;
+	}
+
+	param_len = sizeof(struct mgmt_cp_add_advertising) + adv_data_len +
+							scan_rsp_len;
+
+	cp = malloc0(param_len);
+	if (!cp) {
+		error("Couldn't allocate for MGMT!");
+		goto fail;
+	}
+
+	cp->instance = client->instance;
+	cp->adv_data_len = adv_data_len;
+	cp->scan_rsp_len = scan_rsp_len;
+	memcpy(cp->data, adv_data, adv_data_len);
+	memcpy(cp->data + adv_data_len, scan_rsp, scan_rsp_len);
+
+	free(adv_data);
+	free(scan_rsp);
+	adv_data = NULL;
+	scan_rsp = NULL;
+
+	/* Submit request to update instance data */
+	mgmt_ret = mgmt_send(client->manager->mgmt, MGMT_OP_ADD_EXT_ADV_DATA,
+			     client->manager->mgmt_index, param_len, cp,
+			     client->refresh_done_func, client, NULL);
+
+	/* Clear the callback */
+	client->refresh_done_func = NULL;
+
+	if (!mgmt_ret) {
+		error("Failed to add Advertising Data");
+		goto fail;
+	}
+
+	if (client->add_adv_id)
+		client->add_adv_id = mgmt_ret;
+
+	free(cp);
+	cp = NULL;
+
+	return;
+
+fail:
+	if (adv_data)
+		free(adv_data);
+
+	if (scan_rsp)
+		free(scan_rsp);
+
+	if (cp)
+		free(cp);
+
+	if (!status)
+		status = -EINVAL;
+
+	/* Failure for any reason ends this advertising request */
+	add_client_complete(client, status);
+}
+
 static DBusMessage *parse_advertisement(struct btd_adv_client *client)
 {
 	struct adv_parser *parser;
@@ -1191,7 +1378,9 @@ static DBusMessage *parse_advertisement(struct btd_adv_client *client)
 		goto fail;
 	}
 
-	err = refresh_adv(client, add_adv_callback, &client->add_adv_id);
+	err = refresh_advertisement(client, add_adv_callback,
+					&client->add_adv_id);
+
 	if (!err)
 		return NULL;
 
@@ -1270,6 +1459,8 @@ static struct btd_adv_client *client_create(struct btd_adv_manager *manager,
 	client->min_interval = 0;
 	client->max_interval = 0;
 
+	client->refresh_done_func = NULL;
+
 	return client;
 
 fail:
@@ -1586,7 +1777,9 @@ void btd_adv_manager_destroy(struct btd_adv_manager *manager)
 
 static void manager_refresh(void *data, void *user_data)
 {
-	refresh_adv(data, user_data, NULL);
+	struct btd_adv_client *client = data;
+
+	refresh_advertisement(client, user_data, NULL);
 }
 
 void btd_adv_manager_refresh(struct btd_adv_manager *manager)
-- 
2.29.1.341.ge80a0c044ae-goog

