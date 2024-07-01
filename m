Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161E6167288
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jul 2024 14:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719843052; cv=none; b=CT3NmYpQYZI5pDKIC0m1Fp3elEao2JwNEWNDQ5FoMKXVKuJZupnI2jyzlxmhXZA1UULm6C/tDr5/GKey9L/KFBVfbf9C1oH6SaOt4ucnnc1Nv91fvkCBwtpMOP2H/6x2lxJKu3UJyO2cSzQEEJkUnTKs2HQIx6rr9f8pkthZfS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719843052; c=relaxed/simple;
	bh=U2TwBnP8suGUiR860t4bd7SvpCg1OZLgZSZy3Igmmv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PFcKrTf5IRvBb7gP7RH/Z3y2M1uVsXSpG226qj0WpRoFFL+rcua+QONR4B1erlrEan4dezzY34N/zAGcz0ciDrkWA2GQ+QxDTobqSd1ywKvoMI1/XBAELFQ4vaOqesiLZ/DKweIPa8bHCdAyFMftsfFBkVe5E2ngf8J2btR4LTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1C7dxWd; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1C7dxWd"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ed5ac077f5so36217931fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jul 2024 07:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719843049; x=1720447849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkGmwhGtXK/kQusY3fnpAU2R2fYKjxvbZo6Lv3neKiM=;
        b=A1C7dxWdZ1khbqoagAreFei1SGwrrB3t9/+wMFHvvAwTZmXurjbCiz2UpRQICvDGBT
         58JGEUc0V14tZS/n2sUb6z9IjfZTvkPYQaYPV1JZB70B3Inm2NBhnOaCCqXEfXy/QDzx
         fa7u00/t9cyPIbLikQGST+dhFs/31ko4xmub2ZRpRzHSXxVrUa12PiS0d8tu1KZKMbWV
         hUeb83Kxe8Lkms8IRJOX9mbQFZrnmpdnb98siH6UOrchi8iPoCh35Q8XwHrlD6SU5Xe3
         CpwyuaLMRw/u00oJjL7q5JRY38qj0BvHvIu2OZFwISnpz8iZdK4Jh4+5AaRLrzeeI+1L
         CrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719843049; x=1720447849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BkGmwhGtXK/kQusY3fnpAU2R2fYKjxvbZo6Lv3neKiM=;
        b=vnxNNl+9DPMFbgkEc4smZWCsDV/mxvqGKKL3PBJloXUF2ENYER7wP36qHxZZdwh9wf
         y2k2EUwBtfI0Rr35Bk+GBNg/6bp1Ow2I8ZSebK3LqQ3er45cHWjOBOM/R0FB5OkGPjUQ
         FvQcY42E65poKni22fOnc+H8+uQfl8W8h6LM7F2ss8/nk7b754y7bK35HoCricAUeA9o
         68OvB0vaPSZQFNkppLQ4XVUy2O+I3opcG/i/cQXQxON/meAz3QZXDvc92aQa6+jsekpa
         j2jq6bOpR8OWQJ+C5oi22vZnyqnLNS5AmFqFkU+7bQg7dYA7/svrkc9dhIluu4TdUePD
         aMhQ==
X-Gm-Message-State: AOJu0YwQBLtcdw7zIlFMt5rkSsxOS0hmm3WsqyBQ4BkGD/8m7japP8NH
	rPdjd2+TuXwWRbS+D4mqHxU/UuwH80pDbvwUdqkMiGiyiep9u2+34nmEGxuCX4zyWm+KpmNo4qZ
	oJ8ZCtZz0QxgplUPI7rXPCd3l7Wo=
X-Google-Smtp-Source: AGHT+IGaynqAvCbj+Xq5+OB21dDQ1+gvjUwwG4zZOqauqTQEu/Gs/YVNnEoOJgwkz6uUzn7JnaJL/m0sAqvV1eBavy4=
X-Received: by 2002:a05:651c:503:b0:2ec:5128:184c with SMTP id
 38308e7fff4ca-2ee5e3595f1mr40491081fa.11.1719843048985; Mon, 01 Jul 2024
 07:10:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628072342.2256-1-quic_prathm@quicinc.com>
 <CABBYNZJ7RfPu61tt7R-nrUfZX1DnSY73KS84p9QiyTW7WDpfXQ@mail.gmail.com> <5e3186e5-0ec3-41e2-985e-f2609a4a9fd5@quicinc.com>
