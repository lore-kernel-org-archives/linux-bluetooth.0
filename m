Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE34B239E9F
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Jun 2025 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750177720; cv=none; b=Qeifo7MqqFqQlYxLU8rICh52XrbRwhDZypprU5/O9BqLTmogW7/LvUpZmxs3fjv4SLZXe+yYcsiwfYQ4wipiehP5lym1zeb5scisWD8mCSnSr4CivP+aDwvwz682kqvX/sP1QAqH9s1+bYkUGnJ9fX8J/olZWS5v8zf3ZHMPS1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750177720; c=relaxed/simple;
	bh=SUxsGod99pm93Tvo5bgFHm0Ucb2pDyJnv81KBIbvWRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EpCbi/5USaFB6m4F6J1cyrN1hhVPFzSUf7HSafKt4LDQM5VIZjs2TjW/NXD9NK+j8c8+wsFHOkiM5aGK00bc9kcq94c2Ox730b9nENDLrNhLEDb3zK+TC+yCac9SThHDsTlKH3kMLl6ZvgyvfWCeAzerJNyx4YgZLLqluX0ZPeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gm8hmson; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gm8hmson"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3138e64b42aso6850528a91.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Jun 2025 09:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750177718; x=1750782518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEOqyyXZhu6Lua1UnR3C5nU562ndJs7lk5w8C/iZNpE=;
        b=gm8hmsonHodPIV1fg0YYHBNDrm9PPemB1NngyUqPrhVRK1T8kc6GaIEg7OvkSEjJ9d
         0knY16eAWu737qEEWGJbY67z03aCSk/bEypOMY2lBsrPfhfFJqXtAhPce3Hg3hpln+bB
         a1Gpy9Pe2Ci0VqNI7IDEkrmgGNpHTXmQSkx5JjJ6NtuzrAWGj1L0vwcR2+CpKzMKoAan
         0AxWtMq92Mg8tUf48aiYLZHOMJqYe1XcdyR5QmcV6XV02nhNhfQYZ2Uz6FrAq1Lb50Ec
         vnh5wgc5i4M4TJzGnUgGPycnhzB/u5Fx1qbhLSfx9/vqE7HFo1TvzuTIbFCQ+EvRJ2Hh
         1pDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750177718; x=1750782518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEOqyyXZhu6Lua1UnR3C5nU562ndJs7lk5w8C/iZNpE=;
        b=dFRJPbDGMbN5Tnf06hJiJpKjw0+YBkoCWwm9HOhUidQQVUVwQcH90a2jFY+ctf4ZX2
         tKMXIW5/SJc/rJeAAsgBSnZe5fZpbll8yN4IxFZR0gKRMPs0SGWYXmzpeFViLxW4KM6i
         zr1a4fUbpwNYTTDNI6XLsm+UoNWFSNYow/bXhcYpDvFJkV0eMTRRb97YzJdut7eMX3aa
         /9B/L/1kLMiKhi4DSuaq4vi70KWhH+qWe8dZ/AR/XLFm6duA3LsEZaJpz9FOoTWHALOs
         yC+ihKsGL9ThZUFEtljwfJO0bWyyl3N9tQzFdBu1KZYj85KYlxSfP/E5IHKkfnVr6IFg
         Pj8A==
X-Forwarded-Encrypted: i=1; AJvYcCWMXKQECcAiWblSLancgj8RaIFV+/26bqiq9Br4wFE1baIcV/tBj9QpZEfbHBKLhPdEIB904sAep1mJTenZfuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYnPPwVDHwBvjEK8w7USMjj78f6oxUebbMKvHjavgSuxVgZ4pL
	s7SpCfdH+p5rNT3sduZvl7EG8FlKhSKLc5zOcDh2zIyHyzsiKfJrRRM=
X-Gm-Gg: ASbGncvZnt9V8PMS9jutJk9ah8wN8u9WQqewdrMEqmQ1NOJLoKvlYJMkATbIE2jgQ8B
	rc+bfbuP+StMf+4u7ukB7Ux18v2pnkRKnhTiCchpWKMccMQ9SG11q1yhiQD2nTmfssit42VTf5e
	HEnSCtBxqcOsBBkJdUhC6JEXxziCIoFWeXQZs3yewrFiozJZjD3ObSLRinpQKJNs14WDhFSlP+P
	8GHeM/ArsMyp2IjhYzkVqvA6T6LgKyNs5PzXLpJfHyIoPHeLvnTHQrokBSvV4SuOArN8BkEmiAQ
	k3HfnoVt7Uyk0m/RTnH1oCOqrpAw2fFDi/KlpsU=
