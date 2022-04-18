Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C28C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Apr 2022 04:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236478AbiDREaH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Apr 2022 00:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiDREaG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Apr 2022 00:30:06 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE9EDF7E
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Apr 2022 21:27:28 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id i10-20020a170902e48a00b00153f493fa9aso7004169ple.17
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Apr 2022 21:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=M8MeO3rtYNrekpsED43M2F331S3C89tiDxngPJ9YSzY=;
        b=F3Ah0n4Pn8lNe3/hUDOlabcqHajTrp+GIh27Z7EeC1E84jNzf4RrT4GRTUZwBX45y2
         TB5NAjo1q3AF9qxYbp7BS5F015oFUyaZV6hd7IGXNyVlREchxqanUYNXJOynrUqzzgz1
         CALkVaQQV/5+uXcv4xVTvwUfFlcRl9VWK2pOIAQ43Oj3dJ/dUk/Ega45xvprtWEPklWa
         rKxjc/ASL9teo89I85GjxWM2ojQnNaTZzmlpMqexnQGWSgeHxMhYis58MuhRnfQtDKM8
         aiQ5PB5Fhdj2XlcibziT66pLmOanQ8XVKnP787UjV7qHvBQKuSJRbhoW3VKNuG95T7PW
         9SRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=M8MeO3rtYNrekpsED43M2F331S3C89tiDxngPJ9YSzY=;
        b=ZzTV+W4qJFERDdGT9SOJguEXZPGHBwE4jBt+jbE3JccI9XA2h+ywq/9pKwMeXXkRZ3
         qBdXzTA137LFRlUJv7YU8Cjts16JUG9Ii9QaVxrOcEQVWZxCpymMM0DEKSbZnUVDmyDK
         BWRaDvJzyYnyojlH2HuZIYMzeNc6l70DTcBJ4e9Z2Ly8O4rmg9iXkHJaOu2A4lptzH0H
         91giGmVk8ZKUUYjBBSdTaMNzn2jTPXvNPJIQOkSex8iZ9gDOz74jMTcvgBuILT9LFExf
         vUMtAmeX/qjTUW9u0lVBMARjAs2PRUW99s15kSEtmxwZGd92todO1ABUBnE5Ty1dsb9z
         8hgg==
X-Gm-Message-State: AOAM530Z+3G33kX//zVUFplwT7xxCX7yzjyfdc+hydmX0M4RZSQaVyYR
        KYVimA2r7fJ0LZaLyeCyAjbXoLmD5GRXkX5iy1XvHfSe3Buoznu0PkS7jroockreQBZshXM8ACJ
        7xH8iswm7Apv5/NgBTyEavB/6AWGrkJZYrlDo8fJ+Zn0MKZqav86aHVR35Jrg8EHt4QIeItd//7
        K5
X-Google-Smtp-Source: ABdhPJyVIRVYPtdlADAYbrTeN77IRe7FOMXap0aV7xeHK2bLdoMp5B19J4wPpdoty236Vtvj6dk38i89rttg
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a17:90a:9105:b0:1d2:9e98:7e1e with SMTP id
 k5-20020a17090a910500b001d29e987e1emr179264pjo.0.1650256047189; Sun, 17 Apr
 2022 21:27:27 -0700 (PDT)
Date:   Mon, 18 Apr 2022 04:26:33 +0000
In-Reply-To: <20220418042635.2567170-1-jiangzp@google.com>
Message-Id: <20220418042629.Bluez.v1.1.I6ab300fa4999c9310f4cb6fc09b1290edb6b2c2b@changeid>
Mime-Version: 1.0
References: <20220418042635.2567170-1-jiangzp@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [Bluez PATCH v1 1/2] device: Add "Bonded" flag to dbus property
From:   Zhengping Jiang <jiangzp@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Zhengping Jiang <jiangzp@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Yun-Hao Chung <howardchung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add "Bonded" to dbus device property table. When setting the "Bonded
flag, check the status of the Bonded property first. If the Bonded
property is changed, send property changed signal.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Yun-Hao Chung <howardchung@chromium.org>

Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---

Changes in v1:
- Add "Bonded" to D-Bus interface
- Send property changed signal if the bonded flag is changed

 doc/device-api.txt |  4 ++++
 src/device.c       | 38 +++++++++++++++++++++++++++++++++-----
 2 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 4e824d2dec17..6162755f954c 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -171,6 +171,10 @@ Properties	string Address [readonly]
 
 			Indicates if the remote device is paired.
 
+		boolean Bonded [readonly]
+
+			Indicates if the remote device is bonded.
+
 		boolean Connected [readonly]
 
 			Indicates if the remote device is currently connected.
diff --git a/src/device.c b/src/device.c
index 8dc12d026827..1a7afa8fc5c0 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1042,6 +1042,22 @@ static gboolean dev_property_get_paired(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean dev_property_get_bonded(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *dev = data;
+	dbus_bool_t val;
+
+	if (dev->bredr_state.bonded || dev->le_state.bonded)
+		val = TRUE;
+	else
+		val = FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &val);
+
+	return TRUE;
+}
+
 static gboolean dev_property_get_legacy(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -3120,6 +3136,7 @@ static const GDBusPropertyTable device_properties[] = {
 	{ "Icon", "s", dev_property_get_icon, NULL,
 					dev_property_exists_icon },
 	{ "Paired", "b", dev_property_get_paired },
+	{ "Bonded", "b", dev_property_get_bonded },
 	{ "Trusted", "b", dev_property_get_trusted, dev_property_set_trusted },
 	{ "Blocked", "b", dev_property_get_blocked, dev_property_set_blocked },
 	{ "LegacyPairing", "b", dev_property_get_legacy },
@@ -6117,14 +6134,25 @@ void device_set_bonded(struct btd_device *device, uint8_t bdaddr_type)
 	if (!device)
 		return;
 
-	DBG("");
+	struct bearer_state *state = get_state(device, bdaddr_type);
 
-	if (bdaddr_type == BDADDR_BREDR)
-		device->bredr_state.bonded = true;
-	else
-		device->le_state.bonded = true;
+	if (state->bonded)
+		return;
+
+	DBG("setting bonded for device to true");
+
+	state->bonded = true;
 
 	btd_device_set_temporary(device, false);
+
+	/* If the other bearer state was already true we don't need to
+	 * send any property signals.
+	 */
+	if (device->bredr_state.bonded == device->le_state.bonded)
+		return;
+
+	g_dbus_emit_property_changed(dbus_conn, device->path,
+						DEVICE_INTERFACE, "Bonded");
 }
 
 void device_set_legacy(struct btd_device *device, bool legacy)
-- 
2.36.0.rc0.470.gd361397f0d-goog

