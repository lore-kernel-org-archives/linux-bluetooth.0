Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44806C433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Nov 2021 07:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353483AbhKYHL6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Nov 2021 02:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348674AbhKYHJ5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Nov 2021 02:09:57 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C7AC0613E0
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Nov 2021 23:06:45 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id h8-20020a05622a170800b002acc8656e05so5187092qtk.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Nov 2021 23:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JVVmti1TF4GHlNN4453/y/m8aUQmdPpZK7g3QRcNjfg=;
        b=RRLbabke3uOltGkI4HXHdBLLDD/J3v3jKSIMitbT7iojTmSQEIQyle6U6uYNwW5PKp
         OygKWk8XZii+9KRwnO7W5MLI8JggPM7GFWk0py4fbT6wzLOgWLSFDQhCRLhgbfIjME8n
         CS9Ado2tT/Yt1pzMZtFMCetjtUa+eYYcwSpXnPieP9W+LXeeT/j4bVV+qBe6Wj4x0/b1
         poNit4M+d5KZWEF8NlwURFBCtidQozMYzue+MYLuPVkf+RJjCi057+ZfhSsZqNzylWR6
         rJVBf5M9D/wLwOT0HJTvJ/XtfD+bLl5m4nsQz88KBysGkBOUp26htniHWXrmEiUaL8rR
         jpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JVVmti1TF4GHlNN4453/y/m8aUQmdPpZK7g3QRcNjfg=;
        b=2ACeqhVmif1aJDMLL82521w09eOhZOxe2VDX95nYYWnyjBByjqcE5dMcVFT1+dQIZn
         FINCOOp92di6pZe0AR0ZF1qGwPqe3pg82ds7rMqqcZFtA1prHXq5YY//tpgvqvzI9rLH
         Fqa+MkWLD6R3Zuz4yiuv4XrGtQu5/+TpFpS0z23+ibAnNf0ZcJHc0MmqPOZu7EjsBK7F
         VXWc1A4U2otWdA17ftqEMLkl79OdK+qW/wq8NJkF+9ltmBOxWjwm0uSjgKg1tFU7K6NB
         sQztLbY07Wyk6XhampFyy03aVZIT+8Gp/5J/LcMO63IbQPKtJVPcBAi2HK0nMaKUpi1S
         L94Q==
X-Gm-Message-State: AOAM532RRAP3r6QXbocXXgUFGF0HwGCjSQ98cK0VszH+FUtWBprmDHVe
        1VJI89cRLCIhrcj6w/IIBUI94L5qCk1LM5C+BAXmrPEjRNuwTsLGttmGPRZB8qic9UKte4awj7o
        zdgQL/txbe4Gwseul5SxpCR6mmsLS+1gQ5mXtbQ7xihYQ4jgcV1fVBx0koxrnpKLGZOw15+Djv8
        AH
X-Google-Smtp-Source: ABdhPJxQKLePo8y6Qsv6mGMYHVmmrIZjJjPlrvxuIJUac40AzF9UhGoberfIpp3vpqc+N+niQXUJYiXuGDc+
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:a5d9:6769:9abb:6b2])
 (user=apusaka job=sendgmr) by 2002:a25:b911:: with SMTP id
 x17mr3955460ybj.247.1637824004438; Wed, 24 Nov 2021 23:06:44 -0800 (PST)
Date:   Thu, 25 Nov 2021 15:06:25 +0800
In-Reply-To: <20211125150558.Bluez.v4.1.I78857808e0b20c6e4dd934b174d3f1106fe3402d@changeid>
Message-Id: <20211125150558.Bluez.v4.3.I08d192861aa6b2025fbc575a7e0caffaa6170ed5@changeid>
Mime-Version: 1.0
References: <20211125150558.Bluez.v4.1.I78857808e0b20c6e4dd934b174d3f1106fe3402d@changeid>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [Bluez PATCH v4 3/5] device: Save remote name request attempts into
 cache file
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

Since a peer device is potentially removed if not discovered for more
than 30 seconds, we would lost the remote name request activity when
the device is rediscovered. This could end up with a remote name
request much sooner than we intend it to be.

Therefore, put the RNR record into a cache file, so we can recover it
when the peer device is rediscovered.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

Changes in v4:
* Modify cache to support changes in previous patch

 src/device.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 91 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index a83cb61f8c..44450b1132 100644
