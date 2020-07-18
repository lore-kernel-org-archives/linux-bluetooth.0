Return-Path: <SRS0=BfG3=A5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8631C433E1
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Jul 2020 00:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F3972065D
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Jul 2020 00:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ry8FcUpi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgGRAua (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jul 2020 20:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbgGRAu3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jul 2020 20:50:29 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13CEC0619D2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 17:50:29 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x72so6168510pfc.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 17:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5GN+UF/OVH85cGnmTzEejhlhnPvnuzxXelkhe3E6ra0=;
        b=Ry8FcUpioW+1jRpRmyo+54fL2NGxk/5aFtP//8fgVFisxtZKuCM0H42+0H8bZ5lLFa
         hzBN8oT5lpdB/ocPxopWECqYEkT3Jt3VffyWf9izZXy/7OlKaKnrBCeYhHI/6SI9XBSP
         kI2LlETw8L6qxOmDDsv16y/8dMvsp3Z0HpMoUKN9oI7JLV4QXahpr8qtPUCO4xeaUn9v
         rKdp5EAY+/xWMwHT9VLUzVBbL8bHSeI7B4Siq+DFNzkuOos8gvdoWJhi6t3sjofzc7BQ
         I5OZsX1beNsiy9Cy4C2dI5UsZYt7HPL64f8GjKVELFwgAlK1WFM4l9WC0BbJluQ0hFqC
         4RSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5GN+UF/OVH85cGnmTzEejhlhnPvnuzxXelkhe3E6ra0=;
        b=M3Ee2mC+vJogbSCi4Rh32eYNkcjS/9il4F5Odo2vKmJV89y/4rNw1vOXHsmCRnSxvP
         KLRkGTm7C0E0mLUaGXdKjP6IVfRp5iNvzG2FW+Brsdq3AqRDHJnB4NH1IoLLOMFWNMjM
         Y69D8Pcvqoxbw8xIfujiwNT+NI0tYgi1T9Csga3Q/J7in8XTKKOO6xj8CytYkYEQ9NLH
         slE4m/guOnljbOny9EtLsRWFzHdxezRl+n0xW1UfPObTkETkqjOcK6RKkPL4P9woC3wH
         1vsiohJE7h+fZ2lAtQgzCCbBtNwIzy9xayshGJHfqDunumnrZCzAO9iUys4YFYuzB9Hf
         iB5Q==
X-Gm-Message-State: AOAM533ImXgQCIn/bS/zlf5ANw1H6DQOKmG8PM//Nxf6mmgzFFq3He2m
        PvvCQIn152EnbxbQ60UYROweGPmccdg=
X-Google-Smtp-Source: ABdhPJz/SWB/F8XqiI8LVzAV3GpDutsEBrfXYLgGCeIfGC35ldnEFq+zuV1m34fPlOKcDV0h4ASeVw==
X-Received: by 2002:a63:df03:: with SMTP id u3mr10342709pgg.84.1595033429067;
        Fri, 17 Jul 2020 17:50:29 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h15sm4007266pjc.14.2020.07.17.17.50.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 17:50:28 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] adapter: Don't remove temporary devices on disconnect
Date:   Fri, 17 Jul 2020 17:49:42 -0700
Message-Id: <20200718004942.326261-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes the disconnect logic just update last seen field of the
device so in case it is temporary it would trigger its timer and be
removed after the timeout which is consistent with the discovery
session givin a grace time for application to react to such events.
---
 src/adapter.c | 7 -------
 src/device.c  | 2 ++
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index c757447e2..5e896a9f0 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -6837,13 +6837,6 @@ static void adapter_remove_connection(struct btd_adapter *adapter,
 		return;
 
 	adapter->connections = g_slist_remove(adapter->connections, device);
-
-	if (device_is_temporary(device) && !device_is_retrying(device)) {
-		const char *path = device_get_path(device);
-
-		DBG("Removing temporary device %s", path);
-		btd_adapter_remove_device(adapter, device);
-	}
 }
 
 static void adapter_stop(struct btd_adapter *adapter)
diff --git a/src/device.c b/src/device.c
index 470596ee4..2237a7670 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3039,6 +3039,8 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 	if (device->bredr_state.connected || device->le_state.connected)
 		return;
 
+	device_update_last_seen(device, bdaddr_type);
+
 	g_dbus_emit_property_changed(dbus_conn, device->path,
 						DEVICE_INTERFACE, "Connected");
 }
-- 
2.26.2

