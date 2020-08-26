Return-Path: <SRS0=or7B=CE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC591C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 20:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAF4A2076C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 20:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="kOwGJoJB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgHZUR1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Aug 2020 16:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgHZURZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Aug 2020 16:17:25 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A1FC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2020 13:17:25 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id l67so4319214ybb.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2020 13:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=x5I31Cx/lCkc6J4SrBA8xYUW95BrqBSHcoi2qMQlDjE=;
        b=kOwGJoJBl0E1Z7mvvPzizgkigTQAhMdEY9gNuEBwiXhYb2U3fTx6Zdax9uISRnqZpW
         V/+TPYWoXwyG+QHR6cb7NekVD0O2angGGyrrz1rLNhXN9Ykf1IcboxxBuXj9i5YelPqt
         rKLlspy2/yOd47/ysP6yd0fzf8ms45tFcgdVKukhkaD/LBxqWlE+lmmV6QS4mxYyP9w4
         HdtOoDWRbr5CI2ROwVC+W6Q3dh6MgazSO/2BSRcE+oXeENVGoEDig2KgHCs5z9mQIGU3
         3pclPjCg45VUi4+6OLUJQt/PBHw9NvsnlthdoLUYwRMcsuNufCW0MEtBNK3KpimB98Pb
         lnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x5I31Cx/lCkc6J4SrBA8xYUW95BrqBSHcoi2qMQlDjE=;
        b=phhSZeQP0nKNJP9bLox1ZlUsYgfub05yHcGzyjEg9SNVgQ7c7L9i5aswovabBa3U1x
         VdDTSu+WxlbOIAhyaPOf/YBgLE6fy4RlyvVZHNvnHrGHQiuK6FcGpUK++RlWw7GGTXPP
         /msemgQnGb1lZdfdhYHocZ/I8at6J9QNycNDZuyeaeBVNiBfjALpgHYLkNb0+krGmU1s
         dQ3YTjIMRs9MrnnsLmI4fXwdgrBosCFtI62Nva7K/b8+pA2qs4iCitLcZFNKNub/DSrj
         tiXuBa8NR958p/JbFNMT9MEocAPS8NX50xKpDCYZfGety1Fy1mZ0DZ2o60IFPWDCnFYN
         i/1w==
X-Gm-Message-State: AOAM531UI+W7WMNxYgeNtl5NB+LUPja3M/pKnoWP9BxPv15V27VRXt78
        +PQ8s22UdZOwKqq+udukDz5P0CQUS91A+mrW/VkUTgjcH4vhSun//+zjErp46NlvsXfEh1vlNfE
        ha5Zc8cZKxHNM+HZ+WX9zcTvDuMFMAKfiPhPjuR/tIJI/YjHKMMe9Thuy5TfTvtuAv1T3dcEzpY
        IwgNserAbmOvU6UKs7
X-Google-Smtp-Source: ABdhPJyzWubI/t49HfmzVS/EHd+wEmNGrZHrvm1Eq7yUext2ROZJwxBxb4JLb4d56l04MKLJgSlXdCxHxDWDIFWoNNMg
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:cfcc:: with SMTP id
 f195mr24607098ybg.490.1598473044641; Wed, 26 Aug 2020 13:17:24 -0700 (PDT)
Date:   Wed, 26 Aug 2020 13:17:12 -0700
In-Reply-To: <20200826201715.1911816-1-danielwinkler@google.com>
Message-Id: <20200826131610.Bluez.v1.1.Idf2f9f409a4df20b466ba723dd9b729275a5afbf@changeid>
Mime-Version: 1.0
References: <20200826201715.1911816-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [Bluez PATCH v1 1/3] advertising: Add SupportedFeatures to LEAdvertisingManager1
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

