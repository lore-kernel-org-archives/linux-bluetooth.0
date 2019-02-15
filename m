Return-Path: <SRS0=5uBP=QW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73269C43381
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Feb 2019 14:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4210F2192D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Feb 2019 14:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/CyYr4U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730314AbfBOOXL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:23:11 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:42960 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729857AbfBOOXL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Feb 2019 09:23:11 -0500
Received: by mail-ed1-f54.google.com with SMTP id r15so8068519eds.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Feb 2019 06:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=QhfRqxYC6A3VZBz4LWs2M10bFSSs/3aDBnb+4cZUxTU=;
        b=W/CyYr4UdJKyxJI4pDm07mzE/gIOF8VrE/zxebkiDkr1JLeACiUPkjR/0pIwURFynL
         +1FhNHRJ3vYr37rryCf1KQWT6JnSJaLVy6Cz/w2z1IPDYuNfIACgrIw/sBMMgP97vUcD
         NwMiVXHmSSGK9KQX3plRZJSB2q1dxAfpBpeVZYqC8w+DhwLFO5LzYi6xxnDU/I4dUI7d
         Sh8IcyH0zqnEONlfilOJ0yUGA2SkJbn2p2MVtMo+Ml4P/HDuTpx6/5Np1JFfxbjCYoge
         kjetXSHHXdCX3Ta8Y8jqV2avh/wa3TD3SnsdGWNwoCwG/j5aBHQNHa+NTcCVdho7FeEP
         Jy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=QhfRqxYC6A3VZBz4LWs2M10bFSSs/3aDBnb+4cZUxTU=;
        b=l6EJHTB2dj4I7NBGpCZ8eV0OJeDThADm48YWbhw/bBKD1MrkpadomgtESKuLh1Uz8G
         wkIdKcX/NX7arMWAyZAcE2RxfWV4nBqxru2gOy/Fh4UTQ9kUQV+8vviFp5SpHZ9y9fh2
         +m/n88Ps+S9ZHcHGhRIGsIZgDkgaDSfrud28kp37ZYHS3Gm6cl5R2PFvIDv4ht5KDn83
         veiSCnJeZLPvldJJi59/lDb5+ZGg9uscuyfT0TCCm6hkjMqL1bUPXIlWw1AINYz7bjpt
         5PzS+XZn4xQfUU+QzKClc6xgt/yirCARhn26bNU/elFbTeFb04QHWLu2+W71oJ4aXsOY
         oLiw==
X-Gm-Message-State: AHQUAubLMc/eiiRMTDwZGW7ATN89kST5i7ZvKMYmcpi8IxL8bjQb4p1m
        78gijw/+uSo2z7Ps13Tm8mooX1ma
X-Google-Smtp-Source: AHgI3IZZlvuYjIYgig/MI/nTx3ZBTq2tOKH5mPFE/XBmrME6ZSMB+0mrkYNtxi7qPL1MKP0tkcWAjw==
X-Received: by 2002:a50:88a1:: with SMTP id d30mr7412922edd.207.1550240588783;
        Fri, 15 Feb 2019 06:23:08 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id v11sm1501333edy.49.2019.02.15.06.23.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 06:23:07 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] client: Add advertise.secondary command
Date:   Fri, 15 Feb 2019 16:23:01 +0200
Message-Id: <20190215142301.30909-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190215142301.30909-1-luiz.dentz@gmail.com>
References: <20190215142301.30909-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds advertose.secondary command which can be used to set a
secondary channel to advertise.
---
 client/advertising.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 client/advertising.h |  1 +
 client/main.c        | 20 ++++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/client/advertising.c b/client/advertising.c
