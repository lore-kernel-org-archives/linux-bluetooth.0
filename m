Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EFEC77B73
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 May 2023 22:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjEAWoS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 May 2023 18:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjEAWoR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 May 2023 18:44:17 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355BE26BC
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 May 2023 15:44:16 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-51b0f9d7d70so2719850a12.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 May 2023 15:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682981055; x=1685573055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/8jc43J+oF1ouWCuHyNTyI0g5hAkSGiD9T2/GzAsXmw=;
        b=LofhnNgiKPM3xWsLImMXbIXokQsdeK1B3A/0JRJcm6/fOmq8Jw0226dRkY7sL/hSa3
         Kzau2FSJL9cTL3hgPFgcDveofzrYPZHUr+lyOAzL6Hn6/o3uqsMWAPfVQYixMFD8ht/l
         skN0iaesAbyDrCXBUABQ8kBCdt7OvlIG+D84J0YwcXBjzQBEapN3sr9FB6uj04v0HdNC
         EQ2DmrcTX0vvWQL9+7GVGN2uaafYF3WCzgO1YFxcJUfKu1FCxJhlDpe1CMt2yBULHhY+
         pfyi6oqh9cyoXUb2A2r6jk9DUtyjcWX01DEXXFMtBXNmL+NHH8nI0/DRVctubX9HJbYj
         DG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682981055; x=1685573055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8jc43J+oF1ouWCuHyNTyI0g5hAkSGiD9T2/GzAsXmw=;
        b=LREUK3BooJ8dfrw9sX4mRoKVIzu55efaBszqBqzZvanlnkCVTsT5Ej5WELYswMZE7T
         ln0YGMFiNkiB1SnxeGXg4iZGgdmr1aUbyO4X8lIEEwyfqsKaBEEbOJJGi0x5uc4kexoK
         Ku2MVWFC18wS812F0w+vetVPX6RAaCMy6m/DyCK8BUyamUKTlGFh6BJ2f3uCRaRHE2Dj
         MM0FgSmFXl1PP0cUrVEI57uUHvLWguCCkID5miVlJ4kG+zRlU+wYR3QJncbSQw+pY8ar
         AQP8E9m4DGOc1le7jjmrS/vmmzoHBU7ZvjHHCEb1HA2tG9jUXzeRtw5dYIY2h+GNn3IM
         b17Q==
X-Gm-Message-State: AC+VfDz8anxP1571PkgQA4s+0o6rSgo5LrEJ/KK5/jjyYa/Qe9qpEjzY
        xsJJb/zq5B+gW8l98BHo6D4/iqBoV3I=
X-Google-Smtp-Source: ACHHUZ74KT3cQQAIbeHnxM615HaHGpSQ0jgNCFYTLBen8eAwwHeHKOVwdvVhzJ3e1nDeYaB40DMr9Q==
X-Received: by 2002:a17:903:1103:b0:1aa:f5dd:2d63 with SMTP id n3-20020a170903110300b001aaf5dd2d63mr6040159plh.1.1682981054894;
        Mon, 01 May 2023 15:44:14 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902a70800b001a6756a36f6sm18279806plq.101.2023.05.01.15.44.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 15:44:13 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v3 2/4] client/player: Fix crash when RegisterEndpoint fails
Date:   Mon,  1 May 2023 15:44:08 -0700
Message-Id: <20230501224410.1119023-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230501224410.1119023-1-luiz.dentz@gmail.com>
References: <20230501224410.1119023-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If RegisterEndpoint fails when there are multiple adapters it would
attempt to free the same endpoint multiple times.
---
 client/player.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/client/player.c b/client/player.c
index cc35721d85b7..7719076c8cfa 100644
--- a/client/player.c
+++ b/client/player.c
@@ -2028,9 +2028,11 @@ static void register_endpoint_reply(DBusMessage *message, void *user_data)
 		bt_shell_printf("Failed to register endpoint: %s\n",
 				error.name);
 		dbus_error_free(&error);
-		local_endpoints = g_list_remove(local_endpoints, ep);
-		g_dbus_unregister_interface(dbus_conn, ep->path,
+		if (g_list_find(local_endpoints, ep)) {
+			local_endpoints = g_list_remove(local_endpoints, ep);
+			g_dbus_unregister_interface(dbus_conn, ep->path,
 						BLUEZ_MEDIA_ENDPOINT_INTERFACE);
+		}
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-- 
2.40.0

