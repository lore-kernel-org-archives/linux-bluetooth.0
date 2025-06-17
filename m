Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE402225408
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Jun 2025 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171948; cv=none; b=TCT6tJCWLAj3JbMVPvmV97DFAmaT5rB4TTELlld7YIeheC2xIAx29fds6aGHwOYvv04zt+MImwTspD17G93csIGbk2a2lfUkcGE3hQ3ciV4u4JQJXoFjVuWCryd1dliMZV8tx0/g7GJUvtzJAYhI16PUMBLldHX719RecTEHupA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171948; c=relaxed/simple;
	bh=6EoTL/oCV3pM+sj3U467auuQMQ3RJvXVRizlk1Jtgnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAZzjRxoLHS43V5bVY7CQRFsvRyDkh7mUPoWuxz8aaftQ/Ma5eWIxdvMkKI74bSXo6MfaKAQo8g0OBPlL4FJ5kPuetr5ZYr0+yTsrKyk+BbQsRjUAAdJJepws8OKjsd5XY1DZTLSq2qQFyPuYZQ9RIVgiYjn+pxPTUzeyHLHRnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q60SUHtn; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q60SUHtn"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32a9e5b6395so48564191fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Jun 2025 07:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750171945; x=1750776745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kb6/eigFrNOr+hHCUax3XrubnNhpUSJU768nQ1zYDjU=;
        b=Q60SUHtnFKNchRM0V3TcWP5/G6TMwYFnMP7ykSGIX2uPdIirHqftAKYeiV1FeRZjNJ
         Nk+5pKb/VXPLgCMXE0W8wZJ4r1Fz1v/xueYM9Acyqt8UGlAhN8yDIXaULGcxyX/gqpSn
         +YkatorakwO2SzT2WMUVYiGczBTUcZrIiEleJysLZR3KkbKgU45nTXZzkVqK3gNGCFB9
         TJu51V+jxESLl2fJYRSB5RWt208VTXbM6IWYiAwlnuh5tv6Pg+DeO1I16un/ezolpTbC
         oVl0cb/utvduWOWSuHiG+jisE0swf9pPzGFuhzcb+wT1iwQ+pS8T+SCwUl9kGFfCf9Tf
         GmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750171945; x=1750776745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kb6/eigFrNOr+hHCUax3XrubnNhpUSJU768nQ1zYDjU=;
        b=arAVo/Pdmij5xv7QIc+AYAyZ0zecdfD7VxLD0GIGWu4pl3O009fCYSpS9gnyaHdLDA
         vnKRdvOITGaX55lmFpNgbOzt3rTMxPi85goNo1hXmdCQAI20YnMaEqNPnbunK4TJT5pM
         gFQaBH3eJdQZDsfdKCIKw8F++YkqVO8iDOGC4nMjY/AMy86qw5lDKa5LvccOwJWKIv3w
         bfXZXKei2CQEMzc4RhGjY3q5qVAQaZOIHGQ7XNSSBoRZWdOfHq4+mXR5PUT94X9F1y8l
         yQLG15ESs9oIAjQkOzDTnu/HJGle1Uf2stzXG3Zo61V1ozOoTOisDEROBmuwccppO59q
         IMCw==
X-Gm-Message-State: AOJu0Yyad/14Hlw0v7YqAwC6WBSy4Rxo76fqkDIDA3M0NHpke7D/axMo
	lAYuio8NTbYPNS0rj9G3IKO8FuX116kvTLspi/KCoRW4u9DEU2wtoK2oq+xW5S14EuHxMBI05PB
	KKrwS8NIzBpqwrbQKoOjqutYkzHk9LZ8=
X-Gm-Gg: ASbGncufF47lPCyd4kxauvAl3Vp/xo4/QAfY9oRw3BtsR8fiXrGKhWD2okO8mLTa8VG
	P8yAoBsjqRgB47rGPFK68MVJh7nDv1RYJwnaw2zLA5xs0WISMFWQDf+1j4/t4vL8hDaMEaFk1XC
	tftifZ9cCydhTz1oUAGL9dAIfPiBl/SKYdYoWvWzbP8Q==
