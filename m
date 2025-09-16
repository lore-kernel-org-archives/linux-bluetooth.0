Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD082DAFD2
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Sep 2025 19:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758050645; cv=none; b=SO6IDxX5+ScYTP2x2OXTbnU72qmOtGPcBVHcmCcR9zzqauTW+VCh+RkROexNF/KoKusanCq9nCfz07BuDIwDSN8lq5fUfNKGkIVfwAQLNBnEe/UMh9dIrIBnP5l7bBUOTmkTN4vmdHgcbVmom6t0dUyS9gGUQdhUGOrhHW7/7OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758050645; c=relaxed/simple;
	bh=Pcr63FWHCFjBvO4ZjZ3qFV/Aq6GDax2ZKV5faT16B4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OzAaMULThMfmB2LvOAGkREt2ghwK/IjaqtkztpBMzRdj3KH0Kejw2+0oi4U7JFcX0Hsm7DkZiFzNCaAMZ4hj89Nlv7lg5XRnQ00x7d4V7xv83FYlxWA5qjhCjazYkpyzMgXuHQGKpv8Qj0/LM+s8z+MYb0VU9KLowEP/74AusOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PI0PUIHV; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PI0PUIHV"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-352323388b6so39978661fa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Sep 2025 12:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758050642; x=1758655442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXp520g9ohX+3UxEQnwW8xc/CUFvpt76gwedcjfmAyk=;
        b=PI0PUIHVeoYSpnFFMb7zgvJ9djnZvRBddxthwf6DAKlNI/BGzCsb76Jc9qO7nwob7p
         mpsFszjQErqI2BLrtRtVtGQquyVfbrmq+Yc7jbSRDPMzSXkk5xWbwEmf8U1kB9xcNY8C
         4BsoMrkJRaJ38ym/bqKLdiUA5QNg7v6B12lrvHKMcRdCiZdzngYqdhtnx2WbyGM3ozD6
         IdG118s2PW+2vqD/DtPwcbiTeDXIqC5MseUSqnjiuDcdlrm0MXHN2Go+v8owtUb0KTJL
         DK40roplXg8lPjoOU+oOiBDsgERPXodgvaMttqUHW+7C+FpB6Ob0E0AMZaoIUQ2oYFBo
         sTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758050642; x=1758655442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXp520g9ohX+3UxEQnwW8xc/CUFvpt76gwedcjfmAyk=;
        b=hxklKZWjAb98BQCmlTRQwL/YC9ollH8xfuo23OanDEFGiuTVyk9DmkcOyKommUc2Yp
         +ilB5MBodWFduPqVAIK6rXp0S42Jz/GaNrgLAlzLIomzjf21SWvDj0UnQm8yklLqt9mn
         pODfiM5vUzNrfMmw0o5oePP7VuSFmta/15F7NiUH4GvhLYuRhffL1Ain8F07drPmg98n
         1oFsmPxAjQlfoeRocaJAYqBv/FdEXIOSl+PN81gkiiRQBV0zUpYdhhd3xXpFVjdjIMp5
         TYyaj8W5jMIE4Ka8wqQHOwwvqniwE9PblaFecRfsV4lcbwfWXMqpqEwHR/M8laNxW0be
         GKhA==
X-Gm-Message-State: AOJu0YzRB08vfnHFuNFj+45ij/XzA9cNxX+8GGGCa4QQTXsnLylap86U
	VUQDSCTcBcAB8cLYcdRPCEnlVUiYK7an17nfqYA7z33IvUUnuvsBJ+GCfGrQYoMuorHQQ28Q+FF
	pYpW9DZLn0mKFgRUmBcQvjiUeBQISOW8=
X-Gm-Gg: ASbGnctFTcGbaL/kPQ09T8eDDcaTnNrLcr219SB18zMKzxffudthp2Bc+8vE5ue2wxM
	uPG9Tx7yUxpd7eJKq1iTj5Ph7Ox3/ohR4wTlj80mR9ZhuQOctU3u6NRYpxkzH9sY9E7f1WrfiVX
	ZjItaLUUiyeQLemNd+rVSwLstIA9pxcyKxZ39bwtpla38K1fMhfRxx5NqmxzMvFnKemFiVojyoz
	Ch1mI6AkZquCcjN
X-Google-Smtp-Source: AGHT+IG4Rnfs4hn9der28y9QJpLXpKTzY0aKDydL89uO5rIv+83fnb1uXV3wPsoDCoowHyEd0aFrR4mHUa8JK2hqy/U=
X-Received: by 2002:a2e:a9a8:0:b0:356:839:56f with SMTP id 38308e7fff4ca-35608485217mr39045061fa.20.1758050641837;
 Tue, 16 Sep 2025 12:24:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915161504.814410-1-luiz.dentz@gmail.com> <20250915161504.814410-3-luiz.dentz@gmail.com>
 <38ece9403b84095b1d65d1f52d987a2ec7534f0e.camel@iki.fi>
