Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8A34F89D
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939962; cv=none; b=ofD5kZ30kRWKIeKBceZtUmIAvncCkMNMQoVR882K+9DbmmVa3t2awRF5MFAAcerIvv3cLwmrQLD1m05Ts7aUwdvhwupuY9UePVjK1lmGM+vE8kLnaJU0V3aTOKXbXz+H7jQLO/S12Ac2R3jLvFlYMu3ChajBqltOAHgcXlPmkAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939962; c=relaxed/simple;
	bh=3dBEiDIlJJUHzE8Vm99HctMifC0C2HSrcfG9wcOmBY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rW54kRHTHL2OSqzc+DkJh6wEnrKgimypk3bLM3f2Q8g5FBOOYzA8zQaynQbv3ad8YR4PocZN6aJDBpQPD+jC9hJzCVtZrw3sZ5rrDJlNz4voNTnmADxU8frMUdZHOA9wvQqcQQ+A/DK3iKHISjndcKkhXU+4gt2ysmzzy/5sNeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ria9I/1j; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ria9I/1j"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cca5d81826so39192681fa.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 08:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705939959; x=1706544759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKdGqBZ4dDPZaSykp7nXo1SiJVX9uAT7WTb97CLQLZU=;
        b=Ria9I/1jkeMbc7jBoSCDV1PzSbeWTClPBi6i8S3g7S+tP+uTNrUXv4ESsSLMghOr3p
         myP7ZFOsUWdLhHR1gPsj0+t3gGfr9YV52/yJRTGitABS56QvyzcqQ9iDiCPVPsjw2P5W
         qkE0JSHlYf/5o2CiVW9FGHecdanVui3yuVipRqU7EPMlGR6ny18IIsnNrimX79uANZbV
         V+9zAROUBxjmmJedamH9r0/2QFTFMRjpMpRlq3Bp4JqVjzOmReEd8LJ+XkDmpk+HqTOa
         ssZMc40plNeRxdm9igRtvfeFjqI/olZvAYkc8DX6X2zYmkelOcqZKnwi7w9FaHL0KSne
         bxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705939959; x=1706544759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hKdGqBZ4dDPZaSykp7nXo1SiJVX9uAT7WTb97CLQLZU=;
        b=UmhC0c9HRRydSV7L//XyQ8RPUKZ7uTe0rMM6gNXuVjSF4aYj7oTrpDl8ogQSgARYAh
         0L2WJYOfcwwz5faCNsCjDOjqlSYIVHdjTrLJHTnxmnhKz03rrVOlP5VIVRRGb+/4mWm0
         CSkPGfTotImNFp+YI7AH8WFFl86rP2pPdFTERm/OWKIEifb0Ga+8rC5mDGN1i9smOt/K
         jXToJCsAjwCfPdH+jMmaFiVfPpIHo0/90ngGMDYmRHz15lhRP8yabbIFURK598IDtW08
         Sbq+QZ1A8A/83NWp/16bW570kw+OLMopHpfMjY1cJXVZwwn2D3jkjLN5b3xhfDQk7WeH
         8RQg==
X-Gm-Message-State: AOJu0YzkFVYai3L0/uVHg+WNMZLeO5lWHyuoeBKxkcl1syLt/QWLb2hz
	5DF2rdBXAUcexJAjerUw8nHtiV9kUWctdf0jUSnuC9opUR3cxjFtMk+K0zA0Lxqunc6TJoFFy2S
	PEMVbkBCMLM5s/KWumnfFDhSsQ3oIHSGJ
X-Google-Smtp-Source: AGHT+IGkW+HaQI1lXUPMY5OeDDcMnQO8PCjg6+rEorde/j+c+M2CzNEHIzDsdOlYDR9tVXqZrHAG98JP/ocuR8Uu5HE=
X-Received: by 2002:a2e:9ed6:0:b0:2cf:121:3ccb with SMTP id
 h22-20020a2e9ed6000000b002cf01213ccbmr576404ljk.55.1705939958559; Mon, 22 Jan
 2024 08:12:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a3a31b2d-6039-4b50-af81-47f7ea1a0461@munic.io>
 <CABBYNZ+9UdG1cMZVmdtN3U2aS16AKMCyTARZZyFX7xTEDWcMOw@mail.gmail.com>
 <747030d8-a06f-4d7d-bf93-0e95f54b9bbf@munic.io> <CABBYNZ+4fb3FbEPe41gQuRBNG3jNARakfSqvqB2j8wKZ3J92fQ@mail.gmail.com>
 <810c8fcc-95a5-4117-afbc-91d201398004@munic.io>
In-Reply-To: <810c8fcc-95a5-4117-afbc-91d201398004@munic.io>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 22 Jan 2024 11:12:25 -0500
Message-ID: <CABBYNZ+TujgGCTt93gg-tJryCELuzwyz4vwoxM3ibHZvNvQwvA@mail.gmail.com>
Subject: Re: regression in c7f59461f5a78: Bluetooth: Fix a refcnt underflow
 problem for hci_conn
To: Andrei Volkov <andrey.volkov@mobile-devices.fr>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrei,