--- a/src/device.c
+++ b/src/device.c
@@ -567,6 +567,59 @@ void device_store_cached_name(struct btd_device *dev, const char *name)
 	g_key_file_free(key_file);
 }
 
+static void device_store_cached_name_resolve(struct btd_device *dev)
+{
+	char filename[PATH_MAX];
+	char d_addr[18];
+	GKeyFile *key_file;
+	GError *gerr = NULL;
+	char *data;
+	char *data_old;
+	gsize length = 0;
+	gsize length_old = 0;
+	uint64_t failed_time;
+
+	if (device_address_is_private(dev)) {
+		DBG("Can't store name resolve for private addressed device %s",
+								dev->path);
+		return;
+	}
+
+	ba2str(&dev->bdaddr, d_addr);
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s",
+			btd_adapter_get_storage_dir(dev->adapter), d_addr);
+	create_file(filename, 0600);
+
+	key_file = g_key_file_new();
+	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
+		error("Unable to load key file from %s: (%s)", filename,
+								gerr->message);
+		g_error_free(gerr);
+	}
+
+	failed_time = (uint64_t) dev->name_resolve_failed_time;
+
+	data_old = g_key_file_to_data(key_file, &length_old, NULL);
+
+	g_key_file_set_uint64(key_file, "NameResolving", "FailedTime",
+								failed_time);
+
+	data = g_key_file_to_data(key_file, &length, NULL);
+
+	if ((length != length_old) || (memcmp(data, data_old, length))) {
+		if (!g_file_set_contents(filename, data, length, &gerr)) {
+			error("Unable set contents for %s: (%s)", filename,
+								gerr->message);
+			g_error_free(gerr);
+		}
+	}
+
+	g_free(data);
+	g_free(data_old);
+
+	g_key_file_free(key_file);
+}
+
 static void browse_request_free(struct browse_req *req)
 {
 	struct btd_device *device = req->device;
@@ -3304,6 +3357,32 @@ failed:
 	return str;
 }
 
+static void load_cached_name_resolve(struct btd_device *device,
+					const char *local, const char *peer)
+{
+	char filename[PATH_MAX];
+	GKeyFile *key_file;
+	uint64_t failed_time;
+
+	if (device_address_is_private(device))
+		return;
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", local, peer);
+
+	key_file = g_key_file_new();
+
+	if (!g_key_file_load_from_file(key_file, filename, 0, NULL))
+		goto failed;
+
+	failed_time = g_key_file_get_uint64(key_file, "NameResolving",
+							"FailedTime", NULL);
+
+	device->name_resolve_failed_time = failed_time;
+
+failed:
+	g_key_file_free(key_file);
+}
+
 static struct csrk_info *load_csrk(GKeyFile *key_file, const char *group)
 {
 	struct csrk_info *csrk;
@@ -4311,6 +4390,7 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 	struct btd_device *device;
 	char dst[18];
 	char *str;
+	const char *storage_dir;
 
 	ba2str(bdaddr, dst);
 	DBG("dst %s", dst);
@@ -4326,13 +4406,15 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 	else
 		device->le = true;
 
-	str = load_cached_name(device, btd_adapter_get_storage_dir(adapter),
-									dst);
+	storage_dir = btd_adapter_get_storage_dir(adapter);
+	str = load_cached_name(device, storage_dir, dst);
 	if (str) {
 		strcpy(device->name, str);
 		g_free(str);
 	}
 
+	load_cached_name_resolve(device, storage_dir, dst);
+
 	return device;
 }
 
@@ -4401,7 +4483,12 @@ bool device_is_name_resolve_allowed(struct btd_device *device)
 		return false;
 
 	clock_gettime(CLOCK_MONOTONIC, &now);
-	return now.tv_sec >= device->name_resolve_failed_time +
+
+	/* If now < failed_time, it means the clock has somehow turned back,
+	 * possibly because of system restart. Allow name request in this case.
+	 */
+	return now.tv_sec < device->name_resolve_failed_time ||
+		now.tv_sec >= device->name_resolve_failed_time +
 						NAME_RESOLVE_RETRY_DELAY;
 }
 
@@ -4414,6 +4501,7 @@ void device_name_resolve_fail(struct btd_device *device)
 
 	clock_gettime(CLOCK_MONOTONIC, &now);
 	device->name_resolve_failed_time = now.tv_sec;
+	device_store_cached_name_resolve(device);
 }
 
 void device_set_class(struct btd_device *device, uint32_t class)
-- 
2.34.0.rc2.393.gf8c9666880-goog

