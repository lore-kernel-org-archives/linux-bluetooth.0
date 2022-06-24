Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236CFC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jun 2022 20:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiFXUAD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Jun 2022 16:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiFXUAC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Jun 2022 16:00:02 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B20826B5
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jun 2022 13:00:00 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id c2so6350261lfk.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jun 2022 13:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WvmDAzTeYnupXcG5hwsscAPrC58RhTGzJ0Vo8l3mK6I=;
        b=ZOq9fW+Rs+ykcVbWeLp0QcFyIdMqwZyrUqdE/sJI5lxFsKo/+C6VcXqKIZxzkOnjAD
         EpWiRtZtaf6r1Ao0YgJAF38wMTlgUSCJkPE53mOcG14ksbnqNf4hDHE/AYR+tALy0zHq
         jE8cJQJnRUeOK9BunmDNpY+oAaItYa13rgtZEu3j5xBhp/IEx0uSesHtnFp5MGjQKN3H
         No8erGGfX+4LISYMLIW8asHv9+bTR5cQdXifJ8TR9AtNqf/u8kPi8DzIhxe2cAMu5iQf
         cbs53YmoLyRjAPpEBaC0/z4Zy8wW66MntKwOGBHMnzyt9ov+QsiG95rbyzi3QaDfGwd9
         FaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WvmDAzTeYnupXcG5hwsscAPrC58RhTGzJ0Vo8l3mK6I=;
        b=PVooIhENmMP0LzZx9f3uxWUAEbYyXeHz5BvtrOpEQZF0qFlFlydGrkyouFjqVVC46B
         2D/3wZGu8K0UBaaQ7V2u6Ya0/W88AoPWxL/2PSdDhh6bruje6ZSFt0ft6BkGaYGO0fDi
         nv5mZ9le+YjrKEWxf4tkIWgmOYUdeVaxzpcCgaW9OvYxGREXIiajF7hL2ffIVKdrxRgT
         bPG8mjPVb+5Njz6+TQZVFhik1ixiL4+Tpv8ZEzY7+v5RnAw3+luNdKkWLnsIKVAMdLau
         k/KFn2XZbspQSQzfuOnOeKPyyH4aS/X4LvKldYvWkNZ9W7LjQPOP5HY/pSjNRZHemUuL
         UwIw==
X-Gm-Message-State: AJIora/jd8ci1Lsn91jPQn728/RkZzkhI236nQpOUEmAM2JXpii/zN3f
        d1g5jf3p/9CmaBFqXvZPf7G33AC3kL5o47eMrMYGd4Rt0W9+Gw==
X-Google-Smtp-Source: AGRyM1vrKVgDrOfjjVywF6J2BvIXoa3NNDaYPHZ0XyxTdYGGf+g+ftfevhkkr+MIvOkZfEB2MI2ITMpLeoNEvluY2wI=
X-Received: by 2002:a05:6512:31d0:b0:47f:92c6:99f1 with SMTP id
 j16-20020a05651231d000b0047f92c699f1mr383198lfe.198.1656100799021; Fri, 24
 Jun 2022 12:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <a1ce1743-e450-6cdb-dfab-56a3e3eb9aed@pengutronix.de>
 <CABBYNZ+z8kBUKGXbZSfb0ynJaTnPQRp0wFDUb12AW1ymbNx1eg@mail.gmail.com>
 <CABBYNZ+zsuggTpaUSPsZKeL=qqvM1=sgMWzdWEqaS_oh6dhY2g@mail.gmail.com>
 <8d5c4724-d511-39b1-21d7-116c91cada45@pengutronix.de> <b0cb4fb0-6b89-b9df-9ae6-421ac52b0100@pengutronix.de>
 <CABBYNZ+ubN2rc=zoN_53Pmp6kt3L5UcY3knbtjhhVOjPBpJv4Q@mail.gmail.com>
 <d5654901-6b1f-a1fa-0101-8b52b345af7b@pengutronix.de> <CABBYNZ+8dpPBqaQMr-Hz_DJRxT-0ucCjgAJH50FUaN7Sn9H6rA@mail.gmail.com>
 <1d1b76cf-df6f-3935-5cd2-c45ea78f2c33@pengutronix.de> <CABBYNZLdy-rndKczoG_WiWXQmacX+vzCbftQKvzJ3B6imtZopw@mail.gmail.com>
 <1a5ec80d-690f-285c-3da8-ccdaf5516d85@pengutronix.de>
