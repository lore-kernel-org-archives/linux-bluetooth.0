Return-Path: <SRS0=lLJx=YD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE3BC10F14
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Oct 2019 08:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9057820B7C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Oct 2019 08:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQ/ubQqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733112AbfJJIKH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Oct 2019 04:10:07 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:36906 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732947AbfJJIKH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Oct 2019 04:10:07 -0400
Received: by mail-ot1-f41.google.com with SMTP id k32so4107487otc.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Oct 2019 01:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=61qcfevCTHs8XM2o7bTZAGn624lWyajTVzCkdhDU5LM=;
        b=DQ/ubQqAY4h4K812zAwMkd0NurtzmhEdQAf0xJqrPWYuLbPqch4nKIo76GkvLTCm/p
         FTqi8Wc96pfIApmEpJxdAjJhsltiQPxn/8eezMbn+xV4ub5tqbrwQiC7S/ASOUKKzcPd
         VO00J3QCaTGmgxjhFJqyr+9jGTcaZlzdxFhg5ZvKCXmD9Fep0NoVdVtWNM725LuZYAPr
         1Ora5bRzAZ4VF78ElCTxAeUglTZ5Ch1dG69RPvRyKahvx8Pyth1EQZqeWv2dLoE7qqu0
         6EVqDTMDvjCx8yQ4uiNlbbDRhYq2bQeSSVNeqxeUP3TzVTxfjWCkBqsp7f4qWz1mSItf
         zOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=61qcfevCTHs8XM2o7bTZAGn624lWyajTVzCkdhDU5LM=;
        b=fiO7UcFzy/6+yRTKikaTfxj2Maj6gXF+g7vQqCqGzMFEgclODI2jSlOJlWx0xlx+kG
         DN8yssu2pSlnC7hS4hzRSe4RBR6cx9Z9z3g84rrxxMX2LpFbiCP654P93wvA+kMk1NoT
         umen7FNiPzjro5p4yFortaj36/q+WgH1FS9uOMjz+MKr6yILQhTfPIacTvwbaqTE0/R9
         tkaLtxOc4nylQ8UjF31KYGaj14WzXnPMRoMu/HAUZXDLX76919RguhsNGiug7Ldat9oM
         FI2v6KJyYiyqU1AuDnPA8kZ4V2wwKzarHLG2SshPBFHDOeVLLYz6IohDXoLLRwVzvL81
         577g==
X-Gm-Message-State: APjAAAXaBwAe+133GXBFTSTp2TH+Du2EKs5z8Jt7Q7pxNyozMh1aidAC
        QPTKzhTUbwU3Pk35jI9LV/lWzqZqZxI9Ael0r74=
X-Google-Smtp-Source: APXvYqypWLi+c4JqjKHx6J6OUyZPX7qy697i7PaPjAUtTBAY1pEzYjqlYInTFSmjFz4WdWGd8mG6Q+v6R7otkS3NBKg=
X-Received: by 2002:a9d:5c0e:: with SMTP id o14mr7015849otk.79.1570695004359;
 Thu, 10 Oct 2019 01:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ0=ZJ2rjxM0WmA72J5VCcUZ01q7dH+jxJi7btGzayZWHe7S1Q@mail.gmail.com>
 <CABBYNZ+DYrzhx3Riqt2SFV4ZoL5VHfOnVPH0ScHMRz=+XoBg6Q@mail.gmail.com>
 <CAJ0=ZJ1pD4dHZe98eZnZ6R-ZBazGip_mrPVV_XjFgThXM0Ebmg@mail.gmail.com> <CABBYNZLZFpq_aKpmWFG3mG9oEP7Ly4=5WbJHK3mqGsQgH8Da2g@mail.gmail.com>
In-Reply-To: <CABBYNZLZFpq_aKpmWFG3mG9oEP7Ly4=5WbJHK3mqGsQgH8Da2g@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 10 Oct 2019 11:09:52 +0300
Message-ID: <CABBYNZ+GhHtnDi-FCu0N2xoEc_0eTtPMsW+N+GMM6S7buy1-Xw@mail.gmail.com>
Subject: Re: Bluez stopped connecting A2DP sink
To:     yayfortrees <yayfortrees@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Oct 9, 2019 at 10:51 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi,
>
> On Wed, Oct 9, 2019 at 1:56 AM yayfortrees <yayfortrees@gmail.com> wrote:
> >
> > Hello,
> >
> > I've attached btmon traces for 5.50 and 5.51. Thanks for taking a look!
> >
> > Let me know if you need anything else.
>
> Must likely the following error has something to do with it:
>
> = bluetoothd: a2dp-sink profile connect failed for 34:DF:2A:0D:F8:C2:
> Device or resource busy
>
> I will check why this could be happening.

I tried this one and couldn't reproduce with the headsets I have,
could you please run bluetooth -dn and attach the logs here?

> > On Tue, Oct 8, 2019 at 4:24 AM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > On Mon, Oct 7, 2019 at 10:34 PM yayfortrees <yayfortrees@gmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > I recently upgraded bluez to 5.51 from 5.50 and my headphones stopped
> > > > using the A2DP sink during autoconnect. The headphones instead go to
> > > > HSP/HFP mode and the A2DP sink is disabled in pavucontrol/pactl. The
> > > > A2DP sink will only work when the device is initially paired.
> > > >
> > > > This had worked flawlessly for years. I was able to track down the
> > > > regression to this patch:
> > > > https://www.spinics.net/lists/linux-bluetooth/msg76180.html ([PATCH
> > > > BlueZ] policy: Add logic to connect a Sink). If I apply the patch to
> > > > 5.50, my headphones no longer connect to the A2DP sink, if I remove it
> > > > the problem goes away.
> > > >
> > > > Not sure what else I should include to help track this down. The
> > > > headphones I'm using are Beats Wireless (Solo Bluetooth).
> > > >
> > > > The only relevant log entry I see with the patch applied is:
> > > > a2dp-sink profile connect failed for 34:DF:2A:0D:F8:C2: Device or resource busy
> > >
> > > Can you collect the HCI traces of the problem using btmon? I didn't
> > > expect that to cause any problems, it should in theory solve them but
> > > lets see.
> > >
> > > > Let me know if any other information is needed.
> > > > Thanks.
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
