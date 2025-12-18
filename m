Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6080786323
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 17:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766077812; cv=none; b=icyLlgZ9ec5zB8xQit2X+WJ9K3BpH61rKZYQ9mD4BbO/dHVMxdKIOyKiWML5uxR/DZbR01NnuNctZxhGdw1jRuHsB1Ah/CxvrNmSWQh4uDCc3BHhipd4FdOV6NiMup/5I/uFgZoWCTyxiAPjeNBZcEYUIOZXfJscZBics/zY83M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766077812; c=relaxed/simple;
	bh=3QrBOB5Oc18R6+t8W6h7aDkzxxW67elrBlHi9JAHy/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4TVbROXjAXF2vRaCGBN4Jb4t5BDw2MhLeBfUD8+WR87euEoerLgEEMhChg7pMoqVKX3GKFnZ6zuIA/BrjrX6V4f0PxJFfMIE58Ob/eMDOo+TlT+UlBi/CLaRfLEWz0sEBhaFHiLiWpluWWzaG317YL6s7Kx1jXAuBe50SFTb/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpxGr0Zv; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpxGr0Zv"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-37a33b06028so7290401fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 09:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766077802; x=1766682602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvCGVs5uosibu/Iz6UCibztUgDIA+Vk5xwQIoCt9KOs=;
        b=bpxGr0ZvU50E4b2NrGe30VJY9nBIdUqTUL9S++L2s75voYN5YF+EdBIQR6OyCDjDpL
         +5Dtw+A228jmE9PKuu5C7BFgdWr0ETtfKsxiR7NmAjgX55RX5AXVf3TMtU7UX2+1sVkg
         TS+8kiDbgsN2iilkw2gaCwbCTIYYRhEmRyN8A2KCXm6/Mpc2g3lkaMWPM5viJccLo2I4
         VVZbJJ0wvO8skYxU2SOPmib5k/T+WnaJDtpjH8YfHriEaRDNt4XanI5pJ9KzH2y+wvEY
         Pf6fFX1W8KFO6f4mur0M4srHmOeSCminNK5g/NYe0HUUNfVMzEa4UJrKYwihEeg9YhDW
         nivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766077802; x=1766682602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZvCGVs5uosibu/Iz6UCibztUgDIA+Vk5xwQIoCt9KOs=;
        b=hy7yZABCFc9EBQttQPLrCQFst25Rc2D9FGmquSBm1oErkVs6UELAYfNkNlryZzPEvP
         74QuqolxQ/3//1r0jEaKIV7n115pLlHJZ6GH8jq5rz+ULXe8vu7pkIMg6FVLwqb9qkBW
         /LdcPHTCDLnFkoHB3o1KNTk7G8/teHNiB7TaE/gWWZVciu+C4SIRY7Kt+PNDiCknhtym
         F1DEIVIF+mKT12Frhm5avW0MqanRcwrksEic8x+HwdAuw8Qzh404vN+sV3ETeOtHOP9O
         XXie1HLc3aTlHDFOx9WWKyG8nSfKQ7kmtfjERWd9T3s173dxhHoW5n/YwaJc1cNPfbOP
         xh6A==
X-Forwarded-Encrypted: i=1; AJvYcCV1fJrqQnx/Nk9kvrcftQNqx6YXoG5vttaKDEAiFF/IqxOU25BNlEmSztJtZynkYZRdyKgCT1P3ZY/C9625lJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2GdTcTAHfIslGW5m7S2hkDczoNOfs9jbryDgPwE+cTzb5ze36
	RVg/gh1/Y3JJ85JGVK4SerHrFNxN8y9GAVFKd3WzgHzvNtvgO4ndQkS1AUnRhZT2S4cKf8hBrdG
	ROUfD7CUJNLJtbh6Q2CMdpCJ9r3/7IUM=
X-Gm-Gg: AY/fxX6GJ/ssHPSo4n+rmVQZkEP2/7LSrf/M7sTCclN/cslmw4ci6ddzyx7yJzmyDyz
	RLFaSd1EsGIt0T4v3hsS4rbWOuX3Kwb4Ubhbxvv0XNfViDHXj66XIumBz59d27vQJpsFlFg4AcC
	nV1fTyzgTMCrMEOttG3esgYydG8WJRviWB5MReE2W+RAV4L1dcmt+idiRz2nq8aUy2Nf/btzGwb
	gqaZSg9nt6lLrenvnLri73EwSvaaojv1AAmiRd87b97W9yGW/i4MSnHViwGBA273MDq6Q==
