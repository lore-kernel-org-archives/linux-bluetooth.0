Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ED12DFF15
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Jun 2025 16:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750178112; cv=none; b=Hx/FuwEzRsZ8CxsmoEtfOGA1+h7yCmM6+8/3WtUCRn1Bf+vl5AtFZHemvuIcpO/FTiKb/2TB0ra2gkvL85iQxn4JsVdsWhqAQr63Owf9wC9NDA689CacuqAfhIIwDZUtka8G7dzz2Z4iCdDMjelAdlNKYF563/SpugcR9r7QLD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750178112; c=relaxed/simple;
	bh=ZuXiRsE1QR5Kqf9mAm8GclyENOTS3rkczJ0NhHNAWao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHw2IMnAMk66ampJuNa/rwND0m3mnmXQywUO8KH4otpEl9DgZAnd6qJGSi3Qk2KLBowRhdaJGS8hJlOEMTHxteXkrLfGU/9yLefsfmMOuZEQt35fF83eIvGxSKSyIRBvAwETqoVXiSTdaeKW/4S9ZNKMaNvBpOumt/Cf/kmWttU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpJ7K83Q; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpJ7K83Q"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32925727810so51063711fa.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Jun 2025 09:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750178108; x=1750782908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDwRI44CMG4ZUfiUReL4lh+/DMMfxeEiF09BfMXgO0c=;
        b=CpJ7K83QGk6sOG1pimE5UEikmoVfOg/nDL4BmSwOnxO2loD0UJHgUSgo8A7h0uHJGA
         TYp4QslXF1lhXEpUQRzIOCN9/ag02uRaBkDEIssYo6DZ9n7N6GQLZKbtwg33TLFjKGam
         zMGY61wCueFIy0H/uu/+KOuF3mz35WjW4syj+c10AnjjVI1FnCNWyU/77FOwJHU4UqJe
         3pT2NnQtALaUIe9iOCNwSkav2VAmEZJ/k0Ry9MVIw1BxvcGMjb+jpf+5VRc5dt0cRMLg
         8nn5u473mo8YnXptTuk4Ms5wkasWdilIkfs45qCH3S5xN8DqXLxIEHoaH8YaQFyU5Z7a
         5qiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750178108; x=1750782908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDwRI44CMG4ZUfiUReL4lh+/DMMfxeEiF09BfMXgO0c=;
        b=v8Xq3EX+Q+cM1NpTSMcpkg3308sRsOmvDHuifG5GKHpFel60jb5YJ3UK4GUSwpfDWx
         tfRwSyhV2BHucZ5mcLBIo2J8b6vSCnedYU4cUQD99rUG5quy6e0af0cMwVafh8EQNrzH
         BQO7TUWZLvmNw/pEVEYlOqcFNg4fbW1G0W81jvxyoWll8Dqni68fkXMiSpMzFYT+GubA
         fp8Ldj3Yl67EYPu0+pG49wWNMFAXbSQy62NMCOdAP6DeuRwHS8y2F4Z9MKmibLkyqFKp
         6nRDHCCR8S+Nt/Hg6ORxODB8rXYzPAtMwCjP2FDLXdJOhXgTkN2ocCyf0eMiTvpFzreu
         RRFw==
X-Gm-Message-State: AOJu0YysFVhO79LkXAL00g91CgsMHnfONVfV4HKcC1Lc7sBbH4zXu0lK
	S68Ol4UnoGCfHR+9AmpR0a3qVA77nxTy1fdVpXmU64tzAj3fo9yqdcvaK6WAPxshrGY2dtOjLGo
	4zL1a4kWYUbc8IOlPkmkWm6yI7EBRQLCEOXqh
X-Gm-Gg: ASbGnct78NfwglT1U3MbqIK8WghTm5Bjstx1xtp7CjH4Cn88bCgb8Q6tTeXeQxuYQVr
	fk/mD/ZCig3NQU0qtYfsbNJw+Mudb0PC/an1C+F1Sab4dDmQp703eFVlRwr99aVV/S6GeEsFp/c
	VGoqskIiWBVu4H4ZBzSDaPmgR+I1jgrJyWCKT7UG4ifQ==
X-Google-Smtp-Source: AGHT+IHfvjtFGizCIkouKgmMZtfCkL2KORAPIGnImLhZYeRGFP2UPbB96dYx1kKoQWFZOMvEk8imjOzaitbEOhw1LyM=
X-Received: by 2002:a2e:bc1a:0:b0:32a:869e:4c13 with SMTP id
 38308e7fff4ca-32b4a42a4f3mr34891571fa.14.1750178107967; Tue, 17 Jun 2025
 09:35:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZJK2=B5co7geYH2B8Dq13AU1-4bZcm9ypmk6YwZ=-0T6w@mail.gmail.com>
 <20250617162836.1738956-1-kuni1840@gmail.com>