X-Google-Smtp-Source: AGHT+IFabItbMKxmRWW15m5jL2/dE8rAlA4CXEc/7Zwn00AeoMrqQPxa3fui1yBnNlUlIwBKpBaaDVM3aVPDTDYm2Y8=
X-Received: by 2002:a2e:bb94:0:b0:32b:7123:ec4c with SMTP id
 38308e7fff4ca-32b7123ed58mr5588891fa.38.1750171944362; Tue, 17 Jun 2025
 07:52:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZ+j72ZtXGbE2OmOaNfcoO+XMLS--BnXPwAgmWLh9k=5EA@mail.gmail.com>
 <20250616203506.1047396-1-kuni1840@gmail.com>
In-Reply-To: <20250616203506.1047396-1-kuni1840@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 17 Jun 2025 10:52:11 -0400
X-Gm-Features: AX0GCFv292COv-02RClsJGLweH8JJIo2O4n_YU4aua4wNYS63viTjSygzSAzsfo
Message-ID: <CABBYNZJK2=B5co7geYH2B8Dq13AU1-4bZcm9ypmk6YwZ=-0T6w@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_core: Fix use-after-free in vhci_flush()
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, pav@iki.fi, 
	syzbot+2faa4825e556199361f9@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kuniyuki,

On Mon, Jun 16, 2025 at 4:35=E2=80=AFPM Kuniyuki Iwashima <kuni1840@gmail.c=
om> wrote:
>
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Date: Mon, 16 Jun 2025 15:30:19 -0400
> > Hi Kuniyuki,
> >
> > On Mon, Jun 16, 2025 at 3:20=E2=80=AFPM Kuniyuki Iwashima <kuni1840@gma=
il.com> wrote:
> > >
> > > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > > Date: Mon, 16 Jun 2025 14:56:26 -0400
> > > > Hi Pauli, Kuniyuki,
> > > >
> > > > On Mon, Jun 16, 2025 at 2:12=E2=80=AFPM Pauli Virtanen <pav@iki.fi>=
 wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > ma, 2025-06-16 kello 10:37 -0700, Kuniyuki Iwashima kirjoitti:
