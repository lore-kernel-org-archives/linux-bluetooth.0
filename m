Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279A0C43381
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 20:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F14D664F69
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 20:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhCDUZ5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Mar 2021 15:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhCDUZm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Mar 2021 15:25:42 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD87DC06175F
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 Mar 2021 12:25:01 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id k1so19897373qtp.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Mar 2021 12:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=BiFY7vOowpTr5WqeUR2ASOa9EfK24Kg3HZihoCznWvQ=;
        b=R/R78kSxKxfwlhF7gBfJpxFXY+d/qTbfj1TO0HocePBQI/H7LEmbDDUWrSN5IjX3Ss
         Ba+uavHQPbxj1Wsxs/L0UjS5tmbCgcaA8JS+WEh6mukLJ02YY4hPC3/6+aAPsYMWgbmy
         YrPcTJ8wzcLH2Yy85iYcieml6IXTF5H1iQwDNTPaRiX6zoMQ0W6Fv9xoliTHXRTSPMOI
         1tUoiK06UAxA6bUnbyDYHlkAsJpSQKhQo4EOXBKBAiuPF44B4ruDIXv8wFwjDyk0XYV7
         p6PqqHdHajyNb5cw81MKSLCSTYPkLPStNXznPoDl+KYIOjwf488tk/Jk9Tc6lAvFxPbz
         lSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BiFY7vOowpTr5WqeUR2ASOa9EfK24Kg3HZihoCznWvQ=;
        b=s0Pg/4pqwA9McnGk8WrOjomuVgHMeBie0GsrVto9WNOMxRLpDOOgDN1PVumw8Nn222
         xBLvspszLjtT2u48Bqj19bMB5QO0CaYTe4XtHeK0LhVXfz7FTFgrHd6eq2L1/N63/N74
         My9IL6APMMTiqDo0IH3M7Isz8S7Yq4wBn8km5x6zWgwvkRkXlqVpREx/4fmbTn3cFn8C
         1Cjo4UucucMO98EHHMsVJEiw45MsyU/Ekfmt98jfbV3KQZCrA36Gq8NoIlT+NfSXoyJP
         pBJTcbuW+SBRVW1JHbibTB0evNsla7oF7hU+pa8K9OUdlBPHfQ0ReHcLT8Nz/dsK/E1c
         AEIw==
X-Gm-Message-State: AOAM532bbH7ALXNypeKXDfNY/pfo1F1UMF98gEX8EM2vei+6ngzBUYel
        ZkLnH3ncyLMOt8NpAwzwbflpKe3ZHRXGo4cH+IG5apaM4uDGSQ18+PfDuo96cYj9PcHV6juXObi
        jcQ1VfdqLgw4Kl560m4ctf81djr5C4k8gJSfYTlcKbZ248yEA2ukl2+vt7fZEgdo/YeL0anOOG3
        rzrG+8aEI9YpFgI+8U
X-Google-Smtp-Source: ABdhPJwzZjGNAxyGpLNSyFMPlcKQ+lWgHu8zOb83ehCliwjgjbbFK7557UdqtseAoZU6HeNbnrVFVSZF6942rVAN92w/
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:a873:4408:c731:b8f2])
 (user=danielwinkler job=sendgmr) by 2002:a0c:b617:: with SMTP id
 f23mr5806060qve.44.1614889500871; Thu, 04 Mar 2021 12:25:00 -0800 (PST)
Date:   Thu,  4 Mar 2021 12:24:50 -0800
In-Reply-To: <20210304202452.1998022-1-danielwinkler@google.com>
Message-Id: <20210304122005.Bluez.v2.1.I1411482bfff45aecdec1bc8c895fc7148ee3f50c@changeid>
Mime-Version: 1.0
References: <20210304202452.1998022-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [Bluez PATCH v2 1/3] advertising: Generate advertising data earlier
 in pipeline
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Alain Michaud <alainm@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change moves the advertising data generation to the beginning of
the registration pipeline. This is necessary for the following patch,
which will need to know whether the scan response data is existent so
that the parameter request can be populated correctly.

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>

---

