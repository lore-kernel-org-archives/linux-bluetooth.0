Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E306FC43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jun 2022 19:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377540AbiFVTA5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jun 2022 15:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377503AbiFVTA4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jun 2022 15:00:56 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F633C709
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 12:00:55 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id t21so10647234pfq.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 12:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h9NldJzkM5PkmiLllXyVKHbrFwborg8k7+tu71hGN7k=;
        b=hRPEgwsD5iByPt6DlT52cpQTddM4yrC2Voyh4zi56dtLI7T2xIB8W+GQOvpxPH6ZHg
         jRMTysWIFPAe3GOezBr7GMD/toWo/toyNF8f1FFntzeA5icZmK3bwP0xTMPPDWpeMdAJ
         nBR6etWf3xuAOpTtlABYktL3hGSRPO+2mshFyFnLYdsMeqqYWmxrTNPdZYQSf/D8aYgN
         jRJKQ3SKCQo+L43NRCyZaj6uX1HdDA8kRmxUPlk9BzOMyK+aB+ozsdB1RMtzVab6jOcb
         CV7q5wsZ7hBb1YUdGru6aExA0auD5gDFvgM2Mj1XA1aaqAAMyWIUSoM5enSYrppexSYc
         JpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h9NldJzkM5PkmiLllXyVKHbrFwborg8k7+tu71hGN7k=;
        b=hrXVITVos8/QM5lkQom7dTRtL0+/PHPxE4maExMDvcW7FgO0DBh8KyGB87Qdw6ruXy
         tiMO2pj3z82DGbhQvjis4b1CxS2z3ZHJ9+y0Equ9klUggPJ+NiBJY/j3H3r5gJPnV8Oz
         wiZwcs0mNzEQ1GJxejrV536YImalhgl+zzOS2WI+fwipRq5XdAEkAXVRSdy3Fj+mcRxN
         olG5fCAlECpf0R6i5SEXPRaJjtrMGOZ76ov+z2bu+oEPnQGYTIPGZ8l8rWKXw9NkC+E1
         qbaakaEjPrMzqUMWXbIFWB5Vg5AlxlkykRWniiWGvZcITkj3fIY5f92lJrEC0KG1qE0T
         CuOw==
X-Gm-Message-State: AJIora9DAyt1sLuWuVFqGwnvusGMnprmhfbI6w9aPNJhNgdbiM6AkDOa
        jkRPyBV1ujYZOjYqgvZmIc+Q+Xzyv734fA==
X-Google-Smtp-Source: AGRyM1vk7O+3Irc8mD3YiH6UR+Rox4zaFe6Pj4CeG0v7p4PilOF58yTNE9o0uyBHkcWO76XKRcsiig==
X-Received: by 2002:a05:6a00:2447:b0:520:6b82:6dfd with SMTP id d7-20020a056a00244700b005206b826dfdmr36804106pfj.39.1655924454842;
        Wed, 22 Jun 2022 12:00:54 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902a3c500b0016a38fa3f95sm3991999plb.118.2022.06.22.12.00.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 12:00:54 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] device: Fix not removing when connected
Date:   Wed, 22 Jun 2022 12:00:53 -0700
Message-Id: <20220622190053.2605233-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

RemoveDevice causes the device to disconnect when connected but that
would result in calling set_temporary_timer with 0 timeout which would
only clear the timer but it doesn't program a timeout so
device_disappeared is never called, so instead of using temporary
timeout to cleanup this passes a variable which is set when to indicate
that the device shall be removed.
---
 src/adapter.c | 9 ++++++++-
 src/device.c  | 7 ++++---
 src/device.h  | 3 ++-
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index afefa1d5d..43884cf15 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7171,6 +7171,8 @@ static void adapter_remove_connection(struct btd_adapter *adapter,
 						struct btd_device *device,
 						uint8_t bdaddr_type)
 {
+	bool remove;
+
 	DBG("");
 
 	if (!g_slist_find(adapter->connections, device)) {
@@ -7178,7 +7180,12 @@ static void adapter_remove_connection(struct btd_adapter *adapter,
 		return;
 	}
 
-	device_remove_connection(device, bdaddr_type);
+	device_remove_connection(device, bdaddr_type, &remove);
+
+	if (remove) {
+		btd_adapter_remove_device(adapter, device);
+		return;
+	}
 
 	if (device_is_authenticating(device))
 		device_cancel_authentication(device, TRUE);
diff --git a/src/device.c b/src/device.c
index 7b451e458..24b49ed79 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3073,7 +3073,8 @@ static void set_temporary_timer(struct btd_device *dev, unsigned int timeout)
 								dev, NULL);
 }
 
-void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
+void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
+								bool *remove)
 {
 	struct bearer_state *state = get_state(device, bdaddr_type);
 	DBusMessage *reply;
@@ -3158,8 +3159,8 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 	g_dbus_emit_property_changed(dbus_conn, device->path,
 						DEVICE_INTERFACE, "Connected");
 
-	if (remove_device)
-		set_temporary_timer(device, 0);
+	if (remove_device && remove)
+		*remove = true;
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
2.35.3

