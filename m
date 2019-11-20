Return-Path: <SRS0=VswU=ZM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D31C432C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Nov 2019 09:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8446821850
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Nov 2019 09:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="R8P0r6mM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbfKTJKa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Nov 2019 04:10:30 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:46902 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbfKTJKa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Nov 2019 04:10:30 -0500
Received: by mail-lj1-f178.google.com with SMTP id e9so26602406ljp.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2019 01:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qn7jlJNvwwdSucNx2LHY78ABAQNtQxKaodAV+cYjKL4=;
        b=R8P0r6mMy7Xr7C1hFQAaC3N0L6b/6/AupTkL6nb3ApdvrmXWDn6eRXqJ2nL0EbMwmJ
         o7fzILyyPXX9MB7T4nO8XOlR8OcJQhwOUG0Ftf5LZlBOHWdrFYxS7W3/GjvWz23HLnmF
         JL23na904/zZV2atysp6Ai4u8qguT6rdfsPhv+op7+NvlhWA298nZiBZiBq3Bp1UYTDN
         RgY+aaEGy02JbFx+t7/ojETk3FVlYuDPwBSuWXEhnvsnwgpLJvk2slOlX3Uze4mBGZCQ
         Ool5cmx1Cd1zSHRNrj6WF3FpxwGiH/KPuf8sqV5BrfIsmgGC3jbahoswu7LJ73ldruSU
         DJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qn7jlJNvwwdSucNx2LHY78ABAQNtQxKaodAV+cYjKL4=;
        b=VxfdyS3t2E94shVHH6YQFZARXPQiKWe0TpSnORJQ9zRQkYsMMwFA9u7lccjqsa8tth
         qo24eGKnxaeSEhdwUGSM9GoZxng0vFGe7M0ou4xmAaVuE5eKtiz7B1hF30n9osgTWtHp
         Sg0IJLw66ovpKv0WuNtN3KT+InPD7uY2ixLGE/DpbWCm9i0THI/yo59zRq8Fod9lojcA
         d/P0NzRZzxIyjvjgJgYqZycEHFP5JCGjVnh2sa8W+1F/w7rzPjInH5fpAlcipPU+3c+D
         HaqITQibSLHo6LPGLLYn9Fkg09KtKEENoyOqSS5ZG073Wfj7majDDUQeb8bE3jpx5pDu
         2i4A==
X-Gm-Message-State: APjAAAWltEY3MjS0O1NvGwEbagbRxQ4/m2Ko0NADjTZ1SmUqUuXCTmRm
        HLZCcCGFqZZlWV/YwCM5Bk5uaQ/oZD4=
X-Google-Smtp-Source: APXvYqyrWSQnlb+izbM9QkUq7xB5iM1nlyIK0m64cy/kxZ1XGMMMQksRtLj8Jkpc3kJXyVy06BWTOw==
X-Received: by 2002:a2e:9985:: with SMTP id w5mr1673956lji.162.1574241026764;
        Wed, 20 Nov 2019 01:10:26 -0800 (PST)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id 68sm11710503ljf.26.2019.11.20.01.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 01:10:25 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Gajda?= <rafal.gajda@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?Rafa=C5=82=20Gajda?= <rafal.gajda@silvair.com>
Subject: [PATCH BlueZ] mesh: Fix names of dbus management interface input arguments
Date:   Wed, 20 Nov 2019 10:09:29 +0100
Message-Id: <20191120090930.3993-1-rafal.gajda@silvair.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Previously names for method arguments in "org.bluez.mesh.Management1"
would not register properly, being shifted by one:
     <method name="ImportRemoteNode">
		 <arg name="" type="q" direction="in"/>
		 <arg name="primary" type="y" direction="in"/>
		 <arg name="count" type="ay" direction="in"/>
	 </method>

 This fixes this issue:
	 <method name="ImportRemoteNode">
		 <arg name="primary" type="q" direction="in"/>
		 <arg name="count" type="y" direction="in"/>
		 <arg name="dev_key" type="ay" direction="in"/>
	 </method>
---
 mesh/manager.c | 60 ++++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/mesh/manager.c b/mesh/manager.c