Changes in v2: None

 src/advertising.c | 79 +++++++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 37 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 15a343e52..f3dc357a1 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -80,6 +80,10 @@ struct btd_adv_client {
 	uint32_t flags;
 	struct bt_ad *data;
 	struct bt_ad *scan;
+	uint8_t *adv_data;
+	uint8_t *scan_rsp;
+	size_t adv_data_len;
+	size_t scan_rsp_len;
 	uint8_t instance;
 	uint32_t min_interval;
 	uint32_t max_interval;
@@ -141,6 +145,16 @@ static void client_free(void *data)
 	bt_ad_unref(client->data);
 	bt_ad_unref(client->scan);
 
+	if (client->adv_data) {
+		free(client->adv_data);
+		client->adv_data = NULL;
+	}
+
+	if (client->scan_rsp) {
+		free(client->scan_rsp);
+		client->scan_rsp = NULL;
+	}
+
 	g_dbus_proxy_unref(client->proxy);
 
 	if (client->owner)
@@ -915,6 +929,22 @@ static int refresh_extended_adv(struct btd_adv_client *client,
 		flags |= MGMT_ADV_PARAM_TX_POWER;
 	}
 
+	client->adv_data = generate_adv_data(client, &flags,
+						&client->adv_data_len);
+	if (!client->adv_data ||
+		(client->adv_data_len > calc_max_adv_len(client, flags))) {
+		error("Advertising data too long or couldn't be generated.");
+		return -EINVAL;
+	}
+
+	client->scan_rsp = generate_scan_rsp(client, &flags,
+						&client->scan_rsp_len);
+	if (!client->scan_rsp && client->scan_rsp_len) {
+		error("Scan data couldn't be generated.");
+		free(client->adv_data);
+		return -EINVAL;
+	}
+
 	cp.flags = htobl(flags);
 
 	mgmt_ret = mgmt_send(client->manager->mgmt, MGMT_OP_ADD_EXT_ADV_PARAMS,
@@ -1222,11 +1252,6 @@ static void add_adv_params_callback(uint8_t status, uint16_t length,
 	const struct mgmt_rp_add_ext_adv_params *rp = param;
 	struct mgmt_cp_add_ext_adv_data *cp = NULL;
 	uint8_t param_len;
-	uint8_t *adv_data = NULL;
-	size_t adv_data_len;
-	uint8_t *scan_rsp = NULL;
-	size_t scan_rsp_len = -1;
-	uint32_t flags = 0;
 	unsigned int mgmt_ret;
 	dbus_int16_t tx_power;
 
@@ -1248,23 +1273,8 @@ static void add_adv_params_callback(uint8_t status, uint16_t length,
 
 	client->instance = rp->instance;
 
-	flags = get_adv_flags(client);
-
-	adv_data = generate_adv_data(client, &flags, &adv_data_len);
-	if (!adv_data || (adv_data_len > rp->max_adv_data_len)) {
-		error("Advertising data too long or couldn't be generated.");
-		goto fail;
-	}
-
-	scan_rsp = generate_scan_rsp(client, &flags, &scan_rsp_len);
-	if ((!scan_rsp && scan_rsp_len) ||
-			scan_rsp_len > rp->max_scan_rsp_len) {
-		error("Scan data couldn't be generated.");
-		goto fail;
-	}
-
-	param_len = sizeof(struct mgmt_cp_add_advertising) + adv_data_len +
-							scan_rsp_len;
+	param_len = sizeof(struct mgmt_cp_add_advertising) +
+			client->adv_data_len + client->scan_rsp_len;
 
 	cp = malloc0(param_len);
 	if (!cp) {
@@ -1273,15 +1283,11 @@ static void add_adv_params_callback(uint8_t status, uint16_t length,
 	}
 
 	cp->instance = client->instance;
-	cp->adv_data_len = adv_data_len;
-	cp->scan_rsp_len = scan_rsp_len;
-	memcpy(cp->data, adv_data, adv_data_len);
-	memcpy(cp->data + adv_data_len, scan_rsp, scan_rsp_len);
-
-	free(adv_data);
-	free(scan_rsp);
-	adv_data = NULL;
-	scan_rsp = NULL;
+	cp->adv_data_len = client->adv_data_len;
+	cp->scan_rsp_len = client->scan_rsp_len;
+	memcpy(cp->data, client->adv_data, client->adv_data_len);
+	memcpy(cp->data + client->adv_data_len, client->scan_rsp,
+			client->scan_rsp_len);
 
 	/* Submit request to update instance data */
 	mgmt_ret = mgmt_send(client->manager->mgmt, MGMT_OP_ADD_EXT_ADV_DATA,
@@ -1305,12 +1311,6 @@ static void add_adv_params_callback(uint8_t status, uint16_t length,
 	return;
 
 fail:
-	if (adv_data)
-		free(adv_data);
-
-	if (scan_rsp)
-		free(scan_rsp);
-
 	if (cp)
 		free(cp);
 
@@ -1454,6 +1454,11 @@ static struct btd_adv_client *client_create(struct btd_adv_manager *manager,
 	if (!client->scan)
 		goto fail;
 
+	client->adv_data = NULL;
+	client->scan_rsp = NULL;
+	client->adv_data_len = 0;
+	client->scan_rsp_len = 0;
+
 	client->manager = manager;
 	client->appearance = UINT16_MAX;
 	client->tx_power = ADV_TX_POWER_NO_PREFERENCE;
-- 
2.30.1.766.gb4fecdf3b7-goog

