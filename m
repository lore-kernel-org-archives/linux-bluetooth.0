Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981C6238C24
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186354; cv=none; b=TzinrY7GlAa5UCVGkkW0vy69PSpBUaVC+J+4eP7AR1wdISwpYkXwlg51ibHGbSr9PYmuwfuXFQTlGUiFrE9pUjTaoOUvTLCdKTHZKxahWI2A+vULP64axj9XmlJjOgRkgizO0hQXST3R42l/hH6icOpLZdyAC61+o/Or8rNNpuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186354; c=relaxed/simple;
	bh=tGBuV7uaSm7wqgLBg17X6OH8N750ZBGFWAHnj1SLhVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AK8Frrvrx9QXDgtk5XUSqSeJYDDclbxgsSqrQrI4cwoMOcTe63YQbEEYGjLvJamduBEuL9sOHm9qLOo4Wan0evV4B2BPb3STSJLWgiUuYn0PCePWGW4B5NniAd+hdNDAe1lZj3tdqS1Ui0Md+XjWmiwUDgSUJGuG1GpH8Ku/XTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USq5LxPi; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USq5LxPi"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-333f8d1cbcdso9282651fa.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 08:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755186351; x=1755791151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8lOON8F79yWi9JmFB+ck3YQds6GyUhiNxxzd7ZiD7M=;
        b=USq5LxPiUyJ67+rMJMa7XI/Rh6KMob/QVmned1/MTsZrCNn+dNUB77WtL5fPWCKTvU
         4X3NzwezRvOCo/kvUlNDqujn8/286qzEfIWlv877I8uwy/nj6PBxCABzj1fERunJjfZr
         ac/2KodYnazVWysCVVkRPUk4T+vNH8HPs71u6DsPh1c8gsUnLWJ1lp3DfCOI/5IVdxUe
         QTA8ZrrwVdA6P78jc/kxse3bXYt9hSSXE77jLHJ54tfgIK9sdew1b56q+B/JrQHo/Mnt
         iVb/FocE+OiHNmvusLqHhEUiOlrPmhFwBRKqfYqJ6Uw77NBeuhU7ShAWIiRjKd6uSQxj
         e1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755186351; x=1755791151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8lOON8F79yWi9JmFB+ck3YQds6GyUhiNxxzd7ZiD7M=;
        b=Qoqs+wqZMK+DTx62hD24peYK0l1UNGKfYNVgF0ArSibQ7TdaO4RP9N5nn+muLzHHnE
         jPkaM/3aa7BcbCplHclFVyRviTEOBD+xiVnK74KL8ZjHFr9uNxJa47/yoYeurRZNYpK1
         JN2ch1hHDgAWZkV1YxIDFykm3bruBtlf+8PFPgcDPIRmX0FB1vp3xrxyzzG/uKxGzc2p
         PTNQSC9M5Dxqq/xqZxGfiVNTCpVivJw4mjuVld29D24UcMb+D/NBzLZEskMTgegS0SFp
         yDQB0HFaaIBPnRodWpfOOiYwTDcTZoxE1ZsTc60iwG4XalvcrgvjZ0/FFCNYG58qtXlL
         oO/A==
X-Gm-Message-State: AOJu0YyjDykutp5wVi/q0DC4t2OHDwcCXyEHksS684CrfmKS6xc/zgQJ
	1tQG5AcxaDtEiCxWlCVPa+oSXGjwnlHperfPPBYN0LAuMe3WsKz95L8PbFN6NoAABpjbNgqJFE6
	Q98V+3YFKR3i677lPcnblkcWEavhnNyayo5W3
X-Gm-Gg: ASbGncvLhjwo91z0GbIYChFW/Mvrakw5LNppGlUwyu1P/5GSE320a/2edfs0snfA8tT
	4Y8/jp6SnB/Yj7aU7UfA4yxqudrBfB7d9M1QvrpJ5YC1HYuFlcVikSAQ0EcnDC73WPfjLD+BfK7
	I7gSNr4GNUPcxMKkL+cKLBmJGVumPT6LLWI4rJJ/w1/75WwUZ2j0ZflLCWMBvaIaqgZ3iTUapbi
	3IHRQ==
