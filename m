Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC23C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 May 2022 07:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244588AbiEaHmN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 May 2022 03:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244583AbiEaHmF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 May 2022 03:42:05 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67F00140C1
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 May 2022 00:42:03 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505-0oHKXtoTPhyG3Lw_9NdErQ-1; Tue, 31 May 2022 03:42:00 -0400
X-MC-Unique: 0oHKXtoTPhyG3Lw_9NdErQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 194293C138A4;
        Tue, 31 May 2022 07:42:00 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.64.242.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DC421415100;
        Tue, 31 May 2022 07:41:56 +0000 (UTC)
From:   Gopal Tiwari <gopalkrishna.tiwari@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, gtiwari@redhat.com
Subject: [Bluez V2 11/13] Fixing memory leak in pbap.c
Date:   Tue, 31 May 2022 13:11:15 +0530
Message-Id: <20220531074117.610321-12-gopalkrishna.tiwari@gmail.com>
In-Reply-To: <20220531074117.610321-1-gopalkrishna.tiwari@gmail.com>
References: <20220531074117.610321-1-gopalkrishna.tiwari@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Gopal Tiwari <gtiwari@redhat.com>

Reported by coverity tool as follows:

bluez-5.64/obexd/client/pbap.c:929: leaked_storage: Variable "apparam" 
going out of scope leaks the storage it points to.

Signed-off-by: Gopal Tiwari <gtiwari@redhat.com>
---
 obexd/client/pbap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
index 1a2bacc9f..1ed8c68ec 100644
--- a/obexd/client/pbap.c
+++ b/obexd/client/pbap.c
@@ -925,10 +925,11 @@ static DBusMessage *pbap_search(DBusConnection *connection,
 		return g_dbus_create_error(message,
 				ERROR_INTERFACE ".InvalidArguments", NULL);
 
-	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_STRING)
+	if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_STRING) {
+		g_obex_apparam_free(apparam);
 		return g_dbus_create_error(message,
 				ERROR_INTERFACE ".InvalidArguments", NULL);
-
+	}
 	dbus_message_iter_get_basic(&args, &value);
 	dbus_message_iter_next(&args);
 
-- 
2.26.2