index adbb01280..1ad6c126d 100644
--- a/mesh/manager.c
+++ b/mesh/manager.c
@@ -750,37 +750,35 @@ static struct l_dbus_message *set_key_phase_call(struct l_dbus *dbus,
 
 static void setup_management_interface(struct l_dbus_interface *iface)
 {
-	l_dbus_interface_method(iface, "AddNode", 0, add_node_call, "", "ay",
-								"uuid");
-	l_dbus_interface_method(iface, "ImportRemoteNode", 0, import_node_call,
-						"", "qyay", "", "primary",
-						"count", "dev_key");
-	l_dbus_interface_method(iface, "DeleteRemoteNode", 0, delete_node_call,
-					"", "qy", "", "primary", "count");
-	l_dbus_interface_method(iface, "UnprovisionedScan", 0, start_scan_call,
-							"", "q", "", "seconds");
-	l_dbus_interface_method(iface, "UnprovisionedScanCancel", 0,
-						cancel_scan_call, "", "");
-	l_dbus_interface_method(iface, "CreateSubnet", 0, create_subnet_call,
-						"", "q", "", "net_index");
-	l_dbus_interface_method(iface, "UpdateSubnet", 0, update_subnet_call,
-						"", "q", "", "net_index");
-	l_dbus_interface_method(iface, "DeleteSubnet", 0, delete_subnet_call,
-						"", "q", "", "net_index");
-	l_dbus_interface_method(iface, "ImportSubnet", 0, import_subnet_call,
-					"", "qay", "", "net_index", "net_key");
-	l_dbus_interface_method(iface, "CreateAppKey", 0, create_appkey_call,
-					"", "qq", "", "net_index", "app_index");
-	l_dbus_interface_method(iface, "UpdateAppKey", 0, update_appkey_call,
-						"", "q", "", "app_index");
-	l_dbus_interface_method(iface, "DeleteAppKey", 0, delete_appkey_call,
-						"", "q", "", "app_index");
-	l_dbus_interface_method(iface, "ImportAppKey", 0, import_appkey_call,
-				"", "qqay", "", "net_index", "app_index",
-								"app_key");
-	l_dbus_interface_method(iface, "SetKeyPhase", 0, set_key_phase_call,
-					"", "qy", "", "net_index", "phase");
-}
+    l_dbus_interface_method(iface, "AddNode", 0, add_node_call, "",
+                            "ay", "uuid");
+    l_dbus_interface_method(iface, "ImportRemoteNode", 0, import_node_call, "",
+                            "qyay", "primary", "count", "dev_key");
+    l_dbus_interface_method(iface, "DeleteRemoteNode", 0, delete_node_call, "",
+                            "qy", "primary", "count");
+    l_dbus_interface_method(iface, "UnprovisionedScan", 0, start_scan_call, "",
+                            "q", "seconds");
+    l_dbus_interface_method(iface, "UnprovisionedScanCancel", 0, cancel_scan_call, "",
+                            "");
+    l_dbus_interface_method(iface, "CreateSubnet", 0, create_subnet_call, "",
+                            "q", "net_index");
+    l_dbus_interface_method(iface, "UpdateSubnet", 0, update_subnet_call, "",
+                            "q", "net_index");
+    l_dbus_interface_method(iface, "DeleteSubnet", 0, delete_subnet_call, "",
+                            "q", "net_index");
+    l_dbus_interface_method(iface, "ImportSubnet", 0, import_subnet_call, "",
+                            "qay", "net_index", "net_key");
+    l_dbus_interface_method(iface, "CreateAppKey", 0, create_appkey_call, "",
+                            "qq", "net_index", "app_index");
+    l_dbus_interface_method(iface, "UpdateAppKey", 0, update_appkey_call, "",
+                            "q", "app_index");
+    l_dbus_interface_method(iface, "DeleteAppKey", 0, delete_appkey_call, "",
+                            "q", "app_index");
+    l_dbus_interface_method(iface, "ImportAppKey", 0, import_appkey_call, "",
+                            "qqay", "net_index", "app_index", "app_key");
+    l_dbus_interface_method(iface, "SetKeyPhase", 0, set_key_phase_call, "",
+                            "qy", "net_index", "phase");
+ }
 
 bool manager_dbus_init(struct l_dbus *bus)
 {
-- 
2.22.0

