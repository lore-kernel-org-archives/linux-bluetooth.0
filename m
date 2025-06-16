Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5E8BA42
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 19:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750102236; cv=none; b=KipKrCSk8MP+t5qoZIAtQT9MFxVUReItWqMpgs9t7+kkbXzdTHY0mY7mCHZdrfVoIvzFE4QtobUFLiWNqH0Rv0iYwYukE3DHAWHAhnthR8D7J+G+MN/mnql9dXMOuPdVd6QQnOndbCoYqq+PNh6/UPPmsk+Y3Tv/WgMpq1vKUqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750102236; c=relaxed/simple;
	bh=EWahS6MRA2GMXRmLw3cOz6vsFXvnkwYjELPv2WaiDx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pLcKXrEcpqD7H2nOV0rbIaCJL7aW1/bVSDhidpI3QKq5fn6AMFxU36dCA4D3/wNr3gUn4jqEhpk+NOEBOu+pJVMyPfa4pWby/qLTTWUMCOfGLB5Ic+tlZ83Lsy0kvG2OjB8w8dPVDS5sBncfyV97FkOIzB9zK+wz9dtXVc4P9Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVhES6wm; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVhES6wm"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32addf54a00so40360791fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 12:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750102232; x=1750707032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfGdryXOZAIiBD2F0Pxa4l8XSj9ggyA46NX4+su4WSQ=;
        b=PVhES6wm4bZhrEbGoHGuTcRei/0QX2HPCPGKUSDtC2uZSqk61FyS0D6T+Zz5FeMPis
         LQTC2MqNnBDqa0cjgBPFL7wszyCIs3k5KwezTw2lp8n7+hubCZl5S2TgR04lszOU7B+N
         EQS+Xgx0+w8haDV3Kvhkp5VJI1o1dKgfVUh94x8j7KwLvGqwg9NPNrDomVKh9IGMGR2V
         1N8xjlLqChhC7ZiNi37ww3n/W0M3x6pd3KleC4f76u+T5T4iqLkqvms4hEkobJ14KBVY
         4mVLoiNd2qC+KKNM43lGOeO80FvLBGpwvViUJy9Ek8478BeFlHKQPxjFADeSJmEInM5X
         hchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750102232; x=1750707032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfGdryXOZAIiBD2F0Pxa4l8XSj9ggyA46NX4+su4WSQ=;
        b=ECoa0HVIEwDZW5Nsj6hBJzQQ5UYGUegzTmRHa1qAL30DrwFCrtrkLhGy0UFNt5rxFA
         RIHtsOleVHsxmJ+WolFx7M470yrH0f7Wj+aYhOUWCKaEhK7LS4hCoW71vzkVupyE8eai
         6GB34vWw+2svDe1dwumknZZVZeREmfPUpNBU7EpRp34Q1BDkQAvKMmmN3ffY7EeKxg1o
         maVv2BFPzO+qtzGU0P9fdGi/LAlOqgEey7YFr9xiolAbBLcLM4hQx9Xc2+a/eROFYUEL
         cL2zGk8y/sKFR3SQr1qRjinFEHlbXFzy3zOHeHmIE/RLebzffkBfH+I0e39e97drMUaA
         TMPw==
X-Gm-Message-State: AOJu0YxIvsDXiHbZkyPF9npG1/PpG/AHk2t2dP5+LHvHSWz1Re3h0/6V
	OTathKa/dkXy9igoQQ0AdlaitNVFWpOFCUwIlEeAYAG2fvewCbmUVBxDqyDKn50w6B4QYtuoMX0
	Nuw698iFzV+Ho6FuLwvbIN1EONgKGKB8=
X-Gm-Gg: ASbGncu8uXvefLH+m+9bK6LV3W8QjzBz2BEU4hcKkyq+ilp3KNwBfrqAxKsOw2Gf6Nf
	mNZ55HH8lwyOl8vYF31YdDl1MKvAkSBD//F6yiX6coKIc03w0q+dnimB1BbQjLH4kfAmCS0Hcxv
	rlWyyIQGmEV08LEWu843faCeNTh/A3LJbAanF5ulR7PbU2Xzqw+wbP
X-Google-Smtp-Source: AGHT+IEoh1M8ur2GPHsmagxA/PEwNEXgl7rxvjxacgMzIKemYIiPuMCDtVSZWw/okSvZMznFV1wZUjuJLmzq68mnZV0=
X-Received: by 2002:a05:651c:1544:b0:32a:78f7:9bef with SMTP id
 38308e7fff4ca-32b4a2da70fmr28667861fa.8.1750102231971; Mon, 16 Jun 2025
 12:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZJ0Vggb5J68PBEkv3CzLBO7YoBrqcMvJ-tU_aMghVgBMQ@mail.gmail.com>
 <20250616191959.1001730-1-kuni1840@gmail.com>
In-Reply-To: <20250616191959.1001730-1-kuni1840@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 16 Jun 2025 15:30:19 -0400
X-Gm-Features: AX0GCFsZo8B0sPzLIe9JMwQ7f4aVjN2trIElZEKjgyvGxbTyRR8DvEhJJIJkrdw
Message-ID: <CABBYNZ+j72ZtXGbE2OmOaNfcoO+XMLS--BnXPwAgmWLh9k=5EA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_core: Fix use-after-free in vhci_flush()
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, pav@iki.fi, 
	syzbot+2faa4825e556199361f9@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kuniyuki,

