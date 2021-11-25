Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F953C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Nov 2021 07:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353067AbhKYHME (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Nov 2021 02:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353110AbhKYHKD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Nov 2021 02:10:03 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8BFC0613E1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Nov 2021 23:06:51 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id s6-20020a05622a018600b002b2d93b9c73so5186099qtw.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Nov 2021 23:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1JmPv41Z91ArBPDE/8zSxUM+kn7GRxB8GbDn4MVqK9I=;
        b=ckKDwxCAHL6iEO781TGHX9QR6KGRLAKqWAsOwzRV4TVwRClzjhgOuh+gFvk5dqnKx6
         wIfZDfuq8Sh+whE8qD5ycCNS3HoCm2YBz0MV5UDV1n6IkzDhkcTZGXTHqn1z7P8KYLFe
         ugNvcXKQ7cH5HEVMw+mJOo40g0Lx1Rd2/ZoGdWZV3lj64X/HMbJ1tEyhpY4NyzI4JWy1
         eROL/GUrT62CGknISDAD8DKb9mHhVc6ZE3J1qRT0BNnPdQCDRP+B5fq9YsFsatAk8iV0
         AiPcTPfjsd8AvjCSgjfEXKvi7Pu1gQ0wLCenwW7B4HS5avGShTnomiedT/cnNh/B6sZK
         grjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1JmPv41Z91ArBPDE/8zSxUM+kn7GRxB8GbDn4MVqK9I=;
        b=MSeHDHYTvmKD8oVHRTeJdmkhZQmb4CKJtSGLdc3AQdHNs8UyBeR2nCgb42SihNHU4Y
         y4MHNZYCrvaZrnF7cYDKN89+ku6IzGVpz9zKA4GBmfnlaJoiJUUmFedtLEzNmH+U8I0B
         ofdXmAA5EJgKadDGaEETyALgeE7uEJgMNcAQ/hsJ6ge5HlFNW88TDf2IwGvg1ItyDhwl
         JCd3dDy5g3LrqvqJbEceGZLapxii70jUmtG8SBPxQhImMuByc6TfXjuLv1f6whwJAHxU
         GwfTa/f4iy0NQlTRF8stCHBN0bY9Ns4bISYTZtmVaOHcvi/gmXDrOvkImoaqmo6I71cA
         JXLw==
X-Gm-Message-State: AOAM532Z86jFPE1DdIcQAsKyGxCVC8pXtBg+rniL00otVPnrYu7gbkfF
        YVwfeGD0JoWyfkepCJR6lVQ1Ei1RBle58YT6PO2VbJvbMGk27NCcciGbs8AsAQTOGvC0dRXpETU
        q4e4yPsdBa4lsvbcXYq6hunmeYY6KN1ruKB6Jptmv1ZA2H9b4T1yVD/jyBCKF19WB2v/wpFihK6
        QY
X-Google-Smtp-Source: ABdhPJxDGLEc9gkieENdvQUV6ZIi89Lcd1wOTKhbCE7ayxYvIn1FsutSHeiOVtfA4uh8UUspFZrgJetF4iD7
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:a5d9:6769:9abb:6b2])
 (user=apusaka job=sendgmr) by 2002:a5b:783:: with SMTP id b3mr3784586ybq.328.1637824010485;
 Wed, 24 Nov 2021 23:06:50 -0800 (PST)
Date:   Thu, 25 Nov 2021 15:06:26 +0800
In-Reply-To: <20211125150558.Bluez.v4.1.I78857808e0b20c6e4dd934b174d3f1106fe3402d@changeid>
Message-Id: <20211125150558.Bluez.v4.4.Ia861c62203f9201b657a6e81f7612c5db415ac2c@changeid>
Mime-Version: 1.0
References: <20211125150558.Bluez.v4.1.I78857808e0b20c6e4dd934b174d3f1106fe3402d@changeid>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [Bluez PATCH v4 4/5] main: add configurable RemoteNameRequestRetryDelay
 parameter
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

This specifies how long will the userspace ignore a peer with an
unknown name after a failed remote name resolving procedure.

The peer device can still be connected, this only prevents the remote
name resolving procedure retry.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

