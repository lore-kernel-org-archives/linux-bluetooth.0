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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54987C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 21:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E897F20838
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 21:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i/+C17SH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgJ2VYD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 17:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgJ2VYD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 17:24:03 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB647C0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 14:24:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x125so4064321yba.17
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 14:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/6ckWU4P9kOQQn4bPjgVIjuXAYYlJBgep6JJu1NnBoY=;
        b=i/+C17SHZp7eXw+vkDJdmMaF/wDTufbCR3cQFRsU3B/JkSAtjA0xdKYnutSR/xBS/k
         lTrPHieG6SMQ3kL6gATMXhfE+enMkRY0egVrAtbgj8b1CV7XgMzOah6EYEgismQCvhDC
         cZ+XgCzGStDBim0f0ubTzfUhT77fS0grsRq7uGdlBxwjq5+6J0dxM5bTQvSN+n7E/W2B
         95f8S91C5/oGiw81SDqsqcsPQqTPCXLFoT+5cVGuSnOQ26QCUsT8uO9BE/QYXf6iw1fN
         nOM90Fvj5vRdq5Z/DnnClPuGt8M1tpBEspgG07nIbcb+ku1Fu3iXiytC4K/OVhyFm1Xl
         s9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/6ckWU4P9kOQQn4bPjgVIjuXAYYlJBgep6JJu1NnBoY=;
        b=HeqM+8nPfR1Oci/uC3sn+rcESmMww9Cl0N2eParYOI1Uc5rNivdW5svo/rZIidjxNT
         Gm8IESombwjw7u55QSiIzkndPyfIsFJqXeOOvR7n+6CRQ1tiv1ufKCXu49v2HQQYFGhk
         3f2hNbBl9OVC/w6P2tv3xmA7VOKuaDkJ5tI2YOjsCE7PT4z0VV0TpW+uC2rCjf0a3zK5
         HxBN/bFkwzlBUYBaLUtV49Q+EB+5HfLnkKsMxYnyT+lXhaKxWZvq4etJEQGzQJzPq9g1
         bsUP4+nmPLqqEuCrVz1wWUMeu9MjISI7zR4P57+piIEHW7lE20/dERBrLf/hV51+F0rW
         ujPg==
X-Gm-Message-State: AOAM530yK1BxtwEPKRL9bu72RFyoKPbsYiAad6TSZHGVij9YveMGII9O
        ttqUb/cBwC3niwfK3j2g5riOpchUXryms3oBDg4I
X-Google-Smtp-Source: ABdhPJxNRmrh0Gyqpv3ywdqwJjjippEClYmorC1gk6CseM4WKNM0Z5G/1YvTYIbfUa6N9yqAt1Y4r/j8khmV9uZ0ZJqs
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:2284:: with SMTP id
 i126mr8649810ybi.454.1604006641042; Thu, 29 Oct 2020 14:24:01 -0700 (PDT)
Date:   Thu, 29 Oct 2020 14:23:33 -0700
In-Reply-To: <20201029212336.3283410-1-danielwinkler@google.com>
Message-Id: <20201029141832.Bluez.v5.8.I4e536cf2c9b6c5571b4b3800dfb8338fce8e4421@changeid>
Mime-Version: 1.0
References: <20201029212336.3283410-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [Bluez PATCH v5 08/10] advertising: Expose SupportedCapabilities for advertising
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

Changes in v5:
- Make SupportedCapabilities experimental

Changes in v4: None
Changes in v3: None
Changes in v2: None

 src/advertising.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/src/advertising.c b/src/advertising.c
index 5ed2edf44..62fb3b939 100644
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

