Return-Path: <SRS0=bh0L=UG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22936C2BCA1
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jun 2019 13:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E2B208E3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jun 2019 13:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sq5Hzstu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfFGNHn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jun 2019 09:07:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33349 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfFGNHn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jun 2019 09:07:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so2141831wru.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jun 2019 06:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9EdIUKQ1/TsMUI/d7kfSgUq9bkts48YQROzFErv1XLo=;
        b=Sq5HzstulkAHDwxI0o44mhggbnQFhBJsv0nrh7TJ3xms2BHr074/88kziImL0+kIg4
         DTiDJuQf4LheaqdnzsKw2WEu4HAhTPHh2kZbTmO+aXCCaWB2I0QThDIFgG6FlTsIoQlR
         3plgcpC3rJepbUf5rjtWm+kZ24XwKC89LaZjeoQskBVtMF3uaBkEkKAlu+mHMwyI4DtZ
         MkMApYH9j7G++udvQldL2YQV133c07DnOM/zhENZZy5stxaKjIPeYu3ZQ1Ri1dl6kn7b
         6xu43MrveP0lrqAuIBvcCWQrNqjqSDZm+u7mglvrQEq+tehVxuVj1nsE1vCKnlUh3/iL
         xnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9EdIUKQ1/TsMUI/d7kfSgUq9bkts48YQROzFErv1XLo=;
        b=OxX6Gp90sPw8z7lrdqswZfNACLi1v7LAgErVrDNj+YSKIAo/ttq6zCUH+AieVcTMZP
         FCpP10/pYB+o/lAOCeiTJFMQ6VuwFa5s4pOhbvfl5WoG2+YmodGweeTQyr7zGq03V45m
         kosaNQ+lM/CCAiBVmfdhL++BWXLeLzYdkjxmFVlEtwb1PjfnsNkoyKLio/aOjEt0NbYV
         zNGJhd4YHyvSspE78AhSQXOGiJ/ocl573FL2A4VSSqhhuZNGwwlbK+1OhhE3Ae3mw4jy
         2FYcqNLyKur+pzDVT8Tt55hSHmd3/gK9V3Xo8RSzLw5Nqp3EScS108QYlmAN5U4qw3yg
         9AEw==
X-Gm-Message-State: APjAAAXKghcK7+erPBKYq6YR3mtsyD/xBjsC8wxSz7XBxg4JOz9vnMOy
        LcX6p05NMeUVlpQYLw3Oq3k=
X-Google-Smtp-Source: APXvYqzOaclqDpXqPg8z5zkhbObGhbB6RR5rTCB0nBrlgo4jF7zp8z7e1uy7Dh7wkYzTSQVJ2Wdomg==
X-Received: by 2002:a5d:498a:: with SMTP id r10mr33882408wrq.28.1559912860895;
        Fri, 07 Jun 2019 06:07:40 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id o14sm1973652wrp.77.2019.06.07.06.07.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Jun 2019 06:07:40 -0700 (PDT)
Date:   Fri, 7 Jun 2019 15:07:39 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] tools/hcidump: Decode FastStream, aptX Low Latency, aptX
 HD and LDAC
Message-ID: <20190607130739.j25oqqj624anmcqr@pali>
References: <8D9BABBE-2BBC-4BFE-BF7C-3BE24AF4DD10@holtmann.org>
 <20190123175448.cdkdpnk6i5r4rzjs@pali>
 <20190130081517.GI32745@reaktio.net>
 <20190130120631.usx67zjk4kmbhcla@pali>
 <CABBYNZJ5z_-8KiotL=9fkvq-gLPoqU1LJpaOBv1z4QfZiA3zaA@mail.gmail.com>
 <20190201124353.GK32745@reaktio.net>
 <20190206114300.rxw3ptq7hzathzqe@pali>
 <20190224131907.GV32745@reaktio.net>
 <20190305122630.gwnaz3y7ckzqfjfq@pali>
 <20190410082924.exo2oihzd7w2oz3e@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190410082924.exo2oihzd7w2oz3e@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wednesday 10 April 2019 10:29:24 Pali Rohár wrote:
