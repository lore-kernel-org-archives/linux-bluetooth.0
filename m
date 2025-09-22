Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2A1263F36
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Sep 2025 20:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758573622; cv=none; b=UJ6DJTWJexmqXwkTh6+QWoo3C9E2uAWnkh8z41KERcJaLeALg91joxaei7cnvM+spgwNjBhxUzwVE0V7gZS8EtmmVndxxRyVeoVBcTkFxFxjNMAoHbvIysIgF6aVaieCPclLt/vsRjEk7MS13++aBG9Ru4Z2bhv8+fngYCjsxXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758573622; c=relaxed/simple;
	bh=rjV4KJJwu4Ktk2XZB5muHTyPXwxyMqA0mf0jmjWYmts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uXzvYgdonw3Ii9aS9hLeFeZsSTjE8s9SYm6SGYHeQMGCxv+cr0FsddNIB0DlYeLp5+FxcJA3Vx5DUJNMnmo8T+oall07IqP6pt+vYdslXEqjAHmlmGZykgwcBKXTvkKeO5DJuQHdn6zVNIrKF8gMe3tvUnsNDwVuanf3orRSELs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfns5Zn9; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfns5Zn9"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-36a6a39752bso17569681fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Sep 2025 13:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758573619; x=1759178419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLn0xjrVFMRQaCeyGk9ciDGR2GepgHCS4f6aA7shiXg=;
        b=jfns5Zn9SUrEfpuxnZJ+MbatQiZSQRALa+7qOjdNYcpNMmpmDPSCqTsSJkVkkUEHlD
         1RbusUfeEUqAjRaRahznPqAQwWTZdZRjQ8PsjGjGQgxnLJ53pbVa0SUD3hz/upqZcEp6
         zbSdCl2/FDDns58SE6Xz7YGgRMXTIC9piz+3AgWmBfgFkRJrNZG920KFL5UDqpN3Ec5R
         cKpLktgxPg+kKmvPBoxosxqD1eHwaloMhq8M/tkCv27KNoKjXJVxlEtR5eIhEcXLzbH1
         f30DoQKlo7/n65LLEePthnh4xscCeVZnWuGxIda6ZugWw9lYo4KFsDF8XjtFWCKOf15e
         VZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758573619; x=1759178419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLn0xjrVFMRQaCeyGk9ciDGR2GepgHCS4f6aA7shiXg=;
        b=VIIMc+uPSuoQRz0CtYmJPxraLsa0iPnayuFNKvipKpkxobD6BCCA1VMrMb1wyahusl
         DKdwYH3ouXh/6e3z+WiaYrynxTlmabMujrg5I6sei81aFz5E7djiBDVxwMoO3ZFGoyEF
         t7q9xNNZE3QoHx/khcBejt3cs6rRuor2KajsqEDjvnk/LV2Cbo9fv0ARyRE/QvZGsnhv
         LEdNS0+8aYxv6gngG499kJ1KIGgIhLbeWXBBlQRkjmNqgX6WXeqr1BWehNo8IzCkROjC
         yDxPUzPpqrQWG3apdxA9XfoG8gAXTiRz4qmbIMjI4ZyAED/ugz5JnNXFbMI4ypo42CV+
         oM5Q==
X-Gm-Message-State: AOJu0YwRIhqVlFi66M405CCyK58+z4k8DtchmpXmNKOzmf6Obo9FiNF1
	nl6tFrd2sTK+VJZBkBMMYxu8yM8vEVc5LqYtv2nmbSbjw/GAZx/9RLPqdqOPJOcITPEp2zvoGeX
	CUTXRPUHNvRAoOLqlESKkrNzAdMGRuBjhj6f6CwWjAw==
X-Gm-Gg: ASbGncv7ATRUIyXw0aPh6xm5auEvduRLHLl3EybZvau0wvMyWaRpH957EqLFoZMXBj4
	2m4ft/a9aQ3asPD+dmekoZNECmbshwoRtZYZZViQ2Khw+2ajclAb3TVEXvFmaTSA6+w2Bq5rEsP
	G0XiArCAaYHPogqYzwreBbe8bZ9uWx6Tju18wPJkgQMB2NrMKWoczvIZYHypSaJMT7gUcLgdwDZ
	4AI7w==
