Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E19AC2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 07:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3532E2076E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Nov 2020 07:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wq4vEVAX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgKLHEe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Nov 2020 02:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgKLHEd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Nov 2020 02:04:33 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F90C0613D1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 23:04:33 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id w6so3673260pfu.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2020 23:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6KwB5wprQiur/WxMPQsHteI1wbH0MA8gM8qoRzcjyT0=;
        b=Wq4vEVAX0K22aSMWAXiBd6OsY/+vbu+VALOA27gkeD9a/H7+oHqo75p5zhr1tyscLu
         IqYIIh/0Y42Wd+heThRSkzxe0q78qFKCSSVJQ3/K5v8t9PRdaxGhq5PSfrNxPeEhoQ2U
         SKb13+1rJAULfVae5IGK6YwfweleP9FDm9oOnIqBtr51LWGGsOnM/atiEdx5f2ionKGc
         hx22Vjt8e9nYg4XCj8hTthDjLn5mLup68IaQqpzy0m3h0mz0/rpgh4C+r65CTSZmDW3p
         YeXnLy5Jk8AbIa+sAbkmXwlLqwsCoY9MkPBRYaGX8sh1gMZo2B/hvBHAZZtwEiBeu4ht
         fc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6KwB5wprQiur/WxMPQsHteI1wbH0MA8gM8qoRzcjyT0=;
        b=eCv4vYXffa/2JzCe+ZAo7zlOG619e1yedtGYjDqlzuIAVZdHnIQKH7F2heX2cq1bbV
         uOeOmtSvtnZwhwUebQppl033g8se9CkguE7wEJEiAlxb/JEqFQHITwrNQ+2vT++/3CkA
         uUkwRQbAjJJsnY1Oh2/RpE7sJZnXjaA3YRtUWslnxiee1rIr+zHqAdMCrpCwTDcVYR/Q
         17mlODxkbk8z3dzLIIfx/DgZNc/bTZgZ1uOgzz7RGQAIOSvbanVzVJT8uNvfaO5MHx+q
         BYMqAPxEwM1+G0BZbWptGX3OKWvZJLfhz4cgWQlkRhenCyoTwuA6NpZ9IZt+Y6mVK3x4
         50lQ==
X-Gm-Message-State: AOAM533G53SPd2AjiIl50tvinDzkg1lsVRPjXVQquZtxEGkOEldSvEAH
        Dtg+zvHuAHsZIuubqi0Msqbhi0fWLVM=
X-Google-Smtp-Source: ABdhPJz29OcIkbep2jI8qVVByBJMuQu3Pi4BzHizQRBvvVbXAzxhM6yryVw43hcT0n+iBaDHPueQJw==
X-Received: by 2002:a62:7781:0:b029:18b:5c31:5c27 with SMTP id s123-20020a6277810000b029018b5c315c27mr26589617pfc.70.1605164672770;
        Wed, 11 Nov 2020 23:04:32 -0800 (PST)
Received: from localhost ([122.181.216.76])
        by smtp.gmail.com with ESMTPSA id a28sm5107874pfk.50.2020.11.11.23.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 23:04:32 -0800 (PST)
From:   Sanchayan Maity <maitysanchayan@gmail.com>
X-Google-Original-From: Sanchayan Maity <sanchayan@asymptotic.io>
To:     linux-bluetooth@vger.kernel.org, arun@asymptotic.io
Cc:     maitysanchayan@gmail.com, Sanchayan Maity <sanchayan@asymptotic.io>
Subject: [PATCH 0/1] test: simple-endpoint: Add support for LDAC
Date:   Thu, 12 Nov 2020 12:34:25 +0530
Message-Id: <20201112070426.21050-1-sanchayan@asymptotic.io>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds support for LDAC to the simple endpoint script.

It has been tested with the LDAC plugins in gstreamer which recently got
merged and can be found in the two merge requests below.
https://gitlab.freedesktop.org/gstreamer/gst-plugins-bad/-/merge_requests/1621
https://gitlab.freedesktop.org/gstreamer/gst-plugins-good/-/merge_requests/757

For testing this with upstream, gst-build would be required.
https://gitlab.freedesktop.org/gstreamer/gst-build

Sanchayan Maity (1):
  test: simple-endpoint: Add support for LDAC

 test/simple-endpoint | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

--
2.29.2

