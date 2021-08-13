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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4094EC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29DB560F46
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240506AbhHMMW7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240503AbhHMMW6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:22:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EB9C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:22:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b9-20020a5b07890000b0290558245b7eabso9058690ybq.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=s4NQHarVSL9TDDTgGJmUAljPsi3SbtnYbQw3OEUODtI=;
        b=ifZYxTkcp6wbrI5O1br7tRYdsLBzwoygkO7HGs3ZyW6NZGCGydNrQmzCf0eE5Semri
         moeJXWcXseGFi1ZeWy4MxmoiTezGnndBYQN85xGsAzN7VTlShG9C4pLUS7htoPQk132N
         eW3HWo+cMFJq6Y/nNNVcsqqBXnArI/G2JoQ9MpbQX3tC5Mc7s/vJ1MhxglOt/duQ3tot
         yknIbnc2a0vCqwBXvKmFSwZX2QeF5VDPuqMPw7/0SK6oaCIbaSrIUIXyV00WAPbiG/15
         CMb4xocd6kE83c7hHXuB2zz3oEdAC0l/4SGh8d7QVNHbO7BU/679694XKsnEQFupDHVi
         p2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s4NQHarVSL9TDDTgGJmUAljPsi3SbtnYbQw3OEUODtI=;
        b=brnoIH+fB3vCcdqhykKWbXhAmR6m4ZAqdbEaeuzQjxb14UbbjmfIPIGOrYoImX2jgQ
         yvNs/BDiz6Dh0OsqLZBY0AumZePqaE2e+j7j/YGwnDFC82WaWfJ549bKCdnSIx51LAIo
         JsrZS/iRZ3KWiBUNQIbi7XGXQAD1aVL/aVHtXfS1/AEijzy8zldSiO/+yVlRjIDohSuJ
         RJ5TS2QCHi6h0tlnJsjOUKqiZUDC0fD1uwRuN12Ntbs+nsLIIHvjXI7ZVvc6kXx4vY+5
         VZoIL/utOpnOGkk1IlofKTNTB76+yjtWYIzMMZ4R1wqYNAHD1d8pTL0z8KiQGavpt9EC
         vjmw==
X-Gm-Message-State: AOAM53152WL723orUMnKcfNVOqZ+ZMQqMF1ixSjy0mzvCE9dXwYC9XYV
        HkF4nhD2z2JKwQnUZyFopGmXPPJDO32mCc+6xUIDe79fBO9Y+18OAjcS11lOk12RzdwpmdDNQDI
        0miZ7CT5CN18s8keSIpQWztt/6sB+EuUbK6jciCrG7QgT+0ATG2fLuD7p+oBJq0zJYoAQQ/pNjM
        Vr
X-Google-Smtp-Source: ABdhPJywLm8ihgYOVZ9FxssIota9Pdqu3/h1ifUKNbDrNzr1/SQh7eNiDDbNSl3VcfcjyB5ASfGClj+Am2Rx
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a25:4042:: with SMTP id
 n63mr2540262yba.254.1628857351232; Fri, 13 Aug 2021 05:22:31 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:33 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.48.Ib2581950ac06fb7c6f8843d2c341f79ae0a112fc@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 48/62] profiles/health: Inclusive language changes
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

"central" and "peripheral" are the preferred terms, as reflected in
the BT core spec 5.3.
---

 profiles/health/mcap.c | 20 ++++++++++----------
 profiles/health/mcap.h |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

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
2.33.0.rc1.237.g0d66db33f3-goog

