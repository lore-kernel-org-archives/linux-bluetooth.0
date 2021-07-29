Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A98C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 03:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0182D6101C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 03:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbhG2DNv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 23:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbhG2DNn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 23:13:43 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7D8C0613C1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 20:13:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r1-20020a0569021541b029054df41d5cceso5338624ybu.18
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 20:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+fcd5Qv9ghfGsN7+gveRQgNoa21U6k7qkJYCm6II4Sk=;
        b=SwwKZceXju+uI5pFnaEdkq9zE7k0290LB+Wc27MyVRa4lYI3jRU94FIiJF9PW6WQvf
         dwV5q2vzu8GvsTXHUZl0IK4/pP4X3pwwlDomUBb+O1gPfRqmZQDVfMUDY1asx2/SzUxg
         s8qKuxpzvofGfWUTu3bGD+EBvPaEJ2A+K6/WhgJP0Vp9DoYFH5Wk9a3whxT9N27/DNcR
         tSPhQvHT9qACO7Iv+tikm4B49S1CkeR3zxTzdGHV1ZeFhb/rl6i8e6Yh+DR7JMhW43oe
         pk0ofrJf4IL11PzOQ3Hqe+1TgFRYBczdf7oMOHxSLDwQNj9+LCRtlUHofJs1mtVu5mT+
         uS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+fcd5Qv9ghfGsN7+gveRQgNoa21U6k7qkJYCm6II4Sk=;
        b=d3Drt1tpWdCXqJhpAhsGbcMNJExaUCYr9i0Q/CQHWN1avqTnmqYQ4SrkL4GslKxrqC
         795OGmpQmv6rDspRv1MidhS2GX94nu9BUEjkRDXz0WGljMv/BZTh/zD75UrkjzRIqloL
         tRL+1Snlo0DvRjNuKhjQtZl6PQhbht9FN07uJYp0ldBWhcAI0BEulG5+C+3WdKDvImKH
         Mds8QWJAovUp42r86oUEVwS6F75C2nW+C8fqc3kAjohPk0pGPs+xZYyfar6HkLi4brgv
         Czbhs2DqMLJNT+uPK2IR+0DPzo/cX/76ybks4kN6Vjk5MGJWDTQpv+2hWFDKKs1CVgS7
         VaGg==
X-Gm-Message-State: AOAM533ffcZiduJ/ae8Zn2Ux2hbVIhCBotfJRmaT70C3G5vuqDYt6uMJ
        9AnXdweCJ4IdN1czF1yZLqoCKAo2S9Y/bRQolx8wMAQjlBlnaaDf3xtkWVxmBsGLX5KED9Zb8Dg
        7s7aUYgtF5kII01SXwV7SoJcRi8dYY/6DFfpct9JXS7KFTAHW+ybODeFy+OQG1gJxzVBq/ZSqZY
        LiF/1PmiUZiTw=
X-Google-Smtp-Source: ABdhPJx9KLpS9npOeVNE9JEWkXQGra1TEvGdbkY3w1FWdJhQ8FKvuYNKzfXAeu4XeD+syF814xFrSZ9lYltv6aEIwA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ff72:1420:4502:fdaf])
 (user=howardchung job=sendgmr) by 2002:a25:9d0f:: with SMTP id
 i15mr3827914ybp.311.1627528418255; Wed, 28 Jul 2021 20:13:38 -0700 (PDT)
Date:   Thu, 29 Jul 2021 11:12:49 +0800
In-Reply-To: <20210729031258.3391756-1-howardchung@google.com>
Message-Id: <20210729110956.Bluez.v4.3.If0cf6e1feb9e9cc8106793bcaea60202852d7095@changeid>
Mime-Version: 1.0
References: <20210729031258.3391756-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v4 03/13] mcap: add adapter authorization
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

Currently mcap is the only profile that doesn't request adatper
authorization. This patch adds a argument when creating the mcap
instance to set authorize method. The reason why we don't use
btd_request_authorization directly like all other profiles is because
tools/mcaptest includes the profile/health/mcap.h. If we add dependency
to adapter.h in mcap.h, it will make mcaptest depend on adapter and be
not able to build independently.
---