X-Google-Smtp-Source: AGHT+IGWaEp2d3+mAv0KSN0fVJSCsMip67Z9VVRXGvVBsu9D5gIq5e+joXs1Ui/kTzUeAFt+LJIZGNkH+yoBmdt6cLw=
X-Received: by 2002:a2e:a009:0:20b0:337:fdde:ff3f with SMTP id
 38308e7fff4ca-36d16bf6948mr161791fa.27.1758573618487; Mon, 22 Sep 2025
 13:40:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1758481869.git.pav@iki.fi> <a9e4e1c91a3b551f3ca57dfe816ed271e7da8c26.1758481869.git.pav@iki.fi>
 <CABBYNZJ5VdBW1MSpxSqsi2Jzos3Us20S2aDhmhAYDa1cd5BamQ@mail.gmail.com> <d4d019a26d85b36be664a6205970d249d983dd83.camel@iki.fi>
In-Reply-To: <d4d019a26d85b36be664a6205970d249d983dd83.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 22 Sep 2025 16:40:05 -0400
X-Gm-Features: AS18NWCbPveEtjvjl2KcJIdDJhRCfXJpTy-PJG0hFLj_OBKvvcLQGbDNy7g8USs
Message-ID: <CABBYNZLMwtz_4kQgng1MUZaEYb6gp6EviF2BuHoqsoFm_kiwMg@mail.gmail.com>
Subject: Re: [RFC PATCH 17/24] Bluetooth: hci_sync: add helper for hdev
 locking across waits
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Mon, Sep 22, 2025 at 12:43=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> ma, 2025-09-22 kello 10:51 -0400, Luiz Augusto von Dentz kirjoitti:
> > Hi Pauli,
> >
> > On Sun, Sep 21, 2025 at 3:19=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wro=
te:
> > >
> > > Add hci_dev_lock/unlock_sync, for holding hdev->lock except when wait=
ing
> > > request completion on hdev->req_wait_q.
> > >
> > > This makes writing hci_sync subroutines somewhat simpler, as the lock
> > > needs to be acquired only on top level.  Routines will however still
> > > have to recheck conditions after waits.
> >
> > This one doesn't sound quite right, I'm afraid this will impact the
> > lifetime of hdev itself as well since this means the hdev cannot be
> > freed while req_hdev_locked, so it is effectively another lock
>
> Hmm, I'm not quite seeing it currently:
>
>         hci_dev_lock_sync(hdev);
>         ...
>         err =3D __hci_cmd_sync_status(hdev, ...);
>         ...
>         hci_dev_unlock_sync(hdev);
>
> is equivalent to
>
>         hci_dev_lock(hdev);
>         ...
>         hci_dev_unlock(hdev);
>         err =3D __hci_cmd_sync_status(hdev, ...);
>         hci_dev_lock(hdev);
>         ...
>         hci_dev_unlock(hdev);
>
> (but without having to worry about conn->xxx arguments passed to
> hci_cmd_sync_*, subroutines don't need unlock/lock everywhere, and in
> code the name differentiates from normal hci_dev_lock critical section
> which subroutines aren't usually expected to be unlocking.)
>
> I.e. it unlocks before every event wait, the lock is held only during
> hci_sync payload code execution which shouldn't have delays, so I'm not
> seeing why it would be very different from what is already in hci_sync.
>
> The hdev cannot be freed also before if there is a hci_sync routine
> still executing, destroy_workqueue() drains the queue first.
>
> I think since we are not holding hdev->lock when destroying the
> workqueue, this shouldn't deadlock that, or affect how canceling work
> items functions.
>
> > also I think we might be better of adding a lock directly to
> > hci_conn in that case since most problems seems related to accessing
> > it after waiting for an event.
>
> Doesn't lock in hci_conn lead to similar issue as with hdev->lock here:
>
> If hci_sync task holds lock over event wait, during that wait e.g.
> Disconnect event (which iiuc may arrive at unexpected points) may need
> to take the lock to delete the same hci_conn -> deadlock problem.
>
> If hci_sync doesn't hold lock over event wait, then it seems you have
> to do something similar as done here.

I was thinking more on the likes of locking after hci_conn_valid, so
just to protect the access of fields rather than locking across waits
which as you said may lead to deadlocks, anyway I rather fix the
outstanding reports first then we can take reworks later once we
understand all the problems related to the current design.

Btw, I'm actually planning to get right of mgmt_pending for example,
that is sort of not needed because we can use
hci_cmd_sync_lookup_entry to find mgmt_pending entries.

>
> > > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > > ---
> > >  include/net/bluetooth/hci_core.h |  2 ++
> > >  include/net/bluetooth/hci_sync.h |  4 ++++
> > >  net/bluetooth/hci_sync.c         | 26 ++++++++++++++++++++++++++
> > >  3 files changed, 32 insertions(+)
> > >
> > > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth=
/hci_core.h
> > > index 1e9b27b3b108..10960462c5dd 100644
> > > --- a/include/net/bluetooth/hci_core.h
> > > +++ b/include/net/bluetooth/hci_core.h
> > > @@ -533,6 +533,8 @@ struct hci_dev {
> > >         struct sk_buff          *req_skb;
> > >         struct sk_buff          *req_rsp;
> > >
> > > +       bool                    req_hdev_locked;
> > > +
> > >         void                    *smp_data;
> > >         void                    *smp_bredr_data;
> > >
> > > diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth=
/hci_sync.h
> > > index e352a4e0ef8d..eabc423b210e 100644
> > > --- a/include/net/bluetooth/hci_sync.h
> > > +++ b/include/net/bluetooth/hci_sync.h
> > > @@ -188,3 +188,7 @@ int hci_le_conn_update_sync(struct hci_dev *hdev,=
 struct hci_conn *conn,
> > >
> > >  int hci_connect_pa_sync(struct hci_dev *hdev, struct hci_conn *conn)=
;
> > >  int hci_connect_big_sync(struct hci_dev *hdev, struct hci_conn *conn=
);
> > > +
> > > +void hci_dev_lock_sync(struct hci_dev *hdev);
> > > +void hci_dev_unlock_sync(struct hci_dev *hdev);
> > > +void hci_assert_lock_sync_held(struct hci_dev *hdev);
> > > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > > index 8fe2f5b73040..5391c1bb17f0 100644
> > > --- a/net/bluetooth/hci_sync.c
> > > +++ b/net/bluetooth/hci_sync.c
> > > @@ -20,6 +20,25 @@
> > >  #include "aosp.h"
> > >  #include "leds.h"
> > >
> > > +void hci_dev_lock_sync(struct hci_dev *hdev)
> > > +{
> > > +       hci_dev_lock(hdev);
> > > +       lockdep_assert(!hdev->req_hdev_locked);
> > > +       hdev->req_hdev_locked =3D true;
> > > +}
> > > +
> > > +void hci_dev_unlock_sync(struct hci_dev *hdev)
> > > +{
> > > +       lockdep_assert(hdev->req_hdev_locked);
> > > +       hdev->req_hdev_locked =3D false;
> > > +       hci_dev_unlock(hdev);
> > > +}
> > > +
> > > +void hci_assert_lock_sync_held(struct hci_dev *hdev)
> > > +{
> > > +       lockdep_assert(lockdep_is_held(&hdev->lock) && hdev->req_hdev=
_locked);
> > > +}
> > > +
> > >  static void hci_cmd_sync_complete(struct hci_dev *hdev, u8 result, u=
16 opcode,
> > >                                   struct sk_buff *skb)
> > >  {
> > > @@ -159,6 +178,7 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev =
*hdev, u16 opcode, u32 plen,
> > >  {
> > >         struct hci_request req;
> > >         struct sk_buff *skb;
> > > +       bool locked =3D READ_ONCE(hdev->req_hdev_locked);
> > >         int err =3D 0;
> > >
> > >         bt_dev_dbg(hdev, "Opcode 0x%4.4x", opcode);
> > > @@ -173,10 +193,16 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_de=
v *hdev, u16 opcode, u32 plen,
> > >         if (err < 0)
> > >                 return ERR_PTR(err);
> > >
> > > +       if (locked)
> > > +               hci_dev_unlock(hdev);
> > > +
> > >         err =3D wait_event_interruptible_timeout(hdev->req_wait_q,
> > >                                                hdev->req_status !=3D =
HCI_REQ_PEND,
> > >                                                timeout);
> > >
> > > +       if (locked)
> > > +               hci_dev_lock(hdev);
> > > +
> > >         if (err =3D=3D -ERESTARTSYS)
> > >                 return ERR_PTR(-EINTR);
> > >
> > > --
> > > 2.51.0
> > >
> > >
> >



--=20
Luiz Augusto von Dentz
