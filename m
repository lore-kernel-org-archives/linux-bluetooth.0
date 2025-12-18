Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC472741AB
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766077799; cv=none; b=A+GlfOsUFoYuJLodgdC2C7ct77W7p8dwYVlm6rAw4YJ3hh24z77hjQdYq2X7lwAw3ANcRDL0jncFwFVTnF0PYGDDDziZ7I5UO6Y9rrdTeN6Emtas53aEXWtphjAEKG8EstOqioiwx5JmjGAjHeL2mg8JEhQtP/GalRCYp5zuchc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766077799; c=relaxed/simple;
	bh=J0K8HsC1t2SLh0ko0peV3J6ZX2/VOlGxJTMT+C6ed8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sNKD9vC5IouWUoJ7IRzBf29iv12ZeN9Vsur7E9vdkh+FtICU+jZ5a36BD9YljZztWAtdOIxCuLNt6nPtNY5JSaPK2EC/XHPBoDv5YJlstDdfDGB2IUGdb2jvka6M6Tr2Z4fMVM/0UqzPyqDhFJ1OwOKWP5ck9K2xUY5q8BZanoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYiRtz0/; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYiRtz0/"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34c2f52585fso738867a91.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 09:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766077791; x=1766682591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20YmEbYCV9FSFeCuOwtfHVYAJ/0fmsKrzmjUl+vBj4A=;
        b=eYiRtz0/RH+1cFPronQJZ5yfJEgPPXn10Lgb2K15WX4s6wXP9Hi+hkJfXOEv6+QgmJ
         uIZ21C0Q8z4V/3ohJVUHUlGSW7qkytBrJmsthztncG/Uk+/1i8q60rjd8Kwb2aHTGkGD
         lvadd4OEF2/xoIiOxBVjriBUzELHkJDQOix3MRVRGaDKqbP+7IL5WxekP9rvqERWfgvW
         quiKkds2J0CfJFYBrrgVgpw1frfekAYot52+E5CKyPBFjEM9PPg3SjiFhR4+PeVFOUQ2
         X+iCGthqASoeQk9FBtPwt/Xhml/RrlhBM5EU/4XMMAn/rMVGnhvzNgKOacIz3AqBEf8Z
         GDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766077791; x=1766682591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=20YmEbYCV9FSFeCuOwtfHVYAJ/0fmsKrzmjUl+vBj4A=;
        b=kbUwgsvb+qMEd86v0N+2fwqIBraQDV6UkZsenpiazrEUMAwwngbIXet2qrFQAUkx7d
         Y0RQqjJTtHkPsTjuUu194at51zquVB6MtenYreZ7FXgmF8B9FK2RKCyq+BFPpAevgN1P
         mBd20httAi0Y6+BKYI3enmzCMUGLt1rUDVjpE8ta80ucE3keyyOImJgW2yxBFz+wVq8f
         Oz1dSOs82x6PAAb0eT2BjjZbppf+kkAeM3RxiSPMLelHv1V8kGfQ0XgW/SY1Edlxhqa+
         Yz4cdMTrcUS5i4d6T5Pay22ldGv4HJBruNZIWnfeiykcfqgkuXYhRBffP13oN/DhTpeN
         S+PQ==
X-Gm-Message-State: AOJu0YwDDzNu9LOp3PAzMw5xzmTNJqDOgCrYH11A25Aq3e0KXZi9t3WA
	Fn46vimCsRo8mMlcHFTwkY3jSx6Dsvl8aFTSCjPNkMYM0rYhcGpZA0mALYS5JfYt40CMA1QlCZI
	h2T36EbLXEeyNwfuX9zLDZUotZkdlNQ==
X-Gm-Gg: AY/fxX6Rcqq8lrAIWmoveZ7yt7E1MQ8L72CDVLrMuClQFJjbHFIAGP7Tprf/Y0mLM3F
	YtOww5uyUgGaZqopPvjKqK5BEUnvu/VBkui8gJ9qdxHIpB8I496aM75Ftlx0RM0fOsWYOgyhQ9T
	v4Nkcn6MfEtDOH/SXTs7EfP6by9AM/COPZOeQx4NkaTqbtE1xylQ8kwP799HdVq0kcjKLZy7u4A
	E6BFoaOPcEfVFgF07j6UeTs184s5OD5Eluq/pqzWzh6MiN53IexkgWGxqW4NzU7A+4tJQ==
