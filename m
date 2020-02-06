Return-Path: <SRS0=lv0E=32=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55EEC2D0B1
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Feb 2020 06:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D3B206CC
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Feb 2020 06:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgSTk0lZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgBFGIj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Feb 2020 01:08:39 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:41806 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgBFGIj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Feb 2020 01:08:39 -0500
Received: by mail-il1-f195.google.com with SMTP id f10so4071059ils.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Feb 2020 22:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1pOuLlixYPFJeM4kz7gczb3v+VO/yqCC/17xIPiZo+o=;
        b=VgSTk0lZENUByMCrTMnaOtlxCAKIwLacvCvxEGFE+q3tbQlDRb1VeEpmprA/r/+DJW
         d+lJ746c+FbBpTz7XfmoJZygKwy4Zo2Rvi1IN8LRh757uMrM49rKInoCsX9/H40P4vTy
         OcRDPDhoob2Vq/NdZ5USHPbhDdeiVBsHaXgVZk6q+PBq0WpzBrCuJPc3UTN+jXrpF/P/
         PRDusYR1wXLBHLv+M33zPOtCsfcTh0ALfAVniKe500gjJPcp3xSaIIp44jcrlwPJeX1z
         yW+rNJjF9AFBRXLkFp7x28rP/4TGhYNgS8ydYmEV8sq2rTcCGul8J3RqzUKtpiUBTjIf
         wRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1pOuLlixYPFJeM4kz7gczb3v+VO/yqCC/17xIPiZo+o=;
        b=JmBVKqF3SVlUuxB5rEyW3ciMao4nfe4ziaJg94gB0e552irXUMqlnrVuljuclX366A
         wu0SIA4CWR4rrYgB4cF6RD4f9MTiBn5SPG2LnFr3NROBXN/04DAzJklM84t7d0u2fAf+
         RV2OcPcb+GoPVr3LgzeLrxDrxQGHsV310kAxBul8XaAeeB5VG+5vUh9Z2UzN7IEu5ypE
         Oqad07rysD295dip5eeehdTLNNGodRPmbJF7kUHB8a4GUfw8FAr2GU+l+jh/m1kzTlFD
         M9g57M5H/xeuQuAEdlR9x0iyAJIdXfJy5nBem2S+CG0wQD8CNv+aM8K9L2W2xa2xFNaa
         d5vg==
X-Gm-Message-State: APjAAAVYA7s6jQP5B3br7eOADpnBDY0D/i4tBNoOeLJSuNyUsn5BuNc4
        74z7ghahdEEEtPgwvIOKb0MAVMpLbHiHZUWtDOI=
X-Google-Smtp-Source: APXvYqyRwHXa0PAszveLLYftlPmKA0PDKWd6wS+wLqMxh6xG5HsMR+R2O5BI9mBYj3cJTfRftZwvwChX0Fbu36lokpg=
X-Received: by 2002:a92:c14a:: with SMTP id b10mr2093935ilh.185.1580969318514;
 Wed, 05 Feb 2020 22:08:38 -0800 (PST)
MIME-Version: 1.0
References: <20191205083229.29890-1-sathish.narasimman@intel.com>
 <F7B49142-FD11-4512-B2D4-0840556FC0D3@holtmann.org> <CAMH2TCrF_tU5tu02v2et8DeQQjkOAnioHWLeDPEbk5p1MY_81Q@mail.gmail.com>
In-Reply-To: <CAMH2TCrF_tU5tu02v2et8DeQQjkOAnioHWLeDPEbk5p1MY_81Q@mail.gmail.com>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Thu, 6 Feb 2020 11:38:26 +0530
Message-ID: <CAOVXEJJLSpVcC_nUWTTPuVuY8EfkEv1dNeM5=DPXEpBH93o1Rw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] bluetooth:btusb: handle msbc audio over USB Endpoints
To:     chethan tn <chethantn@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        BlueZ devel list <linux-bluetooth@vger.kernel.org>,
        Sathish Narasimman <sathish.narasimman@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Hsin-Yu Chao <hychao@chromium.org>,
        Amit K Bag <amit.k.bag@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

gentle reminder.

On Mon, Jan 6, 2020 at 2:09 PM chethan tn <chethantn@gmail.com> wrote:
>
> Hi Marcel,
> >
> > Hi Sathish,
> >
> > > For msbc encoded audio stream over usb transport, btusb driver
> > > to be set to alternate settings 6 as per BT core spec 5.0. The
> > > type of air mode is used to differenting which alt setting to be
> > > used.
> > > The changes are made considering some discussion over the similar
> > > patch submitted earlier from Kuba Pawlak(link below)
> > > https://www.spinics.net/lists/linux-bluetooth/msg64577.html
> > >
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > > Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
> > > Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> > > Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
> > > Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> > > ---
> > > drivers/bluetooth/btusb.c | 157 +++++++++++++++++++++++++++++---------
> > > 1 file changed, 121 insertions(+), 36 deletions(-)
> >
> > I would really prefer to have some Tested-by lines from people that can verify that this patch works.
> The patch is verified on Chrome OS( 4.14 and 4.19 Chrome kernel) and
> Ubuntu with intel controllers. However it is always good to test with
> some other controller as well.
> >
> > Luiz, do we. Need to address further details for mSBC support?
> >
> > Regards
> >
> > Marcel
> >
> Thanks and Regards
> Chethan

Regards
Sathish N