X-Google-Smtp-Source: AGHT+IFMdn88yqe7rxcVv11mD3sGBJ60H2xxTH8CwoNQjanzk1Yg2Jop1U4hU4pGpOMSVPiIRNL08A==
X-Received: by 2002:a17:90b:4c09:b0:313:17e3:7ae0 with SMTP id 98e67ed59e1d1-313f1d8346bmr16462381a91.34.1750177717922;
        Tue, 17 Jun 2025 09:28:37 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deca2b5sm82807865ad.195.2025.06.17.09.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 09:28:37 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: luiz.dentz@gmail.com
Cc: kuni1840@gmail.com,
	linux-bluetooth@vger.kernel.org,
	pav@iki.fi,
	syzbot+2faa4825e556199361f9@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] Bluetooth: hci_core: Fix use-after-free in vhci_flush()
Date: Tue, 17 Jun 2025 09:28:25 -0700
Message-ID: <20250617162836.1738956-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CABBYNZJK2=B5co7geYH2B8Dq13AU1-4bZcm9ypmk6YwZ=-0T6w@mail.gmail.com>
References: <CABBYNZJK2=B5co7geYH2B8Dq13AU1-4bZcm9ypmk6YwZ=-0T6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 17 Jun 2025 10:52:11 -0400
> Hi Kuniyuki,
> 
> On Mon, Jun 16, 2025 at 4:35 PM Kuniyuki Iwashima <kuni1840@gmail.com> wrote:
> >
> > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > Date: Mon, 16 Jun 2025 15:30:19 -0400
> > > Hi Kuniyuki,
> > >
> > > On Mon, Jun 16, 2025 at 3:20 PM Kuniyuki Iwashima <kuni1840@gmail.com> wrote:
> > > >
> > > > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > > > Date: Mon, 16 Jun 2025 14:56:26 -0400
> > > > > Hi Pauli, Kuniyuki,
> > > > >
> > > > > On Mon, Jun 16, 2025 at 2:12 PM Pauli Virtanen <pav@iki.fi> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > ma, 2025-06-16 kello 10:37 -0700, Kuniyuki Iwashima kirjoitti:
> > > > > > > From: Kuniyuki Iwashima <kuniyu@google.com>
> > > > > > >
> > > > > > > syzbot reported use-after-free in vhci_flush() without repro. [0]
> > > > > > >
> > > > > > [clip]
> > > > > > > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > > > > > > index 07a8b4281a39..d648b514e2df 100644
> > > > > > > --- a/net/bluetooth/hci_core.c
> > > > > > > +++ b/net/bluetooth/hci_core.c
> > > > > > > @@ -64,9 +64,9 @@ static DEFINE_IDA(hci_index_ida);
> > > > > > >
> > > > > > >  /* Get HCI device by index.
> > > > > > >   * Device is held on return. */
> > > > > > > -struct hci_dev *hci_dev_get(int index)
> > > > > > > +static struct hci_dev *__hci_dev_get(int index, int *srcu_index)
> > > > > > >  {
> > > > > > > -     struct hci_dev *hdev = NULL, *d;
> > > > > > > +     struct hci_dev *hdev = NULL;
> > > > > > >
> > > > > > >       BT_DBG("%d", index);
> > > > > > >
> > > > > > > @@ -74,9 +74,11 @@ struct hci_dev *hci_dev_get(int index)
> > > > > > >               return NULL;
> > > > > > >
> > > > > > >       read_lock(&hci_dev_list_lock);
> > > > > > > -     list_for_each_entry(d, &hci_dev_list, list) {
> > > > > > > -             if (d->id == index) {
> > > > > > > -                     hdev = hci_dev_hold(d);
> > > > > > > +     list_for_each_entry(hdev, &hci_dev_list, list) {
> > > > > > > +             if (hdev->id == index) {
> > > > > > > +                     hci_dev_hold(hdev);
> > > > > > > +                     if (srcu_index)
> > > > > > > +                             *srcu_index = srcu_read_lock(&hdev->srcu);
> > > > > > >                       break;
> > > > > > >               }
> > > > > > >       }
> > > > > > > @@ -84,6 +86,22 @@ struct hci_dev *hci_dev_get(int index)
> > > > > > >       return hdev;
> > > > > > >  }
> > > > > >
> > > > > > If no list item has `hdev->id == index`, doesn't this now return the
> > > > > > list head -> crash?
> > > > >
> > > > > Seems wrong to me as well, *d was used to hold the current entry but
> > > > > that has been removed so hdev would be used instead which may return a
> > > > > valid/non-NULL entry even when its index doesn't match. Btw, are there
> > > > > any documentation regarding the usage of SRCU in such cases where
> > > > > there are still references?
> > > >
> > > > I think that's the main use case of SRCU, and basically the use case
> > > > is similar to the normal RCU.  There are a bunch of doc under
> > > > Documentations/ and I'm not sure what's the best one, but LWN article
> > > > would be a nice one to start.
> > > >
> > > > https://lwn.net/Articles/202847/
> > > >
> > > > Also, one good example would be rtnl_link_ops_get(), rtnl_link_ops_put(),
> > > > and rtnl_link_unregister().
> > >
> > > Oh, this indeed looks pretty similar.
> > >
> > > >
> > > > >
> > > > > Usually the hci_unregister_dev is called by the driver to inform the
> > > > > hardware has been unplugged from the system, so we do want to be able
> > > > > to abort any ongoing usage of the hci_dev so in this particular case
> > > > > perhaps it is easier to just check if HCI_UNREGISTER has been set
> > > > > before attempting to flush.
> > > >
> > > > Maybe like below ?
> > > >
> > > > I think the downside of this approach would be we need to apply this
> > > > change to each driver that has the same issue.
> > > >
> > > > Note that we need to hold mutex here otherwise there is no guarantee
> > > > that another thread does not complete kfree().  I'm not sure if touching
> > > > unregister_dev in non-bluetooth-core code is something we should avoid.
> > > >
> > > > What do you think ?
> > > >
> > > > ---8<---
> > > > diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> > > > index 59f4d7bdffdc..3dea1292da2d 100644
> > > > --- a/drivers/bluetooth/hci_vhci.c
> > > > +++ b/drivers/bluetooth/hci_vhci.c
> > > > @@ -66,7 +66,10 @@ static int vhci_flush(struct hci_dev *hdev)
> > > >  {
> > > >         struct vhci_data *data = hci_get_drvdata(hdev);
> > > >
> > > > -       skb_queue_purge(&data->readq);
> > > > +       mutex_lock(&hdev->unregister_lock);
> > > > +       if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED))
> > > > +               skb_queue_purge(&data->readq);
> > > > +       mutex_unlock(&hdev->unregister_lock);
> > > >
> > > >         return 0;
> > > >  }
> > > > ---8<---
> > >
> > > Not quite, I was thinking more along this lines:
> > >
> > > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > > index 07a8b4281a39..4c8105ad4885 100644
> > > --- a/net/bluetooth/hci_core.c
> > > +++ b/net/bluetooth/hci_core.c
> > > @@ -548,7 +548,7 @@ static int hci_dev_do_reset(struct hci_dev *hdev)
> > >         hci_conn_hash_flush(hdev);
> > >         hci_dev_unlock(hdev);
> > >
> > > -       if (hdev->flush)
> > > +       if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) && hdev->flush)
> > >                 hdev->flush(hdev);
> >
> > I think technically there is still a small race window (and it
> > could be large enough with _RT kernel).
> >
> > CPU1                      CPU2
> >                           hci_unregister_dev
> > hci_dev_get
> > hci_dev_test_flag(hdev, HCI_UNREGISTER)
> >                             hci_dev_set_flag(hdev, HCI_UNREGISTER)
> >                             list_del(&hdev->list)
> >                             kfree(vhci_data)
> > hdev->flush(hdev)
> >
> >
> > I'll keep the current form in v3 to fix the use-after-free
> > with the mentioned list head bug fixed.
> 
> Ok, and how the v3 helps with the situation above? It seems the
> assumption is that synchronize_srcu would wait for the thread holding
> hci_dev_get_srcu, but what if the order is the reversed? It does seem
> like we still need to prevent hci_dev_get_srcu to return the hdev it
> is has been unregistered already.

It is never reversed as hci_dev_get_srcu() and hci_unregister_dev()
hold hci_dev_list_lock.

So, if hci_dev_get_srcu() finds a hdev, it's always after that that
the hdev is un-listed by hci_unregister_dev(), and synchronize_srcu()
follows it.
