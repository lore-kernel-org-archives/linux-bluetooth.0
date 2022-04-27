Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4B4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Apr 2022 20:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbiD0UXU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Apr 2022 16:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235664AbiD0UXS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Apr 2022 16:23:18 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF926606E1
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Apr 2022 13:19:59 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id cu23-20020a17090afa9700b001d98d8e53b7so4641651pjb.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Apr 2022 13:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cETnd29l+7iiB9xh0H31tkH84AUx5Esjc6woAPerXBU=;
        b=Uy7VBbEccXWwfgTPCH+mFaaFtL+sLHdW9Dns7skSZCH+HHqjQsCzV8QbIFZEW2L0kJ
         BD11WOT+L6EsdT69DoUrgFQcY8jqiLe/12CDIv3f5tDXK21+tikhpJjfXd3vbzl9OU9X
         Te3hwEoohfucN8IMMtMNgwxE4ytrJ/viY9TWwlk5lxQPULytL9t9sOwrw87U3NsE4oBY
         JCttYGb8FgGt7vk5/ziYq/WKNhI/s2k3jS+PFwJ2ftltQp3vYabMQYcwpe92lRblZ455
         T0KJ3+OcB7dyMg/0WsoGVBofFW0VN1Eqrhtc1tqaFc8R8fZhjCKZud8q+1n5hWdr7cAq
         s/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cETnd29l+7iiB9xh0H31tkH84AUx5Esjc6woAPerXBU=;
        b=G+N2HKlsd7hz2Xkj2LveG+TJp44dQ2x+w7M5bg7VSWypuhYkYL6ikbrWXunzFo+XEb
         PkvZpRR9XdWtz2oddUSV9KPq19cAMz7U5XzLSvHdCH7bisDJ1x5cppkiIrPXZrGJiDsl
         xfmWLFUS8NgtBy/HDzViMWzVntEdYQ2jo0tUryQW7Z6w/mwO67O24lUbC3jsOAgGirTB
         nbhvM3e+QctDuwip0RC8LvprX9P5ZqFN0awilQb+i/wRPgm/K1YckNFp6+pf/H6gZcmk
         2Bfz+tj0ZyEUi7U3eQpc19TLZUeM0vmkYdVGCbRIoEdpyQnu5ni8rO0EWuQ63bdfWiRP
         0Ixw==
X-Gm-Message-State: AOAM532HUeiicfzvHn2q/TSbARWNQpykMuBdsK2kJQmntnfN+RTF+yp/
        PL0awBXy33lnvY0X1OezF728CbXDzN8=
X-Google-Smtp-Source: ABdhPJwoHbRRa2RH/+hturZGBEHMrSdN4nMGsRNd3dZ3BsVRhCZqCYR1kn8bYhnGIaDusYLvQAqvFA==
X-Received: by 2002:a17:902:e393:b0:15c:f1c1:c527 with SMTP id g19-20020a170902e39300b0015cf1c1c527mr22952793ple.22.1651090799092;
        Wed, 27 Apr 2022 13:19:59 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 35-20020a631063000000b003c14af50602sm149708pgq.26.2022.04.27.13.19.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 13:19:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] transport: Fix not being able to initialize volume properly
Date:   Wed, 27 Apr 2022 13:19:57 -0700
Message-Id: <20220427201957.1004671-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

In case AVRCP is connected first and
media_transport_update_device_volume is called without any media_player
being available the volume setting would be lost and Transport.Volume
won't be available, so this introduces btd_device_{set,get}_volume
helpers which is used to store the volume temporarely so
media_player_get_device_volume is able to restore it when the transport
is created.

Fixes: https://github.com/bluez/bluez/issues/335
---
 profiles/audio/transport.c | 12 ++++++++++--
 src/device.c               | 13 +++++++++++++
 src/device.h               |  3 +++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index d158fc97a..5848e4019 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -949,6 +949,7 @@ int8_t media_transport_get_device_volume(struct btd_device *dev)
 	if (dev == NULL)
 		return -1;
 
+	/* Attempt to locate the transport to get its volume */
 	for (l = transports; l; l = l->next) {
 		struct media_transport *transport = l->data;
 		if (transport->device != dev)
@@ -959,7 +960,8 @@ int8_t media_transport_get_device_volume(struct btd_device *dev)
 			return media_transport_get_volume(transport);
 	}
 
-	return 0;
+	/* If transport volume doesn't exists use device_volume */
+	return btd_device_get_volume(dev);
 }
 
 void media_transport_update_device_volume(struct btd_device *dev,
@@ -970,13 +972,19 @@ void media_transport_update_device_volume(struct btd_device *dev,
 	if (dev == NULL || volume < 0)
 		return;
 
+	/* Attempt to locate the transport to set its volume */
 	for (l = transports; l; l = l->next) {
 		struct media_transport *transport = l->data;
 		if (transport->device != dev)
 			continue;
 
 		/* Volume is A2DP only */
-		if (media_endpoint_get_sep(transport->endpoint))
+		if (media_endpoint_get_sep(transport->endpoint)) {
 			media_transport_update_volume(transport, volume);
+			return;
+		}
 	}
+
+	/* If transport volume doesn't exists add to device_volume */
+	btd_device_set_volume(dev, volume);
 }
diff --git a/src/device.c b/src/device.c
index 38f4993f2..112bcc1f9 100644
--- a/src/device.c
+++ b/src/device.c
@@ -274,6 +274,8 @@ struct btd_device {
 	guint		store_id;
 
 	time_t		name_resolve_failed_time;
+
+	int8_t		volume;
 };
 
 static const uint16_t uuid_list[] = {
@@ -4334,6 +4336,7 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
 		return NULL;
 
 	device->tx_power = 127;
+	device->volume = -1;
 
 	device->db = gatt_db_new();
 	if (!device->db) {
@@ -7303,3 +7306,13 @@ void btd_device_cleanup(void)
 {
 	btd_service_remove_state_cb(service_state_cb_id);
 }
+
+void btd_device_set_volume(struct btd_device *device, int8_t volume)
+{
+	device->volume = volume;
+}
+
+int8_t btd_device_get_volume(struct btd_device *device)
+{
+	return device->volume;
+}
diff --git a/src/device.h b/src/device.h
index 071576d6b..9cdc0e68d 100644
--- a/src/device.h
+++ b/src/device.h
@@ -180,3 +180,6 @@ bool btd_device_all_services_allowed(struct btd_device *dev);
 void btd_device_update_allowed_services(struct btd_device *dev);
 void btd_device_init(void);
 void btd_device_cleanup(void);
+
+void btd_device_set_volume(struct btd_device *dev, int8_t volume);
+int8_t btd_device_get_volume(struct btd_device *dev);
-- 
2.35.1

