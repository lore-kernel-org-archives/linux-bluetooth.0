Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848C2C4320A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 10:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AEE3610E9
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 10:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243237AbhIBKwM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 06:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245096AbhIBKvS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 06:51:18 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F80C061796
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Sep 2021 03:50:20 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f8-20020a2585480000b02905937897e3daso1985801ybn.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Sep 2021 03:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=R0Oz659LTTcuMbArQXPd0hyEmyluAWgCjC36Lfk/tZY=;
        b=SYSNp2zHPj5ELWB7T3I132D5IuW+lGcxgU9KH2LyL6rzarOrwz8rRzAGqcfoLgJP/M
         h+yZQQSjFQL7Ea/qFwnOwRhXgPeb7ZLwA9GIcTBKxQ+nZBo3XvX0he4Tc/LBFtXZ5dxN
         yQULtKGOIsMPBWgLtfaZ1M9ghF9ljx70omoT6JaRxA3hZcbou0vuWSkQit+zI5n4af0z
         Ef25hkDB23RDHaxkjUNwBfRgTThg0kOAl6/7A+uJQM1qUB2mXlz4aXvYQ00Rtgv1KZWQ
         282nP/7000gctolP/Rwyp8e5g16Y1dzp4jtgVw4Ly+VWgDOPnLBA8wI0C71d6uSaR/kz
         +3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=R0Oz659LTTcuMbArQXPd0hyEmyluAWgCjC36Lfk/tZY=;
        b=ZNLMsW6j9gz7Y29ciwMo6sXfToJS/nGwWRIxOGCjezEIzuSrNnOA5N1uXt6OyH/D+8
         RFhso/j5PIqG12ZHujA1LEDqXU0IogbB+uZcPLrBqwgrbM3SEVAnUBiawu1/DGyT5Cnf
         E9HsZhHrMP9/yihahr/QNiWoPZttkN4OPG80fB59a0jysDC4NIsnBOIk56mdooVR2vQF
         ffkYL5yQwfg9u432KD/t38um1qnctv9h0Xv0z06jMSBvAptuHATB7oLXWIuudklv17fP
         2euc0qSBT26T4FFGDW6l9GaNtdcO6DOJtCrghtJjrjSzOobwtPlBUNMkytzIITbv0Qow
         0DTA==
X-Gm-Message-State: AOAM533J+7X4rLW8bwHFlTpwLSqLbFtoCszUTSjtMRjwFIHGGIn+mFX+
        6899/62CWdCDUx+FX5Jk4Gpti262tX7F56nXXkNoZcnAErmNhxxVZrXjMg4iHI2xVeIk/KZ14zI
        RGm0F87uFhadW2BwJJcUML6WDVLNHBg4+vB28XTGX/aJvtPmExHVk3i8GkMHikduWvgU4ql5pcl
        Ki
X-Google-Smtp-Source: ABdhPJzr5wYo0OGUf6zxZ8e/Lsv8Q5rOjlDcM6j22ivs5ipevSBg2K8irUkHn9qMm1ZiaiJu3OWlyoImz6M2
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:5249:e81c:3ce6:f50c])
 (user=apusaka job=sendgmr) by 2002:a25:1a56:: with SMTP id
 a83mr3595751yba.238.1630579819376; Thu, 02 Sep 2021 03:50:19 -0700 (PDT)
Date:   Thu,  2 Sep 2021 18:49:33 +0800
In-Reply-To: <20210902104938.824737-1-apusaka@google.com>
Message-Id: <20210902184744.Bluez.v3.7.I50be9be1265bc743325cfdb9fa0bdbce9671a304@changeid>
Mime-Version: 1.0
References: <20210902104938.824737-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [Bluez PATCH v3 07/12] profiles: Inclusive language changes
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

BT core spec 5.3 promotes the usage of inclusive languages.
This CL replaces some terms with the more appropriate counterparts,
such as "central" and "peripheral".
---

(no changes since v2)

Changes in v2:
* Merging several patches from the same directory into one

 profiles/audio/avctp.c | 10 +++++-----
 profiles/audio/avctp.h |  2 +-
 profiles/health/mcap.c | 20 ++++++++++----------
 profiles/health/mcap.h |  2 +-
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 9f717f35bb..702ded1366 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -1614,7 +1614,7 @@ static void avctp_confirm_cb(GIOChannel *chan, gpointer data)
 	return;
 }
 
