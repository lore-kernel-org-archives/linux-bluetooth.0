Return-Path: <SRS0=NoyY=YH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C234C4CECE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Oct 2019 11:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3DC2084B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Oct 2019 11:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7qZ8ZCY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731665AbfJNLHu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Oct 2019 07:07:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55801 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731400AbfJNLHu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Oct 2019 07:07:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id a6so16776765wma.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2019 04:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bYnZXjlD4AnuB2uTefYKDWKoIRW6WJ1wHFGRenjiP5E=;
        b=b7qZ8ZCYpHVE6UTxPTuO1YFeiGoxdpq8YH5pygxcA/PsX0bG4TMNeWtV5Ch/gE5DS+
         JIMM45zXPwZEpshHNy/nzE9G0URnJYlHfEhqSUVhPQjh6eYJsDub234vaTyux+0RhD/G
         qDhufHDUFgULwZUUpt+7R4TCJeEPpTgUu2RqVRe5oxNYeIUlrumb2PL+63jXhZRrQCUn
         yYlHPsOgO4sjWMm8jGRw2tX6JlfGz3Uy02M5lx2wbIUMH1A3pE+8A8x92viqkojr+xeP
         I+MhM8RPKwprGC/RxuWFAm4D40NkACbb/il2qDXBiTrTxDDqbgTbWpNEMgcytS/OXXWf
         8Dew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bYnZXjlD4AnuB2uTefYKDWKoIRW6WJ1wHFGRenjiP5E=;
        b=HSmOqsFCXyUBTEF+KWarWDIp5Ns0sfk9xysUl1UR53og/8LFf5O8gfnS+lfJZhChYk
         dvAmgXH/S59vQF0dlTBwly9MtjoP1a/PV2kyAXWNKzQxxIJ5r9gKl0L6UQ9THaQzZoC3
         ZQ/uaUlNvj//+/ZgYHDbMoLM8sfTt5VqMNYLURBmwdUXc+q0QKR9W2WgLreDBPP0Y9nC
         JI0IhyhRZUOsEuQiU6CAA8IliB6ui/XBgDYYTVbQr6r2DEtYmxarcWsAyVSskMecAr0h
         pisvH42D6KVuzgwUiPSfDTfowvbPcpm44lzHaCwZR/KPk7KtRpFMrVEM/HYox+bpUJjc
         bxAA==
X-Gm-Message-State: APjAAAVoluTw9AS8RElEJPwiNF40oCNz4UqmZqOmPrCHOt6ZrpcZ5gN1
        dZ1pz+V+7G/gyIMBDZRLzkyC27kv
X-Google-Smtp-Source: APXvYqzpN3+W5cE+lPuQU4VrqIwjQfNnNFDlsvs21tvqg1Q1VDOrf1ZyWfymkaNDgOcTAsGTS/qQjQ==
X-Received: by 2002:a7b:c44f:: with SMTP id l15mr14544314wmi.121.1571051267764;
        Mon, 14 Oct 2019 04:07:47 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id t123sm30899804wma.40.2019.10.14.04.07.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Oct 2019 04:07:47 -0700 (PDT)
Date:   Mon, 14 Oct 2019 13:07:46 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] tools/hcidump: Decode FastStream, aptX Low Latency, aptX
 HD and LDAC
Message-ID: <20191014110746.n3pmoigtf3ewbmrq@pali>
References: <20190123175448.cdkdpnk6i5r4rzjs@pali>
 <20190130081517.GI32745@reaktio.net>
 <20190130120631.usx67zjk4kmbhcla@pali>
 <CABBYNZJ5z_-8KiotL=9fkvq-gLPoqU1LJpaOBv1z4QfZiA3zaA@mail.gmail.com>
 <20190201124353.GK32745@reaktio.net>
 <20190206114300.rxw3ptq7hzathzqe@pali>
 <20190224131907.GV32745@reaktio.net>
 <20190305122630.gwnaz3y7ckzqfjfq@pali>
 <20190410082924.exo2oihzd7w2oz3e@pali>
 <20190607130739.j25oqqj624anmcqr@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190607130739.j25oqqj624anmcqr@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Friday 07 June 2019 15:07:39 Pali Rohár wrote:
