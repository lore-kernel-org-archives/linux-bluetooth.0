Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1298F23F431
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Apr 2026 04:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775881012; cv=pass; b=Dt3xy9vBAkf9XPvAXRucu3/ueHfqj9ghLRdczNDncBSW1/RswjrbwTTiCo6QXB34r1fbJYo3oQTl9mj7sEtfB//ioG/ky2cLy4GwSLdDsgnPLlNhng80St8C33rukk7wGAzSfKt6HqkdDl4RapmjNbpaa9ixXFGgnlaKSC1jUxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775881012; c=relaxed/simple;
	bh=ZMAoOt1wkcOGigQ5e6NiEBofNEla2Sg1fNPkp6tYBhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vr9VDYkilnkCMOI2VTRF0TxTbSH8cg7Tgb/snf9H1g3wnKWHh3kvcRnnecSfFIvYRZHdBXdZliq+bUOXZ1J47T2Gq4W/nay6RINRAC4t4keO8QCyM/kmrFFimiBOp8qX/wIGYagz9kiJqaeBcCgH9JbhHjq2HH6bLvqJ9vBCYDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJpqzEwi; arc=pass smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJpqzEwi"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-46aa216a5edso1653906b6e.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 21:16:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775881009; cv=none;
        d=google.com; s=arc-20240605;
        b=YvIJZ01qrmDVZRf+DHjjXQGYeMcf+nrSiYjbvRGuN6DIpUhpTg5Lq+zhXIfBePhzXA
         bxfXPkqYW3knNPKm8dkTL0dW6bNEL+3vZePaDSVh/olOI6vhfD3vEzvMFxTwlox7wrP4
         fRjsLRwxGbKRb+BRUcEEmLKnfL+/nr8L3Cx/dWSIFNts3fg8cU4Kao2S7r/EBQKy791W
         HqQdrK6nHA/OP8kWd/E3ewFLOoZ9qB7bD7FU5qQV5BYJkth0g5671djtHKSvLKPdacVa
         HyqbcYyoL5rFolvk2C+pEjBYkIaAc7TYE4q38LkOwOFw8VEJVmRK57DKdN0Eqm2nhpJV
         sjfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=twjEd1gufnLRO0nKS7zAkNbwWPdfTOTUCeT//oVlRls=;
        fh=NmBhMI53ajuFHVzymOoaaLdN/ec7n6bdCdupQlBgmYw=;
        b=hPWq2bA+SS0GvsW9d2/Z01DRI+R8oxaDYvdjypEEor4Qg9HOMyP4A9E7uUE65wxdv9
         o25dRByFZWKrx+kOUgWiO+JB76pFKgobitsrQZZW2GSaFZ/libukn/ecwiZaExatiKop
         AawXB/s0NbVsN1HNJ8KtWrxm8mZsztyMn8VjuH13sA5CtLdZrA3uvs8I29mBGA+yEaSD
         /isGTZigRkVhOdtzK1Q6cgjbO7jzBtZmDWUfrnlh4YZVDXANUvuupqNZ9GZ4ss8jniwA
         I1LLyqD3l9Eu8a2USLjjoGkT3kUJtSvu004AkubRmYui+6aXogQQbq061t1HN7B6iPup
         ww7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775881009; x=1776485809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twjEd1gufnLRO0nKS7zAkNbwWPdfTOTUCeT//oVlRls=;
        b=WJpqzEwinr9lE6CEoNj29POPjf2x/6cZ1CS6A6zRRposSzvUtFdko1wVJxg88XcxUZ
         tqvaxqW31KcDfwV3fydAKmhIN9aHKFcAUnhbvbTRzJa+m0LUsbtdtY1ZA1ZRetFCNvRh
         wVGvhtdi78prPCdmRZLk4VsT0Nf0+24N2yEvX6nbLn5v/ASbSKEdT8HZngzpy4DnlnGM
         40y63zPrVGCR23zZDQNXpKJiW9l0GDLePaZ8cfaBPtaho9yBJvU2mIBowheIYraKY3dJ
         7gQsdTxzIdKzmGyHW0mJUS2FjRIf0Ob1d9z8yRnAQWXbAm8P4uZvu/SgnjGVdRfvZw3w
         jtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775881009; x=1776485809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=twjEd1gufnLRO0nKS7zAkNbwWPdfTOTUCeT//oVlRls=;
        b=mGhvNP4INt21aapoMlDbXqCqshUZQjBCPcVk1KFpdarFDSnSMfXnovFMP+JsHSx7ar
         Zn1DZVw0b1ggjlQ63h0i5xq8WsD1ngReC5Ndggvp8jjDDgdzPAC1usiDDohXbxXuZTZo
         zZtYpJDAeYH7u1DqcoGSjpo6KtrzGvl1E/q4RjJJM7/Y8ege8HewJhsp8+fbf47ZGbrE
         Ad71WLX1kHNQ7ZrGV0IxYYJy+BkWEQnNA69+23A9TRQUOta3V/CWLZ2kgZ21PbdV9FED
         yF1wxm9FUZQJnFDG0S8/0LMM+/ZQw+9Z1rbIjIobB764r08Y7pGXceXcUSD86LX8CZkv
         PgCg==
