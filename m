Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B9814D29B
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 20:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750106109; cv=none; b=qHFJk2kIhImqsZ7xrYIn5NWSjb6M9lGXGp3XZhBJQmW1Fd7PjxCANZKnHtUQF2zSWLzXIIXVGphi4CdxmRwzq/9+b2SlGCUQ3XZlM1ehR7JcKcOWnxv8172FyslYC3QUB1qXAcolvQxXHK3eKxPi6j5wqNwrkZ/oeQEwUUUd3eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750106109; c=relaxed/simple;
	bh=4Z2of0CkK4gfRWO2DVL4U8vEgYhZYLOnZwiVoDEcAM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cLrTM0HDiddNJsXwLUOWe60dkVcKKAn2lIO/8NmrQETDagwneJLzFuQb9eMd+Yy5PltNcJ9turTDS1yJLrctZua+wRW2/mXXqTnlQpUYmY2b06Lu79RSsQiuzL8/yS8Tas4bph+WilIkkHQ2V4cB+jzTYgn+OT4gWtbb2STXdcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcz54lDQ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcz54lDQ"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b2fca9dc5f8so3606698a12.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 13:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750106108; x=1750710908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNE2fhfO47U8n3G59hFKCRwQaAxlRamxZo9p5pA09jA=;
        b=lcz54lDQM7kFbtWtxfzt6BiF7zjSu0t9NuwIxNRTke4SGedPjSiq6TCUsU0gI3h12t
         5N0vmwm2sAR0rD3WZd9UEGKBUtfsKct+RZth1nYM1XhM+nyHrmkztQ3N9hnG42Ch9UHb
         iFeqyp/jGol/Ut/BO1RG4w+/becfc8bh5I/DOIgCzQz7j7rXZh3xICCysF0xCZ4ET7m4
         2Yc3h83Mzriv6n41lqN+mMN0bRzWNlP7SRQ5cBmMuh79YpOYo1qGRJIQzqo2O9X7+Edg
         sS8k6Mi3eptjxb1t4RiDBfduP0//Qiiw1FPvBxyr/R/mQtgiQqXrk3fu1wN6flYiikX3
         IMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750106108; x=1750710908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNE2fhfO47U8n3G59hFKCRwQaAxlRamxZo9p5pA09jA=;
        b=e2nS75yymDHqcy/OHtFyb4aGRo9aL+5WjKBvEcQCWpL3d4UlZCrXYx/ViJ+6ZNlYl3
         T14ADesMT/oSd4xFOCfXTaLTE3XrxT3QfiWiPxHnpphhiSB36B31TY91YxFJ2rkC22oD
         o3FafYnqTlfYO/wkL/p6oYPH6OqXK24ftKpk3yrTEg+oBUHOJIKlpLajyypxelHNKZVW
         Dk0PtONAbyOq6psIQTnw2k6Tf7Dh57Dv4tpF0wzej2/fr0Y16lQN2oSKC4OhIm1+BXO6
         6PDk7VAQ/vwmN7ERdGfz/IcF1KBUb7r7tuORrg3AWzGzGUcCtUHeMvYw86fLjUtCdoQF
         OknQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8zpAqq24DKA3Kymt/nWAasTayVseVhKDNuBQWFbz8hpJVSxmKhFAkAjXg1YBE4MQMxDe8sSQyw5Fwi81rsak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcn18EYhWz9fZ7G2+TS0yMhw+Kpz2QCkVMeM4Q5g3mCm9zAyUs
	xIOzeZdiKxB0Di1xlxsQlxeo/qBm1zlMt8VHMWx3QwLYkStRhqvVYg4=
