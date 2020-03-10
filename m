Return-Path: <SRS0=NTC4=43=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFEAC10F25
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 02:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2A124649
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 02:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZTXf5Ab0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgCJChJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Mar 2020 22:37:09 -0400
Received: from mail-ua1-f47.google.com ([209.85.222.47]:33082 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgCJChJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Mar 2020 22:37:09 -0400
Received: by mail-ua1-f47.google.com with SMTP id 94so4130044uat.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Mar 2020 19:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cVpktEY0hpGVgHjUPRvFAW7mTx5wSpnEaAeiFQUfM/k=;
        b=ZTXf5Ab0wXojehiFoF4StDxCkM8DlKmZqZVTWhvaXCMTWMqL6XvSkJbxK4bGjm1UYI
         YyiSBESwzKZT6NK1xsrJQMIzJFcsfOyG8vhcm5eRHFvGcUnGmUSMpGr1ZJZtfagGYCu2
         3etcNyOFjOrQpslmhdRQQAdCb03gYxszJZzEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cVpktEY0hpGVgHjUPRvFAW7mTx5wSpnEaAeiFQUfM/k=;
        b=DbMlj80MOZZHTbOO6dNQTsqoX+JeVGuSgnBdZ3l3pSsCePMRg3jAr/UULiD4EwgEow
         EIaNKxlzecGkOwX+Hs2SAAITMWZE7/ZjeY8RJhIc+lvnedfBeiXH6i6knQYQUWuoSvF+
         1kq+0jZriZhQ8RRM3Dn346c67doQ+Mbyk7yMI2LmwlIhlVoopUCyT3i+vvAjSa//gX5P
         5qkijCsit4rgl7guqu0dEGFSRiSBjxs+aCcviTaoTBanZzr3ZKc5URgK2B/g0o3pdlGI
         kqkZ50URoY2ptUNlW/c4DubtwcD5C9bYsonfAigfxPDf1eEfZZnx9H5o8nViWBSDE7mq
         PqtA==
X-Gm-Message-State: ANhLgQ0urDnwTkI6i5X6kzWtSX5qUYdN2/bEG6vdnAwwZ1JV15LE7kyX
        bwYuurgxetcu1qt9nnKfDdZJIdkvWmg=
X-Google-Smtp-Source: ADFU+vtMhI5wIG+m6RH9tKJsuKZUUzCPY0B3bhnxj7CCQSCMOYTsq5n9cIqLvLsxTy0N4cP3LihNwQ==
X-Received: by 2002:a9f:3311:: with SMTP id o17mr10834028uab.30.1583807827421;
        Mon, 09 Mar 2020 19:37:07 -0700 (PDT)
Received: from alain.c.googlers.com.com (57.152.190.35.bc.googleusercontent.com. [35.190.152.57])
        by smtp.gmail.com with ESMTPSA id p24sm2767024uao.4.2020.03.09.19.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 19:37:07 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>
Subject: [BlueZ PATCH 2/2] HID accepts bonded device connections only.
Date:   Tue, 10 Mar 2020 02:35:18 +0000
Message-Id: <20200310023516.209146-3-alainm@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200310023516.209146-1-alainm@chromium.org>
References: <20200310023516.209146-1-alainm@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change adds a configuration for platforms to choose a more secure
posture for the HID profile.  While some older mice are known to not
support pairing or encryption, some platform may choose a more secure
posture by requiring the device to be bonded  and require the
connection to be encrypted when bonding is required.

Reference:
https://www.intel.com/content/www/us/en/security-center/advisory/intel-sa-00352.html
---

 profiles/input/device.c   | 23 ++++++++++++++++++++++-
 profiles/input/device.h   |  1 +
 profiles/input/input.conf |  8 ++++++++
 profiles/input/manager.c  | 13 ++++++++++++-
 4 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 2cb3811c8..7fb22b18f 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -92,6 +92,7 @@ struct input_device {
 
 static int idle_timeout = 0;
 static bool uhid_enabled = false;
+static bool br_bonded_only = false;
 
 void input_set_idle_timeout(int timeout)
 {
@@ -103,6 +104,11 @@ void input_enable_userspace_hid(bool state)
 	uhid_enabled = state;
 }
 
+void input_set_br_bonded_only(bool state)
+{
+	br_bonded_only = state;
+}
+
 static void input_device_enter_reconnect_mode(struct input_device *idev);
 static int connection_disconnect(struct input_device *idev, uint32_t flags);
 
@@ -970,8 +976,18 @@ static int hidp_add_connection(struct input_device *idev)
 	if (device_name_known(idev->device))
 		device_get_name(idev->device, req->name, sizeof(req->name));
 
+	/* Make sure the device is bonded if required */
+	if (br_bonded_only && !device_is_bonded(idev->device,
+				btd_device_get_bdaddr_type(idev->device))) {
+		error("Rejected connection from !bonded device %s", dst_addr);
+		goto cleanup;
+	}
+
 	/* Encryption is mandatory for keyboards */
-	if (req->subclass & 0x40) {
+	/* Some platforms may choose to require encryption for all devices */
+	/* Note that this only matters for pre 2.1 devices as otherwise the */
+	/* device is encrypted by default by the lower layers */
+	if (br_bonded_only || req->subclass & 0x40) {
 		if (!bt_io_set(idev->intr_io, &gerr,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 					BT_IO_OPT_INVALID)) {
@@ -1203,6 +1219,11 @@ static void input_device_enter_reconnect_mode(struct input_device *idev)
 	DBG("path=%s reconnect_mode=%s", idev->path,
 				reconnect_mode_to_string(idev->reconnect_mode));
 
+	/* Make sure the device is bonded if required */
+	if (br_bonded_only && !device_is_bonded(idev->device,
+				btd_device_get_bdaddr_type(idev->device)))
+		return;
+
 	/* Only attempt an auto-reconnect when the device is required to
 	 * accept reconnections from the host.
 	 */
diff --git a/profiles/input/device.h b/profiles/input/device.h
index 51a9aee18..aaf312f0e 100644
--- a/profiles/input/device.h
+++ b/profiles/input/device.h
@@ -29,6 +29,7 @@ struct input_conn;
 
 void input_set_idle_timeout(int timeout);
 void input_enable_userspace_hid(bool state);
+void input_set_br_bonded_only(bool state);
 
 int input_device_register(struct btd_service *service);
 void input_device_unregister(struct btd_service *service);
diff --git a/profiles/input/input.conf b/profiles/input/input.conf
index 3e1d65aae..58791b7e6 100644
--- a/profiles/input/input.conf
+++ b/profiles/input/input.conf
@@ -11,3 +11,11 @@
 # Enable HID protocol handling in userspace input profile
 # Defaults to false (HIDP handled in HIDP kernel module)
 #UserspaceHID=true
+
+# Limit HID connections to bonded devices
+# The HID Profile does not specify that devices must be bonded, however some
+# platforms may want to make sure that input connections only come from bonded
+# device connections. Several older mice have been known for not supporting
+# pairing/encryption.
+# Defaults to false to maximize device compatibility.
+#BrBondedOnly=true
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index 1d31b0652..ec45e1649 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -96,7 +96,7 @@ static int input_init(void)
 	config = load_config_file(CONFIGDIR "/input.conf");
 	if (config) {
 		int idle_timeout;
-		gboolean uhid_enabled;
+		gboolean uhid_enabled, br_bonded_only;
 
 		idle_timeout = g_key_file_get_integer(config, "General",
 							"IdleTimeout", &err);
@@ -114,6 +114,17 @@ static int input_init(void)
 			input_enable_userspace_hid(uhid_enabled);
 		} else
 			g_clear_error(&err);
+
+		br_bonded_only = g_key_file_get_boolean(config, "General",
+							"BrBondedOnly", &err);
+
+		if (!err) {
+			DBG("input.conf: BrBondedOnly=%s", br_bonded_only ?
+							"true" : "false");
+			input_set_br_bonded_only(br_bonded_only);
+		} else
+			g_clear_error(&err);
+
 	}
 
 	btd_profile_register(&input_profile);
-- 
2.25.1.481.gfbce0eb801-goog

