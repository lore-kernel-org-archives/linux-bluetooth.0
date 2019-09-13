Return-Path: <SRS0=G9Zr=XI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DB8C4CEC9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Sep 2019 19:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC7C2081B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Sep 2019 19:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cdcs3bgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbfIMTDy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Sep 2019 15:03:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44921 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730335AbfIMTDy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Sep 2019 15:03:54 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so15687916pgl.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Sep 2019 12:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=x/yamvLRGsOFeDqXFur/Zb4Sdv22m/s2cmPGwv/2z0o=;
        b=Cdcs3bgHDcBKDr1CiipXvW1WJ5qLEPXzu31u2F54I4EWfsuAaCpXjU81EySF0EaIa5
         kcRxebuuznZO42gFvb0oQhotHQPAZTBdy2pzVgFrhiQ09nLuxdrjJplX3Qr7toceGJmj
         N6KSHCiKP56Ju9gUi7XcRvLYyph4Jk0BizkQrOKqyEY+mmfuk5yCEBi5BfmoQwDVFgwe
         bAkP66sAmyLIY19WuRt7MlywqOD6QQb14BeNgIieyEwNs1yk+cihQrIx1xNkA4//KEu0
         oJxdL8xuD6wPC1Cf14aYKndwEF0eX5SFfoUq2PCZ3F+ndV6Cytoi0lhkcfmfNSq8kNpY
         PGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x/yamvLRGsOFeDqXFur/Zb4Sdv22m/s2cmPGwv/2z0o=;
        b=nsPDn6YAx5w7GSBgq1I1i//fXnWo7138VLam8CZ6TE+8sKmevT9jiBa1D4R1yfrEA8
         HltElW6KBDcU6VHL4Ds/cT9WYd8sEv4BMFk+Jh66TXkJsH+Ry4G0DXJi2WWXyU/bpz6u
         3aLG+0iSL/69CO6aRB+/2lgjOuZHPoFp7O4ntpiWtdqYoM+3v8EknhDkLddOYBDMbgTp
         2xRb5md1Johc+BKKTJgpUJKHqmxS3Sxe1m7onGrBuKeXps0CL17bFbEAhhMoMMZCOwFk
         a20wUvKN/53NDsvcJQxpI47Sraw3JjCyNN4+c5XMERKuLWQj5u5aVfp9lccbJKZ1GhXw
         5DRA==
X-Gm-Message-State: APjAAAUpJ5AsC3wQJtOk8rZShP6YsdP3bWDjNvDDuOUSdebb7Cg4XHgF
        kZlfP14tRm6TFsKZkyamtAzv1aA/Cpk=
X-Google-Smtp-Source: APXvYqySS3FNW2x5QoyW4mAe8eMNpCNK+WaT7LKpOez++QcRR6smk1tZr+jlKNZDcJptGp4k9Tax7Q==
X-Received: by 2002:a62:2d3:: with SMTP id 202mr59870257pfc.141.1568401423791;
        Fri, 13 Sep 2019 12:03:43 -0700 (PDT)
Received: from inwotep.hsd1.or.comcast.net (c-98-232-219-225.hsd1.or.comcast.net. [98.232.219.225])
        by smtp.gmail.com with ESMTPSA id j5sm23444254pgp.59.2019.09.13.12.03.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Sep 2019 12:03:43 -0700 (PDT)
From:   Scott Mertz <scottmertz2@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Scott Mertz <scottmertz2@gmail.com>
Subject: [PATCH 2/2] device: reply to connect/disconnect requests on removal
Date:   Fri, 13 Sep 2019 12:03:28 -0700
Message-Id: <1568401408-24751-1-git-send-email-scottmertz2@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Replying here prevents the client from getting a DBus
NoReply when the device is removed.
---
 src/device.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index b8247cf..f42271c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -650,6 +650,7 @@ static void svc_dev_remove(gpointer user_data)
 static void device_free(gpointer user_data)
 {
 	struct btd_device *device = user_data;
+	DBusMessage *reply;
 
 	btd_gatt_client_destroy(device->client_dbus);
 	device->client_dbus = NULL;
@@ -677,11 +678,17 @@ static void device_free(gpointer user_data)
 	if (device->discov_timer)
 		g_source_remove(device->discov_timer);
 
-	if (device->connect)
+	if (device->connect) {
+		reply = btd_error_failed(device->connect, "Device removed");
+		g_dbus_send_message(dbus_conn, reply);
 		dbus_message_unref(device->connect);
+	}
 
-	if (device->disconnect)
+	if (device->disconnect) {
+		reply = btd_error_failed(device->disconnect, "Device removed");
+		g_dbus_send_message(dbus_conn, reply);
 		dbus_message_unref(device->disconnect);
+	}
 
 	DBG("%p", device);
 
-- 
2.7.4

