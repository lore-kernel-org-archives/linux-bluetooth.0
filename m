Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6336C433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 00:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B33A4613EB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 May 2021 00:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243603AbhEMAjA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 May 2021 20:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236080AbhEMAhV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 May 2021 20:37:21 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B7EC06138F
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 17:34:30 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id e19so1849891pfv.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 17:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R3QOL7X4yORGEcAw8agHT1SpTHlAIWdbVOlcBkZUfAg=;
        b=ck8polTbRxB4CZppbZbWMVfVSEchLrGf5ajA6qg0/gPvsDtC8GijoQ1+j3ZN1BzRdt
         41ek/nneBJKorKz2gy3eoMmE0jLbCLYBJfllLs9bNuVAXM9KHAnRQ/bzRY1i+Pv9G1Dx
         jlAz1N90EES6xDnJcTTyN0XZwKyhmWIiVnQjxMGKVxxPnFr3mkdGV7/JcMJnnFQG2fii
         21Vr8qWosVxgSFOQy7TkYLvctD2hr7uQWoaxpAy+XgSUQWNPeYQNyZaHp9DLoUpuYpr1
         N72IE5fkDA5h2okj8Qu9l6G66vU+Wp2hrPVNSUI/7LCC+MDuNs1cBotiMaWqU4YFuF9P
         LQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R3QOL7X4yORGEcAw8agHT1SpTHlAIWdbVOlcBkZUfAg=;
        b=rzA/PNyHF5UOQWGizOuKCgG13RDNKQx71pRajwcfmNGNIlMGy6gvLZtdD74Kt/auIU
         gODdYKp9XYFb8gSS+8XKFuS1/8Mlg1PLN/Ud3guwiL1urR/xntTHQqVlX0bplCJMyELJ
         IDJ/bkhFayRRidMjD6MgAFj6h2O38TJssW59xCPDPs+yuuHRhBv/gLqBMzRJPycf/1Ug
         Sm/OHxaohmxJ8KcCSuHAUWUSxaXZs7qc0AI7hgrbdHJbVBxR9SUZr36XSWCXrD1d6RM3
         bRXr7o8ceKIxsjUKXXUqZ9NBTlkwf1mQyYx1Pj/52Vc77j2XHkbmy6pCCqgCALuJruCR
         WwnQ==
X-Gm-Message-State: AOAM530ibAHwHWiA0JBVoDcX5O+7gY8sUnr1Jyi9bzHDGUkwJkPogeQe
        xuJAIetfE6rA9Tu5ZiJItGRqTPNpz14=
X-Google-Smtp-Source: ABdhPJzPWBrn4afam4MpdEqwjHqkTktg7/moE7BnuWll81hsDzAVqhmtrhTCrHXkDIy1Fp8WtKOWqw==
X-Received: by 2002:a63:6ec1:: with SMTP id j184mr38474256pgc.364.1620866070078;
        Wed, 12 May 2021 17:34:30 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z23sm700185pjh.44.2021.05.12.17.34.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 17:34:29 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] client/advertising: Add support for setting min/max intervals
Date:   Wed, 12 May 2021 17:34:28 -0700
Message-Id: <20210513003428.2576827-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for setting MinInterval/MaxInterval.
---
 client/advertising.c | 62 ++++++++++++++++++++++++++++++++++++++++++++
 client/advertising.h |  1 +
 client/main.c        | 45 ++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+)

diff --git a/client/advertising.c b/client/advertising.c
index c1a00502e..3bf12fe87 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -52,6 +52,8 @@ static struct ad {
 	char *type;
 	char *local_name;
 	char *secondary;
+	uint32_t min_interval;
+	uint32_t max_interval;
 	uint16_t local_appearance;
 	uint16_t duration;
 	uint16_t timeout;
@@ -182,6 +184,10 @@ static void print_ad(void)
 
 	if (ad.timeout)
 		bt_shell_printf("Timeout: %u sec\n", ad.timeout);
+
+	if (ad.min_interval)
+		bt_shell_printf("Interval: %u-%u msec\n", ad.min_interval,
+					ad.max_interval);
 }
 
 static void register_reply(DBusMessage *message, void *user_data)