Changes in v4:
* New in this version.

 src/btd.h     |  1 +
 src/device.c  |  4 +---
 src/main.c    | 19 ++++++++++++++++---
 src/main.conf |  5 +++++
 4 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/src/btd.h b/src/btd.h
index ff9f082f19..a805a40d7d 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -104,6 +104,7 @@ struct btd_opts {
 	uint32_t	tmpto;
 	uint8_t		privacy;
 	bool		device_privacy;
+	uint32_t	name_request_retry_delay;
 
 	struct btd_defaults defaults;
 
diff --git a/src/device.c b/src/device.c
index 44450b1132..0e2612825b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -79,8 +79,6 @@
 #define GATT_INCLUDE_UUID_STR "2802"
 #define GATT_CHARAC_UUID_STR "2803"
 
-#define NAME_RESOLVE_RETRY_DELAY	300 /* seconds */
-
 static DBusConnection *dbus_conn = NULL;
 static unsigned service_state_cb_id;
 
@@ -4489,7 +4487,7 @@ bool device_is_name_resolve_allowed(struct btd_device *device)
 	 */
 	return now.tv_sec < device->name_resolve_failed_time ||
 		now.tv_sec >= device->name_resolve_failed_time +
-						NAME_RESOLVE_RETRY_DELAY;
+					btd_opts.name_request_retry_delay;
 }
 
 void device_name_resolve_fail(struct btd_device *device)
diff --git a/src/main.c b/src/main.c
index 3adcdc1087..8cc2dfca61 100644
--- a/src/main.c
+++ b/src/main.c
@@ -55,9 +55,10 @@
 
 #define BLUEZ_NAME "org.bluez"
 
-#define DEFAULT_PAIRABLE_TIMEOUT       0 /* disabled */
-#define DEFAULT_DISCOVERABLE_TIMEOUT 180 /* 3 minutes */
-#define DEFAULT_TEMPORARY_TIMEOUT     30 /* 30 seconds */
+#define DEFAULT_PAIRABLE_TIMEOUT           0 /* disabled */
+#define DEFAULT_DISCOVERABLE_TIMEOUT     180 /* 3 minutes */
+#define DEFAULT_TEMPORARY_TIMEOUT         30 /* 30 seconds */
+#define DEFAULT_NAME_REQUEST_RETRY_DELAY 300 /* 5 minutes */
 
 #define SHUTDOWN_GRACE_SECONDS 10
 
@@ -82,6 +83,7 @@ static const char *supported_options[] = {
 	"JustWorksRepairing",
 	"TemporaryTimeout",
 	"Experimental",
+	"RemoteNameRequestRetryDelay",
 	NULL
 };
 
@@ -816,6 +818,16 @@ static void parse_config(GKeyFile *config)
 		g_strfreev(strlist);
 	}
 
+	val = g_key_file_get_integer(config, "General",
+					"RemoteNameRequestRetryDelay", &err);
+	if (err) {
+		DBG("%s", err->message);
+		g_clear_error(&err);
+	} else {
+		DBG("RemoteNameRequestRetryDelay=%d", val);
+		btd_opts.name_request_retry_delay = val;
+	}
+
 	str = g_key_file_get_string(config, "GATT", "Cache", &err);
 	if (err) {
 		DBG("%s", err->message);
@@ -927,6 +939,7 @@ static void init_defaults(void)
 	btd_opts.name_resolv = TRUE;
 	btd_opts.debug_keys = FALSE;
 	btd_opts.refresh_discovery = TRUE;
+	btd_opts.name_request_retry_delay = DEFAULT_NAME_REQUEST_RETRY_DELAY;
 
 	btd_opts.defaults.num_entries = 0;
 	btd_opts.defaults.br.page_scan_type = 0xFFFF;
diff --git a/src/main.conf b/src/main.conf
index 0c41d77420..49b9e67550 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -119,6 +119,11 @@
 # Defaults to false.
 #Experimental = false
 
+# The duration to avoid retrying to resolve a peer's name, if the previous
+# try failed.
+# The value is in seconds. Default is 300, i.e. 5 minutes.
+#RemoteNameRequestRetryDelay = 300
+
 [BR]
 # The following values are used to load default adapter parameters for BR/EDR.
 # BlueZ loads the values into the kernel before the adapter is powered if the
-- 
2.34.0.rc2.393.gf8c9666880-goog

