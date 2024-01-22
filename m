Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19A24E1C4
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936273; cv=none; b=Xpr36JrkL8ZKKYE3/KcgvZGumwscofIMEvjdQwSN3hlO5gTOHu+/o8LuIqOc3dHYhpr+yMHm7nbypAzLvDEq75TqyMNyTEB2Iry3CtPYIqDRzuDzBd9T1aUs1HCZ/PL2c6TSiwUwmL82s/Ybm/coSXqoxhPTKvP0p+Xp3yPhj4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936273; c=relaxed/simple;
	bh=UMJ8Gy1hnTQZrA0Pmf78FFanz0xBG0pCV+b+BbsuOwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EX0UmXBaec6MZFGf1gZnmn6HTnK241IMJ9MYOqOhDrJnVMDo68V6SL39mHtaXFVJXGMw0qd918uPUKo90YzFdKhBoIUjU9YrDfU1Vs1bU5/4bCD3txy0YgRth+kEv8JMPEYBGLt9n1R279Gpm9vC34MIoAstEUkUYIYTmWNlEp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sk/MjHTD; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sk/MjHTD"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cd04078ebeso42079741fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 07:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705936270; x=1706541070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BemZgJRskQRS9fjqFMrR9EbGfogLzA2Wg9/T5IbwFkE=;
        b=Sk/MjHTDzfVpMpYdeJDm0OzztZO1lc/h6yhe6cjrlUy4garHQ8FxafngzWP6t5DHna
         MHDTtAAy+2qfMAE2O3TaRN9ZpMIfT0ZozVGIA/tofHawI8gJrkTOwLeCvuubybwErHex
         VTM89V1k7VVrEVp1KoR2tuwwQwiQLg/dkGYZM+ToNwIgwTR0js9GSX7ZVYvWnOpBARsD
         ApYzu8LiPcgWXOMkOj5N0ybzkCr3n4eog19dEBwlpyrAUI9SqFSC6h64DkciBebeNhTc
         khslQtAFwlApe3RZf624FtR5XPBsj2C8QKZQhPwb616SVFn61VrMHjdsfuXd9iQUqZwX
         mLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705936270; x=1706541070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BemZgJRskQRS9fjqFMrR9EbGfogLzA2Wg9/T5IbwFkE=;
        b=Dg3yIDNvkvHbCZ/ITIM9OTQbI8BEBP7WX+MxL5gfxAOOYRFGoarCfs7hln7mc217d2
         bgG4hW4bqFkRO/tZvUxWaOrOzZ9O5bJx9ngSWNXmZmY5pJDbeYqY6BGYOYs0WhM1fQ4B
         aEYcayGbk2MNTsUdcbRyk+AnwcKilg9nmEhLCv0eKbnldTInojmk0NxbmhNIRsuAwZSg
         Y+86QGDlFQMZ6LCfK4ecM6HlKxXYUVTTKs3GqZpyeGFmCDObE2s+FwazmqSvqGYVErFt
         p/NXkf6OlpIUv510OnvmmEAjVm6AGAg/U9CFzFrN0HdsAX/hhitH7M5Ew+TjH7HFb6BI
         W7sg==
X-Gm-Message-State: AOJu0YxGf3W0W/4EmrBpDcQFOTVDUvkDoSB2Emwcalhd+BGRjNtPerh7
	Mox7ig8X5ItPwht49vtDTAPkz+DNoV6ccsmDJQwvSD2o5gvR4N10sUrFXWoXtPPVYjDzugfYMFu
	KVTbsUlwmoX+SIdXFoiP+OPlNKCoZV7QMELg=
X-Google-Smtp-Source: AGHT+IG49GGU/VuhyJgG7uiBwC4AZ+wEB+f4MnJ9F7K3BnFQp84z9j0Y+EZhLlISpvSAn2ZsvPKfBX5TQPOhK5jbSTY=
X-Received: by 2002:a2e:8486:0:b0:2cd:4164:5d68 with SMTP id
 b6-20020a2e8486000000b002cd41645d68mr3175935ljh.13.1705936269522; Mon, 22 Jan
 2024 07:11:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a3a31b2d-6039-4b50-af81-47f7ea1a0461@munic.io>
 <CABBYNZ+9UdG1cMZVmdtN3U2aS16AKMCyTARZZyFX7xTEDWcMOw@mail.gmail.com> <747030d8-a06f-4d7d-bf93-0e95f54b9bbf@munic.io>
