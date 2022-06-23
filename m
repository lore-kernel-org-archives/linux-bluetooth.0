Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB30FC43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jun 2022 01:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357635AbiFWBod (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jun 2022 21:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbiFWBob (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jun 2022 21:44:31 -0400
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914A9434A1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 18:44:22 -0700 (PDT)
X-QQ-mid: bizesmtp70t1655948652t9u6kciw
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 09:44:05 +0800 (CST)
X-QQ-SSF: 01400000000000C0E000000A0000000
X-QQ-FEAT: aKI6GfWslkPO6K6qoxQgVkp8DYkSkxiX17OaUuw0GjwEmbXaKn1N9RNMuDkDB
        ttySbK9aRAYCNBanigkpy9KCukIfdTAWNk6oHUOXvqDjl97zdxVHycXTsOt3hWHqTpBO7l7
        8SkwpWoq+8Huh4WWP3vs5KY1mpy5wR4k1DVhoYDO1fLyNLMHhpAPznc3f+xMrX8TACL5zKY
        5yTIEi1lAHWlnXcMuvfHD6CmzVv5uJjtY4CrlCEKuiltaINtdBjYUYi8ERV+7yi+k3l0VbU
        ODB3Uhz/tRGPq0rzjmO61nvsoOoJuCJZ4Ao2vUiIW0xrX7QSUYJVwQRblBy+TGapVg0J1ld
        a0S0BcB
X-QQ-GoodBg: 1
From:   Youwan Wang <wangyouwan@uniontech.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Youwan Wang <wangyouwan@uniontech.com>
Subject: [PATCH] device: Fix not removing connected device
Date:   Thu, 23 Jun 2022 09:44:03 +0800
Message-Id: <20220623014403.22360-1-wangyouwan@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign10
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

[bluetooth]# connect 40:EF:4C:0C:11:F0
Attempting to connect to 40:EF:4C:0C:11:F0
[CHG] Device 40:EF:4C:0C:11:F0 Connected: yes
Connection successful
[CHG] Device 40:EF:4C:0C:11:F0 ServicesResolved: yes
[UFO]# remove 40:EF:4C:0C:11:F0
[CHG] Device 40:EF:4C:0C:11:F0 ServicesResolved: no
Device has been removed
[CHG] Device 40:EF:4C:0C:11:F0 Connected: no
[bluetooth]# info 40:EF:4C:0C:11:F0
Device 40:EF:4C:0C:11:F0 (public)
        Name: UFO
        Alias: UFO
        Class: 0x00240418
        Icon: audio-headphones
        Paired: yes
        Trusted: no
        Blocked: no
        Connected: no
        LegacyPairing: no
        UUID: Headset
        UUID: Audio Sink
        UUID: A/V Remote Control Target
        UUID: A/V Remote Control
        UUID: Handsfree
        UUID: Phonebook Access Server
---
 src/adapter.c | 11 ++++++++++-
 src/device.c  |  4 ++--
 src/device.h  |  2 +-
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index afefa1d5d..16da20034 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7171,6 +7171,8 @@ static void adapter_remove_connection(struct btd_adapter *adapter,
 						struct btd_device *device,
 						uint8_t bdaddr_type)
 {
+	bool remove_device = false;
+
 	DBG("");
 
 	if (!g_slist_find(adapter->connections, device)) {
@@ -7178,7 +7180,7 @@ static void adapter_remove_connection(struct btd_adapter *adapter,
 		return;
 	}
 
-	device_remove_connection(device, bdaddr_type);
+	device_remove_connection(device, bdaddr_type, &remove_device);
 
 	if (device_is_authenticating(device))
 		device_cancel_authentication(device, TRUE);
@@ -7188,6 +7190,13 @@ static void adapter_remove_connection(struct btd_adapter *adapter,
 		return;
 
 	adapter->connections = g_slist_remove(adapter->connections, device);
+
+	if (remove_device) {
+		const char *path = device_get_path(device);
+
+		DBG("Removing temporary device %s", path);
+		btd_adapter_remove_device(adapter, device);
+	}
 }
 
 static void adapter_stop(struct btd_adapter *adapter)
diff --git a/src/device.c b/src/device.c
index 7b451e458..24d88929e 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3073,7 +3073,7 @@ static void set_temporary_timer(struct btd_device *dev, unsigned int timeout)
 								dev, NULL);
 }
 
-void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
+void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type, bool *remove)
 {
 	struct bearer_state *state = get_state(device, bdaddr_type);
 	DBusMessage *reply;
@@ -3159,7 +3159,7 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 						DEVICE_INTERFACE, "Connected");
 
 	if (remove_device)
-		set_temporary_timer(device, 0);
+		*remove = remove_device;
 }
 
 guint device_add_disconnect_watch(struct btd_device *device,
diff --git a/src/device.h b/src/device.h
index 960255d2b..fdf18d8e6 100644
--- a/src/device.h
+++ b/src/device.h
@@ -123,7 +123,7 @@ int device_notify_pincode(struct btd_device *device, gboolean secure,
 void device_cancel_authentication(struct btd_device *device, gboolean aborted);
 gboolean device_is_authenticating(struct btd_device *device);
 void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type);
-void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type);
+void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type, bool *remove);
 void device_request_disconnect(struct btd_device *device, DBusMessage *msg);
 bool device_is_disconnecting(struct btd_device *device);
 void device_set_ltk_enc_size(struct btd_device *device, uint8_t enc_size);
-- 
2.20.1



