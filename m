Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF572FD685
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jan 2026 19:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899177; cv=none; b=n7L29lj/a/oBDpiJbv9eUuQGQRL+O6r8s+jzVtM7Enn045zNSRbJ4CfYdj7UFb3qAxZgypnVGJo1wnpaO1xPsLtAHsNkmhDPhiQqssLkZlbCmrFD4233Uh3l4slu7IylJmrfX76HveLL4pG+MvvFPaQ/98SLkK9zlJO+UBRGHuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899177; c=relaxed/simple;
	bh=20zjwS44AExE4eXjuyHV23AhOjxdaim/HoPcedqKHsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d1EzN0C96USI3GqOWIt0RE7tyCA6HdTFHs4SkLE+ZjXAkEgVNrahDVegr4zIiYcYYUMI0aa8RQcDurQOO+y/Xf6xol2yfXtQ8ady8wQpkyjZchbA4P1oEMH30AHuiDbJ/bqDxlxlhtW+SkE68qYmjhSr8p163RmUj4DCJRunW4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bk7mL9qJ; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bk7mL9qJ"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6468f0d5b1cso3163374d50.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Jan 2026 11:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767899173; x=1768503973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wnl5D24QKOu/+5ky5V6nwZ3NDEVkWZNkybNGSKxL3Os=;
        b=bk7mL9qJ/LXUQzL/wYXPCGQ3mI7FtIcTmHk/WB36Y5KNmFk9wlg2X9Y+fM9Uwxj4m6
         raXumR5ibPXSa6y6e45ApGTHeyl3QLotyInOwB4ZK4L8C3+Fd30DeP6ZFAPT1eY4HFPd
         nLcPmwze7woapDYIx7mWk+0vx/ZvXhnNPR+Ddj/0GJO3mSvgmfXnmwRKRrqRjvBMZYD+
         rlgXCsJ5EbBi4ZF5CAKDqhoWi0nGiqAmoxxzv/6/utDMxErj+sh29gRMYMw3cclHvHbJ
         s7yjNxsSB6snEiFkjyA27VpxjgADIayQyay1Mt7zAe1bybrSgrP6W4Bsx4mmHJoJQxBA
         NiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767899173; x=1768503973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wnl5D24QKOu/+5ky5V6nwZ3NDEVkWZNkybNGSKxL3Os=;
        b=fsyZCd/1J6+4wCZIbkc6kzAmmvoNs50hrBE/DWdYP4hMMJ1CXsoc6xcW3gknRtY2IE
         vTge0cgbK6lS9SqcuWPcKbYRmJSLA+LvatemFbKRDH9Vml0PyoXI8naG5hEr13bEDxYU
         mBl0zjOpi0s7gQkxh7Zs4d38yU3Wt/20TFvZx35B2TxjyirDxhJsKArLGl2/NBjSTKJI
         PeMYx6sLbad4Nsck4j+uAF/lR4vQhyTbq1X3ySLmvEPhSnkSHlbosfdb41P7YJgD1/cF
         PksSXAJWR2hIWTGAbBLhpWmmSkHDdm9zM2vZWmR+GNDVZCEwE4/9zebALrME3KJ1dRTs
         k0xw==
X-Gm-Message-State: AOJu0YwmkOcZI4okg8oSw8iisYxedq1SNEs12euzHztI9mNxZ09H/b27
	sQ/54qigBhT1KrygASQYHG30c49NX7//q0WvbuuvUQiT2kpma0CGXMboraiFYecmsF26Eyv30m0
	gjOlK2G6f+8H2PqJ3r2AP0qmMpfeipZM=
X-Gm-Gg: AY/fxX53UNwEqT7JsXuAWiK4g1dxO9F7Pe9FKHTG/NGgqs8lKIlIfFu56EORRnGBzyq
	gc/PUOlfaUyw7Dvau+g93260zYGqtVfWR9IIKYHvZnm3Fdgtyj/+sysmkzeKMTPyU3otCyWTr0U
	pqTesKPeiXpqeAftObjJOFtpcY8rB2O6VhfLYgmUMSLi5Sty1n/dqk04iCQW6pl/tJlMSnSbaR8
	sCMPwv++jSJ5rBvCbDC8kXnbjXQksGFWH0jMmIvGbXi0aHM4faRxW3etQmB8R84myP6riZGvj0U
	Jtu5scQy8IWLbE3Y8BQaQPqHDQ1o/DiLZQ+jTlnf/lM0K0w5tC9N15Ojp/zBirSRvw==
