Return-Path: <SRS0=zBKN=5Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F97C43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 17:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F86F20BED
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 17:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ysijnhs5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgCaRnR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:43:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41019 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgCaRnP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Mar 2020 13:43:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id a24so3816606pfc.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2020 10:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bPcgr0ZzFZtYxT0SzjmjoRcEP9J0iat0KOVCNHCgw7s=;
        b=Ysijnhs5A7jTShMNsVb8hkWRFkx/ndVsnv5g1+8olD+WKiOgrLGpc8Mc82GvDIJOZc
         xpOBHXMgGMCEaV7P3XKbvCogYTcn6OfTU8wfhm/QEnY4zzAR42xI8oTgv7v4fXUCgISq
         NBi7GK//1XdWtx7as2uTqO+Sflz1juBujU5mB6N5y7mX3witlOMckGZkurA66s5e7Q36
         2BrqNtwSKrHpcKlVJJJ78JtcGwJqy2oH4Q6Oe9Kd2+uF2xRBYnYYnhngvJN+JIr95eST
         lJnZOtUjQW6UVSRD+fA+HOcSHdT5+ZSoKGUXwh9ccSfeTZHkYnnNiUN+pdtQltCS0qoP
         osYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bPcgr0ZzFZtYxT0SzjmjoRcEP9J0iat0KOVCNHCgw7s=;
        b=tS0L7MJ+9U/L12FlJG9NfGIg1L0w5/ZRO1/iiWcwk36Tz3vh8PQUICnlJYdXms50l/
         87TTxhYwFFVdbkpljGZCFNw6AMiy3gZ+YGSgoJThtAwTInlRrmFPjuIh1uQTNgyTrGqY
         bnp85kAF/mClwDimd2EPQqqWIwdOEIQ5Te6HwzDf5J9Qxo+f9BkjBqwoXmDcGa9kWAQM
         VUj/3k6iwPTLRqHFd7A+d9juQkRqZhqOdpG7NyTcquRan49McneSKpk/kQGL0Fu9QoKA
         50I7kkV6MYmiXBpN6dqIc/nbTxmVUTZbWmQEL++Lf4NMcAZYLeEqdHY34FJ5oSrwaWE1
         0bEA==
X-Gm-Message-State: ANhLgQ2y/0ZiZflJgJV86kLthvBf1Fst5YmOphdzj1T8iYXpFooVdD9d
        HsG5fQaOg9Pv23bBtOplNPp6BU+1vP4=
X-Google-Smtp-Source: ADFU+vt6T9aqdNrGe2fVDjhKTwVKOTDd5jYRcBxN3t7K/ZpkMDMv8fZsrGtwAkPF9XPTxLw/XYtSLg==
X-Received: by 2002:aa7:991c:: with SMTP id z28mr19163814pff.294.1585676594239;
        Tue, 31 Mar 2020 10:43:14 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x4sm12870558pfi.202.2020.03.31.10.43.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 10:43:13 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] gatt: Fix possible crashes when disconnecting
Date:   Tue, 31 Mar 2020 10:43:11 -0700
Message-Id: <20200331174311.6045-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If there are pending AcquireWrite or AcquireNotify when disconnecting
the attribute object may be freed (e.g. device is temporary) leading to
the following backtrace:

bluetoothd[369928]: src/gatt-database.c:gatt_db_service_removed() Local GATT service removed
bluetoothd[369928]: src/adapter.c:adapter_service_remove() /org/bluez/hci1
bluetoothd[369928]: src/adapter.c:remove_uuid() sending remove uuid command for index 1
bluetoothd[369928]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x1002e
bluetoothd[369928]: src/gatt-database.c:send_notification_to_device() GATT server sending indication
bluetoothd[369928]: src/device.c:gatt_debug() Write Complete: err -125
bluetoothd[369928]: src/gatt-database.c:client_disconnect_cb() Client disconnected
bluetoothd[369928]: src/advertising.c:client_disconnect_cb() Client disconnected
bluetoothd[369928]: Failed to acquire write: org.freedesktop.DBus.Error.NoReply

Program received signal SIGSEGV, Segmentation fault.
0x0000555555631450 in acquire_write_reply (message=0x55555583dec0, user_data=0x555555843e40) at src/gatt-database.c:2437
2437            send_write(op->device, op->attrib, chrc->proxy, NULL, op->id,
---
 src/gatt-database.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index c11d14b41..55fd28a54 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -2405,6 +2405,11 @@ static void acquire_write_reply(DBusMessage *message, void *user_data)
 	int fd;
 	uint16_t mtu;
 
+	if (!op->owner_queue) {
+		DBG("Pending write was canceled when object got removed");
+		return;
+	}
+
 	chrc = gatt_db_attribute_get_user_data(op->attrib);
 	dbus_error_init(&err);
 
@@ -2487,6 +2492,11 @@ static void acquire_notify_reply(DBusMessage *message, void *user_data)
 	int fd;
 	uint16_t mtu;
 
+	if (!op->owner_queue) {
+		DBG("Pending notify was canceled when object got removed");
+		return;
+	}
+
 	dbus_error_init(&err);
 
 	if (dbus_set_error_from_message(&err, message) == TRUE) {
-- 
2.21.1

