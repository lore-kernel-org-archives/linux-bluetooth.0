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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055E0C4363D
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 01:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD70620791
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Sep 2020 01:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pPvOEbHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgIYBOG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Sep 2020 21:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgIYBOG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Sep 2020 21:14:06 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C46C0613CE
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 18:14:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p187so1134448ybg.14
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2020 18:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=tXr+Irv2G+wHqmR80OdYJ4lru+yIUHebqgkog/R/tb8=;
        b=pPvOEbHDx4I5SH0FaG9glZsFN0P6DuwORa5uKW5rhjCziGYZIkZh0a5C0M22nqlwb3
         5QlO8uiQletgvek8VoU8J4nYi0ZB/n9SQAug8K5lHo48hc8mVrcOV/GmsmRbwpnhczlU
         ucEuCcK1ySqQaq+vuKfGFmkeLxbcbTS5QsgiyB+cDVzWaQPVbnMhm1EGVylEcQScDfyD
         h5TCGsI5cYuymshhPOGeOZjahDd2ENEkERl87SN7/KWFv+h8hOE32tRSmdgCY7NjvLAl
         JgUhzDHAM8nzG6wprlCVcliMKfUN7OF3GoapE0EA2z/g3VXsmNOd5Xz6kshlrT/ErmfW
         cNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tXr+Irv2G+wHqmR80OdYJ4lru+yIUHebqgkog/R/tb8=;
        b=GWufbpm8jMxscEHQIFvVGLe/p1SpT+z4QX0WRVTzalR5KKsAdLJARCT3M9XRP1oodH
         c1QPYONgN/uoKdcjF7cjyA9W83tvGEI9acyVMMU1iNIWpdsjiY1yrIFsj58/Kbib6npv
         g2HOTuH7K6s6l393Uo1GdI+5EZBmMlqfSFkAaUiEhxL1B3+r27JlsN9vLYQnPE5v4xa1
         Xnkhq/NEiCVhAn4J13iopGLcRgooKkpSE9naK25XgK5WNGxGPZM7tOHt6lBHiFyO/WLg
         7/eqw46DBysl+T0MIDkbDXX15UZYn1p9Ro1tVW+5jHxH9ply+EniQPeCUaSE4DeyglNo
         7C/g==
X-Gm-Message-State: AOAM531uOdThKiHWz7K3/9M2ct1uIdOJ0/1PKNCB5pu5y12Xx4QHf5tK
        uvdOpChPbEDf+Cem/imX5J8DIORENH2jd8xa6oCB
X-Google-Smtp-Source: ABdhPJwQ91r4keguW1t7VL7KlQUhHIlqDRPzP3JilQn1EFbdhftkA0Z9AHK7g7CiJjnsfwIcq6XZI6GCYyClzONf5qSR
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a5b:ace:: with SMTP id
 a14mr2088803ybr.441.1600996445322; Thu, 24 Sep 2020 18:14:05 -0700 (PDT)
Date:   Thu, 24 Sep 2020 18:13:42 -0700
In-Reply-To: <20200925011347.2478464-1-danielwinkler@google.com>
Message-Id: <20200924180838.Bluez.v3.4.Ic4a3667da774f5f34477d5168a68a9280657e2da@changeid>
Mime-Version: 1.0
References: <20200925011347.2478464-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [Bluez PATCH v3 4/9] advertising: Parse intervals and tx power from adv
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

This change adds parsers for the advertising intervals and tx power
properties of the LEAdvertisement1 object. It validates that each field
adheres to the 5.2 spec, and that min and max intervals are compatible
with each other, i.e. that min interval is less than max interval.

A note here for maintainers: The tx power that is sent in the hci
parameter command is an int8_t, but as far as I can tell, there is no
clean way to use a signed 8-bit integer in dbus. The dbus byte type
seems incompatible with negative values in high-level languages (python)
without awkward usage manipulation on the client side. For this reason,
I chose to use an int16_t type for the tx power dbus field, which is
then downcasted to the int8_t in bluetoothd, which at least makes the
signed-ness of the type crystal clear to the dbus client that uses it.

This change is manually verified by ensuring the intervals and tx power
parameters are correctly parsed from the LEAdvertisement1 object, and
that the parse fails if the parameters are incorrect or not compatible
with each other.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---

