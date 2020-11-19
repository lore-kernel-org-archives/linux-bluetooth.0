Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECCDC388F9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 20:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C58F22261
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Nov 2020 20:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eJfB6NX5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbgKSUC5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Nov 2020 15:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbgKSUC5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Nov 2020 15:02:57 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C409BC0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2020 12:02:56 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id u28so5567311qtv.20
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2020 12:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=jDi6N4xK0qQOR2A47vVbJUY/fLlGGTrrNQVRkrhLX5M=;
        b=eJfB6NX5NVfcpQk2aeqgZGa4k4cJp54sFKPGNZr+gUINsa5+f7sj/yYfrjm8DncdFQ
         bR/V/H5e88rrdbnUxQogHWE6hSaHvaQRTwZPZMtoZMXnJQ57kOz1Yn1s5Eagu8Dg0bPB
         9Ydfn68ikuaFNnILHQcgFOkvBLSS3c3duES/4Y9y3aqsltqs022ZRUhSFADxqWrv7Nov
         JEiUsAkqqqUm1pXq2Y0Vl+Ua7xRDpFgDlSzTdYe8AW1Xqb0IKgfH5gjzB6ZwbvOZx7hW
         rAiAwZUSZ1WZlT1PIAgsa4joEleKRwMobeu4rsy6hRexkw9G9OmM+Q7ltwBczfoIfYdf
         5sew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=jDi6N4xK0qQOR2A47vVbJUY/fLlGGTrrNQVRkrhLX5M=;
        b=fFeoPA1fBxSsD+tVGwYK43seICipqJS1wulU/oe7zJ7GZ5SnidbMSeyR5W0Dsmy/g5
         WA3jecP27JOAU/F4W0WQ7S4kIdtMI61V3BUuy9Lit66Y/3GqCHBSN01y7PpiAopkuxfB
         ftIQTO1OKU6aAtfKCAFGfFO2bLpsVtPPtmBHs0cjQGD7Vb2qaiOa2GEYe9TRZi4JmyC9
         iy4iDfu7xJEu7jJmNTz9gAQJRMnYwtO/mo1XYZgAmlHwUUR9uvwxwRTJ0q3Em0pGlKKa
         8DK6oIcUK4I/kf43mNEuWKrOWuCJQBRSCr608lgF6RLorjHwmFeO0zchu3NKcOykduZj
         7rpg==
X-Gm-Message-State: AOAM5330PotHSOaBehT5nLlK5wjC9twrRgT1y/OtfTpiQzb/Odtxflch
        UnH9JlLYkDLs7oUZ2L8GgzsrjopALvX//HQ+FbZHXkd7xCzZiPOT5udsd4HZKqQchJ7Eh6ajf5p
        N2xGrz3OaMJYIJfWhdRjnNU8U/53JRLI0iOIS09+zSEvWH6Bn/tfJ/UHoNy/sj3aHMbm4tDOx9g
        ==
X-Google-Smtp-Source: ABdhPJxhr/6MovDZ8FaYU944H8S8VTWUmvgnAG6AI/0VJJDN3k4E45sVKGz3EyWdkfBcBLJrMPQ+O+7lRWs=
Sender: "pavelm via sendgmr" <pavelm@pavelm.c.googlers.com>
X-Received: from pavelm.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:67e])
 (user=pavelm job=sendgmr) by 2002:a0c:8d4a:: with SMTP id s10mr13301610qvb.30.1605816175425;
 Thu, 19 Nov 2020 12:02:55 -0800 (PST)
Date:   Thu, 19 Nov 2020 20:02:50 +0000
Message-Id: <20201119200250.3848680-1-pavelm@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH] Fix duplicate free for GATT service includes
From:   Pavel Maltsev <pavelm@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pavel Maltsev <pavelm@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Service includes object is obtained via dbus_message_iter_get_basic call
and according to the contract for the value is that it is returned by
the references and should not be freed so we should make a copy.

The issue I'm running is when the GATT service app is disconnected
(reproduced with gatt-service included in bluez), bluetoothd is crashing:

bluetoothd[9771]: src/gatt-database.c:gatt_db_service_removed() Local GATT service removed
bluetoothd[9771]: src/adapter.c:adapter_service_remove() /org/bluez/hci0
bluetoothd[9771]: src/adapter.c:remove_uuid() sending remove uuid command for index 0
bluetoothd[9771]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10006
bluetoothd[9771]: src/gatt-database.c:proxy_removed_cb() Proxy removed - removing service: /service1
munmap_chunk(): invalid pointer

Signed-off-by: Pavel Maltsev <pavelm@google.com>
---
 src/gatt-database.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 6694a0174..04b49e2c1 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -2017,7 +2017,11 @@ static bool parse_includes(GDBusProxy *proxy, struct external_service *service)
 
 		dbus_message_iter_get_basic(&array, &obj);
 
-		if (!queue_push_tail(service->includes, obj)) {
+		const char* includes = g_strdup(obj);
+		if (!includes)
+			return false;
+
+		if (!queue_push_tail(service->includes, includes)) {
 			error("Failed to add Includes path in queue\n");
 			return false;
 		}
-- 
2.29.2.299.gdc1121823c-goog