> > > > > > From: Kuniyuki Iwashima <kuniyu@google.com>
> > > > > >
> > > > > > syzbot reported use-after-free in vhci_flush() without repro. [=
0]
> > > > > >
> > > > > [clip]
> > > > > > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.=
c
> > > > > > index 07a8b4281a39..d648b514e2df 100644
> > > > > > --- a/net/bluetooth/hci_core.c
> > > > > > +++ b/net/bluetooth/hci_core.c
> > > > > > @@ -64,9 +64,9 @@ static DEFINE_IDA(hci_index_ida);
> > > > > >
> > > > > >  /* Get HCI device by index.
> > > > > >   * Device is held on return. */
> > > > > > -struct hci_dev *hci_dev_get(int index)
> > > > > > +static struct hci_dev *__hci_dev_get(int index, int *srcu_inde=
x)
> > > > > >  {
> > > > > > -     struct hci_dev *hdev =3D NULL, *d;
> > > > > > +     struct hci_dev *hdev =3D NULL;
> > > > > >
> > > > > >       BT_DBG("%d", index);
> > > > > >
> > > > > > @@ -74,9 +74,11 @@ struct hci_dev *hci_dev_get(int index)
> > > > > >               return NULL;
> > > > > >
> > > > > >       read_lock(&hci_dev_list_lock);
> > > > > > -     list_for_each_entry(d, &hci_dev_list, list) {
> > > > > > -             if (d->id =3D=3D index) {
> > > > > > -                     hdev =3D hci_dev_hold(d);
> > > > > > +     list_for_each_entry(hdev, &hci_dev_list, list) {
> > > > > > +             if (hdev->id =3D=3D index) {
> > > > > > +                     hci_dev_hold(hdev);
> > > > > > +                     if (srcu_index)
> > > > > > +                             *srcu_index =3D srcu_read_lock(&h=
dev->srcu);
> > > > > >                       break;
> > > > > >               }
> > > > > >       }
> > > > > > @@ -84,6 +86,22 @@ struct hci_dev *hci_dev_get(int index)
> > > > > >       return hdev;
> > > > > >  }
> > > > >
> > > > > If no list item has `hdev->id =3D=3D index`, doesn't this now ret=
urn the
> > > > > list head -> crash?
> > > >
> > > > Seems wrong to me as well, *d was used to hold the current entry bu=
t
> > > > that has been removed so hdev would be used instead which may retur=
n a
> > > > valid/non-NULL entry even when its index doesn't match. Btw, are th=
ere
> > > > any documentation regarding the usage of SRCU in such cases where
> > > > there are still references?
> > >
> > > I think that's the main use case of SRCU, and basically the use case
> > > is similar to the normal RCU.  There are a bunch of doc under
> > > Documentations/ and I'm not sure what's the best one, but LWN article
> > > would be a nice one to start.
> > >
> > > https://lwn.net/Articles/202847/
> > >
> > > Also, one good example would be rtnl_link_ops_get(), rtnl_link_ops_pu=
t(),
> > > and rtnl_link_unregister().
> >
> > Oh, this indeed looks pretty similar.
> >
> > >
> > > >
> > > > Usually the hci_unregister_dev is called by the driver to inform th=
e
> > > > hardware has been unplugged from the system, so we do want to be ab=
le
> > > > to abort any ongoing usage of the hci_dev so in this particular cas=
e
> > > > perhaps it is easier to just check if HCI_UNREGISTER has been set
> > > > before attempting to flush.
> > >
> > > Maybe like below ?
> > >
> > > I think the downside of this approach would be we need to apply this
> > > change to each driver that has the same issue.
> > >
> > > Note that we need to hold mutex here otherwise there is no guarantee
> > > that another thread does not complete kfree().  I'm not sure if touch=
ing
> > > unregister_dev in non-bluetooth-core code is something we should avoi=
d.
> > >
> > > What do you think ?
> > >
> > > ---8<---
> > > diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhc=
i.c
> > > index 59f4d7bdffdc..3dea1292da2d 100644
> > > --- a/drivers/bluetooth/hci_vhci.c
> > > +++ b/drivers/bluetooth/hci_vhci.c
> > > @@ -66,7 +66,10 @@ static int vhci_flush(struct hci_dev *hdev)
> > >  {
> > >         struct vhci_data *data =3D hci_get_drvdata(hdev);
> > >
> > > -       skb_queue_purge(&data->readq);
> > > +       mutex_lock(&hdev->unregister_lock);
> > > +       if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED))
> > > +               skb_queue_purge(&data->readq);
> > > +       mutex_unlock(&hdev->unregister_lock);
> > >
> > >         return 0;
> > >  }
> > > ---8<---
> >
> > Not quite, I was thinking more along this lines:
> >
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 07a8b4281a39..4c8105ad4885 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -548,7 +548,7 @@ static int hci_dev_do_reset(struct hci_dev *hdev)
> >         hci_conn_hash_flush(hdev);
> >         hci_dev_unlock(hdev);
> >
> > -       if (hdev->flush)
> > +       if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) && hdev->flush)
> >                 hdev->flush(hdev);
>
> I think technically there is still a small race window (and it
> could be large enough with _RT kernel).
>
> CPU1                      CPU2
>                           hci_unregister_dev
> hci_dev_get
> hci_dev_test_flag(hdev, HCI_UNREGISTER)
>                             hci_dev_set_flag(hdev, HCI_UNREGISTER)
>                             list_del(&hdev->list)
>                             kfree(vhci_data)
> hdev->flush(hdev)
>
>
> I'll keep the current form in v3 to fix the use-after-free
> with the mentioned list head bug fixed.

Ok, and how the v3 helps with the situation above? It seems the
assumption is that synchronize_srcu would wait for the thread holding
hci_dev_get_srcu, but what if the order is the reversed? It does seem
like we still need to prevent hci_dev_get_srcu to return the hdev it
is has been unregistered already.

>
>
> >
> >         hci_dev_clear_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
> >
> > Note though, the whole hci_dev_do_reset is actually buggy, to do a
> > proper reset we should probably do hci_power_off_sync +
> > hci_power_on_sync so all the states are properly cleared.



--=20
Luiz Augusto von Dentz
