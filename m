Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D356381D3
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 11:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710934991; cv=none; b=V3pKwKc+W/ecMIHvHJjqPC4oUlcYc/myPvSx/doeI8ZdSQmE1BrWkc0Idjqh3sc0YtSvYNyZdY1IEvlrKbuWjvMaMgYHTlHOXp2YfYwm/4vaaZfzwslyqtsxcVbicM292cPJIeVTLSI1bPmq/Yznd9jnvoGfn6tfUIWWXarQ0Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710934991; c=relaxed/simple;
	bh=rAQV6Bdz1Pz9x+hSlilc5rHiJOD2YEWBWohItBtvvKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TYzz8TaHRgUwKFeC6PDU6Uf6/au0V8op4BI5qVnQUm4+LxpOCx14Q8kMtwMPMi3eY4JfarzVBRrF24/dbjBirh7wx7KRz2ghaYSb45ZSinnOrAyviU+l0GvLzliCUHLAA5ehW8icK/nl4lbus4PDS1MDwRytYHM9ys++vRFjMIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWQkpT60; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWQkpT60"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d49f7e5c2cso50783261fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 04:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710934988; x=1711539788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMDlq/PYNgPSXFBPlEAm5PfgdP8B23n/4oN/Y+Xt+YM=;
        b=DWQkpT60xiBY+ImRHc6ACJxt9wliOdAy2FLprDC7SnGMS3DXRrVOdlVoFhlBzz8rze
         GwI4qwb5ID020hxziO53rXXo+s88Pm8usRqoaPXgtmXvZNDFTfroxX68BbLrbqHt7jTN
         KrkFNjZWA150Fp4NhWeIh0f3IXL/jC4y9eJ8AXUAs8yKnILMzlLdXhNKZzvMCSHjvIHv
         sU2pIv9gck2DWyatn/i5TcESPifVAgYFpJVajBZg7s4VJLIGclFE3MDGbR+oGiFyWz7P
         U9OMMMIWFiB2ud62lfOOHkLzRCEYtd2jcDFPKhPf0EZUudbjmDD3JR0l9S142pe+FKAy
         2+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710934988; x=1711539788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMDlq/PYNgPSXFBPlEAm5PfgdP8B23n/4oN/Y+Xt+YM=;
        b=molxnGwh2eLedHwmcpo2gLdDkJ13XgXLRrij4mA188HBOqzOywK0x2NGHV6zl0NnVc
         tjuad9DSXOWvHuO+Y/qS4PDzEKKEdxoHcah7axDurSzy4PCAzOW/865nLuZ/F+GnEn0b
         ppBeZfOLjukJgowpWUmpL6RLl1w+gLe8ZC4h0YE6EZxbLh/tUDFgcG5sntqb5BuYSIny
         hdbKOr2GLz4mQR5OzA5DTOQvr4duve/h9S5BVVh5Cbfm9q9RXX3pOp9xONIMKqTUCvkQ
         uXo/j99n1Rkml7oVFuiplDO007E/uebKLNnJa1KzeGUgGGjFOToNpovklZyZYjZqn/tg
         JJIg==
X-Gm-Message-State: AOJu0YwDvlVemEoTVWvpA0gjWMaKDQU+0Tqv9R+IbYdDyccYMx7nI/Sy
	kttp7V104E+7sqUyk23+vJ/ExWd4dcNTbOhbgltQx9655E4G1TvzY3v1yezX2fGRuJfMuyZVVEo
	MvJwyz4l2MPBp0cLePySOa9hOmh6MjNn4+oS06Q==
X-Google-Smtp-Source: AGHT+IHZJrqri4NpnIsn3FRg2blawrPseU+gy6c2xviFxepyYd+Nh4ytYQtJj6RHFg9g6AcC85D4nuG+LHcHmeHI9WA=
X-Received: by 2002:a2e:850b:0:b0:2d4:74ab:bc36 with SMTP id
 j11-20020a2e850b000000b002d474abbc36mr10878668lji.0.1710934988021; Wed, 20
 Mar 2024 04:43:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318123712.9729-1-mahesh.talewad@nxp.com> <20240318123712.9729-2-mahesh.talewad@nxp.com>
 <CABBYNZKvAmb5JjfxkPADED6CQKD+GxsRqLajHX=w0GE+imhCMA@mail.gmail.com> <AS5PR04MB975486834B434042CE2A693689332@AS5PR04MB9754.eurprd04.prod.outlook.com>
In-Reply-To: <AS5PR04MB975486834B434042CE2A693689332@AS5PR04MB9754.eurprd04.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 Mar 2024 11:42:54 +0000
Message-ID: <CABBYNZK5YS6paOYbx4yL6R7Wt9o+oGrtmfiQNmOaTAUo2DBfdQ@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH BlueZ v1 1/1] LE Create Connection command
 timeout increased to 20 secs from 4 secs
To: Mahesh Talewad <mahesh.talewad@nxp.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, 
	Devyani Godbole <devyani.godbole@nxp.com>, Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mahesh,

On Wed, Mar 20, 2024 at 10:56=E2=80=AFAM Mahesh Talewad <mahesh.talewad@nxp=
.com> wrote:
>
> Hi Luiz,
>
> Yes, its auto connect scenario.
> While running connect disconnect in a loop on one of the chip, we are get=
ting issue with this default timeout . Hence we increased this timeout valu=
e to standard LE timeout i.e 20s.
> Kindly let us know, is there any timeout explicitly defined for the autoc=
onnect in the spec.

What exactly is the issue though, or are you saying it is a controller
issue because the attempts are too closely together when the timeout
is just 4 seconds, note that you are just working around the problem
because users can bypass the default when set via conn->conn_timeout.

> Thanks and regards,
> Mahesh Vithal Talewad
>
> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Wednesday, March 20, 2024 3:21 PM
> To: Mahesh Talewad <mahesh.talewad@nxp.com>
> Cc: linux-bluetooth@vger.kernel.org; Devyani Godbole <devyani.godbole@nxp=
.com>; Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
> Subject: [EXT] Re: [PATCH BlueZ v1 1/1] LE Create Connection command time=
out increased to 20 secs from 4 secs
>
> Caution: This is an external email. Please take care when clicking links =
or opening attachments. When in doubt, report the message using the 'Report=
 this email' button
>
>
> Hi Mahesh,
>
> On Mon, Mar 18, 2024 at 12:37=E2=80=AFPM Mahesh Talewad <mahesh.talewad@n=
xp.com> wrote:
> >
> >  - As per specs LE Connection timeout is 20 secs but in implementation,
> >    it was 4 secs. Hence increased this timeout to 20 Secs.
> >
> > Signed-off-by: Mahesh Talewad <mahesh.talewad@nxp.com>
> > ---
> >  net/bluetooth/hci_event.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 4ae224824012..06fe5f6b9546 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -6067,7 +6067,7 @@ static struct hci_conn *check_pending_le_conn(str=
uct hci_dev *hdev,
> >         }
> >
> >         conn =3D hci_connect_le(hdev, addr, addr_type, addr_resolved,
> > -                             BT_SECURITY_LOW, hdev->def_le_autoconnect=
_timeout,
> > +                             BT_SECURITY_LOW, HCI_LE_CONN_TIMEOUT,
> >                               HCI_ROLE_MASTER);
> >         if (!IS_ERR(conn)) {
> >                 /* If HCI_AUTO_CONN_EXPLICIT is set, conn is already
> > owned
> > --
> > 2.34.1
>
> Afaik this is on purpose since it is the autoconnect procedure, rather th=
an user initiate connection, so are you running into a problem if the timeo=
ut is different?
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