On Mon, Jan 22, 2024 at 10:50=E2=80=AFAM Andrei Volkov
<andrey.volkov@mobile-devices.fr> wrote:
>
> Hi Luiz,
>
> Le 22/01/2024 =C3=A0 16:10, Luiz Augusto von Dentz a =C3=A9crit :
>
> > Hi Andrei,
> >
> > On Mon, Jan 22, 2024 at 9:45=E2=80=AFAM Andrei Volkov
> > <andrey.volkov@mobile-devices.fr> wrote:
> >> Hi Luiz,
> >>
> >> Wouldn't it be better to add a 'yet-another' flag as an addition to
> >> HCI_CONN_SSP_ENABLED, and clear it unconditionally at the top of
> >> 'hci_remote_ext_features_evt', before
> >>
> >> "        conn =3D hci_conn_hash_lookup_handle"
> >>
> >> check?
> >>
> >> In this case broken ext_features response (with ev->status !=3D 0 or c=
onn
> >> =3D=3D NULL) will not indirectly enable the SSP feature.
> > HCI_CONN_SSP_ENABLED is already at conn level, besides that it is too
> > late to clear it if the SSP procedure has already taken place and on
> > top of it I don't want to change the code too much and risk having
> > more regressions like this.
> >
> > Btw, something tells me that Android is not actually doing the
> > HCI_OP_READ_REMOTE_EXT_FEATURES since we do have CI testing SSP and
> > this change hasn't cause us any problems, do you know what command it
> > uses? Perhaps it tries SSP right-away or does it cache the previous
> > response?
> >
> The real problem is that since the ext. device does not receive a
> response to the IO request (cmd 0x31) from BlueZ, it refuses to continue
> the pairing. But with proposed reverting the ssp check, we are probably
> coming back to the initial href problem.
>
> Btw, for me it's unclear how the additional check in
> "hci_io_capa_request_evt" helps with href undderrun. It looks like the
> original FSM implementation is missing something, and the fix actually
> is masking the problem.

That is a totally different problem, most likely related to
conn->disc_work not being cancelled properly or something, so this
probably was only masking it for some reason but it is not a proper
fix, anyway it is still a good idea to check if hdev has SSP enabled
in any case, since it can be enabled/disabled at runtime thus why I'm
not completely reverting it.

If the conn_timeout problem comes back then we need to investigate
what is really causing that, but there is a high chance this has been
fixed since we have been reworking some of the code paths related to
hci_conn_del, etc.

> Regards
> Andrei VOLKOV
>
> >> Regards
> >> Andrei VOLKOV
> >>
> >> Le 22/01/2024 =C3=A0 15:02, Luiz Augusto von Dentz a =C3=A9crit :
> >>
> >>> Hi Andrei,
> >>>
> >>> On Mon, Jan 22, 2024 at 7:18=E2=80=AFAM Andrei Volkov
> >>> <andrey.volkov@mobile-devices.fr> wrote:
> >>>> Hello,
> >>>>
> >>>> Lately we've bumped with regression introduced by commit:
> >>>>
> >>>>     c7f59461f5a78 ("Bluetooth: Fix a refcnt underflow problem for
> >>>> hci_conn", 2023-10-04)
> >>>>
> >>>> The regression related with adding "hci_conn_ssp_enabled()" check in
> >>>> "hci_io_capa_request_evt()" handler, and broke pairing process initi=
ated
> >>>> by the external device.
> >>>>
> >>>> Precisely, some ext. devices, like any phone equipped with Android v=
er <
> >>>> 14 (we have not latest one, so we didn't check), always send "IO
> >>>> Capability Request" before "Read Remote Extended Features" command, =
as
> >>>> consequence the flag "HCI_CONN_SSP_ENABLED" not yet activated at the
> >>>> time of "hci_io_capa_request_evt()" execution  and
> >>>> "hci_conn_ssp_enabled()" always returns false in time of the pairing=
.
> >>>>
> >>>> As a result, pairing always fails. The quick and dirty fix is revert=
 the
> >>>> ssp check introduced in the subj. commit, like below:
> >>>>
> >>>> --- a/net/bluetooth/hci_event.c
> >>>> +++ b/net/bluetooth/hci_event.c
> >>>> @@ -5329,7 +5329,7 @@ static void hci_io_capa_request_evt(struct hci=
_dev
> >>>> *hdev, void *data,
> >>>>            hci_dev_lock(hdev);
> >>>>
> >>>>            conn =3D hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bda=
ddr);
> >>>> -       if (!conn || !hci_conn_ssp_enabled(conn))
> >>>> +       if (!conn)
> >>>>                    goto unlock;
> >>>>
> >>>>            hci_conn_hold(conn);
> >>>>
> >>>>
> >>>> However, a more thorough and correct fix requires discussion and
> >>>> testing. Therefore, I would like to get any comments/suggestion from=
 the
> >>>> community before doing this.
> >>> I think we need to do something like this, so we consider only the
> >>> local SSP flag when evaluating if we should proceed to respond or jus=
t
> >>> drop:
> >>>
> >>> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> >>> index 6130c969f361..a15924db83d9 100644
> >>> --- a/net/bluetooth/hci_event.c
> >>> +++ b/net/bluetooth/hci_event.c
> >>> @@ -5327,9 +5327,12 @@ static void hci_io_capa_request_evt(struct
> >>> hci_dev *hdev, void *data,
> >>>           hci_dev_lock(hdev);
> >>>
> >>>           conn =3D hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdadd=
r);
> >>> -       if (!conn || !hci_conn_ssp_enabled(conn))
> >>> +       if (!conn || !hci_dev_test_flag(hdev, HCI_SSP_ENABLED))
> >>>                   goto unlock;
> >>>
> >>> +       /* Assume remote supports SSP since it has triggered this eve=
nt */
> >>> +       set_bit(HCI_CONN_SSP_ENABLED, &conn->flags);
> >>> +
> >>>           hci_conn_hold(conn);
> >>>
> >>>           if (!hci_dev_test_flag(hdev, HCI_MGMT))
> >>>
> >>>
> >>>> Regards
> >>>> Andrey VOLKOV
> >>>>
> >>>>
> >
> >



--=20
Luiz Augusto von Dentz
