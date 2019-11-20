Return-Path: <SRS0=VswU=ZM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63652C432C3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Nov 2019 10:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA3B2243F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Nov 2019 10:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="Phccrz5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbfKTKuG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Nov 2019 05:50:06 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]:39173 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbfKTKuG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Nov 2019 05:50:06 -0500
Received: by mail-lj1-f174.google.com with SMTP id p18so26983449ljc.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2019 02:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lziwnzQ0VV6OaEApFgLdcnyv2faXiVXPEN+aEW8ouIg=;
        b=Phccrz5bMJ0ooFSTVkqeCY2asqBNJPA5eHoVN3mwS4/vu5AOlxdOkn2g5kDmx2Shwn
         VBJa9JVxxZ3BsrGzzkGOM8c/GgFtoOCuglXcVO3sNM2SUXnj3k59sM/paK5w1F7JFXWy
         d39gIvEKGwUQnj0PdkqO4MeMiuMoIKK8Z9kRb4VluI57tnyKlvtZ8MJwlqZ820oznJdk
         M3gVF4kK5BlhmHwgIySWXtvEaWUxbweY7EXnJdvbaJxvwPipF+rb0M9XMNLyZM9Rs2xh
         ertn8RVaY2Jxa/ewcab4s2OwA20/PKhhLr+H1LmrB/c+0yTRQCAk/vC+dbAW5baHftRc
         sK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lziwnzQ0VV6OaEApFgLdcnyv2faXiVXPEN+aEW8ouIg=;
        b=JeSNj81WUzko6QOSlaqRENj8PWP4gY+uzj08EsQX9WLQiWWDvqmUchi8Eo5MnWChJ2
         MALNduKtKUu+tehM8hY9lpXBjmDTsI4bGSb+rbxTRMAhYN7XIHApjCYPJ6/yC/mO0oQ3
         dF4UK/Y/tpIJ2xcP0ezd7EygkI7wsyKAVOFl4FZFH8/8GotnYIb6EiOKIztvEzRIqHj0
         j1uGkpNKdHKHT5Ig69kPHzE8wqWhydhummy37y9AVVyF3vw8cXSClj27nD29Bv8rw9tM
         Km2GttpaOjhbOjPIv6HHWnD2JbIbUr6hG9RgSl1Eu+VbrhBsOrjPm0iz8USiDM2cq+Bc
         waCA==
X-Gm-Message-State: APjAAAUvfnoRTifBzsfUrjNp2tsn6+p1UKovtnnCEALNSRzJx9wi/oju
        mPExFmFBQ6uBO2v46NW06ArDPvFHmZc=
X-Google-Smtp-Source: APXvYqy6pPzGQ5revvQgKPnfRJKLK1WEqJL+40z9fZ4xVoXI3/9ClovaJe8WFkEvFbTRDVK+WlWVjA==
X-Received: by 2002:a2e:9a95:: with SMTP id p21mr2056370lji.175.1574247002402;
        Wed, 20 Nov 2019 02:50:02 -0800 (PST)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id t13sm11299830ljo.70.2019.11.20.02.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 02:50:01 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Gajda?= <rafal.gajda@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?Rafa=C5=82=20Gajda?= <rafal.gajda@silvair.com>
Subject: [PATCH BlueZ v2] mesh: Fix names of dbus management interface input arguments
Date:   Wed, 20 Nov 2019 11:49:50 +0100
Message-Id: <20191120104950.7904-1-rafal.gajda@silvair.com>
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

v2 - Fixed coding standard

 mesh/manager.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/mesh/manager.c b/mesh/manager.c
index adbb01280..1fb9df5e6 100644
--- a/mesh/manager.c
+++ b/mesh/manager.c
@@ -750,36 +750,34 @@ static struct l_dbus_message *set_key_phase_call(struct l_dbus *dbus,
 
 static void setup_management_interface(struct l_dbus_interface *iface)
 {
-	l_dbus_interface_method(iface, "AddNode", 0, add_node_call, "", "ay",
-								"uuid");
+	l_dbus_interface_method(iface, "AddNode", 0, add_node_call,
+							"", "ay", "uuid");
 	l_dbus_interface_method(iface, "ImportRemoteNode", 0, import_node_call,
-						"", "qyay", "", "primary",
-						"count", "dev_key");
+				"", "qyay", "primary", "count", "dev_key");
 	l_dbus_interface_method(iface, "DeleteRemoteNode", 0, delete_node_call,
-					"", "qy", "", "primary", "count");
+						"", "qy", "primary", "count");
 	l_dbus_interface_method(iface, "UnprovisionedScan", 0, start_scan_call,
-							"", "q", "", "seconds");
+							"", "q", "seconds");
 	l_dbus_interface_method(iface, "UnprovisionedScanCancel", 0,
 						cancel_scan_call, "", "");
 	l_dbus_interface_method(iface, "CreateSubnet", 0, create_subnet_call,
-						"", "q", "", "net_index");
+							"", "q", "net_index");
 	l_dbus_interface_method(iface, "UpdateSubnet", 0, update_subnet_call,
-						"", "q", "", "net_index");
+							"", "q", "net_index");
 	l_dbus_interface_method(iface, "DeleteSubnet", 0, delete_subnet_call,
-						"", "q", "", "net_index");
+							"", "q", "net_index");
 	l_dbus_interface_method(iface, "ImportSubnet", 0, import_subnet_call,
-					"", "qay", "", "net_index", "net_key");
+					"", "qay", "net_index", "net_key");
 	l_dbus_interface_method(iface, "CreateAppKey", 0, create_appkey_call,
-					"", "qq", "", "net_index", "app_index");
+					"", "qq", "net_index", "app_index");
 	l_dbus_interface_method(iface, "UpdateAppKey", 0, update_appkey_call,
-						"", "q", "", "app_index");
+							"", "q", "app_index");
 	l_dbus_interface_method(iface, "DeleteAppKey", 0, delete_appkey_call,
-						"", "q", "", "app_index");
+							"", "q", "app_index");
 	l_dbus_interface_method(iface, "ImportAppKey", 0, import_appkey_call,
-				"", "qqay", "", "net_index", "app_index",
-								"app_key");
+			"", "qqay", "net_index", "app_index", "app_key");
 	l_dbus_interface_method(iface, "SetKeyPhase", 0, set_key_phase_call,
-					"", "qy", "", "net_index", "phase");
+						"", "qy", "net_index", "phase");
 }
 
 bool manager_dbus_init(struct l_dbus *bus)
-- 
2.22.0

