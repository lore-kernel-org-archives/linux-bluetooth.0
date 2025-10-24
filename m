Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB3F2DAFAF
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761313650; cv=none; b=ajdfVmcOrl3uqCGHRZZUr77WbrQGfb45QIOco/uDDWgJCLp3l5EUKdAB/ksI/1yupsgF5v6t7Fw3aRxTfoj+GjJxtoZeYPcRIveaP7GEoSU2jR55jtNWwda6f1jWmDCYy0hG6NSu+7O5MuqLUL9Mr9RZRSjUTQ5KsO8R7Rmawuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761313650; c=relaxed/simple;
	bh=P5efqsy6mTgjda9OiI4HwPuKs5Ix6wwE5Ev7dBI/rZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=drvnK8qW1sqES5K3jwYDKXuSZK8zhosP3NvdMA8zBv/+NEEzaogoFZfz9v4THYnXpgRRTpa8nda7DnmX6hisOkmCGycy0hjZaCnT5kpbxt4xuVNF1e9rA5GO+PZTFHQuFPnj2/1TL6hnsteEwcn63vYvHIcvzREJgs7/n4U1fr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5wVbLZC; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5wVbLZC"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-378cfd75fb0so21352151fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 06:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761313647; x=1761918447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pchbnAludoXw0jQM03838mZKYOdbsuH0z3yLPtcr2+g=;
        b=h5wVbLZCvraOBsWHvyC2qKSrT8UN0WUitReL8JpanR8LNeHkI6zrGXYl1KUzNXow9r
         1yn4qU0svznpPt2XYVYK5aWobQbqf9UsNBrCQjo5mn7XDQiZM0TO8sbIkOQtLBj7Uxwb
         JylZsqFByDTHgRYHtD/zcXm0K6+YCPG7DCaa20JWSPtMlhNJUKbR2/3tSs90Jkh4Ye2q
         pDr2Ex/J7rNrx0AgmPlsMecEGxjwywRGn4z3DvnkLQ+4l+h6s31KlIhkdO5aZtTyMvGx
         +aEEicXoIgtX+Cz2tiqEYcZp/ENA1gA1aH/uUuR99W932d6y/uRZwKfbKkd28xHOKLSQ
         TkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761313647; x=1761918447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pchbnAludoXw0jQM03838mZKYOdbsuH0z3yLPtcr2+g=;
        b=BgycDeXuIXBoGvl6e312WiLsJGzdJg2o214BvHCtSXrdN82W+NOJZhAbVNHYcx/+np
         zr+wcPgkKgylFvWcFbe0YtDSwWZRIVW2B/R12IsUkFo7xFS8TRi+Ops7bCGl+Cf5MMwc
         BxDwXc0bNUsB4BBgOOOfL4wvORZ2fgAYSMN6bo01EamWO1nKChr/qmcR2oIx94U+MOfv
         CCKzfxn7POpZ/agBrWdXtit01INRvGK8ByVBAjTEATvsm+PysNaVOBAScLt69ykNvAxS
         vrzwi/1uTUDjceAazEiXAU1uF9AIcNs5KXBpz8SJss5GnbaQ/4I+uxvo8ORj2juJSBr0
         +yUA==
X-Forwarded-Encrypted: i=1; AJvYcCXqxqYId0kCGdWnrYdO7/eM3UFbM8XT69dIHW6umONNC218pHIjXZDEhOZecN2kTrS550r3t5Gfhc+hrtOgx18=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF+CPuKSozLkn58XFQ77fKOf0NlrRf7f9apQqsLjp2W503Z6Eh
	sughN2angOQxOcUlyXFAImF29jQ5yo7CLkA50zQobhkF/akJZVZLhwmpmQZunDM+owTI3BPylNH
	SMyuD748c/K7I66LgPu0PlqslOxRCkS4=
X-Gm-Gg: ASbGncut6qhXj3jzsbo8ac/S9j8b/mWY9xRmMK5YeIs5hLTdOP+qoevO7foMvCiLt6n
	M0futP2S55ZEtUR+8Ja/muCEkBnwBVMgkeCYTGWL0ka6kPL452xkJBnmq0HRPJDUrl/SKnDPfCC
	NeQld1G/I1soXRf6JTKoQ71YsAlqk/1f55e1ae96jKvgxmulEtNXzCOh5aUMZhZWpCEXznPH7K/
	0gM5GI+zWB378ssBIE8E+p5aryIdP0g2RtZdjj2X1+ri3i9huWyj4RUb2s=
