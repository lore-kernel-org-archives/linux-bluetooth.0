Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274F0CA0EC7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Sep 2023 23:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjIKX4v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Sep 2023 19:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238529AbjIKXyZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Sep 2023 19:54:25 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC28CAED2
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 15:47:59 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-655d25f3678so19874736d6.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 15:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694472390; x=1695077190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SPxTVKDfPnYcmDz+/Xp310u86Enj0uzeRFdQ4Ju+daI=;
        b=ciQ4TnRy7RkGhRmZZU9acUuzCjx2xdZPbmukymXzLlLbhLj6N8XMzKIq3vlhkjmSLY
         xFkMzxyaapWIAhrVqoXTJfP2LFJvGGU4wX9OoKzDmNmYO7RWqrVwWnSoCO8aSxp9fp9M
         bJwXY8cYNOjo1zI2QsQYnPyjavzJOko1LfzkHT26eTVv07BXDwCj+dUrfxgnVJgtUx6C
         iZCY8CcFn35yRIwjhe9xQrj5EnHWtqWE4JrTC+29nGtyki8FhobsbGzKQIm0+K19huPC
         LDDPeJO2MkieP3VsDxuETxG2H8u+qb1SUGAL/Ilp5LvT25gL+cwBFtUiF/KM7jyrP6Xl
         BO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694472390; x=1695077190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SPxTVKDfPnYcmDz+/Xp310u86Enj0uzeRFdQ4Ju+daI=;
        b=nMETKjI8bvg6u6s44JX3TqErFDDSHYbvRQHFEYA14vUahf9te4+RNJgYlxiFnOtONl
         SRawRl/L5Y0O6D578GnqCYGViH7vfTnIpuj3W6zucXThm1+d13Af5QleTt6UpwpYjN7F
         kRBm1DqYYkogC3FZatgW74/fOFd2nq+MRav/hVt2gZQ1RdYLHo2c00j2nif51S7C6yBM
         cLCPJ7tzajEhqxmdWG5aaI+MLtlDJk5QnUpwnkc/xX2nB8DjWK3lkr4vHg1nKIf/1Kuq
         mN4RlqTdwiNVruKaKUk10ZX9iDPaY2fNNNRAtVqjIXrL6cqQY+Ju9Ttztb/K16MsvISV
         KhNw==
X-Gm-Message-State: AOJu0YwJEx4aKgGCfcm7tUsPdIj75VkLZpGhQdLoZS34/P2ipkF9RFuQ
        9HT0Nt7Yv9nv8mWRJ6WfsM33NZUGLiU=
X-Google-Smtp-Source: AGHT+IGKKiDPc936i0ZoBXURiu5Ui0sNuGvq0kN2SA83XSWu/gFqeir35SNBpPTgc1v2LLOS4RjiFg==
X-Received: by 2002:a05:6a20:d425:b0:14a:7701:56df with SMTP id il37-20020a056a20d42500b0014a770156dfmr8868883pzb.21.1694471636733;
        Mon, 11 Sep 2023 15:33:56 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id o12-20020a170902778c00b001bc6536051bsm6965131pll.184.2023.09.11.15.33.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 15:33:55 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] device: Fix not handling initiator properly
Date:   Mon, 11 Sep 2023 15:33:55 -0700
Message-ID: <20230911223355.2701293-1-luiz.dentz@gmail.com>
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