(no changes since v1)

 android/health.c       |  2 +-
 profiles/health/hdp.c  |  1 +
 profiles/health/mcap.c | 39 +++++++++++++++++++++++++++++++++++++--
 profiles/health/mcap.h |  7 +++++++
 tools/mcaptest.c       |  2 +-
 5 files changed, 47 insertions(+), 4 deletions(-)

diff --git a/android/health.c b/android/health.c
index 9a29964b1be2..de50db98e988 100644
--- a/android/health.c
+++ b/android/health.c
@@ -2008,7 +2008,7 @@ bool bt_health_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 					mcl_connected, mcl_reconnected,
 					mcl_disconnected, mcl_uncached,
 					NULL, /* CSP is not used right now */
-					NULL, &err);
+					NULL, NULL, &err);
 	if (!mcap) {
 		error("health: MCAP instance creation failed %s", err->message);
 		g_error_free(err);
diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index 6bc41946fef3..efa8955efaea 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -1347,6 +1347,7 @@ static gboolean update_adapter(struct hdp_adapter *hdp_adapter)
 				mcl_connected, mcl_reconnected,
 				mcl_disconnected, mcl_uncached,
 				NULL, /* CSP is not used by now */
+				btd_request_authorization,
 				hdp_adapter, &err);
 	if (hdp_adapter->mi == NULL) {
 		error("Error creating the MCAP instance: %s", err->message);
diff --git a/profiles/health/mcap.c b/profiles/health/mcap.c
index be13af37a0b8..d4cb69f77f5b 100644
--- a/profiles/health/mcap.c
+++ b/profiles/health/mcap.c
@@ -14,6 +14,7 @@
 #endif
 
 #define _GNU_SOURCE
+#include <dbus/dbus.h>
 #include <netinet/in.h>
 #include <stdlib.h>
 #include <errno.h>
@@ -23,6 +24,7 @@
 #include <glib.h>
 
 #include "lib/bluetooth.h"
+#include "lib/uuid.h"
 #include "bluetooth/l2cap.h"
 #include "btio/btio.h"
 #include "src/log.h"
@@ -1980,7 +1982,6 @@ static void set_mcl_conf(GIOChannel *chan, struct mcap_mcl *mcl)
 	mcl->state = MCL_CONNECTED;
 	mcl->role = MCL_ACCEPTOR;
 	mcl->req = MCL_AVAILABLE;
-	mcl->cc = g_io_channel_ref(chan);
 	mcl->ctrl |= MCAP_CTRL_STD_OP;
 
 	mcap_sync_init(mcl);
@@ -2005,19 +2006,39 @@ static void set_mcl_conf(GIOChannel *chan, struct mcap_mcl *mcl)
 		mcl->mi->mcl_connected_cb(mcl, mcl->mi->user_data);
 }
 
