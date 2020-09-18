Return-Path: <SRS0=JXiH=C3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D8EC43464
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 22:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 892322311C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 22:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oYoSpkGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgIRWOT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Sep 2020 18:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgIRWOS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Sep 2020 18:14:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834AEC0613CE
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2020 15:14:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g189so6894050ybg.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2020 15:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=lYHat5yuNdgK2r35k9Snf3w/9eMRmnd0NP1xrlEbnvo=;
        b=oYoSpkGhE0TUavlGl2zH9aae4F1lri8CSJUEKwp71c8PDGPDl/t+XrkdBa24bfztmc
         tc8QfOa2oomXU8qXK7hRl0VBvMlshl8ecL7UOuIc4sRw5MgZe19wXcODs/6gcb8IbuN9
         YpJ4Un5XQd6HZdIZgHhHg0RZExxVK/WBlyf2aIs80PPGxxc3FkA8D4xM9F/K8pI+9oBa
         LL5hanKuq3kRq1g0dTOBn7lSifKJcatFGmr7v72wGYnPKwXCys9rBw69dufKIB9DJWRe
         UkrJgPRt+ABjCA7PJuDMatT4VK7FxKZNvLG26wf3Ue2tDupzHw3300s/J35qfg7uJHo1
         e8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lYHat5yuNdgK2r35k9Snf3w/9eMRmnd0NP1xrlEbnvo=;
        b=Zigpe/2OGDrXVLG8UUJ/QcGwr9r+GXLj2UULf8QN4ktbykdN9YLSBOW5G63zKdWkoW
         uSFiSFlS+h48YFJ2Int2PnUfRHQppHbNJLDS3b/z1tA0ZPd3+oKaCdx1OYyHA42GpHel
         e4+4P8cnZthPXJDOM5/FiV+vFZZgtzTrlLOVYR9lpja8Nk2yyNYfeuxhd3KGQ4mvw0p2
         KVWNh1To2GDRmjd1AmmYWDq07Kp+udawY730HvopTHoiMoOPV5FJxDpRWKQTdqdlQX2P
         FFC3n6FdE2fDpxMVGZrTrth6j8TjLxl2gQpsKV5Ww+4ubajBWdQE5HIgrRNcScWUaMdk
         57og==
X-Gm-Message-State: AOAM5315Bh0zJ/vGvPh1AL7Pi1Ze4imJ45U71egnZ08yrtIKSY7vmS+m
        THrSsqH41ujAsGcafQl5uK9WoTHtqUvTy7TgmLFL
X-Google-Smtp-Source: ABdhPJxii+sQzb+fxsjADPDNPTBUXwumo9s7Jla1s8hwgJvkKfMazNb4Y+QccbDAoIXgef1lpdkUgXY1iXUNN52/Rr/+
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a5b:b07:: with SMTP id
 z7mr5265825ybp.318.1600467257760; Fri, 18 Sep 2020 15:14:17 -0700 (PDT)
Date:   Fri, 18 Sep 2020 15:13:52 -0700
In-Reply-To: <20200918221357.3436905-1-danielwinkler@google.com>
Message-Id: <20200918151041.Bluez.v2.5.Ia49df7ccded97ceb4ff1d1b0decc49d03d088a84@changeid>
Mime-Version: 1.0
References: <20200918221357.3436905-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [Bluez PATCH v2 05/10] advertising: Use new mgmt interface for
 advertising add
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.von.dentz@intel.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
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

Changes in v2:
- Cleaned fail path in add_adv_params_callback

 lib/mgmt.h        |  31 +++++++
 src/advertising.c | 216 ++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 232 insertions(+), 15 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 46d894ae9..9874be004 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -713,6 +713,37 @@ struct mgmt_rp_remove_adv_monitor {
 	uint16_t monitor_handle;
 } __packed;
 
