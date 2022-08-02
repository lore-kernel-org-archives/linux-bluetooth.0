Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D9BC00140
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Aug 2022 16:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238063AbiHBQez (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Aug 2022 12:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237994AbiHBQer (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Aug 2022 12:34:47 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C234C616
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 Aug 2022 09:34:46 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d20so6637403pfq.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Aug 2022 09:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4FoavsV5+LBuNx4URqkD9cdDNE333qQzT7m/+eZCdx8=;
        b=DmnIFUptnd/BR5ZWvqQ3K6y4c/Ny7sMxwT0JIBbe8kPmMa1OLSgbPBbqpvkKoPsSqS
         VvahHqXx6FoSvhuzvByIaGWrWYVL2WdTPzXHXzzq6foZ6DGWBErmLb9833qLgECpTBPz
         xd6NO3nseY9IDEfMt1kCnOvl6KBy2lh0ya3jlO00OpaJ44F5Nr5e7iycJ7Q2eMyiCQkr
         qeFv2vYWm3AqjV20Z6+dsdzWcZIZB5QzI3bVw1y5jpB8vpRGOSI1nu2jUbhvjTPBpjMO
         B/UfKZYheg8lxo6dHkMK4lPSDYnPX8HWlMg899s6dABdG9JC0YdenC6WNaNtkskVvHTr
         SPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4FoavsV5+LBuNx4URqkD9cdDNE333qQzT7m/+eZCdx8=;
        b=Um41SeEyyxd0QIT6YjWmhCPXY21zvieb0/5+aT8IhXUQo4ghWPZM3+f71Nrkjls7c6
         sOrxM/8ifzMop/wTqelZnMtltgXD7snGdx5P+HoI1DaOaTu/2qKwIpiVg9APrKruqYpw
         +kDl2nef1qtM6YAj8jkj4SQsKgHVluq/8W1i2ULRFvmHFN91m+Vbryf0RPyEiEaMpEYI
         zFLrtVbzf7+B6kIBXZPoY3oVlYKzZGjOiUCZRQPbSzkBVTm7OWbkc1G3fwpUgTScb4Np
         mXkkNmfN5lZEr/vhffp/uWIfBstLpajiKHHAHf2fRZGsMqCS3S9nNw1IvcxPgaRPacrT
         gV4Q==
X-Gm-Message-State: AJIora/qtuIRz4KNW5yd7SufOU0BJMOCLuBy/QDpQ9Ty6+OzYEwkNxyb
        vJtzrRc9g3+hvO6YaCnIniACWZA3l7deWA==
X-Google-Smtp-Source: AGRyM1ugoErOpfsmxh4oJMnBlr9GhyYKNnMf6Zh3Rj3cYYlrQ/Pq7gZBbCH/E8IN+oF6fZq0H4m0YA==
X-Received: by 2002:a63:170d:0:b0:415:f76d:45e1 with SMTP id x13-20020a63170d000000b00415f76d45e1mr17708130pgl.171.1659458084716;
        Tue, 02 Aug 2022 09:34:44 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id y63-20020a62ce42000000b0052dd9dbe291sm2026149pfg.105.2022.08.02.09.34.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 09:34:42 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] device: Add btd_ prefix to device_is_trusted
Date:   Tue,  2 Aug 2022 09:34:40 -0700
Message-Id: <20220802163441.2522333-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds btd_ prefix to device_is_trusted so it can be used by
plugins.
---
 src/adapter.c       | 2 +-
 src/device.c        | 8 ++++----
 src/device.h        | 2 +-
 src/gatt-database.c | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index b159d2135..10432b734 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7334,7 +7334,7 @@ static gboolean process_auth_queue(gpointer user_data)
 			goto next;
 		}
 
-		if (device_is_trusted(device) == TRUE) {
+		if (btd_device_is_trusted(device) == TRUE) {
 			auth->cb(NULL, auth->user_data);
 			goto next;
 		}
diff --git a/src/device.c b/src/device.c
index 775003796..60762ac35 100644
--- a/src/device.c
+++ b/src/device.c
@@ -257,7 +257,7 @@ struct btd_device {
 
 	sdp_list_t	*tmp_records;
 
-	gboolean	trusted;
+	bool		trusted;
 	gboolean	blocked;
 	gboolean	auto_connect;
 	gboolean	disable_auto_connect;
@@ -826,7 +826,7 @@ bool device_is_bonded(struct btd_device *device, uint8_t bdaddr_type)
 	return state->bonded;
 }
 
-gboolean device_is_trusted(struct btd_device *device)
+bool btd_device_is_trusted(struct btd_device *device)
 {
 	return device->trusted;
 }
@@ -1163,7 +1163,7 @@ static gboolean dev_property_get_trusted(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
 	struct btd_device *device = data;
-	gboolean val = device_is_trusted(device);
+	gboolean val = btd_device_is_trusted(device);
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &val);
 
@@ -6031,7 +6031,7 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
 		 * treated as a newly discovered device.
 		 */
 		if (!device_is_paired(device, bdaddr_type) &&
-				!device_is_trusted(device))
+				!btd_device_is_trusted(device))
 			btd_device_set_temporary(device, true);
 
 		device_bonding_failed(device, status);
diff --git a/src/device.h b/src/device.h
index d7f886224..004d3a78b 100644
--- a/src/device.h
+++ b/src/device.h
@@ -88,7 +88,7 @@ gboolean device_is_temporary(struct btd_device *device);
 bool device_is_connectable(struct btd_device *device);
 bool device_is_paired(struct btd_device *device, uint8_t bdaddr_type);
 bool device_is_bonded(struct btd_device *device, uint8_t bdaddr_type);
-gboolean device_is_trusted(struct btd_device *device);
+bool btd_device_is_trusted(struct btd_device *device);
 void device_set_paired(struct btd_device *dev, uint8_t bdaddr_type);
 void device_set_unpaired(struct btd_device *dev, uint8_t bdaddr_type);
 void btd_device_set_temporary(struct btd_device *device, bool temporary);
diff --git a/src/gatt-database.c b/src/gatt-database.c
index cf651b5f5..db8432c6b 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -2989,7 +2989,7 @@ static void desc_write_cb(struct gatt_db_attribute *attrib,
 	}
 
 	if (opcode == BT_ATT_OP_PREP_WRITE_REQ) {
-		if (!device_is_trusted(device) && !desc->prep_authorized &&
+		if (!btd_device_is_trusted(device) && !desc->prep_authorized &&
 						desc->req_prep_authorization)
 			send_write(att, attrib, desc->proxy,
 					desc->pending_writes, id, value, len,
@@ -3120,7 +3120,7 @@ static void chrc_write_cb(struct gatt_db_attribute *attrib,
 		queue = NULL;
 
 	if (opcode == BT_ATT_OP_PREP_WRITE_REQ) {
-		if (!device_is_trusted(device) && !chrc->prep_authorized &&
+		if (!btd_device_is_trusted(device) && !chrc->prep_authorized &&
 						chrc->req_prep_authorization)
 			send_write(att, attrib, chrc->proxy, queue,
 					id, value, len, offset,
-- 
2.37.1

