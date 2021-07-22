Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D18FC6377D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 07:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 298E261249
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 07:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhGVGnF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 02:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbhGVGnC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 02:43:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25CFC0613C1
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 00:23:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 132-20020a25158a0000b029055791ebe1e6so6447227ybv.20
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 00:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=leZ5/Ng01dmzmYMQdSAMnNxEPVUMttJSIsVjWwyjbFU=;
        b=ReSODkWTWlyr2AvS0IsCjKULYfLZQQ9Lr+5MxvjJR9xpC+uZGpjoNZmySAoTLElujM
         s5G4OuGJQACxSR/kFCO9e/r+B+YY4G6Ws7pAUlkl4qNRAIOFKhgUxpfDZ9SKB26F+VfU
         MEMSo8L0iGaBQVoSLcxDuqFZX+zN4YWe0c9t4CYqkTsbmWrAbrFJI1rF+SHCHabj34EW
         Whzdo/Y2T1hw4f1ovavYhpd1UXzpLx5biX3itIR86Hja4Xvd+o6DHEXHtVTI/N3HOvK/
         zHxIkPVrJF5IN3XU2FEIWBfw5LCjRqJs5u78UQduR9yD6E9GgSC3AOZVFOncjjywnvK8
         HMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=leZ5/Ng01dmzmYMQdSAMnNxEPVUMttJSIsVjWwyjbFU=;
        b=AQVryYXjsTJozNTuWJ2+CxsAqah9gYW/iUx3lM6r5BttALScDpyqtss1Pg1pl/auRA
         JHNVrT5QpHBNujxVSfo43TZtUkhZQZYCEuT+tymmJ1UhfgkaHQs5xluCZ4UH6k9kbePn
         6hGnSIKxzoSj7ptPcJAwuyihsmPiEHqJSeSDfq9RvS4+9b35p4AibjznYUpo7YsdoPCT
         5enfWvX8AjRpV1RsASlpbf7ghQBLtePgaf2iT9laU9WA/kuhLcvcdDct+PRIJ2PlroCx
         VH9+oKUMYxZJYYH6yTM/Pyg8KHmqZO7IoOxl3Ip8qaw8FFWGcFQ+Zh7HvXfZfF/5aoDC
         5lSw==
X-Gm-Message-State: AOAM530KgpeiLvcWzS3T7rN4VVBmM33pHZZccSFVlfE9R1YLDJnYDkZk
        0/mFRi5rJWPQ+05SkDZrLvSDSNju3M6UW6Ns+0QZ7ePIXXzjAtoDDbrl98C5h/HLQ4VHyOafZuB
        nTBFHNSMzwu1yDjTEqHpJtZtzNkf5UV5LRLUKhdW6YR6pCkIsqd6VwkTg5TO6Tbdf6ph+FM7uss
        Y2NeHbJan1Fcg=
X-Google-Smtp-Source: ABdhPJxF9vKf5UxgYJp6glekLmG5PiIiS+gZqNEuL643f33PUIBBWWBKkdq+nR4E/hEk+QLLjknZtA0ESiGMvnsNTg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:69a3:595f:8267:f7e0])
 (user=howardchung job=sendgmr) by 2002:a05:6902:1106:: with SMTP id
 o6mr47940346ybu.380.1626938617161; Thu, 22 Jul 2021 00:23:37 -0700 (PDT)
Date:   Thu, 22 Jul 2021 15:23:13 +0800
In-Reply-To: <20210722072321.1225119-1-howardchung@google.com>
Message-Id: <20210722152159.Bluez.v2.3.I1f8afde9aafc699f5b3ad3b51d672f0416823d50@changeid>
Mime-Version: 1.0
References: <20210722072321.1225119-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [Bluez PATCH v2 03/11] profiles: ignore incoming connection of not
 allowed service
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

Bluez listens for incoming connections for each profile. This patch
ignores them if the service is not allowed by adapter.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---
Hi maintainers,

In previous work of service_api, it blocks incoming connections by
adding a check in profile authorization callback. This doesn't work for
every profile, since some profile (e.g. health) doesn't need
authorization. This change adds check to each profile. I understand it's
not a very clean solution. Please let me know if you have other
thoughts. Thanks.

The following test steps were performed after enabling admin_policy
plugin:
1. Set ServiceAllowList to ["1234"].
2. Turn on a paired classic keyboard. Verify it can not be connected.
3. Set ServiceAllowList to
   ["1800","1801","180A","180F","1812"]
4. Turn off and turn on the keyboard. Verift it can be connected.

(no changes since v1)

 Makefile.tools          |  1 +
 profiles/audio/a2dp.c   |  6 ++++++
 profiles/audio/avctp.c  |  7 +++++++
 profiles/health/mcap.c  | 10 +++++++++-
 profiles/input/server.c | 10 ++++++++++
 src/profile.c           | 12 ++++++++++++
 6 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/Makefile.tools b/Makefile.tools
index c836b5984934..55684824fb91 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -235,6 +235,7 @@ tools_btiotest_LDADD = lib/libbluetooth-internal.la $(GLIB_LIBS)
 tools_mcaptest_SOURCES = tools/mcaptest.c \
 				btio/btio.h btio/btio.c \
 				src/log.c src/log.h \
+				src/adapter.c src/adapter.h \
 				profiles/health/mcap.h profiles/health/mcap.c
 tools_mcaptest_LDADD = lib/libbluetooth-internal.la $(GLIB_LIBS) \
 				src/libshared-mainloop.la -lrt
diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 86bc02994f75..73cf210475bd 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -2386,6 +2386,12 @@ static void confirm_cb(GIOChannel *io, gpointer data)
 		return;
 	}
 
+	if (!btd_adapter_is_uuid_allowed(adapter_find(&src),
+							ADVANCED_AUDIO_UUID)) {
+		info("A2DP is not allowed. Ignoring the incoming connection");
+		return;
+	}
+
 	chan = channel_new(server, device, io);
 	if (!chan)
 		goto drop;
diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 50de3361818f..044c10d213ac 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1587,6 +1587,13 @@ static void avctp_confirm_cb(GIOChannel *chan, gpointer data)
 
 	DBG("AVCTP: incoming connect from %s", address);
 
+	if (!btd_adapter_is_uuid_allowed(adapter_find(&src),
+							AVRCP_REMOTE_UUID)) {
+		info("AVRCP REMOTE is not allowed. "
+					"Ignoring the incoming connection");
+		return;
+	}
+
 	device = btd_adapter_find_device(adapter_find(&src), &dst,
 								BDADDR_BREDR);
 	if (!device)
diff --git a/profiles/health/mcap.c b/profiles/health/mcap.c
index be13af37a0b8..1799d73e6648 100644
--- a/profiles/health/mcap.c
+++ b/profiles/health/mcap.c
@@ -23,8 +23,10 @@
 #include <glib.h>
 
 #include "lib/bluetooth.h"
+#include "lib/uuid.h"
 #include "bluetooth/l2cap.h"
 #include "btio/btio.h"
+#include "src/adapter.h"
 #include "src/log.h"
 #include "src/shared/timeout.h"
 
@@ -2010,7 +2012,7 @@ static void connect_mcl_event_cb(GIOChannel *chan, GError *gerr,
 {
 	struct mcap_instance *mi = user_data;
 	struct mcap_mcl *mcl;
-	bdaddr_t dst;
+	bdaddr_t src, dst;
 	char address[18], srcstr[18];
 	GError *err = NULL;
 
@@ -2018,6 +2020,7 @@ static void connect_mcl_event_cb(GIOChannel *chan, GError *gerr,
 		return;
 
 	bt_io_get(chan, &err,
+			BT_IO_OPT_SOURCE_BDADDR, &src,
 			BT_IO_OPT_DEST_BDADDR, &dst,
 			BT_IO_OPT_DEST, address,
 			BT_IO_OPT_INVALID);
@@ -2027,6 +2030,11 @@ static void connect_mcl_event_cb(GIOChannel *chan, GError *gerr,
 		goto drop;
 	}
 
+	if (!btd_adapter_is_uuid_allowed(adapter_find(&src), HDP_UUID)) {
+		info("HID is not allowed. Ignoring the incoming connection");
+		return;
+	}
+
 	ba2str(&mi->src, srcstr);
 	mcl = find_mcl(mi->mcls, &dst);
 	if (mcl) {
diff --git a/profiles/input/server.c b/profiles/input/server.c
index 79cf08a66b38..94d06a383578 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -156,6 +156,11 @@ static void connect_event_cb(GIOChannel *chan, GError *err, gpointer data)
 	ba2str(&dst, address);
 	DBG("Incoming connection from %s on PSM %d", address, psm);
 
+	if (!btd_adapter_is_uuid_allowed(adapter_find(&src), HID_UUID)) {
+		info("HID is not allowed. Ignoring the incoming connection");
+		return;
+	}
+
 	ret = input_device_set_channel(&src, &dst, psm, chan);
 	if (ret == 0)
 		return;
@@ -234,6 +239,11 @@ static void confirm_event_cb(GIOChannel *chan, gpointer user_data)
 		return;
 	}
 
+	if (!btd_adapter_is_uuid_allowed(adapter_find(&src), HID_UUID)) {
+		info("HID is not allowed. Ignoring the incoming connection");
+		return;
+	}
+
 	ba2str(&dst, addr);
 
 	if (server->confirm) {
diff --git a/src/profile.c b/src/profile.c
index 60d17b6ae657..58500c74746d 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -1249,6 +1249,11 @@ static void ext_confirm(GIOChannel *io, gpointer user_data)
 
 	DBG("incoming connect from %s", addr);
 
+	if (btd_adapter_is_uuid_allowed(adapter_find(&src), uuid)) {
+		info("UUID %s is not allowed. Igoring the connection", uuid);
+		return;
+	}
+
 	conn = create_conn(server, io, &src, &dst);
 	if (conn == NULL)
 		return;
@@ -1272,6 +1277,7 @@ static void ext_direct_connect(GIOChannel *io, GError *err, gpointer user_data)
 	struct ext_profile *ext = server->ext;
 	GError *gerr = NULL;
 	struct ext_io *conn;
+	const char *uuid = ext->service ? ext->service : ext->uuid;
 	bdaddr_t src, dst;
 
 	bt_io_get(io, &gerr,
@@ -1285,6 +1291,12 @@ static void ext_direct_connect(GIOChannel *io, GError *err, gpointer user_data)
 		return;
 	}
 
+	if (btd_adapter_is_uuid_allowed(adapter_find(&src), ext->uuid)) {
+		info("UUID %s is not allowed. Igoring the connection",
+								ext->uuid);
+		return;
+	}
+
 	conn = create_conn(server, io, &src, &dst);
 	if (conn == NULL)
 		return;
-- 
2.32.0.402.g57bb445576-goog

