Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB60C761A6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Apr 2023 23:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjDEXLW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Apr 2023 19:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjDEXLV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Apr 2023 19:11:21 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987077689
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Apr 2023 16:11:19 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id ja10so35860748plb.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Apr 2023 16:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680736278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9h2LAyTEPFBx9MN8b1NweE/DCDt8zWMHpQDzmPvfrs8=;
        b=iE0Eno4PAYMMTG/gXPaRkflofWfvgLwSQSuPoyZRFWT1cwPqGyQ2+D+rPHApTfVEA+
         dKsXY7QPZbVQKegcV2dDq4n0y4kKUNx/oe7autKa1Py01eZMwU1Btvw1RT0Fq5qZ9PBB
         4Mc+iDZODesje6Y+357JyJgJOcpVyz4FCTB+/OswRdbecXbKytZxoMU/6fhPlU7tJr5t
         Kor/K9NxS4Ai1xSv1qwtM9XB/vj9iKBNK3atFIX8WaS74NOOiGMvq/A2gdVAnsfJs3LF
         XpQ+426opYPnktetmfEVbtuLlTdjXVkXU+966RjLR8iZHEEoXaQthJYYGaeiYkhnEg0w
         BAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680736278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9h2LAyTEPFBx9MN8b1NweE/DCDt8zWMHpQDzmPvfrs8=;
        b=MnyxLPcp87TxHIb4M7eWuYIDeVhJo3TcmsbIqe3MtH5kSKXSbpgJOf31IvEnnzQ+L4
         Jkt6Bwj74yzpLRY3BFZv0wfyDqBfQN3VaUoe5DFJ7kOQXU9Z0U6Yv6VAVjiotNZ7PppO
         BA3j6FYb3QeOmfZOu7K5XXGH99dwL32Vp4EgwqZCgxQkFLjlj5OVKzD2XaYoqFvbDEt1
         3Py8Xbpl4Df5iCVXLHi8z4yqstZ8xcSnm7pPS8ZNSE0YGTGDYG74l5bEg8M96g3qRKh3
         u6j6AK0d7UEY19gv7fiubunnbwC0EQeZgZbNgxGJRywMpk7Z3mx5i7ZLDw3DToRoICXY
         bk+Q==
X-Gm-Message-State: AAQBX9ddCwOtBx8RhF/BNV076WMXBfXKUSWRelN+qDWirPu1gIFHQY0p
        F7wXQE28QKDeM4avZqAMrLiFuc/4PkI=
X-Google-Smtp-Source: AKy350brgp0sUKoPy0HTlooEXHSxZIc6ydBZQJdExOj06j1Pn16ptHz29bpYqNrwbZ/oKHOLZ/VrjA==
X-Received: by 2002:a05:6a20:cc41:b0:db:314d:c19a with SMTP id hq1-20020a056a20cc4100b000db314dc19amr658492pzb.50.1680736278419;
        Wed, 05 Apr 2023 16:11:18 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id v12-20020aa7808c000000b006254794d5b2sm11537752pff.94.2023.04.05.16.11.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 16:11:17 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] client/advertising: Add support for advertise.rsi command
Date:   Wed,  5 Apr 2023 16:11:11 -0700
Message-Id: <20230405231111.2636523-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230405231111.2636523-1-luiz.dentz@gmail.com>
References: <20230405231111.2636523-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for advertise.rsi command which can be used to request
the generation of RSI and include it as part of advertising data:

[bluetooth]# advertise.rsi --help
Show/Enable/Disable RSI to be advertised
Usage:
	 rsi [on/off]
[bluetooth]# advertise.rsi
RSI: on
[bluetooth]# advertise on
...
Advertising object registered
Tx Power: off
Name: off
Appearance: off
Discoverable: on
RSI: on
[bluetooth]#
---
 client/advertising.c | 28 +++++++++++++++++++++++++++-
 client/advertising.h |  1 +
 client/main.c        | 17 +++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/client/advertising.c b/client/advertising.c
