Return-Path: <SRS0=rKdx=DI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BB4C4727E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 23:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B65292075F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 23:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TtDk6bkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733233AbgJAXCL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Oct 2020 19:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733131AbgJAXCL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Oct 2020 19:02:11 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB34C0613E2
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2020 16:02:10 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id z27so85614qtu.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2020 16:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=JbKHMmpdC2ZY4nvTCE9yb0aUDWovA3xn3RjvObFQxN4=;
        b=TtDk6bktqq6AHylZnK7Rsf3toIGoHG5q1Q8cnud5KcHHKc56uu7zRzYtwAI3xBv+df
         FTMRCMMuPIisYrN3fAtQS2z5mkVGfx+EqeXEXsn0ehA7i86MZItE6KoDFphNwmb4eFpt
         mTlPgwFHuhodKJM/0gT/jGZrGoGnVvxWRZG5XA6K/WdGkBNo2q/2vbCGAslpBf7EbMyb
         GlD0O0NpC5W3G+BBoHzYGDzOGabt9bcTLZ9ZUp90zjfsoCoTC60GmIHL5NJLWdFAinEv
         9DptGx3nYajGfnjKknZpXfWk7XLJ4IrgH72ZhXBasilfA6bmpeYyr9GB051BwEhmnoJg
         TMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JbKHMmpdC2ZY4nvTCE9yb0aUDWovA3xn3RjvObFQxN4=;
        b=iWpfKT+cskbR7tXDP+kUJ9H+0dO/Q1P0OFPCm6FYkr6iQUhEzqzX5i5h0YUE6mhedx
         OkTgPLNRYvlt84XgMPmoDq4ZE5/PqhrXlZfzrDXEhge4BIOXPLc4JTvFqNI7zGpdo6mP
         Yors4fqTTHNT/k4V9eyrIeRsdufUyF9ClKjViVPHHqfUlGkjtscYdk0o/ELpTzdeXCav
         LkZEK6OjCZi39hGXvu83Ef2WL7lMqugKQAMlUfDMiNapiTW0S0A0GLg9VJbDBEin+Vhy
         2FZD3xMLZX0LI0ssmjD/aPW/xNeyxVmEtCKWgAwkS5kQY8ZmgpJ7ii4AqQNd4XA84ojI
         jutA==
X-Gm-Message-State: AOAM533WvgyII3EfrlP1nj+bZvkTFiWSuWgH5EN5O9E/jom3wL3JMHpr
        3JkRMmpXE5eFQ4uKP4ktFPiiWwiO5ksr/3xBWDN8
X-Google-Smtp-Source: ABdhPJwKkkOeupy8dkLqwv0Po+BrBxpJDAaE3umhYccD7OqHahQhKGDLIvezlv3VHCxEiuB4ylP3R8cduqdJeRJ9p8dg
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a0c:e5cf:: with SMTP id
 u15mr10204486qvm.14.1601593329892; Thu, 01 Oct 2020 16:02:09 -0700 (PDT)
Date:   Thu,  1 Oct 2020 16:01:48 -0700
In-Reply-To: <20201001230152.2422908-1-danielwinkler@google.com>
Message-Id: <20201001155738.Bluez.v4.6.Ia49df7ccded97ceb4ff1d1b0decc49d03d088a84@changeid>
Mime-Version: 1.0
References: <20201001230152.2422908-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [Bluez PATCH v4 06/10] advertising: Use new mgmt interface for
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
index 3690a2aac..052964d42 100644
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
@@ -1048,7 +1128,8 @@ static void properties_changed(GDBusProxy *proxy, const char *name,
 			continue;
 
 		if (parser->func(iter, client)) {
-			refresh_adv(client, NULL, NULL);
+			refresh_advertisement(client, NULL, NULL);
+
 			break;
 		}
 	}
@@ -1111,6 +1192,112 @@ done:
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
@@ -1169,7 +1356,9 @@ static DBusMessage *parse_advertisement(struct btd_adv_client *client)
 		goto fail;
 	}
 
-	err = refresh_adv(client, add_adv_callback, &client->add_adv_id);
+	err = refresh_advertisement(client, add_adv_callback,
+					&client->add_adv_id);
+
 	if (!err)
 		return NULL;
 
@@ -1248,6 +1437,8 @@ static struct btd_adv_client *client_create(struct btd_adv_manager *manager,
 	client->min_interval = 0;
 	client->max_interval = 0;
 
+	client->refresh_done_func = NULL;
+
 	return client;
 
 fail:
@@ -1564,7 +1755,9 @@ void btd_adv_manager_destroy(struct btd_adv_manager *manager)
 
 static void manager_refresh(void *data, void *user_data)
 {
-	refresh_adv(data, user_data, NULL);
+	struct btd_adv_client *client = data;
+
+	refresh_advertisement(client, user_data, NULL);
 }
 
 void btd_adv_manager_refresh(struct btd_adv_manager *manager)
-- 
2.28.0.709.gb0816b6eb0-goog