-static GIOChannel *avctp_server_socket(const bdaddr_t *src, gboolean master,
+static GIOChannel *avctp_server_socket(const bdaddr_t *src, gboolean central,
 						uint8_t mode, uint16_t psm)
 {
 	GError *err = NULL;
@@ -1625,7 +1625,7 @@ static GIOChannel *avctp_server_socket(const bdaddr_t *src, gboolean master,
 				BT_IO_OPT_SOURCE_BDADDR, src,
 				BT_IO_OPT_PSM, psm,
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
-				BT_IO_OPT_CENTRAL, master,
+				BT_IO_OPT_CENTRAL, central,
 				BT_IO_OPT_MODE, mode,
 				BT_IO_OPT_INVALID);
 	if (!io) {
@@ -1636,20 +1636,20 @@ static GIOChannel *avctp_server_socket(const bdaddr_t *src, gboolean master,
 	return io;
 }
 
-int avctp_register(struct btd_adapter *adapter, gboolean master)
+int avctp_register(struct btd_adapter *adapter, gboolean central)
 {
 	struct avctp_server *server;
 	const bdaddr_t *src = btd_adapter_get_address(adapter);
 
 	server = g_new0(struct avctp_server, 1);
 
-	server->control_io = avctp_server_socket(src, master, BT_IO_MODE_BASIC,
+	server->control_io = avctp_server_socket(src, central, BT_IO_MODE_BASIC,
 							AVCTP_CONTROL_PSM);
 	if (!server->control_io) {
 		g_free(server);
 		return -1;
 	}
-	server->browsing_io = avctp_server_socket(src, master, BT_IO_MODE_ERTM,
+	server->browsing_io = avctp_server_socket(src, central, BT_IO_MODE_ERTM,
 							AVCTP_BROWSING_PSM);
 	if (!server->browsing_io) {
 		if (server->control_io) {
diff --git a/profiles/audio/avctp.h b/profiles/audio/avctp.h
index 23e3732cde..ca5ff9126d 100644
--- a/profiles/audio/avctp.h
+++ b/profiles/audio/avctp.h
@@ -145,7 +145,7 @@ unsigned int avctp_add_state_cb(struct btd_device *dev, avctp_state_cb cb,
 							void *user_data);
 gboolean avctp_remove_state_cb(unsigned int id);
 
-int avctp_register(struct btd_adapter *adapter, gboolean master);
+int avctp_register(struct btd_adapter *adapter, gboolean central);
 void avctp_unregister(struct btd_adapter *adapter);
 
 struct avctp *avctp_connect(struct btd_device *device);
diff --git a/profiles/health/mcap.c b/profiles/health/mcap.c
index be13af37a0..2274fd2bd2 100644
--- a/profiles/health/mcap.c
+++ b/profiles/health/mcap.c
@@ -52,15 +52,15 @@
 struct mcap_csp {
 	uint64_t	base_tmstamp;	/* CSP base timestamp */
 	struct timespec	base_time;	/* CSP base time when timestamp set */
-	guint		local_caps;	/* CSP-Master: have got remote caps */
-	guint		remote_caps;	/* CSP-Slave: remote master got caps */
-	guint		rem_req_acc;	/* CSP-Slave: accuracy required by master */
-	guint		ind_expected;	/* CSP-Master: indication expected */
-	uint8_t		csp_req;	/* CSP-Master: Request control flag */
-	guint		ind_timer;	/* CSP-Slave: indication timer */
-	guint		set_timer;	/* CSP-Slave: delayed set timer */
-	void		*set_data;	/* CSP-Slave: delayed set data */
-	void		*csp_priv_data;	/* CSP-Master: In-flight request data */
+	guint		local_caps;	/* CSP-Central: have got remote caps */
+	guint		remote_caps;	/* CSP-Peripheral: remote central got caps */
+	guint		rem_req_acc;	/* CSP-Peripheral: accuracy required by central */
+	guint		ind_expected;	/* CSP-Central: indication expected */
+	uint8_t		csp_req;	/* CSP-Central: Request control flag */
+	guint		ind_timer;	/* CSP-Peripheral: indication timer */
+	guint		set_timer;	/* CSP-Peripheral: delayed set timer */
+	void		*set_data;	/* CSP-Peripheral: delayed set data */
+	void		*csp_priv_data;	/* CSP-Central: In-flight request data */
 };
 
 struct mcap_sync_cap_cbdata {
@@ -3139,7 +3139,7 @@ void mcap_sync_set_req(struct mcap_mcl *mcl, uint8_t update, uint32_t btclock,
 		g_set_error(err,
 			MCAP_CSP_ERROR,
 			MCAP_ERROR_RESOURCE_UNAVAILABLE,
-			"Did not get CSP caps from slave yet");
+			"Did not get CSP caps from peripheral yet");
 		return;
 	}
 
diff --git a/profiles/health/mcap.h b/profiles/health/mcap.h
index 5a94c8b63b..00f3fa8510 100644
--- a/profiles/health/mcap.h
+++ b/profiles/health/mcap.h
@@ -270,7 +270,7 @@ struct mcap_instance {
 	mcap_mcl_event_cb	mcl_reconnected_cb;	/* Old MCL has been reconnected */
 	mcap_mcl_event_cb	mcl_disconnected_cb;	/* MCL disconnected */
 	mcap_mcl_event_cb	mcl_uncached_cb;	/* MCL has been removed from MCAP cache */
-	mcap_info_ind_event_cb	mcl_sync_infoind_cb;	/* (CSP Master) Received info indication */
+	mcap_info_ind_event_cb	mcl_sync_infoind_cb;	/* (CSP Central) Received info indication */
 	gpointer		user_data;		/* Data to be provided in callbacks */
 	int			ref;			/* Reference counter */
 
-- 
2.33.0.259.gc128427fd7-goog