X-Google-Smtp-Source: AGHT+IHvW0zqfCSMt2eNmxcRwl9UZxpIa6XM/ni51aKzpamgw520Ee4qqfelGrF/tDe1fcnxX+4rCxtHyWjRwH+L6JA=
X-Received: by 2002:a05:651c:2122:b0:378:df5b:fbb8 with SMTP id
 38308e7fff4ca-378df5c0217mr15126171fa.19.1761313646678; Fri, 24 Oct 2025
 06:47:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731-bis_cis_coexist-v3-1-1f9bd60ef712@amlogic.com>
 <CABBYNZJu3izq6ZhNRKjMz-mW1CcP2VAE7Xs5oq=NupnVD7aayg@mail.gmail.com>
 <4e0b2df6-1139-49df-b03b-a2f31925d52f@amlogic.com> <CABBYNZ+buYOXaBST-bCyzDWtWihMOoXGaoNzp6+kowKgo+-6=w@mail.gmail.com>
 <5874e307-fa81-4baf-b270-478128d30412@amlogic.com> <44d4423f-e557-4506-966a-7abebca7680a@amlogic.com>
 <CABBYNZLY6ExM1+55sPjXqUnFqCXHy1Ua3WA8zPx2TZOSNS-1oA@mail.gmail.com>
In-Reply-To: <CABBYNZLY6ExM1+55sPjXqUnFqCXHy1Ua3WA8zPx2TZOSNS-1oA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 24 Oct 2025 09:47:12 -0400
X-Gm-Features: AWmQ_bljyv2PlxxNGzStrvRiW6b8KFt3CUmwe8TT0sX_M9MDD8FZZ8XYqUL0AW8
Message-ID: <CABBYNZ+Bs2D9A_OMJ_JGH9yTiLiK_gUz07jBEEXd302Uh01KQQ@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: iso: fix socket matching ambiguity between
 BIS and CIS
To: Yang Li <yang.li@amlogic.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On Fri, Oct 24, 2025 at 9:45=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Yang,
>
> On Thu, Oct 23, 2025 at 11:47=E2=80=AFPM Yang Li <yang.li@amlogic.com> wr=
ote:
> >
> > Hi Luiz,
> > A gentle ping, thanks.
> >
> > > Hi Luiz,
> > >> [ EXTERNAL EMAIL ]
> > >>
> > >> Hi Yang,
> > >>
> > >> On Sun, Aug 3, 2025 at 9:07=E2=80=AFPM Yang Li <yang.li@amlogic.com>=
 wrote:
> > >>> Hi Luiz,
> > >>>> [ EXTERNAL EMAIL ]
> > >>>>
> > >>>> Hi Yang,
> > >>>>
> > >>>> On Thu, Jul 31, 2025 at 4:00=E2=80=AFAM Yang Li via B4 Relay
> > >>>> <devnull+yang.li.amlogic.com@kernel.org> wrote:
> > >>>>> From: Yang Li <yang.li@amlogic.com>
> > >>>>>
> > >>>>> When both BIS and CIS links exist, their sockets are in
> > >>>>> the BT_LISTEN state.
> > >>>> We probably need to introduce tests to iso-test that setup both th=
en
> > >>>> to avoid reintroducing the problem.
> > >>>
> > >>> Since the coexistence of BIS sink and CIS sink is determined by
> > >>> application-level logic, it may be difficult to reproduce this scen=
ario
> > >>> using iso-test.
> > >> Looks like you haven't look at what iso-tester tools tests do, that =
is
> > >> not tight to bluetoothd, it directly operates at the socket layer so
> > >> we can create any scenario we want.
> > >
> > >
> > > Based on the current structure of iso-tester, it is not possible to
> > > implement test cases where CIS and BIS listen simultaneously. There
> > > are several issues:
> > >
> > > 1.
> > >
> > >    In struct iso_client_data, although both CIS and BIS related
> > >    elements are defined, they are mutually exclusive. CIS and BIS
> > >    cannot be used at the same time. For example, .bcast must explicit=
ly
> > >    specify whether it is broadcast or unicast.
> > >
> > > 2.
> > >
> > >    The setup_listen_many function also identifies BIS or CIS through
> > >    .bcast.
> > >
> > > Therefore, if we want to add test cases for the coexistence of BIS an=
d
> > > CIS, the current data structure needs to be modified to completely
> > > separate the elements for BIS and CIS.
> > >
> > >
> >
> > I'm not sure if my understanding is fully correct, so I would appreciat=
e
> > any guidance or suggestions.
> >
> > Based on my testing, this patch does fix the issue on my side.
> > Please let me know if there is anything I may have missed or if further
> > changes are needed.
>
> I hope you are paying attention to the mailing list since I did add a
> lot of new code that introduces support for PAST, including new test
> cases for iso-tester, so I don't think asking for a test case for
> having both BIS/CIS together is too much really. Works for me doesn't
> really cut it since we do want to make sure we don't reintroduce the
> problem later, but Im fine merging this now if it doesn't introduce
> any problem existing tests in iso-tester.

You will need to resend it since it is no longer available in patchwork.

