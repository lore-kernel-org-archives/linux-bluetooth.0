Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E664BC678D5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Mar 2023 22:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjCGW0H (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Mar 2023 17:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjCGWZq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Mar 2023 17:25:46 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB71B06DD
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 14:25:10 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m20-20020a17090ab79400b00239d8e182efso187752pjr.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Mar 2023 14:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678227878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1IU8LiWwZeoZ/1lc6uZFO7QKOeog+W2EZMCDjvEpLE=;
        b=gSq9C3z3ElE7vwAVygN50LcQN0FYB+pGpPYfTeHN3/UJCAzfFYxNdZrGYsYASnNblL
         5sI6W6Rzrq/zzo52klf2HPvCXoSWDFcORmnQPiNjxI1VfRpgRFepHiKYvT4kpvKmNmM1
         9i0damE7357bmEPiczd0V4XJOG5il4lmepG1Q33b7DtAPBeSKjxoAXicbdwogKPitaa0
         StLuMLAPKtHAAfOFS2I2tPMUEPaXUgcz+e1e2X/myZSObdvo8iiwY743CfeErKfl3S9W
         9BnBu7JgcAMVrfHOca7U9sXdqFeC5vMMYJICs+VXZjkG+VV8dQKZSkmInW0iy5V8vM/S
         LHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678227878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1IU8LiWwZeoZ/1lc6uZFO7QKOeog+W2EZMCDjvEpLE=;
        b=JetJfRgcHK1bj43Xy7GzxOL8fzWJ7w3VqsMEAOFMU1LLGn0Fhqu05OCtKzJy/9IXrY
         +uM6b+C8dH9RaRs5lW8LrWtKPuL7Y13P2t9k6Yd9KFvZDg1emUsYEeylExRllr3jA6mb
         gsI8PkcdGp9izmmBDjId3GqujYToOr2UjiwWM5R+N36fqB1/goQRohkfs3AiBfsneNp1
         GtQC4I+tgTM72GjQSsIJSnZyV9GdAwPCAYyWyJmGjZyuQSMAUKqVu64lBQ6OJXFoBM0M
         szle2PCOR1Ib4lKna0LK4TjjYKz5KCiC9WBfkY+2vlj8mLxPmtk99pCJ0BKHDu0puGg5
         bkJg==
X-Gm-Message-State: AO0yUKWvDnPpAXaivb6OdglJ/p5YdpQN9+YizDZgXBgQ2oTejucQpp6J
        IIx5iCPHFnRkkG1va8WdyysmN7g8tEQ=
X-Google-Smtp-Source: AK7set/9eNQAfULKWfO1B3cLnisHqMRtar3Kt0GSm+tu9pS9BEPQ1fFI50buDouk/XrqtPA7ZANQBg==
X-Received: by 2002:a17:903:22c1:b0:19e:ba2c:27ec with SMTP id y1-20020a17090322c100b0019eba2c27ecmr12638088plg.11.1678227878532;
        Tue, 07 Mar 2023 14:24:38 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id d18-20020a170902729200b0019c901b35ecsm8814392pll.106.2023.03.07.14.24.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 14:24:38 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC v2 12/12] client: Use AdvertisingFlags when available
Date:   Tue,  7 Mar 2023 14:24:22 -0800
Message-Id: <20230307222422.2608483-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307222422.2608483-1-luiz.dentz@gmail.com>
References: <20230307222422.2608483-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This prints devices not discoverable in grey so the user are able to
distict when for example set members are actually visible.
---
 client/main.c | 79 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 55 insertions(+), 24 deletions(-)

diff --git a/client/main.c b/client/main.c
index e4a39896b2c6..79895015d6a6 100644
--- a/client/main.c
+++ b/client/main.c
@@ -24,6 +24,7 @@
 
 #include "src/shared/shell.h"
 #include "src/shared/util.h"
+#include "src/shared/ad.h"
 #include "gdbus/gdbus.h"
 #include "print.h"
 #include "agent.h"
@@ -143,10 +144,32 @@ static void print_adapter(GDBusProxy *proxy, const char *description)
 
 }
 
+#define	DISTANCE_VAL_INVALID	0x7FFF
+
+static struct set_discovery_filter_args {
+	char *transport;
+	char *pattern;
+	dbus_uint16_t rssi;
+	dbus_int16_t pathloss;
+	char **uuids;
+	size_t uuids_len;
+	dbus_bool_t duplicate;
+	dbus_bool_t discoverable;
+	bool set;
+	bool active;
+	unsigned int timeout;
+} filter = {
+	.rssi = DISTANCE_VAL_INVALID,
+	.pathloss = DISTANCE_VAL_INVALID,
+	.set = true,
+};
+
 static void print_device(GDBusProxy *proxy, const char *description)
 {
 	DBusMessageIter iter;
 	const char *address, *name;
+	uint8_t *flags;
+	int flags_len = 0;
 
 	if (g_dbus_proxy_get_property(proxy, "Address", &iter) == FALSE)
 		return;
@@ -158,11 +181,39 @@ static void print_device(GDBusProxy *proxy, const char *description)
 	else
 		name = "<unknown>";
 
+	if (g_dbus_proxy_get_property(proxy, "AdvertisingFlags", &iter)) {
+		DBusMessageIter array;
+
+		dbus_message_iter_recurse(&iter, &array);
+		dbus_message_iter_get_fixed_array(&array, &flags, &flags_len);
+	}
+
+	if (!flags_len)
+		goto done;
+
+	if (!(flags[0] & (BT_AD_FLAG_LIMITED | BT_AD_FLAG_GENERAL))) {
+		/* Only print hidden/non-discoverable if filter.discoverable is
+		 * not set.
+		 */
+		if (filter.discoverable)
+			return;
+
+		bt_shell_printf("%s%s%s" COLOR_BOLDGRAY "Device %s %s"
+					COLOR_OFF "\n",
+					description ? "[" : "",
+					description ? : "",
+					description ? "] " : "",
+					address, name);
+
+		return;
+	}
+
+done:
 	bt_shell_printf("%s%s%sDevice %s %s\n",
-				description ? "[" : "",
-				description ? : "",
-				description ? "] " : "",
-				address, name);
+					description ? "[" : "",
+					description ? : "",
+					description ? "] " : "",
+					address, name);
 }
 
 static void print_uuid(const char *label, const char *uuid)
@@ -1133,26 +1184,6 @@ static void cmd_default_agent(int argc, char *argv[])
 	agent_default(dbus_conn, agent_manager);
 }
 
-#define	DISTANCE_VAL_INVALID	0x7FFF
-
-static struct set_discovery_filter_args {
-	char *transport;
-	char *pattern;
-	dbus_uint16_t rssi;
-	dbus_int16_t pathloss;
-	char **uuids;
-	size_t uuids_len;
-	dbus_bool_t duplicate;
-	dbus_bool_t discoverable;
-	bool set;
-	bool active;
-	unsigned int timeout;
-} filter = {
-	.rssi = DISTANCE_VAL_INVALID,
-	.pathloss = DISTANCE_VAL_INVALID,
-	.set = true,
-};
-
 static void start_discovery_reply(DBusMessage *message, void *user_data)
 {
 	dbus_bool_t enable = GPOINTER_TO_UINT(user_data);
-- 
2.39.2

