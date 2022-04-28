Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D43C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Apr 2022 20:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351625AbiD1UIk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Apr 2022 16:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351417AbiD1UIi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Apr 2022 16:08:38 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB3385668
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Apr 2022 13:05:22 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id x52so3584623pfu.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Apr 2022 13:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6vHBJnV74qLIehJVP2T7SQpP4c6G+vpqMpaTLlNt99s=;
        b=mA/4BCIKjaOmXcZoibkLNwrgPlLXRkvcBMoeQAo5kJOGWwdajc+CTRZjogC7jkR3kw
         kdhjNHOjpBtJ3kh0JCPqQzxioKltfIGdVr+6ZKwAaB5HFx/fBw01eXbepdIWMrDWIIjW
         zJFVdpLYO+CiWM32ePO5J4AxexjqaPHhUmi4Jz/z05uG23Zhzj4aV6X2CFfWw5v2FmaF
         PLCFKDkxxeAXe2aOj/raEAhARc+HKRuLAy18A9nGoVpGrENpt9zSCa4i0tP02XHN1qgk
         v6nleUqP9LI8QfT2dbCJepvEqDtI4ro+lj6m9AMcdHcqbYo6D73+x4AmTN1kp3Lpg57+
         4ZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6vHBJnV74qLIehJVP2T7SQpP4c6G+vpqMpaTLlNt99s=;
        b=gRyU71AAj0a8QgOKJmcEouzPys0RUp0AIPTbEKB4B2P1pxB8gS/ajtRZusCusFyvYE
         G4GcM7yOOOITS73x7fBrIoIujQCyIOb8hjq+QHTf0dKYBPr3RSjsizmF0iyijVtcCs0e
         9g1ubwlX9OIhm6hZnZNR+kPpiqDB3EPSVk2gvofT/alO6s6VjTXpH7TQPpZ2HtSGX32b
         FZ0jtnM9yhQ6TAhDI/Slrk2ZrUNAdcKSmLjrDw80turzn2ivAYI2RQp/UilayhKCpv+x
         hbWtVprJFLtdiBkfFHEDVuu7DBHjJtAank5gOM1E9CIXrHlg7I+NLGF8wVTZKibXHZ1J
         nidw==
X-Gm-Message-State: AOAM531CCVKgH4sD5pVj5BGvFljRcchrCYDQYUeXU04ZxfzIpoB0nLFs
        mmOOtlrc6nMlQom93ezLRLKOQ6/ZbqQ=
X-Google-Smtp-Source: ABdhPJz8gY13aewRpxHNKPJqKqZ1zJjoFByLVeZikU9ysYpFmzBTE5WhkN+0s90MLZha1IyLKLngog==
X-Received: by 2002:a05:6a00:b87:b0:50a:5ff2:bb2d with SMTP id g7-20020a056a000b8700b0050a5ff2bb2dmr36392313pfj.68.1651176321855;
        Thu, 28 Apr 2022 13:05:21 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id fv12-20020a17090b0e8c00b001cd4989fed0sm11765110pjb.28.2022.04.28.13.05.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 13:05:21 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] transport: Fix not being able to initialize volume properly
Date:   Thu, 28 Apr 2022 13:05:20 -0700
Message-Id: <20220428200520.1429133-1-luiz.dentz@gmail.com>
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
 profiles/audio/media.c     |  8 +++++---
 profiles/audio/transport.c | 12 ++++++++++--
 src/device.c               | 13 +++++++++++++
 src/device.h               |  3 +++
 4 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 8162417ce..c5d8ab14e 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -456,11 +456,11 @@ int8_t media_player_get_device_volume(struct btd_device *device)
 
 	target_player = avrcp_get_target_player_by_device(device);
 	if (!target_player)
-		return -1;
+		goto done;
 
 	adapter = find_adapter(device);
 	if (!adapter)
-		return -1;
+		goto done;
 
 	for (l = adapter->players; l; l = l->next) {
 		struct media_player *mp = l->data;
@@ -469,7 +469,9 @@ int8_t media_player_get_device_volume(struct btd_device *device)
 			return mp->volume;
 	}
 
-	return -1;
+done:
+	/* If media_player doesn't exists use device_volume */
+	return btd_device_get_volume(device);
 }
 
 static gboolean set_configuration(struct media_endpoint *endpoint,
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