X-Google-Smtp-Source: AGHT+IHLTlRkeRo2CMmyLD+L1edU0Zj32q2GnYfpqQkqaNGnRpymSYzcuusSBwXH45WzpGdgbTsBdCXxorgbA9Z6MHo=
X-Received: by 2002:a17:90b:4ad1:b0:340:29a1:1b0c with SMTP id
 98e67ed59e1d1-34e9212a3acmr83939a91.7.1766077791072; Thu, 18 Dec 2025
 09:09:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216191255.882653-1-cakturk@gmail.com> <CABBYNZKHof-LaKXiB_oe34R9_mTdH_YCjVsATrdwrLQehaGWhg@mail.gmail.com>
In-Reply-To: <CABBYNZKHof-LaKXiB_oe34R9_mTdH_YCjVsATrdwrLQehaGWhg@mail.gmail.com>
From: =?UTF-8?Q?Cihangir_Akt=C3=BCrk?= <cakturk@gmail.com>
Date: Thu, 18 Dec 2025 20:09:40 +0300
X-Gm-Features: AQt7F2rJP08BPehJ9-MDzc-H1PhfdokfQns_eoMh8ZzYkmAdp2Joe79IDxMy5-E
Message-ID: <CACSM0CMXdpaKZ9LeC0QS=dzfYXr4Ac0pd9wzX+aP3m4M3K8COw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci: fix refcounts in LE remote features command
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, linux-kernel@vger.kernel.org, 
	syzbot+87badbb9094e008e0685@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 12:36=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Cihangir,

Hi Luiz,

