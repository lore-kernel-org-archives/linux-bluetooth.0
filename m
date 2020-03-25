Return-Path: <SRS0=+pQP=5K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A2BC2D0E5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 21:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97C820775
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Mar 2020 21:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IOZ6qTTx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgCYVuJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Mar 2020 17:50:09 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36460 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgCYVuJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Mar 2020 17:50:09 -0400
Received: by mail-vs1-f67.google.com with SMTP id 184so1808048vsu.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2020 14:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rpR9+T3RReClSmfYyE7a8wj2FfC9QbmE6XN0tqKV2Ns=;
        b=IOZ6qTTxOL5Mfm6yZusp8ofausGOd/LDrl6K7o0cdoMkNTJVdukFetDQZlmAvPLei4
         Y1j73duEjmfkVghADFMqv1wp4oKcUvKEOHHV5soGAhwjFEfdkYPWvW/a/9A+kNBs1u1D
         /l8TgWp2OE2IdkFNK3he4XDO6FAdetVYgHiKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rpR9+T3RReClSmfYyE7a8wj2FfC9QbmE6XN0tqKV2Ns=;
        b=KQc0vd3z2SP2mI8Ne3rfYQM9+SCYWVm4E9hfxME0poZmZJhA/z1NvmIbahJJoRp+vh
         R/dcj28ctYs6xv12d7vKTKAeyYZ83nDi1TN5QAV6d4IG8Iopy9w9TxUeSxYBkkt3eTMu
         Lq2WFTIV7azkqaFPjzY42K29Osg0Jh/u4JJ5DTehJv4BljegHn0LqImQZPxZqpsGaS2Z
         fKZH1MCeJgZ1cCmsmGAlET5+ranrIx3hN1c54TtGNf5q/15Ha6YDQMKYEHb5H0nsgUAv
         bZkPt/9E08FO1/XtkXa/nlz1AsZM2+0b/ie1fIdhDckZ+Ts1vpYQ9UnFMdj5hqkoXoKw
         3bNg==
X-Gm-Message-State: ANhLgQ0bcOAedr27VItT5ROUVjfakg4459GYPKb9s5nXU9sXBtyphOx+
        nEu+RRDA+zqH+4/AE18evDGY8q3Tad+K8rNL/jI1oQ==
X-Google-Smtp-Source: ADFU+vsVL616Xs43eHLh8VpHqW3BX36bGSFzmg0pd05k0w+SZX/3vxBuouVbPLd+gDP0OSndl3/ldwjf33TgBxa4DyA=
X-Received: by 2002:a67:d086:: with SMTP id s6mr4303004vsi.93.1585173007888;
 Wed, 25 Mar 2020 14:50:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200320015023.85896-1-abhishekpandit@chromium.org>
 <20200319185000.BlueZ.v4.1.Idb4f0444e40064a861ee73b098264abd30114aaa@changeid>
 <E2FD0076-97EC-4CF6-B8D6-D7E4087459F6@holtmann.org>
In-Reply-To: <E2FD0076-97EC-4CF6-B8D6-D7E4087459F6@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Wed, 25 Mar 2020 14:49:57 -0700
Message-ID: <CANFp7mXyY9GrTy9G=9k8yoDKx6_A9P-_AB2cCr0EvdsJi_MWiA@mail.gmail.com>
Subject: Re: [BlueZ PATCH v4 1/5] mgmt: Update docs for Add Device
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Alain Michaud <alainm@chromium.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, Mar 25, 2020 at 2:25 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Abhishek,
>
> > Update the docs for Add Device with information on flags mask and value.
> > Add information on the Wakeable flag that can be set to allow the device
> > to wake the system from suspend.
> > ---
> >
> > Changes in v4:
> > * Newly added support in Add Device for flags
> >
> > Changes in v3: None
> > Changes in v2: None
> >
> > doc/mgmt-api.txt | 12 ++++++++++++
> > 1 file changed, 12 insertions(+)
> >
> > diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> > index 27a41f334..e99c23710 100644
> > --- a/doc/mgmt-api.txt
> > +++ b/doc/mgmt-api.txt
> > @@ -1997,6 +1997,8 @@ Add Device Command
> >       Command Parameters:     Address (6 Octets)
> >                               Address_Type (1 Octet)
> >                               Action (1 Octet)
> > +                             Flags Mask (1 Octet)
> > +                             Flags Value (1 Octet)
>
> so we can actually not do that. This is not backwards compatible since the current kernel version have a strict size check for the command parameter size of Add Device.
>
> Is there a problem to just introduce action 3 as I mentioned before?

How does one mark the device as not wake capable? (if 0x3 means mark
the device as wake capable, should we add 0x4 meaning mark the device
as not wake capable)
Does a device need to have been already added to be marked wake
capable? (Answer should probably be no)

If you're ok with adding new actions 0x3 and 0x4 and making them not
imply 0x1 as well (LE always sets 0x2 so overwriting the value doesn't
make sense), I think that will work.

>
> Regards
>
> Marcel
>
