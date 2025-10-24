Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6DD199E94
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 13:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761313569; cv=none; b=Dat+qxnrEnmLKV5/46Q88xLDGQmW88YHecfjYDN1PRpps7OncaJuppGlbePfYNtp9VuSkov8iUj2Vt4+foPq4cFtkXeaw+4AxSWoMFmRK18iFa0r8aaB81JqL08DmB9jCXFlHr70DxZVTkgQNGBe65PPcR5UvTOItnaWmoUIgDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761313569; c=relaxed/simple;
	bh=X8S92LY+hf/JaGhrxunSANz8b9ZDWTONtBgukhVGh7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atfxjS+Qkc5Wk6k1vO2W13UiBpagdguINKZ6L9up6LDwWUYMBMnbU6ZoI3iI897yheklYiBOgK0C/O5rwMtAhFoa6kBNQA4s7g5bLhlWWkEG+8bdfRbVkvgfjZvil1W84ErsuLFfBq53/1PZY0y0wLo6SSG7A/AjPSLX3h5AOUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EGxHSeLm; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EGxHSeLm"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3696f1d5102so18313671fa.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 06:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761313566; x=1761918366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hy758zjLMExssNQNCx+hJdH7z81NY7qpOFWdCnklvbs=;
        b=EGxHSeLmnOvJs8A67F9JhEE1XiqW9IcH+48QoPm+VXK0RrqjwKLhVGkaM683Kc9OjS
         B5gVQb0ht1gvZwOsWS/Qw0NScIFgdFLLSTZZK2YS8FAzt43KkLL1FaS/OSGBCR57s9FY
         b/k1BLqmvK3bcAMTs4dOH+SwvJ+AH8kJsqqmw9POayXTL92XCToxLFc9OQVyJiVizeKx
         BBVoKDv+KCykjCdoQ4wM341GN6uGutyOeX0ENSLjXSSDrqH0c+VX2lyYJNjrCcB9+QUN
         9+2zs59itdzhtvwNuaS6lmvz7u1fP2eJqTlWVxF4k1lUIxLTnNhQ3v7dnwqQlaLZFDqf
         3tKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761313566; x=1761918366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hy758zjLMExssNQNCx+hJdH7z81NY7qpOFWdCnklvbs=;
        b=vvPZG36PPk/s9PcvutBnJuZPFTZ2KvQoFLoH74MA5nfxx1LWv6X8mqiGbNBZiTOK4A
         gOiWaCyekXOMwiQVzOCaGHQkz6LXjXt/Q1tpI3TrTVOvsvJqWFZl2mYg7rsZ/GW8Yy3L
         6vDpOpJr51TcfSL2WyAApgu0IoZtuPfJpLGNy4tJOya2JwTX6QK9bMsxlblBouSWkJOS
         ctPMBsDJ51JLcHREYxjDTY+nS/PbA5cqC3nGyZosWJBqbzAtbPqB/ipDtVgMYa9S9gko
         8uhN/shRJfXyEGul69bSgU1hEpeXst8etzUq/xh8sokFVftwViAziuTffqD4bUupLkv4
         9BKg==
X-Forwarded-Encrypted: i=1; AJvYcCW1GgAWmcj+x/NUvs6FUui6s0hN27e2KJWUH39FAj2dAbUywVwnXtJ/f4OtznB3JXH1vWjl+Iovog1qcoNUzBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJtHf93gr8cUh4cLDUXYgeUFVK8TrESXcbAB9NJntl1RlUz5bq
	tv20oSXTFt9i7eyjO3K+0wmMv7epxz84I9bARrNbumR9iowLn0KI6AoagCq2TWJWaAwc+ClNEqe
	qZ3Oc9qo1y19w2shmy9z6RZMu9RzxFdIHxA==
X-Gm-Gg: ASbGncvKqoymsBpr9LFDVs0FH36AqII9Fe/XJrVryrIHuLzGoSpznQBbK50wSqnd4yI
	ty4YaNE8x0y84QRDhPRbIYa0lQ6rjaYIl+PWztc98DT58nBhczdpeGxkRuab1yxcg5JYhiBlaXS
	1pHcHxXVVTALlavDWEl3nW6YlefuWO2GBkeP6fvvKOOrWMPoaKNrcbGMv+RvYhFOxitRAI2x9KZ
	lUN6J/l1iTkYkMJ6LbKPMRtF0UyHkA/tpYawuj7OrX9Ljs1UhaAX/AoeDtLY//10lmWog==
