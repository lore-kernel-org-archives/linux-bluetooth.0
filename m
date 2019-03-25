Return-Path: <SRS0=CZwu=R4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3978C43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Mar 2019 13:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9E320830
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Mar 2019 13:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hR5/H8oe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731262AbfCYNBM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:01:12 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:41242 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731158AbfCYNBM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Mar 2019 09:01:12 -0400
Received: by mail-pf1-f172.google.com with SMTP id 188so935168pfd.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2019 06:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PIIuhvdBzp9+lsV/dC06he6ZWvSx6ZcpPEczA6Ql32Q=;
        b=hR5/H8oes95k0gF5zFS9Rt0C0HBdUDt8Y1c2Q7iIOPG0bkmeoKJO3wULo2JMB+xQm3
         QH6l+zUGQzvD4nhWTWSM4K4mWxAFX8MhthRPSl8fVkj3I20V2sesG/Nq12nQYvyxzWmR
         qtBh3+LjBk5ZX0XUUiDPN/uzvt7Q75sSjHW3m8O2uWPY9RZ3TpyRKCW0L1mtidFfWT27
         cioWPxCCQTavxkEJk+SqtGPbT7bPajrUDoyAuOuWyeQhGe2x6n0HxjZigWmwqXPVCIe4
         LDXaMKrdOY/DB6L12vFNvY54iQFl5TbWTs8TBhWvDZ9LtsP9QGDakC1OJ+lYMA2TE44w
         58IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PIIuhvdBzp9+lsV/dC06he6ZWvSx6ZcpPEczA6Ql32Q=;
        b=G+G8ZataVcoH0x5ntgnq2a9ogA9T5wkXbSHp0JKmPTi77WRKHfUDMwFGcWE8NXK1N5
         qpVji8oCywzzJo3J76Akpyxcn/0+kBgSzXWeHTvTvgD8oMr3Aq7ptvsDpIvk5FOiTeNQ
         mu84ACh6uiDcLTG8JZUaqFtMqae1hw1ms92lic7+3jaSP8neuGNC0750W3AL4Lxtwcfw
         AOZrXLuU3ADbXulpiAlo5If6krBwnRC+cd5DofWaGtJYetTiGIoGjEGtqZUhzH0iV1OH
         NwvEj48VMApPjadUdRo9F1xOnqZC9RLMlaw/EkMTSYT1pFmcYW8cq1JzA2ytzjX28G03
         iXLg==
X-Gm-Message-State: APjAAAVOvV4FI11hlUzYhhlJErwnuGlT8rfiHyudaee0BrJ7foys7h2U
        0UyccmmxvpUIlI/l4aGmw9j+z1BL4l294kVTY2A=
X-Google-Smtp-Source: APXvYqxCecDhUTjZCQz2fR+qOjWDhOYjysE+/9YpD4dMT/2RvruAHuVCpQC/N0pVFdoldXAgwcoUNR19+sdjLOAo/z0=
X-Received: by 2002:a17:902:be18:: with SMTP id r24mr2541309pls.69.1553518871400;
 Mon, 25 Mar 2019 06:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <CABLzjm-SLs_AzgS2S=3ogN=P9Jk9OjBuSMaNFTpXawrAsNfe+g@mail.gmail.com>
 <CAO1O6sfDYV9q5z2b64SS1MDSuXUYS6fvxQWc00NsX_1qLxEorQ@mail.gmail.com> <CABLzjm_jO8=vVjSosWh=PjLpoeZuY8BSYPkSxKwomY4AYBPLGA@mail.gmail.com>
In-Reply-To: <CABLzjm_jO8=vVjSosWh=PjLpoeZuY8BSYPkSxKwomY4AYBPLGA@mail.gmail.com>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Mon, 25 Mar 2019 14:01:00 +0100
Message-ID: <CAO1O6sdC8fuFjAh5J-O-qjcaaaft8WfepKLFgXQZpAf-TKkXQQ@mail.gmail.com>
Subject: Re: Information about HCI LE Rand command
To:     Alexandre Augusto <alexandre.a.giron@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Den m=C3=A5n 25 mars 2019 kl 13:40 skrev Alexandre Augusto
<alexandre.a.giron@gmail.com>:
>
> Thanks Emil.
>
> The reason I asked is that I am researching ways to provide that
> "minimum entropy required", and I was not able to find details about
> the number generation.
>
> Best regards,
> Alexandre Giron
>
> Em seg, 25 de mar de 2019 =C3=A0s 09:23, Emil Lenngren
> <emil.lenngren@gmail.com> escreveu:
> >
> > Hi Alexandre,
> >
> > Den m=C3=A5n 25 mars 2019 kl 13:03 skrev Alexandre Augusto
> > <alexandre.a.giron@gmail.com>:
> > >
> > > Hello,
> > >
> > > I would like to know, if possible, information about the bluez LE Ran=
d
> > > command (ocf 0x0018) at HCI code. How does it generate the number? Is
> > > it vendor-specific (or secret)?
> >
> > According to the Bluetooth core specification, it shall be a "A pseudo
> > random number generator compliant with [FIPS PUB 140-2]
> > (http://csrc.nist.gov/publications/fips/fips140-2/fips1402annexc.pdf)"
> > which shall be seeded "with at least the minimum entropy required by
> > the pseudo random number generator". What algorithm each Bluetooth
> > controller actually uses is therefore vendor specific. I guess most
> > controllers will use some SHA-based or AES-based algorithm. Note that
> > it is not the host (BlueZ) that generates the number; it just asks the
> > controller to generate it for the host.
> >
> > /Emil

I'm a aware of two different vendors. One vendor has a hardware-based
random number generator based on thermal inner noise that is used to
feed the CSPRNG
(https://www.nordicsemi.com/DocLib/Content/Product_Spec/nRF52810/latest/rng=
).
The other vendor uses the radio to gather enough random bits from the
air.

/Emil
