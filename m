Return-Path: <SRS0=rjyd=EB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_STARTS_WITH_NUMS,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23DEC4363A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 11:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB7522265
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 11:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebMMNeJ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1773966AbgJZLpa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Oct 2020 07:45:30 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:34847 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1773964AbgJZLp2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Oct 2020 07:45:28 -0400
Received: by mail-ed1-f49.google.com with SMTP id w25so8931433edx.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2020 04:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=rj6DcVVX+KnboZhBR7YygFcjvAS89NIVrLRsp0Dxm90=;
        b=ebMMNeJ0r1vZqD0q81GjhrHSrycRqNORORwh+9MnAenEYhrARGq1NqTAVvdrE83/O9
         Asn6OhJicnWqwxeNxC6K9Mc+AprDBKfS3lqA4WmeW2hxnUkCJAPagOvdh5WetSf3VPl6
         hqIZDWENdISF7Jd6UGUaXdajPbuaq4Lw8I5UaNeG1xVFdp7kWN+aAlDqZ748Flk4ZC/W
         VMnBprB+SsqHlQaJa9gAwfw8aBmwYw0pg0o8Si8TKqWeSOhHLatv1dAFUh8zkTy75AmH
         nhndEg11LSpn1dZFKv6jixtwmzLH9zxydM4rRHi+MZpLyJFapPQNopIGme/N9jugF3sV
         IGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=rj6DcVVX+KnboZhBR7YygFcjvAS89NIVrLRsp0Dxm90=;
        b=Qvs7gbzsHA+itfl5hcR6Rq2W18JqyW2E+UYz1JvF8Z0g0FRWSB+ulkXDdvnaj9i71M
         Y67QX5UswlpePs0DqbJ4Z2+ZKhRMnswTSMa6yMi2GlXtMWnSLRCoCsDak30bDmIZjevW
         fyy9W7DFHa0x2o8wZUSEch8l3ISj31kNzXSoyRn3hiyAN+05Z/tBPbOMclQNgx0js9DH
         K47pfYRkk6uhRpc8m667JRYxPGxlftUQNUeaw/G55CWplWPEYFGkxRgbyocoKnM17/sc
         YD+bNOh0Q4JjIsZZgxhSRhsi3shVtQjABj5WR8VtaBou7PPpJTWiGJBOEaSlU3XQa4Xl
         b3Qg==
X-Gm-Message-State: AOAM533QpUdbm/ZbsKi5K8KCAkdAGThTv6lDkF3FQ/hAE3YvZmourTap
        1332kQwbgOBTuWEq/Y2Uot68BjHF6B9GNA==
X-Google-Smtp-Source: ABdhPJwS7aCnVbxm/aBGeGTMN0heNp3KHTbkxSNIow/9TSqduxIvkecZvVvwk9FZMm4jmnj+GcSGfg==
X-Received: by 2002:aa7:c717:: with SMTP id i23mr14929700edq.250.1603712725852;
        Mon, 26 Oct 2020 04:45:25 -0700 (PDT)
Received: from jurupari (firewall.seitwerk.net. [80.155.46.66])
        by smtp.gmail.com with ESMTPSA id qw1sm5696017ejb.44.2020.10.26.04.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 04:45:25 -0700 (PDT)
Message-ID: <f40ad39dad23c813441a3082550ad44f85671f2d.camel@gmail.com>
Subject: Re: Bluetooth: Allow to use configure SCO socket codec parameters
From:   Joschi 127 <127.joschi@gmail.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Date:   Mon, 26 Oct 2020 12:45:24 +0100
In-Reply-To: <20200929210452.bus2qqbikvu2xtwy@pali>
References: <177c5794-1cd7-8f76-b66f-e9473ed37a31@redhat.com>
         <CAB5wbS97WQTduY9sKgiLjAnpsmka+9hGQOBDdbAEHgkcwnze1w@mail.gmail.com>
         <CABBYNZ+TQ+oSYgL1wGsC0rs9faecd0RtQkFE9fbnV89D1r=LOg@mail.gmail.com>
         <20200516075340.3z37ejs3fuhctunl@pali>
         <CABBYNZLWsYHeOo3_+hcq4r+gY_0sLBQhftW7My7Y4D1n9o5jxg@mail.gmail.com>
         <20200518165011.jfarrp5mtqoy3mqz@pali>
         <6da08b42-34d5-9d20-bfc1-161cc8d0f2ea@igalia.com>
         <CABBYNZ+myxfFmobLuzGeYfP_G5tM_ptKgCQCmpQCiUkPZYemuQ@mail.gmail.com>
         <aff611bb-4b38-7614-ce61-fc3e7c012615@igalia.com>
         <20200604204343.eor47oe3fbzf6rbv@pali>
         <20200929210452.bus2qqbikvu2xtwy@pali>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Am Dienstag, den 29.09.2020, 23:04 +0200 schrieb Pali Rohár:
> On Thursday 04 June 2020 22:43:43 Pali Rohár wrote:
> > On Wednesday 27 May 2020 21:54:18 Ujjwal Sharma wrote:
> > > Hi Luiz!
> > > 
> > > Thanks for your response.
> > > 
> > > On 5/27/20 9:18 PM, Luiz Augusto von Dentz wrote:
> > > > Hi Ujjwal,
> > > > ...
> > > > Testing is one thing but for production we would need a
> > > > qualifyable
> > > > solution, that said I wouldn't oppose to have the socket option
> > > > behind
> > > > a module options (runtime) or Kconfig (build-time) so people
> > > > willing
> > > > to run this code can do on their own.
> > > 
> > > 1. What do you think is lacking in this solution that would make
> > > it
> > > qualifyable for production? I believe there are multiple people
> > > in this
> > > thread including Pali who are willing to put in the extra effort.
> > > 
> > > 2. I'd be happy with a runtime option which would allow me to
> > > test this
> > > as well.
> > 
> > Have I missed something? setsockopt() solution which I described in
> > <20200419234937.4zozkqgpt557m3o6@pali> email is already runtime
> > option.
> 
> PING (after 4 months)?

Hello all,

I'm currently (once again) trying to get different BT headsets working
on Linux, with good audio quality also for telephony. It's
unfortunately still the same issue: I can get good quality for playback
only, but as soon as I start using HSP or HFP profiles to enable and
use the headset's microphone, I will have poor audio quality only.
Unfortunately this stops me (and I guess many other users) from being
able to use any wireless headset on Linux desktop.

On an Android phone the same headsets are working fine, also with the
microphone enabled, with good audio quality.

What can be done to finally make this work on Linux desktop?
As far as I understand HFP profile with a supported codec has to be
used, to get telephony with better quality.
All the hard work Pali did for this seems to be the most promising
solution for this right now, as far as I can tell.

What can be done to get his patch merged?
What is currently blocking this or what are the reasons / open issues
why it can't be merged?

I'm willing to support if I can! At least  I can offer some of my time
for manually installing and testing this, if it helps.
I've also updated the patch already to let it compile successfully with
newer kernel version (tried with linux58) and I can provide this
updated version if it helps. (but I am not sure if everything works as
it should)

I hope this can be pushed forward. Would make me (and many other) users
so happy to finally get wireless headphones working better!

Thanks to all of you for your hard work!! (and I know, very often in
your free time!)

Best,

Joschi



