Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636B03054E6
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Sep 2025 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758559398; cv=pass; b=FTES1mLf5MQHnDh9FU24x6SH8/5cWAXEjMkeqSU5khmJnLEtvoS/tVy4mLJr+QFsy385ovVmpL7CY78AaA7x+cDJ2pqPuTzT0wgzZ8LlItggwtrVr7ASFfl+0I0/nPysCFZD+N42cSK5ISCtyUaqRYfIiBWVgjCZalIVp/VsqFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758559398; c=relaxed/simple;
	bh=yFIkhB5ENcu7ZWqGaSFMVdEqtDzTniQwL5KFHGTFa5o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wyf8M/1Qy1b67SjoE/Z7U7YoAerb4H7CMGcc2JKlbHeUrDuHAeOFr4d0/vSD1WQpcP9FBfJkKgjaNCdrHK3YnixDB7oNDcOPqg3THkYXy189vj75+YYQ0ZEderKqK4lLX0mHXwKn30BbgpNzaxQRoPY2HJf7wqcoyVp+7melQNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=rX37VfhH; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="rX37VfhH"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4cVpnl4bGFz49Q5g;
	Mon, 22 Sep 2025 19:43:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1758559388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZewqX0cHt2k5bRIaoodLOS3E4LZjIxxwBPTrSXuOJvw=;
	b=rX37VfhHIakWoEHa8DC6k2Ezw6qXLj1xUOFkUMRzfnqSN80fChQ7Yh1hvcKOE8G/VlJ1Mv
	4R5ox92NwhvHNuxnbWbGxRN59QA5RGvnZ3x8wC266Zt7nyGHymar2F8q4OJPfD5XccXM8H
	2vEjfKjKF4j0pqgrO/7wRv5/pqRj1CsnhfLm7UAHrvwbxunZlb9DuIGxSiS/TPZxqzYyte
	U/GbDJGxzHTlSjdlLobHjkdmSrgJnITb4zGTdt+4w3p12zNSGCE0o7Ays1LarVCgKtsupS
	/TvGdZiLUaLgjEbjnibaPLA7HexekIMXAcl5pFQ37jpgG4tPJSWQscAnmUMraA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1758559388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZewqX0cHt2k5bRIaoodLOS3E4LZjIxxwBPTrSXuOJvw=;
	b=Pn8GU7UhMvPKvbtE0ypMUlw8O5BZ/BRECxKYOh32NLuE4fGfs1ikUHSZMj+wGrCmRJSII4
	MWY4Eaq/0+jH3LLasCYl/N032n6VWkiKzAB10OU0mpjqVLq3jf0xDmWGrgcteiX5w8uX0C
	IJk9BxxFYKNDHNjgYJ3lNf6O3FRX6RyIskXkzWarAtvn5cXD1NX6+P7y0GbuKp4CcNRd54
	k4lc+f3kOiVaO2Dg33A4tJU3HszzZV6cHMfII9TNYV8Lmz/jGBLXKzLKd6SNSJBtN9/Ie0
	Arr///4GmHeaVJxf5TzgbSO6Pjio715UCuPMU24njgxZN3AuMf5YNFrsHzwfHQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1758559388; a=rsa-sha256;
	cv=none;
	b=wAumGRO/mYXTpTPhQ9snWqgHL8lUVSz3J7Cikj6MOzyPjZZhs6viS990/Jj0ifecoh8/zm
	KBpKW5z52XV3waDpF78/dGDAbg26ZABZKA+BAtzLfz5dNuZR/CTtdgPnDApjRdY7QcrDah
	bAupAsT2gLID6hydFyrHoOMtRFF9YNwG8HN54TfBLLeteKGF2o0ek1vtBKKEMlDDrWiQQ1
	MdYF0zb+CltBHaj46ookGYdSmTWLrJskP5GcKsXG8MBJA8A4ouF5SFRDDfCtnULyq7RDD8
	SvYkFNcZJMaiXC+eqMLa2/nkAj2nrQkbcGkEDSZjEMSyqE/kFcwB3A9y0iXvmQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <d4d019a26d85b36be664a6205970d249d983dd83.camel@iki.fi>
Subject: Re: [RFC PATCH 17/24] Bluetooth: hci_sync: add helper for hdev
 locking across waits
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 22 Sep 2025 19:43:07 +0300
In-Reply-To: <CABBYNZJ5VdBW1MSpxSqsi2Jzos3Us20S2aDhmhAYDa1cd5BamQ@mail.gmail.com>
References: <cover.1758481869.git.pav@iki.fi>
	 <a9e4e1c91a3b551f3ca57dfe816ed271e7da8c26.1758481869.git.pav@iki.fi>
	 <CABBYNZJ5VdBW1MSpxSqsi2Jzos3Us20S2aDhmhAYDa1cd5BamQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Luiz,

ma, 2025-09-22 kello 10:51 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Sun, Sep 21, 2025 at 3:19=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote=
:
> >=20
> > Add hci_dev_lock/unlock_sync, for holding hdev->lock except when waitin=
g
> > request completion on hdev->req_wait_q.
> >=20
> > This makes writing hci_sync subroutines somewhat simpler, as the lock
> > needs to be acquired only on top level.  Routines will however still
> > have to recheck conditions after waits.
>=20
> This one doesn't sound quite right, I'm afraid this will impact the
> lifetime of hdev itself as well since this means the hdev cannot be
> freed while req_hdev_locked, so it is effectively another lock

