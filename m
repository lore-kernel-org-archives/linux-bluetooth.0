Return-Path: <SRS0=2LFz=ID=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20507C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 23:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA0AC650B5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 23:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbhCEXwl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Mar 2021 18:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhCEXw3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Mar 2021 18:52:29 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4B4C06175F
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Mar 2021 15:52:28 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id l10so4308454ybt.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Mar 2021 15:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=JCTB0flAHIiTjBr3HF9i0mcV0r9v1jIF+xjdrPpa554=;
        b=F93N82ZsdvnQtbsS61zG8vWx9O9iRuTMamFMdS1E++9oy6xINuSmCrri29huTG5zkq
         tF05ohehPyFhlqOtERFRvU6uId05RqPszA1KYbnDMKRvsiMSmAL348ZV5PHEWmk2U6l1
         /fP0nheoDt5gCqJLnMwDBYCbZhXi4vho2Cfoe63SK+dq24HPwetZ/0el1nBoN0dpnPN0
         bdV1Kq2gdwWQgDE9I8q6rIX1D7l1H+RrJMhESVk83fV97J83yRckSKSEVeiSmmBCF5z2
         LhD+vlKq/kZmVpbhIa8t0IN/ydcCS74CmV7uo7NR13qv1IxNoLomjNNZ0Kmh2RVGLNnt
         GEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JCTB0flAHIiTjBr3HF9i0mcV0r9v1jIF+xjdrPpa554=;
        b=Gha1vZbcsaGLVN9SdLUb6RFZdpO6wCqD83yJKMf6tm+wEveB9lqxrCbn4QKyQ5dPSd
         j4WA367GiXh99DWd4XjwMAPQdxgx2ZsxiDp+34f4V113YQco6OzH3Qrtu23JVlisu6X0
         3E91SaapCgI0kslxhuypvZK613J0IUT4kzjtWygHVLtq89jLNoBVI6GFcmx9tsXHFZKj
         zQGCJQUAhA8pT520QExOXkB0pbJsT84a/aenVX66vue4lr+Ikn6405l35mOT3kGJld4g
         lnhxQbROvuTp2yDMCW+2z3xc2G+pSaFGzPZvZmEVdrPEC7St+46J79sZCmn/opCIVIil
         d0Ng==
X-Gm-Message-State: AOAM5323jKMqFslP8rEstuagXmkBRc7hyJaGgfzTqvvu6IcJ7OySUW+o
        99j5a6TGZzKEwcEcUqCiAZIU8zous+FOqAG3MTb70++0ImfSjg9IuYiqkgNNSokHCjKKFR9g5y0
        sKQ5ewJwiQFDydYQ+RycLA2S6LnUlGGw8sbnRfQsmsOTUml6Y1i4yGuEii8va/rbVEtTPFnLu0f
        2o3kSomQ3netpI2VVi
X-Google-Smtp-Source: ABdhPJxQf3TqPID8DT62iE1azdzACdSUa4z39fEx/xl4XGTgT39JZUrj7hnBwTI6pRyAge/XaSeDAZfUvWP7iFeNJxgj
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:94dd:309a:2fcb:13a])
 (user=danielwinkler job=sendgmr) by 2002:a25:a441:: with SMTP id
 f59mr17873902ybi.245.1614988348010; Fri, 05 Mar 2021 15:52:28 -0800 (PST)
Date:   Fri,  5 Mar 2021 15:52:17 -0800
In-Reply-To: <20210305235217.2382976-1-danielwinkler@google.com>
Message-Id: <20210305155113.Bluez.v3.3.Ieb6522963e3f54b0d63dd88ed3ce24a8942ed73e@changeid>
Mime-Version: 1.0
References: <20210305235217.2382976-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [Bluez PATCH v3 3/3] doc/advertising-api: Add adv SupportedFeatures
 to doc
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add supported features to advertising dbus api.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

Changes in v3:
- Rebased onto master

Changes in v2:
- Doc: Expect empty SupportedFeatures if no support available

 doc/advertising-api.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index 541c57004..ba9eacaae 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -235,6 +235,7 @@ Properties	byte ActiveInstances
 					 "2M"
 					 "Coded"
 
+
 		dict SupportedCapabilities [Experimental]
 
 			Enumerates Advertising-related controller capabilities
@@ -257,3 +258,22 @@ Properties	byte ActiveInstances
 				int16 MaxTxPower
 
 					Max advertising tx power (dBm)
+
+
+		array{string} SupportedFeatures [readonly, optional]
+
+			List of supported platform features. If no features
+			are available on the platform, the SupportedFeatures
+			array will be empty.
+
+			Possible values: "CanSetTxPower"
+
+						Indicates whether platform can
+						specify tx power on each
+						advertising instance.
+
+					 "HardwareOffload"
+
+						Indicates whether multiple
+						advertising will be offloaded
+						to the controller.
-- 
2.30.1.766.gb4fecdf3b7-goog

