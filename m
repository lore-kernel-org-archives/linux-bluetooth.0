Return-Path: <SRS0=zBEa=4N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE648C35DEA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Feb 2020 01:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F7721D7E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Feb 2020 01:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RemeadNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgBYBwL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Feb 2020 20:52:11 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:41895 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbgBYBwL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Feb 2020 20:52:11 -0500
Received: by mail-ot1-f54.google.com with SMTP id r27so10630689otc.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2020 17:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=akHXeA5lRpMCrGZMdqNpV5NO1b2BK1U09bjTlxx7Lt0=;
        b=RemeadNK2KFNcZ16xxrBJ/4FV/ahudGcc2MTYcPZWH6ZEs6JElzO5lXIGM+yRXuH9g
         hoMVSP3s/N5pRilGpLiSv5uNB5iSdMjZF5WEorXopv4J89gSXAYMGRsvnaPSxh59FuWL
         qQfvcp4qdxinbRQ0yvS9H5Kz0K7C3cwIFSCpufQDC2rMWLBFYxFX6Uu4WcQmz2QmWzAi
         0PojPuh3n9980BB8Yn3wLmLsg2J2gX9fZVUE7Ac0P0KQPnNiqIBAn8nqTI3jx+m+B7sO
         J05KSnNSELAJcDU18pap3P5rymqV/n0wVvIUA1XXWLw9wa0q+DC8CRsyC0RcLnOky/SF
         9h1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=akHXeA5lRpMCrGZMdqNpV5NO1b2BK1U09bjTlxx7Lt0=;
        b=ZcPQEmgFut9hkbGZPp3WIugNw2RaIF8frBfdmlC6bmbqI72tI/oYbWdW5m8egieGFH
         We4I+lIbJ7l0GhK42Ibt3DquF2MYIV0NOqZXHDacTEEWGQszzsVs6lh2Q6dnZ4+0oWAq
         CTu63z4yH8Vq8lX2mtx5c24vD46EnqduZoJL1nsbnTWdjtYyqdg9FNZhPLk4teEfnvnK
         Vwe8/yqMj1gcfaWwnr16Kgrr7XOMW14yvQtT1xg2VbYjVWGiI4fNKZIOgQazw9/nI/oj
         wcA1PeqTu3qWnpSiBH/qv4Zv5d3vmmGGEOFa3JDrv4bcdtEPNGKLgCEs/JficFGZUule
         RJnQ==
X-Gm-Message-State: APjAAAVwMqGa6nOuBLxlg8mj4Mdnyrs1tKOKti2fBxBSuuGtI4pDSpIt
        1taC/U4SOvC0m1UiqM5G/JpBE6mEInPk0ln+1mM=
X-Google-Smtp-Source: APXvYqwap5QGCFMZJig1tP81KBohbQVWRzSXDIJe+ol0+Lg5XAjzmzX5hOo0qBzJc/oJhuvtaRYWUx9NxarbAU1HQiI=
X-Received: by 2002:a9d:6d10:: with SMTP id o16mr44071488otp.28.1582595530050;
 Mon, 24 Feb 2020 17:52:10 -0800 (PST)
MIME-Version: 1.0
References: <CAD3n0hm61cRPK3=Scf02y3Y3aMJ66eCC5nwFh40Y9kfLBWk-tw@mail.gmail.com>
 <CAAu3APZ4WqFd=61eUfbC8biTbygWW4k2Te3De38B2+maYoBePw@mail.gmail.com>
 <CAD3n0hnJkmXGjiei0-u=GBh0xoGb4N7tkuBh_uSvsuT7bAhXLA@mail.gmail.com>
 <CAAu3APbWouHkguPG3_FQmxPY=6q6rzmr_CbOqY2_0a0RzC++XQ@mail.gmail.com>
 <CAD3n0hnWk0rULy+RJNTAujqY5vtTR=zvoB8233rtLSGc3R-9Pw@mail.gmail.com>
 <CABBYNZJn3-xBUQ8h_akoKAzm4AT1COjAFLhMhg6V=VnjOZVTvQ@mail.gmail.com> <CAD3n0h=A9UhCd+Aux=GLdQKWPJUma4=eYfV7xUb0tJHgnxUA0A@mail.gmail.com>
In-Reply-To: <CAD3n0h=A9UhCd+Aux=GLdQKWPJUma4=eYfV7xUb0tJHgnxUA0A@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 24 Feb 2020 17:51:58 -0800
Message-ID: <CABBYNZJC3xwQ0jx7k6_t0uhzpJyOsdO1n3LYqW1gC_TSnU-SHg@mail.gmail.com>
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