index fb9b049fde78..8b8e6d97ff80 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -67,9 +67,11 @@ static struct ad {
 	bool tx_power;
 	bool name;
 	bool appearance;
+	bool rsi;
 } ad = {
 	.local_appearance = UINT16_MAX,
 	.discoverable = true,
+	.rsi = true,
 };
 
 static void ad_release(DBusConnection *conn)
@@ -176,6 +178,7 @@ static void print_ad(void)
 					ad.appearance ? "on" : "off");
 
 	bt_shell_printf("Discoverable: %s\n", ad.discoverable ? "on": "off");
+	bt_shell_printf("RSI: %s\n", ad.rsi ? "on": "off");
 
 	if (ad.duration)
 		bt_shell_printf("Duration: %u sec\n", ad.duration);
@@ -295,7 +298,7 @@ static gboolean get_manufacturer_data(const GDBusPropertyTable *property,
 
 static gboolean includes_exists(const GDBusPropertyTable *property, void *data)
 {
-	return ad.tx_power || ad.name || ad.appearance;
+	return ad.tx_power || ad.name || ad.appearance || ad.rsi;
 }
 
 static gboolean get_includes(const GDBusPropertyTable *property,
@@ -323,6 +326,12 @@ static gboolean get_includes(const GDBusPropertyTable *property,
 		dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING, &str);
 	}
 
+	if (ad.rsi) {
+		const char *str = "rsi";
+
+		dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING, &str);
+	}
+
 	dbus_message_iter_close_container(iter, &array);
 
 
@@ -1023,3 +1032,20 @@ void ad_advertise_interval(DBusConnection *conn, uint32_t *min, uint32_t *max)
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
+
+void ad_advertise_rsi(DBusConnection *conn, dbus_bool_t *value)
+{
+	if (!value) {
+		bt_shell_printf("RSI: %s\n", ad.rsi ? "on" : "off");
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
+	if (ad.rsi == *value)
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+
+	ad.rsi = *value;
+
+	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "Includes");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
diff --git a/client/advertising.h b/client/advertising.h
index 472396efd381..145ac80452d2 100644
--- a/client/advertising.h
+++ b/client/advertising.h
@@ -30,3 +30,4 @@ void ad_advertise_discoverable(DBusConnection *conn, dbus_bool_t *value);
 void ad_advertise_discoverable_timeout(DBusConnection *conn, long int *value);
 void ad_advertise_secondary(DBusConnection *conn, const char *value);
 void ad_advertise_interval(DBusConnection *conn, uint32_t *min, uint32_t *max);
+void ad_advertise_rsi(DBusConnection *conn, dbus_bool_t *value);
diff --git a/client/main.c b/client/main.c
index 79895015d6a6..b433a22001a3 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2733,6 +2733,21 @@ static void cmd_advertise_interval(int argc, char *argv[])
 	ad_advertise_interval(dbus_conn, &min, &max);
 }
 
+static void cmd_advertise_rsi(int argc, char *argv[])
+{
+	dbus_bool_t value;
+
+	if (argc < 2) {
+		ad_advertise_rsi(dbus_conn, NULL);
+		return;
+	}
+
+	if (!parse_argument(argc, argv, NULL, NULL, &value, NULL))
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	ad_advertise_rsi(dbus_conn, &value);
+}
+
 static void ad_clear_uuids(void)
 {
 	ad_disable_uuids(dbus_conn);
@@ -2931,6 +2946,8 @@ static const struct bt_shell_menu advertise_menu = {
 			"Set/Get advertise secondary channel" },
 	{ "interval", "[min] [max] ", cmd_advertise_interval,
 			"Set/Get advertise interval range" },
+	{ "rsi", "[on/off]", cmd_advertise_rsi,
+			"Show/Enable/Disable RSI to be advertised", NULL },
 	{ "clear", "[uuids/service/manufacturer/config-name...]", cmd_ad_clear,
 			"Clear advertise config" },
 	{ } },
-- 
2.39.2

