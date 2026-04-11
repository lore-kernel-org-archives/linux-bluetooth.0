Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE86929D294
	for <linux-bluetooth@vger.kernel.org>; Sat, 11 Apr 2026 12:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775909149; cv=pass; b=imYHut0dYJZ2aGluHM8xJ/pa0sY4Y8hGnI+YK7UQ5+yOg7n1rKEuCYYhv0YXgzhjS9WqdUi7Py6YTMOO82VwgGRXqk54qp0I4cf2YpOA4pKXiBLXHcJnRbsD6C5Wdvl7tyR9XxE3kyFlVqJPZZ8EPiOLZnXYZgJ3mtHQBWeihGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775909149; c=relaxed/simple;
	bh=bnYs7hk/zbiZf89s3svPbtGrxhjCrGgIQD6M8/qJ3KI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BCJGcSiMta+8L/zv4qVWQ1GXB5j0B9ZssFFuucnGcRW8fXfc8RtqduAzLQeKVX5y8DtyUKP+CB0dOUyqxdpVsomK1T0yw/bN77UYR/p7lPdCFRqEjsVtQYDV7ZoEfJGIuILkp0+fXhtZ1yyqK5AID1zF6MKOTD3GaB1iBad+kbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=doGw+esR; arc=pass smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doGw+esR"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-464bba3a9easo1532723b6e.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Apr 2026 05:05:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775909147; cv=none;
        d=google.com; s=arc-20240605;
        b=OBlAnP3pm9a14HncQjf8mB5LzqqHRWsGeo1t8oNYk0efcoyne8suRD4v2tjEmS08ap
         HQmbtabicNKcyzpXQpgq0uRYsFHY7IIN2X+pB6Lw+Z6z46IYu2jF3Yzoc6JtyCC58qHJ
         aoOFuw2q3wpwK6eCw8w4YRMBnpaD+K7oi910BdxbEEUioDxmvRnjfKV5wJu8ryb87g7j
         sT/nLyRnMUyvT1xG39ShPPMwlWK5RJits2Q+BkMycKeDiErym2BZWd+AhXmoFSOmIebD
         zbvrk9JRL94gKfJZYxm2tV1AirCtXGbQFUuuq9PV6Sd2+aCZsDheFmraspeqbfUluAvO
         YKpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hXPjD6Pld7SvrQkihpkIyAMdKV1V/nyJA/zFqgwvNxE=;
        fh=mArNWb6xiGxVBLOhi3i+xPDVTyLsSY1hAzb/p07qDSc=;
        b=MaACOE7DHFflle55twhF1eOGj5NSPKvfgQ6HO0nZFgPmyLuk3J0nkMwfG+uWv//bWN
         5Kk08NQtv8GPoCiYFq0/rToqUo62dsQ0Fh5gePiPiFmTDqwqiOY5bH/fTmZ2cAbpVoW4
         BCIrwSxqQiNDCeuk60WF67bWLUV8p42Mm+QfuJrTvQs9g23RIZMToBpX1sK0eV9H8xa6
         K/HeNFEDodH1pT2xeO3I8R6bABGFC8O4qrCr61Kjvg9qS5IZcc4n1JfdO39tcWiJdkrz
         rzQukClwSFWPTVmWTwl/hOqd1+oATKBwjtITK5U6MNkUVCzdtUoHljT1qAvGJqZ4NCzW
         2cSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775909147; x=1776513947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXPjD6Pld7SvrQkihpkIyAMdKV1V/nyJA/zFqgwvNxE=;
        b=doGw+esRGuZR+WAK+KAe1d3F4wjaaU6biNTdpcWsmB/DjQVnePI20XN3sNfg2VEoB8
         +sTTLwX8IpOFFQdbhvMG6H+IgyLYw/xGiSdmvG0gBSz/dBO6DCQwed8UNMtCQOtSc+cd
         qIwrNszCUHySz34laR+e9O01n8cdRLfCJfiHWSzcCMvsLMN6kn6Sg7dZ3w+i9sps79qg
         lN37QXTx+QzBZktKyywpAmut3+TvAjMMfwPB5rNu03SyraDn8/NSkvJ9ZFhdQ+HmGT7V
         d8GlgtZb70VKfauYJO0ygIyO5naIRtCYqjhfqx94swubr8R/87rtn9/uBlnRMNdOjBi2
         yAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775909147; x=1776513947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hXPjD6Pld7SvrQkihpkIyAMdKV1V/nyJA/zFqgwvNxE=;
        b=sLnkrO61eykqgDvdeeR4e29RcBFi01VQEUmdcPOB95EWqFYcdNb+wac8YV9HqEXsqF
         OyEL++lsadjiXG1W/riRTKkXjnwMMbhHssZQ+NmatnFRwvJA39UT+W3Ow3JcH71F4Yb6
         QkSh5+VuJEM99QekNh2ltZHE39RX6QPcs/UfpuwYrXKB6wducMUDb6xxTnJd0eSht6F9
         qCYgUHS8B0WxUPVsA71Fp0EA2oR/5MkPAH/cDt+WrjClk94AEnd5APmORZG98sHcI4mi
         yeF8I/6NsIZXuvsC/aCoWMesN0tqGxxSRVEFpJP7szrhdgjjnLfP1RWk4E1xBse25HvJ
         Bh5g==
X-Forwarded-Encrypted: i=1; AJvYcCVVywMfDu0prDIxvemEUg0j1iYe1JbuxwOHdbMgm6HvJDWrEH0zLcMQ8PaeD36ll+5geQ3eApjXcV2G5YhjI20=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH/nFqWgKS6L5FhX7Mc9YWsiNpMnr2VTXYLRHLCVDuAtjo+WaC
	c2Ev8ScRIFtj0P4ioDQba+XpChsxRQM6NCkyEf4CmFXmMMK8JF1QYDizOOgnNypF7gpklnrk6l/
	xqOGwmRLPtCREaYy//Chht9H3IleVJfw=