> On Tuesday 05 March 2019 13:26:30 Pali Rohár wrote:
> > On Sunday 24 February 2019 15:19:07 Pasi Kärkkäinen wrote:
> > > On Wed, Feb 06, 2019 at 12:43:00PM +0100, Pali Rohár wrote:
> > > > On Friday 01 February 2019 14:43:53 Pasi Kärkkäinen wrote:
> > > > > Hi,
> > > > > 
> > > > > On Wed, Jan 30, 2019 at 02:24:11PM +0200, Luiz Augusto von Dentz wrote:
> > > > > > Hi Pali, Pasi,
> > > > > > On Wed, Jan 30, 2019 at 2:09 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> > > > > > >
> > > > > > > On Wednesday 30 January 2019 10:15:17 Pasi Kärkkäinen wrote:
> > > > > > > > On Wed, Jan 23, 2019 at 06:54:48PM +0100, Pali Rohár wrote:
> > > > > > > > > On Wednesday 23 January 2019 18:46:18 Marcel Holtmann wrote:
> > > > > > > > > > Hi Pali,
> > > > > > > > > >
> > > > > > > > > > > ---
> > > > > > > > > > > tools/parser/avdtp.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++---
> > > > > > > > > > > 1 file changed, 55 insertions(+), 3 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/tools/parser/avdtp.c b/tools/parser/avdtp.c
> > > > > > > > > > > index 18569c895..a21410f5a 100644
> > > > > > > > > > > --- a/tools/parser/avdtp.c
> > > > > > > > > > > +++ b/tools/parser/avdtp.c
> > > > > > > > > > > @@ -155,6 +155,12 @@ static char *vndcodec2str(uint32_t vendor, uint16_t vndcodec)
> > > > > > > > > > > {
> > > > > > > > > > >         if (vendor == 0x0000004f && vndcodec == 0x0001)
> > > > > > > > > > >                 return "aptX";
> > > > > > > > > > > +       else if (vendor == 0x0000000a && vndcodec == 0x0001)
> > > > > > > > > > > +               return "FastStream";
> > > > > > > > > > > +       else if (vendor == 0x0000000a && vndcodec == 0x0002)
> > > > > > > > > > > +               return "aptX Low Latency";
> > > > > > > > > > > +       else if (vendor == 0x000000d7 && vndcodec == 0x0024)
> > > > > > > > > > > +               return "aptX HD";
> > > > > > > > > > >         else if (vendor == 0x0000012d && vndcodec == 0x00aa)
> > > > > > > > > > >                 return "LDAC";
> > > > > > > > > > >         return "Unknown???;
> > > > > > > > > >
> > > > > > > > > > lets keep the focus on btmon support since nobody should be using hcidump anymore.
> > > > > > > > >
> > > > > > > > > In btmon I already implemented it and patches are now merged. I just
> > > > > > > > > found another place where this capability parsing is implemented and
> > > > > > > > > based on fact that users still use hcidump I quickly looked at it and
> > > > > > > > > implemented this parsing.
> > > > > > > > >
> > > > > > > >
> > > > > > > > I agree, hcidump still comes up on many places (guides, blogs, mailinglist posts, etc),
> > > > > > > > so it makes sense to add these patches to hcidump aswell. Especially when the patch is quite small.
> > > > > > >
> > > > > > > Exactly, people still use hcidump...
> > > > > > 
> > > > > > Well it is a deprecated tool which we might remove starting on BlueZ
> > > > > > 6.x which we would like to do in the very next release, if that
> > > > > > doesn't happen than perhaps Id take these patches in for a very last
> > > > > > BlueZ 5.x release.
> > > > > > 
> > > > > > @Marcel: Or you have a better plan? We could do one last 5.x and then
> > > > > > start working on removing the deprecated tools/etc.
> > > > > > 
> > > > > 
> > > > > +1 for doing one last 5.x release before deprecating and removing tools etc!
> > > > 
> > > > Ok, what is the plan? If hcidump is not going to be deleted in upcoming
> > > > release, can you take this patch?
> > > >
> > > 
> > > How about applying this patch now, considering it's small, and has value for anyone using hcidump.
> > > hcidump then gets removed later whenever the removal of deprecated features/tools starts.
> > 
> > So... what are plans for next release?
> 
> Marcel, Luiz, can you comment next steps? It is waiting there for your
> info here for more than 2 months.

PING!

-- 
Pali Rohár
pali.rohar@gmail.com
