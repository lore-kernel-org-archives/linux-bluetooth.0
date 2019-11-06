Return-Path: <SRS0=igZI=Y6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C77BC5DF62
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Nov 2019 09:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A822187F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Nov 2019 09:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9wX7MHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfKFJmq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Nov 2019 04:42:46 -0500
Received: from mail-il1-f181.google.com ([209.85.166.181]:39007 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfKFJmq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Nov 2019 04:42:46 -0500
Received: by mail-il1-f181.google.com with SMTP id f201so15515385ilh.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Nov 2019 01:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uR5g/Q4J7Z7ZmAVkvCDymVefhoqI47BfU4KZAAIabek=;
        b=Y9wX7MHlCiRG/4nPgfvaPd92ZguoAcq80AfKeBsJDsHVLThF70VilyKNV4d4ceGZpX
         NoPwWdD+nnhr4RKH9QlX+Rf0M8BySwMCwOB16qrfh8Y3npvjLvOAS6wE82INqyN1MNQQ
         hvjFDUgOEtisI6CEpGAqSTLlJ8up3g9/+GXFBpc07pqw/1G+bXU8PjgYkSOMpePrCGPC
         F0cRMRwX8SOLbHqHLPgpz/Pq7H1CJwawVL7Fx8jJRMPKY5QujWJP8QzqOBJmGdvGd+Qb
         AW3jjDR39oQ2MSoHLSSoBXvoj5GyDpGIcNkaUtX58WeJEZzm/QXI11yBdNRIz8gJH/Az
         Fk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uR5g/Q4J7Z7ZmAVkvCDymVefhoqI47BfU4KZAAIabek=;
        b=AMDVQJZta4jCZGVOUkgeg0svLUHVOlnqNm1sKczNBq/sF1Q/uvqMjWr2uobsnX927A
         KYowZB1kJJpMoBy1IA/DgX1Ekjzl/fGiltbJsFjnfUl7fnHxY2MTDLU3gYKk2/5JBk2K
         pjJRWwmCBvUOSFKLzyEGoEUIXw+ROtKsKbrjPtYSzO9zy85d5aTSrn+PKjMBkoVdjZbm
         QkIYHuGAxF0i5EE7l4/eia5rDkCdiZNAw/h/Zj2FunI/Yr1KFi4ohseg9RfA+8kAKCzQ
         CHntOjFBiGmsZ6QJDSvUy1pO3v4wXzDdtNocasBwwgafCvwlr3zO+eTvwzLTwwMZLeJa
         WqAw==
X-Gm-Message-State: APjAAAUMhnPHX4MyJJD5GegIroHUbKPFjrdm3SfoqumJyXqIPeR05iyz
        Oldrk3yrRyGiUtBJzMeWso9AioZccbTrxudNNSylQ08TvqE=
X-Google-Smtp-Source: APXvYqyAZPOe4760SIOYawTnDkHMovAr+hF8oS8ia831cQ+nKxPAND3RpCexuRKjCPLazFM+QqJpXSg+9NMcK/GUXWk=
X-Received: by 2002:a92:5d49:: with SMTP id r70mr1694704ilb.257.1573033365601;
 Wed, 06 Nov 2019 01:42:45 -0800 (PST)
MIME-Version: 1.0
References: <CAOVXEJJ=dMe=f8R23JmC_idSV=gy1mmH4NSQTZUpmQPedjgBxw@mail.gmail.com>
 <CALevQMaR8C6-cGkkFrNO2B6MfSEo+rxq=6DHnJTBv39wwOW4VA@mail.gmail.com>
In-Reply-To: <CALevQMaR8C6-cGkkFrNO2B6MfSEo+rxq=6DHnJTBv39wwOW4VA@mail.gmail.com>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Wed, 6 Nov 2019 15:12:34 +0530
Message-ID: <CAOVXEJ+H2z2EuJ2BaehN-Z+nAiTELFHH9hc2Ym8MRNckVoL9Cg@mail.gmail.com>
Subject: Re: Bluez Compilation error for l_dbus_object_manager_enable arguments
To:     =?UTF-8?Q?Grzegorz_Ko=C5=82odziejczyk?= 
        <grzegorz.kolodziejczyk@codecoup.pl>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Grzegorz,

Sorry for the repeated question.
Now i am getting this error

make[1]: *** No rule to make target 'ell/strv.c', needed by
'ell/strv.lo'.  Stop.
Makefile:3625: recipe for target 'all' failed

I used version0.9 for isntallation
https://mirrors.edge.kernel.org/pub/linux/libs/ell/

Regards,
Sathish N

On Wed, Nov 6, 2019 at 2:32 PM Grzegorz Ko=C5=82odziejczyk
<grzegorz.kolodziejczyk@codecoup.pl> wrote:
>
> Hi,
>
> Please update ell library.
>
> Regards,
> Grzegorz
>
> =C5=9Br., 6 lis 2019 o 07:35 Sathish Narasimman <nsathish41@gmail.com> na=
pisa=C5=82(a):
> >
> > Hi,
> >
> > I am getting the below error for compiling the latest bluez
> >
> > tools/mesh-cfgclient.c:1690:7: error: too many arguments to function
> > =E2=80=98l_dbus_object_manager_enable=E2=80=99
> >  1690 |  if (!l_dbus_object_manager_enable(dbus, "/"))
> >
> >
> > Regards,
> > Sathish N
