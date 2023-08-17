Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4A8C64EAE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Aug 2023 21:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355341AbjHQV1E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Aug 2023 17:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355375AbjHQV0d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Aug 2023 17:26:33 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF013AAE
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 14:26:10 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-790976d86a1so8031439f.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 14:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692307569; x=1692912369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fzdjD6FiEBqiYsThJ+iFPqdZlwU3zFfcdTlTsexhg6w=;
        b=Dax/ZKVe8XJNKIvYg7Yha7Yoii5HzAbhEFtui4rUcNVIzDp18LkqThch8V3rvDMNqg
         6L0rgx/1USYhtpKWrfzuWeqQHJ5i+Hc2EtsEEvcTMn64rf+Y7ABXHpwfImgAImYn6un5
         9jv4bXiMZcQ1NXfP4lDqJEVV0mKNMH5zHWYlfzM2O2QrsnDxZpl2VC1kw7k8vPr2uD6V
         3CSib6CzyGg65R1tBOW/6RGX+TJJn8/qthnAuLn+oisWIjjNLodyI31+Dd6ZEBc8hXfB
         1uE17I2oydJr652CWYpsaOAZuadyDhVkkMVEm0KyK9B2MW/3K61J/m68oJGVMS2Mj81m
         X5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692307569; x=1692912369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fzdjD6FiEBqiYsThJ+iFPqdZlwU3zFfcdTlTsexhg6w=;
        b=LZIpA/G9fG7equ50f1f3dNrDdclxpGlFdspcKyY/6ycuqH/WrZOaIgm51hdMzMe5E1
         My+BUJE9uMl09xe+9A4zclaEFIlcTY0yhtaGjR0GHBWM9Cdazs2X7qXpYPWkZGIaNUNH
         Bhhp4TwesFJEETZ4NZwIV/DuKgAYtpm+XvQrOdekgKiRdCs7s+23k/FVPNkHRic+y/lp
         i3PfVHI17wcQGT15suzq+lRYwf8jsGMpyV1r1Ri7cbxEkasiYgHT99w0XBmTJd0cCTVc
         Fh2aiHm6EcTFnmLx9XI4mtIIQygcJdlZpj8ISSqgZ9D+4G1LF/jP2+So3ip9pN3rbziq
         lYfQ==
X-Gm-Message-State: AOJu0Yx/OSgXIC1HlaYfNeUK7gVCJKexL/7hpoNg/hltG5RqhXlzWHk6
        pG2a/31bx3wwsaHxAhqNwTD9lVNG8JM=
X-Google-Smtp-Source: AGHT+IEyKJ3MFkvTM5azidoYr9zWY6qyfU8bqls05nlyM/kUmUG05t6Qew++CiLi+DhiwsJwncUY/g==
X-Received: by 2002:a6b:6510:0:b0:786:cd9c:cf9e with SMTP id z16-20020a6b6510000000b00786cd9ccf9emr1042332iob.2.1692307568734;
        Thu, 17 Aug 2023 14:26:08 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id fo8-20020a056638648800b0042b48e5da4bsm85528jab.134.2023.08.17.14.26.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 14:26:07 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2] profile: Remove probe_on_discover
Date:   Thu, 17 Aug 2023 14:26:06 -0700
Message-ID: <20230817212606.3024276-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The concept of probing not connected devices is already supported when
loading devices from storage, so drivers shall already be capabable of
handling such a thing as there are dedicated callbacks to indicate when
there is a new connection in the form of .accept callback.
---
 src/device.c  | 33 +++++++++++++--------------------
 src/profile.h |  5 -----
 2 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/src/device.c b/src/device.c
index ecd385cf813a..e0ff0b1c1543 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3930,17 +3930,13 @@ static bool device_match_profile(struct btd_device *device,
 					struct btd_profile *profile,
 					GSList *uuids)
 {
+	GSList *l;
+
 	if (profile->remote_uuid == NULL)
 		return false;
 
-	/* Don't match if device was just discovered, is temporary, and the
-	 * profile don't have probe_on_discover flag set.
-	 */
-	if (device->temporary && !profile->probe_on_discover)
-		return false;
-
-	if (g_slist_find_custom(uuids, profile->remote_uuid,
-							bt_uuid_strcmp) == NULL)
+	l = g_slist_find_custom(uuids, profile->remote_uuid, bt_uuid_strcmp);
+	if (!l)
 		return false;
 
 	return true;
@@ -4831,8 +4827,15 @@ static struct btd_service *probe_service(struct btd_device *device,
 	/* Only set auto connect if profile has set the flag and can really
 	 * accept connections.
 	 */
-	if (profile->auto_connect && profile->accept)
-		device_set_auto_connect(device, TRUE);
+	if (profile->auto_connect && profile->accept) {
+		/* If temporary mark auto_connect as disabled so when the
+		 * device is connected it attempts to enable it.
+		 */
+		if (device->temporary)
+			device->disable_auto_connect = TRUE;
+		else
+			device_set_auto_connect(device, TRUE);
+	}
 
 	return service;
 }
@@ -4903,8 +4906,6 @@ void device_probe_profiles(struct btd_device *device, GSList *uuids)
 		goto add_uuids;
 	}
 
-	DBG("Probing profiles for device %s", addr);
-
 	btd_profile_foreach(dev_probe, &d);
 
 add_uuids:
@@ -6932,9 +6933,6 @@ void btd_device_add_uuid(struct btd_device *device, const char *uuid)
 	GSList *uuid_list;
 	char *new_uuid;
 
-	if (g_slist_find_custom(device->uuids, uuid, bt_uuid_strcmp))
-		return;
-
 	new_uuid = g_strdup(uuid);
 	uuid_list = g_slist_append(NULL, new_uuid);
 
@@ -6942,11 +6940,6 @@ void btd_device_add_uuid(struct btd_device *device, const char *uuid)
 
 	g_free(new_uuid);
 	g_slist_free(uuid_list);
-
-	store_device_info(device);
-
-	g_dbus_emit_property_changed(dbus_conn, device->path,
-						DEVICE_INTERFACE, "UUIDs");
 }
 
 static sdp_list_t *read_device_records(struct btd_device *device)
diff --git a/src/profile.h b/src/profile.h
index cfc50058812d..6871f2f0d7d8 100644
--- a/src/profile.h
+++ b/src/profile.h
@@ -33,11 +33,6 @@ struct btd_profile {
 	 */
 	bool experimental;
 
-	/* Indicates the profile needs to be probed when the remote_uuid is
-	 * discovered.
-	 */
-	bool probe_on_discover;
-
 	int (*device_probe) (struct btd_service *service);
 	void (*device_remove) (struct btd_service *service);
 
-- 
2.41.0

