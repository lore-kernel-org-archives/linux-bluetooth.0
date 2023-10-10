Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63E2CD8CB5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Oct 2023 19:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343539AbjJJTnN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Oct 2023 15:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjJJTnM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Oct 2023 15:43:12 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A090F93
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 12:43:10 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-692c70bc440so4692806b3a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 12:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696966989; x=1697571789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LemRiCOeHqAgSXMydkH6bEiVwFdA76Apq4I6kxFgRQg=;
        b=CujX+IPiDMHMWa2Lcd3OxaIqoQGs4vl6GmJtjAdmZV99BFQY+gNgtEdIjqkmGQvO6x
         5gt/qH/IWeWUp4I+tJX1iLIivV6REk7PTpVUAxnMr/ISgcx0BcCJ+YrZMe6FHvD6nH1z
         KbFZ0Uw+pegTcO5ljd8Pw/B4mpY2gLeeWq63CgBnNJE4qJcFNqB+5aYxtpsG56saaBqf
         xQRHC8+VVqbmUcMVB3ET9gxSTT5cj1beVGG9V1jg4jzRJ6548myj+Ga6jAtTjVtEY3Yt
         GnslyzwZeiXsHXSJrNUrtUVws9HzAn8cqrerdhQEGYy+oydmvj068fJL0U4jTxZpdnNH
         Kk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696966989; x=1697571789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LemRiCOeHqAgSXMydkH6bEiVwFdA76Apq4I6kxFgRQg=;
        b=NLpDdstFXjapaEplAYTXJq2IWjHxrzJvBBCHVbpvE0JSK/GA5SS6fnyhFIpKX41vaY
         rZWzmEkWHHGFm2tgUUbON1y037dRHgbRV3xxZxChjIESIURds1YdiFQaJzRXQdXA2gWE
         1W9Kqv3bapbPO1bKrBnW9ia2vtEezqUereljFayCvZC9Z2MbL5WpTzx4HIFXWXJ3VVli
         BDAZmSW1mDyL4X5erY8txiNdn5bjmF0/ZVairwBv9iWxECiymrrGzVsa9H7dzDfFu5et
         SvTnKo63GLJkBTShJoml7Oghu9cf96jPengWlMhOdaHg3oUqoOExYiCy3nQjByr/qjaE
         VU/w==
X-Gm-Message-State: AOJu0YzGcTpY1nJxvueG0ZXU5yaqqSbWwSelrca3RtHMtTJoq3vJ9YSC
        8qhJ0fQ/Zafs/EZ/zebQrXklH4JfdXPOl/f0
X-Google-Smtp-Source: AGHT+IGFqlGMhwciJ3UIsexYEvKIvP3lSXn5uXeFATZFxJyhqd0LpaFqyytbkOyg6h2GhDmscOKLPA==
X-Received: by 2002:a05:6a00:1392:b0:692:6d3f:483f with SMTP id t18-20020a056a00139200b006926d3f483fmr19846797pfg.27.1696966989134;
        Tue, 10 Oct 2023 12:43:09 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id c4-20020a62e804000000b00690c9fda0fesm8581275pfi.169.2023.10.10.12.43.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 12:43:08 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] input: Fix .device_probe failing if SDP record is not found
Date:   Tue, 10 Oct 2023 12:43:06 -0700
Message-ID: <20231010194306.603745-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Due to changes introduced by 67a26abe53bf
("profile: Add probe_on_discover flag") profiles may get probed when
their profile UUID are discovered, rather than resolved, which means
the SDP record may not be available.

Fixes: https://github.com/bluez/bluez/issues/614
---
 profiles/input/device.c | 182 +++++++++++++++++++---------------------
 1 file changed, 84 insertions(+), 98 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index e2ac6ea60352..4a50ea9921a9 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -60,7 +60,7 @@ struct input_device {
 	char			*path;
 	bdaddr_t		src;
 	bdaddr_t		dst;
-	uint32_t		handle;
+	const sdp_record_t	*rec;
 	GIOChannel		*ctrl_io;
 	GIOChannel		*intr_io;
 	guint			ctrl_watch;
@@ -754,7 +754,8 @@ static void epox_endian_quirk(unsigned char *data, int size)
 	}
 }
 
