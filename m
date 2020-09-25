Return-Path: <SRS0=+RU5=DC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF90C4363D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 01:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCFC7207C4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 01:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WuJwIs63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgIYBOM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Sep 2020 21:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgIYBOM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Sep 2020 21:14:12 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4301CC0613CE
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 18:14:12 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id p43so688649qtb.23
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 18:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=wxrR056CY65v72fHyt/mYYzkOvLiKV45n2FXbJzFgVc=;
        b=WuJwIs63xaEBow3cc64pTdxpECH9p0We1GmbTi7MA9XjPNGnYJ2We68an56zsu3oC5
         zNP6D70cXfwU6tn6mbdMK2gZn26pGo79a8dvWPPyluYx1jeBtJDdcb+GakX3R0Iuyhku
         GBAXIEZFVgsvDDEXEaFZLItoTBGEYtRhxRwEK2CegYSuzwn8DEZ776qgVb74GpfrryRc
         covuCMt9YN8QHKoBHyPv7nhYteQ62Y6nTJovTsQ9VuZbU3I/AbN0Yiw+dcFvT93KOqmZ
         CatBhBae8dq9Svrf3BG5pj8l2sv0vBeMDsLo0AOd1qIKAvPEqZj/jm4gpmjyaZbcIoRq
         ZiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wxrR056CY65v72fHyt/mYYzkOvLiKV45n2FXbJzFgVc=;
        b=ZcoXtePQ8cNlnTzYdNQweloui1VXaikCoZwt58cZDWb8CStDaZGeDDoy4OJiNAn50y
         cGXuttYxVBVaETZIilbEb/aOrbf1l48Z8TwA2tjQmUS9xN/thXbNnFsoOl827PIWvFuc
         a0k8dvqdY6N4CiPhN61X0nDLsSHoe1+y1GzmL1sBC77ry9WcCDsVO02HURqgAthQMCRH
         JQjU1OgU2KIkYQ5LJIRs306r66RHZHO0Lgq3dHWjFa4nBrXhLqBb7mMeSo3yAedYwiRf
         dVlgDN3qSbpRIDyfdvU8aFB5SmVL4U2vEv4sfQXTqZfICQHMJJ7JdUZJ02LUqk6seH6Y
         SBJg==
X-Gm-Message-State: AOAM532vg6NiGE2hF9bLn0lq6uOSmyMKxK5meVPxWwQhp1Z1odmbrH9y
        kB1/3vAJpOCVBrm32ib0LJHbbRliYDl9tln2PMHQ
X-Google-Smtp-Source: ABdhPJxWGb3jSS44KVX3dzIzUuCnaefZQb4oPOHCP9k+eIA1EX7EUmvJj02rSaPZoOKRt+HXeXGpX/4tIpAflxtWxW1x
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a0c:cdc4:: with SMTP id
 a4mr2176129qvn.31.1600996451426; Thu, 24 Sep 2020 18:14:11 -0700 (PDT)
Date:   Thu, 24 Sep 2020 18:13:45 -0700
In-Reply-To: <20200925011347.2478464-1-danielwinkler@google.com>
Message-Id: <20200924180838.Bluez.v3.7.I4e536cf2c9b6c5571b4b3800dfb8338fce8e4421@changeid>
Mime-Version: 1.0
References: <20200925011347.2478464-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [Bluez PATCH v3 7/9] advertising: Expose SupportedCapabilities for advertising
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.von.dentz@intel.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
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

Changes in v3: None
Changes in v2: None

 src/advertising.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/src/advertising.c b/src/advertising.c
index 48b3d78b8..9ab8842c8 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1639,12 +1639,46 @@ static gboolean get_supported_secondary(const GDBusPropertyTable *property,
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
2.28.0.709.gb0816b6eb0-goog

