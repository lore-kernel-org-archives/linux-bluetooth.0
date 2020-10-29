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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4987C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 23:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A7B20791
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 23:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uhqd6dBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgJ2XGk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 19:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJ2XGk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 19:06:40 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A14CC0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 16:06:40 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id q16so3308326pfj.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 16:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=EOx3zY4sv78PXdbq3qCGZpKmBh3t/np3IO11o3dWgy0=;
        b=Uhqd6dBZq6Hf4V+X9j4eCYKiH+Z1xCOVIFLmZBOZAR7tDDmY1+Cl8uLM0Ka5F2Qw/3
         1TahHs4im8yb50JGtKmsXrvIheUEnCSoI61yvR6WUNKkvsF4jB5WWRrmV3woUw1OhwVu
         FkChaWNUtB0qHyxfGaUJ05ScjUA6SRPp/qpAu7YZKm+JiypYlt3QbNt1Kh7E9i1oyVoY
         VQ79BlOif8oVJq+VsxzMC0y5CAGPJPmXKOV5mtk3kQjVwpzK1FA9avSlxKF6b6MxDbT9
         OhVkcoCmm4jKIxzYKscWuo7+rQgRd8q0gjBqWXzwtwFgNvgz+eL57jgSRmPMMMOfGzxS
         komQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EOx3zY4sv78PXdbq3qCGZpKmBh3t/np3IO11o3dWgy0=;
        b=Bd5fJNcxa4bdrFyw7bgfhU3EUEoqxXhfHs0DPN/paANfjL91Eb6240LrjRmMvbr/U6
         f8EO4zEAUrbYU54FiqiWXQWEOCNTZ5rjQ1V9m8gBhnlYZWSSEa1Ys1Q7YEXaJLrBzTcg
         tFPV+EwuySdfxISykOO/SXsiPjszQdFa2tPtgHI/nLHwoldNCoZTKwnJwHCFKziq0v+M
         cqQ95MBbnZILSWhR4uJD2sE/MYoGnpKZ4rID4oP4wxs43VKcKT8J9b2RZWjFzAt52FDZ
         wJRI48S5VNvRAUd/WLXs8dXEPgnve4E5sUcpy2JH31Iwy3FsZRUAhow62O/HUpjPWh12
         7y0g==
X-Gm-Message-State: AOAM53338foqq6g5YVct1WxxEgwbYzHO67pij/29xYKxsCiHv4wE9PCj
        IUpGficiU2TLw8QUj6N8GgeHo2X5Sps076I3EBLJ
X-Google-Smtp-Source: ABdhPJxUhr3D2sErvjpMqpj49afJtE6mzHcLU2TTJXMXyZxuzu2fRKgTdV9LGSjFUv55zgSyRiIrExZUi2ErBFVCrrU5
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:aa7:93b6:0:b029:155:3b0b:d47a with
 SMTP id x22-20020aa793b60000b02901553b0bd47amr6484486pff.47.1604012799701;
 Thu, 29 Oct 2020 16:06:39 -0700 (PDT)
Date:   Thu, 29 Oct 2020 16:06:17 -0700
In-Reply-To: <20201029230623.3630069-1-danielwinkler@google.com>
Message-Id: <20201029160317.Bluez.v6.5.Ic4a3667da774f5f34477d5168a68a9280657e2da@changeid>
Mime-Version: 1.0
References: <20201029230623.3630069-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [Bluez PATCH v6 05/10] advertising: Parse intervals and tx power from adv
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

Changes in v6: None
Changes in v5:
- Only parse new properties if experimental flag is set

Changes in v4: None
Changes in v3: None
Changes in v2: None

 src/advertising.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/src/advertising.c b/src/advertising.c
index 7c7599552..8443251bd 100644
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
+	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL))
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
+	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL))
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
+	if (!(g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL))
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

