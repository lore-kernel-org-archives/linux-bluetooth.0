Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A7DE9271B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Oct 2023 17:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjJERbt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Oct 2023 13:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbjJERbV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Oct 2023 13:31:21 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFA3D5D
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Oct 2023 09:57:39 -0700 (PDT)
Received: from monolith.lan (91-152-120-176.elisa-laajakaista.fi [91.152.120.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4S1d5q2w0Sz49Q0S;
        Thu,  5 Oct 2023 19:57:34 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1696525055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hrl/8xpCGnP/ySpTqW2v+Egd8AMv9xokOq2w+m/wFTI=;
        b=P4g5MQrzf9c2PczkDXaGJiLOZWja+5OsKTKQG+pLxSnEB77pqexhLxFSKt1e2NMmgyN8Lb
        HCkrzrChlywetkdulV9NMy90hFV5o22/IFzjxIbjcazwgafj05rjow8R5cA661DZrspHWB
        GYfoDNtziBmDuWVTswFrdKXNa7cdcWGykmLdVHUNXAfBpq5DXCS5r5Ynst2RhJbF/K95NF
        oT3FuaXga8O9NFhodLyjYq4MTaOdms/H62Ef/jfJTkOkKuDV6DcUVYzph88GRVF2ptYpDY
        aQihxb39Ms6d0khmf5lZMPTrOiLWbqXsMDz31vf+QxKXPuXce0NouJiftmQhjw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1696525055; a=rsa-sha256;
        cv=none;
        b=iJ9Cw36bStcFLF2AHiTfpTmkbrTZ1smLehjBIMyVr7mBk79vUnOyzrL0y0yIUbYKPl/ELm
        G3ysxVumuCE6WEOOVN+nKEnxZBE+YYo0bOg0V6szmB5xVdA843x+zO2DT265BZ8lQ7jUl2
        TL7pn3MP/+IZWfN1td8/PgfoXrgTgtEmdAzV/ImsK+pjg7OyWeoBfSuBIUXSBWxNzYV/D/
        3kkb9Zt7DM9W44jWBmiy0fwxu0WVFvLLlSgeSieR1vBL34FIeldWit6UiK7IaRK3/a3P8u
        eGYuTgphUyE/OnAsfUBG31NaSALJ34FAWEwYV8ZRUDn/2DCowgGPF4yFcYLDOw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1696525055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hrl/8xpCGnP/ySpTqW2v+Egd8AMv9xokOq2w+m/wFTI=;
        b=rZJLOf7NIWmsX4b5RldHvi1EuKtZ6Z+rVIZnkMwM0pHFCCQBSXOzMqxRpJU7OT2KQWvwA2
        N9NT5osXsjV7uVAV9MZefteUoKLqB4+E8Qi9JI094uv/8uKWUdcGU6lFQcCjaoibPTjY6s
        SJqqTITv+z0Jyglp6jSS0QmuQmkHphkXjBg4DpqzZJzysUzGBSK/tGgdGfjJzPYYW+8414
        eI7tm0h58Jdz7b6q0+aabJe0GB6sa/VzyjY5pKnVx3Bw4cTbk3ViIy27DMB41QaOqBN4px
        b6CEkd2mR+27/EZq7DA2nSHnm6rKNqOnBV6vQey/8nnQoafdrklpST5iW5dc3g==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/2] battery: mark all battery DBus APIs non-experimental
Date:   Thu,  5 Oct 2023 19:57:32 +0300
Message-ID: <ceaf8aa40e0967b01b86008b16a26bbb111a2cf6.1696524938.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Remove experimental marker from BatteryProvider1 and Battery1.Source.

It's common that headsets send battery information via HFP, and often
this is also the only way to get it. Pipewire/pulseaudio manage HFP,
parse the battery commands, and use the BatteryProvider API if present
to forward it. No problems with the API appeared here, and it's been
experimental for a few years, so it's useful to enable it by default
now.
---
 src/adapter.c | 6 ++----
 src/battery.c | 7 +++----
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 8c267d418..6c539a81e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -9286,10 +9286,8 @@ static int adapter_register(struct btd_adapter *adapter)
 		agent_unref(agent);
 	}
 
-	if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL) {
-		adapter->battery_provider_manager =
-			btd_battery_provider_manager_create(adapter);
-	}
+	adapter->battery_provider_manager =
+		btd_battery_provider_manager_create(adapter);
 
 	/* Don't start GATT database and advertising managers on
 	 * non-LE controllers.
diff --git a/src/battery.c b/src/battery.c
index 5c52581f3..59e4fc570 100644
--- a/src/battery.c
+++ b/src/battery.c
@@ -152,8 +152,7 @@ static gboolean property_source_exists(const GDBusPropertyTable *property,
 static const GDBusPropertyTable battery_properties[] = {
 	{ "Percentage", "y", property_percentage_get, NULL,
 	  property_percentage_exists },
-	{ "Source", "s", property_source_get, NULL, property_source_exists,
-	  G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Source", "s", property_source_get, NULL, property_source_exists },
 	{}
 };
 
@@ -523,10 +522,10 @@ static DBusMessage *unregister_battery_provider(DBusConnection *conn,
 }
 
 static const GDBusMethodTable methods[] = {
-	{ GDBUS_EXPERIMENTAL_METHOD("RegisterBatteryProvider",
+	{ GDBUS_METHOD("RegisterBatteryProvider",
 				    GDBUS_ARGS({ "provider", "o" }), NULL,
 				    register_battery_provider) },
-	{ GDBUS_EXPERIMENTAL_METHOD("UnregisterBatteryProvider",
+	{ GDBUS_METHOD("UnregisterBatteryProvider",
 				    GDBUS_ARGS({ "provider", "o" }), NULL,
 				    unregister_battery_provider) },
 	{}
-- 
2.41.0

