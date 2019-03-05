Return-Path: <SRS0=u2q6=RI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD2BC43381
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Mar 2019 12:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909022082C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Mar 2019 12:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvHjbAva"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbfCEM0i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Mar 2019 07:26:38 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45439 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbfCEM0e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Mar 2019 07:26:34 -0500
Received: by mail-wr1-f65.google.com with SMTP id w17so9230268wrn.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Mar 2019 04:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9NcOcbYPwEyxuEibdTg1ZSn8tVMyNdks4aTi7ai883k=;
        b=UvHjbAvaAf85QDRukQc5AtASbohfoffLVcRTLLZlwtOR4jC34mAdJzPrCBeb+2hV/U
         1Mr+rte1N4UxRd0PE0RKkhC60j7IyJbLH/E+VBAYyhgAryrFyJHUmCi/nYGByOkkKMJ2
         YFhHHdhxPavXWYXWYSXDtdCmLG0/f4qwtTuFLnfbUnvfCis2/hkDgluF1+13xz2k8u2y
         oSM3JkhVBlgHdiNm0Qa9M/EhKZPB+9mSY7gTYwGj5gyIv+w+BwL7blqGesh9f6B/FA28
         fp6wAERCaQktYw4V8y07s97XmvImKHqvB5jTy/fEFSxysCfwFwszI0XRieRn52uUVnYR
         2lPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9NcOcbYPwEyxuEibdTg1ZSn8tVMyNdks4aTi7ai883k=;
        b=BrGHLZ+GXmDJM9K4ydcBRSHiSf4dg+NB/q0RSG7/09pQgXFlC+4uSXD8R/OyICrHCm
         /X4Ewc0o0GOyfgdA7STRQ+jG7f22knhrVf7Z017Pzm2HkyAldDTbg/OUYSAw2LDaKPlh
         QCpNchsJrU5BzruG6jN3QUiVlSVytSblX+hhq42YuIzkYJTfwACy4b+RB1nwFCrNscs+
         ftGgzygj0taR7l6QS0uU1Kd+N5sXyizRpBggFHopd2POtCWn0BPzMVlj82DmGlStvU9M
         zibSXRdzdJJXtkOv0HZFS2E26E4C1XoI90MZKXPrNGzVuGteDfQgAhceE8+G/XlATpKx
         KYiw==
X-Gm-Message-State: APjAAAWxx0sbNX9jk3RmPDlneEJ56p3zg1d7hekUOdPA62i32cOfSemW
        u6A8sKgNEdH1yXw1SJRLaMg=
X-Google-Smtp-Source: APXvYqxd+FebX7RjiL+Zg1L7bIIIzaGVThR1w+NQcirrUamNYxyDmz5tFCYIB98NVJwl0r/rt/omfw==
X-Received: by 2002:adf:ce90:: with SMTP id r16mr16080544wrn.64.1551788792658;
        Tue, 05 Mar 2019 04:26:32 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id t8sm5966094wmi.21.2019.03.05.04.26.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Mar 2019 04:26:31 -0800 (PST)
Date:   Tue, 5 Mar 2019 13:26:30 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] tools/hcidump: Decode FastStream, aptX Low Latency, aptX
 HD and LDAC
Message-ID: <20190305122630.gwnaz3y7ckzqfjfq@pali>
References: <20190123174504.12350-1-pali.rohar@gmail.com>
 <8D9BABBE-2BBC-4BFE-BF7C-3BE24AF4DD10@holtmann.org>
 <20190123175448.cdkdpnk6i5r4rzjs@pali>
 <20190130081517.GI32745@reaktio.net>
 <20190130120631.usx67zjk4kmbhcla@pali>
 <CABBYNZJ5z_-8KiotL=9fkvq-gLPoqU1LJpaOBv1z4QfZiA3zaA@mail.gmail.com>
 <20190201124353.GK32745@reaktio.net>
 <20190206114300.rxw3ptq7hzathzqe@pali>
 <20190224131907.GV32745@reaktio.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190224131907.GV32745@reaktio.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sunday 24 February 2019 15:19:07 Pasi Kärkkäinen wrote:
