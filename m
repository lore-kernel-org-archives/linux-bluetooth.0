Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDA9C5ACA1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Aug 2023 20:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354816AbjHQUON (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Aug 2023 16:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354736AbjHQUOF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Aug 2023 16:14:05 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB79359C
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 13:14:04 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-26b4c6a5e61so143851a91.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 13:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692303243; x=1692908043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fs17u3kvDmlFl+WgAdWLRkdr+O5b79KaS1N6l6Lldrs=;
        b=lQNqBr1DHGoFJuv8XbD4cziwY89iertLXo2J1tzvzSygoMbx9WLavOQaYTuteBldec
         BtVjKfem5AqMw/2+Oiq7vRdcdfLms69SBcZIaQUP3aOM2J03Ly9wq/1PTOObDF2Ke8fW
         UB2LHQ5mkYjgUaTRKir99ZnfI02ihj/J2G2JwEmO2LQTcmGzdGuAYYsQ2Gl+oK6Xb6p4
         8yfw8nvqA09LPyOKq4iwC0PzCYnKzvaG1HVdaQMn3grRO3oScRzB/d2H+NEFnHyO/NhM
         Ny8hYkO7gs9x09u2egC50yeZnO9cVPD749NubN/HT2i7XWDVrOQBEQwG+d+C4ACiHJxN
         E7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692303243; x=1692908043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fs17u3kvDmlFl+WgAdWLRkdr+O5b79KaS1N6l6Lldrs=;
        b=KWHgEfhnnyOBLfNkSqEZ1/6nsn4X1T73oeU3lqoTUEO56mp8Z2R5RJgIPn/mTy3C0j
         SUHESV5VgS7XGsORPSNM1UoKC4ieCF0xktucgJOUKU26ECFysb23z12E6QzdDmQCfmcP
         6ekTDJWgFUtQcyeo4viNJCXnT+k03tWBCStTXjLjXZ1xlhXgqHuiJUsg2O+bT3+Yxgc5
         Ae2LfL0BsFPDUE01Em4tMF/cVjb5TVwk9iBSFzsf2QlQjIUZvNyrq48rIkLPIBpK6w7W
         4R1M6/QrqbBmZNnVYozvrSeksIanalqxAPTlTUfHmP02cwd2bE4Via1giZ21Mp4bbQXa
         x6Bg==
X-Gm-Message-State: AOJu0YygUKqAYLvc1SRsRrgE/Sz6KCaxfUxsX0EToaPxyhIEC4fT4WJ7
        Mt07C76nWdoV8+7YrTgV2zSpjL/KTfc=
X-Google-Smtp-Source: AGHT+IFfJ9VI2TZL9HEnnWJ1MCoKG/xTfXdfwjSlJLRKqrkb9e+Ipa5DmwsSwyQuKZmVSZTMbe6UBw==
X-Received: by 2002:a17:90a:e503:b0:269:32d2:5ac4 with SMTP id t3-20020a17090ae50300b0026932d25ac4mr527673pjy.25.1692303243258;
        Thu, 17 Aug 2023 13:14:03 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a191700b0026b41363887sm2088672pjg.27.2023.08.17.13.14.01
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 13:14:02 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] profile: Remove probe_on_discover
Date:   Thu, 17 Aug 2023 13:14:01 -0700
Message-ID: <20230817201401.3001315-1-luiz.dentz@gmail.com>
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
 src/device.c  | 22 ++++------------------
 src/profile.h |  5 -----
 2 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/src/device.c b/src/device.c
index ecd385cf813a..6d46fdb83b19 100644
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
@@ -4903,8 +4899,6 @@ void device_probe_profiles(struct btd_device *device, GSList *uuids)
 		goto add_uuids;
 	}
 
-	DBG("Probing profiles for device %s", addr);
-
 	btd_profile_foreach(dev_probe, &d);
 
 add_uuids:
@@ -6932,9 +6926,6 @@ void btd_device_add_uuid(struct btd_device *device, const char *uuid)
 	GSList *uuid_list;
 	char *new_uuid;
 
-	if (g_slist_find_custom(device->uuids, uuid, bt_uuid_strcmp))
-		return;
-
 	new_uuid = g_strdup(uuid);
 	uuid_list = g_slist_append(NULL, new_uuid);
 
@@ -6942,11 +6933,6 @@ void btd_device_add_uuid(struct btd_device *device, const char *uuid)
 
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

