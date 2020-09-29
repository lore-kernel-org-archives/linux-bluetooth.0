Return-Path: <SRS0=RRj3=DG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D78C4727F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Sep 2020 10:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16AD521734
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Sep 2020 10:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SIOlNjM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgI2K4S (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Sep 2020 06:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727403AbgI2K4S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Sep 2020 06:56:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E096C0613D0
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2020 03:56:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p187so4391740ybg.14
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2020 03:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=tUfIoHY+I51t089OtH1cmnT10uqLtMWw27M2pZamjGQ=;
        b=SIOlNjM0Tzc9GwmmuW+tWZInkxM14bE/TgDoLxJRnaky/W6dyiaGZOScwIgV8AS4Qj
         ukCMVLgx37FNaAuB8F7RlA28blL7tX9eqZ2VV9t6FHIHQQCHhvaAHHrjm3dHfTxbY171
         087XNl2YSF4VqCSFsCRonFyYlPrHmrfaSW4X9CVYLUxaAwWjMOhRNMPOqRTZncF2uEkd
         wRuWXhSXLpZJfiltckZs9WymxyIrZgq4AKnaH1Za8IyI+VouaJEM7QmJ8hhrH1YAdtgU
         rHo07IhsnKTqB0RjH+FhLZ/+EUJ98FQGPY4hkVhzcgsh1Re5X/F6qC5w3XomCSK21wD+
         eLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tUfIoHY+I51t089OtH1cmnT10uqLtMWw27M2pZamjGQ=;
        b=Jty6BiXKXXB9hWB63InyZoGJWTDex36IXe8Ec7Ogi+U8wAuMQljqR904iOu9eJ+vdw
         R8oTKZ/owwHC2gNKXRPbiNLbKeaU4O2OEd3h5mqSkL1XbqoYJQnzcYZUq1IOnR0DMyAI
         cAscJWmnqeqNy+NQB+sGJGh87qHjYLXWrjzStkWzr2ad01j+iPC7u0JyX57rVFOo9hT/
         +SIjKZuTx9rYv4lNxeZMi1lM4CN1zhxyGmEnsBct3C59P3KKWmipkdZ+WZauo9sfgWMG
         2dQabW6FQCPWe4k/C2yZKgUna/nYhxl637aPTAKG+xuN4kfO58snL6CbHRmbYOLsKn9p
         DAHA==
X-Gm-Message-State: AOAM531G9W2Am91FnE5FNjIbmDvw56G1aW2HNcB5bTXWusZ8E3SbvyDB
        upee1TIrcL6m63AX5wFJj4vhPmzKHIZNbJDPwThxDCxOGcy9IjXQrnbMUyNZmYI+8gVfNgu/j2r
        DTRQmZ4eTh5927LGjpdlLjK5MwTFTPDafLwKSUdnTJUwoCuSddYF/ER+H59NvJxcCb8LBLS4Gfd
        Jl7Pl1Yq/66pg=
X-Google-Smtp-Source: ABdhPJynLa++z8js+mdAZvFF8iVQyg5jofp+Nz0kCpaa4/P412VEcVcmPh+AZE+cfwIUbDTDLd/Y/koFDNAsWm3Thw==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a25:5c43:: with SMTP id
 q64mr5692337ybb.498.1601376977518; Tue, 29 Sep 2020 03:56:17 -0700 (PDT)
Date:   Tue, 29 Sep 2020 18:56:04 +0800
In-Reply-To: <20200929185522.BlueZ.v5.1.I1f083629d41c747a33a3937fbc199ea37dccde12@changeid>
Message-Id: <20200929185522.BlueZ.v5.3.I7d35bfa961d5f9998833b0b015e02b81f804f9fe@changeid>
Mime-Version: 1.0
References: <20200929185522.BlueZ.v5.1.I1f083629d41c747a33a3937fbc199ea37dccde12@changeid>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [BlueZ PATCH v5 3/3] doc: Add definition of advmon related parameters
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     mmandlik@chromium.org, luiz.dentz@gmail.com, alainm@chromium.org,
        mcchou@chromium.org, Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds definition of the newly added parameters for advertisment
monitor interleave scan.
---

(no changes since v1)

 doc/mgmt-api.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index e7a7138249d1..45211dba7fbd 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3279,6 +3279,9 @@ Read Default System Configuration Command
 		0x0019	LE Connection Latency
 		0x001a	LE Connection Supervision Timeout
 		0x001b	LE Autoconnect Timeout
+		0x001d  Advertisement Monitor Allowlist scan duration
+		0x001e  Advertisement Monitor No filter scan duration
+		0x001f  Enable Advertisement Monitor Interleave Scan
 
 	This command can be used at any time and will return a list of
 	supported default parameters as well as their current value.
-- 
2.28.0.709.gb0816b6eb0-goog