In-Reply-To: <20250617162836.1738956-1-kuni1840@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 17 Jun 2025 12:34:45 -0400
X-Gm-Features: AX0GCFuNXrBRsLv19L2kHDmg471Wqodaa-FRWcuAsATXwST64CoF37yojzSK8uY
Message-ID: <CABBYNZLdBDAvyWwCYPY+0BfBnRqu52toHuYzmHD3ppDj0bxvGw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_core: Fix use-after-free in vhci_flush()
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, pav@iki.fi, 
	syzbot+2faa4825e556199361f9@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kuniyuki,

On Tue, Jun 17, 2025 at 12:28=E2=80=AFPM Kuniyuki Iwashima <kuni1840@gmail.=
com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Date: Tue, 17 Jun 2025 10:52:11 -0400
> > Hi Kuniyuki,
> >
> > On Mon, Jun 16, 2025 at 4:35=E2=80=AFPM Kuniyuki Iwashima <kuni1840@gma=
il.com> wrote:
> > >
> > > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > > Date: Mon, 16 Jun 2025 15:30:19 -0400
> > > > Hi Kuniyuki,
> > > >
> > > > On Mon, Jun 16, 2025 at 3:20=E2=80=AFPM Kuniyuki Iwashima <kuni1840=
@gmail.com> wrote:
> > > > >
> > > > > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > > > > Date: Mon, 16 Jun 2025 14:56:26 -0400
> > > > > > Hi Pauli, Kuniyuki,
> > > > > >
> > > > > > On Mon, Jun 16, 2025 at 2:12=E2=80=AFPM Pauli Virtanen <pav@iki=
.fi> wrote:
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > ma, 2025-06-16 kello 10:37 -0700, Kuniyuki Iwashima kirjoitti=
:
> > > > > > > > From: Kuniyuki Iwashima <kuniyu@google.com>
> > > > > > > >
> > > > > > > > syzbot reported use-after-free in vhci_flush() without repr=
o. [0]
> > > > > > > >
> > > > > > > [clip]
> > > > > > > > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_c=
ore.c
> > > > > > > > index 07a8b4281a39..d648b514e2df 100644
> > > > > > > > --- a/net/bluetooth/hci_core.c
> > > > > > > > +++ b/net/bluetooth/hci_core.c
> > > > > > > > @@ -64,9 +64,9 @@ static DEFINE_IDA(hci_index_ida);
> > > > > > > >
> > > > > > > >  /* Get HCI device by index.
> > > > > > > >   * Device is held on return. */
> > > > > > > > -struct hci_dev *hci_dev_get(int index)
> > > > > > > > +static struct hci_dev *__hci_dev_get(int index, int *srcu_=
index)
> > > > > > > >  {
> > > > > > > > -     struct hci_dev *hdev =3D NULL, *d;
> > > > > > > > +     struct hci_dev *hdev =3D NULL;
> > > > > > > >
> > > > > > > >       BT_DBG("%d", index);
> > > > > > > >
> > > > > > > > @@ -74,9 +74,11 @@ struct hci_dev *hci_dev_get(int index)
> > > > > > > >               return NULL;
> > > > > > > >
> > > > > > > >       read_lock(&hci_dev_list_lock);
> > > > > > > > -     list_for_each_entry(d, &hci_dev_list, list) {
> > > > > > > > -             if (d->id =3D=3D index) {
> > > > > > > > -                     hdev =3D hci_dev_hold(d);
> > > > > > > > +     list_for_each_entry(hdev, &hci_dev_list, list) {
> > > > > > > > +             if (hdev->id =3D=3D index) {
> > > > > > > > +                     hci_dev_hold(hdev);
> > > > > > > > +                     if (srcu_index)
> > > > > > > > +                             *srcu_index =3D srcu_read_loc=
k(&hdev->srcu);
> > > > > > > >                       break;
> > > > > > > >               }
> > > > > > > >       }
> > > > > > > > @@ -84,6 +86,22 @@ struct hci_dev *hci_dev_get(int index)
> > > > > > > >       return hdev;
> > > > > > > >  }
> > > > > > >
> > > > > > > If no list item has `hdev->id =3D=3D index`, doesn't this now=
 return the
> > > > > > > list head -> crash?
> > > > > >
> > > > > > Seems wrong to me as well, *d was used to hold the current entr=
y but
> > > > > > that has been removed so hdev would be used instead which may r=
eturn a
> > > > > > valid/non-NULL entry even when its index doesn't match. Btw, ar=
e there
> > > > > > any documentation regarding the usage of SRCU in such cases whe=
re
> > > > > > there are still references?
> > > > >
> > > > > I think that's the main use case of SRCU, and basically the use c=
ase
> > > > > is similar to the normal RCU.  There are a bunch of doc under
> > > > > Documentations/ and I'm not sure what's the best one, but LWN art=
icle
> > > > > would be a nice one to start.
> > > > >
> > > > > https://lwn.net/Articles/202847/
> > > > >
> > > > > Also, one good example would be rtnl_link_ops_get(), rtnl_link_op=
s_put(),
> > > > > and rtnl_link_unregister().
> > > >
> > > > Oh, this indeed looks pretty similar.
> > > >
> > > > >
> > > > > >
> > > > > > Usually the hci_unregister_dev is called by the driver to infor=
m the
> > > > > > hardware has been unplugged from the system, so we do want to b=
e able
> > > > > > to abort any ongoing usage of the hci_dev so in this particular=
 case
> > > > > > perhaps it is easier to just check if HCI_UNREGISTER has been s=
et
> > > > > > before attempting to flush.
> > > > >
> > > > > Maybe like below ?
> > > > >
> > > > > I think the downside of this approach would be we need to apply t=
his
> > > > > change to each driver that has the same issue.
> > > > >
> > > > > Note that we need to hold mutex here otherwise there is no guaran=
tee
> > > > > that another thread does not complete kfree().  I'm not sure if t=
ouching
> > > > > unregister_dev in non-bluetooth-core code is something we should =
avoid.
> > > > >
> > > > > What do you think ?
> > > > >
> > > > > ---8<---
> > > > > diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci=
_vhci.c
> > > > > index 59f4d7bdffdc..3dea1292da2d 100644
> > > > > --- a/drivers/bluetooth/hci_vhci.c
> > > > > +++ b/drivers/bluetooth/hci_vhci.c
> > > > > @@ -66,7 +66,10 @@ static int vhci_flush(struct hci_dev *hdev)
> > > > >  {
> > > > >         struct vhci_data *data =3D hci_get_drvdata(hdev);
> > > > >
> > > > > -       skb_queue_purge(&data->readq);
> > > > > +       mutex_lock(&hdev->unregister_lock);
> > > > > +       if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED))
> > > > > +               skb_queue_purge(&data->readq);
> > > > > +       mutex_unlock(&hdev->unregister_lock);
> > > > >
> > > > >         return 0;
> > > > >  }
> > > > > ---8<---
> > > >
> > > > Not quite, I was thinking more along this lines:
> > > >
> > > > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > > > index 07a8b4281a39..4c8105ad4885 100644
> > > > --- a/net/bluetooth/hci_core.c
> > > > +++ b/net/bluetooth/hci_core.c
> > > > @@ -548,7 +548,7 @@ static int hci_dev_do_reset(struct hci_dev *hde=
v)
> > > >         hci_conn_hash_flush(hdev);
> > > >         hci_dev_unlock(hdev);
> > > >
> > > > -       if (hdev->flush)
> > > > +       if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) && hdev->flush=
)
> > > >                 hdev->flush(hdev);
> > >
> > > I think technically there is still a small race window (and it
> > > could be large enough with _RT kernel).
> > >
> > > CPU1                      CPU2
> > >                           hci_unregister_dev
> > > hci_dev_get
> > > hci_dev_test_flag(hdev, HCI_UNREGISTER)
> > >                             hci_dev_set_flag(hdev, HCI_UNREGISTER)
> > >                             list_del(&hdev->list)
> > >                             kfree(vhci_data)
> > > hdev->flush(hdev)
> > >
> > >
> > > I'll keep the current form in v3 to fix the use-after-free
> > > with the mentioned list head bug fixed.
> >
> > Ok, and how the v3 helps with the situation above? It seems the
> > assumption is that synchronize_srcu would wait for the thread holding
> > hci_dev_get_srcu, but what if the order is the reversed? It does seem
> > like we still need to prevent hci_dev_get_srcu to return the hdev it
> > is has been unregistered already.
>
> It is never reversed as hci_dev_get_srcu() and hci_unregister_dev()
> hold hci_dev_list_lock.
>
> So, if hci_dev_get_srcu() finds a hdev, it's always after that that
> the hdev is un-listed by hci_unregister_dev(), and synchronize_srcu()
> follows it.

Right, I forgot hci_unregister_dev does actually remove the hdev from
the list hci_dev_list, alright then we just need to sort out the
removal of the temporary variable pointed by Pauli, so please spin a
v4 once you fix that.
--=20
Luiz Augusto von Dentz
