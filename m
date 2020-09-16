Return-Path: <SRS0=qc6f=CZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B973C433E2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 23:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E08B2220B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 23:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="OlVd74Vn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgIPX0B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Sep 2020 19:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgIPX0A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Sep 2020 19:26:00 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C24AC06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 16:26:00 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id r128so99049qkc.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 16:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=3Gv2h6Y33PNU5maObWHRnY34pFguxERvrCFOTuDaK1I=;
        b=OlVd74VnuAOjp0KkIozGsSyIwRgXhHSHBQ3Ru+dKUxnl1XvGpZppbQmdpNCn9Zpkyb
         57hRTgzG/uws5apQjfgq6H0X5pMlBPSJQjZx2zOU80evDN+P4esfYI1VO3SzojX8Tn5O
         K4LigxjDz6CGEtj7kztPVUElFrVyggwJ0MTMlUYaoqXLByRyoBtLJfw9bGO3UU04uNBA
         7UEXy3e2XND9DsCtg/5DakHbjqHhiKfnUibnD+McM4rGzpXRbltRrcraefZFJ48SaS7N
         Fd4upvA5tAd20VxKn1duFRhNYCWx/h0/VpnP/Tfajhxjwij+/ElG57RomCll3cjyMv29
         Dkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3Gv2h6Y33PNU5maObWHRnY34pFguxERvrCFOTuDaK1I=;
        b=ZnxqfaOJTu0+f92Kn4dzRbubRj90OmUzjZ0tHV9ROsUrBGTOS7y+nJYn8X8ozCwham
         9bbBhBeAFNInY7/P1QgJkMC8JV4RHlvgz0c1m4sN6Nb410+4ckgRINVsKHjEIdxh409c
         QYPnLSmRCQe4a8nhDYXOhfMo8k+o9SBeHBPvgfBtN+Ey7moMrXsgCaB7iGdyAXrNpEEu
         lumxcD3/1MzT7lZzpDBiNZ7iIQ5Ibe5PxDCWngoZMEbxRG8b4zIljFgFecD1d4jw8pgi
         ITrMj7AN/Br+60v2u5jCfdKVicxGzxQ5JkVTqxvxFJIUjpQNo79om+9ppfmewuvPHaH/
         osmg==
X-Gm-Message-State: AOAM532M8ez+cHKEE+G5wgzyIIYd1lqIUwZO6uYSJJsHT5nwVO1linJb
        5SzAwfz/Cemxj+EpM/IKYufGroXxrgzaG26HXk+Q
X-Google-Smtp-Source: ABdhPJy2cLkZ+qaqTzd2UONEmYJuM5szArdjhG3kchEo9ONpeVZCVd7vR8/hqmrsE9jP1S+nN0/jPmKaN4mTcGc2lGdT
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a0c:8c4c:: with SMTP id
 o12mr8977581qvb.46.1600298759734; Wed, 16 Sep 2020 16:25:59 -0700 (PDT)
Date:   Wed, 16 Sep 2020 16:25:36 -0700
In-Reply-To: <20200916232542.1584854-1-danielwinkler@google.com>
Message-Id: <20200916162155.Bluez.4.Ia7689bc6f45cf6b8e13a95cd1da4f96fbfc3ac14@changeid>
Mime-Version: 1.0
References: <20200916232542.1584854-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [Bluez PATCH 04/10] advertising: Catch tx power selected event and
 handle it
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

The new Tx Power Selected MGMT event will alert bluetoothd that an
advertising instance has been assigned a tx power. This is intended to
be used to then update the client of their instance's tx power.

Towards this goal, this patch does the following:
- When adv manager is created, register a handler for tx selected event
- On callback, identify the relevant advertising instance, and call for
  a property set with the new value. If the client exposes this method,
  it will be called with the new value selected by the controller.

To test, I modified the example-advertisement python script to implement
the Set dbus method, and verified that it is called after advertisement
registration on a device with extended advertising.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---

 lib/mgmt.h        |  6 ++++++
 src/advertising.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 9874be004..97f8dd9b4 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -1002,6 +1002,12 @@ struct mgmt_ev_controller_resume {
 	uint8_t wake_reason;
 } __packed;
 
+#define MGMT_EV_ADV_TX_POWER_SELECTED	0x002f
+struct mgmt_ev_adv_tx_power_selected {
+	uint8_t	instance;
+	int8_t	tx_power;
+}  __packed;
+
 static const char *mgmt_op[] = {
 	"<0x0000>",
 	"Read Version",
diff --git a/src/advertising.c b/src/advertising.c
index 008ce0073..0269c9224 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -113,6 +113,17 @@ static bool match_client(const void *a, const void *b)
 	return true;
 }
 
+static bool match_client_by_instance(const void *a, const void *b)
+{
+	const struct btd_adv_client *client = a;
+	const uint8_t *instance = b;
+
+	if (client && client->instance == *instance)
+		return true;
+
+	return false;
+}
+
 static void client_free(void *data)
 {
 	struct btd_adv_client *client = data;
@@ -1673,6 +1684,22 @@ static void read_adv_features_callback(uint8_t status, uint16_t length,
 		remove_advertising(manager, 0);
 }
 
+static void tx_power_selected(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_ev_adv_tx_power_selected *ev = param;
+	struct btd_adv_client *client;
+	struct btd_adv_manager *manager = user_data;
+	dbus_int16_t tx_power = ev->tx_power;
+
+	client = queue_find(manager->clients, match_client_by_instance,
+			&ev->instance);
+
+	if (client)
+		g_dbus_proxy_set_property_basic(client->proxy, "TxPower",
+				DBUS_TYPE_INT16, &tx_power, NULL, NULL, NULL);
+}
+
 static void read_commands_complete(uint8_t status, uint16_t length,
 				   const void *param, void *user_data)
 {
@@ -1716,6 +1743,11 @@ static void read_commands_complete(uint8_t status, uint16_t length,
 			break;
 		}
 	}
+
+	if (manager->extended_add_cmds)
+		mgmt_register(manager->mgmt, MGMT_EV_ADV_TX_POWER_SELECTED,
+			      manager->mgmt_index, tx_power_selected,
+			      manager, NULL);
 }
 
 static struct btd_adv_manager *manager_create(struct btd_adapter *adapter,
-- 
2.28.0.618.gf4bc123cb7-goog

