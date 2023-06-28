Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08231EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jun 2023 19:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjF1TlE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jun 2023 15:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjF1TlC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jun 2023 15:41:02 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5862194
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 12:40:58 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b698dd515dso3015411fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 12:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687981257; x=1690573257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIcq79lRqvkoj1gnPc1yfiujt7ezRZNZUGkIpsEg580=;
        b=mMJCF8+uCYxrXBJDls/iuxXdcFv0Lw15X+uc8VrjOzDgS7hoFRZi4KwPPM/w5BhpI7
         I1L5LBLRl07+tsLKAQXaPqyd69sFRIpZOf4/0CMhWY7x+iZshS4E1CFk9KEq4L8zurZ0
         qvbA3n4ENBvVr6a6hv9Lv5eqDiCyQjBjgLQo+HZbjAYcWHlCADjxsewCmwR2N6qRt+bo
         L+4Ex6TlMKCskKlTefJi0Szm1gWlrR7s4aOVE9Z8O65Vnafp3/b9XEl9xFC9GogwBGJx
         dN8YNeOzRZsUuMAdMBhqGA7kZCmQctOxdc3EmpNOXcFGgoyOqy6KTZmXFhDplVCbZJe0
         YahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687981257; x=1690573257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EIcq79lRqvkoj1gnPc1yfiujt7ezRZNZUGkIpsEg580=;
        b=YVM/TmM9xIACSuB7/YgTfb40kU9i6BRl/PMIbItiHfXixgAKETlw4M0Xh+W1DpMbl5
         UU0+Q9gLciCBeQQKrs/+3B/On46guAdDPxXRvi/e7FbaCuqbti5YawbXk0mJ3xhw4KRR
         z8F2z3yJWe5wIotlzJdX8HoMLaaEqYvp3ZxZcsbSbob4/eliiafiWFw/nmsy9iTrc/ZV
         Ujd6y4otgOPyerfQb2DZCRliQV8lQamMDNm4fyWY+xbgxuJLYFvvYfOw68jE7WS5KlJC
         Cc6qYBJBOEb2SK+3KSFrUv5JWovsbSUfPAS2gI20CsJKtdFYitVjbUAzHZCjGIdvJ18V
         eYmg==
X-Gm-Message-State: AC+VfDyqtJmgdGp9UB2j1OjIqugc4HH2iOlrMEYdPkCnY1GQXRGL0SgO
        D3QwORt6oMSPEXJVdz6gz6BfZpRUNEWd6oe65VE=
X-Google-Smtp-Source: ACHHUZ7p/vo3wUdtI+GXadL6zxWoRm7QOOkSlp4/D0JaVMNiODFkffXHk36PwiZuLhlWmOamxhBJyioms0YDx8/jZu4=
X-Received: by 2002:a2e:94c7:0:b0:2b6:bc30:7254 with SMTP id
 r7-20020a2e94c7000000b002b6bc307254mr2113023ljh.13.1687981256680; Wed, 28 Jun
 2023 12:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230628113934.824668-1-kiran.k@intel.com> <2a43ecd8-faf5-11f7-1a01-c114aa16354b@molgen.mpg.de>
 <PH0PR11MB758555E584EC6C8691133565F524A@PH0PR11MB7585.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB758555E584EC6C8691133565F524A@PH0PR11MB7585.namprd11.prod.outlook.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 28 Jun 2023 12:40:43 -0700
Message-ID: <CABBYNZJv=PHS5uiD7r1Wzgt4XC04dvjGpnAAH5gK-o15Y958LQ@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btintel: Add support for GalePeak
To:     "K, Kiran" <kiran.k@intel.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

On Wed, Jun 28, 2023 at 4:57=E2=80=AFAM K, Kiran <kiran.k@intel.com> wrote:
>
> Hi Paul,
>
> Thanks for the comments.
>
> >
> > Dear Kiran,
> >
> >
> > Thank you for your patch.
> >
> > Am 28.06.23 um 13:39 schrieb Kiran K:
> > > Hardware variant for GalePeak core (CNVi) is added.
> >
> > The code names are officially spelled with a space, I believe: Gale Pea=
k.
> >
> > Maybe also mention 0x1c.
>
> I will fix it in V2 version of patch.
> >
> > > Signed-off-by: Kiran K <kiran.k@intel.com>
> > > ---
> > >   drivers/bluetooth/btintel.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.=
c
> > > index dd1e48808ee2..f4d096639080 100644
> > > --- a/drivers/bluetooth/btintel.c
> > > +++ b/drivers/bluetooth/btintel.c
> > > @@ -480,6 +480,7 @@ static int btintel_version_info_tlv(struct hci_de=
v
> > *hdev,
> > >     case 0x18:      /* Slr */
> > >     case 0x19:      /* Slr-F */
> > >     case 0x1b:      /* Mgr */
> > > +   case 0x1c:      /* GaP */
> >
> > Why not add the full name in the comment? Maybe: Gale Peak (GaP).
> Ack.

I think it is about time to introduce proper definitions, or use an
enum, for these values. It would be also great to have btmon decoding
these values so you can include a HCI trace in the patch description.

> > >     case 0x1b:
> > > +   case 0x1c:
> > >             /* Display version information of TLV type */
> > >             btintel_version_info_tlv(hdev, &ver_tlv);
> > >
> >
> >
> > Kind regards,
> >
> > Paul
>
> Regards,
> Kiran



--=20
Luiz Augusto von Dentz