X-Gm-Gg: ASbGncvTmzdLO5pybZjXm0Z2IIXQoiwTCbx5exXkJwl0jBxoSOl4h5qencdnfJzQ9kY
	92NP99HXqTA0p701T1nV5kuwjW7OoHIY2L6tLAfcwhrQuEwM2CCBKfnDWY2WlwCvov5+z1cM+lG
	/j4hE3PRvXC6kF+RkwWxxr3IOpJaeNz3dLYCv2T7K1494yd7kInhyO2nYk9eHW4i661U0u5ttRC
	9lXA9YN5lMKTh6Y5h+YqYoekkpVZQPH/atmW5TDXSmLLGPj6iSsgOrDIlMdPlXHzna2qgZCWpBA
	B9ww1SUDNImrOt3jYFTf9a30BSJSMie41wFuVgM=
X-Google-Smtp-Source: AGHT+IFYxIUJW9OFLCiRXl9WMPQ4BxGHEx1HT4/c1fIeZPgqkhqzy20bi+PDjtU0mBWrGOxGgioxGw==
X-Received: by 2002:a05:6a21:348b:b0:21f:39c9:2122 with SMTP id adf61e73a8af0-21fbd505f8cmr18598526637.2.1750106107563;
        Mon, 16 Jun 2025 13:35:07 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffed0c2sm7282355b3a.22.2025.06.16.13.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 13:35:07 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: luiz.dentz@gmail.com
Cc: kuni1840@gmail.com,
	linux-bluetooth@vger.kernel.org,
	pav@iki.fi,
	syzbot+2faa4825e556199361f9@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] Bluetooth: hci_core: Fix use-after-free in vhci_flush()
