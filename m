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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E72C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 08:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E8D261209
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Sep 2021 08:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236894AbhIOIew (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Sep 2021 04:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236942AbhIOIer (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Sep 2021 04:34:47 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298AEC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 01:33:23 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id d202-20020a3768d3000000b003d30722c98fso2586789qkc.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Sep 2021 01:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XTV5yvBIy7/Nqie5b5cUh0hYAvES/DVSeYmIqN6qvjQ=;
        b=OiOBxQFVGugQrif1PzckoCAnD7afd0QvSmo7VyyBYgaOYto84LfYjC8k2w+C1h/ibS
         t+CFXTwQ7rZS/npp2dMAWNXopHM/RuJleBYYInR1jpTMDotUJmH/xcm1O9j8vheEOfFm
         PnIEIrGXNELsEZPfuIte2IuB3qWAj9rcA6MOIuMdnrBqNNP0NZjcL+eyazvUdxxGh42g
         FLwkEFv5F1ojeANrcRyux1JNXDEsx6n3SeE4YvHoUV13hsMmVYcrzTt84/+KECPEqJ6T
         8pOrmlbT1TCJUvScgcxrp5py/KJtHqNuPmo5M9JuljJ0QnOVN4bQGeuiona6eFcd48wn
         ApKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XTV5yvBIy7/Nqie5b5cUh0hYAvES/DVSeYmIqN6qvjQ=;
        b=35Dnh6Jgp8Irk9HggwGjqj9hZW6P/Ek/y+/rv4PE/T/PfGj9K/FqYld2r+4WMVrIEG
         xL1eCE+nSuMdaWjGdNeVatFYNM5c9alEh4d8oKf1bliM8YH6rc2dLS2GfSjJNqzOBiXH
         ok7LK5OHKRP0gC6M4XIf6npC7kSCnf67GzzHMcFgeJRnbgyXRcBe64tqHV2bUfn0et4t
         BvWxMLHZHvea8PiFg2LEzVnMzgcfsSPMNMCxyGl0YN0enL/LsHMAPg/yc+VZ/qRbJbqb
         U1UGp8SvCAtknq1zUb0o55WTjsE20ExTjXe13SrPKvBTDDEma7+rtYrz2ecY74bjcA+E
         cROw==
X-Gm-Message-State: AOAM530zUQwDnK0CZHjAnccwfc2ywHVRCPtmxMCTzeTI7ZcdH2mfn4Cl
        GV9JOe0Lg+hWfl++DDJpyOQapO5OCsdmNkyuaVS+bPo5jaJ4KDv5ZeYFZ4lpcO5G/gken2hWjJv
        Bkq04RLVU2B0KLWH3QMEMzk9NxyV1WgGIzT5h3Sb7MeOR4RfDg5a6d+f3VkSqtT+n3/iGumlxcg
        Wg
X-Google-Smtp-Source: ABdhPJzncqmlrT6+3O2PmxDt1PaTimfdBcVIsWYZp4HuttXymlYWWDmIded6UCM7pbGYZvHCI/Wa4R0tsaPv
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:3c6b:8053:7e45:276b])
 (user=apusaka job=sendgmr) by 2002:a0c:f047:: with SMTP id
 b7mr9632396qvl.15.1631694802284; Wed, 15 Sep 2021 01:33:22 -0700 (PDT)
Date:   Wed, 15 Sep 2021 16:32:04 +0800
In-Reply-To: <20210915083207.243957-1-apusaka@google.com>
Message-Id: <20210915162843.Bluez.v5.8.I50be9be1265bc743325cfdb9fa0bdbce9671a304@changeid>
Mime-Version: 1.0
References: <20210915083207.243957-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [Bluez PATCH v5 08/13] profiles: Inclusive language changes
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

(no changes since v4)

Changes in v4:
* Fix line over 80 columns

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
index be13af37a0..5161ef77c8 100644
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
+	guint		local_caps;	/* CSP-Cent.: have got remote caps */
+	guint		remote_caps;	/* CSP-Perip: remote central got caps */
+	guint		rem_req_acc;	/* CSP-Perip: accuracy req by central */
+	guint		ind_expected;	/* CSP-Cent.: indication expected */
+	uint8_t		csp_req;	/* CSP-Cent.: Request control flag */
+	guint		ind_timer;	/* CSP-Perip: indication timer */
+	guint		set_timer;	/* CSP-Perip: delayed set timer */
+	void		*set_data;	/* CSP-Perip: delayed set data */
+	void		*csp_priv_data;	/* CSP-Cent.: In-flight request data */
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
2.33.0.464.g1972c5931b-goog

