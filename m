Return-Path: <SRS0=k5tg=AN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A23C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 17:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6570F2084C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jul 2020 17:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s0VX9fWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgGBRhp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jul 2020 13:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbgGBRhp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jul 2020 13:37:45 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF4CC08C5C1
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2020 10:37:45 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q7so20042576ljm.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2020 10:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hjypz7hFyFKrs0DnFxsXcBRXvUNFSdjgwsRh4IgaA38=;
        b=s0VX9fWqu4Uc55ZWvRMyuapD9SZPgcQRA706bED0/IyCXRexdcElq9tutq3md5ZWMc
         e5jsAdZJo6xsqcLH4DJMEax7/XZY/agO4ll7I8H69qrNwC7e0rrminUfkK5qF7MKw+2q
         M6VQmTCFywCyo4I9347JGxQJ3giC7JiMVQPMGF9KzIdehutmOkyDLcE1JlYrQCMZqAwZ
         T78mzFdOwTsxl+tU2NcSu0lWOnwm/9Tp1PubkTPuxEcMyVN0fJN7E/GbgeubQtOGzQPe
         5QZ7BZvtAzjQQOvsf1d5lHCjaBS/Uz5KUfBGG+E1pEwL5YYygLN8iVlayHk3WnGObpOO
         LQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hjypz7hFyFKrs0DnFxsXcBRXvUNFSdjgwsRh4IgaA38=;
        b=IexdHhbRUuYJOn9+mLKG5WalO0RLDsSa16i+8QCPdTvrxZCQ8O4kgpXLvNsaTjwlCI
         zsjh8OpS9Pgf3tT4uNdBxOwkfIZS1IDbVBhZDpyiejLnoUySXHRshNr2xGkDRggFL3do
         Xtrhp8Vn3g2X6YGmGqlS3g/juvjOnhY7o704IUUjHdKId7czLz+AakWPslYoBckVK/fP
         wO5SLWOextP7YL5zTE+GnnySgnoFh8K0b9SYLa/dQ29cnwAYVUfwS6yWN1Vgqu7h7ANl
         epjec8orvsgWBZJdxwTXb8GProzA6W2jD3ud4F0GkjoECx+7X6f2EjnUjNYSRuC6x1uN
         UCSQ==
X-Gm-Message-State: AOAM530lUm86EmI7RDJze9WUZzJeusk2nL7GXBVVz9FnV9hTaLj9i4Wa
        FCz0BxAYnFBSUP9GKjdYeQ4n/kRVu5YlmJUJNrckHPKP9G0=
X-Google-Smtp-Source: ABdhPJz5o6Vok/n2Vp8zN8pvbrZiV0oIyQZl4Iq36noUv/1OdSv+B5D/x2Z6NX7XgNYxnSnJT1xNv8VyXL+aTI/K9OY=
X-Received: by 2002:a2e:7019:: with SMTP id l25mr3791002ljc.256.1593711463048;
 Thu, 02 Jul 2020 10:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200701220853.421445-1-alainm@chromium.org> <427B6E1C-178C-405D-88F8-899EC48AC8A9@holtmann.org>
 <CALWDO_XT=O4NiqMur+_u1z4o0868ZzBr4gpUikgmgw2U4zqMzw@mail.gmail.com> <CALWDO_Wf5gftarhsxq-itzWhvtjj171hVYezsRN-GU_dv-zaVg@mail.gmail.com>
In-Reply-To: <CALWDO_Wf5gftarhsxq-itzWhvtjj171hVYezsRN-GU_dv-zaVg@mail.gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Thu, 2 Jul 2020 13:37:31 -0400
Message-ID: <CALWDO_VcbYuWV7yoJBNM17up8Wb+TXnYQMAe9oexhv3zFt5y0g@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: le_supported_roles experimental feature
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Jul 2, 2020 at 11:01 AM Alain Michaud <alainmichaud@google.com> wro=
te:
>
> Resending as plaintext.
>
>
> On Thu, Jul 2, 2020 at 10:59 AM Alain Michaud <alainmichaud@google.com> w=
rote:
> >
> > Hi Marcel
> >
> > On Thu, Jul 2, 2020 at 9:18 AM Marcel Holtmann <marcel@holtmann.org> wr=
ote:
> >>
> >> Hi Alain,
> >>
> >> > This patch adds an le_supported_roles features which allows a
> >> > clients to determine if the controller is able to support peripheral=
 and
