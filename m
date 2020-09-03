Return-Path: <SRS0=fWrd=CM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FFDC433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Sep 2020 03:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E903120716
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Sep 2020 03:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="g1v0faM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgICDu6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Sep 2020 23:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgICDu6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Sep 2020 23:50:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA09C061244
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2020 20:50:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p138so1519187yba.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Sep 2020 20:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=/FSgf2EPD/YJcQe1a7i0YAGBtiAsMfHL3A3+v0vuBC0=;
        b=g1v0faM52Nxm06t0CDxXxgCPDG8S8sAmtCSDegQTQdaB1+peSBjIvCRoMd7aQNEG5O
         BIohBF933VKvuezgZeMLE9/RCAOb9IIWpBwi8IObl2mrtHu7eYE+hwri3BWFJOgB6awY
         5RQJS7iCgyC7fRiPeiU8Zwr0hTPXARmO7k7M+F3mzOiHk/WlyuyGqZbwAuZ+WugtPjOh
         BUdJELaMeb4nlZMm1NM1Gt5ldrtsDDG0gsCfWAYHTNXiu7kprLMU9sQSg1LZYrX9oSvP
         WXrrvopWxDjwSgAIWG5d1JHwAv+0IBVIQ//mla7Z+87F5wSMLfAvmPolPh9sR0Q5jJGm
         4phg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=/FSgf2EPD/YJcQe1a7i0YAGBtiAsMfHL3A3+v0vuBC0=;
        b=XFjcV2b55tKaG3yA4lHrJttGVF5j1bjCphElQhj2QaQSybDHRDI1UX1yKdvBqg9n0H
         3jbTglkyjTOXfjA0x2sIsC6xqc7DdwUaY7qrbgCMJZjOtYNLclHxCVFWJkwBYXZS6+u5
         BJ9QpMKjfYIy4CgRECwOkugBd2umyhy5jjA8ip3Q/CO4ZUfvjVP7syO054dcIAZWU5LX
         sB6BCSfl5GmSKPCUHCgORcgNAhm2YiNO7fp5RyCeAuqfJl0z2E303tEa1CR2bhWv+PDb
         fOgAhRO3yaG65qX3D80z82f2DdoOyDZkTUxPC0REsxdsmhSeGcPFuqcV8UeI+NH65g+B
         mMiA==
X-Gm-Message-State: AOAM530/kOeaeLJZq0OWY2jnPzrUi7jwm8sTOf2hf6/s0Z5aLwgzH3LC
        GcDc83Trffbl5OtYF9XKXhJJQcBjkqiMmPJiuoXtsrelPIGLMLoNU76WE1gpvWq1/piuf3KXuwY
        9VJtPcl0e4vEI5LXG1MGgB+74GAgPh0vYlMqWEwk9XWM+wxVf+d83BgULoQaOPlrht4ojuqanI8
        1H
X-Google-Smtp-Source: ABdhPJybbsUs5HOk1fDx9wuuqgx3GoxG4SbzI9tSPChs1O+twa+CMiswd+DiIC9y8QFlrMDEmclcOX/6tx6u
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a25:c004:: with SMTP id
 c4mr1395166ybf.475.1599105056918; Wed, 02 Sep 2020 20:50:56 -0700 (PDT)
Date:   Thu,  3 Sep 2020 11:50:37 +0800
Message-Id: <20200903115020.Bluez.v3.1.I6767a68b7e7b6cfb6d8046ee8b66c8e7d008d3e6@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [Bluez PATCH v3 1/2] doc/media-api: Add Press/Hold/Release methods
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

(no changes since v2)

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