X-Google-Smtp-Source: AGHT+IH3Ig4pXI+GJJqYuhOahnqkNC9UPzayJm88A3iyblyBTafBnHWnB84k540mqSYmGsLJUku6Ypkbcui21wJsrYg=
X-Received: by 2002:a05:651c:2225:b0:37a:45fb:d42f with SMTP id
 38308e7fff4ca-381215cb7e6mr133791fa.19.1766077801350; Thu, 18 Dec 2025
 09:10:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216191255.882653-1-cakturk@gmail.com> <CABBYNZKHof-LaKXiB_oe34R9_mTdH_YCjVsATrdwrLQehaGWhg@mail.gmail.com>
 <8e9f289c294e66881323ee7f8f785a64e2e7ae8e.camel@iki.fi>
In-Reply-To: <8e9f289c294e66881323ee7f8f785a64e2e7ae8e.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 18 Dec 2025 12:09:49 -0500
X-Gm-Features: AQt7F2rvx4lJ3RUyl9sDt6dfqZDOn9RL9una4LBr0Fyu9ZLHzCXML4-rYMwJTK4
Message-ID: <CABBYNZLrL9cQSePJMT+ALdav8kV-+oD60Bnf9iZ5dZ27e3ZXCg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci: fix refcounts in LE remote features command
To: Pauli Virtanen <pav@iki.fi>
Cc: Cihangir Akturk <cakturk@gmail.com>, linux-bluetooth@vger.kernel.org, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-kernel@vger.kernel.org, 
	syzbot+87badbb9094e008e0685@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Thu, Dec 18, 2025 at 11:33=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> ke, 2025-12-17 kello 16:36 -0500, Luiz Augusto von Dentz kirjoitti:
> > Hi Cihangir,
> >
> > On Tue, Dec 16, 2025 at 2:13=E2=80=AFPM Cihangir Akturk <cakturk@gmail.=
com> wrote:
> > >
> > > KASAN reported a slab-use-after-free in le_read_features_complete()
> > > running from hci_cmd_sync_work.  le_read_features_complete() can run
> > > after hci_rx_work/hci_conn_del() has removed the link, so the destroy
> > > callback may touch a freed hci_conn and trigger a KASAN use-after-fre=
e.
> > > Duplicate submissions also need to drop the references to avoid leaki=
ng
> > > the hold and blocking teardown.
> > >
> > > Fix this by taking hci_conn_get() before queueing, passing the conn
> > > directly as work data, and balancing hci_conn_hold()/drop() and
> > > hci_conn_get()/put() in the completion and all error/-EEXIST paths so
> > > the connection stays referenced while the work runs and is released
> > > afterwards.
> > >
> > > Reported-by: syzbot+87badbb9094e008e0685@syzkaller.appspotmail.com
> > > Signed-off-by: Cihangir Akturk <cakturk@gmail.com>
> > > ---
> > >  net/bluetooth/hci_sync.c | 37 ++++++++++++++++++++++++++-----------
> > >  1 file changed, 26 insertions(+), 11 deletions(-)
> > >
> > > I am not entirely sure that removing the err =3D=3D -ECANCELED early =
return
> > > is strictly correct. My assumption is that, with the changes in this
> > > patch, there does not appear to be another cancellation path that
> > > reliably balances hci_conn_drop() and hci_conn_put() for this command=
.
> > > Based on that assumption, keeping the early return could leave the
> > > references taken before queuing unbalanced on cancellation, so I opte=
d
> > > to remove it to keep the lifetime handling consistent.
> > >
> > > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > > index a9f5b1a68356..5a3d288e7015 100644
> > > --- a/net/bluetooth/hci_sync.c
> > > +++ b/net/bluetooth/hci_sync.c
> > > @@ -776,14 +776,23 @@ _hci_cmd_sync_lookup_entry(struct hci_dev *hdev=
, hci_cmd_sync_work_func_t func,
> > >   * - Lookup if an entry already exist and only if it doesn't creates=
 a new entry
> > >   *   and queue it.
> > >   */
> > > -int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_=
func_t func,
> > > +static int __hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_s=
ync_work_func_t func,
> > >                             void *data, hci_cmd_sync_work_destroy_t d=
estroy)
> > >  {
> > >         if (hci_cmd_sync_lookup_entry(hdev, func, data, destroy))
> > > -               return 0;
> > > +               return -EEXIST;
> > >
> > >         return hci_cmd_sync_queue(hdev, func, data, destroy);
> > >  }
> > > +
> > > +int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_=
func_t func,
> > > +                           void *data, hci_cmd_sync_work_destroy_t d=
estroy)
> > > +{
> > > +       int ret;
> > > +
> > > +       ret =3D __hci_cmd_sync_queue_once(hdev, func, data, destroy);
> > > +       return ret =3D=3D -EEXIST ? 0 : ret;
> > > +}
> > >  EXPORT_SYMBOL(hci_cmd_sync_queue_once);
> > >
> > >  /* Run HCI command:
> > > @@ -7338,10 +7347,8 @@ static void le_read_features_complete(struct h=
ci_dev *hdev, void *data, int err)
> > >
> > >         bt_dev_dbg(hdev, "err %d", err);
> > >
> > > -       if (err =3D=3D -ECANCELED)
> > > -               return;
> > > -
> > >         hci_conn_drop(conn);
> > > +       hci_conn_put(conn);
> > >  }
> > >
> > >  static int hci_le_read_all_remote_features_sync(struct hci_dev *hdev=
,
> > > @@ -7408,12 +7415,20 @@ int hci_le_read_remote_features(struct hci_co=
nn *conn)
> > >          * role is possible. Otherwise just transition into the
> > >          * connected state without requesting the remote features.
> > >          */
> > > -       if (conn->out || (hdev->le_features[0] & HCI_LE_PERIPHERAL_FE=
ATURES))
> > > -               err =3D hci_cmd_sync_queue_once(hdev,
> > > -                                             hci_le_read_remote_feat=
ures_sync,
> > > -                                             hci_conn_hold(conn),
> > > -                                             le_read_features_comple=
te);
> > > -       else
> > > +       if (conn->out || (hdev->le_features[0] & HCI_LE_PERIPHERAL_FE=
ATURES)) {
> > > +               hci_conn_get(conn);
> > > +               hci_conn_hold(conn);
> > > +               err =3D __hci_cmd_sync_queue_once(hdev,
> > > +                                               hci_le_read_remote_fe=
atures_sync,
> > > +                                               conn,
> > > +                                               le_read_features_comp=
lete);
> > > +               if (err) {
> > > +                       hci_conn_drop(conn);
> > > +                       hci_conn_put(conn);
> > > +                       if (err =3D=3D -EEXIST)
> > > +                               err =3D 0;
> > > +               }
> > > +       } else
> >
> > Sort of overkill, why do we have to use 2 references? Also we do have
> > code for dequeuing callbacks using conn as user_data so either that is
> > not working or there is something else at play here. Maybe we need to
> > change the order so that dequeue happens before hci_conn_cleanup:
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index dc085856f5e9..b64c0e53d9cd 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -1232,15 +1232,15 @@ void hci_conn_del(struct hci_conn *conn)
> >         skb_queue_purge(&conn->data_q);
> >         skb_queue_purge(&conn->tx_q.queue);
> >
> > +       /* Dequeue callbacks using connection pointer as data */
> > +       hci_cmd_sync_dequeue(hdev, NULL, conn, NULL);
> > +
>
> hci_cmd_sync_dequeue() does not (i) cancel + wait for a job that is
> already running, (ii) prevent further jobs for this conn from being
> queued. So it's not guaranteed to work here AFAICS.
>
> For (i): note running hci_sync job may be blocked on taking hdev->lock,
> which is held here, so trying to cancel + wait deadlocks. Does not seem
> straightforward to fix.

