Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEFAC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 May 2022 07:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240481AbiEaHmL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 May 2022 03:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244588AbiEaHmD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 May 2022 03:42:03 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 193C417054
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 May 2022 00:41:59 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-SoPxMpqFPm-69KalcedRPQ-1; Tue, 31 May 2022 03:41:56 -0400
X-MC-Unique: SoPxMpqFPm-69KalcedRPQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C5A33C138A8;
        Tue, 31 May 2022 07:41:56 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.64.242.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A75F1415100;
        Tue, 31 May 2022 07:41:53 +0000 (UTC)
From:   Gopal Tiwari <gopalkrishna.tiwari@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, gtiwari@redhat.com
Subject: [Bluez V2 10/13] Fixing use after free in src/device.c
Date:   Tue, 31 May 2022 13:11:14 +0530
Message-Id: <20220531074117.610321-11-gopalkrishna.tiwari@gmail.com>
In-Reply-To: <20220531074117.610321-1-gopalkrishna.tiwari@gmail.com>
References: <20220531074117.610321-1-gopalkrishna.tiwari@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Gopal Tiwari <gtiwari@redhat.com>

Following traces reported by covirty tool

Error: USE_AFTER_FREE (CWE-416):
bluez-5.64/src/device.c:2962: path: Condition 
"!dbus_message_get_args(msg, NULL, 0 /* (int)0 */)", taking false branch.

bluez-5.64/src/device.c:2965: path: 
Condition "device->bonding", taking false branch.

bluez-5.64/src/device.c:2968: path: 
Condition "device->bredr_state.bonded", taking true branch.

bluez-5.64/src/device.c:2969: path: Falling through to end of 
if statement.

bluez-5.64/src/device.c:2977: path: Condition "state->bonded", 
taking false branch.

bluez-5.64/src/device.c:2983: path: Condition "agent", taking 
true branch.

bluez-5.64/src/device.c:2984: path: Falling through to end of 
if statement.

bluez-5.64/src/device.c:2990: path: Condition "agent", taking 
true branch.

bluez-5.64/src/device.c:3005: path: Condition "bdaddr_type != 0", 
taking true branch.

bluez-5.64/src/device.c:3006: path: 

Condition "!state->connected", taking true branch.

bluez-5.64/src/device.c:3006: path: 
Condition "btd_le_connect_before_pairing()", taking true branch.
bluez-5.64/src/device.c:3007: freed_arg: "device_connect_le" frees 
"device->bonding".

bluez-5.64/src/device.c:3007: path: Falling through to end of 
if statement.

bluez-5.64/src/device.c:3012: path: Falling through to end of 
if statement.

bluez-5.64/src/device.c:3017: path: Condition "err < 0", 
taking true branch.

bluez-5.64/src/device.c:3018: double_free: Calling "bonding_request_free" 
frees pointer "device->bonding" which has already been freed.

Signed-off-by: Gopal Tiwari <gtiwari@redhat.com>
---
 src/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/device.c b/src/device.c
index 8dc12d026..a0e5d40db 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2942,6 +2942,7 @@ static void bonding_request_free(struct bonding_req *bonding)
 		bonding->device->bonding = NULL;
 
 	g_free(bonding);
+	bonding = NULL;
 }
 
 static DBusMessage *pair_device(DBusConnection *conn, DBusMessage *msg,
-- 
2.26.2