> On Tue, Dec 16, 2025 at 2:13=E2=80=AFPM Cihangir Akturk <cakturk@gmail.co=
m> wrote:
> >
> > KASAN reported a slab-use-after-free in le_read_features_complete()
> > running from hci_cmd_sync_work.  le_read_features_complete() can run
> > after hci_rx_work/hci_conn_del() has removed the link, so the destroy
> > callback may touch a freed hci_conn and trigger a KASAN use-after-free.
> > Duplicate submissions also need to drop the references to avoid leaking
> > the hold and blocking teardown.
> >
> > Fix this by taking hci_conn_get() before queueing, passing the conn
> > directly as work data, and balancing hci_conn_hold()/drop() and
> > hci_conn_get()/put() in the completion and all error/-EEXIST paths so
> > the connection stays referenced while the work runs and is released
> > afterwards.
> >
> > Reported-by: syzbot+87badbb9094e008e0685@syzkaller.appspotmail.com
> > Signed-off-by: Cihangir Akturk <cakturk@gmail.com>
> > ---
> >  net/bluetooth/hci_sync.c | 37 ++++++++++++++++++++++++++-----------
> >  1 file changed, 26 insertions(+), 11 deletions(-)
> >
> > I am not entirely sure that removing the err =3D=3D -ECANCELED early re=
turn
> > is strictly correct. My assumption is that, with the changes in this
> > patch, there does not appear to be another cancellation path that
> > reliably balances hci_conn_drop() and hci_conn_put() for this command.
> > Based on that assumption, keeping the early return could leave the
> > references taken before queuing unbalanced on cancellation, so I opted
> > to remove it to keep the lifetime handling consistent.
> >
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index a9f5b1a68356..5a3d288e7015 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -776,14 +776,23 @@ _hci_cmd_sync_lookup_entry(struct hci_dev *hdev, =
hci_cmd_sync_work_func_t func,
> >   * - Lookup if an entry already exist and only if it doesn't creates a=
 new entry
> >   *   and queue it.
> >   */
> > -int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_fu=
nc_t func,
> > +static int __hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_syn=
c_work_func_t func,
> >                             void *data, hci_cmd_sync_work_destroy_t des=
troy)
> >  {
> >         if (hci_cmd_sync_lookup_entry(hdev, func, data, destroy))
> > -               return 0;
> > +               return -EEXIST;
> >
> >         return hci_cmd_sync_queue(hdev, func, data, destroy);
> >  }
> > +
> > +int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_fu=
nc_t func,
> > +                           void *data, hci_cmd_sync_work_destroy_t des=
troy)
> > +{
> > +       int ret;
> > +
> > +       ret =3D __hci_cmd_sync_queue_once(hdev, func, data, destroy);
> > +       return ret =3D=3D -EEXIST ? 0 : ret;
> > +}
> >  EXPORT_SYMBOL(hci_cmd_sync_queue_once);
> >
> >  /* Run HCI command:
> > @@ -7338,10 +7347,8 @@ static void le_read_features_complete(struct hci=
_dev *hdev, void *data, int err)
> >
> >         bt_dev_dbg(hdev, "err %d", err);
> >
> > -       if (err =3D=3D -ECANCELED)
> > -               return;
> > -
> >         hci_conn_drop(conn);
> > +       hci_conn_put(conn);
> >  }
> >
> >  static int hci_le_read_all_remote_features_sync(struct hci_dev *hdev,
> > @@ -7408,12 +7415,20 @@ int hci_le_read_remote_features(struct hci_conn=
 *conn)
> >          * role is possible. Otherwise just transition into the
> >          * connected state without requesting the remote features.
> >          */
> > -       if (conn->out || (hdev->le_features[0] & HCI_LE_PERIPHERAL_FEAT=
URES))
> > -               err =3D hci_cmd_sync_queue_once(hdev,
> > -                                             hci_le_read_remote_featur=
es_sync,
> > -                                             hci_conn_hold(conn),
> > -                                             le_read_features_complete=
);
> > -       else
> > +       if (conn->out || (hdev->le_features[0] & HCI_LE_PERIPHERAL_FEAT=
URES)) {
> > +               hci_conn_get(conn);
> > +               hci_conn_hold(conn);
> > +               err =3D __hci_cmd_sync_queue_once(hdev,
> > +                                               hci_le_read_remote_feat=
ures_sync,
> > +                                               conn,
> > +                                               le_read_features_comple=
te);
> > +               if (err) {
> > +                       hci_conn_drop(conn);
> > +                       hci_conn_put(conn);
> > +                       if (err =3D=3D -EEXIST)
> > +                               err =3D 0;
> > +               }
> > +       } else
>
> Sort of overkill, why do we have to use 2 references? Also we do have
> code for dequeuing callbacks using conn as user_data so either that is
> not working or there is something else at play here. Maybe we need to
> change the order so that dequeue happens before hci_conn_cleanup:
>

From what I understand based on the KASAN trace, the issue happens
when a disconnect event is handled in hci_event_work while, at the
same time, hci_cmd_sync_work processes the LE Read Remote Features
command. So, le_read_features_complete() ends up calling
hci_conn_drop() on a connection that appears to have already been
freed.

Holding a reference with hci_conn_hold() alone does not seem
sufficient to prevent the disconnect path from removing and freeing
the hci_conn. That was the reason I tried taking an additional
reference with hci_conn_get(), to keep the connection object around
until the work finishes.

> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index dc085856f5e9..b64c0e53d9cd 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1232,15 +1232,15 @@ void hci_conn_del(struct hci_conn *conn)
>         skb_queue_purge(&conn->data_q);
>         skb_queue_purge(&conn->tx_q.queue);
>
> +       /* Dequeue callbacks using connection pointer as data */
> +       hci_cmd_sync_dequeue(hdev, NULL, conn, NULL);
> +
>         /* Remove the connection from the list and cleanup its remaining
>          * state. This is a separate function since for some cases like
>          * BT_CONNECT_SCAN we *only* want the cleanup part without the
>          * rest of hci_conn_del.
>          */
>         hci_conn_cleanup(conn);
> -
> -       /* Dequeue callbacks using connection pointer as data */
> -       hci_cmd_sync_dequeue(hdev, NULL, conn, NULL);
>  }
>
>  struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src, uint8_t src_=
type)
>
>
> >                 err =3D -EOPNOTSUPP;
> >
> >         return err;
> > --
> > 2.52.0
> >
>

I tried this change and tested the suggested ordering, but in my
testing the issue still appears to reproduce, so it does not seem to
fully address the problem.

>
> --
> Luiz Augusto von Dentz
