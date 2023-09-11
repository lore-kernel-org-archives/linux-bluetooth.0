Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF111CA0EC6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 00:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjILAaM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Sep 2023 20:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjILAaD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Sep 2023 20:30:03 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325D011C8E2
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 17:05:50 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-44e3a4d0a6fso2007182137.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 17:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694477072; x=1695081872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SPxTVKDfPnYcmDz+/Xp310u86Enj0uzeRFdQ4Ju+daI=;
        b=dJb+IG/lvIUcmSTn3yzkleOCFgoZgJTho/Q+buO1qJX7rtPuwhFYcyQpHUY+3em+/2
         7kc3eHzzefgW564GD+Bwm6QF6tmjDXzucQuXPrupbut3ZoQzzvD0Ok64oWz/H1kpTt69
         qmIe7upR/ojb7sAAuGsXaKDBamV4gs5yDWZ7TQlU+vzXtd/Ig28sFqUQQFldB18NclIR
         4T2T1XQfdRexz3N531cMoJepssnwk33xYE6aFRbsHtyZgc5NM5atILTib6pEbpSAjXbF
         XyjHAijui6WX/7z04W+/YtyMALjX85ZucMKIF2HDaiANLoyeVkNEwNk5j6TVsOfqPblJ
         KcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694477072; x=1695081872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SPxTVKDfPnYcmDz+/Xp310u86Enj0uzeRFdQ4Ju+daI=;
        b=L8ZvrdSVcO0WfFx5mV3dMxomUuZ1T5M8K9Fg0Hgvp8PYJttYgqTw0LY9VK/ZPSVfkc
         y32dQ8tVpnyufVjkmAV49LSM3XLXTSSgkPxafcGc5/nF6idy57qUswv1BmVeDCLZ7YO7
         40AWh9naUoJOAFkLz5A2SB5o+ZvkTgZKyL0y8e5yJr8+BBWAoOeqeA+lgpkPaAEICZeb
         koAwVVH5st7Ebsyti+1tr6oOPao0oALCrGqpRYrOy99gY2fgm/JV0kgv/FrZEDO00yS0
         DxMPMedNnmh4bY+BhA4fpX7XaucBtC3GXVfckXsnlUu7y2J4rSPKMYHahuYNd3sGHQxo
         Z3CA==
X-Gm-Message-State: AOJu0YyfZmMY+SdpDZY0i4mIG5+gzwq0kkymy71ahUFQ5pQyoUYKcevY
        2+GzbYcoozLhprkDLg+f5s3B6nI8uJc=
X-Google-Smtp-Source: AGHT+IFgYOtMG094/l9VZWAHidoq46axAkCYbGpmTf8zEuGplOWf2+7Fv5ebWipEdA6LuXx7OFdEow==
X-Received: by 2002:a05:6a20:842a:b0:134:9f4e:623f with SMTP id c42-20020a056a20842a00b001349f4e623fmr10639128pzd.14.1694471623775;
        Mon, 11 Sep 2023 15:33:43 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id i11-20020a633c4b000000b005634343cd9esm4099884pgn.44.2023.09.11.15.33.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 15:33:42 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] device: Fix not handling initiator properly
Date:   Mon, 11 Sep 2023 15:33:40 -0700
Message-ID: <20230911223341.2701182-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Previously initiator would be set whenever a central key was found
which turns out to be unreliable besides the MGMT New Connection event
does in fact inform if the connection was initiated locally or not.

Fixes: https://github.com/bluez/bluez/issues/598
---
 src/adapter.c | 10 ++++++----
 src/device.c  | 15 +++++----------
 src/device.h  |  3 ++-
 3 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 5ebfc4752a7e..8a7c53a9e3ce 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5163,9 +5163,10 @@ static void adapter_remove_device(struct btd_adapter *adapter,
 
 static void adapter_add_connection(struct btd_adapter *adapter,
 						struct btd_device *device,
-						uint8_t bdaddr_type)
+						uint8_t bdaddr_type,
+						uint32_t flags)
 {
-	device_add_connection(device, bdaddr_type);
+	device_add_connection(device, bdaddr_type, flags);
 
 	if (g_slist_find(adapter->connections, device)) {
 		btd_error(adapter->dev_id,
@@ -5218,7 +5219,7 @@ static void get_connections_complete(uint8_t status, uint16_t length,
 		device = btd_adapter_get_device(adapter, &addr->bdaddr,
 								addr->type);
 		if (device)
-			adapter_add_connection(adapter, device, addr->type);
+			adapter_add_connection(adapter, device, addr->type, 0);
 	}
 }
 
@@ -9426,7 +9427,8 @@ static void connected_callback(uint16_t index, uint16_t length,
 	if (eir_data.class != 0)
 		device_set_class(device, eir_data.class);
 
-	adapter_add_connection(adapter, device, ev->addr.type);
+	adapter_add_connection(adapter, device, ev->addr.type,
+					le32_to_cpu(ev->flags));
 
 	name_known = device_name_known(device);
 
diff --git a/src/device.c b/src/device.c
index 9b58e0c4e6c5..35ce1df0fe74 100644
--- a/src/device.c
+++ b/src/device.c
@@ -312,16 +312,9 @@ static struct bearer_state *get_state(struct btd_device *dev,
 
 bool btd_device_is_initiator(struct btd_device *dev)
 {
-	if (dev->le_state.connected) {
-		/* Mark as initiator if not set yet and auto-connect flag is
-		 * set and LTK key is for a peripheral.
-		 */
-		if (!dev->le_state.initiator && dev->auto_connect &&
-					dev->ltk && !dev->ltk->central)
-			dev->le_state.initiator = true;
-
+	if (dev->le_state.connected)
 		return dev->le_state.initiator;
-	} else if (dev->bredr_state.connected)
+	else if (dev->bredr_state.connected)
 		return dev->bredr_state.initiator;
 
 	return dev->att_io ? true : false;
@@ -3226,7 +3219,8 @@ static void clear_temporary_timer(struct btd_device *dev)
 	}
 }
 
-void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type)
+void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type,
+							uint32_t flags)
 {
 	struct bearer_state *state = get_state(dev, bdaddr_type);
 
@@ -3249,6 +3243,7 @@ void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type)
 		device_set_le_support(dev, bdaddr_type);
 
 	state->connected = true;
+	state->initiator = flags & BIT(3);
 
 	if (dev->le_state.connected && dev->bredr_state.connected)
 		return;
diff --git a/src/device.h b/src/device.h
index 3252e14eff84..0a9e51533ca5 100644
--- a/src/device.h
+++ b/src/device.h
@@ -124,7 +124,8 @@ int device_notify_pincode(struct btd_device *device, gboolean secure,
 							const char *pincode);
 void device_cancel_authentication(struct btd_device *device, gboolean aborted);
 gboolean device_is_authenticating(struct btd_device *device);
-void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type);
+void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type,
+							uint32_t flags);
 void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
 								bool *remove);
 void device_request_disconnect(struct btd_device *device, DBusMessage *msg);
-- 
2.41.0

