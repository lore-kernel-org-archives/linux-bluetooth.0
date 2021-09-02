Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6C5C432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 04:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61CC760EE6
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 04:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhIBEJD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 00:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhIBEJD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 00:09:03 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773A3C061760
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Sep 2021 21:08:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f8-20020a2585480000b02905937897e3daso932084ybn.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Sep 2021 21:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=A93ZFvRGofCq3B/sQF0zyV0NETmID4wfdDKEfDQ+hTk=;
        b=lRofl41TAdGHri4fMFo7JsgTXcjm5hLGoIVf8LX3vZjmQU5++Kk84LJAp5iiJB769Q
         mHbuSdjM7SqKu7zVIQBtfHt82g95h7OLUv8Vw4/3BiUTv2Uq9RT7kbNOz20M7S2nkDd5
         SvPZrpjBmelqwS6hdh0hLW5vNTGuSyMtUuNPwcrCvZdeKk4YT0Rt6BFywDuHZNrwPOl3
         6mNx2pTAETtY0a8FbrjgEZtb8o4/xyL9ik274V3QgxC0rppWm4y5bFZtmStiwXAMUqAp
         zbM4AFc/bZ1672HhNfBthwpWv/PnDlgc1WTSSZMt5D4MlqQNpaFiOTIZsDB2aDvzq2kz
         FRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=A93ZFvRGofCq3B/sQF0zyV0NETmID4wfdDKEfDQ+hTk=;
        b=CZwtVDuDiSo0ns2z5aq3zUG8THIRarUEROxVHDhrkAfAoCH1hyG9ast6d/1Tb1uFxt
         o+ofiN8PfB17vwfrUBEEYDSsqgNBAsfF9GC9GgF9ULkSeYiKkzzmPqQXtkcxXNXm/52H
         yco03BSrUNlOLNq0tRgrD69qKM43JKitjH02JobJ7UlB9GwHLmMVImDWEKKbwDRqhyT5
         vursK98/gHpmnVULAB2DrpvBY3eqTLlFgF+VEUCGnn45jQOPwJE7r1EMVrz/aZBSyUwI
         RkE9NktH2wP7KXStvydzRA3DzsywMf/6P4HuD4OKtq9kxyslDxLEyVrekWZOy98Z+45y
         Bp2Q==
X-Gm-Message-State: AOAM5322CP1pV7xFVdWK0TbdppCPADFKYuOo5eMV+9UDdfClgP4QHEO9
        UkTZzMmvl9DV0PSZ3EqMDB9gPpO8QZekENpbm3mt5k7h9EcfH3E02zI4nN4LJ7LnD5Wna+gRyZK
        P59w7F3EHRyvCiixwVeHbtwDHUT7f1oQZqS26SsOPEm0DhdmAxMYRaiZa50eJyJCCGMpT1mBWZU
        VS
X-Google-Smtp-Source: ABdhPJyeKKLEzv8lE9liTTm+qvVnuOlFIEnRfQLxgan/6kHg7kHpmc5reHC1ASRWE21h4AxOayofJO9FrG26
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:5249:e81c:3ce6:f50c])
 (user=apusaka job=sendgmr) by 2002:a25:c647:: with SMTP id
 k68mr1671517ybf.349.1630555684704; Wed, 01 Sep 2021 21:08:04 -0700 (PDT)
Date:   Thu,  2 Sep 2021 12:07:05 +0800
In-Reply-To: <20210902040711.665952-1-apusaka@google.com>
Message-Id: <20210902120509.Bluez.v2.7.I50be9be1265bc743325cfdb9fa0bdbce9671a304@changeid>
Mime-Version: 1.0
References: <20210902040711.665952-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [Bluez PATCH v2 07/13] profiles: Inclusive language changes
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
index ab05a2bc24..48f825c4ff 100644
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