On Mon, Jun 16, 2025 at 3:20=E2=80=AFPM Kuniyuki Iwashima <kuni1840@gmail.c=
om> wrote:
>
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Date: Mon, 16 Jun 2025 14:56:26 -0400
> > Hi Pauli, Kuniyuki,
> >
> > On Mon, Jun 16, 2025 at 2:12=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wro=
te:
> > >
> > > Hi,
> > >
> > > ma, 2025-06-16 kello 10:37 -0700, Kuniyuki Iwashima kirjoitti:
> > > > From: Kuniyuki Iwashima <kuniyu@google.com>
> > > >
> > > > syzbot reported use-after-free in vhci_flush() without repro. [0]
> > > >
> > > [clip]
> > > > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > > > index 07a8b4281a39..d648b514e2df 100644
> > > > --- a/net/bluetooth/hci_core.c
> > > > +++ b/net/bluetooth/hci_core.c
> > > > @@ -64,9 +64,9 @@ static DEFINE_IDA(hci_index_ida);
> > > >
> > > >  /* Get HCI device by index.
> > > >   * Device is held on return. */
> > > > -struct hci_dev *hci_dev_get(int index)
> > > > +static struct hci_dev *__hci_dev_get(int index, int *srcu_index)
> > > >  {
> > > > -     struct hci_dev *hdev =3D NULL, *d;
> > > > +     struct hci_dev *hdev =3D NULL;
> > > >
> > > >       BT_DBG("%d", index);
> > > >
> > > > @@ -74,9 +74,11 @@ struct hci_dev *hci_dev_get(int index)
> > > >               return NULL;
> > > >
> > > >       read_lock(&hci_dev_list_lock);
> > > > -     list_for_each_entry(d, &hci_dev_list, list) {
> > > > -             if (d->id =3D=3D index) {
> > > > -                     hdev =3D hci_dev_hold(d);
> > > > +     list_for_each_entry(hdev, &hci_dev_list, list) {
> > > > +             if (hdev->id =3D=3D index) {
> > > > +                     hci_dev_hold(hdev);
> > > > +                     if (srcu_index)
> > > > +                             *srcu_index =3D srcu_read_lock(&hdev-=
>srcu);
> > > >                       break;
> > > >               }
> > > >       }
> > > > @@ -84,6 +86,22 @@ struct hci_dev *hci_dev_get(int index)
> > > >       return hdev;
> > > >  }
> > >
> > > If no list item has `hdev->id =3D=3D index`, doesn't this now return =
the
> > > list head -> crash?
> >
> > Seems wrong to me as well, *d was used to hold the current entry but
> > that has been removed so hdev would be used instead which may return a
> > valid/non-NULL entry even when its index doesn't match. Btw, are there
> > any documentation regarding the usage of SRCU in such cases where
> > there are still references?
>
> I think that's the main use case of SRCU, and basically the use case
> is similar to the normal RCU.  There are a bunch of doc under
> Documentations/ and I'm not sure what's the best one, but LWN article
> would be a nice one to start.
>
> https://lwn.net/Articles/202847/
>
> Also, one good example would be rtnl_link_ops_get(), rtnl_link_ops_put(),
> and rtnl_link_unregister().

Oh, this indeed looks pretty similar.

>
> >
> > Usually the hci_unregister_dev is called by the driver to inform the
> > hardware has been unplugged from the system, so we do want to be able
> > to abort any ongoing usage of the hci_dev so in this particular case
> > perhaps it is easier to just check if HCI_UNREGISTER has been set
> > before attempting to flush.
>
> Maybe like below ?
>
> I think the downside of this approach would be we need to apply this
> change to each driver that has the same issue.
>
> Note that we need to hold mutex here otherwise there is no guarantee
> that another thread does not complete kfree().  I'm not sure if touching
> unregister_dev in non-bluetooth-core code is something we should avoid.
>
> What do you think ?
>
> ---8<---
> diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> index 59f4d7bdffdc..3dea1292da2d 100644
> --- a/drivers/bluetooth/hci_vhci.c
> +++ b/drivers/bluetooth/hci_vhci.c
> @@ -66,7 +66,10 @@ static int vhci_flush(struct hci_dev *hdev)
>  {
>         struct vhci_data *data =3D hci_get_drvdata(hdev);
>
> -       skb_queue_purge(&data->readq);
> +       mutex_lock(&hdev->unregister_lock);
> +       if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED))
> +               skb_queue_purge(&data->readq);
> +       mutex_unlock(&hdev->unregister_lock);
>
>         return 0;
>  }
> ---8<---

Not quite, I was thinking more along this lines:

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 07a8b4281a39..4c8105ad4885 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -548,7 +548,7 @@ static int hci_dev_do_reset(struct hci_dev *hdev)
        hci_conn_hash_flush(hdev);
        hci_dev_unlock(hdev);

-       if (hdev->flush)
+       if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) && hdev->flush)
                hdev->flush(hdev);

        hci_dev_clear_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);

Note though, the whole hci_dev_do_reset is actually buggy, to do a
proper reset we should probably do hci_power_off_sync +
hci_power_on_sync so all the states are properly cleared.

--=20
Luiz Augusto von Dentz
