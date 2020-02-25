Return-Path: <SRS0=zBEa=4N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12C2C35DEE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Feb 2020 00:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 876A121927
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Feb 2020 00:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beIUoD1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgBYAdL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Feb 2020 19:33:11 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:35859 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbgBYAdK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Feb 2020 19:33:10 -0500
Received: by mail-oi1-f176.google.com with SMTP id c16so10872254oic.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2020 16:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Res0HXUOda8HRoAlvYopl15Xx32Uf448+bwwDxLqWJ8=;
        b=beIUoD1iaf4uNmi+ZdQqTXFtTGOHXajE/zKFI0MK7t8kOx+NoUMQjzIiHlQTaft8Av
         Q/hmoPN0dwZpeRk2RtBIlF9/IOp1ZxGQlDr7CtTzIJ/y4iNE7gFlII0kRxWJgUcY186f
         dgXzhiao1tECQDXqnZJymxi3ZRymJOPSRrwIyxoqnfsJjviMSWvEwqWS413D6Rovgggh
         TqfExlaFvLit39+zOqKegQEXXQ5KAiWCc6MefIQLJ+OF1c5TxOrkzHdKAcS4H/S0jfPR
         xteehljDmgd4Gw5bxQbCnNYIxpsmOJVI4xjwdOrYtJeF7v8/eGgJAIj8wcX6d8fAdvXd
         UQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Res0HXUOda8HRoAlvYopl15Xx32Uf448+bwwDxLqWJ8=;
        b=NbxcEkAc1tBc6vL5nTQ1MjVY8gODUcxtORztGTr6pkLh73KK1s9OT7Z7rQzJbEIGoH
         xZiWU//dQTWY7tUbei9uzrz8SfHcjDjTDSSaDqz9Wk+z0RcKwdekXJJtQ9VB2WdCr272
         fRf4ZZIyc7jUk4+5Q/nCfJRlqXfBVIvIYcdJNcO5h+H4HehvlV7ZTHNcXkSrPHduN9NJ
         pvx4hoCc6+TdKQ2MSzotnDNmfBdBV2FtrDClXfOV4fv8JX1WQhtQLp/BKkeX1WQFim1j
         vY381CLjWDbiN6Mk+26bTqp/Te9rofHF9IsByt1xMGagijfsqLjHxiT6tgcB7hgMzJ5m
         57SQ==
X-Gm-Message-State: APjAAAWoFz5ELqmCheXqzRBPPNtdJWjfoQkS/Hcm2CafLr4iB5uLmExH
        6p3Gp/AnZIM73GwlteJVUKYTdVBr49h7yrrJoq0=
X-Google-Smtp-Source: APXvYqzcznhh1uJ/NVSm7VZ5dLzVAWCvzkfM6JTah9ZFUf6ZCS/IATgbcRNX+ulohZqsvjVWqHgU4XAodjtEbFoeFIk=
X-Received: by 2002:a05:6808:98e:: with SMTP id a14mr1344924oic.8.1582590789846;
 Mon, 24 Feb 2020 16:33:09 -0800 (PST)
MIME-Version: 1.0
References: <CAD3n0hm61cRPK3=Scf02y3Y3aMJ66eCC5nwFh40Y9kfLBWk-tw@mail.gmail.com>
 <CAAu3APZ4WqFd=61eUfbC8biTbygWW4k2Te3De38B2+maYoBePw@mail.gmail.com>
 <CAD3n0hnJkmXGjiei0-u=GBh0xoGb4N7tkuBh_uSvsuT7bAhXLA@mail.gmail.com>
 <CAAu3APbWouHkguPG3_FQmxPY=6q6rzmr_CbOqY2_0a0RzC++XQ@mail.gmail.com> <CAD3n0hnWk0rULy+RJNTAujqY5vtTR=zvoB8233rtLSGc3R-9Pw@mail.gmail.com>
In-Reply-To: <CAD3n0hnWk0rULy+RJNTAujqY5vtTR=zvoB8233rtLSGc3R-9Pw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 24 Feb 2020 16:32:58 -0800
Message-ID: <CABBYNZJn3-xBUQ8h_akoKAzm4AT1COjAFLhMhg6V=VnjOZVTvQ@mail.gmail.com>
Subject: Re: Bluez blotoothctl scan vs hcitool scan
To:     chris baker <chrisbkr2020@gmail.com>
Cc:     Barry Byford <31baz66@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Chris,

On Mon, Feb 24, 2020 at 1:56 PM chris baker <chrisbkr2020@gmail.com> wrote:
>
> On Mon, Feb 24, 2020 at 9:13 AM Barry Byford <31baz66@gmail.com> wrote:
> >
> > If the DBus API is not cutting it for you then using the MGMT API
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/mgmt-api.txt
> > is what has been recommended in the past:
> > https://www.spinics.net/lists/linux-bluetooth/msg68959.html
> >
> > On Mon, 24 Feb 2020 at 16:37, chris baker <chrisbkr2020@gmail.com> wrote:
> > >
> > > On Mon, Feb 24, 2020 at 6:08 AM Barry Byford <31baz66@gmail.com> wrote:
> > > >
> > > > Hi Chris,
> > > >
> > > > On Mon, 24 Feb 2020 at 10:12, chris baker <chrisbkr2020@gmail.com> wrote:
> > > > >
> > > >
> > > > > So my question is, is there a way to get those missing advertisements
> > > > > through the dbus api, possibly some additional setting somewhere?
> > > >
> > > > Duplicates are disabled by default with the DBus API. This can be
> > > > controlled with the DuplicateData setting:
> > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/adapter-api.txt#n107
> > > >
> > > > Regards,
> > > > Barry
> > >
> > >
> > > My apologies, I guess I wasn't clear (long post) but, I turned
> > > duplicate data on when using the bluetoothctl command (via the "scan"
> > > submenu) and also used the flag, "hcitool lescan --duplicates", when
> > > running the hcitool command. So both scans should have included any
> > > duplicates (unless I've misunderstood something). Additionally, none
> > > of the missing packets were duplicates (again, unless I'm
> > > misunderstanding what "duplicates" means). each packet had a unique
> > > sequence numbers as well as the button data field toggling.
>
> Great, thank you. I'll look into the MGMT api in the coming days. That
> said, is it a problem to use both api's (MGMT/DBus) concurrently from
> the same app? My application supports both connected BLE sensors as
> well as BLE beacon type sensors. If possible I can handle them in two
> different threads, but the DBus thread for connected sensors would
> still occasionally need to scan for new sensors (using the DBus
> discovery call) and would still need to get characteristic changed
> callbacks as well.

Have a look at the other thread subject: Adding support for
DuplicateData into the kernel

We are discussing adding support to disable duplicate via MGMT since
DuplicateData does not currently remove it but we might want to change
that, or at least have some alternative API to do that. We could for
example have a socket that enables a more direct access to the
advertisments, that way protocol that work over advertisement would
have a way to do this, in fact this might be better for things like
mesh so it can coexist with bluetoothd.

> Out of curiosity though, is the behavior I'm seeing normal? Or is the
> sensor doing something improper possibly? Seeing as the packets aren't
> duplicates why would they be filtered (or are they just not being
> received to begin with for some reason)? The 11 second interval seems
> kind of strange. Anyway, thanks again for the help! Chris



--
Luiz Augusto von Dentz
