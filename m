Return-Path: <SRS0=R8GA=23=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563D6C32771
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jan 2020 08:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 265B621734
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jan 2020 08:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGdNHOSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgAFIjO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Jan 2020 03:39:14 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41196 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgAFIjO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Jan 2020 03:39:14 -0500
Received: by mail-ot1-f68.google.com with SMTP id r27so70720115otc.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Jan 2020 00:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WEfAEo08brNYui5UZ+GMWgYlt0uO9PrXJcaXnTsNcnE=;
        b=MGdNHOSSUuIDcS5n1ALtMwpeHbHGJ6UULKWFQRRwWP7E2vzviobXg0EqU7aIJ8Zpf7
         0Oymx6eaYHxUoGxZRRP4QZyZfBw4XNdGnMem7NIYIR8RYNlDXIiHZL/O0Ac1SpuSl8i+
         PYq+DbeUbMSOMnNDhxqD887aOb5YV/ZugG8leK59qGfY5i0gLHR75A/ZZU4PjqqT6r0p
         vn/AvsR293pXEK5YlR5cAoLYV41rstIFTes2S2+GV4UbsKnAXk6H4o3ITD0fC97UXb8s
         glVCyw9MWi5hNjx6/8H3efL7IPl+A4JzYsGP40uIxhfpqAv+Q3pR+bQvSwOvZCWC8bgg
         DPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WEfAEo08brNYui5UZ+GMWgYlt0uO9PrXJcaXnTsNcnE=;
        b=EPIx4Rk0zfNfaQP38HHlESI4Ran6g5gt+fV5vnCNUGSxwEMho55cbN6+rGKY/xiNKA
         UCDsQf59vvhZHmG6lNSzVaN7iXDjujuUVW3dRRQ74i3hzIE/Li2i8/lCWs5qT/QJbGEM
         0LQH1Eu9yUPSSTCFMT7uyJXVxChufvGVjnHhYrvw+29mtxc9ky9pcIBBZ4rrlaT2sMIx
         W7JFwHXEJaZKlWLpis2VDxsvVTbBO8vHKsiJOLw4qJi7C1j0ppTp//PGzPkpZJudOql7
         UgRp9gUMHkYTRZalEY9+3wIwKnTWdVS6HQMiMTLnFwyUiJQzZoL5R/XYQ6hlYZeC81Ud
         lLKw==
X-Gm-Message-State: APjAAAUf+lHBaZi7mUkfbxrULR8Nur7+qeSl++b5dFhQfHhg49qieV9a
        J3++TjlC/l2nehcdLQXUcNBo/8Yl7M35nhtdAmiimewI
X-Google-Smtp-Source: APXvYqwSnp1lSl6dLgKzhDN/Th5WB772mupi1Xia8WLFkJq7F/PoUt/fQwgQLXepTwlGdZaf54rGvgpG8nBlGxUYZSQ=
X-Received: by 2002:a9d:65cb:: with SMTP id z11mr91299097oth.348.1578299953748;
 Mon, 06 Jan 2020 00:39:13 -0800 (PST)
MIME-Version: 1.0
References: <20191205083229.29890-1-sathish.narasimman@intel.com> <F7B49142-FD11-4512-B2D4-0840556FC0D3@holtmann.org>
In-Reply-To: <F7B49142-FD11-4512-B2D4-0840556FC0D3@holtmann.org>
From:   chethan tn <chethantn@gmail.com>
Date:   Mon, 6 Jan 2020 14:09:02 +0530
Message-ID: <CAMH2TCrF_tU5tu02v2et8DeQQjkOAnioHWLeDPEbk5p1MY_81Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] bluetooth:btusb: handle msbc audio over USB Endpoints
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Sathish Narsimman <nsathish41@gmail.com>,
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

Hi Marcel,
>
> Hi Sathish,
>
> > For msbc encoded audio stream over usb transport, btusb driver
> > to be set to alternate settings 6 as per BT core spec 5.0. The
> > type of air mode is used to differenting which alt setting to be
> > used.
> > The changes are made considering some discussion over the similar
> > patch submitted earlier from Kuba Pawlak(link below)
> > https://www.spinics.net/lists/linux-bluetooth/msg64577.html
> >
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
> > Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> > Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
> > Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> > ---
> > drivers/bluetooth/btusb.c | 157 +++++++++++++++++++++++++++++---------
> > 1 file changed, 121 insertions(+), 36 deletions(-)
>
> I would really prefer to have some Tested-by lines from people that can verify that this patch works.
The patch is verified on Chrome OS( 4.14 and 4.19 Chrome kernel) and
Ubuntu with intel controllers. However it is always good to test with
some other controller as well.
>
> Luiz, do we. Need to address further details for mSBC support?
>
> Regards
>
> Marcel
>
Thanks and Regards
Chethan
