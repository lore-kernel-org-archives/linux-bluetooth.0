Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E18C388F9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 00:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC79C22242
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 00:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VYWsJlRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgKTAWW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Nov 2020 19:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgKTAWW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Nov 2020 19:22:22 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B94C0613CF
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2020 16:22:20 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id a20so5293984pgb.21
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2020 16:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=ob6uq+6Y5z4R94A6A97idNM+o//LBkc8gpHzZYfl3dI=;
        b=VYWsJlRk1hNpuL0djmnc9EQvvFUoCZZ6AShFrt1OEPXfriy16vhsSmh4k5QjkVeFx0
         xgBRnU4ITesopLO73iVBZVQlcogHGymPEQgBMmWdBmcEmj7yNBPMG6YXJQ6cD2jTJX9R
         iwVkpm6afgA7qAka1EKx2hn+PF0NZlzLYMpCxI7Mnd56eQHJhzI4cnrp2VTPOsF4SL6H
         OJ8YmDcu2XFLNVKdFRV9zWkbowmXeJAxPLlgk2+EiAni1oMrivJBEBx4JMSTdQGP5+ni
         lzWaRmjpJ9SpZBx7NpV9xz6PyQbjrbxEkXW0W4dgZmRF8luCeSQFw3gxTBcNMZIYz0ti
         ClJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=ob6uq+6Y5z4R94A6A97idNM+o//LBkc8gpHzZYfl3dI=;
        b=ehukWASXbdI0cdEBmtXWCIGvjcrqmf84RQ9sUoiPgaCWctlWuRlMKrRP515rAVH48p
         G+SJLw3qXT5jUTdcDacX2UfnH5GJz8+JPX3b60ZhWM5N9wi7l6i/wOiwo8sJ7mxsJD9J
         /Yw2R4y+HjUoW/32ZZqBzTw8+b9VzG06B52zYt0NTZGNhK+3ZT5CYkBklmJhWpqueYJ8
         uxwGoEb+Ufj60SwV+ZG6YIXuI+HUNIfvj5u/Yv5hIXbPzv+D6v5hByCiKvVsYJQzFeil
         H+j9xIcj76b4tP3iZg99hQ1cxdSz1LBrZQ4xOOsoxNsrtYk/wSaGr+MrI9WBSw6rdvTp
         P/GA==
X-Gm-Message-State: AOAM53020rjvm03P5F8A6pKm+Zv2cX6Zh7xcBByxaQH9oqJbEOsMR/Wy
        HGyCCqTjhquDJcysZ0ImxvikMKNHELB3lrlXHcJWLGq2zx2Yv9KO7kIfuhgSfNouQ6Z7nv4DJqK
        gAJCVpUrpbCoJdAnEjC2GMpY/YaxLcQBtuDO8L79UZ3EAx1mql9+t9ktUnkrUBs/eCvXcbqASxQ
        ==
X-Google-Smtp-Source: ABdhPJxkOygt5TjwIfKHSwEVIr4GOO25WaDalhQUaNkc2H4gB+wCN4ODl0AdRUurPKz3BcedTXOEnxfmU5A=
Sender: "pavelm via sendgmr" <pavelm@pavelm.c.googlers.com>
X-Received: from pavelm.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:67e])
 (user=pavelm job=sendgmr) by 2002:a05:6a00:9d:b029:18c:8dac:4a96 with SMTP id
 c29-20020a056a00009db029018c8dac4a96mr11578081pfj.22.1605831739644; Thu, 19
 Nov 2020 16:22:19 -0800 (PST)
Date:   Fri, 20 Nov 2020 00:22:15 +0000
Message-Id: <20201120002215.3946089-1-pavelm@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH] Fix duplicate free for GATT service includes
From:   Pavel Maltsev <pavelm@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pavel Maltsev <pavelm@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Objects in the service->includes queue are obtained via
dbus_message_iter_get_basic call and according to the
contract for the value is that it is returned by the reference
and should not be freed thus we should make a copy.

This will fix the issue when the GATT service app is disconnected
(reproduced with gatt-service included in bluez), bluetoothd is crashing:

src/gatt-database.c:gatt_db_service_removed() Local GATT service removed
src/adapter.c:adapter_service_remove() /org/bluez/hci0
src/adapter.c:remove_uuid() sending remove uuid command for index 0
src/gatt-database.c:proxy_removed_cb() Proxy removed - removing service: /serv1
munmap_chunk(): invalid pointer
---
 src/gatt-database.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 6694a0174..90cc4bade 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1999,6 +1999,7 @@ static bool parse_includes(GDBusProxy *proxy, struct external_service *service)
 	DBusMessageIter iter;
 	DBusMessageIter array;
 	char *obj;
+	char *includes;
 	int type;
 
 	/* Includes property is optional */
@@ -2017,7 +2018,11 @@ static bool parse_includes(GDBusProxy *proxy, struct external_service *service)
 
 		dbus_message_iter_get_basic(&array, &obj);
 
-		if (!queue_push_tail(service->includes, obj)) {
+		includes = g_strdup(obj);
+		if (!includes)
+			return false;
+
+		if (!queue_push_tail(service->includes, includes)) {
 			error("Failed to add Includes path in queue\n");
 			return false;
 		}
-- 
2.29.2.454.gaff20da3a2-goog

