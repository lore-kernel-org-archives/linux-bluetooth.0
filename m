Return-Path: <SRS0=7chU=YC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95566C47404
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Oct 2019 07:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C8F20B7C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Oct 2019 07:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WG1ti7eM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfJIHvn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Oct 2019 03:51:43 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:42650 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJIHvm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Oct 2019 03:51:42 -0400
Received: by mail-oi1-f169.google.com with SMTP id i185so961461oif.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Oct 2019 00:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CHKQW0azpOOEjd2MkM8uHfCgg4nBncmrX4OiehHbteo=;
        b=WG1ti7eMSGjb+rD2C1CO13dIHCuo530nzx2uZTOHoZXQlX80T08QBkqIRWRPK+0pMA
         KUKXLiQ35JrSF50gorPUiykqZs7eP7PVC3A0xLeYcLMUw02345+58igLrSHx7cqRdQEA
         z2ZfZ/+n3aGz51bXNdU7VagLww6UOqppE9z+8g2lvWE6vzo2gI7wHYnjIUUgjW/OIQRK
         dAX0yZKzyZwVCFScxKao+vxHGFhIWMVANOrL3UfOaWhyt2M+HS6ZwnRhP/crJPnyFj+a
         0xAnkNGnJ+BqWMCgET0XgQfDP46PDsqKjJZ7pQYdrEQHTr8JCpYUSSBh6pmMfvk4E8nD
         hvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CHKQW0azpOOEjd2MkM8uHfCgg4nBncmrX4OiehHbteo=;
        b=EZJQDcj9PPrpBjepquBEiWbdIqA0NExYIyVP6jRH9Alv/SUTxgxdqgtwJJ/LMAoet6
         hiwKZ7z96bmkWaqz1LI6m3LmP7sohQi02zsQNpWR107giCC/v3Fh/36g8Quv8+ztLEZ4
         TSpVJt1TCBJZDVb77ql9D2rWV7zbb1hdknDK7ZLJR0/T57kc7MH0DmpfVmPDO8Afy6dG
         KRQNFK44VbqQamNhuvJCBuPG/loh/gN4RLzDtvT+53qffOb4sgmdW9slXFbPMVDjzISk
         hfhqMNTDlLKFx7s/bITsYzveOc30Rz2bxZaVqbrqovb/O1L4/TPXpaPY9tZH0CmTXgh/
         PgzA==
X-Gm-Message-State: APjAAAWDRs2Zzn30Jdwb3jFe5YIP7hnY9byo47Ec3YGfRsqRDqz65I6c
        aL5DgXAlYI3hwPxEUwZD12nE5ndGBJorJROv+jqFna/sUGPg7w==
X-Google-Smtp-Source: APXvYqx90jadezZF/cabVdAmKTN6ubrs5+iGyFYhysQq/StjWj6ZPBIWuOI8dPmdrgObgA8UyAVHDpT9SFla6gDW9vE=
X-Received: by 2002:aca:1c03:: with SMTP id c3mr1159029oic.8.1570607501606;
 Wed, 09 Oct 2019 00:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ0=ZJ2rjxM0WmA72J5VCcUZ01q7dH+jxJi7btGzayZWHe7S1Q@mail.gmail.com>
 <CABBYNZ+DYrzhx3Riqt2SFV4ZoL5VHfOnVPH0ScHMRz=+XoBg6Q@mail.gmail.com> <CAJ0=ZJ1pD4dHZe98eZnZ6R-ZBazGip_mrPVV_XjFgThXM0Ebmg@mail.gmail.com>
In-Reply-To: <CAJ0=ZJ1pD4dHZe98eZnZ6R-ZBazGip_mrPVV_XjFgThXM0Ebmg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 9 Oct 2019 10:51:28 +0300
Message-ID: <CABBYNZLZFpq_aKpmWFG3mG9oEP7Ly4=5WbJHK3mqGsQgH8Da2g@mail.gmail.com>
Subject: Re: Bluez stopped connecting A2DP sink
To:     yayfortrees <yayfortrees@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Oct 9, 2019 at 1:56 AM yayfortrees <yayfortrees@gmail.com> wrote:
>
> Hello,
>
> I've attached btmon traces for 5.50 and 5.51. Thanks for taking a look!
>
> Let me know if you need anything else.

Must likely the following error has something to do with it:

= bluetoothd: a2dp-sink profile connect failed for 34:DF:2A:0D:F8:C2:
Device or resource busy

I will check why this could be happening.

> On Tue, Oct 8, 2019 at 4:24 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi,
> >
> > On Mon, Oct 7, 2019 at 10:34 PM yayfortrees <yayfortrees@gmail.com> wrote:
> > >
> > > Hello,
> > >
> > > I recently upgraded bluez to 5.51 from 5.50 and my headphones stopped
> > > using the A2DP sink during autoconnect. The headphones instead go to
> > > HSP/HFP mode and the A2DP sink is disabled in pavucontrol/pactl. The
> > > A2DP sink will only work when the device is initially paired.
> > >
> > > This had worked flawlessly for years. I was able to track down the
> > > regression to this patch:
> > > https://www.spinics.net/lists/linux-bluetooth/msg76180.html ([PATCH
> > > BlueZ] policy: Add logic to connect a Sink). If I apply the patch to
> > > 5.50, my headphones no longer connect to the A2DP sink, if I remove it
> > > the problem goes away.
> > >
> > > Not sure what else I should include to help track this down. The
> > > headphones I'm using are Beats Wireless (Solo Bluetooth).
> > >
> > > The only relevant log entry I see with the patch applied is:
> > > a2dp-sink profile connect failed for 34:DF:2A:0D:F8:C2: Device or resource busy
> >
> > Can you collect the HCI traces of the problem using btmon? I didn't
> > expect that to cause any problems, it should in theory solve them but
> > lets see.
> >
> > > Let me know if any other information is needed.
> > > Thanks.
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