Changes in v3: None
Changes in v2: None

 src/advertising.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/src/advertising.c b/src/advertising.c
index f7b379b25..c2de9fa2f 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -63,6 +63,11 @@ struct btd_adv_manager {
 #define AD_TYPE_BROADCAST 0
 #define AD_TYPE_PERIPHERAL 1
 
+/* BLUETOOTH SPECIFICATION Version 5.2 | Vol 4, Part E, page 2585
+ * defines tx power value indicating no preference
+ */
+#define ADV_TX_POWER_NO_PREFERENCE 0x7F
+
 struct btd_adv_client {
 	struct btd_adv_manager *manager;
 	char *owner;
@@ -83,6 +88,9 @@ struct btd_adv_client {
 	struct bt_ad *data;
 	struct bt_ad *scan;
 	uint8_t instance;
+	uint32_t min_interval;
+	uint32_t max_interval;
+	int8_t tx_power;
 };
 
 struct dbus_obj_match {
@@ -946,6 +954,74 @@ static bool parse_secondary(DBusMessageIter *iter,
 	return false;
 }
 
+static bool parse_min_interval(DBusMessageIter *iter,
+					struct btd_adv_client *client)
+{
+	if (!iter)
+		return false;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT32)
+		return false;
+
+	dbus_message_iter_get_basic(iter, &client->min_interval);
+
+	/* BLUETOOTH SPECIFICATION Version 5.2 | Vol 4, Part E, page 2584
+	 * defines acceptable interval range
+	 */
+	if (client->min_interval < 0x20 || client->min_interval > 0xFFFFFF) {
+		client->min_interval = 0;
+		return false;
+	}
+
+	return true;
+}
+
+static bool parse_max_interval(DBusMessageIter *iter,
+					struct btd_adv_client *client)
+{
+	if (!iter)
+		return false;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT32)
+		return false;
+
+	dbus_message_iter_get_basic(iter, &client->max_interval);
+
+	/* BLUETOOTH SPECIFICATION Version 5.2 | Vol 4, Part E, page 2584
+	 * defines acceptable interval range
+	 */
+	if (client->max_interval < 0x20 || client->max_interval > 0xFFFFFF) {
+		client->max_interval = 0;
+		return false;
+	}
+
+	return true;
+}
+
+static bool parse_tx_power(DBusMessageIter *iter,
+					struct btd_adv_client *client)
+{
+	int16_t val;
+
+	if (!iter)
+		return false;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_INT16)
+		return false;
+
+	dbus_message_iter_get_basic(iter, &val);
+
+	/* BLUETOOTH SPECIFICATION Version 5.2 | Vol 4, Part E, page 2585
+	 * defines acceptable tx power range
+	 */
+	if (val < -127 || val > 20)
+		return false;
+
+	client->tx_power = val;
+
+	return true;
+}
+
 static struct adv_parser {
 	const char *name;
 	bool (*func)(DBusMessageIter *iter, struct btd_adv_client *client);
@@ -964,6 +1040,9 @@ static struct adv_parser {
 	{ "Discoverable", parse_discoverable },
 	{ "DiscoverableTimeout", parse_discoverable_timeout },
 	{ "SecondaryChannel", parse_secondary },
+	{ "MinInterval", parse_min_interval },
+	{ "MaxInterval", parse_max_interval },
+	{ "TxPower", parse_tx_power },
 	{ },
 };
 
@@ -1092,6 +1171,13 @@ static DBusMessage *parse_advertisement(struct btd_adv_client *client)
 		goto fail;
 	}
 
+	if (client->min_interval > client->max_interval) {
+		/* Min interval must not be bigger than max interval */
+		error("MinInterval must be less than MaxInterval (%lu > %lu)",
+				client->min_interval, client->max_interval);
+		goto fail;
+	}
+
 	err = refresh_adv(client, add_adv_callback, &client->add_adv_id);
 	if (!err)
 		return NULL;
@@ -1167,6 +1253,9 @@ static struct btd_adv_client *client_create(struct btd_adv_manager *manager,
 
 	client->manager = manager;
 	client->appearance = UINT16_MAX;
+	client->tx_power = ADV_TX_POWER_NO_PREFERENCE;
+	client->min_interval = 0;
+	client->max_interval = 0;
 
 	return client;
 
-- 
2.28.0.709.gb0816b6eb0-goog