@@ -445,6 +451,36 @@ static gboolean get_secondary(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean min_interval_exits(const GDBusPropertyTable *property,
+							void *data)
+{
+	return ad.min_interval;
+}
+
+static gboolean get_min_interval(const GDBusPropertyTable *property,
+				DBusMessageIter *iter, void *user_data)
+{
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32,
+						&ad.min_interval);
+
+	return TRUE;
+}
+
+static gboolean max_interval_exits(const GDBusPropertyTable *property,
+							void *data)
+{
+	return ad.max_interval;
+}
+
+static gboolean get_max_interval(const GDBusPropertyTable *property,
+				DBusMessageIter *iter, void *user_data)
+{
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32,
+						&ad.max_interval);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable ad_props[] = {
 	{ "Type", "s", get_type },
 	{ "ServiceUUIDs", "as", get_uuids, NULL, uuids_exists },
@@ -460,6 +496,8 @@ static const GDBusPropertyTable ad_props[] = {
 	{ "Appearance", "q", get_appearance, NULL, appearance_exits },
 	{ "Duration", "q", get_duration, NULL, duration_exits },
 	{ "Timeout", "q", get_timeout, NULL, timeout_exits },
+	{ "MinInterval", "u", get_min_interval, NULL, min_interval_exits },
+	{ "MaxInterval", "u", get_max_interval, NULL, max_interval_exits },
 	{ "SecondaryChannel", "s", get_secondary, NULL, secondary_exits },
 	{ }
 };
@@ -951,3 +989,27 @@ void ad_advertise_secondary(DBusConnection *conn, const char *value)
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
+
+void ad_advertise_interval(DBusConnection *conn, uint32_t *min, uint32_t *max)
+{
+	if (!min && !max) {
+		if (ad.min_interval && ad.max_interval)
+			bt_shell_printf("Interval: %u-%u msec\n",
+					ad.min_interval, ad.max_interval);
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
+	if (ad.min_interval != *min) {
+		ad.min_interval = *min;
+		g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
+							"MinInterval");
+	}
+
+	if (ad.max_interval != *max) {
+		ad.max_interval = *max;
+		g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
+							"MaxInterval");
+	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
diff --git a/client/advertising.h b/client/advertising.h
index 25e6aee99..472396efd 100644
--- a/client/advertising.h
+++ b/client/advertising.h
@@ -29,3 +29,4 @@ void ad_disable_data(DBusConnection *conn);
 void ad_advertise_discoverable(DBusConnection *conn, dbus_bool_t *value);
 void ad_advertise_discoverable_timeout(DBusConnection *conn, long int *value);
 void ad_advertise_secondary(DBusConnection *conn, const char *value);
+void ad_advertise_interval(DBusConnection *conn, uint32_t *min, uint32_t *max);
diff --git a/client/main.c b/client/main.c
index 1669d2c89..c1a62edb7 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2625,6 +2625,40 @@ static void cmd_advertise_secondary(int argc, char *argv[])
 	ad_advertise_secondary(dbus_conn, argv[1]);
 }
 
+static void cmd_advertise_interval(int argc, char *argv[])
+{
+	uint32_t min, max;
+	char *endptr = NULL;
+
+	if (argc < 2) {
+		ad_advertise_interval(dbus_conn, NULL, NULL);
+		return;
+	}
+
+	min = strtol(argv[1], &endptr, 0);
+	if (!endptr || *endptr != '\0' || min < 20 || min > 10485) {
+		bt_shell_printf("Invalid argument\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	max = min;
+
+	if (argc > 2) {
+		max = strtol(argv[1], &endptr, 0);
+		if (!endptr || *endptr != '\0' || max < 20 || max > 10485) {
+			bt_shell_printf("Invalid argument\n");
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
+	}
+
+	if (min > max) {
+		bt_shell_printf("Invalid argument: %u > %u\n", min, max);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	ad_advertise_interval(dbus_conn, &min, &max);
+}
+
 static void ad_clear_uuids(void)
 {
 	ad_disable_uuids(dbus_conn);
@@ -2683,6 +2717,14 @@ static void ad_clear_secondary(void)
 	ad_advertise_secondary(dbus_conn, value);
 }
 
+static void ad_clear_interval(void)
+{
+	uint32_t min = 0;
+	uint32_t max = 0;
+
+	ad_advertise_interval(dbus_conn, &min, &max);
+}
+
 static const struct clear_entry ad_clear[] = {
 	{ "uuids",		ad_clear_uuids },
 	{ "service",		ad_clear_service },
@@ -2694,6 +2736,7 @@ static const struct clear_entry ad_clear[] = {
 	{ "duration",		ad_clear_duration },
 	{ "timeout",		ad_clear_timeout },
 	{ "secondary",		ad_clear_secondary },
+	{ "interval",		ad_clear_interval },
 	{}
 };
 
@@ -2812,6 +2855,8 @@ static const struct bt_shell_menu advertise_menu = {
 			"Set/Get advertise timeout" },
 	{ "secondary", "[1M/2M/Coded]", cmd_advertise_secondary,
 			"Set/Get advertise secondary channel" },
+	{ "interval", "[min] [max] ", cmd_advertise_interval,
+			"Set/Get advertise interval range" },
 	{ "clear", "[uuids/service/manufacturer/config-name...]", cmd_ad_clear,
 			"Clear advertise config" },
 	{ } },
-- 
2.30.2

