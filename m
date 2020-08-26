Return-Path: <SRS0=or7B=CE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3781BC433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 20:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C3552080C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 20:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="X5TlRlIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgHZUMD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Aug 2020 16:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgHZUMD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Aug 2020 16:12:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD751C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2020 13:12:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 83so4357538ybf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2020 13:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=x5I31Cx/lCkc6J4SrBA8xYUW95BrqBSHcoi2qMQlDjE=;
        b=X5TlRlIa/cQZmDjbzYzSWOG3R7OJuKmzdHHBIRHKPM6cDkoxD4j6Fhj+ETUnPd0qpO
         gPCriLCFZFd9cQjFW11DygRpa0nP56om7X5X/Kn6X7ceLMDBavk6D7E4y5gqATene9WX
         TlwdZYaRqxeVw/CjFUq7XNU9tjtZkqByYh1TlGZA3vRDsyy/mx2dBVdGUbcv7h/5mNyb
         5tpVUSquIstollCIcB///kmFxjysjUhBxndZDQ+r/JuTg0l650w7Fiv0zSXSnKK8LtZM
         B4436xqGhamonzagg8TSwMxfitIJ1Nza+3xS+/I1BlCnh0zZcFtU6ZiYwIXgZ2Z548wT
         SWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x5I31Cx/lCkc6J4SrBA8xYUW95BrqBSHcoi2qMQlDjE=;
        b=j1beBHTbWLfB9wnUt7X0iy2V7vxUYc26NkR+8fDq6FRgxEbHrBE1OsVKVP1atk1bG0
         LBbc6YifNWzOaSPiUSh8VuayoaBRGNGYNQrgkz+PCgKBpxLyyTT2Hn/c8FIiukmWq1N9
         pm3TE3rUBnpfuCKsT3i7QmGdqWBcyH98sSlm68IR01sYFL70VCgc/wF48Hfn2rWqSX0n
         6ovIDehNoSW5pN5o1p09sCLS5oDN8WySMW0tUe+p+YVsnsRKtaI+ckLyFM5a1ggRgoAW
         DBwX/9aEobjVuFztH6gV1jllD3rY2HIGSZ+qMe4EcwfH1OT8/hofIv0ABI2rbt2y3ZKV
         DFVA==
X-Gm-Message-State: AOAM533iDU3ezvaM4loIES0rjFOK9ca/IguLXd7V8vDZsRn4yuYKQB5V
        iiO/2akYWwF97w1MALvFBNGDHts5GRLRzptU8oy9JBKqwnTbSJHKv/MIhAAOiznsOjSVZbEP+h3
        Shrm8fFlC0wzBb0a3neKSO/KK7PJ//k7nulZ5BbV1Iop0NsOtwzlTNs2D9eq31HW0NFskmVCH4x
        AxxLdM5KN0iSpcMZjC
X-Google-Smtp-Source: ABdhPJwqPVROgyrD7pYkUsV1/xGbrktwuk/s14Ma2EcuOQZoEw8sy3gErs3HQmoi1wKgSOxsu4yCsxcTWb9NA+YV3R4t
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:c791:: with SMTP id
 w139mr23204942ybe.345.1598472721893; Wed, 26 Aug 2020 13:12:01 -0700 (PDT)
Date:   Wed, 26 Aug 2020 13:11:45 -0700
In-Reply-To: <20200826201147.1908411-1-danielwinkler@google.com>
Message-Id: <20200826131103.Bluez.v1.1.Idf2f9f409a4df20b466ba723dd9b729275a5afbf@changeid>
Mime-Version: 1.0
References: <20200826201147.1908411-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [Bluez PATCH v1 1/3] PRE_UPSTREAM: advertising: Add SupportedFeatures
 to LEAdvertisingManager1
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
verify that SupportedFeatures are populated when extended
advertising is available only.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

 lib/mgmt.h        |  2 ++
 src/advertising.c | 56 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 56 insertions(+), 2 deletions(-)

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
index e5f25948d..9853baa4e 100644
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
 
@@ -1345,12 +1346,63 @@ static gboolean get_supported_secondary(const GDBusPropertyTable *property,
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
+static gboolean display_features(const GDBusPropertyTable *property,
+						void *data)
+{
+	struct btd_adv_manager *manager = data;
+
+	/* Currently, all displayed features are supported if hardware
+	 * offloading is available, so this is used to determine if we
+	 * should display the feature list
+	 */
+	return manager->supported_flags & (MGMT_ADV_FLAG_HW_OFFLOAD);
+}
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
+	{ "SupportedFeatures", "as", get_supported_features, NULL,
+							display_features },
 	{ }
 };
 
-- 
2.28.0.297.g1956fa8f8d-goog

