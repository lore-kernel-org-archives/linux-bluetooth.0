Return-Path: <SRS0=3U9n=EK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9B7C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 07:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B703D22384
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 07:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ImAPgtRi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgKDH2x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Nov 2020 02:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKDH2x (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Nov 2020 02:28:53 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2105C061A4D
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2020 23:28:52 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a184so20762637ybg.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2020 23:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=MvHC64F7MCyUUsOrtg57NOsgameuY0hHXKFdMfRhW2Q=;
        b=ImAPgtRiVrdwFF5Tj2iF8DyRup7BhWjmT5BnH2Y79ARBqfwZFI2750e+UX22Yv/X8/
         Wwyv/iYcxLG5ct0f5fpz1G/EeHi+nu+2NCr5tVGrrF9+PaRR5G7i5qaxtVTJ/gtPuLLl
         wgzgUJQdHs9NroY3S0YcOAy4WJVC2DcHErR9qhDyyL1H6fwuDSoDtVI/PLgmOQRrPkpU
         /O+ySA7QjINLPV16bm4Vp5Na6HXKdfm/rX459DRxb7AhVMNVdpaPQX/FSPwsIgmw78PO
         kFWMAzqeoWVLtHGfWicfiN1slUSduzcLMNEbMyTGiDHYMY8IRD9kiXbas6vN9sxo0R7b
         C/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MvHC64F7MCyUUsOrtg57NOsgameuY0hHXKFdMfRhW2Q=;
        b=MUv/VZh8/DUSd+2W95zHh2QJ1y9St500hViWY223a8vZIis2S3k+U5vIjjt6aQ2RQE
         tLvGWnnLTwt1wwoj7WmrQRWW5piYXAEtQmiPjsaz93KjXbuhwuYMoSSX53DwP91AdYGA
         k1Y/HsRv2ocC7AnIVRiLfIx4674rnTTpOiRedc2GWTHEgxbQCwEGONxwkwtV7nCLDBpN
         e5K5jsPcVnC8Il7LrLmuG3jY+qesMHxi43XAYbiX4yFex+0LRA3Ykn3tChXM5BABqI7C
         /d5CleckBSmdLebZLoL2VxWaRuuHG2VFZn+58BqFQh9IWK+po+SMRZ1w5dD++u2YGkLp
         y1Yg==
X-Gm-Message-State: AOAM531FhFJNUrJV8coIJUo+Q8EaLSRm8n2rkTL1HzKGD7g//hDwz7VT
        wyiwHGfS3xIdCIQzTrxyozV1NJMHtvmNgm3l83eiH6T7hiLE6rwh0K2Q5RMpYnD1j1HI484v5/H
        zK2hQ99aQix9YFbWqkGgDgDNsD+Y8kS09oUWOS5i8eRkfvupvD3KtHyd69fhbj+aTHg4RIvgd//
        LN
X-Google-Smtp-Source: ABdhPJyQzsqiuT1rCKeEeKHCmJgErykx28DG9KtGFln8enVo97sHV+G28uJxxp/AXAjqsfIbtxhWL9qK3uKA
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a25:2bc7:: with SMTP id
 r190mr33610277ybr.497.1604474932023; Tue, 03 Nov 2020 23:28:52 -0800 (PST)
Date:   Wed,  4 Nov 2020 13:35:27 +0800
In-Reply-To: <20201104133318.Bluez.v1.1.Ibb93fb0188187d11151855d2dcc737640b2b81da@changeid>
Message-Id: <20201104133318.Bluez.v1.2.I4c872b9b8fdee53a335db41acbb6e59fe9692cc5@changeid>
Mime-Version: 1.0
References: <20201104133318.Bluez.v1.1.Ibb93fb0188187d11151855d2dcc737640b2b81da@changeid>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [Bluez PATCH v1 2/3] audio: unref session when failed to setup
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

There is a possibility to miss unref-ing when source/sink fails at
setup.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---

 profiles/audio/sink.c   | 5 ++++-
 profiles/audio/source.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index 134d157bc6..d672670e25 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -258,8 +258,11 @@ gboolean sink_setup_stream(struct btd_service *service, struct avdtp *session)
 
 	sink->connect_id = a2dp_discover(sink->session, discovery_complete,
 								sink);
-	if (sink->connect_id == 0)
+	if (sink->connect_id == 0) {
+		avdtp_unref(sink->session);
+		sink->session = NULL;
 		return FALSE;
+	}
 
 	return TRUE;
 }
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index fca85d4cb3..c706c928a7 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -259,8 +259,11 @@ gboolean source_setup_stream(struct btd_service *service,
 
 	source->connect_id = a2dp_discover(source->session, discovery_complete,
 								source);
-	if (source->connect_id == 0)
+	if (source->connect_id == 0) {
+		avdtp_unref(source->session);
+		source->session = NULL;
 		return FALSE;
+	}
 
 	return TRUE;
 }
-- 
2.29.1.341.ge80a0c044ae-goog

