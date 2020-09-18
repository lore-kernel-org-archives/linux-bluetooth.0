Return-Path: <SRS0=JXiH=C3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C619C43463
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 22:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 535DA21D7F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 22:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XlN9d5AU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgIRWOZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Sep 2020 18:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgIRWOY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Sep 2020 18:14:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC222C0613CE
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2020 15:14:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b127so6920322ybh.21
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2020 15:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=sJRM1WhxZbP9THVTVPuuP6KYJ5zZwp3ZEJNIYXffik0=;
        b=XlN9d5AUAtlD36K5CJ6mIjwdnbxvMlZ8hFITE5KCRxbHpvJ3N5nV333n4OiimGE9RW
         ijCk748AqzIUUfkDKF2K2nNB32dlXFCK1+O+YttmWeh2BH3mqliiJbt4ySps+/puICd/
         2E+bLRl407W7DV7guD531STYEjchnIV/XDhtZDj/ltKRV6GEd9qg7EiIQ4FiNAKnOFTW
         gB+QCfewrmHw4iiK1kwnnXLuDfvc+RR1wB3M2S5d1fbYZ4xI2y1SNACGpdDJ3eBAZfQv
         GuZPkHE+do69/cyKMtSxUaYHaSiC4N7I0VIHbXjtmJTCqyAD+h06L3tVCyWSGMYvOvXz
         EfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sJRM1WhxZbP9THVTVPuuP6KYJ5zZwp3ZEJNIYXffik0=;
        b=pfrf39lRUH/+VaVxuXCNS3iTlzFya4VtahIMR8g5BZk3/DLsV/VJlfD7wGvu1yYRbx
         ksh+MvHS1/lwwrO61e2clABB4FKunUbWOC3uzrcTtrcWBvSIhqRmR80YwZQkhz3pvH+3
         3On7nVmPCHNzZTXw7Lp4zgdF7MNLDnU7M1tFcs1hJYFQvvcTgaKb2RJZS3TrzirR5KTo
         ClZ50kQvsPCUkOewPnPrrFBcMDBrwHV6mVGykDmM4zJgu9UGlAz+EPBNDy5iFq1dYm5W
         OQfNE2429HS2j5+/ZEeIaXBGSUf8p66uSKfllbD/RdRxahjSowg5lZXtvpUgzDoMr+XU
         7LAA==
X-Gm-Message-State: AOAM532o/ifnYhkRl0NZ4+JS6BS+/fpm1wP3wTmpXsmAuwtuHf/QaZE9
        IkEArHexANMSZ5gEIuSZpyIdNIFQeXoTqPUX0GaB
X-Google-Smtp-Source: ABdhPJwaLqVDElqHUKvwHsbykLqT6xg2J+Yk9iz8N/JJoTLUkgJ5OwaxrySP9BPBjkk2+jWTobge7fti14eV4picAv2y
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:6a41:: with SMTP id
 f62mr24091118ybc.225.1600467263909; Fri, 18 Sep 2020 15:14:23 -0700 (PDT)
Date:   Fri, 18 Sep 2020 15:13:55 -0700
In-Reply-To: <20200918221357.3436905-1-danielwinkler@google.com>
Message-Id: <20200918151041.Bluez.v2.8.I4e536cf2c9b6c5571b4b3800dfb8338fce8e4421@changeid>
Mime-Version: 1.0
References: <20200918221357.3436905-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [Bluez PATCH v2 08/10] advertising: Expose SupportedCapabilities for advertising
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.von.dentz@intel.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Daniel Winkler <danielwinkler@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

To help our advertising clients understand the device capabilities, this
patch adds a SupportedCapabilities dbus endpoint for the advertising
manager. The primary reason behind this is to provide the valid LE tx
power range the controller supports (populated if controller supports
BT5), so a client can know the valid power range before requesting a tx
power for their advertisement.

I also thought it would be useful to indicate the max advertising data
length and scan response length in this endpoint, since some clients
will find it useful to set their advertising data (currently
experimental feature) or scan response data (possible future feature)
directly.

This patch has been tested on Hatch (BT5 support) and Kukui (No BT5
support) chromebooks to verify that the dbus endpoint contains the
correct data.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---

Changes in v2: None

 src/advertising.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/src/advertising.c b/src/advertising.c
index a3e7f3d59..a736c409f 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1632,12 +1632,46 @@ static gboolean get_supported_secondary(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean get_supported_cap(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_adv_manager *manager = data;
+	DBusMessageIter dict;
+	int16_t min_tx_power = manager->min_tx_power;
+	int16_t max_tx_power = manager->max_tx_power;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&dict);
+
+	if (min_tx_power != ADV_TX_POWER_NO_PREFERENCE)
+		dict_append_entry(&dict, "MinTxPower", DBUS_TYPE_INT16,
+				&min_tx_power);
+
+	if (max_tx_power != ADV_TX_POWER_NO_PREFERENCE)
+		dict_append_entry(&dict, "MaxTxPower", DBUS_TYPE_INT16,
+				&max_tx_power);
+
+	dict_append_entry(&dict, "MaxAdvLen", DBUS_TYPE_BYTE,
+			&manager->max_adv_len);
+	dict_append_entry(&dict, "MaxScnRspLen", DBUS_TYPE_BYTE,
+			&manager->max_scan_rsp_len);
+
+	dbus_message_iter_close_container(iter, &dict);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable properties[] = {
 	{ "ActiveInstances", "y", get_active_instances, NULL, NULL },
 	{ "SupportedInstances", "y", get_instances, NULL, NULL },
 	{ "SupportedIncludes", "as", get_supported_includes, NULL, NULL },
 	{ "SupportedSecondaryChannels", "as", get_supported_secondary, NULL,
 							secondary_exits },
+	{ "SupportedCapabilities", "a{sv}", get_supported_cap, NULL, NULL},
 	{ }
 };
 
-- 
2.28.0.681.g6f77f65b4e-goog

