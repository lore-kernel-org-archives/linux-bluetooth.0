Return-Path: <SRS0=i/J9=5R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5C9C43331
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 22:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A741C20719
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 22:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="asBdPD6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732849AbgDAWNj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Apr 2020 18:13:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37354 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732537AbgDAWNj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Apr 2020 18:13:39 -0400
Received: by mail-pg1-f193.google.com with SMTP id i34so832646pgl.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2020 15:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+xr2rEcqkTvnh0oYOe3jlueoi2NAyuaNMHum7SWLrDc=;
        b=asBdPD6Vp0Q50ivPa6Mi23j8RX8iJuojMKd23NWBeZQvokLFXD3m63BI/ryn+lJAJs
         DEbxBUp7NMVzqCUSt+rhoJfdLnxd6RteNVY82xSVbXv2Yzyw7TCNiUW76L6xolasZGX9
         ItZ1GZ72Ri9cYuXQgaIZgN4VRQqGUKCIpQNJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+xr2rEcqkTvnh0oYOe3jlueoi2NAyuaNMHum7SWLrDc=;
        b=AXfFp3cfR9TRapVQU/Pb4+UQyDuBMG9/16n8bHtaHvGCO/aw65jqr8k4PQmS6/C+Xh
         zsHE/vkTjbfroVf2XqRT9rgqp0NnccLha4fycUzleJC3gXuTBWp4KzJouyLXteTeaHlf
         6F3edbZu8Y1EDwMVmfMB8SDANN/FTjZnbnLdyPFZUwONVrHyA/bjnopJPQa1f1dDOA/c
         FaA8aYmWY/JY+bh4Y8wim2fdi7n4KCwqCkJPrHPNHUuTFFRGer7R+GL2jW8FlAm3Ap79
         XyNAIhj4eVrbZ0XQlo0tLSyKBw213B44irqQaCW0mo7KDppHko88G/EHtAnSuCIW0N3N
         oubA==
X-Gm-Message-State: AGi0PuYoIKzU6/CQ5vej9fVqBAzz1Umdmjm3HZHJSbk6OOl1du2+7ggI
        q/UM8e21mLz6JTdfds/6ZgDsOKCXBrg=
X-Google-Smtp-Source: APiQypI+uOZpRBU0tE3RnlqjHMb3Vb5L263ZCl8gsDJowPgEQ/N1YRo3xlRBs/qVevDXunbrEBTR9Q==
X-Received: by 2002:aa7:919a:: with SMTP id x26mr21739216pfa.39.1585779217770;
        Wed, 01 Apr 2020 15:13:37 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:b7e2:9910:bd78:608d])
        by smtp.gmail.com with ESMTPSA id f15sm2265366pfd.215.2020.04.01.15.13.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 15:13:37 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Eric Caruso <ejcaruso@chromium.org>
Subject: [PATCH] device: Add device type property
Date:   Wed,  1 Apr 2020 15:13:20 -0700
Message-Id: <20200401221320.12105-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Eric Caruso <ejcaruso@chromium.org>

This allows us to gather information about whether a device
supports BR/EDR, BLE, or both. It appears as DBus Property
"Type" on the org.bluez.Device1 interface.
---
 doc/device-api.txt |  5 +++++
 src/device.c       | 31 +++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 65d8fee37..ceb68d2f6 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -158,6 +158,11 @@ Properties	string Address [readonly]
 
 			The Bluetooth class of device of the remote device.
 
+		string Type [readonly, optional]
+
+			The carriers supported by this remote device. If it
+			exists, it can be one of "BR/EDR", "LE", or "DUAL".
+
 		uint16 Appearance [readonly, optional]
 
 			External appearance of device, as found on GAP service.
diff --git a/src/device.c b/src/device.c
index 5f9ad227d..ace9c348c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -849,6 +849,35 @@ static gboolean dev_property_get_class(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean dev_property_exists_type(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct btd_device *device = data;
+
+	return device->bredr || device->le;
+}
+
+static gboolean dev_property_get_type(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	const char *type;
+
+	if (!device->bredr && !device->le)
+		return FALSE;
+
+	if (!device->bredr)
+		type = "LE";
+	else if (!device->le)
+		type = "BR/EDR";
+	else
+		type = "DUAL";
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &type);
+
+	return TRUE;
+}
+
 static gboolean get_appearance(const GDBusPropertyTable *property, void *data,
 							uint16_t *appearance)
 {
@@ -2752,6 +2781,8 @@ static const GDBusPropertyTable device_properties[] = {
 	{ "Alias", "s", dev_property_get_alias, dev_property_set_alias },
 	{ "Class", "u", dev_property_get_class, NULL,
 					dev_property_exists_class },
+	{ "Type", "s", dev_property_get_type, NULL,
+					dev_property_exists_type },
 	{ "Appearance", "q", dev_property_get_appearance, NULL,
 					dev_property_exists_appearance },
 	{ "Icon", "s", dev_property_get_icon, NULL,
-- 
2.24.1

