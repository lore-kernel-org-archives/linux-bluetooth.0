Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAA0C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 06:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 394C660EE8
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 06:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbhHBGNS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Aug 2021 02:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhHBGNQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Aug 2021 02:13:16 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34BDC06175F
        for <linux-bluetooth@vger.kernel.org>; Sun,  1 Aug 2021 23:13:07 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id x12-20020a05620a14acb02903b8f9d28c19so12177399qkj.23
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Aug 2021 23:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=F7VJqV3BeiJu665vbWvjgil8eUCIQvMKzwljw5TIy8g=;
        b=uGc82zsXPPEEKkj+VR67JZA6I3HM8MGm5bjV+ebmcIMTypGWrLqZdXWB6u97RqFki2
         7+X1UFWriyRMZaQLbdZdQ161HyvrqcjM5T01n1xj6USfuSYceyaJR7FrxewzcyE3RZSt
         IzIHvXqAAq30QAzE6z0ERFKwuQlLf5F6DZ3KocMfhyZ0OGQODa+i8LhtHg0zZGEc1lfg
         ecBj3I+yNgpTi4E9vLabMLcvKaVxoFnjEmncZRL4I18zu9DH9+MQEaYilSZmBXqT7MQq
         hUe4V4NndavjwRSg7JTnU4sa0Y+S+B/1L83c7eh1FHENZbr4CP+1jxlNEWB1R7uO4U3x
         gfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=F7VJqV3BeiJu665vbWvjgil8eUCIQvMKzwljw5TIy8g=;
        b=dmu5UBPLJK6a8gAeOdqcom1KO639YlFjw6UZLJcOnXvRo/l+JWlLIuBRDwnGtnitI1
         X60ty4oO0ca+c20/qa+z96IhXRPG7GotdOqRbXhnWkF8/u8YaFVKN8AfarftWDeJjJIX
         SX5vKxJDqWYH15QmXbTBehJfK0Cv7y9XIWFc43wr8glL9J8uSqtqO+cOVZ8jBbDbL4os
         9TaX9H3SnYbmrt9+YQJCPPBZk/b4NhD8Sw8A2y6yqs+uF8xf6ozFzXkvXYZP/f+weSyd
         KrFDiIPVkspE7shm5+n/6bLHo+oq8c/bWqjZoPImdr83rSAk9QQ6JTTQF1Rpe/FGVIQ6
         QgEg==
X-Gm-Message-State: AOAM530s72W83c9EyqY9/STF3p68462SjTG9rPqpeUnU7fyFW8b95pRp
        Xx/ilMzA1VZbTi3oaT1vJGLaPPTZ/5jEAoGhopPe10Boa+tfWSf5TM1UzUut0FKpUW7hS/qC6Hs
        yY8713Z2QTcl2rpNhrhSQv9EXrfOz399frVne+MtcWy7TfZCx0uEWpVsxcDFb9RDw7g/r1XdXK4
        eCL0s8rsiU+tg=
X-Google-Smtp-Source: ABdhPJz6jgYvnSoDg7/F7pKd553uERJ6+YKwWF8iW+wV545uanLlpN43rTq3VisCzWxRvfXO5o5f0xZOqp7OKMJXpQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:9f82:5515:89:f2cb])
 (user=howardchung job=sendgmr) by 2002:a05:6214:dce:: with SMTP id
 14mr9060709qvt.34.1627884786950; Sun, 01 Aug 2021 23:13:06 -0700 (PDT)
Date:   Mon,  2 Aug 2021 14:12:40 +0800
In-Reply-To: <20210802061250.170975-1-howardchung@google.com>
Message-Id: <20210802141140.Bluez.v7.3.If0cf6e1feb9e9cc8106793bcaea60202852d7095@changeid>
Mime-Version: 1.0
References: <20210802061250.170975-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v7 03/13] mcap: add adapter authorization
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
 profiles/health/mcap.c | 38 ++++++++++++++++++++++++++++++++++++--
 profiles/health/mcap.h |  9 +++++++++
 tools/mcaptest.c       |  2 +-
 5 files changed, 48 insertions(+), 4 deletions(-)

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
index be13af37a0b8..a7eaba51693a 100644
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
@@ -2005,19 +2006,38 @@ static void set_mcl_conf(GIOChannel *chan, struct mcap_mcl *mcl)
 		mcl->mi->mcl_connected_cb(mcl, mcl->mi->user_data);
 }
 
+static void auth_callback(DBusError *derr, void *user_data)
+{
+	struct mcap_mcl *mcl = user_data;
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
@@ -2044,6 +2064,18 @@ static void connect_mcl_event_cb(GIOChannel *chan, GError *gerr,
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
@@ -2060,6 +2092,7 @@ struct mcap_instance *mcap_create_instance(const bdaddr_t *src,
 					mcap_mcl_event_cb mcl_disconnected,
 					mcap_mcl_event_cb mcl_uncached,
 					mcap_info_ind_event_cb mcl_sync_info_ind,
+					mcap_authorize_cb authorize_cb,
 					gpointer user_data,
 					GError **gerr)
 {
@@ -2089,6 +2122,7 @@ struct mcap_instance *mcap_create_instance(const bdaddr_t *src,
 	mi->mcl_disconnected_cb = mcl_disconnected;
 	mi->mcl_uncached_cb = mcl_uncached;
 	mi->mcl_sync_infoind_cb = mcl_sync_info_ind;
+	mi->authorize_cb = authorize_cb;
 	mi->user_data = user_data;
 	mi->csp_enabled = FALSE;
 
diff --git a/profiles/health/mcap.h b/profiles/health/mcap.h
index 5a94c8b63bea..48b7d7846c57 100644
--- a/profiles/health/mcap.h
+++ b/profiles/health/mcap.h
@@ -9,6 +9,8 @@
  *
  */
 
+#include <dbus/dbus.h>
+
 #define MCAP_VERSION	0x0100	/* current version 01.00 */
 
 /* bytes to get MCAP Supported Procedures */
@@ -249,6 +251,11 @@ typedef void (* mcap_sync_set_cb) (struct mcap_mcl *mcl,
 					GError *err,
 					gpointer data);
 
+typedef void mcap_auth_cb(DBusError *derr, void *user_data);
+typedef guint (* mcap_authorize_cb) (const bdaddr_t *src, const bdaddr_t *dst,
+					const char *uuid, mcap_auth_cb cb,
+					void *user_data);
+
 struct mcap_mdl_cb {
 	mcap_mdl_event_cb		mdl_connected;	/* Remote device has created a MDL */
 	mcap_mdl_event_cb		mdl_closed;	/* Remote device has closed a MDL */
@@ -271,6 +278,7 @@ struct mcap_instance {
 	mcap_mcl_event_cb	mcl_disconnected_cb;	/* MCL disconnected */
 	mcap_mcl_event_cb	mcl_uncached_cb;	/* MCL has been removed from MCAP cache */
 	mcap_info_ind_event_cb	mcl_sync_infoind_cb;	/* (CSP Master) Received info indication */
+	mcap_authorize_cb	authorize_cb;		/* Method to request authorization */
 	gpointer		user_data;		/* Data to be provided in callbacks */
 	int			ref;			/* Reference counter */
 
@@ -404,6 +412,7 @@ struct mcap_instance *mcap_create_instance(const bdaddr_t *src,
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