Hmm, I'm not quite seeing it currently:

	hci_dev_lock_sync(hdev);
	...
	err =3D __hci_cmd_sync_status(hdev, ...);
	...
	hci_dev_unlock_sync(hdev);

is equivalent to

	hci_dev_lock(hdev);
	...
	hci_dev_unlock(hdev);
	err =3D __hci_cmd_sync_status(hdev, ...);
	hci_dev_lock(hdev);
	...
	hci_dev_unlock(hdev);

(but without having to worry about conn->xxx arguments passed to
hci_cmd_sync_*, subroutines don't need unlock/lock everywhere, and in
code the name differentiates from normal hci_dev_lock critical section
which subroutines aren't usually expected to be unlocking.)

I.e. it unlocks before every event wait, the lock is held only during
hci_sync payload code execution which shouldn't have delays, so I'm not
seeing why it would be very different from what is already in hci_sync.

The hdev cannot be freed also before if there is a hci_sync routine
still executing, destroy_workqueue() drains the queue first.

I think since we are not holding hdev->lock when destroying the
workqueue, this shouldn't deadlock that, or affect how canceling work
items functions.

> also I think we might be better of adding a lock directly to
> hci_conn in that case since most problems seems related to accessing
> it after waiting for an event.

Doesn't lock in hci_conn lead to similar issue as with hdev->lock here:

If hci_sync task holds lock over event wait, during that wait e.g.
Disconnect event (which iiuc may arrive at unexpected points) may need
to take the lock to delete the same hci_conn -> deadlock problem.

If hci_sync doesn't hold lock over event wait, then it seems you have
to do something similar as done here.

> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > ---
> >  include/net/bluetooth/hci_core.h |  2 ++
> >  include/net/bluetooth/hci_sync.h |  4 ++++
> >  net/bluetooth/hci_sync.c         | 26 ++++++++++++++++++++++++++
> >  3 files changed, 32 insertions(+)
> >=20
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index 1e9b27b3b108..10960462c5dd 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -533,6 +533,8 @@ struct hci_dev {
> >         struct sk_buff          *req_skb;
> >         struct sk_buff          *req_rsp;
> >=20
> > +       bool                    req_hdev_locked;
> > +
> >         void                    *smp_data;
> >         void                    *smp_bredr_data;
> >=20
> > diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/h=
ci_sync.h
> > index e352a4e0ef8d..eabc423b210e 100644
> > --- a/include/net/bluetooth/hci_sync.h
> > +++ b/include/net/bluetooth/hci_sync.h
> > @@ -188,3 +188,7 @@ int hci_le_conn_update_sync(struct hci_dev *hdev, s=
truct hci_conn *conn,
> >=20
> >  int hci_connect_pa_sync(struct hci_dev *hdev, struct hci_conn *conn);
> >  int hci_connect_big_sync(struct hci_dev *hdev, struct hci_conn *conn);
> > +
> > +void hci_dev_lock_sync(struct hci_dev *hdev);
> > +void hci_dev_unlock_sync(struct hci_dev *hdev);
> > +void hci_assert_lock_sync_held(struct hci_dev *hdev);
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index 8fe2f5b73040..5391c1bb17f0 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -20,6 +20,25 @@
> >  #include "aosp.h"
> >  #include "leds.h"
> >=20
> > +void hci_dev_lock_sync(struct hci_dev *hdev)
> > +{
> > +       hci_dev_lock(hdev);
> > +       lockdep_assert(!hdev->req_hdev_locked);
> > +       hdev->req_hdev_locked =3D true;
> > +}
> > +
> > +void hci_dev_unlock_sync(struct hci_dev *hdev)
> > +{
> > +       lockdep_assert(hdev->req_hdev_locked);
> > +       hdev->req_hdev_locked =3D false;
> > +       hci_dev_unlock(hdev);
> > +}
> > +
> > +void hci_assert_lock_sync_held(struct hci_dev *hdev)
> > +{
> > +       lockdep_assert(lockdep_is_held(&hdev->lock) && hdev->req_hdev_l=
ocked);
> > +}
> > +
> >  static void hci_cmd_sync_complete(struct hci_dev *hdev, u8 result, u16=
 opcode,
> >                                   struct sk_buff *skb)
> >  {
> > @@ -159,6 +178,7 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *h=
dev, u16 opcode, u32 plen,
> >  {
> >         struct hci_request req;
> >         struct sk_buff *skb;
> > +       bool locked =3D READ_ONCE(hdev->req_hdev_locked);
> >         int err =3D 0;
> >=20
> >         bt_dev_dbg(hdev, "Opcode 0x%4.4x", opcode);
> > @@ -173,10 +193,16 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev =
*hdev, u16 opcode, u32 plen,
> >         if (err < 0)
> >                 return ERR_PTR(err);
> >=20
> > +       if (locked)
> > +               hci_dev_unlock(hdev);
> > +
> >         err =3D wait_event_interruptible_timeout(hdev->req_wait_q,
> >                                                hdev->req_status !=3D HC=
I_REQ_PEND,
> >                                                timeout);
> >=20
> > +       if (locked)
> > +               hci_dev_lock(hdev);
> > +
> >         if (err =3D=3D -ERESTARTSYS)
> >                 return ERR_PTR(-EINTR);
> >=20
> > --
> > 2.51.0
> >=20
> >=20
>=20
