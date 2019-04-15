Return-Path: <SRS0=fr0v=SR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D868AC10F0E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Apr 2019 09:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD89220675
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Apr 2019 09:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfDOJhx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:37:53 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:35315 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbfDOJhw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Apr 2019 05:37:52 -0400
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 5A6A52000D;
        Mon, 15 Apr 2019 09:37:50 +0000 (UTC)
Message-ID: <6339c67c82a7e425a3c3cee415626cf32e080144.camel@hadess.net>
Subject: Re: [PATCH] Fix cups backend location
From:   Bastien Nocera <hadess@hadess.net>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ludwig Nussel <ludwig.nussel@suse.de>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Mon, 15 Apr 2019 11:37:49 +0200
In-Reply-To: <CABBYNZ+4Mgp0h2YusoEVK64a-uTXdarANc+Tm-KKpjR1=9h2cg@mail.gmail.com>
References: <20190412140803.28622-1-ludwig.nussel@suse.de>
         <CABBYNZ+4Mgp0h2YusoEVK64a-uTXdarANc+Tm-KKpjR1=9h2cg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, 2019-04-15 at 10:52 +0300, Luiz Augusto von Dentz wrote:
> Hi Bastien,
> 
> On Fri, Apr 12, 2019 at 5:11 PM Ludwig Nussel <ludwig.nussel@suse.de>
> wrote:
> > ---
> >  Makefile.tools | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Makefile.tools b/Makefile.tools
> > index 7d5361bcd..9f8a0b87b 100644
> > --- a/Makefile.tools
> > +++ b/Makefile.tools
> > @@ -436,7 +436,10 @@ endif
> >  endif
> > 
> >  if CUPS
> > -cupsdir = $(libdir)/cups/backend
> > +# need to use upstream location here which is
> > $exec_prefix/lib/cups/backend, see
> > +# 
> > https://github.com/apple/cups/blob/master/config-scripts/cups-directories.m4
> > +# https://github.com/apple/cups/blob/master/backend/Makefile
> > +cupsdir = $(exec_prefix)/lib/cups/backend
> > 
> >  cups_PROGRAMS = profiles/cups/bluetooth
> 
> Any feedback on these changes?

The Fedora package has been doing that manually for 11 years, so, yes
that looks correct.

It should probably be using the output of
"cups-config --serverbin" instead, but given how hard that is with
autotools, this is probably fine. I'd mention it in the commend instead
of linking at the code though.