> On Wed, Feb 06, 2019 at 12:43:00PM +0100, Pali Rohár wrote:
> > On Friday 01 February 2019 14:43:53 Pasi Kärkkäinen wrote:
> > > Hi,
> > > 
> > > On Wed, Jan 30, 2019 at 02:24:11PM +0200, Luiz Augusto von Dentz wrote:
> > > > Hi Pali, Pasi,
> > > > On Wed, Jan 30, 2019 at 2:09 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> > > > >
> > > > > On Wednesday 30 January 2019 10:15:17 Pasi Kärkkäinen wrote:
> > > > > > On Wed, Jan 23, 2019 at 06:54:48PM +0100, Pali Rohár wrote:
> > > > > > > On Wednesday 23 January 2019 18:46:18 Marcel Holtmann wrote:
> > > > > > > > Hi Pali,
> > > > > > > >
> > > > > > > > > ---
> > > > > > > > > tools/parser/avdtp.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++---
> > > > > > > > > 1 file changed, 55 insertions(+), 3 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/tools/parser/avdtp.c b/tools/parser/avdtp.c
> > > > > > > > > index 18569c895..a21410f5a 100644
> > > > > > > > > --- a/tools/parser/avdtp.c
> > > > > > > > > +++ b/tools/parser/avdtp.c
> > > > > > > > > @@ -155,6 +155,12 @@ static char *vndcodec2str(uint32_t vendor, uint16_t vndcodec)
> > > > > > > > > {
> > > > > > > > >         if (vendor == 0x0000004f && vndcodec == 0x0001)
> > > > > > > > >                 return "aptX";
> > > > > > > > > +       else if (vendor == 0x0000000a && vndcodec == 0x0001)
> > > > > > > > > +               return "FastStream";
> > > > > > > > > +       else if (vendor == 0x0000000a && vndcodec == 0x0002)
> > > > > > > > > +               return "aptX Low Latency";
> > > > > > > > > +       else if (vendor == 0x000000d7 && vndcodec == 0x0024)
> > > > > > > > > +               return "aptX HD";
> > > > > > > > >         else if (vendor == 0x0000012d && vndcodec == 0x00aa)
> > > > > > > > >                 return "LDAC";
> > > > > > > > >         return "Unknown???;
> > > > > > > >
> > > > > > > > lets keep the focus on btmon support since nobody should be using hcidump anymore.
> > > > > > >
> > > > > > > In btmon I already implemented it and patches are now merged. I just
> > > > > > > found another place where this capability parsing is implemented and
> > > > > > > based on fact that users still use hcidump I quickly looked at it and
> > > > > > > implemented this parsing.
> > > > > > >
> > > > > >
> > > > > > I agree, hcidump still comes up on many places (guides, blogs, mailinglist posts, etc),
> > > > > > so it makes sense to add these patches to hcidump aswell. Especially when the patch is quite small.
> > > > >
> > > > > Exactly, people still use hcidump...
> > > > 
> > > > Well it is a deprecated tool which we might remove starting on BlueZ
> > > > 6.x which we would like to do in the very next release, if that
> > > > doesn't happen than perhaps Id take these patches in for a very last
> > > > BlueZ 5.x release.
> > > > 
> > > > @Marcel: Or you have a better plan? We could do one last 5.x and then
> > > > start working on removing the deprecated tools/etc.
> > > > 
> > > 
> > > +1 for doing one last 5.x release before deprecating and removing tools etc!
> > 
> > Ok, what is the plan? If hcidump is not going to be deleted in upcoming
> > release, can you take this patch?
> >
> 
> How about applying this patch now, considering it's small, and has value for anyone using hcidump.
> hcidump then gets removed later whenever the removal of deprecated features/tools starts.

So... what are plans for next release?

> Any news about next bluez release?
> 
> 
>  
> > -- 
> > Pali Rohár
> > pali.rohar@gmail.com
> 
> 
> Thanks,
> 
> -- Pasi
> 

-- 
Pali Rohár
pali.rohar@gmail.com