In-Reply-To: <5e3186e5-0ec3-41e2-985e-f2609a4a9fd5@quicinc.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 1 Jul 2024 10:10:36 -0400
Message-ID: <CABBYNZKmqjZ_1oQTrF7+EB=tzv5AfAjQ9jUAw4Nf1NOXPjMHEg@mail.gmail.com>
Subject: Re: [PATCH v1] Added BREDR not supported bit in AD Flag when
 discoverable is off
To: Prathibha Madugonde <quic_prathm@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 1, 2024 at 7:03=E2=80=AFAM Prathibha Madugonde
<quic_prathm@quicinc.com> wrote:
>
>
>
> On 6/28/2024 7:08 PM, Luiz Augusto von Dentz wrote:
> > Hi,
> >
> > On Fri, Jun 28, 2024 at 3:24=E2=80=AFAM <quic_prathm@quicinc.com> wrote=
:
> >>
> >> From: Prathibha Madugonde <quic_prathm@quicinc.com>
> >>
> >> Fix for GAP/DISC/NONM/BV-02-C
> >> As per GAP.TS.p44 test spec
> >> IUT does not contain General Discoverable mode and Limited Discoverabl=
e
> >> mode in the AD Type Flag. IUT shall send AD Type Flag to PASS the test
> >> case, thus added BR/EDR not supported bit in the AD Type Flag when
> >> discoverable is off.
> >>
> >> Signed-off-by: Prathibha Madugonde <quic_prathm@quicinc.com>
> >> ---
> >>   src/advertising.c | 16 ++++++++++++++++
> >>   1 file changed, 16 insertions(+)
> >>
> >> diff --git a/src/advertising.c b/src/advertising.c
> >> index 5d373e088..9857ceceb 100644
> >> --- a/src/advertising.c
> >> +++ b/src/advertising.c
> >> @@ -1444,6 +1444,7 @@ static DBusMessage *parse_advertisement(struct b=
td_adv_client *client)
> >>   {
> >>          struct adv_parser *parser;
> >>          int err;
> >> +       uint8_t flags;
> >>
> >>          for (parser =3D parsers; parser && parser->name; parser++) {
> >>                  DBusMessageIter iter;
> >> @@ -1499,6 +1500,21 @@ static DBusMessage *parse_advertisement(struct =
btd_adv_client *client)
> >>                  goto fail;
> >>          }
> >>
> >> +       if (!btd_adapter_get_discoverable(client->manager->adapter)) {
> >> +               /* GAP.TS.p44 Test Spec GAP/DISC/NONM/BV-02-C
> >> +                * page 158:
> >> +                * IUT does not contain
> >> +                * =E2=80=98LE General Discoverable Mode=E2=80=99 flag=
 or the
> >> +                * =E2=80=98LE Limited Discoverable Mode=E2=80=99 flag=
 in the Flags AD Type
> >> +                * But AD Flag Type should be there for the test case =
to
> >> +                * PASS. Thus BR/EDR Not Supported BIT shall be includ=
ed
> >> +                * in the AD Type flag.
> >> +                */
> >> +               flags =3D bt_ad_get_flags(client->data);
> >> +               flags |=3D BT_AD_FLAG_NO_BREDR;
> >> +               bt_ad_add_flags(client->data, &flags, 1);
> >> +       }
> >
> > I think we would be much better off using broadcaster role for such a
> > test case or does it require to be connectable? Anyway I don't think
> > there is a requirement to disable BR/EDR when not discoverable, so if
> > we really need to pass specific flags then perhaps it would be better
> > to create a Flags property so clients can set themselves.
> >
> Hi,
> This particular test case require IUT to be in connectable. There is
> already code snippet to disable BR/EDR when adapter is not discoverable
> in the set_flags() like below.
>         /* Set BR/EDR Not Supported if adapter is not discoverable but
>          * the instance is.
>          */
>         if ((flags & (BT_AD_FLAG_GENERAL | BT_AD_FLAG_LIMITED)) &&
>                         !btd_adapter_get_discoverable(client->manager->ad=
apter))
>                 flags |=3D BT_AD_FLAG_NO_BREDR;
>
> Hence using the same logic. Currently AD flags(BT_AD_FLAG_LIMITED,
> BT_AD_FLAG_GENERAL & BT_AD_FLAG_NO_BREDR) is managed based on properties
> discoverable, discoverable timeout and adapter discoverable.

Oh, in that case why didn't you change that statement? Anyway, the PTS
requiring the use of flags is rather unconventional here but I think
it should be fine not marking BR/EDR support if it is not
discoverable.

> --
> Prathibha Madugonde
>
>
> >>          err =3D refresh_advertisement(client, add_adv_callback);
> >>
> >>          if (!err)
> >> --
> >> 2.17.1
> >>
> >
> >



--=20
Luiz Augusto von Dentz
