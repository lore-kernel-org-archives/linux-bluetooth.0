Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6E0C0015E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Aug 2023 17:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbjHKRMG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Aug 2023 13:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236599AbjHKRMG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Aug 2023 13:12:06 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA58E54
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Aug 2023 10:12:04 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so35097311fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Aug 2023 10:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691773923; x=1692378723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlyaKuwj2DFFxidP787empBBUtzACLvaTTNnrqR+Se0=;
        b=Wrq/oURPgVnyR8qktov2J5GfBHaQ/Kc/E0xg0ntNhhQyk0UaR+n8FOSBfn7ACaloLg
         LigwbXITuMCvLyyidiJRNQWTq34rDqR0MQSK4iyeoxSI4hdjRqUq/pi9/COzO0OVikJR
         W11rOCOuPmzmr/50cuI7HL51CvuhWJ3ic/SaLzMwc+bUTBvQS9/+t2PynjrC5fAWawMi
         51amxgoJlunl/ssJiZAgE6k1BXp5hOQBPh58hnP+ROYFtCcsXLTRf+P88Rr4SpBXl984
         7M4RikX1KZHlOnH3oJOQQt2lOWjbl8V0lVCNjaOoOYyoj2+wXh55jwZJ9rutc8Jz/url
         eXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691773923; x=1692378723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SlyaKuwj2DFFxidP787empBBUtzACLvaTTNnrqR+Se0=;
        b=PjNs/CJEGFaJ7wLJYel+jFuHLOC+JwNMVxvg2Cjm+VRFrpDw4WDc1Es+3pssT8shmh
         31lMEg/+r5cv5VnK7DEDWFO8fKyUtxdmJiAPF99e7f8bVvoay5eUfgWkqOKi+LPe8Vev
         sFwLvpf9zgHeW4sAxB71XvRG2A/xRmeSe9yr24tyHRXFSAvnT/4rjBduARuqTtN4ylYO
         SnfvZnMnqn/t7GyjVV7LWwSNnUFfA98vsFpAcZ7ThXKh4+hAf5VWhFwkLC+TcsI6WEVd
         pibDORGmBVV0nWVaWkyILoolnmHWcAZAZm0Kbq+36YhkkzsdlgmEVMQMKq47qor79GCf
         kJ6Q==
X-Gm-Message-State: AOJu0Yxdz2CAtLny8vmRB8cvPQOgpjC7pwgICDE4X6/W6JtAkfVy9l4S
        /kUXYkR1x7MFlwaDxS950J6DbaVJyTnPCx0hwrU=
X-Google-Smtp-Source: AGHT+IHcdcO2UJfxUcpxWpL8WCWyLnjAGZQJonFoYsxnrR8wAfX/cWIF0NTB2hX+3vOEKVdDhL5jRJ33xn1VoJkOoWo=
X-Received: by 2002:a2e:3604:0:b0:2b6:e196:68c4 with SMTP id
 d4-20020a2e3604000000b002b6e19668c4mr2076868lja.39.1691773922513; Fri, 11 Aug
 2023 10:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <2300626.ElGaqSPkdT@bruno-beit> <47e6ab77-e1dd-4ede-b75d-f484b2593395@molgen.mpg.de>
 <5706628.DvuYhMxLoT@bruno-beit>
In-Reply-To: <5706628.DvuYhMxLoT@bruno-beit>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 11 Aug 2023 10:11:50 -0700
Message-ID: <CABBYNZ+Nt3Rho2=VtVrspRLond2agnKhT1LmeLCGdY4fdxmusg@mail.gmail.com>
Subject: Re: regression: kernel 6.4.x breaks scanning/pairing (but not use) of
 LE devices
To:     Bruno Pitrus <brunopitrus@hotmail.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Takashi Iwai <tiwai@suse.de>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bruno,

On Fri, Aug 11, 2023 at 4:25=E2=80=AFAM Bruno Pitrus <brunopitrus@hotmail.c=
om> wrote:
>
> Dnia sobota, 5 sierpnia 2023 09:31:08 CEST Paul Menzel pisze:
> > [Cc: +regressions@]
> >
> > #regzbot introduced v6.3.9..v6.4.2
> >
> > Dear Bruno,
> >
> >
> > Thank you for your report.
> >
> > Am 04.08.23 um 20:55 schrieb Bruno Pitrus:
> > > I am using openSUSE Tumbleweed on a Dell Precision 3551 which has a
> > > bluetooth adapter of ID 8087:0026 (Intel AX201). I am using a
> > > Logitech M575 trackball mouse which only supports Bluetooth LE.
> > >
> > > With kernel 6.4.2 or newer, scanning for devices =E2=80=94 using eith=
er the
> > > KDE gui or bluetoothctl =E2=80=94 most of the time returns only =E2=
=80=9Cclassic
> > > bluetooth=E2=80=9D devices like computers and phones, and not the mou=
se. If
> > > the mouse was paired before, it works correctly however.
> > >
> > > With previous kernel versions (6.3.9 and before), pairing the mouse
> > > worked correctly.
> >
> > Are you able to bisect the regression? Please also attach the Linux
> > messages. (You can also create a ticket in the Linux kernel Bugzilla [1=
]
> > and attach everything there.)
> >
> >
> > Kind regards,
> >
> > Paul
> >
> >
> > [1]: https://bugzilla.kernel.org/
> >
>
> The offending commit is https://github.com/SUSE/kernel/commit/288c90224ee=
c55d13e786844b7954ef060752089 :
>
> > Bluetooth: Enable all supported LE PHY by default
> > This enables 2M and Coded PHY by default if they are marked as supporte=
d
> > in the LE features bits.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Do you have the btmon/HCI traces showing this, we also need the
firmware version as well since I suspect this is due to the controller
setting the PHYs as supported but being unable to to use them
properly.

--=20
Luiz Augusto von Dentz