Date: Mon, 16 Jun 2025 13:33:29 -0700
Message-ID: <20250616203506.1047396-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CABBYNZ+j72ZtXGbE2OmOaNfcoO+XMLS--BnXPwAgmWLh9k=5EA@mail.gmail.com>
References: <CABBYNZ+j72ZtXGbE2OmOaNfcoO+XMLS--BnXPwAgmWLh9k=5EA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 16 Jun 2025 15:30:19 -0400
> Hi Kuniyuki,
> 
> On Mon, Jun 16, 2025 at 3:20 PM Kuniyuki Iwashima <kuni1840@gmail.com> wrote:
> >
> > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > Date: Mon, 16 Jun 2025 14:56:26 -0400
> > > Hi Pauli, Kuniyuki,
> > >
> > > On Mon, Jun 16, 2025 at 2:12 PM Pauli Virtanen <pav@iki.fi> wrote:
> > > >
> > > > Hi,
> > > >
> > > > ma, 2025-06-16 kello 10:37 -0700, Kuniyuki Iwashima kirjoitti:
> > > > > From: Kuniyuki Iwashima <kuniyu@google.com>
> > > > >
> > > > > syzbot reported use-after-free in vhci_flush() without repro. [0]
> > > > >
> > > > [clip]
> > > > > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > > > > index 07a8b4281a39..d648b514e2df 100644
> > > > > --- a/net/bluetooth/hci_core.c
> > > > > +++ b/net/bluetooth/hci_core.c
> > > > > @@ -64,9 +64,9 @@ static DEFINE_IDA(hci_index_ida);
> > > > >
> > > > >  /* Get HCI device by index.
> > > > >   * Device is held on return. */
> > > > > -struct hci_dev *hci_dev_get(int index)
> > > > > +static struct hci_dev *__hci_dev_get(int index, int *srcu_index)
> > > > >  {
> > > > > -     struct hci_dev *hdev = NULL, *d;
> > > > > +     struct hci_dev *hdev = NULL;
> > > > >
> > > > >       BT_DBG("%d", index);
> > > > >
> > > > > @@ -74,9 +74,11 @@ struct hci_dev *hci_dev_get(int index)
> > > > >               return NULL;
> > > > >
> > > > >       read_lock(&hci_dev_list_lock);
> > > > > -     list_for_each_entry(d, &hci_dev_list, list) {
> > > > > -             if (d->id == index) {
> > > > > -                     hdev = hci_dev_hold(d);
> > > > > +     list_for_each_entry(hdev, &hci_dev_list, list) {
> > > > > +             if (hdev->id == index) {
> > > > > +                     hci_dev_hold(hdev);
> > > > > +                     if (srcu_index)
> > > > > +                             *srcu_index = srcu_read_lock(&hdev->srcu);
> > > > >                       break;
> > > > >               }
> > > > >       }
> > > > > @@ -84,6 +86,22 @@ struct hci_dev *hci_dev_get(int index)
> > > > >       return hdev;
> > > > >  }
> > > >
> > > > If no list item has `hdev->id == index`, doesn't this now return the
> > > > list head -> crash?
> > >
> > > Seems wrong to me as well, *d was used to hold the current entry but
> > > that has been removed so hdev would be used instead which may return a
> > > valid/non-NULL entry even when its index doesn't match. Btw, are there
> > > any documentation regarding the usage of SRCU in such cases where
> > > there are still references?
> >
> > I think that's the main use case of SRCU, and basically the use case
> > is similar to the normal RCU.  There are a bunch of doc under
> > Documentations/ and I'm not sure what's the best one, but LWN article
> > would be a nice one to start.
> >
> > https://lwn.net/Articles/202847/
> >
> > Also, one good example would be rtnl_link_ops_get(), rtnl_link_ops_put(),
> > and rtnl_link_unregister().
> 
> Oh, this indeed looks pretty similar.
> 
> >
> > >
> > > Usually the hci_unregister_dev is called by the driver to inform the
> > > hardware has been unplugged from the system, so we do want to be able
> > > to abort any ongoing usage of the hci_dev so in this particular case
> > > perhaps it is easier to just check if HCI_UNREGISTER has been set
> > > before attempting to flush.
> >
> > Maybe like below ?
> >
> > I think the downside of this approach would be we need to apply this
> > change to each driver that has the same issue.
> >
> > Note that we need to hold mutex here otherwise there is no guarantee
> > that another thread does not complete kfree().  I'm not sure if touching
> > unregister_dev in non-bluetooth-core code is something we should avoid.
> >
> > What do you think ?
> >
> > ---8<---
> > diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> > index 59f4d7bdffdc..3dea1292da2d 100644
> > --- a/drivers/bluetooth/hci_vhci.c
> > +++ b/drivers/bluetooth/hci_vhci.c
> > @@ -66,7 +66,10 @@ static int vhci_flush(struct hci_dev *hdev)
> >  {
> >         struct vhci_data *data = hci_get_drvdata(hdev);
> >
> > -       skb_queue_purge(&data->readq);
> > +       mutex_lock(&hdev->unregister_lock);
> > +       if (hci_dev_test_flag(hdev, HCI_UNCONFIGURED))
> > +               skb_queue_purge(&data->readq);
> > +       mutex_unlock(&hdev->unregister_lock);
> >
> >         return 0;
> >  }
> > ---8<---
> 
> Not quite, I was thinking more along this lines:
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 07a8b4281a39..4c8105ad4885 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -548,7 +548,7 @@ static int hci_dev_do_reset(struct hci_dev *hdev)
>         hci_conn_hash_flush(hdev);
>         hci_dev_unlock(hdev);
> 
> -       if (hdev->flush)
> +       if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) && hdev->flush)
>                 hdev->flush(hdev);

I think technically there is still a small race window (and it
could be large enough with _RT kernel).

CPU1                      CPU2
                          hci_unregister_dev
hci_dev_get
hci_dev_test_flag(hdev, HCI_UNREGISTER)
                            hci_dev_set_flag(hdev, HCI_UNREGISTER)
                            list_del(&hdev->list)
                            kfree(vhci_data)
hdev->flush(hdev)


I'll keep the current form in v3 to fix the use-after-free
with the mentioned list head bug fixed.


> 
>         hci_dev_clear_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
> 
> Note though, the whole hci_dev_do_reset is actually buggy, to do a
> proper reset we should probably do hci_power_off_sync +
> hci_power_on_sync so all the states are properly cleared.