X-Forwarded-Encrypted: i=1; AJvYcCWMcB6f/ygNEcqWZj+bAKT9qmnVCEclWXRVt9i4dpxJUFHm4IFDeLa7sXz4Qf4JO22YLx99OOAOshTJo/loDMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrcHQgiYCT834yHDIx8l2EjdzHr/nRxVaUDqNr8SwKlhF5hr2K
	2sEOjlGsxsnu84cwAYAJPNVphKSfT587lbvAZm6MdBzoTxTPyTQWyxfb7xhfi+7TcxZYNdpZuR6
	WyKqJJmM+taz5peyMm09uqrWFM9Pf/I2w4Yn7szvFcQ==
X-Gm-Gg: AeBDiesGm6AiKssXM8FBH6Xd0uSBU4UpBNnaE+wiVp4hAf1PSIHeuiR4PsvJQuiACxj
	MOwcfiISfl0Pc0Jhfl9iI8f9gMkbFDSoK19DpiZK9vZIJNfaP+M1EfX5+dAismLVxhkGGcGG762
	6mdN+7agoRmrHphqULqAuF3iFCeoRNls4oumW4xU644YBi93e6fkM23f/4VxyDGj0e5vpOV9DM4
	RDFoRz2AN6Fj1tmU+kVaHs4UlIiOSq21eePSHqdVRjpzu9C8bpuTVAAXfb6pklO+jhUVwfdU9Q1
	3yX4GwWT1ib1Ckg7vR2ChxGTiKNNG2g1E1UKzg==
X-Received: by 2002:a05:6808:c2b4:b0:45c:881c:e0c0 with SMTP id
 5614622812f47-4789f905c23mr3400091b6e.47.1775881008948; Fri, 10 Apr 2026
 21:16:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410173451.4797-1-devnexen@gmail.com> <eb7a2494-eadb-4801-a12e-68f537bfc94d@molgen.mpg.de>
In-Reply-To: <eb7a2494-eadb-4801-a12e-68f537bfc94d@molgen.mpg.de>
From: David CARLIER <devnexen@gmail.com>
Date: Sat, 11 Apr 2026 05:16:37 +0100
X-Gm-Features: AQROBzB5wNWqO-H31WnQxEe0oVHgscgvRrm-wDp9TRnfVf0eiHEvvwosysq5Ytg
Message-ID: <CA+XhMqx+anKJvtGM4NrYTEVAWgY1K_FNnic+GgBNj3dtpaKB5Q@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] Bluetooth: hci_conn: fix potential UAF in create_big_sync
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

  Thanks a lot for taking the time to look at this.

  > (Using 75 characters per line would save a line.)

  Good catch, I'll rewrap it in v3.

  > I wonder if a debug message about the stale connection would be
useful.

  Yes, that makes sense =E2=80=94 I'll add a bt_dev_dbg() right before the
  -ECANCELED return so it's visible when debugging.

  > gemini/gemini-3.1-pro-preview comments [1]:
  > > Could this introduce a time-of-check to time-of-use race
condition?
  > [ ... ]

  I had the same reflex when I first looked at it, but I think the tool
  is reading the check in isolation. The hci_conn_valid() at the top
of
  a *_sync callback is really just a "did this connection get torn down
  before the work ran?" guard =E2=80=94 it's the same idiom already used by
  hci_le_create_conn_sync(), hci_le_pa_create_sync() and
  hci_le_big_create_sync() in hci_sync.c. It was never meant to fully
  serialize against a concurrent hci_conn_del().

  The piece that actually closes the UAF in v2 is in
  create_big_complete(): it now takes hci_dev_lock() and re-validates
  conn before dereferencing it, which mirrors what
create_pa_complete()
  does. That's the part doing the real work here.

  If there's a genuine strict-TOCTOU window between the valid check and
  the &conn->iso_qos access inside create_big_sync(), it would equally
  affect every other *_sync user of the same idiom, so I'd rather not
  try to rework that in this fix =E2=80=94 happy to revisit it separately i=
