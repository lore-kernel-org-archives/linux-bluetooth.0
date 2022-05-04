Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840B7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 May 2022 21:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378506AbiEDVNg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 May 2022 17:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378505AbiEDVNg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 May 2022 17:13:36 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4390B515B1
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 14:09:59 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id o8-20020a17090a9f8800b001dc9f554c7fso984076pjp.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 May 2022 14:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7PU1gWqW2ulTh1HEHniSNAgI0gD5Fj7dKsltxYqKlnY=;
        b=YFLnYQiMiij9eGvoO2gmBtRH/HmM0g+3jDZVTLgH8H5BCaJ1rz7++9eZ10unMlfngN
         fFhU7SV20qKx066870QFDIJ/Ylse/TkccHhixT7SLBQQJF93ozkAcMdRdkGOLj82hh39
         J+JQRGSLkPIyA8NYdMD9ruwjpqc43RWPDGx/MPPkOU5XZLUS/0SWTxBVDmLdJUp4oMxJ
         KD/pkwTLyyJ4UB91eY7FHi6RvuosKHxfIpHmHY0RFt3mjY29IBfxBeOGBAEy6fV+dMLo
         RLg9uMyvTKGqhVrCg7D7MZJ8gEFLHDcwVvmIfIHVAomrMeLhDQqTExv+2MMd62COMEjd
         2xdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7PU1gWqW2ulTh1HEHniSNAgI0gD5Fj7dKsltxYqKlnY=;
        b=t0OdZdQO7y88g4EGF+Hphr5jGSdJVlrKczSbd9wpEHKX0+t2aj5OnYabcbgvKACZtB
         4RKYGiOMlSJQziidkpsXUapQI5rpvKD6UWMeUAFNdmtmzh+NM+BBD5A/H16mi9Kk6c71
         i8wmFwcL7Ht70T7nKZPRCQvxCSd55627510EnlhB3RHY5lJZiUUBetnZNWC9wY0PAFk1
         xilPcXQ7X1sGxt6smBcGIzSE4cd19eysoMxSJ5uCZDwivFSrCrAow/MTyQleqWtygXB/
         pjEQRE95PjW3PxwLi2nZbTEzaXeg8wI1casYIxj6x0q77Zt66WtCgkx9QlO334yz4oo0
         eJ1Q==
X-Gm-Message-State: AOAM532FiXJ+mGcYkEHrJF8MTLPnpEvDpYu+bl5twIpbDwiU36wBtaRy
        UQ3U/j1R55PPLDcMge5Wa3bZdeB8e8YWKsOBV3ObLMljLOIzWfFWz39yqsUonceEJwceLvkyyu2
        J1MpQYRMotN9F1yX5JurJJo7maXmn1Zq5P3XfQ7Z2VC8ziy0hCI0c3khNGA4HBrQ/1X3F2eJAM2
        A7
X-Google-Smtp-Source: ABdhPJxEO43DHxak0caUrAVL/CIc2YI4szlbZWpF8BdFKNV7EtDed5aBWmI8hKm5U5gVjVlViI07+/uGAx2w
X-Received: from jiangzp-glinux-dev.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4c52])
 (user=jiangzp job=sendgmr) by 2002:a05:6a00:10cc:b0:505:ada6:e03e with SMTP
 id d12-20020a056a0010cc00b00505ada6e03emr22873341pfu.45.1651698598549; Wed,
 04 May 2022 14:09:58 -0700 (PDT)
Date:   Wed,  4 May 2022 14:09:46 -0700
In-Reply-To: <20220504210948.2968827-1-jiangzp@google.com>
Message-Id: <20220504140940.Bluez.v3.1.I6ab300fa4999c9310f4cb6fc09b1290edb6b2c2b@changeid>
Mime-Version: 1.0
References: <20220504210948.2968827-1-jiangzp@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [Bluez PATCH v3 1/3] device: Add "Bonded" flag to dbus property
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

(no changes since v2)

Changes in v2:
- Move one variable declaration to the top following C90 standard

Changes in v1:
- Add "Bonded" to D-Bus interface
- Send property changed signal if the bonded flag is changed

 src/device.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/src/device.c b/src/device.c
index a62564b14f49..72804713b25b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1143,6 +1143,22 @@ static gboolean dev_property_get_paired(const GDBusPropertyTable *property,
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
@@ -4033,6 +4049,7 @@ static const GDBusPropertyTable device_properties[] = {
 	{ "Icon", "s", dev_property_get_icon, NULL,
 					dev_property_exists_icon },
 	{ "Paired", "b", dev_property_get_paired },
+	{ "Bonded", "b", dev_property_get_bonded },
 	{ "Trusted", "b", dev_property_get_trusted, dev_property_set_trusted },
 	{ "Blocked", "b", dev_property_get_blocked, dev_property_set_blocked },
 	{ "LegacyPairing", "b", dev_property_get_legacy },
@@ -7065,14 +7082,25 @@ void device_set_bonded(struct btd_device *device, uint8_t bdaddr_type)
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
2.36.0.464.gb9c8b46e94-goog