Hmm, there is a lock though that is used when running the callbacks:

            hci_req_sync_lock(hdev);
            err =3D entry->func(hdev, entry->data);
            if (entry->destroy)
                entry->destroy(hdev, entry->data, err);
            hci_req_sync_unlock(hdev);

We could attempt to acquire hci_req_sync_lock on dequeue, but it looks
like there are code paths that already do call hci_conn_del with that
lock so the likes of mgmt-tester deadlock, anyway if there are code
paths already doing with hci_req_sync_lock held then it should be safe
to already require it when doing hci_conn_del or maybe rename
hci_conn_del to hci_conn_del_sync and then have hci_conn_del
performing the hci_req_sync_lock before calling hci_conn_del_sync then
work out the code paths where hci_req_sync_lock is already held to use
hci_conn_del_sync.

> For (ii): one would need to audit the places where these jobs are
> queued, and make sure they are all done with hdev->lock held, to avoid
> racing with the code here. Maybe doable with separate queueing function
> that has lockdep asserts.
>
> I suggested some time ago to always hold either refcount or lock to
> keep the hci_conn alive everywhere, also in these hci_sync callbacks:
>
> https://lore.kernel.org/linux-bluetooth/cover.1762100290.git.pav@iki.fi/
>
> with similar changes as suggested in this patch. This may be the
> simpler fix.
>
> >         /* Remove the connection from the list and cleanup its remainin=
g
> >          * state. This is a separate function since for some cases like
> >          * BT_CONNECT_SCAN we *only* want the cleanup part without the
> >          * rest of hci_conn_del.
> >          */
> >         hci_conn_cleanup(conn);
> > -
> > -       /* Dequeue callbacks using connection pointer as data */
> > -       hci_cmd_sync_dequeue(hdev, NULL, conn, NULL);
> >  }
> >  struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src, uint8_t sr=
c_type)
> >
> >
> > >                 err =3D -EOPNOTSUPP;
> > >
> > >         return err;
> > > --
> > > 2.52.0
> > >
> >
>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