In-Reply-To: <1a5ec80d-690f-285c-3da8-ccdaf5516d85@pengutronix.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 24 Jun 2022 12:59:47 -0700
Message-ID: <CABBYNZJQKc9ozReXLeESWY8U648eQytKfGB4WmhZi4M+YOW7jw@mail.gmail.com>
Subject: Re: [BUG] BLE device unpairing triggers kernel panic
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ahmad,

On Fri, Jun 24, 2022 at 5:53 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hi Tedd, Luiz,
>
> On 21.06.22 20:52, Luiz Augusto von Dentz wrote:
> > Hi Ahmad, Tedd,
> >
> > On Tue, Jun 21, 2022 at 1:32 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >>
> >> Hello Luiz,
> >>
> >> On 20.06.22 22:18, Luiz Augusto von Dentz wrote:
> >>> On Mon, Jun 20, 2022 at 3:06 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >>>> Disconnect of connection #1 being processed after new connection #2
> >>>> concluded sounds wrong. Would I be able to reconnect
> >>>> afterwards or would all connections, but the first, be directly
> >>>> disconnected...?
> >>>
> >>> That depends on the order you have queued the commands, it will be
> >>> processed in the exact order it is received, that why I said it is
> >>> single queue design, and it is done like that to prevent messing up
> >>> with states since we know the exact order the commands will be sent.
> >>>
> >>>>> otherwise we need a
> >>>>> different queue to handle command that abort/cancel other already in
> >>>>> the queue.
> >>>>
> >>>> Is the revert an acceptable interim solution or are there issues
> >>>> I am missing?
> >>>
> >>> Afaik there were problem with concurrent connections request, so what
> >>> would really help us here is to have some tests to emulate this
> >>> scenario with our CI, in the meantime please check if the following
> >>> fixes your problem:
> >>>
> >>> https://gist.github.com/Vudentz/b4fff292c7f4ad55ca3299fd5ab797ae
> >>
> >> Doesn't help unfortunately. First pairing works as before.
> >> Second still fails:
> >>
> >>   Bluetooth: hci0: Opcode 0x200d failed: -110
> >>   Bluetooth: hci0: request failed to create LE connection: err -110
> >
> > Can we try to add a test in mgmt-tester to reproduce the error above?
>
> I am not familiar with mgmt-tester. What information do you
> need to reproduce? In the meantime, can we revert the commit?
> I understand that this may break other uses, but I believe
> previously working stuff should have precedence..

Have a looks at:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/test-runner.txt

And then run with:

sudo tools/test-runner -k <pathyto/bzImage> -- tools/mgmt-tester

Btw, can we have the exact steps to reproduce it using bluetoothctl if possible?

> Cheers,
> Ahmad
>
> >
> >> Cheers,
> >> Ahmad
> >>
> >>>
> >>>> Cheers,
> >>>> Ahmad
> >>>>
> >>>>>
> >>>>>> We've been deploying the revert for a while now and I just posted
> >>>>>> it to the mailing list[1]. There have been other reports
> >>>>>> of this issue with different hardware too and fixing sent_cmd
> >>>>>> would likely be too complicated/time intensive for me.
> >>>>>>
> >>>>>> I am happy to test future patches that fix this properly though.
> >>>>>>
> >>>>>> [1]: https://lore.kernel.org/linux-bluetooth/20220616092418.738877-1-a.fatoum@pengutronix.de/T/#t
> >>>>>>
> >>>>>> Cheers,
> >>>>>> Ahmad
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>>>
> >>>>>>> Cheers,
> >>>>>>> Ahmad
> >>>>>>>
> >>>>>>
> >>>>>>
> >>>>>> --
> >>>>>> Pengutronix e.K.                           |                             |
> >>>>>> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> >>>>>> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> >>>>>> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> >>>>>
> >>>>>
> >>>>>
> >>>>
> >>>>
> >>>> --
> >>>> Pengutronix e.K.                           |                             |
> >>>> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> >>>> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> >>>> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> >>>
> >>>
> >>>
> >>
> >>
> >> --
> >> Pengutronix e.K.                           |                             |
> >> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> >> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> >> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> >
> >
> >
>
>
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |



-- 
Luiz Augusto von Dentz
