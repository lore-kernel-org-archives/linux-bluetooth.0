Return-Path: <SRS0=qc6f=CZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAE2C433E2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 23:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BAF622208
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Sep 2020 23:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UK37IqGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgIPX3a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Sep 2020 19:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgIPX33 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Sep 2020 19:29:29 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AC6C06174A
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 16:29:29 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id b17so255777pji.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2020 16:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jJtM6SWc5ZprJqMDDK5XKhZigjMAkpVWMtpZC0dehHA=;
        b=UK37IqGVbuC4KpqXMsFpnuuRHM4BtO9YmaDyAzwwVzLpG7H+o8gb+uis7gcg3jqZS5
         tVAVSOejG4y/MVUDLBM0DR/FKJ4EWoOcQi+ZgVdVoPyDBow76x8nNwskzGyEYUAYWf2s
         /4QdHAzQ6CiOtz6vP7Bv2glbZOfR8lOOTIILw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jJtM6SWc5ZprJqMDDK5XKhZigjMAkpVWMtpZC0dehHA=;
        b=ev7NGPugx85R0uWYKh5Sd6qa2qtMg0HdOwuef5ayK9ZwNU2Javf1ggET4Y9sz+O/Me
         8ASAcw+04mLRYoY2RaRC8gqfXEwvvQACyW6Y0ObNmvb74fbaurURtgFEfOK0XkwGyWEl
         IVTYk/YvOZI7okh8oK6dTSU+tnT41oLVVCF104V7g8SWlz71mWvRWoSknpwnIblos+c/
         fdcfEiSNAO226g0OJmiW46DzR6cnyR1yYULA7j3Tx8OK49D/kHNUUjVnpnFDAz3Toe33
         IsGQWRYtdpWi9cHiiaqwEQnBkA/kHVDlYB2x1KaB3PZ2zaM8CVZzS0cnyULpcukROlvh
         zI9Q==
X-Gm-Message-State: AOAM533rB3Dh6rzpsZJ0nTgqNNOrZO2LyQgGUK0vGDIAPD0bniBcRBlq
        C5mZ47XcQZ/NADV4ILoXt/jN3NCb9WfxfQ==
X-Google-Smtp-Source: ABdhPJzO09u3HbXY+6gsdxh8qsbkrvXf8kZLhLYQoWorNow32Lw0OlDHuj6L+y4FuMw6JG7Bk1zXKQ==
X-Received: by 2002:a17:902:d711:b029:d1:c6b5:ae5f with SMTP id w17-20020a170902d711b02900d1c6b5ae5fmr17157192ply.38.1600298968370;
        Wed, 16 Sep 2020 16:29:28 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id d77sm18211112pfd.121.2020.09.16.16.29.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 16:29:27 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH BlueZ] doc/coding-style: Allow spaces after tabs for indenting wrapped lines
Date:   Wed, 16 Sep 2020 16:29:24 -0700
Message-Id: <20200916232924.129991-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The "only tabs for indentation" rule was enforced long ago to align with
Linux kernel net coding style. This is no longer the case today so we
are relaxing the coding style to allow spaces after tabs if it can
increase readability.

---
 doc/coding-style.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/coding-style.txt b/doc/coding-style.txt
index f0bf880e3..6a7415847 100644
--- a/doc/coding-style.txt
+++ b/doc/coding-style.txt
@@ -104,9 +104,16 @@ void btd_adapter_register_pin_cb(struct btd_adapter *adapter,
 void btd_adapter_register_pin_cb(struct btd_adapter *adapter,
 							btd_adapter_pin_cb_t cb)
 
+5)
+void btd_adapter_register_pin_cb(struct btd_adapter *adapter,
+				 btd_adapter_pin_cb_t cb)
+
 The referred style for line wrapping is to indent as far as possible to the
 right without hitting the 80 columns limit.
 
+It is acceptable to add padding with spaces after tabs to increase
+readability, for example to indent function arguments at the parenthesis.
+
 M5: Space when doing type casting
 =================================
 
-- 
2.26.2