X-Google-Smtp-Source: AGHT+IFejLiV9XkVIIPbOwGhUQmmYGEGEgTDvNMztKzJilxiCrq0eu9S90ea2hAc/QJe5DSOtLc1TRKqYSYT5bbUJqY=
X-Received: by 2002:a05:651c:35cc:b0:36d:54b3:9f81 with SMTP id
 38308e7fff4ca-37797a79f46mr82642701fa.41.1761313565663; Fri, 24 Oct 2025
 06:46:05 -0700 (PDT)
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
In-Reply-To: <44d4423f-e557-4506-966a-7abebca7680a@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 24 Oct 2025 09:45:51 -0400
X-Gm-Features: AWmQ_bnzEIxSbspiC7wSs7uxhxFJlSuD9i6KgxuHiiUSydi1kks-6NaW0SMdaz8
Message-ID: <CABBYNZLY6ExM1+55sPjXqUnFqCXHy1Ua3WA8zPx2TZOSNS-1oA@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: iso: fix socket matching ambiguity between
 BIS and CIS
To: Yang Li <yang.li@amlogic.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On Thu, Oct 23, 2025 at 11:47=E2=80=AFPM Yang Li <yang.li@amlogic.com> wrot=
e:
>
> Hi Luiz,
> A gentle ping, thanks.
>
> > Hi Luiz,
> >> [ EXTERNAL EMAIL ]
> >>
> >> Hi Yang,
> >>
> >> On Sun, Aug 3, 2025 at 9:07=E2=80=AFPM Yang Li <yang.li@amlogic.com> w=
rote:
> >>> Hi Luiz,
> >>>> [ EXTERNAL EMAIL ]
> >>>>
> >>>> Hi Yang,
> >>>>
> >>>> On Thu, Jul 31, 2025 at 4:00=E2=80=AFAM Yang Li via B4 Relay
> >>>> <devnull+yang.li.amlogic.com@kernel.org> wrote:
> >>>>> From: Yang Li <yang.li@amlogic.com>
> >>>>>
> >>>>> When both BIS and CIS links exist, their sockets are in
> >>>>> the BT_LISTEN state.
> >>>> We probably need to introduce tests to iso-test that setup both then
> >>>> to avoid reintroducing the problem.
> >>>
> >>> Since the coexistence of BIS sink and CIS sink is determined by
> >>> application-level logic, it may be difficult to reproduce this scenar=
io
> >>> using iso-test.
> >> Looks like you haven't look at what iso-tester tools tests do, that is
> >> not tight to bluetoothd, it directly operates at the socket layer so
> >> we can create any scenario we want.
> >
> >
> > Based on the current structure of iso-tester, it is not possible to
> > implement test cases where CIS and BIS listen simultaneously. There
> > are several issues:
> >
> > 1.
> >
> >    In struct iso_client_data, although both CIS and BIS related
> >    elements are defined, they are mutually exclusive. CIS and BIS
> >    cannot be used at the same time. For example, .bcast must explicitly
> >    specify whether it is broadcast or unicast.
> >
> > 2.
> >
> >    The setup_listen_many function also identifies BIS or CIS through
> >    .bcast.
> >
> > Therefore, if we want to add test cases for the coexistence of BIS and
> > CIS, the current data structure needs to be modified to completely
> > separate the elements for BIS and CIS.
> >
> >
>
> I'm not sure if my understanding is fully correct, so I would appreciate
> any guidance or suggestions.
>
> Based on my testing, this patch does fix the issue on my side.
> Please let me know if there is anything I may have missed or if further
> changes are needed.

I hope you are paying attention to the mailing list since I did add a
lot of new code that introduces support for PAST, including new test
cases for iso-tester, so I don't think asking for a test case for
having both BIS/CIS together is too much really. Works for me doesn't
really cut it since we do want to make sure we don't reintroduce the
problem later, but Im fine merging this now if it doesn't introduce
any problem existing tests in iso-tester.

