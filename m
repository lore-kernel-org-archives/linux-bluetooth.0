Return-Path: <SRS0=QCqs=4V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF0CC3F2CE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Mar 2020 23:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FF22084E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Mar 2020 23:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvO8MEUr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388371AbgCDXCZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Mar 2020 18:02:25 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:41806 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387931AbgCDXCZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Mar 2020 18:02:25 -0500
Received: by mail-oi1-f169.google.com with SMTP id i1so3920265oie.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Mar 2020 15:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H+sBP9+yWP2sbq7Zi/k4IQQIQXenXjxeuqmGuRXtyDU=;
        b=mvO8MEUrSTL/jIJPrzFAVjuYWHJ8auSin8NDlMGp3qai8SVQgTaIjOtAaQ/DGGZ+qB
         d9q3P2zZ/nsLenRam8mMBrzHbpm9C5FCfRN7yEKwLsQkJY1qiOf0AqKBbwNVDAh/1AIf
         bgVtDAPqZgwpUgK3HNlXi32bXgF7gvyqqRy4XCZW61+2SaMT5vK6gSdlv8bnGbH/1gQC
         JgFz+hg09mSJs8PS0COCJDnmTJTtUvi8MOTfMksxVTuo/dXuCG3F4i797b3DEgQaFHB0
         DzDZjSMJslSpJxX9wQLKyxNaJ0Esb3JlbLKRBtLmUHTLoOMRO8VZuyDgnRjqZvxRnTCO
         68pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H+sBP9+yWP2sbq7Zi/k4IQQIQXenXjxeuqmGuRXtyDU=;
        b=S4hhCxzDKZ+65sb1wWSyLarU7Kvce+Gzq1ztB/ViJBdXbGE4SVX+r8AYIzRq2BwDuz
         /YJTzNDD1teM5e3Q/SGaqm8oOCbfsYzFmDQPfrOoWH1ewylB7+u02ILHbVdhgoFDaK5a
         0X+KSN25LfrssH4RJc2L9NxYazKVqdSJQfnwE9q8WRb2U9ETT3hYqFiU2M7DiNgvmASF
         YOrp5riYegQdjiwcsfOogxYEnvsqvvcRjZ/iuC25rqWL+BqSJ2jrHdLAagNH4Nca4pBT
         v0104dDV9uxKgzg82WgHEs6Fh/lMru8F3BkytwJ/e6z/NjE+VE9lTG44AbhqKchY2WcL
         c0ww==
X-Gm-Message-State: ANhLgQ3QEWf4OyZehmIhJLw8jvFsBttsYmFFt/h0vDldu/9Yoyq/Yrem
        r/Jwum8jnB8NriU/hePy+Xkw8jqbsIsKvh5qTvkN5JjT
X-Google-Smtp-Source: ADFU+vtqOMD6o/eFiL9LEtToHug4FgrorWOW3iMQ2FS5LguN8uGRWcDEKQ7aXTq8LZVfBFDZ03R6q68cvge5YXMBZjM=
X-Received: by 2002:a54:4801:: with SMTP id j1mr3540939oij.108.1583362944013;
 Wed, 04 Mar 2020 15:02:24 -0800 (PST)
MIME-Version: 1.0
References: <CAO1O6sdGJeAKTHBVyDSUa7-Hp_ULYmfOHJEbb6=-B6xuPHvffQ@mail.gmail.com>
 <CABBYNZKtxPmTUn2fw9-dy1V9M_Pb996O6VmHkg4NrAr-=t+-4A@mail.gmail.com>
 <CAO1O6sdke-2J=eYHS2SoG83v-hMJDBu-gasufJYDyHK+1R+w5g@mail.gmail.com>
 <CH2PR14MB3658759A2701FB52A2D6573BE6E50@CH2PR14MB3658.namprd14.prod.outlook.com>
 <CAO1O6sfwcEswTkuuntoBM_S5oFkQv7mCP1GH8Z0S0vgHk2Bp5A@mail.gmail.com>
 <CABBYNZ+2v5Z05dSD+TrzioGYVWugZJGpBnq+2M=MO-smuVgXbA@mail.gmail.com>
 <CAO1O6sfWgqnduM8_UuO_1W8KjnEvoetbk6bcaA_ATFUaXLtB0w@mail.gmail.com>
 <CABBYNZJrWBVEY7ZUxqFShfPne2b=6ahDOd3srJF6NAJwQLWQpQ@mail.gmail.com> <CAO1O6sfp2ikCkAY3UGvxe-+F-L-nG=cdTqjzthrv4ddrADxWnw@mail.gmail.com>
In-Reply-To: <CAO1O6sfp2ikCkAY3UGvxe-+F-L-nG=cdTqjzthrv4ddrADxWnw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 4 Mar 2020 15:02:12 -0800
Message-ID: <CABBYNZ+K+bPSaQLP=+etjhu=xPOszV6MApzyMe0-YhrTL0e-Jg@mail.gmail.com>
Subject: Re: Get negotiated ATT MTU?
To:     Emil Lenngren <emil.lenngren@gmail.com>
Cc:     Jamie Mccrae <Jamie.Mccrae@lairdconnect.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Emil,

On Wed, Mar 4, 2020 at 2:41 PM Emil Lenngren <emil.lenngren@gmail.com> wrote:
>
> Hi Luiz,
>
> Den ons 4 mars 2020 kl 20:44 skrev Luiz Augusto von Dentz
> <luiz.dentz@gmail.com>:
> > > > It completely transparent to D-Bus, so if we do expose the MTU it
> > > > should probably be reporting the biggest MTU of all connected channel,
> > >
> > > Is there ever any reason for one application to have more than one ATT
> > > bearer? I thought the idea of EATT was to allow one ATT bearer per
> > > application.
> >
> > EATT is meant to allow multiple outstanding requests, it probably
> > would not escale if we would add an API to have a bearer per
> > application so we just use the extra bearers as a pool.
>
> I just read the 5.2 overview and 5.2 specification again and I see now
> that the overview suggests that a pool of bearers should be used, as
> you mentioned. So yes in that case the maximum ATT_MTU of the bearers
> seems reasonable to report (if they for some reason would differ). But
> by having a pool like this, I hope implementations will make sure that
> multiple Write Without Response values or notifications from the same
> application are sent on a single bearer, to avoid reorderings.

Commands don't need a response so in theory one should just use the
unenhanced bearer or the first one EATT bearer regardless, in the
current implementation I just pick the first bearer that allow sending
all the data in one shot given that the MTU can be different.

-- 
Luiz Augusto von Dentz
