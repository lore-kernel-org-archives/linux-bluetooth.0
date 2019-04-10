Return-Path: <SRS0=/qBL=SM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BE4C10F14
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Apr 2019 08:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37F442084B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Apr 2019 08:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Is3bxtnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfDJI3c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:29:32 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39178 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729045AbfDJI3c (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Apr 2019 04:29:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so1558229wmk.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2019 01:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0sXLJF2JE9mF3B0kRJ1ZYJizdzJQ7aB4P2Lz0zQfxJ4=;
        b=Is3bxtnZZUZGzHtPQLCWOBjDc1QzG8ctCiUdu4ytkJZn1qsv4hfzIk51dAUyd1WWYM
         7jWnanpc4K6H4JcJnBuIQnQIhgaeIBh/kbdHxxzUgALm0xHxApZ42BiXzAO1yXMbr3It
         cAw6BFBN+XWAR+RdZQP6W1kYT+1gKqw+w4p/AQ3ELrFVHMocBzbH0+lcQV3cgV4GeiFX
         I0csm6Fhm12E/uGKW3PttMyjSTGVTiSoSG1kdRWW9EYvMcKxmqUbPEOSrgYAPk2EfsXA
         uoPzWdoQ9JkbjJFtzWHwHEQVTjZdM21R7TdW3w6mQ0CRjN9pvI9ujEdZzTgmTPQxreHb
         ogzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0sXLJF2JE9mF3B0kRJ1ZYJizdzJQ7aB4P2Lz0zQfxJ4=;
        b=g/eBseR1kyNxO73fEtB0KpOK1YlK1sLP62YZQNm50p94SFcZl0o5fUIDG+kY+kIt8m
         GXo8cqcD+xN5eWTDahlste5TDs3cGSqu4+FrNZ0jz35TRC5W7CKSSzaGrv0ATKA4pG6i
         JJDxLmEZ2ClvZepYvsD38HMq0A6/yBz+rTcE2x6tUPAtfbeqLIaW6GfX+38qLGdvk7Ap
         /JbFbJrkwBf0yR4IQVaDZCqdr0pEArsDbg7n4OKKRRXh6si6hObBa06J2FtRTefia+y+
         FwiTAWB65igyQEgNeSJ8qxMyf4Cs/R8wRZtwSIOwjYX99+e6bmNN2g8yTw34HkwHgyYY
         N4Lg==
X-Gm-Message-State: APjAAAUSLsG89pZ4AbIUp4toHdutWUAHKjJQEFwgwqW7S7rVx+vkKuGO
        725UGJ1xHDSlnZKEYd3RcWUVGRy2
X-Google-Smtp-Source: APXvYqz9AAUen+RdEYH0nD8f4LG2g8t3ozue0bNljVoI9mQDx1y258D8zIyefXVR+clUb0lTbdJF3Q==
X-Received: by 2002:a05:600c:211a:: with SMTP id u26mr1955318wml.74.1554884970054;
        Wed, 10 Apr 2019 01:29:30 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id z74sm7946354wmc.2.2019.04.10.01.29.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 01:29:29 -0700 (PDT)
Date:   Wed, 10 Apr 2019 10:29:24 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] tools/hcidump: Decode FastStream, aptX Low Latency, aptX
 HD and LDAC
Message-ID: <20190410082924.exo2oihzd7w2oz3e@pali>
References: <20190123174504.12350-1-pali.rohar@gmail.com>
 <8D9BABBE-2BBC-4BFE-BF7C-3BE24AF4DD10@holtmann.org>
 <20190123175448.cdkdpnk6i5r4rzjs@pali>
 <20190130081517.GI32745@reaktio.net>
 <20190130120631.usx67zjk4kmbhcla@pali>
 <CABBYNZJ5z_-8KiotL=9fkvq-gLPoqU1LJpaOBv1z4QfZiA3zaA@mail.gmail.com>
 <20190201124353.GK32745@reaktio.net>
 <20190206114300.rxw3ptq7hzathzqe@pali>
 <20190224131907.GV32745@reaktio.net>
 <20190305122630.gwnaz3y7ckzqfjfq@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190305122630.gwnaz3y7ckzqfjfq@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Tuesday 05 March 2019 13:26:30 Pali Rohár wrote:
> On Sunday 24 February 2019 15:19:07 Pasi Kärkkäinen wrote:
> > On Wed, Feb 06, 2019 at 12:43:00PM +0100, Pali Rohár wrote:
> > > On Friday 01 February 2019 14:43:53 Pasi Kärkkäinen wrote:
> > > > Hi,
> > > > 
> > > > On Wed, Jan 30, 2019 at 02:24:11PM +0200, Luiz Augusto von Dentz wrote:
> > > > > Hi Pali, Pasi,
> > > > > On Wed, Jan 30, 2019 at 2:09 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> > > > > >
> > > > > > On Wednesday 30 January 2019 10:15:17 Pasi Kärkkäinen wrote:
> > > > > > > On Wed, Jan 23, 2019 at 06:54:48PM +0100, Pali Rohár wrote:
> > > > > > > > On Wednesday 23 January 2019 18:46:18 Marcel Holtmann wrote:
> > > > > > > > > Hi Pali,
> > > > > > > > >
> > > > > > > > > > ---
> > > > > > > > > > tools/parser/avdtp.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++---
> > > > > > > > > > 1 file changed, 55 insertions(+), 3 deletions(-)
> > > > > > > > > >
> > > > > > > > > > diff --git a/tools/parser/avdtp.c b/tools/parser/avdtp.c
> > > > > > > > > > index 18569c895..a21410f5a 100644
> > > > > > > > > > --- a/tools/parser/avdtp.c
> > > > > > > > > > +++ b/tools/parser/avdtp.c
> > > > > > > > > > @@ -155,6 +155,12 @@ static char *vndcodec2str(uint32_t vendor, uint16_t vndcodec)
> > > > > > > > > > {
> > > > > > > > > >         if (vendor == 0x0000004f && vndcodec == 0x0001)
> > > > > > > > > >                 return "aptX";
> > > > > > > > > > +       else if (vendor == 0x0000000a && vndcodec == 0x0001)
> > > > > > > > > > +               return "FastStream";
> > > > > > > > > > +       else if (vendor == 0x0000000a && vndcodec == 0x0002)
> > > > > > > > > > +               return "aptX Low Latency";
> > > > > > > > > > +       else if (vendor == 0x000000d7 && vndcodec == 0x0024)
> > > > > > > > > > +               return "aptX HD";
> > > > > > > > > >         else if (vendor == 0x0000012d && vndcodec == 0x00aa)
> > > > > > > > > >                 return "LDAC";
> > > > > > > > > >         return "Unknown???;
> > > > > > > > >
> > > > > > > > > lets keep the focus on btmon support since nobody should be using hcidump anymore.
> > > > > > > >
> > > > > > > > In btmon I already implemented it and patches are now merged. I just
> > > > > > > > found another place where this capability parsing is implemented and
> > > > > > > > based on fact that users still use hcidump I quickly looked at it and
> > > > > > > > implemented this parsing.
> > > > > > > >
> > > > > > >
> > > > > > > I agree, hcidump still comes up on many places (guides, blogs, mailinglist posts, etc),
> > > > > > > so it makes sense to add these patches to hcidump aswell. Especially when the patch is quite small.
> > > > > >
> > > > > > Exactly, people still use hcidump...
> > > > > 
> > > > > Well it is a deprecated tool which we might remove starting on BlueZ
> > > > > 6.x which we would like to do in the very next release, if that
> > > > > doesn't happen than perhaps Id take these patches in for a very last
> > > > > BlueZ 5.x release.
> > > > > 
> > > > > @Marcel: Or you have a better plan? We could do one last 5.x and then
> > > > > start working on removing the deprecated tools/etc.
> > > > > 
> > > > 
> > > > +1 for doing one last 5.x release before deprecating and removing tools etc!
> > > 
> > > Ok, what is the plan? If hcidump is not going to be deleted in upcoming
> > > release, can you take this patch?
> > >
> > 
> > How about applying this patch now, considering it's small, and has value for anyone using hcidump.
> > hcidump then gets removed later whenever the removal of deprecated features/tools starts.
> 
> So... what are plans for next release?

Marcel, Luiz, can you comment next steps? It is waiting there for your
info here for more than 2 months.

> > Any news about next bluez release?
> > 
> > 
> >  
> > > -- 
> > > Pali Rohár
> > > pali.rohar@gmail.com
> > 
> > 
> > Thanks,
> > 
> > -- Pasi
> > 
> 

-- 
Pali Rohár
pali.rohar@gmail.com
