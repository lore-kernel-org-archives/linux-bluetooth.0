Return-Path: <SRS0=SAxJ=4M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846BBC38BF9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Feb 2020 21:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5470020CC7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Feb 2020 21:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDBIosUz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgBXVzo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:55:44 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:38408 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbgBXVzn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Feb 2020 16:55:43 -0500
Received: by mail-ot1-f49.google.com with SMTP id z9so10173799oth.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2020 13:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XvLFP8y+jCq32sXzWEJETvhKdUi7HlmOpGs4d4aKb1Y=;
        b=mDBIosUzKgxYJ7NoQM+IHg4LCf2opgeS6NdaC063pAfbgYT401sUYpP7/SICPkjx60
         wxlJ+U1Ku1XFs3eLlX0dDSofxFeSqOfpzXLt/GhleyGXVXdfMvBcgCnVOaon11bxNpSC
         kMYyFk8eWd1icBnowdzq9cO0cPNaaJYR47GXP/hW5fokwVhDQfnMkAVyebS/ruUZEukQ
         4W1rWxg9/78zXGdqeLdvJhaDjGHMiyTPwOpQmj+Lz29r33ilGh0p6O0HQL7JljCk7FcW
         UQ1gbRTYIUXCBvq2G+nd7Gt4LJf6vyfF0I1hdtyDXlf7Fizu18VMe6pEpxSsU9Ir6t10
         tPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XvLFP8y+jCq32sXzWEJETvhKdUi7HlmOpGs4d4aKb1Y=;
        b=em5+oK+aZ+cVMI2LJJNRfKDjuge7SIvah8cFduNAVkPneexFv7WyyDBCkpsaLWFCSB
         0Pgq7OCRINVFzJUIiHZS2qRS6nDdy91LOnTikZnXgFPmVCYyUdJMMNujzjcgPyI/Mkiv
         DZ35F+AB5PdtAyAW6VPc+LG82XEf6t+W9Lev5ba1LX7G9VqeXRWGPGOww0tehW98omnR
         CbGWxboJ8tyt4uJfIXMjL2u13io14ebbPFisuJm7J81zGxL0Mg3Fi/qEutr3YW4qMSEb
         dcieCWSWSmg9BdYGm774pmPrkqWtCCSCBylQqqDzrzdJoHOOp8Y3drMpMQI/jFQTEi/n
         cEkQ==
X-Gm-Message-State: APjAAAXutWBubmoD2dsXauX2YpXRUhmzYHBv9lueGUNb8NLrtY92GkyL
        JKl/jCZnvfRSr5VNwxjKVHKqU2i2ldbwLu2LCxA=
X-Google-Smtp-Source: APXvYqx9qAEKLoeFfCskwg1/Hbjd8lpcOv5qc9VovfSbkpdlJR/mTTKtch235uCfd3WISV1hrxRaDagrA6WKagmnwus=
X-Received: by 2002:a9d:58cb:: with SMTP id s11mr43083839oth.55.1582581342330;
 Mon, 24 Feb 2020 13:55:42 -0800 (PST)
MIME-Version: 1.0
References: <CAD3n0hm61cRPK3=Scf02y3Y3aMJ66eCC5nwFh40Y9kfLBWk-tw@mail.gmail.com>
 <CAAu3APZ4WqFd=61eUfbC8biTbygWW4k2Te3De38B2+maYoBePw@mail.gmail.com>
 <CAD3n0hnJkmXGjiei0-u=GBh0xoGb4N7tkuBh_uSvsuT7bAhXLA@mail.gmail.com> <CAAu3APbWouHkguPG3_FQmxPY=6q6rzmr_CbOqY2_0a0RzC++XQ@mail.gmail.com>
In-Reply-To: <CAAu3APbWouHkguPG3_FQmxPY=6q6rzmr_CbOqY2_0a0RzC++XQ@mail.gmail.com>
From:   chris baker <chrisbkr2020@gmail.com>
Date:   Mon, 24 Feb 2020 13:55:32 -0800
Message-ID: <CAD3n0hnWk0rULy+RJNTAujqY5vtTR=zvoB8233rtLSGc3R-9Pw@mail.gmail.com>
Subject: Re: Bluez blotoothctl scan vs hcitool scan
To:     Barry Byford <31baz66@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, Feb 24, 2020 at 9:13 AM Barry Byford <31baz66@gmail.com> wrote:
>
> If the DBus API is not cutting it for you then using the MGMT API
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/mgmt-api.txt
> is what has been recommended in the past:
> https://www.spinics.net/lists/linux-bluetooth/msg68959.html
>
> On Mon, 24 Feb 2020 at 16:37, chris baker <chrisbkr2020@gmail.com> wrote:
> >
> > On Mon, Feb 24, 2020 at 6:08 AM Barry Byford <31baz66@gmail.com> wrote:
> > >
> > > Hi Chris,
> > >
> > > On Mon, 24 Feb 2020 at 10:12, chris baker <chrisbkr2020@gmail.com> wrote:
> > > >
> > >
> > > > So my question is, is there a way to get those missing advertisements
> > > > through the dbus api, possibly some additional setting somewhere?
> > >
> > > Duplicates are disabled by default with the DBus API. This can be
> > > controlled with the DuplicateData setting:
> > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/adapter-api.txt#n107
> > >
> > > Regards,
> > > Barry
> >
> >
> > My apologies, I guess I wasn't clear (long post) but, I turned
> > duplicate data on when using the bluetoothctl command (via the "scan"
> > submenu) and also used the flag, "hcitool lescan --duplicates", when
> > running the hcitool command. So both scans should have included any
> > duplicates (unless I've misunderstood something). Additionally, none
> > of the missing packets were duplicates (again, unless I'm
> > misunderstanding what "duplicates" means). each packet had a unique
> > sequence numbers as well as the button data field toggling.

Great, thank you. I'll look into the MGMT api in the coming days. That
said, is it a problem to use both api's (MGMT/DBus) concurrently from
the same app? My application supports both connected BLE sensors as
well as BLE beacon type sensors. If possible I can handle them in two
different threads, but the DBus thread for connected sensors would
still occasionally need to scan for new sensors (using the DBus
discovery call) and would still need to get characteristic changed
callbacks as well.

Out of curiosity though, is the behavior I'm seeing normal? Or is the
sensor doing something improper possibly? Seeing as the packets aren't
duplicates why would they be filtered (or are they just not being
received to begin with for some reason)? The 11 second interval seems
kind of strange. Anyway, thanks again for the help! Chris
