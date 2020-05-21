Return-Path: <SRS0=imY+=7D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC3CC433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 01:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B69392078C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 01:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kGKArYoW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgEUBHW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 May 2020 21:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgEUBHV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 May 2020 21:07:21 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5E8C061A0E
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2020 18:07:21 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id d191so4768413oib.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2020 18:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mt/UVpasxCKnOJ3EiOEy2VERgba+DlUPBaJMbAheIB0=;
        b=kGKArYoWqZyCaSJh4OnI33N5Ef7Snj56D8i4itn+vbsRBCTYSjKXnI4ORVVeGI4Arv
         cc56BVNDUfX/gxV8mNiOqMYGLjFePMvwJarkD8bmf0eGE+hHa99WPNePwyMHTllzEZUf
         VurZvSAoYRBsPSv6v+7RQxDFSggX/sy40p53A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mt/UVpasxCKnOJ3EiOEy2VERgba+DlUPBaJMbAheIB0=;
        b=pLtOqFpDx6OfqtviAumK9jIM/PdOyEelZblZJHZRNZxUL6qsYfaXWJDFNOb3WZzXBj
         JBgtHfIMBBueIh/9EKUTL5AX+V8EtAqsOi1LmPZwgpwxOmmQF1skuxOUiW+2xO9Xlwc+
         TveQi/h7CGVmGvC9okVtaQ1HISl5tDU0gxS9sbO4f3n2is4ZD4+GeJR9ijmnXZWF5urf
         IPwQBdLnqMNxWUXsJ9mCEWv6EGTz5IXHGVMynijWQNjEvukK/8es+qSVIkibW7gcU9C1
         L6dtJS298wslI1aTwHO87tbY2w2cBoe+o1DPl5jk72Apj8tN4jKtT47ZNT/C9SIVh2eF
         wQ8g==
X-Gm-Message-State: AOAM5304+F8GeRqpmNY8X49/zUjRrx5qrnoPjeUbE0DIqcm3dj642rMI
        vYb3BYdD/LoLGRXKt+EM/TEeOFKkdkK2kfdsrivOpw==
X-Google-Smtp-Source: ABdhPJwvkVFDgaOVc1+ZdJ9rgXvscsDEtPAyLaiQlXKdzKPFfY+J5vJGPHL/zDpDpuoIpnKMWzWXAFLhMmgYsT3Ep7I=
X-Received: by 2002:aca:d696:: with SMTP id n144mr5253340oig.136.1590023240225;
 Wed, 20 May 2020 18:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200401221320.12105-1-sonnysasaka@chromium.org>
 <6A574E50-BBF3-4967-9C93-6F4B6DAFB47D@holtmann.org> <CAO271m=Rqq7QS6R362xLQWjbo6_ZLYPo-ttvevJmjqJ73HbAVQ@mail.gmail.com>
 <68C2E4A8-29E0-44D8-9D2F-F4E2354DE419@holtmann.org> <CAOxioNkw8g90tVwQjqgdpX38__f17JHHTTsqBZwCjEkjME0Zyg@mail.gmail.com>
 <6C21A2C1-6224-4FB6-B483-27B1C89864BE@holtmann.org>
In-Reply-To: <6C21A2C1-6224-4FB6-B483-27B1C89864BE@holtmann.org>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Wed, 20 May 2020 18:07:07 -0700
Message-ID: <CAOxioN=zqg59Kmc4rSEaceDuHd9PnS1-iHLkdN2DrUF_y=-40Q@mail.gmail.com>
Subject: Re: [PATCH] device: Add device type property
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Eric Caruso <ejcaruso@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

I am okay with Types =3D ["le", "bredr"]. However, I don't understand
why a user should be able to change the Type, since this property
describes the fact about a peer device, not a local adapter. What does
it mean by a user changing the type of a peer device? Also, I don't
understand why HS needs to be considered in that property, since I see
org.bluez.Device1 objects as discovered devices either through Inquiry
(in which case it'd be "bredr") or Advertisement (in which case it'd
be "le"), or both. HS seems to be one of remote features rather than a
type. Also the HS information is also not readily available in the
struct btd_device, or even src/device.c, which suggests that it has
been treated differently.

On Tue, May 19, 2020 at 11:50 PM Marcel Holtmann <marcel@holtmann.org> wrot=
e:
>
> Hi Sonny,
>
> > After giving it more thought, I would like to propose that this
> > additional property corresponds with Device Type as defined in Generic
> > Access Profile:
> >
> > As stated in Bluetooth Core Specification Version 5.2, Vol 3, Part C
> > (Generic Access Profile):
> > This profile defines three device types based on the supported Core
> > Configurations as defined in [Vol 0] Part B, Section 3.1. The device
> > types are shown in Table 1.1:
> > * BR/EDR
> > * LE only
> > * BR/EDR/LE
> >
> > Therefore, to be as close to the spec as possible, I propose that the
> > property be named GAPDeviceType, and the possible values be "br/edr",
> > "le-only", "br/edr/le".
> >
> > What do you think? Thanks for reviewing this proposal!
>
> maybe we should do SupportedTypes =3D [=E2=80=9Cle=E2=80=9D, =E2=80=9Cbre=
dr=E2=80=9D, =E2=80=9Chs=E2=80=9D] since that also maps to what we expose i=
n MGMT. And then add a Types =3D [ .. ] property with the same values. I do=
n=E2=80=99t like using GAP in property names and repeating Device is also n=
ot needed since we are already in the Device interface. In addition I have =
a reservation with spec naming in this area since it has changed over time =
and there is a chance it might change again in future specs when new featur=
es come along.
>
> If you know the supported types of the hardware and the selected types, y=
ou can easily get to the GAP Device Type from the spec if you actually want=
 to show it. If you wanted to, you could make the Types property writeable =
as well and users could change their device type via D-Bus.
>
> Regards
>
> Marcel
>
