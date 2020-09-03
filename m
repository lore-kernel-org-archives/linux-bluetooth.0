Return-Path: <SRS0=fWrd=CM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFABCC433E7
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Sep 2020 03:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC30420773
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Sep 2020 03:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="vh5RjQ6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgICDCF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Sep 2020 23:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgICDCE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Sep 2020 23:02:04 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9FDC061244
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2020 20:02:03 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id a14so1212010qtp.15
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Sep 2020 20:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=iPi5IQAuAg6VdmAUQLYPOaBS4AFQMK7BNHv1zt5oaas=;
        b=vh5RjQ6FHmaQNjsY3qBg9GI9ZMrEXyqdcyrlmBuWXVgkEkyl86MTGsJkeYxiWdEVdG
         wAF4d4T29VN0yJ7xzT7zOUXZhoyooFv5kvJCQFEXE9Tm6sZYejy/UwwI3mVWEnuRpYjI
         4fmuduMX6Alucf7vuLtat0zc4KPAqfKBGw2Mf+k5Tm9gOQMLII4GJkgNBcuYzcQrf43o
         7WZX5lDMxxWwc5bUBQAZy4/Nx4UdO5ppQatoCtKEicO7QcuLNnXgWTh8BTf9KysfQhC1
         ZcYExhAgHbj7hTrY1UFoMdnBgsfEqaoZITuDjrEyx/ISdQBAhgl5BVCfN/jbRB9fUDJq
         KBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=iPi5IQAuAg6VdmAUQLYPOaBS4AFQMK7BNHv1zt5oaas=;
        b=p/l9rw52KPNDPFL48sHHN/8FiDIn/VDTR7jd/tLR61sEi+wrJicm9GQYQsloQF0l65
         9Fjj7lP5EtH8Pnzduai8y0dT58qku48kHVqYJv1o6YHkvjDJ/G7TqWi8rpYfwCNyPetS
         1V5vTkpWvMecF+h8BJqBR7QvBUjGFaHbAfd9HYy1/WE2m7SxGn+7igWQiTmTqhUYbKah
         oqpUOxUptz2b0m9J+rNDTu8I+Dt/M04UPO7BW6TOG0JqcWr1hh10lL1yFb7nxd596fzS
         VuPDLrhy73ArUpZBCtMLw3lQn0JCHJOulgPpTGLkbINO+DdtbDtu2R5YUxm2Rys1509w
         D0Rw==
X-Gm-Message-State: AOAM531WoGApl1Av3TdcmIPWzhWCrV8y8ipdSEnMbO3+f7c3j3G+WqPd
        6JQ36/hZDNSY6dHq0+DQgcf0+cbb5IgIZQQrzZTpzWePnFUUzCF04szNOL+4IQyL6HxiSJ15/Px
        LdpW3MV4B04x74yBaUDxnYp2OHU/S2ORoB+zjpg/u/NtDN7LfrjNYrriUgEAWudWZJcDnj3bHGZ
        ER
X-Google-Smtp-Source: ABdhPJzUKm9lxGj82QCW5HMSI2QiaMKZOWj6wCqteYWFLJyULborcs2qu5oduPZodszs1GnpBZCuLQjuJ7YG
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a0c:d803:: with SMTP id
 h3mr1546022qvj.0.1599102122134; Wed, 02 Sep 2020 20:02:02 -0700 (PDT)
Date:   Thu,  3 Sep 2020 11:01:44 +0800
Message-Id: <20200903110031.Bluez.v2.1.I6767a68b7e7b6cfb6d8046ee8b66c8e7d008d3e6@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [Bluez PATCH v2 1/2] doc/media-api: Add Press/Hold/Release methods
 for MediaPlayer1
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Michael Sun <michaelfsun@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

This allows us to send any passthrough command. The button can also
be held for an extended amount of time.

Reviewed-by: Michael Sun <michaelfsun@chromium.org>
---

Changes in v2:
* Add Hold and Release methods

 doc/media-api.txt | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index dabc69936..e98573157 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -199,6 +199,35 @@ Methods		void Play()
 			Possible Errors: org.bluez.Error.NotSupported
 					 org.bluez.Error.Failed
 
+		void Press(byte avc_key)
+
+			Press a specific key to send as passthrough command.
+			The key will be released automatically. Use Hold()
+			instead if the intention is to hold down the key.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.NotSupported
+					 org.bluez.Error.Failed
+
+		void Hold(byte avc_key)
+
+			Press and hold a specific key to send as passthrough
+			command. It is your responsibility to make sure that
+			Release() is called after calling this method. The held
+			key will also be released when any other method in this
+			interface is called.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.NotSupported
+					 org.bluez.Error.Failed
+
+		void Release()
+
+			Release the previously held key invoked using Hold().
+
+			Possible Errors: org.bluez.Error.NotSupported
+					 org.bluez.Error.Failed
+
 Properties	string Equalizer [readwrite]
 
 			Possible values: "off" or "on"
-- 
2.28.0.402.g5ffc5be6b7-goog

