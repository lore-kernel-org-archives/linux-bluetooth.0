Return-Path: <SRS0=qc6f=CZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E60C2BB84
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 23:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 852FE22208
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 23:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="fZ3CAxTf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgIPXZ5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Sep 2020 19:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgIPXZ5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Sep 2020 19:25:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F9DC06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 16:25:56 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p13so409894ybe.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 16:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=zx9Y03QWb8BNYfZ72/GnCJ0C/Svhms4y9N7CxG393LA=;
        b=fZ3CAxTfX2LjadVjg66T+bvLiW5pSHYoRjb1kbL1D6R4rTaXW8vM++LeGGpAYNWwaZ
         fFL9fnyDzCVNCQBp3jdE9NQwfe61d1QuQ4SMIIuh8MF5HGvGylgByzhEDbz5ABZCepor
         5tZI7bbZlXipSUw/KT77E/ZxJQnciLqu/t0v6ZomN81YfhM5bUEkuGc6NGH+bt/Qp8B2
         rL4Mei1UIA5D6JFmW7IFTv8cInLR/waqdze8np/B7OInc6E6gwNuFNRQO8PlAYIoVgiA
         oR+2LQUCZn7CuJI10FFA8gIW32BmC1ylcLFWzvq3WT7suttFLM8RsNph8LC8KMkgV/W+
         54bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zx9Y03QWb8BNYfZ72/GnCJ0C/Svhms4y9N7CxG393LA=;
        b=A+dEL5n0/mmbOHxeuIMhwq489kX0nJKpTUTNS7W4d9mgAdJaT5fcBr2Jf9PU4ajm0g
         n5bQZ0AzJJt8NtHbB5nwV2WVD/5d5QshjvGlTa9Yg0gaPaYfHmMQVXqb8Hg7wHTvwsY7
         MYeaN2GHQpDkQ3sRDPxlJS73JxRNxjz92xht6hsFPSSyVms7KgOf1qKWfP6KprX1NlIg
         DwRgTvKD0OOUFtOxU71t4FAaBm1C4MdgkhzalpPWSZBkrPNY1rNhGrJzOeuBF1O3eHI1
         GONJM0/lq2YmlIuuVLW8sEBpuntn+bQM79lKCUCYfaPl7piSfz3Gox0xcrrEKACCvH59
         VXkg==
X-Gm-Message-State: AOAM531sz6piR+VYGy2CwmPLhv+AZsLND1WldtQe9ZEtkybmVD2+m4eD
        i/YWlZvro5GBSsrwbA4PO0vbd2g/8IycG2orAu7b
X-Google-Smtp-Source: ABdhPJxhB4qjTqAAoBhxpCKngQTIbV+27jBJl34UL4gHdjhcBqywaNiZNm0vu5WtZD43Uw5bOmY/R5XyM5cRpsbA2FoM
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a25:6c05:: with SMTP id
 h5mr35164839ybc.433.1600298755450; Wed, 16 Sep 2020 16:25:55 -0700 (PDT)
Date:   Wed, 16 Sep 2020 16:25:34 -0700
In-Reply-To: <20200916232542.1584854-1-danielwinkler@google.com>
Message-Id: <20200916162155.Bluez.2.Ic4a3667da774f5f34477d5168a68a9280657e2da@changeid>
Mime-Version: 1.0
References: <20200916232542.1584854-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [Bluez PATCH 02/10] advertising: Parse intervals and tx power from adv
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
---

 src/advertising.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/src/advertising.c b/src/advertising.c
index 172a83907..82ee87313 100644
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
2.28.0.618.gf4bc123cb7-goog

