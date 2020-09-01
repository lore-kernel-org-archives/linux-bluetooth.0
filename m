Return-Path: <SRS0=HAk7=CK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8673C433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 22:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92B6E206C0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Sep 2020 22:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="EQylgbEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbgIAWAl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbgIAWAk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Sep 2020 18:00:40 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2FBC061244
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2020 15:00:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 207so2709766ybd.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2020 15:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=2pjMPOzpNyrqpjBIOCKze3A6gHCruyIibRIu9fK5k6E=;
        b=EQylgbEdbO1jIvVdRLO+ImoHZ9mFEHlMeaavDVLhjcc3l7m87tDHb4HHNz1Z2P2i+g
         N2MEMYiBg+XR5jIEgZf9ETFF7FRYcOu2eKQuxBUvh3MT+GM9Q329hNUWKUfYUz0099RY
         uSkimyDPd73QRg0/puz5lHgjhiTUN3gZ71V+9U79QcCcYrVmY9qCXoFcw7bAAMYnMdzk
         oxVbA7qEbkKARRvu03V8ZHN1K8A+yJAdX95DUBwP9bts0n9FuPhTONHSR5ZAcGWCREkt
         bnoIS9YRQF81mZusnrYlfVJhfXt2ogwYOU6dwKAjPAXfknu+MGFR479LE3uwZQQThdDs
         c1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2pjMPOzpNyrqpjBIOCKze3A6gHCruyIibRIu9fK5k6E=;
        b=BqjotgAD5zy8UG3V0zY+MoSwtutno8OiHV5GVLN16lwNkbKakDfspSUYlNEIx9OOrI
         2H620Eh0CtetntLOZylgofp06pGQ05mE+kAmO13qPWY4g27MFUp4+W3uxS0LJccYkXFP
         z5fq2D2LOqHgMzcU0XinTm5vOmFOQGUvDq3DUB+Wgngf1nNosFlSIFFr6mgGw7nxfgip
         vamkHhex545PurRWUz8ATEOu4WqeFTjy8EVPxTcxHhv8T0yy0GGfkSIAETWT7xY0zXd6
         A/0n75R5ha2LZ9TzcaEdIVsyQ+Mhcxd15Obr97jf9NdhkAk/y8RWoBX7fBOleGb941xT
         sGAA==
X-Gm-Message-State: AOAM5310kUK7I26l52QGYxHaAbi6GXW+/o+sCkIcZGZc4DhDF5N2VUDy
        Rnid3y/B5HT4p3Ul4Cmx8+9m5HWaiZmMtSRq6kG8diTBENBMB7gKowFOr3H+wCdyCLqEJm6eTaJ
        sbuP4wI86khEAhfCM5iKAynooGEFkQFucQAw31JjO+KykyI3jyQklZ9vUPPs/oJANxAFGN3RUvi
        wvnqSZWcxYGcsBrDRY
X-Google-Smtp-Source: ABdhPJwvgDTHCt9+Zhqq30zNVMjzllK0eBLoZmQ9eVV6p5GGviZkHkwTAf/eku4F7uA9uPwULTCFFrqURi4kYvxTpJ+Z
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:c7cd:: with SMTP id
 w196mr5350640ybe.351.1598997639598; Tue, 01 Sep 2020 15:00:39 -0700 (PDT)
Date:   Tue,  1 Sep 2020 15:00:22 -0700
In-Reply-To: <20200901220024.662941-1-danielwinkler@google.com>
Message-Id: <20200901145820.Bluez.v2.1.Idf2f9f409a4df20b466ba723dd9b729275a5afbf@changeid>
Mime-Version: 1.0
References: <20200901220024.662941-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [Bluez PATCH v2 1/3] advertising: Add SupportedFeatures to LEAdvertisingManager1
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
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

Changes in v2:
- Expose empty SupportedFeatures if no support available

 lib/mgmt.h        |  2 ++
 src/advertising.c | 43 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index a800bcab4..38182e576 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -516,6 +516,8 @@ struct mgmt_rp_add_advertising {
 #define MGMT_ADV_FLAG_SEC_1M		(1 << 7)
 #define MGMT_ADV_FLAG_SEC_2M		(1 << 8)
 #define MGMT_ADV_FLAG_SEC_CODED		(1 << 9)
+#define MGMT_ADV_FLAG_CAN_SET_TX_POWER	(1 << 10)
+#define MGMT_ADV_FLAG_HW_OFFLOAD	(1 << 11)
 
 #define MGMT_OP_REMOVE_ADVERTISING	0x003F
 struct mgmt_cp_remove_advertising {
diff --git a/src/advertising.c b/src/advertising.c
index e5f25948d..518d0a80a 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1321,7 +1321,8 @@ static void append_secondary(struct btd_adv_manager *manager,
 	}
 }
 
-static gboolean secondary_exits(const GDBusPropertyTable *property, void *data)
+static gboolean secondary_exists(const GDBusPropertyTable *property,
+						void *data)
 {
 	struct btd_adv_manager *manager = data;
 
@@ -1345,12 +1346,50 @@ static gboolean get_supported_secondary(const GDBusPropertyTable *property,
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
 static const GDBusPropertyTable properties[] = {
 	{ "ActiveInstances", "y", get_active_instances, NULL, NULL },
 	{ "SupportedInstances", "y", get_instances, NULL, NULL },
 	{ "SupportedIncludes", "as", get_supported_includes, NULL, NULL },
 	{ "SupportedSecondaryChannels", "as", get_supported_secondary, NULL,
-							secondary_exits },
+							secondary_exists },
+	{ "SupportedFeatures", "as", get_supported_features, NULL, NULL },
 	{ }
 };
 
-- 
2.28.0.402.g5ffc5be6b7-goog

