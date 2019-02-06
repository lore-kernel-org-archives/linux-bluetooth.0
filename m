Return-Path: <SRS0=OPIh=QN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C26A6C169C4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Feb 2019 11:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7A820B1F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Feb 2019 11:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPfakXlz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfBFLnE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:43:04 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36610 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfBFLnE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Feb 2019 06:43:04 -0500
Received: by mail-wm1-f66.google.com with SMTP id p6so2331059wmc.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Feb 2019 03:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tkuqINNNE6AyiX347ShiXHbxzIelFGxvIy1enHVfMAU=;
        b=IPfakXlz/nIb9t/i+P9P53MqpTFpJS/fdEccjn/6ffCEcvviKRvIaXm3swDIkFJVSK
         H5i7uNzNqBXm/WYLE46V2yUOtkoFBTOz4ANDw4rI8gph/jo2BdzFrFzDADmgJVeLqNg/
         D2sGaZLKfO7ED63bbcckBUq2d/JLufE+MdJvuY3XFwHkbdgQob5RPoEu1C26BvT6Pixb
         xFEQ8+dBdgCREMV2Sayh0L2jqvUiWxe4TXfC6M5gPAOJHbyCkZhU+hF6AU6HhghEQP9V
         TT5FRk3AB1Ee+KWjiIO7LHxsnuUGv9+jVHslJEAkTlGdWIEW1ODhGTp0bkQUhbumC/5W
         oNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tkuqINNNE6AyiX347ShiXHbxzIelFGxvIy1enHVfMAU=;
        b=a1Ks80LEmqH0z8DfxzbHKL9VSkSYOr/JdCPPArB57AORj6rK7iwL4SkEHtDaZitP3j
         frMnMW7M3eEHhtN4abNiax6vWhxL9p4q/rgF0+YHT3UwbcToLt21TljYcOLzuS2vMRlh
         Wwe7QrVAQLtRdhCyj3hP6K3h83qREH9Thi92OuqAse9wSLlQNuvyygraDlAHtNKuFETm
         yB+I8EMgNNpDetK5RTfzgTUU6xwK9Qnya23pXBJ/JS+PC7ddnjaHv0v/q+Jzx/MwbbXG
         U7107Rmq9co4UJ17e8xXjioKsTMfDrs+/lLBWbaINk5TMke8w5Sb2u3qDCWJA4GtnqJB
         5YeQ==
X-Gm-Message-State: AHQUAub4XTCFX6ciqbcjFmbPkJFc2k9FSi1twy3I2X50AF0fySpAW2TQ
        B0UA76lHCrUoiCwCnyDiC4tjrdVX
X-Google-Smtp-Source: AHgI3IZnOKytFUgkZByxCod1C7+8Q3FRb9j0AVzH5MuREFzpgxZtaJJ6EjVrr0Dc0QKz2W2EAMv29g==
X-Received: by 2002:a1c:c58d:: with SMTP id v135mr2976295wmf.88.1549453381975;
        Wed, 06 Feb 2019 03:43:01 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id q1sm9724039wrs.89.2019.02.06.03.43.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 03:43:01 -0800 (PST)
Date:   Wed, 6 Feb 2019 12:43:00 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Pasi =?utf-8?B?S8Okcmtrw6RpbmVu?= <pasik@iki.fi>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] tools/hcidump: Decode FastStream, aptX Low Latency, aptX
 HD and LDAC
Message-ID: <20190206114300.rxw3ptq7hzathzqe@pali>
References: <20190123174504.12350-1-pali.rohar@gmail.com>
 <8D9BABBE-2BBC-4BFE-BF7C-3BE24AF4DD10@holtmann.org>
 <20190123175448.cdkdpnk6i5r4rzjs@pali>
 <20190130081517.GI32745@reaktio.net>
 <20190130120631.usx67zjk4kmbhcla@pali>
 <CABBYNZJ5z_-8KiotL=9fkvq-gLPoqU1LJpaOBv1z4QfZiA3zaA@mail.gmail.com>
 <20190201124353.GK32745@reaktio.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190201124353.GK32745@reaktio.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Friday 01 February 2019 14:43:53 Pasi Kärkkäinen wrote:
> Hi,
> 
> On Wed, Jan 30, 2019 at 02:24:11PM +0200, Luiz Augusto von Dentz wrote:
> > Hi Pali, Pasi,
> > On Wed, Jan 30, 2019 at 2:09 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> > >
> > > On Wednesday 30 January 2019 10:15:17 Pasi Kärkkäinen wrote:
> > > > On Wed, Jan 23, 2019 at 06:54:48PM +0100, Pali Rohár wrote:
> > > > > On Wednesday 23 January 2019 18:46:18 Marcel Holtmann wrote:
> > > > > > Hi Pali,
> > > > > >
> > > > > > > ---
> > > > > > > tools/parser/avdtp.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++---
> > > > > > > 1 file changed, 55 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > diff --git a/tools/parser/avdtp.c b/tools/parser/avdtp.c
> > > > > > > index 18569c895..a21410f5a 100644
> > > > > > > --- a/tools/parser/avdtp.c
> > > > > > > +++ b/tools/parser/avdtp.c
> > > > > > > @@ -155,6 +155,12 @@ static char *vndcodec2str(uint32_t vendor, uint16_t vndcodec)
> > > > > > > {
> > > > > > >         if (vendor == 0x0000004f && vndcodec == 0x0001)
> > > > > > >                 return "aptX";
> > > > > > > +       else if (vendor == 0x0000000a && vndcodec == 0x0001)
> > > > > > > +               return "FastStream";
> > > > > > > +       else if (vendor == 0x0000000a && vndcodec == 0x0002)
> > > > > > > +               return "aptX Low Latency";
> > > > > > > +       else if (vendor == 0x000000d7 && vndcodec == 0x0024)
> > > > > > > +               return "aptX HD";
> > > > > > >         else if (vendor == 0x0000012d && vndcodec == 0x00aa)
> > > > > > >                 return "LDAC";
> > > > > > >         return "Unknown???;
> > > > > >
> > > > > > lets keep the focus on btmon support since nobody should be using hcidump anymore.
> > > > >
> > > > > In btmon I already implemented it and patches are now merged. I just
> > > > > found another place where this capability parsing is implemented and
> > > > > based on fact that users still use hcidump I quickly looked at it and
> > > > > implemented this parsing.
> > > > >
> > > >
> > > > I agree, hcidump still comes up on many places (guides, blogs, mailinglist posts, etc),
> > > > so it makes sense to add these patches to hcidump aswell. Especially when the patch is quite small.
> > >
> > > Exactly, people still use hcidump...
> > 
> > Well it is a deprecated tool which we might remove starting on BlueZ
> > 6.x which we would like to do in the very next release, if that
> > doesn't happen than perhaps Id take these patches in for a very last
> > BlueZ 5.x release.
> > 
> > @Marcel: Or you have a better plan? We could do one last 5.x and then
> > start working on removing the deprecated tools/etc.
> > 
> 
> +1 for doing one last 5.x release before deprecating and removing tools etc!

Ok, what is the plan? If hcidump is not going to be deleted in upcoming
release, can you take this patch?

-- 
Pali Rohár
pali.rohar@gmail.com