index 960cdd62d..72f91b9a5 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -64,6 +64,7 @@ static struct ad {
 	bool registered;
 	char *type;
 	char *local_name;
+	char *secondary;
 	uint16_t local_appearance;
 	uint16_t duration;
 	uint16_t timeout;
@@ -441,6 +442,20 @@ static gboolean get_discoverable_timeout(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean secondary_exits(const GDBusPropertyTable *property, void *data)
+{
+	return ad.secondary ? TRUE : FALSE;
+}
+
+static gboolean get_secondary(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
+							&ad.secondary);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable ad_props[] = {
 	{ "Type", "s", get_type },
 	{ "ServiceUUIDs", "as", get_uuids, NULL, uuids_exists },
@@ -456,6 +471,7 @@ static const GDBusPropertyTable ad_props[] = {
 	{ "Appearance", "q", get_appearance, NULL, appearance_exits },
 	{ "Duration", "q", get_duration, NULL, duration_exits },
 	{ "Timeout", "q", get_timeout, NULL, timeout_exits },
+	{ "SecondaryChannel", "s", get_secondary, NULL, secondary_exits },
 	{ }
 };
 
@@ -919,3 +935,30 @@ void ad_advertise_timeout(DBusConnection *conn, long int *value)
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
+
+void ad_advertise_secondary(DBusConnection *conn, const char *value)
+{
+	if (!value) {
+		if (ad.secondary)
+			 bt_shell_printf("Secondary Channel: %s\n",
+							ad.secondary);
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
+	if (ad.secondary && !strcmp(value, ad.secondary))
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+
+	free(ad.secondary);
+
+	if (value[0] == '\0') {
+		ad.secondary = NULL;
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
+	ad.secondary = strdup(value);
+
+	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
+							"SecondaryChannel");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
diff --git a/client/advertising.h b/client/advertising.h
index fe3a7c8c6..9967e657b 100644
--- a/client/advertising.h
+++ b/client/advertising.h
@@ -41,3 +41,4 @@ void ad_advertise_data(DBusConnection *conn, int argc, char *argv[]);
 void ad_disable_data(DBusConnection *conn);
 void ad_advertise_discoverable(DBusConnection *conn, dbus_bool_t *value);
 void ad_advertise_discoverable_timeout(DBusConnection *conn, long int *value);
+void ad_advertise_secondary(DBusConnection *conn, const char *value);
diff --git a/client/main.c b/client/main.c
index 1f6e04578..2c5b05693 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2479,6 +2479,16 @@ static void cmd_advertise_timeout(int argc, char *argv[])
 	ad_advertise_timeout(dbus_conn, &value);
 }
 
+static void cmd_advertise_secondary(int argc, char *argv[])
+{
+	if (argc < 2) {
+		ad_advertise_secondary(dbus_conn, NULL);
+		return;
+	}
+
+	ad_advertise_secondary(dbus_conn, argv[1]);
+}
+
 static void ad_clear_uuids(void)
 {
 	ad_disable_uuids(dbus_conn);
@@ -2530,6 +2540,13 @@ static void ad_clear_timeout(void)
 	ad_advertise_timeout(dbus_conn, &value);
 }
 
+static void ad_clear_secondary(void)
+{
+	const char *value = "";
+
+	ad_advertise_secondary(dbus_conn, value);
+}
+
 static const struct clear_entry ad_clear[] = {
 	{ "uuids",		ad_clear_uuids },
 	{ "service",		ad_clear_service },
@@ -2540,6 +2557,7 @@ static const struct clear_entry ad_clear[] = {
 	{ "appearance",		ad_clear_appearance },
 	{ "duration",		ad_clear_duration },
 	{ "timeout",		ad_clear_timeout },
+	{ "secondary",		ad_clear_secondary },
 	{}
 };
 
@@ -2583,6 +2601,8 @@ static const struct bt_shell_menu advertise_menu = {
 			"Set/Get advertise duration" },
 	{ "timeout", "[seconds]", cmd_advertise_timeout,
 			"Set/Get advertise timeout" },
+	{ "secondary", "[1M/2M/Coded]", cmd_advertise_secondary,
+			"Set/Get advertise secondary channel" },
 	{ "clear", "[uuids/service/manufacturer/config-name...]", cmd_ad_clear,
 			"Clear advertise config" },
 	{ } },
-- 
2.17.2

