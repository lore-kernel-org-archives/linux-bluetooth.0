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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B478DC432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 12:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95E3260F23
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 12:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237018AbhG2M2U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 08:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237104AbhG2M2R (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 08:28:17 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2253C0613D5
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 05:28:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f3-20020a25cf030000b029055a2303fc2dso6572055ybg.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 05:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+fcd5Qv9ghfGsN7+gveRQgNoa21U6k7qkJYCm6II4Sk=;
        b=engS8A5pBz6cs4CQ3y0h39tB8MhjlhlN7NAeiMtGrEQ/WeAwNnPe+x112sxY0DpwTT
         u86zvCNDmbX9oD3dFZeusqmGAF2LoMmuTR9OY4G0mK5JqMNPyS4dPtOXb+zNvc5EiLMI
         0XmxXK5wiFw7VltEgSA8512X9UAKtd4YOCccHymeEVmIvXX3ISh+3qy3JpP1n/BObP1N
         Vem254RQLfbGcQLUflAunI2IeMKTcqXzcY77Zv2HeKQlV6dUD6b/6FwzT07aIfvLe6zG
         qPudg+V0wJD23daQmFf5puIIgyjwjiy6RI7ooymXWhBEsLcN+QONNEecsdIWQ4klSuL6
         Wklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+fcd5Qv9ghfGsN7+gveRQgNoa21U6k7qkJYCm6II4Sk=;
        b=Wh0DxLpIhquiPutx13uuoX/F8epkAIYGxBHW6UdpMLwDqt4UTjDZpWTWLxxrvzUwAh
         IFtmSI+HiMMrhE8IKEX7bJMHYfKtp3Y++zdsMcK6V5x+ipoc84vi2haLE/1QpBdrzala
         D8pn/R/ocLhqLaRF0CSxpsg9gwCzYfqLgp3fmiThsvdidkSqThGNsvfhMSSDx+27dJwQ
         No4egvrciaggxnw+TjVIRL5eSUUnS5sy05hv+vz6hM0oxALb2KEknsWpbi1V3EVTZVez
         MT8Kx+fRY3Fg0VqYDwxuxJ8vIvkbKrFJpGQRupTjUZTuFeHNqYKd9bl98zvnOw8vKnUu
         2Jbw==
X-Gm-Message-State: AOAM530shj6cJ5Z8AJSgGyIg09gwJx40leHZsUFnChzWu19bGt7cf7uQ
        jMa/Dp4lLAmZVuvNfQQl6lspXnHUSP9voopMV9fppnLnUs7TLCe9Ut3tX9SxgpAgIsM22MbEuUI
        cPfmG49PQbThKy9q+kPsjLkGmWFGQjpacnKOsF6SfKu5peRTcD0Lt4nhan+vOraO0fqKYUxoAem
        QkHCtbm890PdA=
X-Google-Smtp-Source: ABdhPJwC22ud52M67m/2a9MKP56j3nnmNtIwt4Nilby24VMH6tFXmbHdVRzuBU9utH9Y6Jz4tr+wX6Szxf25nbVsNw==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ff72:1420:4502:fdaf])
 (user=howardchung job=sendgmr) by 2002:a25:e006:: with SMTP id
 x6mr5953175ybg.341.1627561694088; Thu, 29 Jul 2021 05:28:14 -0700 (PDT)
Date:   Thu, 29 Jul 2021 20:27:41 +0800
In-Reply-To: <20210729122751.3728885-1-howardchung@google.com>
Message-Id: <20210729202648.Bluez.v6.3.If0cf6e1feb9e9cc8106793bcaea60202852d7095@changeid>
Mime-Version: 1.0
References: <20210729122751.3728885-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v6 03/13] mcap: add adapter authorization
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

