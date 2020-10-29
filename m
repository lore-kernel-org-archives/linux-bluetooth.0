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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF5DC55178
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 21:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38A4120838
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 21:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dwnuvDkW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgJ2VXz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 17:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgJ2VXz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 17:23:55 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEB0C0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 14:23:55 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id l188so3121722pfl.23
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 14:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=P+SDqtmg4eLZ9mT2fhiYwlVLZMV5m/3vumx5CxGCgm8=;
        b=dwnuvDkW11YTKmsQMZgTI8w2owcjkIh0Ey3qzfRtkySpH7yfAi8qUP7K9m0gcKyIE6
         93aRbgIEU6Rq38x8BzSsvhab6ekyCx11+uXOLC3G1aUkKPCSm7wv65vCJVN4L3nhLKdQ
         cdSqWKP8sT3FssbQ1Jm/0RQHO8e/jad+5xFkVY2L+w4W/PYcwDGZl4baIzW2SvaDem6f
         SRQeVmFvzvmfE+GWj3g5LcJ5rowcUdZ4DsaXoyzkeXJu6tU0PuxtjkbzleCd34ARkmYW
         DGNoCZgGyGIkWFDuyeuqGBz9O/WFjMZ3RtwKwFdNvWqiflr25w0KlSZ0j3GvmyYMXi49
         y0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=P+SDqtmg4eLZ9mT2fhiYwlVLZMV5m/3vumx5CxGCgm8=;
        b=ns7By4+pyHP/qMS4GFiSKuXwJhu4BVSJy050vk9rjKHW4qN+8odsejlt2MNRUVtET5
         g9/33ciXg9FkWHeV1jfXfTA4gUfgttc5+/azLe5yyP4ReBUe4IDkEbhIDZbXsn1xkglO
         3uyJ5UBZMB1+O/Sk6UnpkUnNryrh05xpCfFO2oIG95Y1+0xYrtdWhT6GZxenujfiu/vd
         g5nQT1aOoCtV2pf/XcYVD060gLsCb0Q13lvCYbFS6VMtI6AtNcDjWQuUZNGbB1BicpL4
         7gt6X9023EWEFM19Hml7ZKcc64ze9vKHT9pm4NRB5bAVwt2BW6WbiNi6p/uPXQP0GkUC
         fFVg==
X-Gm-Message-State: AOAM531cBdDVp/JJ3lSpnhng/CAsbo/waxULZ69QavJAGG9Q2gylQZRc
        9OdtNHISrCUK1B7nfAxUVWCdWXrSE8ijpPbpujG1
X-Google-Smtp-Source: ABdhPJzAXooqtpaZ+hh71tMrvsseHKzEy3icvc6g6KOiyR28W0od8fsCkNMt7yahPDXLICaqU27cQwTgyIAoUZ/9iV+P
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:aa7:92d4:0:b029:163:e68e:5ffb with
 SMTP id k20-20020aa792d40000b0290163e68e5ffbmr5792088pfa.40.1604006634850;
 Thu, 29 Oct 2020 14:23:54 -0700 (PDT)
Date:   Thu, 29 Oct 2020 14:23:30 -0700
In-Reply-To: <20201029212336.3283410-1-danielwinkler@google.com>
Message-Id: <20201029141832.Bluez.v5.5.Ic4a3667da774f5f34477d5168a68a9280657e2da@changeid>
Mime-Version: 1.0
References: <20201029212336.3283410-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [Bluez PATCH v5 05/10] advertising: Parse intervals and tx power from adv
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

Changes in v5:
- Only parse new properties if experimental flag is set

Changes in v4: None
Changes in v3: None
Changes in v2: None

 src/advertising.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/src/advertising.c b/src/advertising.c
index 7c7599552..25d8ba770 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -54,6 +54,11 @@ struct btd_adv_manager {
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
@@ -74,6 +79,9 @@ struct btd_adv_client {
 	struct bt_ad *data;
 	struct bt_ad *scan;
 	uint8_t instance;
+	uint32_t min_interval;
+	uint32_t max_interval;
+	int8_t tx_power;
 };
 
 struct dbus_obj_match {
@@ -937,6 +945,96 @@ static bool parse_secondary(DBusMessageIter *iter,
 	return false;
 }
 
+static bool parse_min_interval(DBusMessageIter *iter,
+					struct btd_adv_client *client)
+{
+	uint32_t min_interval_ms;
+
+	/* Only consider this property if experimental setting is applied */
+	if (!g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)
+		return true;
+
+	if (!iter)
+		return false;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT32)
+		return false;
+
+	dbus_message_iter_get_basic(iter, &min_interval_ms);
+
+	/* Convert ms to jiffies to be used in adv request */
+	client->min_interval = min_interval_ms / 0.625;
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
+	uint32_t max_interval_ms;
+
+	/* Only consider this property if experimental setting is applied */
+	if (!g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)
+		return true;
+
+	if (!iter)
+		return false;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT32)
+		return false;
+
+	dbus_message_iter_get_basic(iter, &max_interval_ms);
+
+	/* Convert ms to jiffies to be used in adv request */
+	client->max_interval = max_interval_ms / 0.625;
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
+	/* Only consider this property if experimental setting is applied */
+	if (!g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL)
+		return true;
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
@@ -955,6 +1053,9 @@ static struct adv_parser {
 	{ "Discoverable", parse_discoverable },
 	{ "DiscoverableTimeout", parse_discoverable_timeout },
 	{ "SecondaryChannel", parse_secondary },
+	{ "MinInterval", parse_min_interval },
+	{ "MaxInterval", parse_max_interval },
+	{ "TxPower", parse_tx_power },
 	{ },
 };
 
@@ -1083,6 +1184,13 @@ static DBusMessage *parse_advertisement(struct btd_adv_client *client)
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
@@ -1158,6 +1266,9 @@ static struct btd_adv_client *client_create(struct btd_adv_manager *manager,
 
 	client->manager = manager;
 	client->appearance = UINT16_MAX;
+	client->tx_power = ADV_TX_POWER_NO_PREFERENCE;
+	client->min_interval = 0;
+	client->max_interval = 0;
 
 	return client;
 
-- 
2.29.1.341.ge80a0c044ae-goog

