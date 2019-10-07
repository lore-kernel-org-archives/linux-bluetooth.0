Return-Path: <SRS0=J5Bo=YA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22554C352AA
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Oct 2019 11:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E778F206C2
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Oct 2019 11:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="VFjdokbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfJGLsV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:48:21 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:43475 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbfJGLsV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Oct 2019 07:48:21 -0400
Received: by mail-lf1-f54.google.com with SMTP id u3so9006354lfl.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Oct 2019 04:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ihqA0pqMaUtuWsIxnNgBte0+FMTka3Zg65QlOUq8eNo=;
        b=VFjdokbzmFtza3R5wrRssowF4K5GiJYG/hajyIQMPBmRax0PYr+mgtw9ZXwWpTzt6/
         1Se2bkoJfNoj6pdHfHa3mZ2Cbae9v0F6+M1+BBXnszLD7sCET7EDXfBhNcfehYRuq1Zp
         8PglsihcBOIlHuFuC502flLIAuEnUSjT0D+0KLJu1G76D7id/4qpfO2FP00FIE1TrFRm
         1cs2xnR+y9K513w9KOTsvl1kRciQT665znJn5M760nAD8cnFGkWh8P0RHH0/FIDTtxIH
         hH3Eq+aFBBpoXQqEsuhexH1htapaNdnruDBE9sXY2nztCkjviffrGbJolqW4YPVvNmJd
         hIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ihqA0pqMaUtuWsIxnNgBte0+FMTka3Zg65QlOUq8eNo=;
        b=H7qR+dXrK4o3kQzpn+g4H0axp5N9uQK1vhM8BCUDKzjNFCvqapCBLOZHgFK1A1y9f/
         5UJaK/rdeIShvDgYYmetAUJDuJZh0S09lhWtLqXYIqxjl0OvtKp2reYKCWzt5bR3+RfM
         CKODvf/z7KrL16s6JfkIyz1lZ+OF4/M1VY4PjXnpX2nxR6Gfkb9gIsXPHP2Kqj/a/HCh
         uOL7BanFm6IZnkk3j+DGV2rGDeuCcXjqfAEFkCQ8JX9ZjYVR2EH1/0fb7+SHqFv2FAUZ
         15B+5DIzr/IYhGbmF7uH9pZmCG/26RmcZP5i7Ds4MPQ5EG4BH8lbFjB/74m9ff84ki94
         lt2A==
X-Gm-Message-State: APjAAAUSmDmZ1TBgrBSgrlVmcIB3eHvdMixxZAglMyk5CPeYoT0fuuQr
        fHxYQRsBXrsju4OipqfvLaXS4aX/bcc=
X-Google-Smtp-Source: APXvYqysRIiY+JQVbtp5d2wdzoqnM98t5bHB0MrKrL7tGmYC16YSOGf/urLcIYJb/fVGC72cBA4EzQ==
X-Received: by 2002:ac2:5090:: with SMTP id f16mr17156213lfm.66.1570448899151;
        Mon, 07 Oct 2019 04:48:19 -0700 (PDT)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id j26sm2994940lja.25.2019.10.07.04.48.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 04:48:18 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Gajda?= <rafal.gajda@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] mesh: Fix dbus management interface
Date:   Mon,  7 Oct 2019 13:48:12 +0200
Message-Id: <20191007114812.29044-1-rafal.gajda@silvair.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This fixes names of dbus management interface input values.
---
 mesh/manager.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/mesh/manager.c b/mesh/manager.c
index 633597659..6c8896839 100644
--- a/mesh/manager.c
+++ b/mesh/manager.c
@@ -698,36 +698,34 @@ static struct l_dbus_message *set_key_phase_call(struct l_dbus *dbus,
 
 static void setup_management_interface(struct l_dbus_interface *iface)
 {
-	l_dbus_interface_method(iface, "AddNode", 0, add_node_call, "", "ay",
-								"uuid");
+	l_dbus_interface_method(iface, "AddNode", 0, add_node_call,
+							"", "ay", "uuid");
 	l_dbus_interface_method(iface, "ImportRemoteNode", 0, import_node_call,
-						"", "qyay", "", "primary",
-						"count", "dev_key");
+							"", "qyay", "primary", "count", "dev_key");
 	l_dbus_interface_method(iface, "DeleteRemoteNode", 0, delete_node_call,
-					"", "qy", "", "primary", "count");
+							"", "qy", "primary", "count");
 	l_dbus_interface_method(iface, "UnprovisionedScan", 0, start_scan_call,
-							"", "q", "", "seconds");
-	l_dbus_interface_method(iface, "UnprovisionedScanCancel", 0,
-						cancel_scan_call, "", "");
+							"", "q", "seconds");
+	l_dbus_interface_method(iface, "UnprovisionedScanCancel", 0, cancel_scan_call,
+							"", "");
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
+							"", "qay", "net_index", "net_key");
 	l_dbus_interface_method(iface, "CreateAppKey", 0, create_appkey_call,
-					"", "qq", "", "net_index", "app_index");
+							"", "qq", "net_index", "app_index");
 	l_dbus_interface_method(iface, "UpdateAppKey", 0, update_appkey_call,
-						"", "q", "", "app_index");
+							"", "q", "app_index");
 	l_dbus_interface_method(iface, "DeleteAppKey", 0, delete_appkey_call,
-						"", "q", "", "app_index");
+							"", "q", "app_index");
 	l_dbus_interface_method(iface, "ImportAppKey", 0, import_appkey_call,
-				"", "qqay", "", "net_index", "app_index",
-								"app_key");
+							"", "qqay", "net_index", "app_index", "app_key");
 	l_dbus_interface_method(iface, "SetKeyPhase", 0, set_key_phase_call,
-					"", "qy", "", "net_index", "phase");
+							"", "qy", "net_index", "phase");
 }
 
 bool manager_dbus_init(struct l_dbus *bus)
-- 
2.22.0