In-Reply-To: <747030d8-a06f-4d7d-bf93-0e95f54b9bbf@munic.io>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 22 Jan 2024 10:10:56 -0500
Message-ID: <CABBYNZ+4fb3FbEPe41gQuRBNG3jNARakfSqvqB2j8wKZ3J92fQ@mail.gmail.com>
Subject: Re: regression in c7f59461f5a78: Bluetooth: Fix a refcnt underflow
 problem for hci_conn
To: Andrei Volkov <andrey.volkov@mobile-devices.fr>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrei,

On Mon, Jan 22, 2024 at 9:45=E2=80=AFAM Andrei Volkov
<andrey.volkov@mobile-devices.fr> wrote:
>
> Hi Luiz,
>
> Wouldn't it be better to add a 'yet-another' flag as an addition to
> HCI_CONN_SSP_ENABLED, and clear it unconditionally at the top of
> 'hci_remote_ext_features_evt', before
>
> "        conn =3D hci_conn_hash_lookup_handle "
>
> check?
>
> In this case broken ext_features response (with ev->status !=3D 0 or conn
> =3D=3D NULL) will not indirectly enable the SSP feature.

HCI_CONN_SSP_ENABLED is already at conn level, besides that it is too
late to clear it if the SSP procedure has already taken place and on
top of it I don't want to change the code too much and risk having
more regressions like this.

Btw, something tells me that Android is not actually doing the
HCI_OP_READ_REMOTE_EXT_FEATURES since we do have CI testing SSP and
this change hasn't cause us any problems, do you know what command it
uses? Perhaps it tries SSP right-away or does it cache the previous
response?

> Regards
> Andrei VOLKOV
>
> Le 22/01/2024 =C3=A0 15:02, Luiz Augusto von Dentz a =C3=A9crit :
>
> > Hi Andrei,
> >
> > On Mon, Jan 22, 2024 at 7:18=E2=80=AFAM Andrei Volkov
> > <andrey.volkov@mobile-devices.fr> wrote:
> >> Hello,
> >>
> >> Lately we've bumped with regression introduced by commit:
> >>
> >>    c7f59461f5a78 ("Bluetooth: Fix a refcnt underflow problem for
> >> hci_conn", 2023-10-04)
> >>
> >> The regression related with adding "hci_conn_ssp_enabled()" check in
> >> "hci_io_capa_request_evt()" handler, and broke pairing process initiat=
ed
> >> by the external device.
> >>
> >> Precisely, some ext. devices, like any phone equipped with Android ver=
 <
> >> 14 (we have not latest one, so we didn't check), always send "IO
> >> Capability Request" before "Read Remote Extended Features" command, as
> >> consequence the flag "HCI_CONN_SSP_ENABLED" not yet activated at the
> >> time of "hci_io_capa_request_evt()" execution  and
> >> "hci_conn_ssp_enabled()" always returns false in time of the pairing.
> >>
> >> As a result, pairing always fails. The quick and dirty fix is revert t=
he
> >> ssp check introduced in the subj. commit, like below:
> >>
> >> --- a/net/bluetooth/hci_event.c
> >> +++ b/net/bluetooth/hci_event.c
> >> @@ -5329,7 +5329,7 @@ static void hci_io_capa_request_evt(struct hci_d=
ev
> >> *hdev, void *data,
> >>           hci_dev_lock(hdev);
> >>
> >>           conn =3D hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr=
);
> >> -       if (!conn || !hci_conn_ssp_enabled(conn))
> >> +       if (!conn)
> >>                   goto unlock;
> >>
> >>           hci_conn_hold(conn);
> >>
> >>
> >> However, a more thorough and correct fix requires discussion and
> >> testing. Therefore, I would like to get any comments/suggestion from t=
he
> >> community before doing this.
> > I think we need to do something like this, so we consider only the
> > local SSP flag when evaluating if we should proceed to respond or just
> > drop:
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 6130c969f361..a15924db83d9 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -5327,9 +5327,12 @@ static void hci_io_capa_request_evt(struct
> > hci_dev *hdev, void *data,
> >          hci_dev_lock(hdev);
> >
> >          conn =3D hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
> > -       if (!conn || !hci_conn_ssp_enabled(conn))
> > +       if (!conn || !hci_dev_test_flag(hdev, HCI_SSP_ENABLED))
> >                  goto unlock;
> >
> > +       /* Assume remote supports SSP since it has triggered this event=
 */
> > +       set_bit(HCI_CONN_SSP_ENABLED, &conn->flags);
> > +
> >          hci_conn_hold(conn);
> >
> >          if (!hci_dev_test_flag(hdev, HCI_MGMT))
> >
> >
> >> Regards
> >> Andrey VOLKOV
> >>
> >>
> >



--=20
Luiz Augusto von Dentz
