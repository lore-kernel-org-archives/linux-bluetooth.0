Return-Path: <SRS0=BM5K=DF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74047C2D0A8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Sep 2020 07:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AB4E22207
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Sep 2020 07:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hk4D0RUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgI1Ho3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Sep 2020 03:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgI1Ho3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Sep 2020 03:44:29 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D121C0613CE
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2020 00:44:29 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id w2so122994qvr.19
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2020 00:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=pgfqKV7LBIlMPkXRvO7yuz6KtuOYAmkcHX6f4TfAnHs=;
        b=Hk4D0RUaPdXO2ts4zSScGXqOR8pm+y/vljrW8RfhxU1sIL9whX4TTi+JsmKezveE9m
         xaR77OeIdMGq6hQsFtjoPKwZLHgo8YY4OJ4uXZ6YtP6GUfwqjQEx0iwcFrbgPLNhJ4fT
         ULf4tl2jsJyquRGdTP1WTnduaaPNqh+ishUmER53SsnR9cS6qL+oMqr90XyO5W8x7gZ/
         U9DLxCHYKC8Z4uWnthOdEySgZBEZQskgzwTsBqdTM7GxQpGudsQz851dAhBtAROYyLy+
         U4I+9bVcsUFczOyPnC0IceAs6qIijqdlU9SRfD973ta7zKBARe0QcjXUkitOPw1VhHS6
         fR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pgfqKV7LBIlMPkXRvO7yuz6KtuOYAmkcHX6f4TfAnHs=;
        b=U4vybdK02TvZrZII1gTdxUTIf0xgsLQ8PrzAkimFRSsi0NcHo6uLT0cS5eGlYkgyP9
         QOIjywv3jNvllfzpahebIo2esXqUv58diC/I12VipUBA7suWFcbQg1Kkds5fRq8atNo1
         kmx/SrDzqFdQaOPJLnICtxg7UP9oGPe2fVCsMSDmwv2JL39785llGH7x4of1/7qa2X5g
         Wld+SBByGkrRG6TrMKfqfb9KW2VU/kUvRyO1SQrcbFK+UGettkwTxY50MBT6CPWeDnqJ
         XErd0GhWK2oyTDk6oLaLRJpNcdC71TDp3metAUdJnJvpRLpyBZoIg68GcP9jBw6/dugZ
         S2Kg==
X-Gm-Message-State: AOAM532em+ock6dFOkWmNM1gha8UeLin6xvPmmuq+/3C8T0q2EG40lxk
        iRxqeY93JjU0U6/noYtTjKLzH+wAZCEU7+XEnuVlezG1M9LeQ52F4K3URCCaeatkIuVpibeh0Yk
        en++4rkcfKqYZIds8ActLvnDBJojd16nY+JfNI9tj/Vqsf2jtqa12huNZYgqICOdpPToCScMpao
        0REyPzWMtnp3c=
X-Google-Smtp-Source: ABdhPJyrFBWmJTq3CVdj7w1+wcqwkrHlWPlXs+UAXUI+UAMorOeqI8oVsa8ow5DkBx+5mL6Lv904qqDL0WNyiZlGbw==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a0c:9cc6:: with SMTP id
 j6mr10605757qvf.60.1601279068224; Mon, 28 Sep 2020 00:44:28 -0700 (PDT)
Date:   Mon, 28 Sep 2020 15:44:03 +0800
In-Reply-To: <20200928154344.BlueZ.v4.1.I1f083629d41c747a33a3937fbc199ea37dccde12@changeid>
Message-Id: <20200928154344.BlueZ.v4.3.I7d35bfa961d5f9998833b0b015e02b81f804f9fe@changeid>
Mime-Version: 1.0
References: <20200928154344.BlueZ.v4.1.I1f083629d41c747a33a3937fbc199ea37dccde12@changeid>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [BlueZ PATCH v4 3/3] doc: Add definition of advmon related parameters
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, mmandlik@chromium.org, mcchou@chromium.org,
        alainm@chromium.org, Howard Chung <howardchung@google.com>
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
2.28.0.681.g6f77f65b4e-goog

