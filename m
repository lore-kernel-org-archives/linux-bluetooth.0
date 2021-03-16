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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D6DC43381
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 23:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F086364F97
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 23:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhCPXWz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 19:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhCPXWY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 19:22:24 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCE8C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 16:22:24 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id t18so26407643qva.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 16:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y6B0hjFKQfsKqaoZv93H9tmhDwCuVWmHaQYcV2oPxNE=;
        b=fi/0JZPGvaD2CWPpOUlIKpYaD3w3lquw+/2bzb1JtZ5rnqPF82oj22YWE9WHHh1PAI
         ZJlqYTULSPBH/kSLN8IaFM4P9K5ned6uzBFXAggnshcQqBOv5zophirzh7NWosKX4Pz+
         7H9r3Moj9CUz0kDfL1+t1HazHTSPc5aaUc13oDI9QZh+DbZku/q9/dawqaQ0oZAqPnkc
         Pt0euMBq59bEYm5jAqT4m9nxxt/3rh2yqyHF7uWIm21zoNBbRXm0FH/3kdc9cPTPxZcM
         o5pDsaxVLo8LL4V6VQOm6b3S4cSV/x69Nl0QJqWnGwUK/zpJHI2dF1DHfVXtogHvkJry
         zsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y6B0hjFKQfsKqaoZv93H9tmhDwCuVWmHaQYcV2oPxNE=;
        b=RjZOxOtG1sF4ftwbBoUCABDkBM1hld8S3VcLFij/Yo2aY6ESql3Ny4XcLm277wazTk
         kkPCJYtzf2eOxQP1t69O5P5AvRz/Q2+MTueys/Z9Wx62jPSCmlKPlDoXxAW6IzbxC0VG
         0HrsJobEPpToyIS3PpH36xW9FmBKZQASCRKoYkXE1M2ElUMbX4+qFzfL1o9UF2GFNZzY
         okl2YXbiQvds3mSvlh6uYQOqbISKrYqPcczoFY/Pgi1JYPaLTYPnH5rRewLTvK5OwiPG
         v961t+semMT1bxN5WPHtp7uzrkpL1D31Qx4MwcQYwJTiPu6cPh6ohznA6YYGqZNX3xiV
         YCrQ==
X-Gm-Message-State: AOAM531p2qFC3MW+I1UhACpGPLSPPxLylSkUET2Lt+HxH14+R9hmgqGW
        ZWjPXCvoDKQazAYQl+LWLtRXVJ7WOFjCj3LQV5It1cKUFX1wTVcFs3kgYCl+FLfP6GVgEYG1YKX
        YcqFnn12UzpbHHrlioLRhjyOgW7ZHr3UN09zMRO1WLjZgodcMynJftMkfayk5RnQ6zvxo5/Re+h
        VqkfGck+XXW6HdzPlq
X-Google-Smtp-Source: ABdhPJwEjqqsKkjoV25zXH1kuar6EAn0wK5tFe8NpnvRadBiZXZeTVje1YpeG3qkfq8P/X+Z9L/cSwYQfIBRW5qAckPE
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:8543:90a8:2e5c:1402])
 (user=danielwinkler job=sendgmr) by 2002:a0c:80ca:: with SMTP id
 68mr2488197qvb.12.1615936943456; Tue, 16 Mar 2021 16:22:23 -0700 (PDT)
Date:   Tue, 16 Mar 2021 16:22:15 -0700
In-Reply-To: <20210316232217.3344489-1-danielwinkler@google.com>
Message-Id: <20210316162044.Bluez.v4.1.Idf2f9f409a4df20b466ba723dd9b729275a5afbf@changeid>
Mime-Version: 1.0
References: <20210316232217.3344489-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [Bluez PATCH v4 1/3] advertising: Add SupportedFeatures to LEAdvertisingManager1
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The new SupportedFeatures member tells advertising clients whether the
platform has hardware support for advertising or capability to set tx
power of advertisements.

Additionally, fix small typo in "secondary_exists" function name.

Change is tested on hatch and kukui chromebooks by using dbus-send to
verify that SupportedFeatures always exists, and is only populated when
extended advertising is available.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

Changes in v4:
- Mark SupportedFeatures as experimental

Changes in v3: None
Changes in v2:
- Expose empty SupportedFeatures if no support available

 lib/mgmt.h        |  2 ++
 src/advertising.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 76a03c9c2..c0021abd8 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -503,6 +503,8 @@ struct mgmt_rp_add_advertising {
 #define MGMT_ADV_FLAG_SEC_1M		(1 << 7)
 #define MGMT_ADV_FLAG_SEC_2M		(1 << 8)
 #define MGMT_ADV_FLAG_SEC_CODED		(1 << 9)
+#define MGMT_ADV_FLAG_CAN_SET_TX_POWER	(1 << 10)
+#define MGMT_ADV_FLAG_HW_OFFLOAD	(1 << 11)
 #define MGMT_ADV_PARAM_DURATION		(1 << 12)
 #define MGMT_ADV_PARAM_TIMEOUT		(1 << 13)
 #define MGMT_ADV_PARAM_INTERVALS	(1 << 14)
diff --git a/src/advertising.c b/src/advertising.c
index d76e97a74..4ab449ceb 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1618,7 +1618,8 @@ static void append_secondary(struct btd_adv_manager *manager,
 	}
 }
 
-static gboolean secondary_exits(const GDBusPropertyTable *property, void *data)
+static gboolean secondary_exists(const GDBusPropertyTable *property,
+						void *data)
 {
 	struct btd_adv_manager *manager = data;
 
@@ -1642,6 +1643,43 @@ static gboolean get_supported_secondary(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static struct adv_feature {
+	int flag;
+	const char *name;
+} features[] = {
+	{ MGMT_ADV_FLAG_CAN_SET_TX_POWER, "CanSetTxPower" },
+	{ MGMT_ADV_FLAG_HW_OFFLOAD, "HardwareOffload" },
+	{ },
+};
+
+static void append_features(struct btd_adv_manager *manager,
+						DBusMessageIter *iter)
+{
+	struct adv_feature *feat;
+
+	for (feat = features; feat->name; feat++) {
+		if (manager->supported_flags & feat->flag)
+			dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
+								&feat->name);
+	}
+}
+
+static gboolean get_supported_features(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_adv_manager *manager = data;
+	DBusMessageIter entry;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_STRING_AS_STRING, &entry);
+
+	append_features(manager, &entry);
+
+	dbus_message_iter_close_container(iter, &entry);
+
+	return TRUE;
+}
+
 static gboolean get_supported_cap(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -1680,7 +1718,9 @@ static const GDBusPropertyTable properties[] = {
 	{ "SupportedInstances", "y", get_instances, NULL, NULL },
 	{ "SupportedIncludes", "as", get_supported_includes, NULL, NULL },
 	{ "SupportedSecondaryChannels", "as", get_supported_secondary, NULL,
-							secondary_exits },
+							secondary_exists },
+	{ "SupportedFeatures", "as", get_supported_features, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL},
 	{ "SupportedCapabilities", "a{sv}", get_supported_cap, NULL, NULL,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL},
 	{ }
-- 
2.31.0.rc2.261.g7f71774620-goog

