Return-Path: <SRS0=u3xs=74=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33136C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jun 2020 12:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FADC206D7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jun 2020 12:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="xCyEkhze"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgFOMlo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgFOMlo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jun 2020 08:41:44 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9625AC061A0E
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 05:41:42 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id o4so1805759lfi.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2020 05:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4hLQBaK4uf5u7ueEngGcyHZ26nc7pao38tXlhI/74uo=;
        b=xCyEkhzeXk3X80q1Q1eWY7hgwD7gmMapxsuIIPV8+X0hWcC1ij+KdG3bb9vpfd/GNN
         e8PA1hT/Bt0iSsY3iODxXgh5bV73tdxpVyjvOWJgfkNqdHdCw2ez1c2yHonKU9tClHLW
         Vte0dwey/8BuKpMByVkyGkK8hnik2WgVtXVviAN7dQkYh67QbmIWeKsCPMT+cnY1ljGz
         ORI5R/XVvHn2zH5UCxoRNiLMpb1xypcozHDl+dzxikxWBWcnPBj4qI7Qz9C/xYvV2aMc
         JiahUQn0Fijc8QA3oauzDiT1Gm1SYwjHar2pZ1VBBc8SnOTLehCJSr47BjI9tZ6v8h49
         TUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4hLQBaK4uf5u7ueEngGcyHZ26nc7pao38tXlhI/74uo=;
        b=GjWbYstOzn2XXdi5LguLvl5oO9RWrJmckAMdFa3uEmFd8yVyDI2cCxynmXEwl3uyW2
         sON5I4cR7MUihhX38NBL/x/NDyCgjdne9DA9xrcW0ufs1VXWqKqlitzwtKPXyV3QnYRZ
         J8bY/F0z/BhXIHaWjlQcHhqsmDWBFvWPuqbh54kJKzWAhZaOkiHlxRIS8Khyex5daLRt
         rL4tN7+1+NfZw5V9q7kzlr19KRKlFWuYN2IsnJvB4AM6c6I0Y9JA6Io9HNl7UPBe+i+a
         wikB25cUwTOdpRrcP+SS7QzuKlqF3YBDkiiXpZVuFYD2A+JIxDX3fqOODtmH5jOOT4eF
         ywOg==
X-Gm-Message-State: AOAM530cMkfVjwc1IsTf4wyVEXfxFiJBiby2xYEGME2JE6jkvQArWxuY
        0z7ZZZJYXsaZXzvc9/a3W98ncvARuNufsw==
X-Google-Smtp-Source: ABdhPJyab9qIKuWVWzTvX6R8MXR23KXH9NP0ULgt+sMaHgIdcjTbfFlusm+ekrtTPVSkq/kkX2A+lA==
X-Received: by 2002:ac2:544b:: with SMTP id d11mr13524897lfn.157.1592224900805;
        Mon, 15 Jun 2020 05:41:40 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id b10sm3398821lfi.20.2020.06.15.05.41.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 05:41:40 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Change BeaconFlags property type to a dict
Date:   Mon, 15 Jun 2020 14:41:58 +0200
Message-Id: <20200615124158.12163-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Instead of a binary value, return a dictionary consistent with
"flags" argument used in Import().
---
 doc/mesh-api.txt | 18 ++++++++++++++----
 mesh/node.c      | 13 +++++++++++--
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index 7fbab32b6..26bc92807 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -431,11 +431,21 @@ Properties:
 		This property indicates whether the periodic beaconing is
 		enabled (true) or disabled (false).
 
-	uint8 BeaconFlags [read-only]
+	dict BeaconFlags [read-only]
 
-		This property may be read at any time to determine the flag
-		field setting on sent and received beacons of the primary
-		network key.
+		This property may be read at any time to determine the flags
+		used in network beacons of the primary network key. Supported
+		values are:
+
+			boolean IvUpdate
+
+				When true, indicates that the network is in the
+				middle of IV Index Update procedure.
+
+			boolean KeyRefresh
+
+				When true, indicates that the network is in the
+				middle of a key refresh procedure.
 
 	uint32 IvIndex [read-only]
 
diff --git a/mesh/node.c b/mesh/node.c
index 6140fdf9f..87a85a44d 100644
--- a/mesh/node.c
+++ b/mesh/node.c
@@ -32,6 +32,7 @@
 #include "mesh/mesh-defs.h"
 #include "mesh/mesh.h"
 #include "mesh/net.h"
+#include "mesh/net-keys.h"
 #include "mesh/appkey.h"
 #include "mesh/mesh-config.h"
 #include "mesh/provision.h"
@@ -2191,10 +2192,18 @@ static bool beaconflags_getter(struct l_dbus *dbus, struct l_dbus_message *msg,
 	struct mesh_net *net = node_get_net(node);
 	uint8_t flags;
 	uint32_t iv_index;
+	bool ivu;
+	bool kr;
 
 	mesh_net_get_snb_state(net, &flags, &iv_index);
 
-	l_dbus_message_builder_append_basic(builder, 'y', &flags);
+	ivu = flags & IV_INDEX_UPDATE;
+	kr = flags & KEY_REFRESH;
+
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+	dbus_append_dict_entry_basic(builder, "IvUpdate", "b", &ivu);
+	dbus_append_dict_entry_basic(builder, "KeyRefresh", "b", &kr);
+	l_dbus_message_builder_leave_array(builder);
 
 	return true;
 }
@@ -2295,7 +2304,7 @@ static void setup_node_interface(struct l_dbus_interface *iface)
 	l_dbus_interface_property(iface, "Features", 0, "a{sv}", features_getter,
 									NULL);
 	l_dbus_interface_property(iface, "Beacon", 0, "b", beacon_getter, NULL);
-	l_dbus_interface_property(iface, "BeaconFlags", 0, "y",
+	l_dbus_interface_property(iface, "BeaconFlags", 0, "a{sv}",
 						beaconflags_getter, NULL);
 	l_dbus_interface_property(iface, "IvIndex", 0, "u", ivindex_getter,
 									NULL);
-- 
2.20.1

