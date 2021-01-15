Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D619C433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Jan 2021 19:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1D6123A58
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Jan 2021 19:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733159AbhAOT5Q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Jan 2021 14:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbhAOT5P (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Jan 2021 14:57:15 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145CDC061757
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Jan 2021 11:56:35 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id v19so2495998ooj.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Jan 2021 11:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=owFLotVNuMaogh9faUg74MewN0Se3wOF0nDvmklFUzo=;
        b=k5XQwo68/izz/LwYjAegDr91PDu/Vrxpa1umVgflzQF2tlKcXxB5axTDq7Fmnh0YOG
         rZAlDPF+870kxk5H6wMlaS5DyN/otL2U48jyGIt7tQ9dQLumOq1MVhz4JRWrhXyui6ER
         6VRJfbhMS+hg3RbuzmqM5bzGKRke4VK4Zf9RsoBRBR5f8VcxPS0ybtnxmgMw9f5C1Cov
         0qF6RBpI6Tur99mh7qPGCCP7/yR0a5qPhVUz0Fe2ZZ2FkTmstDwkcwoCCVAJRn8ar2Ia
         t9iwmxw6FtRDx+yVMlevs3OKwfgHlSS0CwLFMM4Y+4g4yjlSjMmplkOyBOiaO4DPWOsj
         TQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=owFLotVNuMaogh9faUg74MewN0Se3wOF0nDvmklFUzo=;
        b=AXR79a4eBpnfZ2UtpcUizp63AVchtNjeYEhYgVJzuwEs6mXq5ZA0z46ouz31wmhC6v
         CK3AMNwFN4250R+drf2cf4Y64crb/pDUITxICOlU4ucd70BQ9IITGBpjwiUn1BhNBayS
         eg+ZyAmTk9T1/OG5isoL0zVsCmSkdRj7M731mSORUPZ5E5ucTkGyK1746mfZz9/x83q7
         KbUy+zvUiwZj23ZC6fwkoqc8di+gvgDy/+StcufjUe60DQFMcDBYD6XFgzGKGmbNdtjm
         IIBKterC+8cE6jmWyBczwRaFM6fIOVp/3JR6dsbHXD7r02tecfbLOeXip6WuxEsCcAQK
         Qz3Q==
X-Gm-Message-State: AOAM532HA9oBFvOwEsxzNgEryxby/jT8rcTvah4DNNRghH22bcBpiV76
        eYA8v0kdfIdaTAPI7yZGlNyn50LOw+fXpR/2+czJ6llL
X-Google-Smtp-Source: ABdhPJyF52wYTHIpYOyeiofDY1X/gwQqHzE/KZFLOJ9c8tms94NWwsvhH1Tz33IKPf11SJhduXp8V5N2PzGf4Io0BsQ=
X-Received: by 2002:a05:6820:22c:: with SMTP id j12mr9626203oob.65.1610740594174;
 Fri, 15 Jan 2021 11:56:34 -0800 (PST)
MIME-Version: 1.0
References: <20210115115036.3973761-1-apusaka@google.com>
In-Reply-To: <20210115115036.3973761-1-apusaka@google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 15 Jan 2021 11:55:57 -0800
Message-ID: <CABBYNZJUEh5mdTVFpdw6hVNrc-ALWK4JFEZOQFtm1z=r=P7Yig@mail.gmail.com>
Subject: Re: [Bluez PATCH v4 0/6] Support advertising monitor add pattern with
 RSSI opcode
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Archie,

On Fri, Jan 15, 2021 at 3:51 AM Archie Pusaka <apusaka@google.com> wrote:
>
> From: Archie Pusaka <apusaka@chromium.org>
>
> Hi linux-bluetooth,
>
> This series of patches adds a new MGMT command for adding a monitor
> with RSSI parameter. Changes are focused on passing parameters to
> the kernel via btmgmt and bluetoothctl.
>
> PTAL and thanks for your feedback!
> Archie
>
> Changes in v4:
> * split the add-or-pattern-rssi command
> * update doc
>
> Changes in v3:
> * split the struct RSSIThresholdsAndTimers
>
> Changes in v2:
> * Remove trailing period and fix order of mgmt parameter
>
> Archie Pusaka (6):
>   lib/mgmt: Adding Add Adv Patterns Monitor RSSI opcode
>   doc/advmon-api: Introduce sampling period property
>   src/adv_monitor: add monitor with rssi support for mgmt
>   btmgmt: advmon add rssi support
>   bluetoothctl: advmon rssi support for mgmt
>   monitor: Decode add advmon with RSSI parameter
>
>  client/adv_monitor.c              | 258 +++++++++++++++++++----------
>  client/adv_monitor.h              |  11 +-
>  client/main.c                     |  72 ++++----
>  doc/advertisement-monitor-api.txt |  78 ++++++---
>  lib/mgmt.h                        |  15 ++
>  monitor/packet.c                  |  43 ++++-
>  src/adv_monitor.c                 | 267 +++++++++++++++++++-----------
>  tools/btmgmt.c                    | 160 +++++++++++++++---
>  8 files changed, 625 insertions(+), 279 deletions(-)
>
> --
> 2.30.0.296.g2bfb1c46d8-goog

Applied, thanks.

-- 
Luiz Augusto von Dentz