On Mon, Feb 24, 2020 at 5:36 PM chris baker <chrisbkr2020@gmail.com> wrote:
>
> On Mon, Feb 24, 2020 at 4:33 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Chris,
> >
> > On Mon, Feb 24, 2020 at 1:56 PM chris baker <chrisbkr2020@gmail.com> wrote:
> > >
> > > On Mon, Feb 24, 2020 at 9:13 AM Barry Byford <31baz66@gmail.com> wrote:
> > > >
> > > > If the DBus API is not cutting it for you then using the MGMT API
> > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/mgmt-api.txt
> > > > is what has been recommended in the past:
> > > > https://www.spinics.net/lists/linux-bluetooth/msg68959.html
> > > >
> > > > On Mon, 24 Feb 2020 at 16:37, chris baker <chrisbkr2020@gmail.com> wrote:
> > > > >
> > > > > On Mon, Feb 24, 2020 at 6:08 AM Barry Byford <31baz66@gmail.com> wrote:
> > > > > >
> > > > > > Hi Chris,
> > > > > >
> > > > > > On Mon, 24 Feb 2020 at 10:12, chris baker <chrisbkr2020@gmail.com> wrote:
> > > > > > >
> > > > > >
> > > > > > > So my question is, is there a way to get those missing advertisements
> > > > > > > through the dbus api, possibly some additional setting somewhere?
> > > > > >
> > > > > > Duplicates are disabled by default with the DBus API. This can be
> > > > > > controlled with the DuplicateData setting:
> > > > > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/adapter-api.txt#n107
> > > > > >
> > > > > > Regards,
> > > > > > Barry
> > > > >
> > > > >
> > > > > My apologies, I guess I wasn't clear (long post) but, I turned
> > > > > duplicate data on when using the bluetoothctl command (via the "scan"
> > > > > submenu) and also used the flag, "hcitool lescan --duplicates", when
> > > > > running the hcitool command. So both scans should have included any
> > > > > duplicates (unless I've misunderstood something). Additionally, none
> > > > > of the missing packets were duplicates (again, unless I'm
> > > > > misunderstanding what "duplicates" means). each packet had a unique
> > > > > sequence numbers as well as the button data field toggling.
> > >
> > > Great, thank you. I'll look into the MGMT api in the coming days. That
> > > said, is it a problem to use both api's (MGMT/DBus) concurrently from
> > > the same app? My application supports both connected BLE sensors as
> > > well as BLE beacon type sensors. If possible I can handle them in two
> > > different threads, but the DBus thread for connected sensors would
> > > still occasionally need to scan for new sensors (using the DBus
> > > discovery call) and would still need to get characteristic changed
> > > callbacks as well.
> >
> > Have a look at the other thread subject: Adding support for
> > DuplicateData into the kernel
> >
> > We are discussing adding support to disable duplicate via MGMT since
> > DuplicateData does not currently remove it but we might want to change
> > that, or at least have some alternative API to do that. We could for
> > example have a socket that enables a more direct access to the
> > advertisments, that way protocol that work over advertisement would
> > have a way to do this, in fact this might be better for things like
> > mesh so it can coexist with bluetoothd.
> >
> > > Out of curiosity though, is the behavior I'm seeing normal? Or is the
> > > sensor doing something improper possibly? Seeing as the packets aren't
> > > duplicates why would they be filtered (or are they just not being
> > > received to begin with for some reason)? The 11 second interval seems
> > > kind of strange. Anyway, thanks again for the help! Chris
> >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
>
> Thanks Luiz, I don't want to sound dense, and I really appreciate you
> and Barry's help, but these aren't duplicate packets (unless, again,
> I'm misunderstanding the term). Each packet payload is completely
> unique. I'll have a look at the other thread for sure, but I'm really
> just trying to understand if the missing packets I identified in the
> trace should be there (in the DBus/bluetoothctl trace) or if there's a
> reason they were excluded. Again, they weren't duplicates and I'm
> reasonably sure I had the duplicate data flags set correctly each
> time. Also, whatever is going on is not transient, I can duplicate it
> with the senor I'm testing every time (both in my app or via
> bluetoothctl). More important for sure is to find a work-around
> (hopefully the MGMT api Barry pointed me to) but still just curious
> why these packets are getting dropped/filtered... Anyway, thanks again
> to you both!

Afaik the HCI duplicate filter flag is not very granular, so the
controller may be dropping any reports found during a sort period
since it might not have enough memory to store everything, include
actual data in the advertisement, to compare with.

-- 
Luiz Augusto von Dentz
