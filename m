Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AFC3A1A0
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2024 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721055967; cv=none; b=V5PrkGOxtk+B7tDuew13dC6Xc/sWWXnucT2oNwrd0FgUeQ2bTE40BCBzlnpDRfoNqbeUj2h0CNvT2XO8IE0gbh55RwSR7i9cGmOcunmx0G7/d70dlNLBJbYlfbYh8QY4UVqoyfKDyIiP4amFOanAdG7QXrfsY+sYVwhkivx/XNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721055967; c=relaxed/simple;
	bh=OarshQdpgun2Eko3exFcFkbJtCPzB4iYaDfwBO+tvT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUDJNaZkvp3McCsKh04uRIdvjKSHAA0tihVSHxKeI7hdaI0E4W1AUvot4w1eVc2JltJ4amqMTUUAGwR14QPg/e8UD2Y3CUkRyIVkek+YpivEYD1Ctf7mj5RzhgZR8qj9ghMYny9ObdpWw01Cb0+kNo34PHhWrpZyWYXk9hpq5wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3hJQ9v5; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3hJQ9v5"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2eede876fbfso25847111fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2024 08:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721055963; x=1721660763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGxkWY3Wq2HIgHX3FUIVhpsuRil8pINRPL0+4PliUxg=;
        b=A3hJQ9v5bNl5gcsl+aUkHYw/ZpUhDIhW8teX8F4E9IOqz5NjzFsxTysucv7QDm0Xwf
         PuX4+P4fFquWhcKjbBH6e1S9chxfkH1SwU00VNt4SGpnBsYwPr0r8B1FR05qxcZy7GC0
         jK2xJMg/slz0desIUnQm6h5MGtK/HlrhsVO52w9IfgKXA3XJeyCwK1fW3kJHVusXxv5Z
         vn8iHiTRhtBKcUZiN8LQ/sfBmKDrT1EZXT0kpdJcVEzJVNpgG2yPFcTLybyQhPF8R9Et
         56C41c5S01vXWYyq5U7O08jYc3QGMx0yLKejEotsmE+UHKkTPWiKRhsgEJtq2ZQbMzTq
         0WXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721055963; x=1721660763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGxkWY3Wq2HIgHX3FUIVhpsuRil8pINRPL0+4PliUxg=;
        b=SYq0tIoo/AFHtg0IymQm7o379XvjB0wdTEj7Dqjj7TqNsOx8lZKENADodr2YQt+2fr
         YRTOPTAdBXubiJBn5r1+vFDlIZqx0Cty/nKw38PVRnNJb0vittvI7ahfKi9rfW5HjX7E
         5hU04iQ+v2G5xZGkUmIn3z9pcqSWQ1ouoJZVUE91ojC7/7+cCOegcKobjzkwQi5wTupe
         gGzHdWqT6o+sIVZF2uc8dAlyLsGIwfy0YfGXr1pLBqirNVcwDLJW1uneSLMLpaNmEDce
         gOR+kZ9GTb6/N4uTzJKw1VNL5xdAMI3owCaaFa0Pj3eojX8zdjHLKgi/QUDo8zYkAy5j
         Qi+A==
X-Gm-Message-State: AOJu0YxNLsiqMp5++VQLTGa5iIQPL8tkmmY2RGDQAk7SUMkOS5lqkjAZ
	0Kg8ilwPdWU9R8deNjoT8t2n9T2BgMYgKMOyPhTfUuGI7iwD765Y8LxjdYqSoY1oy1EhYnJ0VCv
	MbFVS4DrS2Bjo1mafGHEYTiVEhWo=
X-Google-Smtp-Source: AGHT+IGtnVRvTjBzObr/41cjoVBz2y1ND6u+2bWlieYsvHqDvXXIHJSDbM1+2FAXfwKf/GXdNG3nWVxQUDRMtNN/3QA=
X-Received: by 2002:a2e:9e82:0:b0:2ee:896d:2408 with SMTP id
 38308e7fff4ca-2eef2dc3e97mr931661fa.37.1721055962970; Mon, 15 Jul 2024
 08:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715144730.311392-1-luiz.dentz@gmail.com> <4fd7e7bc-43de-4a67-bff0-889fc0b24fdd@molgen.mpg.de>
In-Reply-To: <4fd7e7bc-43de-4a67-bff0-889fc0b24fdd@molgen.mpg.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 15 Jul 2024 11:05:50 -0400
Message-ID: <CABBYNZKiu1TM50+ddrc0PmJj6PHOQAC5cheEabRSXE_9E4d_fA@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Fix suspending with wrong filter policy
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Mon, Jul 15, 2024 at 11:00=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de=
> wrote:
>
> Dear Luiz,
>
>
> Thank you for the patch.
>
> Am 15.07.24 um 16:47 schrieb Luiz Augusto von Dentz:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > When suspending the scan filter policy cannot be 0x00 (no acceptlist)
> > since that means the host has to process every advertisement report
> > waking up the system, so this attempt to check if hdev is marked as
>
> attempt*s*
>
> > suspended and the resulting filter policy would be 0x00 (no acceptlist)
>
> =E2=80=A6 *if* the =E2=80=A6?
>
> > then skip passive scanning.
> >
> > Note: This disables remote wakeup for devices using privacy when LL
> > privacy is not enabled since that would require the controller to
> > resolve the addresses.
>
> Would that regress certain use-cases?

Not apart from what is already stated which is sort of a broke
behavior since any advertisement would result in the system being
woken up which was never the intention. Anyway we do have CI test
cases to cover such regressions.

> > Fixes: 182ee45da083 ("Bluetooth: hci_sync: Rework hci_suspend_notifier"=
)
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >   net/bluetooth/hci_sync.c | 7 +++++++
> >   1 file changed, 7 insertions(+)
> >
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index cd2ed16da8a4..0996f159c675 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -2976,6 +2976,13 @@ static int hci_passive_scan_sync(struct hci_dev =
*hdev)
> >        */
> >       filter_policy =3D hci_update_accept_list_sync(hdev);
> >
> > +     /* If suspended and filter_policy set to 0x00 (no acceptlist) the=
n
> > +      * passive scanning cannot be started since that would require th=
e host
> > +      * to be wakeup.
>
> to be woken up
>
> > +      */
> > +     if (hdev->suspended && !filter_policy)
> > +             return 0;
> > +
> >       /* When the controller is using random resolvable addresses and
> >        * with that having LE privacy enabled, then controllers with
> >        * Extended Scanner Filter Policies support can now enable suppor=
t
>
>
> Kind regards,
>
> Paul



--=20
Luiz Augusto von Dentz
