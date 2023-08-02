Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75110C001DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 20:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjHBUPt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Aug 2023 16:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjHBUPp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Aug 2023 16:15:45 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7079A26A1
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Aug 2023 13:15:42 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-686b91c2744so171215b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Aug 2023 13:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691007341; x=1691612141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CpcQF2DQCIMnKy3lACKGfyzR8y138lcXemdIuDv/JJQ=;
        b=ds6uIqFhKoY/sbXNMYceE/y3SmFMbMpkYpFFyVt/UmTNMrxhQXS2fQ5MwvAF9/USeQ
         wrS8xjwSyF1LIyzn0wdPx6Kc4mQJZCa5S2MrnPTjcfDneeHLgkHYXO5K8jVi+VqO8Q/b
         ZeGZ5K09+xx4bXCv0cd+4UtULk5xCXSfwrnSHh1uomrfn8znwm87TX3V4nGOn6iahI3n
         Ze11dqP5F+RT+3ygtauOXUvWNDtHcajeN7PxPr+x8RIo2Pp4amcSghMK6w3pVqnAGNan
         v1Y6abmdUqvF2N+N8RnSoMdrbPiPJGhNH+XxT8QvXFs2nuHYeRoGZjB1KpL7nN109mVE
         udOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691007341; x=1691612141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CpcQF2DQCIMnKy3lACKGfyzR8y138lcXemdIuDv/JJQ=;
        b=fFVpG+dcuBChTtf98TfEJLHFS7nB5AadJXLVdPwtAJx8uXOuKjDRQOfqnmig/0TQ01
         Pr5XNEBLxzT5QG+8BTtSywu/cGmznnc7zE2eZNvh68TZIECSLe6vKnXjmLFSAium5uPp
         RnywpbiWrsL4If3AIqSdbiaHWDTjEgxFz82zotvBVzALM7lA7Mb3tiG7TbsTLoBcgBIk
         g270GplzD9Mmt8jS488vaxZHMUv2/UmkjNy/ZxGBms4DnvNFl8QG2E46hUNsFGqfnb1P
         PammZpb8SzYtsNGOwZATYET5pwDqS7M3Ky+PXLQ9mKDdMpJJz2RYors8nbCEDDewSXcb
         lQTg==
X-Gm-Message-State: ABy/qLaGqq0WO4GrVyjVowE8D/KLye89m/a/Olyz3T04rDWIU8ptEuWs
        zWptV+xBRdaHEMGkzVCDiAdt/yQFswE=
X-Google-Smtp-Source: APBJJlFLGicriyR3T5U0+9Igp5Jclmd1g+33qCt8hxx6pzGZ1eyq+yZWN2drJlKJ31kpQ5J6bITb1A==
X-Received: by 2002:a17:902:968e:b0:1b1:9218:6bf3 with SMTP id n14-20020a170902968e00b001b192186bf3mr14924521plp.37.1691007340901;
        Wed, 02 Aug 2023 13:15:40 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-236-201-58.hsd1.or.comcast.net. [71.236.201.58])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b001b9da8b4eb7sm12800586ple.35.2023.08.02.13.15.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 13:15:39 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ RFC] profile: Add probe_on_discover flag
Date:   Wed,  2 Aug 2023 13:15:38 -0700
Message-ID: <20230802201538.584029-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds probe_on_discover flag which indicates if profile needs to be
probed when the remote_uuid is discovered and changes device logic to
attempt to probe driver when a new UUID is discovered and
probe_on_discover is set.
---
 src/device.c  | 22 +++++++++++++++++-----
 src/profile.h |  5 +++++
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/src/device.c b/src/device.c
index b43ced8b5c91..19ae03f7d98a 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2156,7 +2156,7 @@ done:
 void device_add_eir_uuids(struct btd_device *dev, GSList *uuids)
 {
 	GSList *l;
-	bool added = false;
+	GSList *added = NULL;
 
 	if (dev->bredr_state.svc_resolved || dev->le_state.svc_resolved)
 		return;
@@ -2165,13 +2165,11 @@ void device_add_eir_uuids(struct btd_device *dev, GSList *uuids)
 		const char *str = l->data;
 		if (g_slist_find_custom(dev->eir_uuids, str, bt_uuid_strcmp))
 			continue;
-		added = true;
+		added = g_slist_append(added, (void *)str);
 		dev->eir_uuids = g_slist_append(dev->eir_uuids, g_strdup(str));
 	}
 
-	if (added)
-		g_dbus_emit_property_changed(dbus_conn, dev->path,
-						DEVICE_INTERFACE, "UUIDs");
+	device_probe_profiles(dev, added);
 }
 
 static void add_manufacturer_data(void *data, void *user_data)
@@ -2201,6 +2199,7 @@ static void add_service_data(void *data, void *user_data)
 	struct eir_sd *sd = data;
 	struct btd_device *dev = user_data;
 	bt_uuid_t uuid;
+	GSList *l;
 
 	if (bt_string_to_uuid(&uuid, sd->uuid) < 0)
 		return;
@@ -2208,6 +2207,10 @@ static void add_service_data(void *data, void *user_data)
 	if (!bt_ad_add_service_data(dev->ad, &uuid, sd->data, sd->data_len))
 		return;
 
+	l = g_slist_append(NULL, sd->uuid);
+	device_add_eir_uuids(dev, l);
+	g_slist_free(l);
+
 	g_dbus_emit_property_changed(dbus_conn, dev->path,
 					DEVICE_INTERFACE, "ServiceData");
 }
@@ -3930,6 +3933,12 @@ static bool device_match_profile(struct btd_device *device,
 	if (profile->remote_uuid == NULL)
 		return false;
 
+	/* Don't match if device was just discovered (not connected) and the
+	 * profile don't have probe_on_discover flag set.
+	 */
+	if (!btd_device_is_connected(device) && !profile->probe_on_discover)
+		return false;
+
 	if (g_slist_find_custom(uuids, profile->remote_uuid,
 							bt_uuid_strcmp) == NULL)
 		return false;
@@ -4884,6 +4893,9 @@ void device_probe_profiles(struct btd_device *device, GSList *uuids)
 	struct probe_data d = { device, uuids };
 	char addr[18];
 
+	if (!uuids)
+		return;
+
 	ba2str(&device->bdaddr, addr);
 
 	if (device->blocked) {
diff --git a/src/profile.h b/src/profile.h
index 6871f2f0d7d8..cfc50058812d 100644
--- a/src/profile.h
+++ b/src/profile.h
@@ -33,6 +33,11 @@ struct btd_profile {
 	 */
 	bool experimental;
 
+	/* Indicates the profile needs to be probed when the remote_uuid is
+	 * discovered.
+	 */
+	bool probe_on_discover;
+
 	int (*device_probe) (struct btd_service *service);
 	void (*device_remove) (struct btd_service *service);
 
-- 
2.41.0