+#define MGMT_ADV_PARAM_DURATION		(1 << 0)
+#define MGMT_ADV_PARAM_TIMEOUT		(1 << 1)
+#define MGMT_ADV_PARAM_INTERVALS	(1 << 2)
+#define MGMT_ADV_PARAM_TX_POWER		(1 << 3)
+
+#define MGMT_OP_ADD_EXT_ADV_PARAMS		0x0054
+struct mgmt_cp_add_ext_adv_params {
+	uint8_t		instance;
+	uint32_t	flags;
+	uint16_t	params;
+	uint16_t	duration;
+	uint16_t	timeout;
+	uint32_t	min_interval;
+	uint32_t	max_interval;
+	int8_t		tx_power;
+} __packed;
+struct mgmt_rp_add_ext_adv_params {
+	uint8_t	instance;
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
diff --git a/src/advertising.c b/src/advertising.c
index 3c173fef0..cab0b79de 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -91,6 +91,7 @@ struct btd_adv_client {
 	uint32_t min_interval;
 	uint32_t max_interval;
 	int8_t tx_power;
+	mgmt_request_func_t refresh_done_func;
 };
 
 struct dbus_obj_match {
@@ -797,19 +798,9 @@ static uint8_t *generate_scan_rsp(struct btd_adv_client *client,
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
@@ -821,6 +812,26 @@ static int refresh_adv(struct btd_adv_client *client, mgmt_request_func_t func,
 
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
@@ -873,6 +884,76 @@ static int refresh_adv(struct btd_adv_client *client, mgmt_request_func_t func,
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
+	cp.flags = htobl(flags);
+	cp.instance = client->instance;
+
+	/* Not all advertising instances will use all possible parameters. The
+	 * included_params bit field tells the kernel which parameters are
+	 * relevant, and sensible defaults will be used for the rest
+	 */
+
+	if (client->duration) {
+		cp.duration = client->duration;
+		included_params |= MGMT_ADV_PARAM_DURATION;
+	}
+
+	if (client->min_interval && client->max_interval) {
+		cp.min_interval = client->min_interval;
+		cp.max_interval = client->max_interval;
+		included_params |= MGMT_ADV_PARAM_INTERVALS;
+	}
+
+	if (client->tx_power != ADV_TX_POWER_NO_PREFERENCE) {
+		cp.tx_power = client->tx_power;
+		included_params |= MGMT_ADV_PARAM_TX_POWER;
+	}
+
+	cp.params = included_params;
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
@@ -883,7 +964,7 @@ static gboolean client_discoverable_timeout(void *user_data)
 
 	bt_ad_clear_flags(client->data);
 
-	refresh_adv(client, NULL, NULL);
+	refresh_advertisement(client, NULL, NULL);
 
 	return FALSE;
 }
@@ -1057,7 +1138,8 @@ static void properties_changed(GDBusProxy *proxy, const char *name,
 			continue;
 
 		if (parser->func(iter, client)) {
-			refresh_adv(client, NULL, NULL);
+			refresh_advertisement(client, NULL, NULL);
+
 			break;
 		}
 	}
@@ -1120,6 +1202,104 @@ done:
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
+	client->instance = rp->instance;
+
+	flags = get_adv_flags(client);
+
+	adv_data = generate_adv_data(client, &flags, &adv_data_len);
+	if (!adv_data || (adv_data_len > calc_max_adv_len(client, flags))) {
+		error("Advertising data too long or couldn't be generated.");
+		goto fail;
+	}
+
+	scan_rsp = generate_scan_rsp(client, &flags, &scan_rsp_len);
+	if (!scan_rsp && scan_rsp_len) {
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
@@ -1178,7 +1358,9 @@ static DBusMessage *parse_advertisement(struct btd_adv_client *client)
 		goto fail;
 	}
 
-	err = refresh_adv(client, add_adv_callback, &client->add_adv_id);
+	err = refresh_advertisement(client, add_adv_callback,
+					&client->add_adv_id);
+
 	if (!err)
 		return NULL;
 
@@ -1257,6 +1439,8 @@ static struct btd_adv_client *client_create(struct btd_adv_manager *manager,
 	client->min_interval = 0;
 	client->max_interval = 0;
 
+	client->refresh_done_func = NULL;
+
 	return client;
 
 fail:
@@ -1573,7 +1757,9 @@ void btd_adv_manager_destroy(struct btd_adv_manager *manager)
 
 static void manager_refresh(void *data, void *user_data)
 {
-	refresh_adv(data, user_data, NULL);
+	struct btd_adv_client *client = data;
+
+	refresh_advertisement(client, user_data, NULL);
 }
 
 void btd_adv_manager_refresh(struct btd_adv_manager *manager)
-- 
2.28.0.681.g6f77f65b4e-goog