X-Google-Smtp-Source: AGHT+IEN2ivXbps7A+nN1hoE28vy3t1fmjMicbA2Ti89tjkyDkSrzjUbqNT6U7iqxJSfbS+zUHpN+29zLNq+HTcU+QM=
X-Received: by 2002:a05:651c:1543:b0:333:fdb8:cd8c with SMTP id
 38308e7fff4ca-333fdb8d3efmr7789131fa.9.1755186350517; Thu, 14 Aug 2025
 08:45:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813211511.90866-1-luiz.dentz@gmail.com> <20250813211511.90866-3-luiz.dentz@gmail.com>
 <6311cc4c8ab9a9c5b14d3c4aa1f9b213fd064d6d.camel@iki.fi>
In-Reply-To: <6311cc4c8ab9a9c5b14d3c4aa1f9b213fd064d6d.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 14 Aug 2025 11:45:37 -0400
X-Gm-Features: Ac12FXyfQBisu_j2QG67XKtH9Q1juUvJgbRhu3kDUKD8hJ650tz9SZb6nhN0KdY
Message-ID: <CABBYNZJ7GMu9SO6czMK61AapTgUScZJin5+899WoAQ6cy1jUBg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] Bluetooth: hci_conn: Make unacked packet handling
 more robust
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Thu, Aug 14, 2025 at 11:30=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> ke, 2025-08-13 kello 17:15 -0400, Luiz Augusto von Dentz kirjoitti:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This attempts to make unacked packet handling more robust by detecting
> > if there are no connections left then restore all buffers of the
> > respective pool.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  net/bluetooth/hci_conn.c | 34 ++++++++++++++++++++++++++++------
> >  1 file changed, 28 insertions(+), 6 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index 9d2324eb1211..d2f0c3c0f0ae 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -1151,22 +1151,44 @@ void hci_conn_del(struct hci_conn *conn)
> >       disable_delayed_work_sync(&conn->auto_accept_work);
> >       disable_delayed_work_sync(&conn->idle_work);
> >
> > -     /* Handle unnacked frames */
> > +     /* Handle unnacked frames:
> > +      *
> > +      * - In case there are no connection restore all buffers to the p=
ool
> > +      * - Otherwise restore just the buffers considered in transit for=
 the
> > +      *   hci_conn
> > +      */
> >       switch (conn->type) {
> >       case ACL_LINK:
> > -             hdev->acl_cnt +=3D conn->sent;
> > +             if (!hci_conn_num(hdev, ACL_LINK))
> > +                     hdev->acl_cnt =3D hdev->acl_pkts;
> > +             else
> > +                     hdev->acl_cnt +=3D conn->sent;
> >               break;
> >       case LE_LINK:
> >               cancel_delayed_work(&conn->le_conn_timeout);
> >
> > -             if (hdev->le_pkts)
> > -                     hdev->le_cnt +=3D conn->sent;
> > -             else
> > -                     hdev->acl_cnt +=3D conn->sent;
> > +             if (hdev->le_pkts) {
> > +                     if (!hci_conn_num(hdev, LE_LINK))
> > +                             hdev->le_cnt =3D hdev->le_pkts;
> > +                     else
> > +                             hdev->le_cnt +=3D conn->sent;
> > +             } else {
> > +                     if (!hci_conn_num(hdev, LE_LINK) &&
> > +                         !hci_conn_num(hdev, ACL_LINK))
> > +                             hdev->acl_cnt =3D hdev->acl_pkts;
> > +                     else
> > +                             hdev->acl_cnt +=3D conn->sent;
> > +             }
> >               break;
> >       case CIS_LINK:
> >       case BIS_LINK:
> >       case PA_LINK:
> > +             if (!hci_conn_num(hdev, CIS_LINK) &&
> > +                 !hci_conn_num(hdev, BIS_LINK) &&
> > +                 !hci_conn_num(hdev, PA_LINK))
> > +                     hdev->iso_cnt =3D hdev->iso_pkts;
> > +             else
> > +                     hdev->iso_cnt +=3D conn->sent;
> >               hdev->iso_cnt +=3D conn->sent;
>
> The last hdev->iso_cnt +=3D conn->sent; probably should be removed.

Opps, yeah that is a mistake, will fix that in v5.

> >               break;
> >       }
>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