In-Reply-To: <38ece9403b84095b1d65d1f52d987a2ec7534f0e.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 16 Sep 2025 15:23:48 -0400
X-Gm-Features: AS18NWC-d1yjLKFOHMgoO3NKW2BHglZJw1l77IragUHiVmQt13xQqy8UOZkhRp8
Message-ID: <CABBYNZ++CepEsC1RXWN8Woe7Zm2Rh=Q=p1C+vqPbXGKP3huaig@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] Bluetooth: MGMT: Fix possible UAFs
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Tue, Sep 16, 2025 at 12:37=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> ma, 2025-09-15 kello 12:15 -0400, Luiz Augusto von Dentz kirjoitti:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This attemps to fix possible UAFs caused by struct mgmt_pending being
> > freed while still being processed like in the following trace, in order
> > to fix mgmt_pending_valid is introduce and use to check if the
> > mgmt_pending hasn't been removed from the pending list, on the complete
> > callbacks it is used to check and in addtion remove the cmd from the li=
st
> > while holding mgmt_pending_lock to avoid TOCTOU problems since if the c=
md
> > is left on the list it can still be accessed and freed.
> >
> > BUG: KASAN: slab-use-after-free in mgmt_add_adv_patterns_monitor_sync+0=
x35/0x50 net/bluetooth/mgmt.c:5223
> > Read of size 8 at addr ffff8880709d4dc0 by task kworker/u11:0/55
> >
> > CPU: 0 UID: 0 PID: 55 Comm: kworker/u11:0 Not tainted 6.16.4 #2 PREEMPT=
(full)
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubu=
ntu1 04/01/2014
> > Workqueue: hci0 hci_cmd_sync_work
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
> >  print_address_description mm/kasan/report.c:378 [inline]
> >  print_report+0xca/0x240 mm/kasan/report.c:482
> >  kasan_report+0x118/0x150 mm/kasan/report.c:595
> >  mgmt_add_adv_patterns_monitor_sync+0x35/0x50 net/bluetooth/mgmt.c:5223
> >  hci_cmd_sync_work+0x210/0x3a0 net/bluetooth/hci_sync.c:332
> >  process_one_work kernel/workqueue.c:3238 [inline]
> >  process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3321
> [clip]
> > diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
> > index a88a07da3947..be6d9b8db51b 100644
> > --- a/net/bluetooth/mgmt_util.c
> > +++ b/net/bluetooth/mgmt_util.c
> > @@ -320,6 +320,29 @@ void mgmt_pending_remove(struct mgmt_pending_cmd *=
cmd)
> >       mgmt_pending_free(cmd);
> >  }
> >
> > +bool mgmt_pending_valid(struct hci_dev *hdev, struct mgmt_pending_cmd =
*cmd,
> > +                     bool remove)
> > +{
> > +     struct mgmt_pending_cmd *tmp;
> > +
> > +     if (!cmd)
> > +             return false;
> > +
> > +     mutex_lock(&hdev->mgmt_pending_lock);
> > +
> > +     list_for_each_entry(tmp, &hdev->mgmt_pending, list) {
> > +             if (cmd =3D=3D tmp) {
> > +                     if (remove)
> > +                             list_del(&cmd->list);
> > +                     mutex_unlock(&hdev->mgmt_pending_lock);
> > +                     return true;
>
> There seems to be a theoretical UAF left:
>
> Task 1: [in mgmt_pending_foreach, remove=3Dtrue] mutex_lock()
>
> Task 2: [in here, remove=3Dfalse] mutex_unlock()
>
> Task 1: mgmt_pending_free(cmd)
>
> Task 2: return true
>
> mgmt_pending_valid(hdev, cmd, false) returns true even though cmd is
> already freed.

You mean that after it has unlocked it still has the TOCTOU problem, right?

> This function could leave locking to caller and have
> lockdep_assert_held(&hdev->mgmt_pending_lock).
>
> Or maybe always remove=3Dtrue, and caller has to add it back to the list
> if needed.

Yeah, well then perhaps we need an alternative version to
mgmt_pending_valid which can be called while holding
mgmt_pending_lock, that said there is another thing that we might want
to fix as well.

> > +             }
> > +     }
> > +
> > +     mutex_unlock(&hdev->mgmt_pending_lock);
> > +     return false;
> > +}
> > +
> >  void mgmt_mesh_foreach(struct hci_dev *hdev,
> >                      void (*cb)(struct mgmt_mesh_tx *mesh_tx, void *dat=
a),
> >                      void *data, struct sock *sk)
> > diff --git a/net/bluetooth/mgmt_util.h b/net/bluetooth/mgmt_util.h
> > index 024e51dd6937..5aeba4c7b07f 100644
> > --- a/net/bluetooth/mgmt_util.h
> > +++ b/net/bluetooth/mgmt_util.h
> > @@ -65,6 +65,8 @@ struct mgmt_pending_cmd *mgmt_pending_new(struct sock=
 *sk, u16 opcode,
> >                                         void *data, u16 len);
> >  void mgmt_pending_free(struct mgmt_pending_cmd *cmd);
> >  void mgmt_pending_remove(struct mgmt_pending_cmd *cmd);
> > +bool mgmt_pending_valid(struct hci_dev *hdev, struct mgmt_pending_cmd =
*cmd,
> > +                     bool remove);
> >  void mgmt_mesh_foreach(struct hci_dev *hdev,
> >                      void (*cb)(struct mgmt_mesh_tx *mesh_tx, void *dat=
a),
> >                      void *data, struct sock *sk);
>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
