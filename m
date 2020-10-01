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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A215CC4741F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 23:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62B7720796
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Oct 2020 23:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vaKy3dgc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733275AbgJAXCL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Oct 2020 19:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733085AbgJAXCI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Oct 2020 19:02:08 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C14C0613D0
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2020 16:02:08 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 24so49346pgm.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2020 16:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=547JYF0IMcaqv1BQTmLjD4gaRjPJdiPoacjVTjvc+Xo=;
        b=vaKy3dgcwO04Um8w2V2NAKsmKCSjwLc8L9dp/hA7IinBJSZicdETeSrGBnbUa3a9ec
         O8Us7KqEkZvVSXE00H5kH8sjrMhzGAngWwFOOeV7awa23Rn1zu7dUKQzk/mHwgFFWZcB
         Rl46WnXg9GQm3eRyyxPBrFSbXL13UCinhH5SDVCidXatMgG155+2XCkerLiIyU71pE6B
         qS+W2FMAT+qG0fqQ6fInT8KSeo/LwI+biip6A+Hb8aVwtcfbHO4FZdU8aRTcXjD+ep+x
         ZBT5lc9vbdQTnu2MKy52wNUaLDHz9SvzcJKsMOiYvIyjLk0Qw5FOLIJiQehlePMNqjOa
         C/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=547JYF0IMcaqv1BQTmLjD4gaRjPJdiPoacjVTjvc+Xo=;
        b=Hsi+KBSkJIPQHdRu0t63/oT3XbOm1WxliIlCJfT+TTtfRJ/zaIJ1LaSrOLY/CkUd0B
         nus/kijQwYAlD9oYYLeiXgG5+99jtWkZha8WLgmOShdrUTnAmIAQQR1D2cFJcI351KPA
         YzK3TZSpW3J1dK7UC0btUN6FRk1q+I4r57LmNagZWZZ0yhiBA2ZtsEn7kk/05UBSCNPH
         qd9/EtGNJWLfGFXNlshxVccLvqKz9lIE7pV+ZsecZl16fQ+QoK+PWJa0rKYxcqmiTcqH
         j/VC1kJs+l6PNbYzGhhE8WBM5BzhFoJSIv/cGrUVzoWd5jlPAWnSPYBQpXMPnNI+MvfC
         sK1w==
X-Gm-Message-State: AOAM5339zxkdVYqer1yTKzHAq+VVnPqi/WCPNAhulYia9D6fICHuRV/q
        lHb1HRqblZmiUjmc7yfHG12jAtq464qAY4h26QPb
X-Google-Smtp-Source: ABdhPJw/h4NhxVxw59pqEyKWimnzNRByLPvyaRCVio5Ksu02iiYLrGAuxbOR4mf1FQ3pilwyzRYlxHkOJtz7DJxe4kKr
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a65:400b:: with SMTP id
 f11mr7034014pgp.57.1601593327859; Thu, 01 Oct 2020 16:02:07 -0700 (PDT)
Date:   Thu,  1 Oct 2020 16:01:47 -0700
In-Reply-To: <20201001230152.2422908-1-danielwinkler@google.com>
Message-Id: <20201001155738.Bluez.v4.5.Ic4a3667da774f5f34477d5168a68a9280657e2da@changeid>
Mime-Version: 1.0
References: <20201001230152.2422908-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [Bluez PATCH v4 05/10] advertising: Parse intervals and tx power from adv
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

Changes in v4: None
Changes in v3: None
Changes in v2: None

 src/advertising.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/src/advertising.c b/src/advertising.c
index 7c7599552..3690a2aac 100644
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
@@ -937,6 +945,74 @@ static bool parse_secondary(DBusMessageIter *iter,
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
@@ -955,6 +1031,9 @@ static struct adv_parser {
 	{ "Discoverable", parse_discoverable },
 	{ "DiscoverableTimeout", parse_discoverable_timeout },
 	{ "SecondaryChannel", parse_secondary },
+	{ "MinInterval", parse_min_interval },
+	{ "MaxInterval", parse_max_interval },
+	{ "TxPower", parse_tx_power },
 	{ },
 };
 
@@ -1083,6 +1162,13 @@ static DBusMessage *parse_advertisement(struct btd_adv_client *client)
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
@@ -1158,6 +1244,9 @@ static struct btd_adv_client *client_create(struct btd_adv_manager *manager,
 
 	client->manager = manager;
 	client->appearance = UINT16_MAX;
+	client->tx_power = ADV_TX_POWER_NO_PREFERENCE;
+	client->min_interval = 0;
+	client->max_interval = 0;
 
 	return client;
 
-- 
2.28.0.709.gb0816b6eb0-goog

