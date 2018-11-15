Return-Path: <SRS0=SE7D=N2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEB6C43441
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Nov 2018 12:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33220223DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Nov 2018 12:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxXi/O9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33220223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732953AbeKOXEX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Nov 2018 18:04:23 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36523 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbeKOXEW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Nov 2018 18:04:22 -0500
Received: by mail-pf1-f195.google.com with SMTP id b85so2846581pfc.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Nov 2018 04:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kNynFSUf02syNWM2lfhVeF0/sZrOUBz7MljXFpKVH1Y=;
        b=pxXi/O9n54xbN4Yj8wajBC8ClX0uGwGDxH5SzrAcStBg9iaUtb+Asm4pv/afmVBmCo
         xS6H2wigkAYEnK63pIm62kNOM/orud20dBwbTBJNYbNT5YdZA0HGFwlM1Gk1b/tp0QdI
         nOCOTuvKB1Lf1F+Faf6uTBTyPCs1fkmivFKcbagyNmZuL7a6bcSh2qHJFFxzrB7Hi4uf
         tUQSYJAnLRas6GKSygCOkvkEYlartoBGDJrcMtdtHLPp5vLYsuAztXC+Qk274VSLx7Xp
         d5mc1bPL3BKt0Putpv3pYSP5+ySf4PG/T8PWgD9XQ/HEP+7MzdL4JXdSHNEVikuuT+w1
         BZEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kNynFSUf02syNWM2lfhVeF0/sZrOUBz7MljXFpKVH1Y=;
        b=po0Jm6y3Uuigs7My2DrjjuYu+SjAS8Vz3Elv7KEawG2PvhxfP7omObJsuTEFcIEn8a
         cIbaF6cSMvntLH3nnU/Owol8wC2jGqXu0eM/1+kAfwN5C0ZjM7ycDm0csj/T3pYear6l
         85QwFyNGMh7dkCxUg5fIGwr8BjEQ7b0KIAYzTuikwjKuCFGJcxBjaO8UH3gfZopWCwdI
         yRaBDEmf5yYJUGrgwv9vHSj4cTRqT6s1zuwXeRwygoVWYp6MC+0b+CSLZP7WHOEpUyEj
         8V3Mp1Sqys5aDexDLL7q7xuO7dsNbqDu5tuBA0+Cp5k0mhV7ImI7vdBJukf3QYO5GoQ2
         X4Ig==
X-Gm-Message-State: AGRZ1gKZMnbxKIzXG42EVzreoPJmOc3/QGJEKfoOgNGA9V/omVfMlrPr
        CByfwW+RpQs2LCCEfIEvUAR2W1AN/k1TLgxvv3+I1A==
X-Google-Smtp-Source: AJdET5efD2wguShjDL+0+C0e8fwD1GVexydWuYQsem/rQbcBiCKIpLWYl5ciWFH/CxEMMq7hCpyl5eayvk1EK55REc0=
X-Received: by 2002:a62:1e42:: with SMTP id e63-v6mr6294105pfe.149.1542286597640;
 Thu, 15 Nov 2018 04:56:37 -0800 (PST)
MIME-Version: 1.0
References: <20181115083817.20986-1-gbenhaim@augury.com> <CABBYNZJ_TEM18yfO6O4HFdyo7sm-cE8iL4Y8_DEa1e6xZ7a=Bg@mail.gmail.com>
 <CAHotPr-jS457EKX=7dvcwA6eB12zr7d2dZG5Prjh6+fMdAT=+Q@mail.gmail.com>
 <9007400A-D10D-4906-AB75-6D6395AF98FD@holtmann.org> <CAHotPr9Jb3Prqk_tkaeTRsJk0VgsGWbj8tsSdEp-Q9mb9Dt=-A@mail.gmail.com>
 <CAHotPr-BO=RE6HZYWsC1+MT9oSZ58Xf-8XLz53BJq0Z6Em9Hsw@mail.gmail.com>
In-Reply-To: <CAHotPr-BO=RE6HZYWsC1+MT9oSZ58Xf-8XLz53BJq0Z6Em9Hsw@mail.gmail.com>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Thu, 15 Nov 2018 13:56:27 +0100
Message-ID: <CAO1O6seRNsBvz_sdZHKZhSYc3wbeZPOf-_0qXEG6PAnom0qcvA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] gatt: Ignore SIGPIPE
To:     gbenhaim@augury.com
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Den tors 15 nov. 2018 kl 12:55 skrev Gal Ben Haim <gbenhaim@augury.com>:
>
> I submitted a different patch -
> https://marc.info/?l=linux-bluetooth&m=154228281730667&w=2
> On Thu, Nov 15, 2018 at 12:20 PM Gal Ben Haim <gbenhaim@augury.com> wrote:
> >
> > I can try to create another patch for it
> >
> > On Thu, Nov 15, 2018 at 12:18 PM Marcel Holtmann <marcel@holtmann.org> wrote:
> > >
> > > Hi Gal,
> > >
> > > > io_send can use poll and check for POLLOUT and POLLRDHUP before
> > > > writing to the pipe
> > >
> > > that should be done anyway since code that writes to a pipe descriptor (or socket for that matter) without checking that it is still valid is broken code.
> > >
> > > Regards
> > >
> > > Marcel
> > >

Even if you first check for writability with poll, you still need to
also ignore the SIGPIPE signal, since the connection could be reset
after the check is made but before the write is executed, I guess. But
the "signal(SIGPIPE, SIG_IGN)" should usually be made once at
application initialization.

/Emil