>
> >>> Do you have any suggestions on how to simulate or test this case more
> >>> effectively?
> >>>
> >>>>> dump sock:
> >>>>>     sk 000000001977ef51 state 6
> >>>>>     src 10:a5:62:31:05:cf dst 00:00:00:00:00:00
> >>>>>     sk 0000000031d28700 state 7
> >>>>>     src 10:a5:62:31:05:cf dst00:00:00:00:00:00
> >>>>>     sk 00000000613af00e state 4   # listen sock of bis
> >>>>>     src 10:a5:62:31:05:cf dst 54:00:00:d4:99:30
> >>>>>     sk 000000001710468c state 9
> >>>>>     src 10:a5:62:31:05:cf dst 54:00:00:d4:99:30
> >>>>>     sk 000000005d97dfde state 4   #listen sock of cis
> >>>>>     src 10:a5:62:31:05:cf dst 00:00:00:00:00:00
> >>>>>
> >>>>> To locate the CIS socket correctly, check both the BT_LISTEN
> >>>>> state and whether dst addr is BDADDR_ANY.
> >>>>>
> >>>>> Link: https://github.com/bluez/bluez/issues/1224
> >>>>>
> >>>>> Signed-off-by: Yang Li <yang.li@amlogic.com>
> >>>>> ---
> >>>>>    net/bluetooth/iso.c | 9 +++++++--
> >>>>>    1 file changed, 7 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> >>>>> index eaffd25570e3..9a4dea03af8c 100644
> >>>>> --- a/net/bluetooth/iso.c
> >>>>> +++ b/net/bluetooth/iso.c
> >>>>> @@ -1919,6 +1919,11 @@ static bool iso_match_pa_sync_flag(struct
> >>>>> sock *sk, void *data)
> >>>>>           return test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags);
> >>>>>    }
> >>>>>
> >>>>> +static bool iso_match_dst(struct sock *sk, void *data)
> >>>>> +{
> >>>>> +       return !bacmp(&iso_pi(sk)->dst, (bdaddr_t *)data);
> >>>>> +}
> >>>>> +
> >>>>>    static void iso_conn_ready(struct iso_conn *conn)
> >>>>>    {
> >>>>>           struct sock *parent =3D NULL;
> >>>>> @@ -1981,7 +1986,7 @@ static void iso_conn_ready(struct iso_conn
> >>>>> *conn)
> >>>>>
> >>>>>                   if (!parent)
> >>>>>                           parent =3D iso_get_sock(&hcon->src,
> >>>>> BDADDR_ANY,
> >>>>> -                                             BT_LISTEN, NULL, NULL=
);
> >>>>> +                                             BT_LISTEN,
> >>>>> iso_match_dst, BDADDR_ANY);
> >>>>>
> >>>>>                   if (!parent)
> >>>>>                           return;
> >>>>> @@ -2220,7 +2225,7 @@ int iso_connect_ind(struct hci_dev *hdev,
> >>>>> bdaddr_t *bdaddr, __u8 *flags)
> >>>>>                   }
> >>>>>           } else {
> >>>>>                   sk =3D iso_get_sock(&hdev->bdaddr, BDADDR_ANY,
> >>>>> -                                 BT_LISTEN, NULL, NULL);
> >>>>> +                                 BT_LISTEN, iso_match_dst,
> >>>>> BDADDR_ANY);
> >>>> Perhaps we should add helper function that wrap the iso_get_sock (e.=
g.
> >>>> iso_get_sock_cis and iso_get_sock_bis) to make it clearer what is th=
e
> >>>> expected socket type, also if the hcon has been set perhaps that
> >>>> should be matched as well with CIS_LINK/BIS_LINK, or perhaps we
> >>>> introduce a socket type to differentiate since the use of the addres=
s
> >>>> can make the logic a little confusing when the socket types are mixe=
d
> >>>> together.
> >>>>
> >>>> Now looking at the source code perhaps we can have a separate list f=
or
> >>>> cis and bis sockets instead of global iso_sk_list (e.g. cis_sk_list
> >>>> and bis_sk_list), that way we don't need a type and there is no risk
> >>>> of confusing the sockets since they would never be in the same list.
> >>>
> >>> Alright, I will give it a try.
> >>>
> >>>>>           }
> >>>>>
> >>>>>    done:
> >>>>>
> >>>>> ---
> >>>>> base-commit: 9c533991fe15be60ad9f9a7629c25dbc5b09788d
> >>>>> change-id: 20250731-bis_cis_coexist-717a442d5c42
> >>>>>
> >>>>> Best regards,
> >>>>> --
> >>>>> Yang Li <yang.li@amlogic.com>
> >>>>>
> >>>>>
> >>>> --
> >>>> Luiz Augusto von Dentz
> >>
> >>
> >> --
> >> Luiz Augusto von Dentz
>
>


--=20
Luiz Augusto von Dentz
