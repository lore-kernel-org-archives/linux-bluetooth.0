Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA9CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jun 2022 21:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiFVVcP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jun 2022 17:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiFVVcN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jun 2022 17:32:13 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2FE13D39
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 14:32:12 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id q9so2948772ljp.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 14:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hqNzdMfM+efEyM3UCK0ToWnarRRL3BwN/oHoZRoNsBw=;
        b=kUXCyWmTasQZXooInHNWBGiknjTs9IhKSi9YfL4re/gxOPuI7v0s9rSK7siKAHOaic
         pKwcfd5cMYnm1Tc1aqkgpaCVbPLOOZNT2WtsibtY0agiWv7n2J9/nuOHu5qklxvnJSnw
         Wb8bDu6AMoy97Yr2jUad/CTcqwl7Vi13THIrzWEUNjz4EMdo7C8gG/rhVaE2hIqY4jzi
         7ImVegjsT9xuMiZ4Bn6G4Me8PRhzWbJi8cH8Ht65LT6oslgI/HZgWnws9y41B0ToO5xQ
         KilggD0E1fS6rSvNc7/MGe0yNHOfwOtf2noOA1iiZYeu+0cycYwAzGIKEEEACQu2kCEs
         eU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hqNzdMfM+efEyM3UCK0ToWnarRRL3BwN/oHoZRoNsBw=;
        b=DA51FXUiT4pI/nHZdzZKjHWbS2Set/K1ocunHNhH0JQxJCsvXk1PJ+2ZnvxuqJ8nG1
         WM2kt62e0EetkFgZoHcma2cb9mbahfkaRGqL58PIg99lkf2gDn0iTWcFGRLdxHbHKc1R
         z6g/YNd9Cqo909LYe22s79k2WRVmLyydXDNzD0PVzq24UNicRJkbesxiBPn0fmjMeYDW
         C8aMMoq8WzTCN6xrWiCwV/eUunQfzj/Q4jYHNXACzvxb36ug7Q6UNibOcI/TfTMDVekd
         Nx17AfixKhDHt9LOaBshfpvrV2amiNMKxviMg7qV0+4pRLuxhOCE3ufDmdrthxdjFll7
         vzhA==
X-Gm-Message-State: AJIora/fwMjJGSQuNtZgn1XlFSkU4ZzbdBWusGhbp/KcoVxUck+yCfXM
        X5znDJPrFVFEQw0ATN9NTs2XQACgEy4AuiNjIcui1Rb8JJU=
X-Google-Smtp-Source: AGRyM1sDV/YFKXyLCpbIVaAIDljIycqR+qEXlKNNMiElqH9ImZ5cppLOC46fEsZ5+PQoDNxQLFcxtHVCVCwec1kawCQ=
X-Received: by 2002:a2e:8449:0:b0:24f:4db3:f02e with SMTP id
 u9-20020a2e8449000000b0024f4db3f02emr2958917ljh.140.1655933530633; Wed, 22
 Jun 2022 14:32:10 -0700 (PDT)
MIME-Version: 1.0
References: <BN7PR04MB52674E1CAADA5B0550C3F6959FB39@BN7PR04MB5267.namprd04.prod.outlook.com>
 <CABBYNZLaPxBMvVXWx+yqQz-SyxptdMfEZ5TPQVP7q4otpcbErg@mail.gmail.com> <BN7PR04MB526737063784913B34568C009FB29@BN7PR04MB5267.namprd04.prod.outlook.com>
In-Reply-To: <BN7PR04MB526737063784913B34568C009FB29@BN7PR04MB5267.namprd04.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 22 Jun 2022 14:31:59 -0700
Message-ID: <CABBYNZ+Ak=U1UUmYvWwfGOMMQNBAFKpbNm_ZoUTcGvCw7EYxpQ@mail.gmail.com>
Subject: Re: third time
To:     Thomas Green <TGreen2@sorenson.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Thomas,

On Wed, Jun 22, 2022 at 2:22 PM Thomas Green <TGreen2@sorenson.com> wrote:
>
> Luiz,
>
> Thank you for your reply.  In my first two attempts I pasted into it the =
log file created by running:
>
> bluetoothd --experimental -debug -n
>
> The version of bluez is 5.50.  I looked at the patch you suggested and it=
's already included in this version of src/device.c
>
> Are there any further patches I should look at?  Would you like a copy of=
 my log again?

Ouch, that is quite an old version, have you considered using something new=
er?

> Tom
>
> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Tuesday, June 21, 2022 2:40 PM
> To: Thomas Green <TGreen2@Sorenson.com>
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: third time
>
> [EXTERNAL]
>
> Hi Thomas,
>
> On Tue, Jun 21, 2022 at 1:29 PM Thomas Green <TGreen2@sorenson.com> wrote=
:
> >
> > I've twice before written about this issue I'm having, but never heard =
anything back.  It regards a GATT device that connects and operates correct=
ly.  The issue is when we call the Adapter1.RemoveDevice method for this de=
vice.  Some times the device is removed completely, and everything works fi=
ne.  Some times it fails and bluetoothd becomes unusable.  Even when I shut=
down and restart bluetoothd it doesn't operate correctly when restarting.  =
The difference is that when it works, at the end of the removal process, it=
 reconnects the device, tries to recreate the device, then removes it.  All=
 internally.  When things fail, those steps don't happen.  I've posted befo=
re the salient part of the Bluetooth log.  The only thing that will make bl=
uetoothd function correctly is to shut it down, remove all of the similar G=
ATT devices, then restart bluetoothd.
> >
> > I have yet to hear if anyone has -any- idea regarding this, not even to=
 tell me it's not something that needs to be looked at.  It is something th=
at renders bluetoothd unusable, so I would think that it is something that =
might be interesting to look into.
> >
> > If anyone has any ideas where to look, or what might be going on, I'd
> > love to hear from you
>
> Do you have any logs? Also what version is this happening, perhaps you ar=
e missing some fixes like:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=3D5ebc2b5a3=
e48dbe67a2d315979b096a1b4d1eb99
>
> >
> > Tom Green
>
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
