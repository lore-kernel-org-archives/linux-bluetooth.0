Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4F4C00140
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Aug 2022 16:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238065AbiHBQe5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Aug 2022 12:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237995AbiHBQet (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Aug 2022 12:34:49 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FBF4B0F8
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 Aug 2022 09:34:47 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id bh13so12787113pgb.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Aug 2022 09:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KAhRUIJv/KlerRNKOScgBfsKM4xAMhcrzOSBUbh4KQc=;
        b=aoIvW0OYhHfjlI7JcwQqnymRluDYHrEjpCywIicCCoGhHNpZEo1isALGcMBvvTO/Bi
         LjctAl0gkth3VlOAcIV8cktVmziIpQn+thNO75AFQGL/VbXv6oEncQGSB8wiGgmYAhYh
         M0I3FhYRx7hhlerQE30/oBpd3XQtMR2r5l9vlSut5hkAPvUFs/ziP/uU9eMCC+dj/KRs
         2UP842Qwo0slnlGMdJSshI2LDLrD9FrpFKfzumOJg5TV1kHXWVmEh7BlLR1OxQ4/uhLi
         israA4d84gwfHafRy8T5UtMJiMHe800Bdl88pbSJ4OHRhJ/IYnvAmG/SoCc9CqalHI8a
         UO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KAhRUIJv/KlerRNKOScgBfsKM4xAMhcrzOSBUbh4KQc=;
        b=nAYHY7/OBS8Qf9p+LC2XfvD3eYBP6J0Dan8If5WwgIK2Qmb/BLMWvFKNwF0OwlwI3n
         9UT+FBByQYBnX87Z+txbYhgKamj/UeSN5Up9e4llKWxHUOJkWKf6h20cmv1I9MzMye0y
         BWxxddSSfLhaxJ1GmVY+/Y2hFyAD84zonk2mr8E36fAUJUV0eJyoAEzvaKDqCheZD4hs
         A8kbKyZ+tFp6x3oRqTNlgh3QbfWmCx53AftQrVJfgxw5WuLX+Go2Q3aAqMnJSFqug4V7
         eNfs3XIaFPGtX1SNURYfWOkEsYfSFNvshZzwy+fvYvt7ZLHZccVzBiuLKthg3ypsx0Qv
         +JNw==
X-Gm-Message-State: ACgBeo0inNSN9T8LNUyS81FezsRuxOEdax38lu5vlm/+aSLiZtiv2IgN
        eaBLrzxaxCakG6I9s5oK+PJyTwKWhVmw7w==
X-Google-Smtp-Source: AA6agR4c4vuriVadpLH0OlHJpBHQl1lreKCEJfU/SBVgyxvR/SJ5pb4tEvtW+EV7LuncLTOJIwUduw==
X-Received: by 2002:a63:2021:0:b0:41b:c2e5:f4ab with SMTP id g33-20020a632021000000b0041bc2e5f4abmr12908959pgg.496.1659458086328;
        Tue, 02 Aug 2022 09:34:46 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id y63-20020a62ce42000000b0052dd9dbe291sm2026149pfg.105.2022.08.02.09.34.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 09:34:45 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] sixaxis: Fix fliping device.trusted automatically
Date:   Tue,  2 Aug 2022 09:34:41 -0700
Message-Id: <20220802163441.2522333-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220802163441.2522333-1-luiz.dentz@gmail.com>
References: <20220802163441.2522333-1-luiz.dentz@gmail.com>
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
index 10cf15948..544ab399a 100644
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
+			 btd_device_is_trusted(device))) {
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
index 60762ac35..bc9942022 100644
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
index 004d3a78b..cc474bd88 100644
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