X-Google-Smtp-Source: AGHT+IE+0B+j1xvcZmlmjeClVaCOy+JbvmE+tv+GFn9F9eb4xnQ+k8P6qsNICmByzW1B4qFLkN0F0QYli2m2wgvyi9E=
X-Received: by 2002:a53:e02a:0:b0:644:6af1:1922 with SMTP id
 956f58d0204a3-64716c44f99mr5186865d50.53.1767899172847; Thu, 08 Jan 2026
 11:06:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108100136.486675-1-dalegaard@gmail.com> <CABBYNZLfjWHAUorAmRvam+2NnGqRw0HF50XBoQNEXVEdzpQBjQ@mail.gmail.com>
 <CAJWtJbZAa+_2rR6dh9W9FiEBvvj2x7O4A5cCE2-czgPddAB7PA@mail.gmail.com>
In-Reply-To: <CAJWtJbZAa+_2rR6dh9W9FiEBvvj2x7O4A5cCE2-czgPddAB7PA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 8 Jan 2026 14:06:01 -0500
X-Gm-Features: AQt7F2odWt1m9f6TOEo3p3IKhg1QB3IyvGiaTbiVq5lwtejFw06ke8q4puqHNNw
Message-ID: <CABBYNZLcbKqTN-nare0_nphzHLfWN-MMTPyo4x92bTRSqg11Hg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] gatt-client: fix use-after-free
To: Lasse Dalegaard <dalegaard@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lasse,

On Thu, Jan 8, 2026 at 1:46=E2=80=AFPM Lasse Dalegaard <dalegaard@gmail.com=
> wrote:
>
> Hi Luiz,
>
> On Thu, Jan 8, 2026 at 4:23=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Lasse,
> >
> > On Thu, Jan 8, 2026 at 5:56=E2=80=AFAM Lasse Dalegaard <dalegaard@gmail=
.com> wrote:
> > >
> > > Clients with an acquired characteristic subscription would free the
> > > client during disconnect. When notify_io_destroy then tries to remove
> > > the client, it'll use-after-free.
> > >
> > > Add another reference when allocating the notify_io and unref it agai=
n
> > > in notify_io_destroy.
> >
> > Please add a backtrace to the patch description.
>
> Are you looking for backtraces on how this was discovered or something el=
se?
> There could be multiple paths that cause the use-after-free.

How you discovered it

> >
> > > ---
> > >  src/gatt-client.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/src/gatt-client.c b/src/gatt-client.c
> > > index 44ec95db0..374e67c34 100644
> > > --- a/src/gatt-client.c
> > > +++ b/src/gatt-client.c
> > > @@ -1566,6 +1566,7 @@ static void notify_io_destroy(void *data)
> > >
> > >         if (queue_remove(client->chrc->notify_clients, client))
> > >                 notify_client_unref(client);
> > > +       notify_client_unref(client);
> > >  }
> > >
> > >  static DBusMessage *characteristic_acquire_notify(DBusConnection *co=
nn,
> > > @@ -1607,7 +1608,7 @@ static DBusMessage *characteristic_acquire_noti=
fy(DBusConnection *conn,
> > >         queue_push_tail(chrc->notify_clients, client);
> > >
> > >         chrc->notify_io =3D new0(struct sock_io, 1);
> > > -       chrc->notify_io->data =3D client;
> > > +       chrc->notify_io->data =3D notify_client_ref(client);
> > >         chrc->notify_io->msg =3D dbus_message_ref(msg);
> > >         chrc->notify_io->destroy =3D notify_io_destroy;
> > >
> > > --
> > > 2.52.0
> > >
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
> Best regards,
> Lasse



--=20
Luiz Augusto von Dentz
