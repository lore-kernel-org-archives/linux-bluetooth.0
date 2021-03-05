Return-Path: <SRS0=2LFz=ID=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02362C433E9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 23:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C293B650B4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 23:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhCEXwl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Mar 2021 18:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhCEXwZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Mar 2021 18:52:25 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E1CC06175F
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Mar 2021 15:52:24 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v196so4288779ybv.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Mar 2021 15:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=QXCaWeacRSyK84p34eElm2tdjRHFV2ozbDFoOiTQlIM=;
        b=QVRJwjdLKTCRFelNUHOGp2Rlne4TrfetuJp/0+RRzuX8o1aPo6RxiXUTYr7HeqU140
         S/lcaK3e2egnY48YV88pSoENZSQhITZVfmC58h4r29Yio3QfMe7B24NvdKa5nxMcZVOy
         dWmh3XmeeEb//SHl5Vz5+4Fm9r/BBoib9+JMif1Z/bepbBrT7tObmTbwnYuc+4u0/Tiy
         UKK+eaSYgX5zcx9tMoAxIHKo8mitFHQ7OVeaOQrFL6h74z7KqIAXPE6NK33L3J2izBCn
         WD5U0Val0iO19NziqkwexMkqZFxHEQUEOxjDu1uMPmr7sqPEtWyfvxrCeP6HzdXDQkwC
         gCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QXCaWeacRSyK84p34eElm2tdjRHFV2ozbDFoOiTQlIM=;
        b=L/52QaG//C/ZiteuF1pfRf4LC6UzKiqJLkOFXwr1iB30Ixeijpyjowdzteyej/2Dum
         iatULml/x9Mrs/U5sKRCJNy3E5jqXE6XMIne481Nk+RMR0KErY18ILKb8bZTQ1jfaAbP
         86en7gRe0mDLQuWxYQHz4j2Eq9E08ibOTc5ySRy/ObYZTEcTC8o/O8btSSSM6SGCA9xo
         ygxpZg0P/agw2mZCYw0Z4X4A3FNMyCsH7GbOEOhEKAEthKSctZ0neugJgJA0RQb28XYH
         EOYrr++/kM3hT+LxaNiqAMiE4Ask2TyjO9dSF1PlM7HNZHNKoglVSxWqQF5eKZdMJPxg
         VlbQ==
X-Gm-Message-State: AOAM530PA13b53mqB1VYaPdOarfQZLnq9pVtJGJ59ZAbOk1qgrW0NYfe
        TPlQORKcftCoPqHK0CJkoLcfRR1kp+mP8bXaJZykeWoODkVz4IGl5ZoU9Y8dxNCm8RAdXzsFsyW
        uAoAexq/PIz67QNtiiZPr+LHOaNyr9ZW9H6Z7mE9Dtf4dDVLRrDOel8MO5cEO6+qgEZtTZC1mOB
        c5B1I5fqXCS4xHTD9A
X-Google-Smtp-Source: ABdhPJy+Q+LkLu7AMPdFDbF7wU5ualDfvMQhz/WtHErI+rAyDXsE4OLwghxefghN6s4TBi95RVEmPCO+bzZNPr/S5suo
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:94dd:309a:2fcb:13a])
 (user=danielwinkler job=sendgmr) by 2002:a25:d943:: with SMTP id
 q64mr16822819ybg.508.1614988344178; Fri, 05 Mar 2021 15:52:24 -0800 (PST)
Date:   Fri,  5 Mar 2021 15:52:15 -0800
In-Reply-To: <20210305235217.2382976-1-danielwinkler@google.com>
Message-Id: <20210305155113.Bluez.v3.1.Idf2f9f409a4df20b466ba723dd9b729275a5afbf@changeid>
Mime-Version: 1.0
References: <20210305235217.2382976-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [Bluez PATCH v3 1/3] advertising: Add SupportedFeatures to LEAdvertisingManager1
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

Changes in v3: None
Changes in v2:
- Expose empty SupportedFeatures if no support available

 lib/mgmt.h        |  2 ++
 src/advertising.c | 43 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 43 insertions(+), 2 deletions(-)

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
index 15a343e52..dd6008cb9 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1616,7 +1616,8 @@ static void append_secondary(struct btd_adv_manager *manager,
 	}
 }
 
-static gboolean secondary_exits(const GDBusPropertyTable *property, void *data)
+static gboolean secondary_exists(const GDBusPropertyTable *property,
+						void *data)
 {
 	struct btd_adv_manager *manager = data;
 
@@ -1640,6 +1641,43 @@ static gboolean get_supported_secondary(const GDBusPropertyTable *property,
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
@@ -1678,7 +1716,8 @@ static const GDBusPropertyTable properties[] = {
 	{ "SupportedInstances", "y", get_instances, NULL, NULL },
 	{ "SupportedIncludes", "as", get_supported_includes, NULL, NULL },
 	{ "SupportedSecondaryChannels", "as", get_supported_secondary, NULL,
-							secondary_exits },
+							secondary_exists },
+	{ "SupportedFeatures", "as", get_supported_features, NULL, NULL },
 	{ "SupportedCapabilities", "a{sv}", get_supported_cap, NULL, NULL,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL},
 	{ }
-- 
2.30.1.766.gb4fecdf3b7-goog