> On Wednesday 10 April 2019 10:29:24 Pali Rohár wrote:
> > On Tuesday 05 March 2019 13:26:30 Pali Rohár wrote:
> > > On Sunday 24 February 2019 15:19:07 Pasi Kärkkäinen wrote:
> > > > On Wed, Feb 06, 2019 at 12:43:00PM +0100, Pali Rohár wrote:
> > > > > On Friday 01 February 2019 14:43:53 Pasi Kärkkäinen wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > On Wed, Jan 30, 2019 at 02:24:11PM +0200, Luiz Augusto von Dentz wrote:
> > > > > > > Hi Pali, Pasi,
> > > > > > > On Wed, Jan 30, 2019 at 2:09 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Wednesday 30 January 2019 10:15:17 Pasi Kärkkäinen wrote:
> > > > > > > > > On Wed, Jan 23, 2019 at 06:54:48PM +0100, Pali Rohár wrote:
> > > > > > > > > > On Wednesday 23 January 2019 18:46:18 Marcel Holtmann wrote:
> > > > > > > > > > > Hi Pali,
> > > > > > > > > > >
> > > > > > > > > > > > ---
> > > > > > > > > > > > tools/parser/avdtp.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++---
> > > > > > > > > > > > 1 file changed, 55 insertions(+), 3 deletions(-)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/tools/parser/avdtp.c b/tools/parser/avdtp.c
> > > > > > > > > > > > index 18569c895..a21410f5a 100644
> > > > > > > > > > > > --- a/tools/parser/avdtp.c
> > > > > > > > > > > > +++ b/tools/parser/avdtp.c
> > > > > > > > > > > > @@ -155,6 +155,12 @@ static char *vndcodec2str(uint32_t vendor, uint16_t vndcodec)
> > > > > > > > > > > > {
> > > > > > > > > > > >         if (vendor == 0x0000004f && vndcodec == 0x0001)
> > > > > > > > > > > >                 return "aptX";
> > > > > > > > > > > > +       else if (vendor == 0x0000000a && vndcodec == 0x0001)
> > > > > > > > > > > > +               return "FastStream";
> > > > > > > > > > > > +       else if (vendor == 0x0000000a && vndcodec == 0x0002)
> > > > > > > > > > > > +               return "aptX Low Latency";
> > > > > > > > > > > > +       else if (vendor == 0x000000d7 && vndcodec == 0x0024)
> > > > > > > > > > > > +               return "aptX HD";
> > > > > > > > > > > >         else if (vendor == 0x0000012d && vndcodec == 0x00aa)
> > > > > > > > > > > >                 return "LDAC";
> > > > > > > > > > > >         return "Unknown???;
> > > > > > > > > > >
> > > > > > > > > > > lets keep the focus on btmon support since nobody should be using hcidump anymore.
> > > > > > > > > >
> > > > > > > > > > In btmon I already implemented it and patches are now merged. I just
> > > > > > > > > > found another place where this capability parsing is implemented and
> > > > > > > > > > based on fact that users still use hcidump I quickly looked at it and
> > > > > > > > > > implemented this parsing.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > I agree, hcidump still comes up on many places (guides, blogs, mailinglist posts, etc),
> > > > > > > > > so it makes sense to add these patches to hcidump aswell. Especially when the patch is quite small.
> > > > > > > >
> > > > > > > > Exactly, people still use hcidump...
> > > > > > > 
> > > > > > > Well it is a deprecated tool which we might remove starting on BlueZ
> > > > > > > 6.x which we would like to do in the very next release, if that
> > > > > > > doesn't happen than perhaps Id take these patches in for a very last
> > > > > > > BlueZ 5.x release.
> > > > > > > 
> > > > > > > @Marcel: Or you have a better plan? We could do one last 5.x and then
> > > > > > > start working on removing the deprecated tools/etc.
> > > > > > > 
> > > > > > 
> > > > > > +1 for doing one last 5.x release before deprecating and removing tools etc!
> > > > > 
> > > > > Ok, what is the plan? If hcidump is not going to be deleted in upcoming
> > > > > release, can you take this patch?
> > > > >
> > > > 
> > > > How about applying this patch now, considering it's small, and has value for anyone using hcidump.
> > > > hcidump then gets removed later whenever the removal of deprecated features/tools starts.
> > > 
> > > So... what are plans for next release?
> > 
> > Marcel, Luiz, can you comment next steps? It is waiting there for your
> > info here for more than 2 months.
> 
> PING!

Just a gentle reminder for this thread and patch.

-- 
Pali Rohár
pali.rohar@gmail.com
