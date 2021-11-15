Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B1DC433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 09:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9F2E63223
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 09:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhKOJJz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Nov 2021 04:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236478AbhKOJJp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Nov 2021 04:09:45 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F717C061746
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 01:06:48 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id t24-20020a252d18000000b005c225ae9e16so25916772ybt.15
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 01:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jbHbixo7emzfL/F0ImZygG8UOnWaD9volVJgAu+usN8=;
        b=r41eLf2MZUIr3RIjxKHBY/OSqJYh1XIq9mxFXAS3JVIL4m0gO7w/PScHjTn7M97ooe
         6tbVqzpXX3VJ56pbnp4LfAWeGbLt2M7BfJ/lOAkfbIYLh5dnjzEjrB3cdySLSPwNy6rZ
         PF1CSBLrZd4Odm2hHrDUd0lBYnpWP08Zm+l6mrbOwZtAnUd580P6nFGmY1UNXjuBomt9
         rVPVVCStVlvjOfcfSRGXO6NQHOidiC3yV7WONuNXA4xjPnu+8D5WMu6/edMfMhQAhqgb
         Pva29aSPHWxlUTz285ByCKH8xV1elFe0i21Tw0Sr53NxoRbCv2EyU4X3aXsNWgRxlTVL
         PRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jbHbixo7emzfL/F0ImZygG8UOnWaD9volVJgAu+usN8=;
        b=Sm6c4A8S9ZMVFnFkJy/L+KQkTb63Iyr0nSouJ2l4PqOUlbpfDCXEHdQNVo/1legcWF
         9uG5Sx/tqSY940yLODoJFRlBDW0VKbo7cNMd1tS8WFkEE0WMj2Jh8VNVUCOC5eGeavGg
         1LOMEZj24gW3s8+O3/NIr04NJThkUhV2qZp9S+OGBvh49OUFOpdVIVb5fnrGRmM8rZIV
         Sb67UeMN9i091e8XlFkqH4zUEUVK0OCDO59c+fytFw6E9eKoN05mdNDLUxvA8wlGj7vq
         Yc25R7SNgNIVcip2zumvRqqMfwJ5mHLOqdSS3hU4hAKVOwP0yOIGiBlBEXXCyJvjEpNW
         EaAQ==
X-Gm-Message-State: AOAM533uR7hacSnRVysuMWTRFu7j4zfeoH5xutf8NQHnuH4ZTBcrC2nd
        H28Xd03npdGRjbh8ZOB3M8wiU7mlm09Y+Y9iyd3aGXqsSEDpJYOhNxd2BwlYP0TMuwVKU6SRKkr
        wJNtFrYXcKXWpCqssUA4npROPxWzGXTzSd+UQXlaVEBxZdwxIW7D7xG4OTS91jcgjE2f2hSWgIP
        4f
X-Google-Smtp-Source: ABdhPJyEjQNN/e9iMzIgleD7X+iMiaMiFewPp/r/0iHlDVXo+ZDPt5nNp6K9o2wWU4nXaFUhmfl5swfYyw6b
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:5c8f:7191:e5ca:14fb])
 (user=apusaka job=sendgmr) by 2002:a05:6902:724:: with SMTP id
 l4mr40386077ybt.544.1636967207683; Mon, 15 Nov 2021 01:06:47 -0800 (PST)
Date:   Mon, 15 Nov 2021 17:06:23 +0800
In-Reply-To: <20211115170538.Bluez.v2.1.I9fc087b25433a9347b2d8c8ff7a25fadf448ef49@changeid>
Message-Id: <20211115170538.Bluez.v2.2.I08d192861aa6b2025fbc575a7e0caffaa6170ed5@changeid>
Mime-Version: 1.0
References: <20211115170538.Bluez.v2.1.I9fc087b25433a9347b2d8c8ff7a25fadf448ef49@changeid>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [Bluez PATCH v2 2/3] device: Save remote name request attempts into
 cache file
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
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

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

(no changes since v1)

 src/device.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 94 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 699faeba3b..fa6e3abc37 100644
--- a/src/device.c
+++ b/src/device.c
@@ -568,6 +568,63 @@ void device_store_cached_name(struct btd_device *dev, const char *name)
 	g_key_file_free(key_file);
 }
 
+static void device_store_cached_name_resolve_attempts(struct btd_device *dev)
+{
+	char filename[PATH_MAX];
+	char d_addr[18];
+	GKeyFile *key_file;
+	GError *gerr = NULL;
+	char *data;
+	char *data_old;
+	gsize length = 0;
+	gsize length_old = 0;
+	uint64_t earliest_allowed;
+	unsigned int num_failures;
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
+	earliest_allowed = (uint64_t) dev->name_resolve_earliest_allow_time;
+	num_failures = dev->name_resolve_fail_count;
+
+	data_old = g_key_file_to_data(key_file, &length_old, NULL);
+
+	g_key_file_set_uint64(key_file, "NameResolve", "EarliestAllowed",
+							earliest_allowed);
+	g_key_file_set_integer(key_file, "NameResolve", "NumFailures",
+							num_failures);
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
@@ -3277,6 +3334,36 @@ failed:
 	return str;
 }
 
+static void load_cached_name_resolve_attempts(struct btd_device *device,
+					const char *local, const char *peer)
+{
+	char filename[PATH_MAX];
+	GKeyFile *key_file;
+	uint64_t earliest_allowed;
+	unsigned int num_failures;
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
+	earliest_allowed = g_key_file_get_uint64(key_file, "NameResolve",
+						"EarliestAllowed", NULL);
+	num_failures = g_key_file_get_uint64(key_file, "NameResolve",
+						"NumFailures", NULL);
+
+	device->name_resolve_earliest_allow_time = earliest_allowed;
+	device->name_resolve_fail_count = (uint8_t) num_failures;
+
+failed:
+	g_key_file_free(key_file);
+}
+
 static struct csrk_info *load_csrk(GKeyFile *key_file, const char *group)
 {
 	struct csrk_info *csrk;
@@ -4284,6 +4371,7 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 	struct btd_device *device;
 	char dst[18];
 	char *str;
+	const char *storage_dir;
 
 	ba2str(bdaddr, dst);
 	DBG("dst %s", dst);
@@ -4299,13 +4387,15 @@ struct btd_device *device_create(struct btd_adapter *adapter,
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
 
+	load_cached_name_resolve_attempts(device, storage_dir, dst);
+
 	return device;
 }
 
@@ -4382,6 +4472,8 @@ void device_name_resolve_fail(struct btd_device *device)
 	device->name_resolve_fail_count++;
 	device->name_resolve_earliest_allow_time = time(NULL) +
 		NAME_RESOLVE_RETRY_DELAY * device->name_resolve_fail_count;
+
+	device_store_cached_name_resolve_attempts(device);
 }
 
 void device_set_class(struct btd_device *device, uint32_t class)
-- 
2.34.0.rc1.387.gb447b232ab-goog

