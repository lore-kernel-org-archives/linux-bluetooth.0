Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96635C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jun 2022 04:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiFWEmi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jun 2022 00:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbiFWDNS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jun 2022 23:13:18 -0400
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29681AF28
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 20:13:15 -0700 (PDT)
X-QQ-mid: bizesmtp75t1655953987td2qeqr7
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 11:13:03 +0800 (CST)
X-QQ-SSF: 01400000000000C0E000000A0000000
X-QQ-FEAT: RutLVTpVSxFkhXPKkUI5rgplrDssth4w3He83id+DO/0/zQho2ldktbf+IcdY
        DqRlM0R8xl7gCxPfA723DRmBdVdeum1449HWGOSWw7pldJ4w1EgXZ/H+MbEBudAwZxOb49k
        ulrRrkL9jH4VBhqWxZQmmw6KzApSFYNcji71laYKtmPDSVZHNM+/IDjPb+T6E9NVu7120Co
        jJv1wo2Kdyl74oAsTuIRFBI70NAaRKaeeSdf74m+AfRSF+mRozsDM2Way7bOjopJciIdgvG
        DRJRXKs6VjiZwpdeFkBDaftDm/y/fwhHfIysI+CTDac4P+yiLYujA8CcSOvCmt6Ebc+4OOv
        tRWEhMGFGpLcsnCnMKv2niOvPtUsg==
X-QQ-GoodBg: 1
From:   Youwan Wang <wangyouwan@uniontech.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Youwan Wang <wangyouwan@uniontech.com>
Subject: [PATCH] device: Fix not removing connected device
Date:   Thu, 23 Jun 2022 11:13:00 +0800
Message-Id: <20220623031300.11581-1-wangyouwan@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign3
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
 src/device.h  |  3 ++-
 3 files changed, 14 insertions(+), 4 deletions(-)

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
index 960255d2b..d7f886224 100644
--- a/src/device.h
+++ b/src/device.h
@@ -123,7 +123,8 @@ int device_notify_pincode(struct btd_device *device, gboolean secure,
 void device_cancel_authentication(struct btd_device *device, gboolean aborted);
 gboolean device_is_authenticating(struct btd_device *device);
 void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type);
-void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type);
+void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
+								bool *remove);
 void device_request_disconnect(struct btd_device *device, DBusMessage *msg);
 bool device_is_disconnecting(struct btd_device *device);
 void device_set_ltk_enc_size(struct btd_device *device, uint8_t enc_size);
-- 
2.20.1



