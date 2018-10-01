Return-Path: <SRS0=AfC+=MN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A59C43143
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Oct 2018 11:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54EF82089C
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Oct 2018 11:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMitJsne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54EF82089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbeJASa4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:30:56 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:36608 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728921AbeJASaz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Oct 2018 14:30:55 -0400
Received: by mail-ed1-f41.google.com with SMTP id f4-v6so13921372edq.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Oct 2018 04:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=cnznC1QOgCgEI4ETCozZcC2TM6zJ1kX74NWbWeskU5M=;
        b=rMitJsneZJBmFZoWVrt5o755FGTbQ+XIInYDABi5zpz2mleQAIuciDmElJEtQYUEF2
         I/z4qazS2c5nemlJFG7MDnEGgx5lr3gsAGE6bKQOt2qskFiEZcysHOuZD0tSeAzaZH/T
         p+X3xv2p4lfpdulDiGTE6Hu6rUgB7p6XVCrEpe2IwYDnvkSKlPFwXwOlw7gGrIiQ6ffH
         5SQMrTAu6khSh/cjEdfBGOJL48kVKn7VzgKt2OV5QLwRUgYWaidyLkHDPxhK0mzcRewe
         VnWaeg5i3awDfM7ULq8yRoPOnWGE9pYfg0qRkB7BorjFCQ4MAvtHLxSZQp+HTMZf57JX
         TWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=cnznC1QOgCgEI4ETCozZcC2TM6zJ1kX74NWbWeskU5M=;
        b=Y4GvPxzWjMp9n74brwz3PFHEmqtK8F3Bjsmkrc97ZYeLih4xEQqQecMplrnPXsOMzW
         Lr2OuwzNeQ05x8Bnq2Ss2RMb80Hi34rlH44QngxJkuBKa2s3Lo0/DmRCeOSu+gd0AOZi
         mC8f24ZX8TCbWvF5eQO4E1IDzNT0GHnc/6u/+basSMtiGUHMqk1Nh/JnMt8nIb4tyuXk
         hQoKdk7X+Xsby04NlmzM2bCKvrPdTJaZftVqS1k7m05BpGtvauiyeXSRG/UDcTipOm0E
         +4NJjQypIohyB7juQfM6bzGVqREHSyi0kH1oBJm7sfe9pVmvzyCfhJ4T2BcHwrVz2r5W
         KrCw==
X-Gm-Message-State: ABuFfoj+mxq9zqF07IxADW/Gkrzzw+qSmVZXacYB3mNe4SqdmDXHUhfM
        jNIcaTlRmaOui6U5qKoW6EIvh5YS
X-Google-Smtp-Source: ACcGV60iRufX6vGIUjB5CYSPj0SO0zmeJlqbbIDJS8OpFCGAE4PbxxLyEhrfefLsLR8NFjX3J8UjOg==
X-Received: by 2002:a17:906:5fce:: with SMTP id k14-v6mr14199658ejv.10.1538394808131;
        Mon, 01 Oct 2018 04:53:28 -0700 (PDT)
Received: from vudentzs-t460s.fi.intel.com ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id 94-v6sm4382570edc.59.2018.10.01.04.53.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 04:53:27 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] gatt: Fix not cleaning up device state properly
Date:   Mon,  1 Oct 2018 14:53:25 +0300
Message-Id: <20181001115325.17082-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If the device is removed locally device_free would end up calling
bt_att_unref which won't trigger any disconnect callback necessary
to remove device states.
---
v2: Fix glib warning if att is already disconnected.

 src/device.c        |  3 +++
 src/gatt-database.c | 29 +++++++++++++++++++++++++++++
 src/gatt-database.h |  2 ++
 3 files changed, 34 insertions(+)

diff --git a/src/device.c b/src/device.c
index ef5b8f86a..5ddfb9266 100644
--- a/src/device.c
+++ b/src/device.c
@@ -580,6 +580,9 @@ static void gatt_server_cleanup(struct btd_device *device)
 
 	bt_gatt_server_unref(device->server);
 	device->server = NULL;
+
+	btd_gatt_database_att_disconnected(
+			btd_adapter_get_database(device->adapter), device->att);
 }
 
 static void attio_cleanup(struct btd_device *device)
diff --git a/src/gatt-database.c b/src/gatt-database.c
index abcf7b759..911c674d3 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -357,6 +357,11 @@ static bool get_dst_info(struct bt_att *att, bdaddr_t *dst, uint8_t *dst_type)
 {
 	GIOChannel *io = NULL;
 	GError *gerr = NULL;
+	int fd;
+
+	fd = bt_att_get_fd(att);
+	if (fd < 0)
+		return false;
 
 	io = g_io_channel_unix_new(bt_att_get_fd(att));
 	if (!io)
@@ -3349,6 +3354,30 @@ void btd_gatt_database_att_connected(struct btd_gatt_database *database,
 	state->pending = NULL;
 }
 
+void btd_gatt_database_att_disconnected(struct btd_gatt_database *database,
+						struct bt_att *att)
+{
+	struct device_state *state;
+	bdaddr_t bdaddr;
+	uint8_t bdaddr_type;
+
+	DBG("");
+
+	if (!get_dst_info(att, &bdaddr, &bdaddr_type))
+		return;
+
+	state = find_device_state(database, &bdaddr, bdaddr_type);
+	if (!state)
+		return;
+
+	if (state->disc_id) {
+		bt_att_unregister_disconnect(att, state->disc_id);
+		state->disc_id = 0;
+	}
+
+	att_disconnected(0, state);
+}
+
 static void restore_ccc(struct btd_gatt_database *database,
 			const bdaddr_t *addr, uint8_t addr_type, uint16_t value)
 {
diff --git a/src/gatt-database.h b/src/gatt-database.h
index a6c3139c4..9e7cda8c2 100644
--- a/src/gatt-database.h
+++ b/src/gatt-database.h
@@ -25,5 +25,7 @@ void btd_gatt_database_destroy(struct btd_gatt_database *database);
 struct gatt_db *btd_gatt_database_get_db(struct btd_gatt_database *database);
 void btd_gatt_database_att_connected(struct btd_gatt_database *database,
 						struct bt_att *att);
+void btd_gatt_database_att_disconnected(struct btd_gatt_database *database,
+						struct bt_att *att);
 
 void btd_gatt_database_restore_svc_chng_ccc(struct btd_gatt_database *database);
-- 
2.17.1

