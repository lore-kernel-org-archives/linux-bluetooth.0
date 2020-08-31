Return-Path: <SRS0=C8Ye=CJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10496C433E2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Aug 2020 07:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2FB920738
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Aug 2020 07:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="YY77rNik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgHaHhN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Aug 2020 03:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgHaHhK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Aug 2020 03:37:10 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48936C061573
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 00:37:10 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id b1so5387895qto.17
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2020 00:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=s9VJKEkalBronQIXpvXWZsG3O7AMhGMwRvW0lxf7xHg=;
        b=YY77rNik+jivlMpK6E3iCn6fd8mm3J7ul6FMvXFpkbVixMWy1GfcYRC2BT79HX7Gj1
         IUTxVtAh8cXSa8Bn5JDflR5Z5QE3bcpNv7abPIo1j/qplGmpO2KqYaeQ4D8zLAggIhzY
         TIPqEMfvHUUs543pCuOJUvAeXCq1MK95YhwXfxNsiMjoZ2tYkYAwVbclYPbobUDrc/ks
         KcEDljEv3S56uzC5ZDJlgfhUZvhV48qtlrdPbplyJBB+0mOussZRbJaWhsihwmlp3qV2
         pBwTbKaOwa2CeShsB3URMxNoB0Kni2uuEnGH6Llda9Ks2Sdsz8V2gRj8DfT9RY+EB36N
         XCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=s9VJKEkalBronQIXpvXWZsG3O7AMhGMwRvW0lxf7xHg=;
        b=PWt3OgCil01jKIrYrH+0wfnHH213qspkzsuC3R5Shynl84pyPzLCdpq2g/Saig1B5j
         Ssh4UiDhG6HIcLbXnJgUzO7LvdaYmgQYye92O7qX2sOymWqZF33JkiFsYgZvOrw5uW4Q
         Sl/Pa30brsgPxbsACekyXds+VDPdlGwrt+9k11zltPMHjQpSkzSHLQk27rXcr0NSJyzS
         Wuw0D7x7s0IQAPdVhNrwqlHoFZ4rKEXVktsrDgtet8tU34t3aylTq5vo++3Lb4AbABqP
         5zCCRafFxm2IarBVwX//QagQsy0TClnXSJLzG9Bw5rMUO+rpUcFOG6KJY/VpJ9G5WOIO
         ENqA==
X-Gm-Message-State: AOAM5339s390nIO9csW1/MbTem8YgAIu172XrvAtYYoBIJcY0Kx8qJpP
        SMHChbUJqGPa9De79aEt0YV4mOIpSxe2toIHSWNGriu/Gpbt4scLL5HtUnqU5CqrK0+kQaefRs8
        r/YWUNMsi4bmHVddzXDLjsc6MwC7XrXzdFOcn/pEW6QY/AEikUYd/Au8zsPabdp39KspKxB3+az
        lN
X-Google-Smtp-Source: ABdhPJxVCkppEp4J0xA4mmgo0kNNNBAXnIlwOPzPn1OraYghgFX0AIWRLYc+DiGPXnt70yjTHr9k2mo6ntok
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a0c:f2c4:: with SMTP id
 c4mr3830159qvm.118.1598859428244; Mon, 31 Aug 2020 00:37:08 -0700 (PDT)
Date:   Mon, 31 Aug 2020 15:36:32 +0800
Message-Id: <20200831153544.Bluez.v1.1.I6767a68b7e7b6cfb6d8046ee8b66c8e7d008d3e6@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [Bluez PATCH v1 1/2] doc/media-api: Add Press method for MediaPlayer1
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Michael Sun <michaelfsun@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

This allows us to send any passthrough command.

Reviewed-by: Michael Sun <michaelfsun@google.com>
---

 doc/media-api.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index dabc69936..fe7222eef 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -199,6 +199,14 @@ Methods		void Play()
 			Possible Errors: org.bluez.Error.NotSupported
 					 org.bluez.Error.Failed
 
+		void Press(byte avc_key)
+
+			Press a specific key to send as passthrough command.
+
+			Possible Errors: org.bluez.Error.InvalidArguments
+					 org.bluez.Error.NotSupported
+					 org.bluez.Error.Failed
+
 Properties	string Equalizer [readwrite]
 
 			Possible values: "off" or "on"
-- 
2.28.0.402.g5ffc5be6b7-goog

