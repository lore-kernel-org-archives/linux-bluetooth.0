Return-Path: <SRS0=/JiD=VA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1303C0650E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 13:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7220E2187F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jul 2019 13:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYABkhmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbfGCN0u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:26:50 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43607 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGCN0t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jul 2019 09:26:49 -0400
Received: by mail-ot1-f65.google.com with SMTP id q10so2300437otk.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2019 06:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lptmGSbfjPOx7PVijeWMhM0iNIlgi2dVphQRrNWCQuw=;
        b=fYABkhmdtBqZlQdB0QqL4gc0hcCK+9wFeWul17EjbScVP/Hlr3XurjrFG17uCKN/qA
         9WIE7hGVBHVZSNqdwb/mf4kbtpqHTeAGeHcf0JlNr4H/qMot+7QqOHFGIMo/ieFEFjYY
         ic4qJDzYKengtZqsEn7GzFV2nkVQ0LS8rzvmYPSKrXN/fU7b4W9JgnANqOf41eSslNr4
         PfnmzlWW8SFGp1cTv5Opi5vkvu5vFSdx8S9Bjo68x/M6gCsJcOm7ont0Wi6dlP+jOmCy
         3CMghGMDMrEjY468ieMXtl4PpKCsVmJy/9XZpuFRgdz+iaiyXS35bKe6CRATEOP8+wGt
         ZVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lptmGSbfjPOx7PVijeWMhM0iNIlgi2dVphQRrNWCQuw=;
        b=jIEYOQjvKMGdsQ5hVW/4dNG6Wl9i1JE47klkh0otSiJ70YVjr6DxeZAyaGpJQjLRn/
         RI/DY2X3AEuCscGX2DurbaEaeCmctFvIEyQ1bIWVvgg7g9Xa1y0JwLnofTfnZ8Zc844J
         w4XKXikMPbT4stmVsWRclk2dDMCSwwz6NLoXfEuNAzjlt+k26x019Q12R90xUjXf2H9z
         1OOB0CCGJqo3mjVQxLZN/UXsXyWWidpU/zb71P88fg1KWoOCFJBRca7vsonXK4f3c10Z
         v83DwRKy+yW2d6XL9hZ/2te2GujI2zC8MVFdc1vQ7urH0xIjqxUOx+fulOLCGMb8/gky
         NFdg==
X-Gm-Message-State: APjAAAUUih5/zgOlgQu/JXi9ND7mw6OD5nK+EluEtB94kSHmkMUqD1cP
        38/6qVpek+RTSNcUH2LE6XxpM0dgIg0W5QuH0n8=
X-Google-Smtp-Source: APXvYqx7nGxMt1iVc5KUR8ZRcGQy1EODCihLeg82MQwZkYI/aWJ1AEwhLLE1Ajd0Z45xFUK2KWE7gD/iMVVGOKNse9U=
X-Received: by 2002:a9d:7003:: with SMTP id k3mr22005084otj.28.1562160409136;
 Wed, 03 Jul 2019 06:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190513170550.bsbr2mh7w36hj7io@pali> <20190607125800.trsx2o3njaiaitu2@pali>
 <CABBYNZLtgaCi5VGHapsKQG4iAC33ySow3AuH0Qkx8iCo3LcZDg@mail.gmail.com>
 <20190607153715.w5exsodd25qxc6xv@pali> <CABBYNZ+gPRkAgFAeeoSqZ7tp5fYimGdju9JSuSpn_kL+f9hJhQ@mail.gmail.com>
 <20190608105924.qmauvrwyz7nofx74@pali> <20190608111553.65s6yoyhmusmr3pc@pali>
 <20190622161837.37mjlsirpoql2plj@pali> <CABBYNZK-L0NfuR9Qq8Vj9Q7nxmgurzkimayJHSKV+kTJ7D_tUA@mail.gmail.com>
 <20190622170933.lxuftoxmvtv7ssfo@pali> <20190703125608.nl72umoinhg2kh6k@pali>
In-Reply-To: <20190703125608.nl72umoinhg2kh6k@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 3 Jul 2019 16:26:37 +0300
Message-ID: <CABBYNZL55sB=zG1zkHvTwmTJuSxHwEJ_a+9PjehVpW54tYe9BQ@mail.gmail.com>
Subject: Re: bluez - check for new a2dp features
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Wed, Jul 3, 2019 at 3:56 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrote=
:
>
> On Saturday 22 June 2019 19:09:33 Pali Roh=C3=A1r wrote:
> > On Saturday 22 June 2019 20:01:15 Luiz Augusto von Dentz wrote:
> > > Hi Pali,
> > >
> > > I think a better idea would be that we introduce something specific t=
o
> > > that, such as the SEID being returned so the next time around you may
> > > restore a SEID, this may actually make more sense perhaps if we reuse
> > > the RegisterApplication semantics:
> > >
> > > https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/doc/gatt-api.=
txt#n464
> > >
> > > That means it is no longer required to call RegisterEndpoint as many
> > > times as there are endpoints since that is time-consuming due to the
> > > D-Bus round trips, instead, the endpoint are discovered with the use
> > > of ObjectManager, if the method doesn't exist then you just fall back
> > > to the old mechanism since it might be an old daemon.
> >
> > Hi! If I understand it correctly, pulseaudio would register itself via
> > new dbus method and bluez daemon then discover A2DP SEP endpoints
> > automatically, right? And if that new dbus method does not exist
> > pulseaudio would know that in system is running old bluez version
> > without codec switching support. Seems it is perfectly fine solution.
>
> Hi Luiz! Do you have some patches ready for testing?

Not yet, will try to arrange time for implementing it next week.

--=20
Luiz Augusto von Dentz
