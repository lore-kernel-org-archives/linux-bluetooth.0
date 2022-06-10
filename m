Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4034C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jun 2022 17:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347189AbiFJRwU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jun 2022 13:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244289AbiFJRwT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jun 2022 13:52:19 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D31639E499
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 10:52:18 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id t1so2078151ybd.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 10:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=EP2CN5s/HOY++c1dpVKxmHeYgyVSXN/8MbQfIfErye8=;
        b=hFNyhbvXEzy6gLrU3R6dS6JJpwgfscNMPFdjNjlKlBKBPwaSzP2hSpElzqUnxQfE4l
         YeKzmd9x5oP2cI97HEyotquV091oF3dKMhja/aRwjNtCFFBokzmGqGojoO2LMJr83JnW
         4G3i085mTY2P3Q3sCJfpeQ78JFsTyjJc3iBvWccTfGu9aLht9iI8Ba1mC8ANXUQ11KIu
         LelwAnLHxflAqu4BOoS1IdFiNZGmlsuIUGK0rpVLDNWsM20xmEW/XOH66hZTJlsut4og
         vTpC8ypqi9RYI2W5GVr+NI7Yl22eh4cg6D9Ojlg6FnrRzCKlQ2OOz/Fa4d5Y80APKioM
         C6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=EP2CN5s/HOY++c1dpVKxmHeYgyVSXN/8MbQfIfErye8=;
        b=G/cqyIZjImCn2uInUBPDOyAqy4eYxVwIE/NU4m8cEpFJAaAyqXRKZOgtDgJDnRzD7n
         8l7jSA1pshnJMZFiznpoBjruA3FR2To+2PWWp3FwZ5qRfPY75FwpSZnOGOjnEC1zYDur
         WQfutpdBxFBOVw0JPZdVc0+SDRj1Id/mMVdwcrP9BwLOymDbwt+iXSAMxLYk4bq+5jlY
         ckeXWjEut7Hv8JP5hMfMdxp2EbHKibbmX20ain9rCs0iVzAXuXta/HhP50dSpGqxG133
         iWWn1gRN7Ph5/bFk/WRSHOY3xlKU9kQT5877wOnpF0aSzDTqXnWAcradE27kO26YDBY4
         pDYg==
X-Gm-Message-State: AOAM531H9lyGUVxuU3tK2QgDeWISMyLm8+uDWmOj+szN/9BeolTRAO3z
        0zUkEkOt5b6KP6kSGZNfxMZpouM5PEkn035VYl3+XsU8
X-Google-Smtp-Source: ABdhPJz5Bpu5Je4XZj4k627ZqrI91ZKOX2nTg+yRkJ1CSFBA2bKXgq6k7WlrhI+gAzSvJN8SkCerFOxdda/zSPJmqRM=
X-Received: by 2002:a25:780b:0:b0:664:3e22:3368 with SMTP id
 t11-20020a25780b000000b006643e223368mr8199689ybc.625.1654883537524; Fri, 10
 Jun 2022 10:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220603223225.20296-1-puffy.taco@gmail.com>
In-Reply-To: <20220603223225.20296-1-puffy.taco@gmail.com>
From:   Mike Brudevold <puffy.taco@gmail.com>
Date:   Fri, 10 Jun 2022 12:52:06 -0500
Message-ID: <CAB7rCThDckbnpLiooSUR9z0J1jdRVe0N2qTBup9m1Ue=OptCgA@mail.gmail.com>
Subject: Re: [PATCH 0/3] LE OOB pairing support
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

More testing below.

On Fri, Jun 3, 2022 at 5:32 PM Michael Brudevold <puffy.taco@gmail.com> wrote:
>
> From: Michael Brudevold <michael.brudevold@veranexsolutions.com>
>
> This patch series implements userspace support for LE OOB pairing. It was
> tested against an nRF52 dev kit with Nordic's NFC pairing example. Support is
> only for reading a tag; generating and sending back OOB information was not
> implemented.

Further testing indicates that the OOB pairing data was not being used
(beyond BD addr).  I tried corrupting the relevant fields and it still
successfully paired.  The bluetooth capture in Wireshark shows an SMP
Pairing Request going out with the OOB data flags set to zero (OOB
auth not present).  This is a 5.13 kernel from Ubuntu 20.04, so I'll
check that it isn't a kernel version issue, but a coworker tested on
an Ubuntu 22.04 instance and had a similar high level experience.  I'm
still digging into where/how the OOB flag gets set for this request.

>
> Overall, LE EIR data is not dissimilar to BREDR, but the OOB blob starts off
> slightly differently necessitating a different code path before reaching the
> EIR parser.
>
> Michael Brudevold (3):
>   eir: parse data types for LE OOB pairing
>   Accept LE formatted EIR data with neard plugin
>   neard: Update D-Bus path and interface
>
>  plugins/neard.c | 64 +++++++++++++++++++++++++++++++++++++++++++------
>  src/adapter.c   |  3 ++-
>  src/adapter.h   |  2 +-
>  src/eir.c       | 21 ++++++++++++++++
>  src/eir.h       |  4 ++++
>  5 files changed, 85 insertions(+), 9 deletions(-)
>
> --
> 2.25.1
>