+static void auth_callback(void *err, void *user_data)
+{
+	struct mcap_mcl *mcl = user_data;
+	DBusError *derr = err;
+
+	if (derr) {
+		error("Access denied: %s", derr->message);
+		goto reject;
+	}
+
+	set_mcl_conf(mcl->cc, mcl);
+	return;
+
+reject:
+	g_io_channel_shutdown(mcl->cc, TRUE, NULL);
+	g_io_channel_unref(mcl->cc);
+}
+
 static void connect_mcl_event_cb(GIOChannel *chan, GError *gerr,
 							gpointer user_data)
 {
 	struct mcap_instance *mi = user_data;
 	struct mcap_mcl *mcl;
-	bdaddr_t dst;
+	bdaddr_t src, dst;
 	char address[18], srcstr[18];
 	GError *err = NULL;
+	guint ret;
 
 	if (gerr)
 		return;
 
 	bt_io_get(chan, &err,
+			BT_IO_OPT_SOURCE_BDADDR, &src,
 			BT_IO_OPT_DEST_BDADDR, &dst,
 			BT_IO_OPT_DEST, address,
 			BT_IO_OPT_INVALID);
@@ -2044,6 +2065,18 @@ static void connect_mcl_event_cb(GIOChannel *chan, GError *gerr,
 		mcl->next_mdl = (rand() % MCAP_MDLID_FINAL) + 1;
 	}
 
+	mcl->cc = g_io_channel_ref(chan);
+	if (mi->authorize_cb) {
+		ret = mi->authorize_cb(&src, &dst, HDP_UUID, auth_callback,
+									mcl);
+		if (ret != 0)
+			return;
+
+		error("HDP: authorization for device %s failed", address);
+		g_io_channel_unref(mcl->cc);
+		goto drop;
+	}
+
 	set_mcl_conf(chan, mcl);
 
 	return;
@@ -2060,6 +2093,7 @@ struct mcap_instance *mcap_create_instance(const bdaddr_t *src,
 					mcap_mcl_event_cb mcl_disconnected,
 					mcap_mcl_event_cb mcl_uncached,
 					mcap_info_ind_event_cb mcl_sync_info_ind,
+					mcap_authorize_cb authorize_cb,
 					gpointer user_data,
 					GError **gerr)
 {
@@ -2089,6 +2123,7 @@ struct mcap_instance *mcap_create_instance(const bdaddr_t *src,
 	mi->mcl_disconnected_cb = mcl_disconnected;
 	mi->mcl_uncached_cb = mcl_uncached;
 	mi->mcl_sync_infoind_cb = mcl_sync_info_ind;
+	mi->authorize_cb = authorize_cb;
 	mi->user_data = user_data;
 	mi->csp_enabled = FALSE;
 
diff --git a/profiles/health/mcap.h b/profiles/health/mcap.h
index 5a94c8b63bea..aa69b0d32c0d 100644
--- a/profiles/health/mcap.h
+++ b/profiles/health/mcap.h
@@ -249,6 +249,11 @@ typedef void (* mcap_sync_set_cb) (struct mcap_mcl *mcl,
 					GError *err,
 					gpointer data);
 
+typedef void mcap_auth_cb(void *err, void *user_data);
+typedef guint (* mcap_authorize_cb) (const bdaddr_t *src, const bdaddr_t *dst,
+					const char *uuid, mcap_auth_cb cb,
+					void *user_data);
+
 struct mcap_mdl_cb {
 	mcap_mdl_event_cb		mdl_connected;	/* Remote device has created a MDL */
 	mcap_mdl_event_cb		mdl_closed;	/* Remote device has closed a MDL */
@@ -271,6 +276,7 @@ struct mcap_instance {
 	mcap_mcl_event_cb	mcl_disconnected_cb;	/* MCL disconnected */
 	mcap_mcl_event_cb	mcl_uncached_cb;	/* MCL has been removed from MCAP cache */
 	mcap_info_ind_event_cb	mcl_sync_infoind_cb;	/* (CSP Master) Received info indication */
+	mcap_authorize_cb	authorize_cb;		/* Method to request authorization */
 	gpointer		user_data;		/* Data to be provided in callbacks */
 	int			ref;			/* Reference counter */
 
@@ -404,6 +410,7 @@ struct mcap_instance *mcap_create_instance(const bdaddr_t *src,
 					mcap_mcl_event_cb mcl_disconnected,
 					mcap_mcl_event_cb mcl_uncached,
 					mcap_info_ind_event_cb mcl_sync_info_ind,
+					mcap_authorize_cb authorize_cb,
 					gpointer user_data,
 					GError **gerr);
 void mcap_release_instance(struct mcap_instance *mi);
diff --git a/tools/mcaptest.c b/tools/mcaptest.c
index dcef0b908ac8..63ee22149a40 100644
--- a/tools/mcaptest.c
+++ b/tools/mcaptest.c
@@ -434,7 +434,7 @@ int main(int argc, char *argv[])
 					mcl_connected, mcl_reconnected,
 					mcl_disconnected, mcl_uncached,
 					NULL, /* CSP is not used right now */
-					NULL, &err);
+					NULL, NULL, &err);
 
 	if (!mcap) {
 		printf("MCAP instance creation failed %s\n", err->message);
-- 
2.32.0.554.ge1b32706d8-goog