X-Gm-Gg: AeBDievotIyzR7KrXpcEO+cCgR5uyM2Byy9QvV0PxiBzTmJIlfKrsArR5zN0nHypjpr
	so4zV2OCRmgn77zhx4a2jDkJVOOPS5OWsRgd8mxna8r9HMYLF12899u9IZ6hJeLg2AtfazKMy0z
	nazxXdQM2k0GNfP7NsEqzJQAQe20IPYkf+EK+Ws0g9HVQjQkVeYKwUXIC9Rp4NRdiE6KaOSyABm
	ZLCbI6unTv1i5N4zkhvohOlvcp++8BiyKKEe/bZh13wNSRvNP7kE8sjl9/12jJS4jQJV9vrtQbz
	LytWjHf5KNPJusFIfW4FSso6p3bCpAzv/hQN7g==
X-Received: by 2002:a05:6808:2e45:b0:467:237e:ba47 with SMTP id
 5614622812f47-4789d63f7d7mr3557542b6e.1.1775909146659; Sat, 11 Apr 2026
 05:05:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410201343.229470-1-luiz.dentz@gmail.com> <c8a8aca1bb455d72e5e902b4ae0487947457b0e6.camel@iki.fi>
In-Reply-To: <c8a8aca1bb455d72e5e902b4ae0487947457b0e6.camel@iki.fi>
From: David CARLIER <devnexen@gmail.com>
Date: Sat, 11 Apr 2026 13:05:35 +0100
X-Gm-Features: AQROBzDYzmV-fGYlpnNfzagmAaCR47P1cI6JXgLc8VuY-uoRfiOjqwJhOhtZICI
Message-ID: <CA+XhMqxYgJZGTK=nncdGJM0D-1rdJuENePO0e7Akkw81CU4tQg@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: hci_conn: fix potential UAF in create_big_sync
To: Pauli Virtanen <pav@iki.fi>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

  Good catch. I think you're right =E2=80=94 hci_conn_del() ends up in
hci_conn_hash_del() which does list_del_rcu() + synchronize_rcu() on
hdev->conn_hash, so the call really
  does want hdev->lock held around it, not just a refcount keeping the
object allocated.

  Wrapping the hci_connect_cfm() / hci_conn_del() pair in
hci_dev_lock() and re-checking hci_conn_valid() inside the critical
section would also bring
  create_big_complete() in line with what create_le_conn_complete()
and create_pa_complete() already do, which is nice for consistency.

  The lockdep_assert_held(&hdev->lock) in hci_conn_del() sounds
reasonable as a follow-up =E2=80=94 it'd catch exactly this kind of thing. =
I
can take a look at whether all
  existing call sites already satisfy it before proposing it separately.

  Luiz, let me know if you'd like me to respin, or whether you prefer
to fold it into a v4 yourself.

Cheers !

On Sat, 11 Apr 2026 at 12:07, Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> pe, 2026-04-10 kello 16:13 -0400, Luiz Augusto von Dentz kirjoitti:
> > From: David Carlier <devnexen@gmail.com>
> >
> > Add hci_conn_valid() check in create_big_sync() to detect stale
> > connections before proceeding with BIG creation. Fix
> > create_big_complete() to handle the resulting -ECANCELED error
> > and validate the connection under hci_dev_lock() before
> > dereferencing, following the established pattern used by
> > create_le_conn_complete() and create_pa_complete().
> >
> > Without this, create_big_complete() would unconditionally
> > dereference the stale conn pointer on error, causing a
> > use-after-free via hci_connect_cfm() and hci_conn_del().
> >
> > Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS conn=
ections")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  net/bluetooth/hci_conn.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index 3a0592599086..7e6b3542809c 100644
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
> >       if (qos->bcast.out.phys =3D=3D BIT(1))
> >               flags |=3D MGMT_ADV_FLAG_SEC_2M;
> >
> > @@ -2204,11 +2207,17 @@ static void create_big_complete(struct hci_dev =
*hdev, void *data, int err)
> >
> >       bt_dev_dbg(hdev, "conn %p", conn);
> >
> > +     if (err =3D=3D -ECANCELED)
> > +             goto done;
> > +
> >       if (err) {
> >               bt_dev_err(hdev, "Unable to create BIG: %d", err);
> >               hci_connect_cfm(conn, err);
> >               hci_conn_del(conn);
>
> hci_conn_del() is called without hci_dev_lock() here.
>
> It probably should take the lock and check hci_conn_valid() inside the
> critical section before calling into hci_conn_del().
>
> Probably hci_conn_del() should have lockdep_assert_held(&hdev->lock)
>
> >       }
> > +
> > +done:
> > +     hci_conn_put(conn);
> >  }
> >
> >  struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst, __u=
8 sid,
> > @@ -2336,10 +2345,11 @@ struct hci_conn *hci_connect_bis(struct hci_dev=
 *hdev, bdaddr_t *dst,
> >                                BT_BOUND, &data);
> >
> >       /* Queue start periodic advertising and create BIG */
> > -     err =3D hci_cmd_sync_queue(hdev, create_big_sync, conn,
> > +     err =3D hci_cmd_sync_queue(hdev, create_big_sync, hci_conn_get(co=
nn),
> >                                create_big_complete);
> >       if (err < 0) {
> >               hci_conn_drop(conn);
> > +             hci_conn_put(conn);
> >               return ERR_PTR(err);
> >       }
> >
>
> --
> Pauli Virtanen
