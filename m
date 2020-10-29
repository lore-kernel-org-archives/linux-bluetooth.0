Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AA3C55178
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 23:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 369FB2076D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 23:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h60+CZ1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgJ2XGt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 19:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJ2XGs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 19:06:48 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BCEC0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 16:06:47 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id e19so2841412qtq.17
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 16:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=lKz2fQJlTyrs0uo8QPGYuVg2z+i8x82ZYum7zKbfLmY=;
        b=h60+CZ1GA8S7ghm4MOnfBRYDMtpecWq0kDjhGG32WYKiW8U6tX6eEzF3dPcd6gasJg
         RLWJqRMcnK6tTo2zpiG5OZ7FaqYr6Ab8+240qainQ7OnjqhBTOQ2r5gfLGnjRUtLlGq8
         s+Zr9gYf5SQ7LwTjI7KQxJG2wccV3CnOHrGv7ULU4ZQaaW+6Zg3z7h1ZCaCIg10k61W6
         QNEqNsk2D7l5gEqH0DqM5byXe+Cp9DZGuLMuH7cDtOkmPkDmFOHMzYfFVtM1h2H9NqY3
         Ny6lKcZZcun9/fVAUVhFZ3ChAt6rw9KPcSVEHMcEN2kTOcLyV4/WjVOOWgmg+53VAqRW
         oMag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lKz2fQJlTyrs0uo8QPGYuVg2z+i8x82ZYum7zKbfLmY=;
        b=qY5qPqEuQbze62TqwESKbOgLDiXi60vCvUoKzazarW05CRFmEp4lUKe4db7lmVEatz
         2WBD7HRyAhODbCB0YFYTugf6iobSRYhbv6NLjhvw9Q4IzyB6X2kizm55b4D1o4yTqCU0
         +/8K0Uilk+PefA/y5kGDS1HRRmZL4oV02UjlQFqbKBhiOVA5Ar1UVa6Y15xFZAo1EKex
         WIci7eVAo4AtpLBcwlx/CrdMrsopo3vTVEoDY+dhl4ay6hpl8jh+F7b0vILIfcOcAPdu
         t8QK2qvW/lH3Luezt87T4fF6hIj7BNB5c53ENdIv1TF5ibkmmhN8TsxDflEzwiYBcnOU
         XRVQ==
X-Gm-Message-State: AOAM5304ArgO3s2UAz19DFbPsMG9IB8G3w0Yzq8slYttOklNV25SOaZy
        hZBlLTEFOlvWgs8xSAMYuFCWjFaeFhZTn5HE5VCU
X-Google-Smtp-Source: ABdhPJxoe4Ha0Kx/MNnuNMpn6ZQYFE58/kXAJzWWGXdw3v96vjElDIIPctPITOxNDe32Uert9M+sKMhaABt2Qycu12US
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:ad4:4e73:: with SMTP id
 ec19mr6637357qvb.58.1604012806257; Thu, 29 Oct 2020 16:06:46 -0700 (PDT)
Date:   Thu, 29 Oct 2020 16:06:20 -0700
In-Reply-To: <20201029230623.3630069-1-danielwinkler@google.com>
Message-Id: <20201029160317.Bluez.v6.8.I4e536cf2c9b6c5571b4b3800dfb8338fce8e4421@changeid>
Mime-Version: 1.0
References: <20201029230623.3630069-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [Bluez PATCH v6 08/10] advertising: Expose SupportedCapabilities for advertising
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

Changes in v6: None
Changes in v5:
- Make SupportedCapabilities experimental

Changes in v4: None
Changes in v3: None
Changes in v2: None

 src/advertising.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/src/advertising.c b/src/advertising.c
index 9008b7813..9a0c70ff1 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1641,12 +1641,47 @@ static gboolean get_supported_secondary(const GDBusPropertyTable *property,
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
+	{ "SupportedCapabilities", "a{sv}", get_supported_cap, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL},
 	{ }
 };
 
-- 
2.29.1.341.ge80a0c044ae-goog

