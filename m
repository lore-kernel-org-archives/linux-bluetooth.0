Return-Path: <SRS0=cA0y=4I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346E8C5ACC4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Feb 2020 00:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31C4207FD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Feb 2020 00:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rBYl1C0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbgBTA2j (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Feb 2020 19:28:39 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35292 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbgBTA2j (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Feb 2020 19:28:39 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so806697plt.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Feb 2020 16:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Ns4Fu2uAcE2PjfhDsU29BteUAwP8E8zX8ihqevM9inI=;
        b=rBYl1C0qWV2WlIEltag+TPkDzK4+fw7XqoGtW+y+N51zXkshhAJDVWrQdLm9cB0PbX
         pSfsR6mFnYyvJH9401NrUgvIMS0gKl7v/00Yj5fVB8QsTDvriTVSnrD+xfPtPnGbDlsB
         tK7YLh6LeNTRyIKdDagj8YVbmHSaOjBAqUAv4PBF24CFD/y6DI0YkpfhVFzl2H3Extcl
         b7eKuRS/PZO6qdpa9LeBKapfjDCfjyS9y7Sw7zHKjmuo75kF8hDnta4tDpY9SVQTUWle
         5FVwHhKSvFbfzDPa7yeylhKjXYbrQIjRwlE6NoHM6ueQEagJwF9CWtwP39CDY5XraZPu
         OZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ns4Fu2uAcE2PjfhDsU29BteUAwP8E8zX8ihqevM9inI=;
        b=kzRm3VQncnxmVii9WBl2J/vER4L2FhavJMKQDBf17rJA6JvW1pnl/TR16/cBwR0Ela
         EvD9cE4GPSnUFmCN9ciVJY94mqbnOVBJFNbht8rLywZvX4yVzIICL/CgUhIvr/6KpsD/
         TtvgUGeh91zbIqVeYpqV1k7FElixU1ixOZm3t0kS6/JtU9amyzfZ3ZbUx0SNxAYXInMO
         tVcr4DYd3iztWrQxBFJrM0E8yNxI9um0Jzp6BjrykcwZFslCslSX4UjKbLKBhd0ndSwn
         hyFI9WhFsyMpyqsH2TfXjTmDi6W1Pm+RzjUKCksu8x2PKhJsnnwzgRavpNUHUvBEYeKj
         uWAg==
X-Gm-Message-State: APjAAAXc/dN0epfg1Zk+svfBPBeIE5ySJrYX4y325B8liK0w95xlEp5K
        3pwq/Wml/+blmeA1W881jRZEwXVVDPs=
X-Google-Smtp-Source: APXvYqzty42aysvU0hAp7Oyo+7zwEfIDrAb68YuMCxOyGpeAOT+dnwQjdzXhUII22YFiQKvvgHVWcQ==
X-Received: by 2002:a17:90a:db0f:: with SMTP id g15mr400203pjv.40.1582158517096;
        Wed, 19 Feb 2020 16:28:37 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id c68sm769213pfc.156.2020.02.19.16.28.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 16:28:36 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] adapter: Implement Pattern filter
Date:   Wed, 19 Feb 2020 16:28:34 -0800
Message-Id: <20200220002835.8929-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200220002835.8929-1-luiz.dentz@gmail.com>
References: <20200220002835.8929-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements the new Pattern filter as documented in the
adapter-api.txt.
---
 src/adapter.c | 92 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 76 insertions(+), 16 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 329c3ae0b..972d88772 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -174,6 +174,7 @@ struct conn_param {
 
 struct discovery_filter {
 	uint8_t type;
+	char *pattern;
 	uint16_t pathloss;
 	int16_t rssi;
 	GSList *uuids;
@@ -2423,6 +2424,22 @@ static bool parse_discoverable(DBusMessageIter *value,
 	return true;
 }
 
+static bool parse_pattern(DBusMessageIter *value,
+					struct discovery_filter *filter)
+{
+	const char *pattern;
+
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_STRING)
+		return false;
+
+	dbus_message_iter_get_basic(value, &pattern);
+
+	free(filter->pattern);
+	filter->pattern = strdup(pattern);
+
+	return true;
+}
+
 struct filter_parser {
 	const char *name;
 	bool (*func)(DBusMessageIter *iter, struct discovery_filter *filter);
@@ -2433,6 +2450,7 @@ struct filter_parser {
 	{ "Transport", parse_transport },
 	{ "DuplicateData", parse_duplicate_data },
 	{ "Discoverable", parse_discoverable },
+	{ "Pattern", parse_pattern },
 	{ }
 };
 
@@ -2473,6 +2491,7 @@ static bool parse_discovery_filter_dict(struct btd_adapter *adapter,
 	(*filter)->type = get_scan_type(adapter);
 	(*filter)->duplicate = false;
 	(*filter)->discoverable = false;
+	(*filter)->pattern = NULL;
 
 	dbus_message_iter_init(msg, &iter);
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY ||
@@ -2518,10 +2537,11 @@ static bool parse_discovery_filter_dict(struct btd_adapter *adapter,
 		goto invalid_args;
 
 	DBG("filtered discovery params: transport: %d rssi: %d pathloss: %d "
-		" duplicate data: %s discoverable %s", (*filter)->type,
-		(*filter)->rssi, (*filter)->pathloss,
+		" duplicate data: %s discoverable %s pattern %s",
+		(*filter)->type, (*filter)->rssi, (*filter)->pathloss,
 		(*filter)->duplicate ? "true" : "false",
-		(*filter)->discoverable ? "true" : "false");
+		(*filter)->discoverable ? "true" : "false",
+		(*filter)->pattern);
 
 	return true;
 
@@ -6146,6 +6166,52 @@ static void filter_duplicate_data(void *data, void *user_data)
 	*duplicate = client->discovery_filter->duplicate;
 }
 
+static bool device_is_discoverable(struct btd_adapter *adapter,
+					struct eir_data *eir, const char *addr,
+					uint8_t bdaddr_type)
+{
+	GSList *l;
+	bool discoverable;
+
+	if (bdaddr_type == BDADDR_BREDR || adapter->filtered_discovery)
+		discoverable = true;
+	else
+		discoverable = eir->flags & (EIR_LIM_DISC | EIR_GEN_DISC);
+
+	/*
+	 * Mark as not discoverable if no client has requested discovery and
+	 * report has not set any discoverable flags.
+	 */
+	if (!adapter->discovery_list && !discoverable)
+		return false;
+
+	/* Do a prefix match for both address and name if pattern is set */
+	for (l = adapter->discovery_list; l; l = g_slist_next(l)) {
+		struct watch_client *client = l->data;
+		struct discovery_filter *filter = client->discovery_filter;
+		size_t pattern_len;
+
+		if (!filter || !filter->pattern)
+			continue;
+
+		/* Reset discoverable if a client has a pattern filter */
+		discoverable = false;
+
+		pattern_len = strlen(filter->pattern);
+		if (!pattern_len)
+			return true;
+
+		if (!strncmp(filter->pattern, addr, pattern_len))
+			return true;
+
+		if (eir->name && !strncmp(filter->pattern, eir->name,
+							pattern_len))
+			return true;
+	}
+
+	return discoverable;
+}
+
 static void update_found_devices(struct btd_adapter *adapter,
 					const bdaddr_t *bdaddr,
 					uint8_t bdaddr_type, int8_t rssi,
@@ -6162,21 +6228,14 @@ static void update_found_devices(struct btd_adapter *adapter,
 	memset(&eir_data, 0, sizeof(eir_data));
 	eir_parse(&eir_data, data, data_len);
 
-	if (bdaddr_type == BDADDR_BREDR || adapter->filtered_discovery)
-		discoverable = true;
-	else
-		discoverable = eir_data.flags & (EIR_LIM_DISC | EIR_GEN_DISC);
-
 	ba2str(bdaddr, addr);
 
+	discoverable = device_is_discoverable(adapter, &eir_data, addr,
+							bdaddr_type);
+
 	dev = btd_adapter_find_device(adapter, bdaddr, bdaddr_type);
 	if (!dev) {
-		/*
-		 * If no client has requested discovery or the device is
-		 * not marked as discoverable, then do not create new
-		 * device objects.
-		 */
-		if (!adapter->discovery_list || !discoverable) {
+		if (!discoverable) {
 			eir_data_free(&eir_data);
 			return;
 		}
@@ -6219,8 +6278,9 @@ static void update_found_devices(struct btd_adapter *adapter,
 		return;
 	}
 
-	if (adapter->filtered_discovery &&
-	    !is_filter_match(adapter->discovery_list, &eir_data, rssi)) {
+	/* Don't continue if not discoverable or if filter don't match */
+	if (!discoverable || (adapter->filtered_discovery &&
+	    !is_filter_match(adapter->discovery_list, &eir_data, rssi))) {
 		eir_data_free(&eir_data);
 		return;
 	}
-- 
2.21.1

