Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6876AC00144
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Aug 2022 00:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiHBAMB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Aug 2022 20:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiHBAMA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Aug 2022 20:12:00 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE38D46DBD
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 17:11:59 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id o3so11938966ple.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Aug 2022 17:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n4k4m1zFVF7TKZfWdymcSqqaRExMXxa65ysPUNsKgjM=;
        b=MzvpAspGQJgUAyoUT3QQUvvAcqIRYjzBvAYMi2S1HqeOzXM3J+04sGRloIcYiTaSrf
         2jQWQFyQ1whoDszYaBdUvGrz4oZeHwKOTla6f8lCKGchbIg1rTrP14MXtdtZcCKASgnq
         ChnxcARqrbs5RqSGE00+8mFnlCmVfZO28y6vlOHoVEK1dRFjtHzQFr7VHmpD1nqzZ9Xy
         AXS6QHMnOEBLx6SZ3Po4UGyjRLcElxGg8aI8/2hE1a4bxP6ZXXGv6FRA5EKhNZcTbOkF
         6sIWWqtcoVLJFuhqaRnZijU/rRE1gxeRa5q49w3Nf7iMJsVOznRQhpZ+e8XneFEvf/pn
         hHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n4k4m1zFVF7TKZfWdymcSqqaRExMXxa65ysPUNsKgjM=;
        b=6lfeXoxD1Y9oU6hZpvPERggHh+kfnMf0wTxzBKdvBdhpYxLVy7F+cUvaE0sRyJND4G
         oaOPS/oKigp5ENhpEMqI85Lyp/5XjalDFL1jq0XxDFDpx90wLvcIDIyoj6C/2qwJRY4l
         fDvZlFlmZLZSd+g5kpSRjG6+r3t916ygNSva2nPVLcDuSQO964dR2eAj8Yyb3wkQ/5nn
         +k3ubbDBJKQMhDMZxMgTIzwEwF6ieb4eybcDCquPVg+s1pwmK3oASMzVXUFpE7G5mOLF
         OpuFUDc0tBsuTMMCyVoRKfxwWyLpw3PoAfKyheUhJ/ug8VzDS0taAs0QnCidVpa3SiEa
         xl+A==
X-Gm-Message-State: ACgBeo2wnDqRvunrpb4j0mhPLp1UiX6bnkkM3FOi+IJAf7wbxNIxN+bZ
        oOCfGzpVCXP0e8+ZGbPURKnG1DRYYuOEfw==
X-Google-Smtp-Source: AA6agR7Hw+A3uOwp/45PdcZULV+Jce3xwbyIbU7kPCj9SBzjb2TPrzgWLGqe3JYpHuya1NeOGuZshA==
X-Received: by 2002:a17:90a:6b45:b0:1e3:3cfa:3104 with SMTP id x5-20020a17090a6b4500b001e33cfa3104mr22464437pjl.113.1659399118829;
        Mon, 01 Aug 2022 17:11:58 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z6-20020aa79e46000000b0052dce4edceesm518863pfq.169.2022.08.01.17.11.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 17:11:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] sixaxis: Fix fliping device.trusted automatically
Date:   Mon,  1 Aug 2022 17:11:57 -0700
Message-Id: <20220802001157.2308559-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

device.trusted is a user preference which controls if the devices needs
to be authorized or not so the plugin shall not overwrite it and instead
just honor what user has set and skip authorizing if already trusted.

Fixes: https://github.com/bluez/bluez/issues/372
---
 plugins/sixaxis.c | 9 +++------
 src/device.c      | 6 ++++++
 src/device.h      | 1 +
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 10cf15948..9b9d51914 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -294,7 +294,6 @@ static void agent_auth_cb(DBusError *derr, void *user_data)
 	}
 
 	remove_device = false;
-	btd_device_set_trusted(closure->device, true);
 	btd_device_set_temporary(closure->device, false);
 
 	if (closure->type == CABLE_PAIRING_SIXAXIS)
@@ -336,10 +335,9 @@ static bool setup_device(int fd, const char *sysfs_path,
 	 * connected eg. to charge up battery. */
 	device = btd_adapter_find_device(adapter, &device_bdaddr,
 							BDADDR_BREDR);
-	if (device != NULL &&
-		btd_device_is_connected(device) &&
-		g_slist_find_custom(btd_device_get_uuids(device), HID_UUID,
-						(GCompareFunc)strcasecmp)) {
+	if (device && btd_device_has_uuid(device, HID_UUID) &&
+			(btd_device_is_connected(device) ||
+			 device_is_trusted(device))) {
 		char device_addr[18];
 		ba2str(&device_bdaddr, device_addr);
 		DBG("device %s already known, skipping", device_addr);
@@ -352,7 +350,6 @@ static bool setup_device(int fd, const char *sysfs_path,
 
 	btd_device_device_set_name(device, cp->name);
 	btd_device_set_pnpid(device, cp->source, cp->vid, cp->pid, cp->version);
-	btd_device_set_trusted(device, false);
 	btd_device_set_temporary(device, true);
 
 	closure = g_new0(struct authentication_closure, 1);
diff --git a/src/device.c b/src/device.c
index 775003796..8fa035b73 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4509,6 +4509,12 @@ GSList *btd_device_get_uuids(struct btd_device *device)
 	return device->uuids;
 }
 
+bool btd_device_has_uuid(struct btd_device *device, const char *uuid)
+{
+	return g_slist_find_custom(device->uuids, uuid,
+						(GCompareFunc)strcasecmp);
+}
+
 struct probe_data {
 	struct btd_device *dev;
 	GSList *uuids;
diff --git a/src/device.h b/src/device.h
index d7f886224..e8116c305 100644
--- a/src/device.h
+++ b/src/device.h
@@ -54,6 +54,7 @@ struct device_addr_type {
 
 int device_addr_type_cmp(gconstpointer a, gconstpointer b);
 GSList *btd_device_get_uuids(struct btd_device *device);
+bool btd_device_has_uuid(struct btd_device *device, const char *uuid);
 void device_probe_profiles(struct btd_device *device, GSList *profiles);
 
 void btd_device_set_record(struct btd_device *device, const char *uuid,
-- 
2.37.1

