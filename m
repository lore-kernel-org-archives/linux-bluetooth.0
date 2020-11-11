Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFFCC388F7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 01:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BFA9221F9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Nov 2020 01:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BOMtsVSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733001AbgKKBSA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Nov 2020 20:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732835AbgKKBRy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Nov 2020 20:17:54 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD02C0613D3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 17:17:54 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id i26so302324pgl.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2020 17:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qnjOyIqD02WVy6ZZ2x5bkuCTpr4hjumX5jR/HYlXCOk=;
        b=BOMtsVSoSPnADSKJwzb1eP0Vwq39Fkd9SuyQT/fbeY9TAtnbDONIODZ8jwWBsEVt5d
         lpZJnC0w7K7A0oNyD6CP+UkPIiyX+66Cqgp2/SVtORW6pi6gJKl25WWhFY4NG7z1bsOj
         bfBO60uh5F3/7IVfDtQsvl8akXKcty+46xtdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qnjOyIqD02WVy6ZZ2x5bkuCTpr4hjumX5jR/HYlXCOk=;
        b=iLNu+Ty1hgPuWtfkfZKR92AH1TS8H3L8JCV0eTINN2fLjmLE2ZhU2NQqTWfE1wnvty
         zpkRFvGVF9dLIvQD0koergT7jcw6chQI1TLrag3aVLWCyC+GovYk4QTLF9UhZW14J3Nh
         ysENBCZJ8t4Expt/NoBq8qmcwh36EWfOF6VL0veAyZ4kbTAlTlPAhF3bEulYI3juXybQ
         jZOyaKC8ECjoydw8Z8BTfwTJAtNmN3VA+JqQvKQcqAiVmonacA0F18/iRiieFy37Gffi
         WaioDU3Uf7EHQnR/RmDQtI1b23als463awMLTmp8nd6XKZrLVsOfmYsSOSp0ULr+Gtpq
         zpOA==
X-Gm-Message-State: AOAM530YAJk0uMc2kn26mXqq31upDecAi8v4COLwUmNMQizAU04BKSF6
        gITy+mYqUNHOTWkipPCHd50Gqs10r1H8ZA==
X-Google-Smtp-Source: ABdhPJwgafqx6FwTLdAYDbaZrTTrY/mMKKaUKAgMlPby5N0cZluNlNt7c88bGZa+sL+FFaivHDpJUw==
X-Received: by 2002:a63:c43:: with SMTP id 3mr20231994pgm.222.1605057474034;
        Tue, 10 Nov 2020 17:17:54 -0800 (PST)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id y19sm331695pfn.147.2020.11.10.17.17.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2020 17:17:53 -0800 (PST)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: [PATCH BlueZ v2 3/7] battery: Add Source property to Battery API
Date:   Tue, 10 Nov 2020 17:17:41 -0800
Message-Id: <20201111011745.2016-3-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201111011745.2016-1-sonnysasaka@chromium.org>
References: <20201111011745.2016-1-sonnysasaka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

As Battery API will be generalized for other battery reporting
protocols, the Source property is useful for diagnostics purposes.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

---
 profiles/battery/battery.c |  3 ++-
 src/battery.c              | 35 +++++++++++++++++++++++++++++++----
 src/battery.h              |  2 +-
 3 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index e1a61dd0b..2478816a4 100644
--- a/profiles/battery/battery.c
+++ b/profiles/battery/battery.c
@@ -126,7 +126,8 @@ static void batt_io_ccc_written_cb(uint16_t att_ecode, void *user_data)
 		return;
 	}
 
-	batt->battery = btd_battery_register(device_get_path(batt->device));
+	batt->battery = btd_battery_register(device_get_path(batt->device),
+					     "GATT Battery Service");
 
 	if (!batt->battery) {
 		batt_reset(batt);
diff --git a/src/battery.c b/src/battery.c
index 87a6b91fb..8613d6e23 100644
--- a/src/battery.c
+++ b/src/battery.c
@@ -31,8 +31,9 @@
 #define BATTERY_MAX_PERCENTAGE 100
 
 struct btd_battery {
-	char *path; /* D-Bus object path, owns pointer */
+	char *path; /* D-Bus object path */
 	uint8_t percentage; /* valid between 0 to 100 inclusively */
+	char *source; /* Descriptive source of the battery info */
 };
 
 static struct queue *batteries = NULL;
@@ -62,13 +63,15 @@ static bool match_path(const void *data, const void *user_data)
 	return g_strcmp0(battery->path, path) == 0;
 }
 
-static struct btd_battery *battery_new(const char *path)
+static struct btd_battery *battery_new(const char *path, const char *source)
 {
 	struct btd_battery *battery;
 
 	battery = new0(struct btd_battery, 1);
 	battery->path = g_strdup(path);
 	battery->percentage = UINT8_MAX;
+	if (source)
+		battery->source = g_strdup(source);
 
 	return battery;
 }
@@ -78,6 +81,9 @@ static void battery_free(struct btd_battery *battery)
 	if (battery->path)
 		g_free(battery->path);
 
+	if (battery->source)
+		g_free(battery->source);
+
 	free(battery);
 }
 
@@ -100,13 +106,34 @@ static gboolean property_percentage_exists(const GDBusPropertyTable *property,
 	return battery->percentage <= BATTERY_MAX_PERCENTAGE;
 }
 
+static gboolean property_source_get(const GDBusPropertyTable *property,
+				    DBusMessageIter *iter, void *data)
+{
+	struct btd_battery *battery = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
+				       &battery->source);
+
+	return TRUE;
+}
+
+static gboolean property_source_exists(const GDBusPropertyTable *property,
+				       void *data)
+{
+	struct btd_battery *battery = data;
+
+	return battery->source != NULL;
+}
+
 static const GDBusPropertyTable battery_properties[] = {
 	{ "Percentage", "y", property_percentage_get, NULL,
 	  property_percentage_exists },
+	{ "Source", "s", property_source_get, NULL, property_source_exists,
+	  G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{}
 };
 
-struct btd_battery *btd_battery_register(const char *path)
+struct btd_battery *btd_battery_register(const char *path, const char *source)
 {
 	struct btd_battery *battery;
 
@@ -122,7 +149,7 @@ struct btd_battery *btd_battery_register(const char *path)
 		return NULL;
 	}
 
-	battery = battery_new(path);
+	battery = battery_new(path, source);
 	battery_add(battery);
 
 	if (!g_dbus_register_interface(btd_get_dbus_connection(), battery->path,
diff --git a/src/battery.h b/src/battery.h
index 9c69b7afa..ff63454cd 100644
--- a/src/battery.h
+++ b/src/battery.h
@@ -10,6 +10,6 @@
 
 struct btd_battery;
 
-struct btd_battery *btd_battery_register(const char *path);
+struct btd_battery *btd_battery_register(const char *path, const char *source);
 bool btd_battery_unregister(struct btd_battery *battery);
 bool btd_battery_update(struct btd_battery *battery, uint8_t percentage);
-- 
2.26.2

