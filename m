Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D63DC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 May 2022 07:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244569AbiEaHlg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 May 2022 03:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244561AbiEaHlc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 May 2022 03:41:32 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C65E8CCEE
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 May 2022 00:41:30 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-6BGb8hCeOUCnD5ofEBvGWA-1; Tue, 31 May 2022 03:41:28 -0400
X-MC-Unique: 6BGb8hCeOUCnD5ofEBvGWA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4DB085A5B9;
        Tue, 31 May 2022 07:41:27 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.64.242.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 77CFC1410DDB;
        Tue, 31 May 2022 07:41:25 +0000 (UTC)
From:   Gopal Tiwari <gopalkrishna.tiwari@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, gtiwari@redhat.com
Subject: [Bluez V2 01/13] Fixing memory leak issue in gatt.c
Date:   Tue, 31 May 2022 13:11:05 +0530
Message-Id: <20220531074117.610321-2-gopalkrishna.tiwari@gmail.com>
In-Reply-To: <20220531074117.610321-1-gopalkrishna.tiwari@gmail.com>
References: <20220531074117.610321-1-gopalkrishna.tiwari@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Gopal Tiwari <gtiwari@redhat.com>

While performing the static tool analysis using coverity tool 
found following reports

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/client/gatt.c:1531: leaked_storage: Variable "service" 
going out of scope leaks the storage it points to.

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/client/gatt.c:2626: leaked_storage: Variable "chrc" 
going out of scope leaks the storage it points to.

Error: RESOURCE_LEAK (CWE-772):
bluez-5.64/client/gatt.c:2906: leaked_storage: Variable "desc" 
going out of scope leaks the storage it points to.

Fixing them.

Signed-off-by: Gopal Tiwari <gtiwari@redhat.com>
---
 client/gatt.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index 13872c794..4c1efaf75 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -1527,8 +1527,10 @@ void gatt_register_service(DBusConnection *conn, GDBusProxy *proxy,
 
 	if (argc > 2) {
 		service->handle = parse_handle(argv[2]);
-		if (!service->handle)
+		if (!service->handle) {
+			service_free(service);
 			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
 	}
 
 	if (g_dbus_register_interface(conn, service->path,
@@ -2622,8 +2624,10 @@ void gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy,
 
 	if (argc > 3) {
 		chrc->handle = parse_handle(argv[3]);
-		if (!chrc->handle)
+		if (!chrc->handle) {
+			chrc_free(chrc);
 			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
 	}
 
 	if (g_dbus_register_interface(conn, chrc->path, CHRC_INTERFACE,
@@ -2902,8 +2906,10 @@ void gatt_register_desc(DBusConnection *conn, GDBusProxy *proxy,
 
 	if (argc > 3) {
 		desc->handle = parse_handle(argv[3]);
-		if (!desc->handle)
+		if (!desc->handle) {
+			desc_free(desc);
 			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
 	}
 
 	if (g_dbus_register_interface(conn, desc->path, DESC_INTERFACE,
-- 
2.26.2

