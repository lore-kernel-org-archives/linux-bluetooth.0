Return-Path: <SRS0=rKdx=DI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E5BC4727F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 23:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64966207DE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 23:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LVc7Q/yD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733298AbgJAXCP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Oct 2020 19:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733085AbgJAXCO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Oct 2020 19:02:14 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A9CC0613D0
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2020 16:02:14 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id s12so53750pfu.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2020 16:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=maUrfGT7jy9cVJbqXYrpdONDLxxV8RzyhqkrkcruXa0=;
        b=LVc7Q/yDyoic0OxwZR1m9fScoMjTcknFfAWJs8BoUtA+SGyPsZJubCmUUpJRIOB08d
         w+cfE5en7HLZ+uuC+L7MAUjP6Hbhv4X9jfAh3gZmjqBkHkglLCYyGIkrRlt02rVnZ6Fz
         zTH+H3ZuYZrT1SOZ+SOSX6jKegaPbtDwMdzWyL23AKT59pEDk2AwrHT7wziNVeO+o0ME
         8p6F886eKMCu6wVjVYXvFAsj4R7a29IsGjALb32stLWrQAABrThaC8XnqS6ypmEyg3+5
         MXdkjDrhmbMAB07WXVsjrQXoGuPPJevLXdmGnOQgUVl+8acJyqi4CoWZ1sNIicfAvrfH
         DfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=maUrfGT7jy9cVJbqXYrpdONDLxxV8RzyhqkrkcruXa0=;
        b=MqVtAQZIJ6prYdRmu7ouE3+KYxR9cDe/6UDvsH4RZpByUZfIGKZhSJCqgAfi4VAw12
         v8gF5Y63kwMh2uOPyoGAOixZecuz0XobRnE3WxqQZoii3//sckDz9m7bHlq+LB8RQktp
         9ysSvt7WRc74M8XZT4P1HEkaWZaugoQ5IkIM8x7SZHgWayJIdX1vjUF3mhvTbjmNiZrj
         P7HnWxPVW1Vog+grLFwvryRo/nvetFELa6qHfrfuGUUi4daTZ3ppDN6Zy5i2DyqXyCrY
         kopl+ekarKtK39j91QsgXvMt/1kygqE8dxdZE5Kp0Itl8iwXt0e5XSO4Jaw8ZzzOAfSk
         RT2g==
X-Gm-Message-State: AOAM533hKV47nsj1ZqkxD+jwYh+wPSOcvYVYrvwH34rreGRhI3OCLHP7
        QWgX7YruKxWhHnYq/tmrvBHtL+o85oA7rK9Dl8ER
X-Google-Smtp-Source: ABdhPJwmsOV+VEAx3GRl+SkStsKPBkbESnclB3XuBZHitMzBN86zQ+rHphwbhpadDsye33LOXoUPwRDhuWfSEjM4WiQq
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a63:e145:: with SMTP id
 h5mr8179334pgk.334.1601593334146; Thu, 01 Oct 2020 16:02:14 -0700 (PDT)
Date:   Thu,  1 Oct 2020 16:01:50 -0700
In-Reply-To: <20201001230152.2422908-1-danielwinkler@google.com>
Message-Id: <20201001155738.Bluez.v4.8.I4e536cf2c9b6c5571b4b3800dfb8338fce8e4421@changeid>
Mime-Version: 1.0
References: <20201001230152.2422908-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [Bluez PATCH v4 08/10] advertising: Expose SupportedCapabilities for advertising
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

Changes in v4: None
Changes in v3: None
Changes in v2: None

 src/advertising.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/src/advertising.c b/src/advertising.c
index 41d0658c8..f76831594 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -1619,12 +1619,46 @@ static gboolean get_supported_secondary(const GDBusPropertyTable *property,
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