f
  you think it's worth digging into.

  > > + if (err =3D=3D -ECANCELED)
  > > +         return;
  >
  > Should the error message still be printed in this case?

  I went back and forth on that one. In the end I kept it silent to
  stay consistent with create_pa_complete() in hci_sync.c, which also
  just returns on -ECANCELED without logging. Happy to add a print if
  you'd rather have one, though.

  I'll send a v3 with the rewrap and the debug message in a timely manner.

Cheers !

On Fri, 10 Apr 2026 at 21:25, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear David,
>
>
> Thank you for the patch.
>
> Am 10.04.26 um 19:34 schrieb David Carlier:
> > Add hci_conn_valid() check in create_big_sync() to detect stale
> > connections before proceeding with BIG creation. Fix
> > create_big_complete() to handle the resulting -ECANCELED error
> > and validate the connection under hci_dev_lock() before
> > dereferencing, following the established pattern used by
> > create_le_conn_complete() and create_pa_complete().
>
> (Using 75 characters per line would save a line.)
>
> > Without this, create_big_complete() would unconditionally
> > dereference the stale conn pointer on error, causing a
> > use-after-free via hci_connect_cfm() and hci_conn_del().
> >
> > Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS conn=
ections")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > ---
> >
> > v1 -> v2: fix create_big_complete() to handle -ECANCELED and
> >    validate conn under hci_dev_lock(), matching the pattern in
> >    create_le_conn_complete() and create_pa_complete().
> > v1: https://lore.kernel.org/r/20260408155638.95927-1-devnexen@gmail.com
> >   net/bluetooth/hci_conn.c | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> >
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index 11d3ad8d2551..feebe933efc8 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -2130,6 +2130,9 @@ static int create_big_sync(struct hci_dev *hdev, =
void *data)
> >       u32 flags =3D 0;
> >       int err;
> >
> > +     if (!hci_conn_valid(hdev, conn))
> > +             return -ECANCELED;
> > +
>
> I wonder if a debug message about the stale connection would be useful.
>
> gemini/gemini-3.1-pro-preview comments [1]:
>
> > Could this introduce a time-of-check to time-of-use race condition?
> > Because create_big_sync() executes asynchronously in the cmd_sync_work
> > workqueue without holding hci_dev_lock(), hci_conn_valid() only protect=
s
> > the lookup for the duration of its internal rcu_read_lock().
> > If a concurrent thread acquires hci_dev_lock() and calls hci_conn_del()
> > immediately after hci_conn_valid() returns true:
> > cpu 1
> > create_big_sync()
> >     if (!hci_conn_valid(hdev, conn))
> >         return -ECANCELED;
> > cpu 2
> > hci_dev_lock(hdev);
> > hci_conn_del(conn);
> > hci_dev_unlock(hdev);
> > cpu 1
> >     if (qos->bcast.out.phys =3D=3D BIT(1))
> > Will this lead to a use-after-free on the conn pointer since qos resolv=
es
> > to &conn->iso_qos?
> > Additionally, since conn is passed to the workqueue without holding a
> > reference via hci_conn_get(), could this be susceptible to a pointer re=
use
> > problem?
> > If the original connection is freed and the memory is reallocated for a
> > new, unrelated connection before the work runs, hci_conn_valid() might
> > incorrectly return true. This could cause the new connection to be wron=
gly
> > operated on or deleted later in create_big_complete().
> > Does the caller queueing the work need to take a proper reference with
> > hci_conn_get() and release it in the completion callback instead?
> > [ ... ]
>
>
>
> >       if (qos->bcast.out.phys =3D=3D BIT(1))
> >               flags |=3D MGMT_ADV_FLAG_SEC_2M;
> >
> > @@ -2204,11 +2207,22 @@ static void create_big_complete(struct hci_dev =
*hdev, void *data, int err)
> >
> >       bt_dev_dbg(hdev, "conn %p", conn);
> >
> > +     if (err =3D=3D -ECANCELED)
> > +             return;
>
> Should the error message still be printed in this case?
>
>      bt_dev_err(hdev, "Unable to create BIG: ECANCELED");
>
> > +
> > +     hci_dev_lock(hdev);
> > +
> > +     if (!hci_conn_valid(hdev, conn))
> > +             goto done;
> > +
> >       if (err) {
> >               bt_dev_err(hdev, "Unable to create BIG: %d", err);
> >               hci_connect_cfm(conn, err);
> >               hci_conn_del(conn);
> >       }
> > +
> > +done:
> > +     hci_dev_unlock(hdev);
> >   }
> >
> >   struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __=
u8 sid,
>
>
> Kind regards,
>
> Paul
>
>
> [1]:
> https://sashiko.dev/#/patchset/20260410173451.4797-1-devnexen%40gmail.com
