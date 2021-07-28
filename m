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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB68C432BE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 13:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FFA160F91
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 13:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbhG1NPz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 09:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbhG1NPz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 09:15:55 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23CBC061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 06:15:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y125-20020a2532830000b029058328f1b02eso2492717yby.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 06:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rpiPOzmTxUmQLBZkNI79pcAyBGS3USA6umBlfJ/AEMA=;
        b=cEJAsLr4ReUqNwCYP0PPFgLQKtK+vyLcBT34a2UrsIPcGZQlHqjE8x4bz3Bqq3tixe
         hrpNwvQN1xrNAIdaMxqoZx9Lnjz1IaUJbi4ZJEvP4mG1/qOKMub3SHYeikNvCb6stGb1
         AgZ4pD98nxumTZDp1K8y8MUYkJFbFH15+nNZxvBpEpWlXcSQm57VJqdgq203aV1m4a3p
         5kMF51WzquIRn3md4aOHRLJzpaUkL7E73bxhJesqvAJOl50mO1Vy4hheVCLB7EqKYlFI
         QZh3DBP7A57cefr3bu+MhvAxJkuF26DGS2ph6Se6mcbVAOvgdsEXYmvpkssDzqzUMSF/
         ZpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rpiPOzmTxUmQLBZkNI79pcAyBGS3USA6umBlfJ/AEMA=;
        b=XdV3f9YBgaBCaTg4izMQb4KZqWLzg9JIpNYUB7IA8zXLZTH0X0EbniWdl2hQTO9v/c
         Pi+THbSY29EN9Lw8NpBmzke1GQVcHvwONijNSn1W/NWvnIt+1YQq5tK/WO9Ev4dppKRM
         A9A6xnS8aZTTNEemOpcjRjwn/1spYlzwTAo0rVyu5r5aps2s33n8vPqLF1EA/+NOxzim
         lEFaZIaYc+diYuLhFp7oMsVukvknajPDnFqytGVOuqfq7KN1kGdf1/lVTX+GzpzaOTa5
         Kctnp1c2aTpHpIV1zLz27vLrTNaUyz1yGfqy6p2lvfAO1iTWzdHZWOR+fJ9KhaWhWOe8
         ixZw==
X-Gm-Message-State: AOAM530fsSzxyr/wXQ8nhQrhPzFGvW3/BckduGmfSsMe0jq9UdsRh9Xg
        +PNcYShwcUsbyQypPh48gBvqbRDkBo7SvYPsNanBeqatqp1jmGhmca1lMnH75PL7vbP0Dc95LVF
        58n4QvA46Q2u0+OPCap1mpcrgglv8kIOFM9l8wBJHilH8j9QNsxsJvw4lSKLodNzM+ON9H5f+ko
        UdUq4TJUM1Nw8=
X-Google-Smtp-Source: ABdhPJxCq27Q6nql0k/YabtmmdG0oowTKIKoLkGhABOoaONXoVfkuoR4fHc9mXMPwM2VN2L87Usue/w9XOFDDKOlPw==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:9b6a:9d1f:2f3e:45de])
 (user=howardchung job=sendgmr) by 2002:a25:2688:: with SMTP id
 m130mr22712013ybm.146.1627478153162; Wed, 28 Jul 2021 06:15:53 -0700 (PDT)
Date:   Wed, 28 Jul 2021 21:15:19 +0800
In-Reply-To: <20210728131529.3310558-1-howardchung@google.com>
Message-Id: <20210728211405.Bluez.v3.3.If0cf6e1feb9e9cc8106793bcaea60202852d7095@changeid>
Mime-Version: 1.0
References: <20210728131529.3310558-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [Bluez PATCH v3 03/13] mcap: add adapter authorization
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

 profiles/health/hdp.c  |  1 +
 profiles/health/mcap.c | 39 +++++++++++++++++++++++++++++++++++++--
 profiles/health/mcap.h |  7 +++++++
 tools/mcaptest.c       |  2 +-
 4 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index 6bc41946f..efa8955ef 100644
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
index be13af37a..d4cb69f77 100644
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
index 5a94c8b63..aa69b0d32 100644
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
index dcef0b908..63ee22149 100644
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
2.32.0.432.gabb21c7263-goog