> >
> > >>> Do you have any suggestions on how to simulate or test this case mo=
re
> > >>> effectively?
> > >>>
> > >>>>> dump sock:
> > >>>>>     sk 000000001977ef51 state 6
> > >>>>>     src 10:a5:62:31:05:cf dst 00:00:00:00:00:00
> > >>>>>     sk 0000000031d28700 state 7
> > >>>>>     src 10:a5:62:31:05:cf dst00:00:00:00:00:00
> > >>>>>     sk 00000000613af00e state 4   # listen sock of bis
> > >>>>>     src 10:a5:62:31:05:cf dst 54:00:00:d4:99:30
> > >>>>>     sk 000000001710468c state 9
> > >>>>>     src 10:a5:62:31:05:cf dst 54:00:00:d4:99:30
> > >>>>>     sk 000000005d97dfde state 4   #listen sock of cis
> > >>>>>     src 10:a5:62:31:05:cf dst 00:00:00:00:00:00
> > >>>>>
> > >>>>> To locate the CIS socket correctly, check both the BT_LISTEN
> > >>>>> state and whether dst addr is BDADDR_ANY.
> > >>>>>
> > >>>>> Link: https://github.com/bluez/bluez/issues/1224
> > >>>>>
> > >>>>> Signed-off-by: Yang Li <yang.li@amlogic.com>
> > >>>>> ---
> > >>>>>    net/bluetooth/iso.c | 9 +++++++--
> > >>>>>    1 file changed, 7 insertions(+), 2 deletions(-)
> > >>>>>
> > >>>>> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> > >>>>> index eaffd25570e3..9a4dea03af8c 100644
> > >>>>> --- a/net/bluetooth/iso.c
> > >>>>> +++ b/net/bluetooth/iso.c
> > >>>>> @@ -1919,6 +1919,11 @@ static bool iso_match_pa_sync_flag(struct
> > >>>>> sock *sk, void *data)
> > >>>>>           return test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags);
> > >>>>>    }
> > >>>>>
> > >>>>> +static bool iso_match_dst(struct sock *sk, void *data)
> > >>>>> +{
> > >>>>> +       return !bacmp(&iso_pi(sk)->dst, (bdaddr_t *)data);
> > >>>>> +}
> > >>>>> +
> > >>>>>    static void iso_conn_ready(struct iso_conn *conn)
> > >>>>>    {
> > >>>>>           struct sock *parent =3D NULL;
> > >>>>> @@ -1981,7 +1986,7 @@ static void iso_conn_ready(struct iso_conn
> > >>>>> *conn)
> > >>>>>
> > >>>>>                   if (!parent)
> > >>>>>                           parent =3D iso_get_sock(&hcon->src,
> > >>>>> BDADDR_ANY,
> > >>>>> -                                             BT_LISTEN, NULL, NU=
LL);
> > >>>>> +                                             BT_LISTEN,
> > >>>>> iso_match_dst, BDADDR_ANY);
> > >>>>>
> > >>>>>                   if (!parent)
> > >>>>>                           return;
> > >>>>> @@ -2220,7 +2225,7 @@ int iso_connect_ind(struct hci_dev *hdev,
> > >>>>> bdaddr_t *bdaddr, __u8 *flags)
> > >>>>>                   }
> > >>>>>           } else {
> > >>>>>                   sk =3D iso_get_sock(&hdev->bdaddr, BDADDR_ANY,
> > >>>>> -                                 BT_LISTEN, NULL, NULL);
> > >>>>> +                                 BT_LISTEN, iso_match_dst,
> > >>>>> BDADDR_ANY);
> > >>>> Perhaps we should add helper function that wrap the iso_get_sock (=
e.g.
> > >>>> iso_get_sock_cis and iso_get_sock_bis) to make it clearer what is =
the
> > >>>> expected socket type, also if the hcon has been set perhaps that
> > >>>> should be matched as well with CIS_LINK/BIS_LINK, or perhaps we
> > >>>> introduce a socket type to differentiate since the use of the addr=
ess
> > >>>> can make the logic a little confusing when the socket types are mi=
xed
> > >>>> together.
> > >>>>
> > >>>> Now looking at the source code perhaps we can have a separate list=
 for
> > >>>> cis and bis sockets instead of global iso_sk_list (e.g. cis_sk_lis=
t
> > >>>> and bis_sk_list), that way we don't need a type and there is no ri=
sk
> > >>>> of confusing the sockets since they would never be in the same lis=
t.
> > >>>
> > >>> Alright, I will give it a try.
> > >>>
> > >>>>>           }
> > >>>>>
> > >>>>>    done:
> > >>>>>
> > >>>>> ---
> > >>>>> base-commit: 9c533991fe15be60ad9f9a7629c25dbc5b09788d
> > >>>>> change-id: 20250731-bis_cis_coexist-717a442d5c42
> > >>>>>
> > >>>>> Best regards,
> > >>>>> --
> > >>>>> Yang Li <yang.li@amlogic.com>
> > >>>>>
> > >>>>>
> > >>>> --
> > >>>> Luiz Augusto von Dentz
> > >>
> > >>
> > >> --
> > >> Luiz Augusto von Dentz
> >
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
