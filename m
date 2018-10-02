Return-Path: <SRS0=6kNt=MO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54750C43143
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Oct 2018 08:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B36920645
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Oct 2018 08:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGMUsTTV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B36920645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbeJBPGy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:06:54 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:44001 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbeJBPGy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Oct 2018 11:06:54 -0400
Received: by mail-ed1-f54.google.com with SMTP id a4-v6so1250217eds.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Oct 2018 01:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=jkDa4A4ZXiHRp/pmUggrhp4jb499g381YUuj7h3ZrSQ=;
        b=jGMUsTTVGxB30JZsXDrYo1bLpnkH5kNzIEAZB7anRHSgBcLIWtWnKflqy2QFyIGmny
         0Nj0s9lpcQNi22MHru4948YpMJ9YFW1oyutagDcXPS88KSXBUAQk5EVS97JHbmuEfsj8
         OKmf0jEWvQ9wZ2b4aLh5+Wyv/IYUO+nPdm9i3/sXcC7qtX5FYABW+b7Vye87pmt9uFup
         YN/kLRq/JwA73l+o/3K3G970k4zjgx+bPElLYR3qZM+3mMZxk3r4OibXUqqAgyMGXOc0
         +8BZSsVHsTRZ5Bq8BI+B0tuN3W15KqT46CRub7YJUpw6cIx/sb6XKHJ6cM/MBxOs6xtB
         jjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=jkDa4A4ZXiHRp/pmUggrhp4jb499g381YUuj7h3ZrSQ=;
        b=GHauMOJkX37cUUUqFHCXCBh+xYITPh5fv80QYU+NNP+YJR+4YNsnxAuA5aBvoi8lLT
         bivg1+cMmqn+7DEWH7hdzqgmITVBdPIMRh82taxLEuCIe4PPbyb6AT2Ue2Ne6kc5InCN
         6/UOgt7ojmH3pbzXf99H5OZh6/jhjCfBeIVKOZhpFoMFCsiAAvJwPtHoXYL2T2pJlJxv
         yCuK4ownXc6mWSYFLvu4jc2BuofV2/oplwzOAodhwfh+0G8/4vZIAmorZ1F5aZkzB07A
         acjj8xPbPa0GMhO874qwtavBNA86CausXUBvgp3eckR62O0qA0tyIfciCGYic3jYNOcs
         WGVg==
X-Gm-Message-State: ABuFfojdaadErrzpgsnORi3YG0jHNsc8FCjOCz/P0oQlrtW6RCFVtsl0
        EwBbfpy35HD+S1MVqtvUdQ8f876k
X-Google-Smtp-Source: ACcGV6328Q0/93foN1tcpwS6ayeRtVVTFRAqq+bg0t4hc4ArPl4l9nF8zYgG15SmCCbwFDvNQ4aHgw==
X-Received: by 2002:a50:d2d4:: with SMTP id q20-v6mr23157942edg.212.1538468688013;
        Tue, 02 Oct 2018 01:24:48 -0700 (PDT)
Received: from vudentzs-t460s.fi.intel.com ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id r23-v6sm6215676edi.17.2018.10.02.01.24.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 01:24:47 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/3] gatt: Fix not cleaning up device state properly
Date:   Tue,  2 Oct 2018 11:24:42 +0300
Message-Id: <20181002082442.20802-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002082442.20802-1-luiz.dentz@gmail.com>
References: <20181002082442.20802-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the device is removed locally device_free would end up calling
bt_att_unref which won't trigger any disconnect callback necessary
to remove device states.
---
 src/device.c        |  3 +++
 src/gatt-database.c | 28 ++++++++++++++++++++++++++--
 src/gatt-database.h |  2 ++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index ef5b8f86a..024e670e0 100644
--- a/src/device.c
+++ b/src/device.c
@@ -580,6 +580,9 @@ static void gatt_server_cleanup(struct btd_device *device)
 
 	bt_gatt_server_unref(device->server);
 	device->server = NULL;
+
+	btd_gatt_database_att_disconnected(
+			btd_adapter_get_database(device->adapter), device);
 }
 
 static void attio_cleanup(struct btd_device *device)
diff --git a/src/gatt-database.c b/src/gatt-database.c
index febc2f840..783b692d5 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -242,7 +242,7 @@ static bool dev_state_match(const void *a, const void *b)
 }
 
 static struct device_state *
-find_device_state(struct btd_gatt_database *database, bdaddr_t *bdaddr,
+find_device_state(struct btd_gatt_database *database, const bdaddr_t *bdaddr,
 							uint8_t bdaddr_type)
 {
 	struct device_info dev_info;
@@ -357,8 +357,13 @@ static bool get_dst_info(struct bt_att *att, bdaddr_t *dst, uint8_t *dst_type)
 {
 	GIOChannel *io = NULL;
 	GError *gerr = NULL;
+	int fd;
 
-	io = g_io_channel_unix_new(bt_att_get_fd(att));
+	fd = bt_att_get_fd(att);
+	if (fd < 0)
+		return false;
+
+	io = g_io_channel_unix_new(fd);
 	if (!io)
 		return false;
 
@@ -3349,6 +3354,25 @@ void btd_gatt_database_att_connected(struct btd_gatt_database *database,
 	state->pending = NULL;
 }
 
+void btd_gatt_database_att_disconnected(struct btd_gatt_database *database,
+						struct btd_device *device)
+{
+	struct device_state *state;
+	const bdaddr_t *addr;
+	uint8_t type;
+
+	DBG("");
+
+	addr = device_get_address(device);
+	type = btd_device_get_bdaddr_type(device);
+
+	state = find_device_state(database, addr, type);
+	if (!state)
+		return;
+
+	att_disconnected(0, state);
+}
+
 static void restore_ccc(struct btd_gatt_database *database,
 			const bdaddr_t *addr, uint8_t addr_type, uint16_t value)
 {
diff --git a/src/gatt-database.h b/src/gatt-database.h
index a6c3139c4..a77a0fb20 100644
--- a/src/gatt-database.h
+++ b/src/gatt-database.h
@@ -25,5 +25,7 @@ void btd_gatt_database_destroy(struct btd_gatt_database *database);
 struct gatt_db *btd_gatt_database_get_db(struct btd_gatt_database *database);
 void btd_gatt_database_att_connected(struct btd_gatt_database *database,
 						struct bt_att *att);
+void btd_gatt_database_att_disconnected(struct btd_gatt_database *database,
+						struct btd_device *device);
 
 void btd_gatt_database_restore_svc_chng_ccc(struct btd_gatt_database *database);
-- 
2.17.1

