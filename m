Return-Path: <SRS0=VTGX=35=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF74C35250
	for <linux-bluetooth@archiver.kernel.org>; Sun,  9 Feb 2020 13:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74ED2080C
	for <linux-bluetooth@archiver.kernel.org>; Sun,  9 Feb 2020 13:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TI/ML40s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgBINFf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 9 Feb 2020 08:05:35 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34561 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbgBINFf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 9 Feb 2020 08:05:35 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so4238915wrr.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 09 Feb 2020 05:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UOxBx4KJCaL9MLhJkfIo/zGb3y2rXxDFxI+Nkvmnv38=;
        b=TI/ML40sWFoSe8MfT1D+KAQXoiJUkNn3pMV0A/XYjKzo08+DjBZghT1A/ksH+2rJeN
         swtd48c99mS8/VUlcgBY+tlbQ7BeJSOeUX4U1rx8zwst9C78wV81n1QnW/ufX7Uqo+0H
         qn4enKYoduBaQCIxrJM21QxnaJNcQ8L6aXjMONUDq0LHQjyi+v0f5DZCe/wAlHQdb1q1
         /ZH6CPBbohYdFpGhpsSVca4FA05z3URBbPXH6mUIcQJTdCFE9wiZF8AnzKmubX491A8n
         29/XYMjY7PJO1k2FLgJKFNyhzbETFsgPyt9mJv2U1V1RqIhdoGwNkwTDzLDrD7jjDvpK
         2AOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UOxBx4KJCaL9MLhJkfIo/zGb3y2rXxDFxI+Nkvmnv38=;
        b=A26z5CPM57GBIW5LIpvu0LkjXbl6/qjlf+qNXq+9616PnAhxBdJp5xyTntRMcJlR10
         8aBx4RhJumKfwa8iWPtlQWBiR/yjNuWb0GE0hUfaUW2or9rzel3qVtk6dkNsb/oMnDLX
         MwXuQH449qhSThDfHwTepD14GjrXHTb0Omcrqu5hOuMVMt57GR9cKcUYp7r7OhPCorF1
         s0Q/sNDupFMeXl+KOtJxP1Y2kQDuEO7e3t89kTOqUhFhGcb3lDrguYA2deWPm6K69ZlK
         lARgKLgp9Zow70SwCbljeFenAQZiQcJaGcnmpUkdQ1uwXoAquKzBVlGprZ3ULhELGTRG
         avhQ==
X-Gm-Message-State: APjAAAXsC94Rtx062HPS7fOcHhSDU4ASBoU0uKsUhU7uaX0M7oxvobyg
        EGAGQSKtOxeNxOSK+meX9g0=
X-Google-Smtp-Source: APXvYqwrYtPNJLFpEadrTWsuaXzGBKmsBNFXoFbHu9ySPSaAS4CY+YhgWHbLc33shbM6UEtAnlv5qA==
X-Received: by 2002:a05:6000:50:: with SMTP id k16mr10593501wrx.145.1581253533188;
        Sun, 09 Feb 2020 05:05:33 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id p5sm11710325wrt.79.2020.02.09.05.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 05:05:32 -0800 (PST)
Date:   Sun, 9 Feb 2020 14:05:32 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] tools/hcidump: Decode FastStream, aptX Low Latency, aptX
 HD and LDAC
Message-ID: <20200209130532.4evozfyutikzwn4a@pali>
References: <20190130081517.GI32745@reaktio.net>
 <20190130120631.usx67zjk4kmbhcla@pali>
 <CABBYNZJ5z_-8KiotL=9fkvq-gLPoqU1LJpaOBv1z4QfZiA3zaA@mail.gmail.com>
 <20190201124353.GK32745@reaktio.net>
 <20190206114300.rxw3ptq7hzathzqe@pali>
 <20190224131907.GV32745@reaktio.net>
 <20190305122630.gwnaz3y7ckzqfjfq@pali>
 <20190410082924.exo2oihzd7w2oz3e@pali>
 <20190607130739.j25oqqj624anmcqr@pali>
 <20191014110746.n3pmoigtf3ewbmrq@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191014110746.n3pmoigtf3ewbmrq@pali>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Monday 14 October 2019 13:07:46 Pali Rohár wrote:
> On Friday 07 June 2019 15:07:39 Pali Rohár wrote:
> > On Wednesday 10 April 2019 10:29:24 Pali Rohár wrote:
> > > On Tuesday 05 March 2019 13:26:30 Pali Rohár wrote:
> > > > On Sunday 24 February 2019 15:19:07 Pasi Kärkkäinen wrote:
> > > > > On Wed, Feb 06, 2019 at 12:43:00PM +0100, Pali Rohár wrote:
> > > > > > On Friday 01 February 2019 14:43:53 Pasi Kärkkäinen wrote:
> > > > > > > Hi,
> > > > > > > 
> > > > > > > On Wed, Jan 30, 2019 at 02:24:11PM +0200, Luiz Augusto von Dentz wrote:
> > > > > > > > Hi Pali, Pasi,
> > > > > > > > On Wed, Jan 30, 2019 at 2:09 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wednesday 30 January 2019 10:15:17 Pasi Kärkkäinen wrote:
> > > > > > > > > > On Wed, Jan 23, 2019 at 06:54:48PM +0100, Pali Rohár wrote:
> > > > > > > > > > > On Wednesday 23 January 2019 18:46:18 Marcel Holtmann wrote:
> > > > > > > > > > > > Hi Pali,
> > > > > > > > > > > >
> > > > > > > > > > > > > ---
> > > > > > > > > > > > > tools/parser/avdtp.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++---
> > > > > > > > > > > > > 1 file changed, 55 insertions(+), 3 deletions(-)
> > > > > > > > > > > > >
> > > > > > > > > > > > > diff --git a/tools/parser/avdtp.c b/tools/parser/avdtp.c
> > > > > > > > > > > > > index 18569c895..a21410f5a 100644
> > > > > > > > > > > > > --- a/tools/parser/avdtp.c
> > > > > > > > > > > > > +++ b/tools/parser/avdtp.c
> > > > > > > > > > > > > @@ -155,6 +155,12 @@ static char *vndcodec2str(uint32_t vendor, uint16_t vndcodec)
> > > > > > > > > > > > > {
> > > > > > > > > > > > >         if (vendor == 0x0000004f && vndcodec == 0x0001)
> > > > > > > > > > > > >                 return "aptX";
> > > > > > > > > > > > > +       else if (vendor == 0x0000000a && vndcodec == 0x0001)
> > > > > > > > > > > > > +               return "FastStream";
> > > > > > > > > > > > > +       else if (vendor == 0x0000000a && vndcodec == 0x0002)
> > > > > > > > > > > > > +               return "aptX Low Latency";
> > > > > > > > > > > > > +       else if (vendor == 0x000000d7 && vndcodec == 0x0024)
> > > > > > > > > > > > > +               return "aptX HD";
> > > > > > > > > > > > >         else if (vendor == 0x0000012d && vndcodec == 0x00aa)
> > > > > > > > > > > > >                 return "LDAC";
> > > > > > > > > > > > >         return "Unknown???;
> > > > > > > > > > > >
> > > > > > > > > > > > lets keep the focus on btmon support since nobody should be using hcidump anymore.
> > > > > > > > > > >
> > > > > > > > > > > In btmon I already implemented it and patches are now merged. I just
> > > > > > > > > > > found another place where this capability parsing is implemented and
> > > > > > > > > > > based on fact that users still use hcidump I quickly looked at it and
> > > > > > > > > > > implemented this parsing.
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > I agree, hcidump still comes up on many places (guides, blogs, mailinglist posts, etc),
> > > > > > > > > > so it makes sense to add these patches to hcidump aswell. Especially when the patch is quite small.
> > > > > > > > >
> > > > > > > > > Exactly, people still use hcidump...
> > > > > > > > 
> > > > > > > > Well it is a deprecated tool which we might remove starting on BlueZ
> > > > > > > > 6.x which we would like to do in the very next release, if that
> > > > > > > > doesn't happen than perhaps Id take these patches in for a very last
> > > > > > > > BlueZ 5.x release.
> > > > > > > > 
> > > > > > > > @Marcel: Or you have a better plan? We could do one last 5.x and then
> > > > > > > > start working on removing the deprecated tools/etc.
> > > > > > > > 
> > > > > > > 
> > > > > > > +1 for doing one last 5.x release before deprecating and removing tools etc!
> > > > > > 
> > > > > > Ok, what is the plan? If hcidump is not going to be deleted in upcoming
> > > > > > release, can you take this patch?
> > > > > >
> > > > > 
> > > > > How about applying this patch now, considering it's small, and has value for anyone using hcidump.
> > > > > hcidump then gets removed later whenever the removal of deprecated features/tools starts.
> > > > 
> > > > So... what are plans for next release?
> > > 
> > > Marcel, Luiz, can you comment next steps? It is waiting there for your
> > > info here for more than 2 months.
> > 
> > PING!
> 
> Just a gentle reminder for this thread and patch.
> 

Ping, another reminder.

-- 
Pali Rohár
pali.rohar@gmail.com