> >> > central connections separately and at the same time.
> >> >
> >> > Signed-off-by: Alain Michaud <alainm@chromium.org>
> >> > ---
> >> >
> >> > Changes in v2:
> >> > - Slight change of design based on offline feedback
> >> >
> >> > net/bluetooth/mgmt.c | 36 +++++++++++++++++++++++++++++++++++-
> >> > 1 file changed, 35 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> >> > index 5e9b9728eeac..c13fcc21745f 100644
> >> > --- a/net/bluetooth/mgmt.c
> >> > +++ b/net/bluetooth/mgmt.c
> >> > @@ -3753,10 +3753,36 @@ static const u8 debug_uuid[16] =3D {
> >> > };
> >> > #endif
> >> >
> >> > +/* 671b10b5-42c0-4696-9227-eb28d1b049d6 */
> >> > +static const u8 le_supported_roles[16] =3D {
> >> > +     0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb, 0x27, 0x92,
> >> > +     0x96, 0x46, 0xc0, 0x42, 0xb5, 0x10, 0x1b, 0x67,
> >> > +};
> >> > +
> >> > +static u32 get_le_roles_flags(struct hci_dev *hdev)
> >> > +{
> >> > +     u32 flags =3D 0;
> >> > +
> >> > +     /* Central connections supported */
> >> > +     if (hdev->le_states[4] & 0x08)
> >> > +             flags |=3D BIT(0);
> >> > +
> >> > +     /* Peripheral connections supported */
> >> > +     if (hdev->le_states[4] & 0x40)
> >> > +             flags |=3D BIT(1);
> >> > +
> >> > +     /* Simult central and peripheral connections supported */
> >> > +     if (test_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks) &&
> >> > +         (hdev->le_states[3] & 0x10))
> >> > +             flags |=3D BIT(2);
> >> > +
> >> > +     return flags;
> >> > +}
> >>
> >> this is not what we can do here. The flags are defined like this.
> >>
> >>         The following bits are defined for the Flags parameter:
> >>
> >>                 0       Feature active
> >>                 1       Causes change in supported settings
> >>
> >> And I want these flags for generic handling of experimental features. =
Individual features can not overwrite it.
> >>
> >> So if you only want to support a the =E2=80=9Cread" functionality, the=
n something like this please.
> >>
> >>         if ((hdev->le_states[4] & 0x08) &&      /* Central */
> >>             (hdev->le_states[4] & 0x40) &&      /* Peripheral */
> >>             (hdev->le_states[3] & 0x10) &&      /* Simultaneous */
> >>             test_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks))
> >>                 flags |=3D BIT(0);
> >>
> > OK, Since the userspace Api we discussed reports individual states, wou=
ld you suggest if LE is supported that the Central and Peripheral roles are=
 supported and just use this to query the simultaneous support? Also, seems=
 like what you are suggesting looks a lot like v1.
> >
> >>
> >> > +
> >> > static int read_exp_features_info(struct sock *sk, struct hci_dev *h=
dev,
> >> >                                 void *data, u16 data_len)
> >> > {
> >> > -     char buf[42];
> >> > +     char buf[44];
> >> >       struct mgmt_rp_read_exp_features_info *rp =3D (void *)buf;
> >> >       u16 idx =3D 0;
> >> >
> >> > @@ -3774,6 +3800,14 @@ static int read_exp_features_info(struct sock=
 *sk, struct hci_dev *hdev,
> >> >       }
> >> > #endif
> >> >
> >> > +     if (hdev) {
> >> > +             memcpy(rp->features[idx].uuid, le_supported_roles,
> >> > +                    sizeof(le_supported_roles));
> >> > +
> >>
> >> And I would put it all here instead of a separate function.
> >>
> >> > +             rp->features[idx].flags =3D cpu_to_le32(get_le_roles_f=
lags(hdev));
> >> > +             ++idx;
> >> > +     }
> >> > +
> >> >       rp->feature_count =3D cpu_to_le16(idx);
> >> >
> >> >       /* After reading the experimental features information, enable
> >>
> >> Regards
> >>
> >> Marcel
> >>