-static int create_hid_dev_name(sdp_record_t *rec, struct hidp_connadd_req *req)
+static int create_hid_dev_name(const sdp_record_t *rec,
+					struct hidp_connadd_req *req)
 {
 	char sdesc[sizeof(req->name) / 2];
 
@@ -776,7 +777,7 @@ static int create_hid_dev_name(sdp_record_t *rec, struct hidp_connadd_req *req)
 
 /* See HID profile specification v1.0, "7.11.6 HIDDescriptorList" for details
  * on the attribute format. */
-static int extract_hid_desc_data(sdp_record_t *rec,
+static int extract_hid_desc_data(const sdp_record_t *rec,
 						struct hidp_connadd_req *req)
 {
 	sdp_data_t *d;
@@ -817,36 +818,40 @@ invalid_desc:
 	return -EINVAL;
 }
 
-static int extract_hid_record(sdp_record_t *rec, struct hidp_connadd_req *req)
+static int extract_hid_record(struct input_device *idev,
+					struct hidp_connadd_req *req)
 {
 	sdp_data_t *pdlist;
 	uint8_t attr_val;
 	int err;
 
-	err = create_hid_dev_name(rec, req);
+	if (!idev->rec)
+		return -ENOENT;
+
+	err = create_hid_dev_name(idev->rec, req);
 	if (err < 0)
 		DBG("No valid Service Name or Service Description found");
 
-	pdlist = sdp_data_get(rec, SDP_ATTR_HID_PARSER_VERSION);
+	pdlist = sdp_data_get(idev->rec, SDP_ATTR_HID_PARSER_VERSION);
 	req->parser = pdlist ? pdlist->val.uint16 : 0x0100;
 
-	pdlist = sdp_data_get(rec, SDP_ATTR_HID_DEVICE_SUBCLASS);
+	pdlist = sdp_data_get(idev->rec, SDP_ATTR_HID_DEVICE_SUBCLASS);
 	req->subclass = pdlist ? pdlist->val.uint8 : 0;
 
-	pdlist = sdp_data_get(rec, SDP_ATTR_HID_COUNTRY_CODE);
+	pdlist = sdp_data_get(idev->rec, SDP_ATTR_HID_COUNTRY_CODE);
 	req->country = pdlist ? pdlist->val.uint8 : 0;
 
-	pdlist = sdp_data_get(rec, SDP_ATTR_HID_VIRTUAL_CABLE);
+	pdlist = sdp_data_get(idev->rec, SDP_ATTR_HID_VIRTUAL_CABLE);
 	attr_val = pdlist ? pdlist->val.uint8 : 0;
 	if (attr_val)
 		req->flags |= (1 << HIDP_VIRTUAL_CABLE_UNPLUG);
 
-	pdlist = sdp_data_get(rec, SDP_ATTR_HID_BOOT_DEVICE);
+	pdlist = sdp_data_get(idev->rec, SDP_ATTR_HID_BOOT_DEVICE);
 	attr_val = pdlist ? pdlist->val.uint8 : 0;
 	if (attr_val)
 		req->flags |= (1 << HIDP_BOOT_PROTOCOL_MODE);
 
-	err = extract_hid_desc_data(rec, req);
+	err = extract_hid_desc_data(idev->rec, req);
 	if (err < 0)
 		return err;
 
@@ -1035,11 +1040,6 @@ static gboolean encrypt_notify(GIOChannel *io, GIOCondition condition,
 static int hidp_add_connection(struct input_device *idev)
 {
 	struct hidp_connadd_req *req;
-	sdp_record_t *rec;
-	char src_addr[18], dst_addr[18];
-	char filename[PATH_MAX];
-	GKeyFile *key_file;
-	char handle[11], *str;
 	GError *gerr = NULL;
 	int err;
 
@@ -1049,33 +1049,7 @@ static int hidp_add_connection(struct input_device *idev)
 	req->flags     = 0;
 	req->idle_to   = idle_timeout;
 
-	ba2str(&idev->src, src_addr);
-	ba2str(&idev->dst, dst_addr);
-
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", src_addr,
-								dst_addr);
-	sprintf(handle, "0x%8.8X", idev->handle);
-
-	key_file = g_key_file_new();
-	if (!g_key_file_load_from_file(key_file, filename, 0, &gerr)) {
-		error("Unable to load key file from %s: (%s)", filename,
-								gerr->message);
-		g_clear_error(&gerr);
-	}
-	str = g_key_file_get_string(key_file, "ServiceRecords", handle, NULL);
-	g_key_file_free(key_file);
-
-	if (!str) {
-		error("Rejected connection from unknown device %s", dst_addr);
-		err = -EPERM;
-		goto cleanup;
-	}
-
-	rec = record_from_string(str);
-	g_free(str);
-
-	err = extract_hid_record(rec, req);
-	sdp_record_free(rec);
+	err = extract_hid_record(idev, req);
 	if (err < 0) {
 		error("Could not parse HID SDP record: %s (%d)", strerror(-err),
 									-err);
@@ -1091,7 +1065,7 @@ static int hidp_add_connection(struct input_device *idev)
 
 	/* Make sure the device is bonded if required */
 	if (classic_bonded_only && !input_device_bonded(idev)) {
-		error("Rejected connection from !bonded device %s", dst_addr);
+		error("Rejected connection from !bonded device %s", idev->path);
 		goto cleanup;
 	}
 
@@ -1161,6 +1135,68 @@ static int connection_disconnect(struct input_device *idev, uint32_t flags)
 		return ioctl_disconnect(idev, flags);
 }
 
+static bool is_device_sdp_disable(const sdp_record_t *rec)
+{
+	sdp_data_t *data;
+
+	data = sdp_data_get(rec, SDP_ATTR_HID_SDP_DISABLE);
+
+	return data && data->val.uint8;
+}
+
+static enum reconnect_mode_t hid_reconnection_mode(bool reconnect_initiate,
+						bool normally_connectable)
+{
+	if (!reconnect_initiate && !normally_connectable)
+		return RECONNECT_NONE;
+	else if (!reconnect_initiate && normally_connectable)
+		return RECONNECT_HOST;
+	else if (reconnect_initiate && !normally_connectable)
+		return RECONNECT_DEVICE;
+	else /* (reconnect_initiate && normally_connectable) */
+		return RECONNECT_ANY;
+}
+
+static void extract_hid_props(struct input_device *idev,
+					const sdp_record_t *rec)
+{
+	/* Extract HID connectability */
+	bool reconnect_initiate, normally_connectable;
+	sdp_data_t *pdlist;
+
+	/* HIDNormallyConnectable is optional and assumed FALSE if not
+	 * present.
+	 */
+	pdlist = sdp_data_get(rec, SDP_ATTR_HID_RECONNECT_INITIATE);
+	reconnect_initiate = pdlist ? pdlist->val.uint8 : TRUE;
+
+	pdlist = sdp_data_get(rec, SDP_ATTR_HID_NORMALLY_CONNECTABLE);
+	normally_connectable = pdlist ? pdlist->val.uint8 : FALSE;
+
+	/* Update local values */
+	idev->reconnect_mode =
+		hid_reconnection_mode(reconnect_initiate, normally_connectable);
+}
+
+static void input_device_update_rec(struct input_device *idev)
+{
+	struct btd_profile *p = btd_service_get_profile(idev->service);
+	const sdp_record_t *rec;
+
+	rec = btd_device_get_record(idev->device, p->remote_uuid);
+	if (!rec || idev->rec == rec)
+		return;
+
+	idev->rec = rec;
+	idev->disable_sdp = is_device_sdp_disable(rec);
+
+	/* Initialize device properties */
+	extract_hid_props(idev, rec);
+
+	if (idev->disable_sdp)
+		device_set_refresh_discovery(idev->device, false);
+}
+
 static int input_device_connected(struct input_device *idev)
 {
 	int err;
@@ -1168,6 +1204,9 @@ static int input_device_connected(struct input_device *idev)
 	if (idev->intr_io == NULL || idev->ctrl_io == NULL)
 		return -ENOTCONN;
 
+	/* Attempt to update SDP record if it had changed */
+	input_device_update_rec(idev);
+
 	err = hidp_add_connection(idev);
 	if (err < 0)
 		return err;
@@ -1411,74 +1450,21 @@ int input_device_disconnect(struct btd_service *service)
 	return 0;
 }
 
-static bool is_device_sdp_disable(const sdp_record_t *rec)
-{
-	sdp_data_t *data;
-
-	data = sdp_data_get(rec, SDP_ATTR_HID_SDP_DISABLE);
-
-	return data && data->val.uint8;
-}
-
-static enum reconnect_mode_t hid_reconnection_mode(bool reconnect_initiate,
-						bool normally_connectable)
-{
-	if (!reconnect_initiate && !normally_connectable)
-		return RECONNECT_NONE;
-	else if (!reconnect_initiate && normally_connectable)
-		return RECONNECT_HOST;
-	else if (reconnect_initiate && !normally_connectable)
-		return RECONNECT_DEVICE;
-	else /* (reconnect_initiate && normally_connectable) */
-		return RECONNECT_ANY;
-}
-
-static void extract_hid_props(struct input_device *idev,
-					const sdp_record_t *rec)
-{
-	/* Extract HID connectability */
-	bool reconnect_initiate, normally_connectable;
-	sdp_data_t *pdlist;
-
-	/* HIDNormallyConnectable is optional and assumed FALSE
-	* if not present. */
-	pdlist = sdp_data_get(rec, SDP_ATTR_HID_RECONNECT_INITIATE);
-	reconnect_initiate = pdlist ? pdlist->val.uint8 : TRUE;
-
-	pdlist = sdp_data_get(rec, SDP_ATTR_HID_NORMALLY_CONNECTABLE);
-	normally_connectable = pdlist ? pdlist->val.uint8 : FALSE;
-
-	/* Update local values */
-	idev->reconnect_mode =
-		hid_reconnection_mode(reconnect_initiate, normally_connectable);
-}
-
 static struct input_device *input_device_new(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
-	struct btd_profile *p = btd_service_get_profile(service);
 	const char *path = device_get_path(device);
-	const sdp_record_t *rec = btd_device_get_record(device, p->remote_uuid);
 	struct btd_adapter *adapter = device_get_adapter(device);
 	struct input_device *idev;
 
-	if (!rec)
-		return NULL;
-
 	idev = g_new0(struct input_device, 1);
 	bacpy(&idev->src, btd_adapter_get_address(adapter));
 	bacpy(&idev->dst, device_get_address(device));
 	idev->service = btd_service_ref(service);
 	idev->device = btd_device_ref(device);
 	idev->path = g_strdup(path);
-	idev->handle = rec->handle;
-	idev->disable_sdp = is_device_sdp_disable(rec);
 
-	/* Initialize device properties */
-	extract_hid_props(idev, rec);
-
-	if (idev->disable_sdp)
-		device_set_refresh_discovery(device, false);
+	input_device_update_rec(idev);
 
 	return idev;
 }
-- 
2.41.0

