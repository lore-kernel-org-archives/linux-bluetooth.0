Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD1AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Nov 2021 21:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26C4F60EE9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Nov 2021 21:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbhKEVPb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Nov 2021 17:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbhKEVPa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Nov 2021 17:15:30 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3DDC061714
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Nov 2021 14:12:49 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id y1so11804759plk.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Nov 2021 14:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pUF8cFIXRCrIuKF6pXVJj4xsEb6l2WKd0y6NYJG0m9c=;
        b=n92Gy3rhly0VtRP73BDTa0zq27mMxGMdR2kIJbGBTIKyi9ihVqpjnBiq8Wd9ChG1BA
         N3+uB5HGhT2T/htIyp9CCqO0LgGrF5CEJkarDdm7J25Cyn8ttSZGLe2xsX8tHGhGMv5f
         Cq1vl63x2L1PgXF9SdvoxOGDFN11lvv3Qb+VEjTjmPM6t8+o//ZWx7/XAIykXg17KmGe
         26+loFxwssJMk/ZUaH5fpQueUFvZKhNyGwa9gJNw87+jn9ZBgFnh9gZPH2YchAoL5pzA
         pGnkJmsD25OzjpYtnaMUbRVc+Y1UX1es88tAND4VHj52IzfmuaCPd/uDbMhmJwoWC9hy
         qU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pUF8cFIXRCrIuKF6pXVJj4xsEb6l2WKd0y6NYJG0m9c=;
        b=nhb5FUtSXK68EZcQpPP7uBoAu3mvw+LhePztLHFdArF3QMFysJjPtffN+rtzXQIZ2d
         kHx5wyzWI4bU2VY6MQzCyDeKqF0RjSb8PEZ14ZRMqlDu1WqLAcnH2S/AipygyxttM0zj
         CKQv8U5AdssS0Zm9qn+2+LV0Ry2GA0VntuM9EL+4CpZRWkd+DHZqwmeSuWO8UqB//uqY
         s29FmN9xUDUbQbi0l0hmTa8ABkCKUenfI/VUftzz1orDCRJJB4S/w/ge3ud9PqzAJ/qu
         HP+AFJUcfgo4bl3PTUKvwonlDi1zM0EGIzD0tvYhHKjvhTcvDDJtWn7TuKXEPNU0Lusy
         4amg==
X-Gm-Message-State: AOAM530NLfd5MSU68JY0I34S1qmWmRz/da0CwOjVpcUjhvOZQDJQUyp+
        q1L1KZaKRQ7JSUkpeIyNIxAoDCXFi+0=
X-Google-Smtp-Source: ABdhPJzUZqfr/q1FDnNVEjPsY4WzLm8ixLlNTC/yiJ2jEmKmNgsEmCuTqmFhQm+CCvQOc9BFjZuO+A==
X-Received: by 2002:a17:90b:105:: with SMTP id p5mr32804988pjz.60.1636146768609;
        Fri, 05 Nov 2021 14:12:48 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id om8sm2250553pjb.12.2021.11.05.14.12.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 14:12:48 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/6] main.conf: Rework privacy options
Date:   Fri,  5 Nov 2021 14:12:42 -0700
Message-Id: <20211105211245.424024-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211105211245.424024-1-luiz.dentz@gmail.com>
References: <20211105211245.424024-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This reworks privacy options so the limited discoverable is only
available when controller mode is set to dual.
---
 src/btd.h     |  1 +
 src/main.c    | 22 ++++++++++++++++++----
 src/main.conf | 25 ++++++++++++++++++++-----
 3 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/src/btd.h b/src/btd.h
index f83591f8f..ff9f082f1 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -103,6 +103,7 @@ struct btd_opts {
 	uint32_t	discovto;
 	uint32_t	tmpto;
 	uint8_t		privacy;
+	bool		device_privacy;
 
 	struct btd_defaults defaults;
 
diff --git a/src/main.c b/src/main.c
index 2835c81b2..dd954e1ab 100644
--- a/src/main.c
+++ b/src/main.c
@@ -666,13 +666,27 @@ static void parse_config(GKeyFile *config)
 	} else {
 		DBG("privacy=%s", str);
 
-		if (!strcmp(str, "network") || !strcmp(str, "on"))
+		if (!strcmp(str, "network") || !strcmp(str, "on")) {
 			btd_opts.privacy = 0x01;
-		if (!strcmp(str, "device") || !strcmp(str, "limited"))
+		} else if (!strcmp(str, "device")) {
+			btd_opts.privacy = 0x01;
+			btd_opts.device_privacy = true;
+		} else if (!strcmp(str, "limited-network")) {
+			if (btd_opts.mode != BT_MODE_DUAL) {
+				DBG("Invalid privacy option: %s", str);
+				btd_opts.privacy = 0x00;
+			}
+			btd_opts.privacy = 0x01;
+		} else if (!strcmp(str, "limited-device")) {
+			if (btd_opts.mode != BT_MODE_DUAL) {
+				DBG("Invalid privacy option: %s", str);
+				btd_opts.privacy = 0x00;
+			}
 			btd_opts.privacy = 0x02;
-		else if (!strcmp(str, "off"))
+			btd_opts.device_privacy = true;
+		} else if (!strcmp(str, "off")) {
 			btd_opts.privacy = 0x00;
-		else {
+		} else {
 			DBG("Invalid privacy option: %s", str);
 			btd_opts.privacy = 0x00;
 		}
diff --git a/src/main.conf b/src/main.conf
index 4019ea903..c82d7e648 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -67,14 +67,29 @@
 
 # Default privacy setting.
 # Enables use of private address.
-# Possible values: "off", "network/on", "device/limited"
-# "network/on": a device will only accept advertising packets from peer devices
-# that contain private addresses. It may not be compatible with some legacy
-# devices since it requires the use of RPA(s) all the time.
-# "device/limited": A device in device privacy mode is only concerned about the
+# Possible values for LE mode: "off", "network/on", "device"
+# Possible values for Dual mode: "off", "network/on", "device",
+# "limited-network", "limited-device"
+#
+# - off: Local privacy disabled.
+#
+# - network/on: A device will only accept advertising packets from peer
+# devices that contain private addresses. It may not be compatible with some
+# legacy devices since it requires the use of RPA(s) all the time.
+#
+# - device: A device in device privacy mode is only concerned about the
 # privacy of the device and will accept advertising packets from peer devices
 # that contain their Identity Address as well as ones that contain a private
 # address, even if the peer device has distributed its IRK in the past.
+
+# - limited-network: Apply Limited Discoverable Mode to advertising, which
+# follows the same policy as to BR/EDR that publishes the identity address when
+# discoverable, and Network Privacy Mode for scanning.
+#
+# - limited-device: Apply Limited Discoverable Mode to advertising, which
+# follows the same policy as to BR/EDR that publishes the identity address when
+# discoverable, and Device Privacy Mode for scanning.
+#
 # Defaults to "off"
 #Privacy = off
 
-- 
2.31.1

