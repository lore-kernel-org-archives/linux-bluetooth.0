Return-Path: <SRS0=qc6f=CZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5058C43461
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 23:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A62222208
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 23:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="NzopJ8vm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgIPX0F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Sep 2020 19:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgIPX0E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Sep 2020 19:26:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4724EC06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 16:26:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g189so389018ybg.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 16:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=gLuLjClfnxVK5qrLMV6N0yEMaNbvlz3r2lsErbvwRmM=;
        b=NzopJ8vmUcd4umxiXHqIoXJOUPhjs8z6IyuvpxHLydN8ltvQqj3a87Mp6j+voWuEZB
         rmdxdQpPwMaD5wrPpxBiPiE6feJrgDwXN5X8toVCPHaYILmhlcIqE2VnkRIt29WhcLpq
         tMv+85aEeYzHRuvBhqoa5aUu27WENKif9S3VtYjx5Izj5qNYyQ1SWtZhhb6pwmMN+eeX
         rfVbM2rff7PH553UnIPI9LBCy4MfoGSPmsq13G7GT17tIYBxFEPP3tPd2ywq9/05z//c
         WZDkMZC6uJTYI2dwA+MsEkBQJu9PejNW0bPp3G3MMXMRZm3zTIYaNMhPgevxnhZQqirK
         J5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gLuLjClfnxVK5qrLMV6N0yEMaNbvlz3r2lsErbvwRmM=;
        b=dG3ErB+OVswD77+onlfnslDK28Q0bZai2NDPA0veAdRVoYGaAOlyoMh1Z0R9KwFmXK
         RC2Qyks7xMG0gh9nC4qIN831SJgVJ9HBZTRQr4ZT2qf/h6BesAq7SECY2IUaa3fXZxAQ
         EyX+6ZSt65kAgkX4WALYr1K7XCnYzxGbM81BVDlezHnID+nK1kNKERDHOGVOvUFF0YU9
         vuufFymr15hacEqQLI9Lrx6+1KRgKBnsEn1A3ysYamT0II8nd4WA0uGuuXIF0RkUUR8J
         Bn/j2Lvc7N553Pt7Ewame4ZiG/SZBSLd/Kwq9h7hv3xLP0tKQIiRdP0fIqIoeguzLmhN
         mWvg==
X-Gm-Message-State: AOAM533knfxD+QFUNHxvacQ4uX60TPNDbajF0P3mCDKpJhqQldzoVfPE
        hw/Kw1clAdVfLqFOpw/ZysSOlpfcKuArsE+DB7NR
X-Google-Smtp-Source: ABdhPJwmQlIQLlRdgxNjGJru8bJiaFcDYpzwIOP1A9ZgkoFRWh5b6HAuz+FTESFXl/y6aBgVnvIbmLPg1224CDt0WkNm
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:ab2b:: with SMTP id
 u40mr41014451ybi.496.1600298763531; Wed, 16 Sep 2020 16:26:03 -0700 (PDT)
Date:   Wed, 16 Sep 2020 16:25:38 -0700
In-Reply-To: <20200916232542.1584854-1-danielwinkler@google.com>
Message-Id: <20200916162155.Bluez.6.I4e536cf2c9b6c5571b4b3800dfb8338fce8e4421@changeid>
Mime-Version: 1.0
References: <20200916232542.1584854-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [Bluez PATCH 06/10] advertising: Expose SupportedCapabilities for advertising
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>
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
---

 lib/mgmt.h        |  4 ++--
 src/advertising.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index dbabb513f..5f752ecd5 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -744,8 +744,8 @@ struct mgmt_rp_add_ext_adv_data {
 	uint8_t	instance;
 } __packed;
 
-#define MGMT_CAP_LE_TX_PWR_MIN	0x0001
-#define MGMT_CAP_LE_TX_PWR_MAX	0x0002
+#define MGMT_CAP_LE_TX_PWR_MIN	0x0000
+#define MGMT_CAP_LE_TX_PWR_MAX	0x0001
 
 #define MGMT_OP_READ_CONTROLLER_CAP	0x0056
 struct mgmt_rp_read_controller_cap {
diff --git a/src/advertising.c b/src/advertising.c
index 02aa11934..df7436b1d 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1624,12 +1624,46 @@ static gboolean get_supported_secondary(const GDBusPropertyTable *property,
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
2.28.0.618.gf4bc123cb7-goog

