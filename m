Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BE61DF247
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186295; cv=none; b=ScytGvI5NaJ45c4KtJL0ZiBM3QezKbJ3f5LrCEvja+vX9PI19FY2vqYUoMOHRMp34NskFi8LsJ8LXf1HIwFzB+J1SX9EQFcL5T8BPlM/tMiON+g74lDWKY45FS6i0RcFXaJTE7wbLbWFqknmJb/NG0Siov9jgFV4tf4apxDpqNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186295; c=relaxed/simple;
	bh=P2CTZ4AtjhIisOKNwSLZ0FGIjDKfACHagiIdE0MTXQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vjk47pvoKTVPNycBSA1ADkLDoSitnNdb+gzIM/j2Tzb7KiWbfMn+0CaNm43AozweTKcKlwrQg0WoqaZogJhhDW1DpIcUv3TA71Ub/O9seu9Zqxw1v+nWRNWAs2YjdcwaLrIyphbBRbXHPF+U5ygwDLBYhotD0TKsd04vtyeGTmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKKts5yH; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKKts5yH"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-333e7517adcso19083001fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 08:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755186292; x=1755791092; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NXMbEjVFMImCNQUdKNJzAMJi8CrUU3DYmjDvCxNMNQ=;
        b=hKKts5yHy2G/z/zB8PreBSiJ4kjZpZgy8IRF6KLQqW/wPXt3BfJPTQG0rCL5H2tBO9
         8ms5Hlsu6xATbG3+PlqiuSEINJ+GFJnjmREguqy9ZcuU0SR+KKKwYwl+gKYI4i/6O0Lp
         X7hAQRM0rcItX602yD/rqsbbvZ1KD5uDn76GNEU2CvrnO6vLKTQlDKujSe5EaGHaE0GR
         F9F5o/x1olAKH67JUJ2bqUPCuxeHjZxyZuRCrtvPjBWkf4RJi3BeOgufG2VBBbxoAfT0
         OcKPrkn9Yf8MyTh/yLl2pXnEGh6qiKc00y2/XTg3r9ipSp17/upWcNSA5FfMyC4SmDbh
         V6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755186292; x=1755791092;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NXMbEjVFMImCNQUdKNJzAMJi8CrUU3DYmjDvCxNMNQ=;
        b=gFUL2BkQMIoO82STL4UlButGjEYWoYuRuCIQWyZd1dIuU9xREJGiduOdPhXh6FkS8T
         MY+37IPuDcG5Q9PU3O1uNwvT8zWvaR6ygna3n1YeX4GDf9xX/dnZhJek2opBTtvE85EF
         Hoc+mObSvvPxTSTJg+qCLIpPRObaa6r1k9dgBLgtXdsyyShiQ1wsfiX5FfcCHwkoEfne
         /kE/9B9yMSBtTNxJ5jdkt6cEuqnNhulwh5UcCO4433Q8TzEXexCV3tBrwMW7Hw36zoCt
         bW7EkxW8zKyMkU9zAMm5PEBedWAZm9MlKVzdDUqhpqihgF4n0iDkrazFzfklktMxOZPK
         +/Kw==
X-Gm-Message-State: AOJu0YyY8OIh8GSEK37yvn+Z4UFe3zFo9BYLyylscQri99hDdDwxWZpT
	oiVV1x7zj6akW6HfzCQTDrz7n0VF6loVu9rZ4Dfh9CyIjQg25WzEt2Jfy9emXEBzle42lJ0rXPI
	gO0y8e+WkuaazK6z96YVDIvR5pQgRbbuCN6+R
X-Gm-Gg: ASbGncuW4ohx4RS1Tb/oiAtpqzUKdh3ePkOkiYvkZTPwHJ/CBnw/9IY+BYt8mq2YFTb
	sPU3HK6RX1xVv2DBEmzvaXVeoIR6EzlAdDLnbyo/7oLl3Zv2vf0tY9m84iNzWwyyV3ngt2ArCd1
	sLpVPz1vOhsgE3r7dssa6PvAizy6EM78bZPubCNfbdDZZFcXGAw53TCVdCriAcT+sdIusQ3fP2/
	B39KQlmslCpqUQb
X-Google-Smtp-Source: AGHT+IF+vB4FPhgymhFUSYfbdQMALHNP4shVcByRLyWYh3FeSWFEAMEaQBFO39ts1mg5eXYZsA3tKO3eydggTBRSj08=
X-Received: by 2002:a2e:8859:0:b0:331:e799:978f with SMTP id
 38308e7fff4ca-333fac8c623mr6520911fa.8.1755186291526; Thu, 14 Aug 2025
 08:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813211511.90866-1-luiz.dentz@gmail.com> <09686fe95fd6d79c9b271d6366bcd6dc4f890480.camel@iki.fi>
In-Reply-To: <09686fe95fd6d79c9b271d6366bcd6dc4f890480.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 14 Aug 2025 11:44:38 -0400
X-Gm-Features: Ac12FXxHvCxfLOZ2xWN_p4AkNnXqRH5VdPJfCDltI-RspU-3ieHVfJXIa687ELE
Message-ID: <CABBYNZ+iR5ta8WZugfOJaNaqcNMG4yV4q7RHAhUQN_X+f1x2Cw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] Bluetooth: ISO: Don't initiate CIS connections if
 there are no buffers
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Thu, Aug 14, 2025 at 11:26=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> ke, 2025-08-13 kello 17:15 -0400, Luiz Augusto von Dentz kirjoitti:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > If the controller has no buffers left return -ENOBUFF to indicate that
> > iso_cnt might be out of sync.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  net/bluetooth/iso.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> > index 5ce823ca3aaf..dff3fc4917d6 100644
> > --- a/net/bluetooth/iso.c
> > +++ b/net/bluetooth/iso.c
> > @@ -458,6 +458,13 @@ static int iso_connect_cis(struct sock *sk)
> >               goto unlock;
> >       }
> >
> > +     /* Check if there are available buffers for output/TX. */
> > +     if (iso_pi(sk)->qos.ucast.out.sdu && !hci_conn_num(hdev, CIS_LINK=
) &&
> > +         (hdev->iso_pkts && !hdev->iso_cnt)) {
>
> Also && !hci_conn_num(hdev, BIS_LINK) so it doesn't fail if a BIS is
> saturating the buffers?

Right, will add that on v5.

> Does PA_LINK have ISO packet TX/RX?

Don't think so but since it is used while establishing the BIS I guess
it is safer that we check that as well.

> > +             err =3D -ENOBUFS;
> > +             goto unlock;
> > +     }
> > +
> >       /* Just bind if DEFER_SETUP has been set */
> >       if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
> >               hcon =3D hci_bind_cis(hdev, &iso_pi(sk)->dst,
>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
