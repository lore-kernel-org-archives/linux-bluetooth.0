Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F402DB7B9
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 18:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771526096; cv=pass; b=QrnwzAct7LNrW2R+N6mwRD4sfjAiIWumw9gZmYuSJnEIf2TPRm0vtJU0PYno6Y2Ibx1UNW6R4f6NMLX9L2jqBGgM48OBlAElzyOU/O9qJZEa2K0LJzvbCaVsFSs3LxCOitsrXwwIvz8BK+yGqCk8HJ9qE7J4rd59bGg3pxN7KT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771526096; c=relaxed/simple;
	bh=A9XZgGLty3z85XE93Yr3ix2KCS8uEQs1krXvsGkWnsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pBr7vX239HO3ueZXP04nEf792CeKI/Qw7K4UqsqAAUmY5il9EC8rHQlH4/L1iP/VwZRQ/HFfwJPBpaByZ7HlEcTDDUIuvGmr4TlMIFIN1YGmf4T/bPgA3QVIlZrz98yyHYglGZqqKuGCXynMbTfELj9G6rh3TOEdqTVWC1fvnJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ec9bKDxk; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ec9bKDxk"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-894674a4c4aso18824226d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 10:34:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771526094; cv=none;
        d=google.com; s=arc-20240605;
        b=FT61KpqeuRZ2rpRslhVDzbYAev1SmHp0i0mQY1yKC61Y9YNhNgq1rZlZ/4vB0+HDZ3
         rUIJEKDMnBpZRDi5BrdSfbfkKjVQiIYRWExu4Bd9SaUh6eNEbTLVxYwyy46X81MhIawZ
         eTeWmD6Kkf0tN36GRBtrJKgGtjlKxJ0v+HGsN+xBluQSYG68nI6HT5cBMPX+HMAGGHYO
         Q1P3+ExHO+QhfeepRxeeKBLikhIIFAqofgsLaiKU+bNGLySc7GMy9e+MtRIlG6JgZFCA
         KCUF2DsF7dKOfVjzctghyiad+CyrH0Y/n1mkUL5qGbuTEF3QXwra9a325KqizxOIqO3C
         FAKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JV2qH9cY1Yzb57AevKyGXAKH0CdShb+Ar1Fm6qQ3YJM=;
        fh=nb2yAo1P9HYQtv+/SSMYoPaQhjKwVnbWDTVPTQPkhkc=;
        b=TLs8MMY/tS9YW4KKVXVaVBzBn/YYvZGSUV7LUVRIwD9DtV8Skn3esBw7Q8FooGVvR1
         EAB8rItpcSi8KF0vaY/OlQ0OYMupseNsdkrb+uELZXVUeDHKFV3C2fbjwjPOuPbvIWtM
         4CrNbn5mDYn9ZF4VhPczUKtytXTa++A+XUW/Yeld9phnywafgyUrxQgbpAD3vJGzqylJ
         p7N1UT/OHF6aIuIoE+n4aZj/plJoYVTuIgZ7PMrDG9mKl7OedpBUDXtZZ65HcoPNk9zS
         rySKyEEPAqsqOi1bTCN2ngVYSMa8hqZ9jqXbEPjTso0I5JhUkQrcEjirVN8JrcNl140P
         Fgug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771526094; x=1772130894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JV2qH9cY1Yzb57AevKyGXAKH0CdShb+Ar1Fm6qQ3YJM=;
        b=Ec9bKDxkQyPkg8L4xCEhGDMajKGi9rwbOkG9ZQedFgS/y/85i/Nd9geMNMe5KW7RA9
         cpVL2RGT5dyn8+dK73khJNHI5Rt+SB3K3O7XbZHk2C60aszYxbyNYNZxdoEj/x1z89KT
         LacHSPdIAj28EOZiiLkGXC72NJmP8qmwxdBNFjAUroD4jfAEo4u1Os7ac0VmsK1zmlOi
         nUNQYau2flcJYoWgA1xo0YtP+6YLZpeMbiCmkTJjKuwsaXRyWeRcep86aa9iuwezlfma
         BOaaANyT5c/AhAvNmqpAmJDmIj6YP8k6dywXkfYW7qxpoJMaB432oT79pgHgnKGAH6UU
         hUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771526094; x=1772130894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JV2qH9cY1Yzb57AevKyGXAKH0CdShb+Ar1Fm6qQ3YJM=;
        b=Ar2c8reCGxzC3Ftn3Q/Kd2E9hq0EQU4zLs4Z1+vmOdpgsLD8cPvxDgREsCdElGQ01R
         BsaBOiMNPyGNkkMAPMnZ8hivKGKskl8iRJ8MWyxmIDv3BCqgySlxI3TX1EgwniYFmhQI
         06ClNKFWJOc5E3Cl3l9RKnjdB0PT/CIGH5OOqWdvy36Z7ZwHqbpto6wOkZe55SHiMoyT
         fFmG2Y7oEt0uDQ9aD+MKqsBchG/8FQmhfdYonxy4YU+XCD0Zzotoh2ZPOd0yMb1tX57H
         JKFwUAY9xyYhQWFl7AnBtkr4amBDmn/svke1EMh0XNofEtg5JFO7mVNIvwnQ/d8ETfYz
         5p1A==
X-Forwarded-Encrypted: i=1; AJvYcCVlQdhW7VECtaflm3faKNjOTLncu5zh7TfZnE7JBVF05/6WYOFnMdiB+wVnX18PlG23f00RzFh1rq/Xzp4GYis=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcKnh5uI90OU/1j6Ihb+mUUEEpYKmGkjzQjxywgz0A0vxmu+Nc
	ZOE1+4csJ653an5DIsRojXhDG8l1NC+uglNqzorpnshw/mESbj+CA81D7zJuTb/PncchuGVAUfu
	eGf5ysswSa3Ykv5can9q1P2iU02MDkBg=
X-Gm-Gg: AZuq6aIq/QJc94petfQ0UNqd59goTL6OUR4oC6cDixIl3GzBtvG5W0FM+g+UPYFh6Xl
	4yFwus+cy7ku92YpRz82vScNaVcmqkT+5OF2lbRZwaIKtZrak3GiHpnwY8iAz5mPsolvLbuXxvM
	8DwmHktbnv2Gg9EkwY0WDB+g0lBcF0U8pK4l7wQ7UGHnz2mntTvLK/nGe7eOpgXnRWAbIyHcufQ
	8ZaZ5k92uA2Vtl6l2JtzZPfE/XMMyW0YTaHUYug8UUVp2Af+HJ6Ao1x13mS3b83NxYR2kN5fLDk
	qFgjp+FK4aqUfrF8SkOC9PHCNjS58GIf0qghKXbPXHTEtvdf7owU/3oznA35xv0U3FWVBO2o4B3
	Rzbjiuian5AKxwJaZLLhpZMy8
X-Received: by 2002:ad4:5bcd:0:b0:896:f47e:fd53 with SMTP id
 6a1803df08f44-8974030972amr271050186d6.17.1771526093915; Thu, 19 Feb 2026
 10:34:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADbaWgHykWB_EBiqp15W1C+v0OUMG2RXWv7zG_gocp2kgmkcew@mail.gmail.com>
 <CABBYNZKPyi=qz-XfiNex2oS3DaJUQq-JN7uOxip90jaaHC2cHg@mail.gmail.com>
 <CADbaWgEfX87oPoiO3vdn_s4=Q4TVRVzh=qDgewEC-t2Xa9gU7Q@mail.gmail.com>
 <CALGDAeCGPpEjJonFJ5q7tg7UhJwp+CnLO9Fb8U6dEhjGzRS=nQ@mail.gmail.com> <CABBYNZJ9cSB_-Q_yVPPivqHCPw+9DE=mfN0J3oqDSm0naDxwjg@mail.gmail.com>
In-Reply-To: <CABBYNZJ9cSB_-Q_yVPPivqHCPw+9DE=mfN0J3oqDSm0naDxwjg@mail.gmail.com>
From: Daniel Matsumoto <insidetf2@gmail.com>
Date: Thu, 19 Feb 2026 15:34:43 -0300
X-Gm-Features: AaiRm53GQRVzIz8NqMEFE_SLu5CJbMafC9IX56Fim2NE-ouFliNMPhCflJnHqCs
Message-ID: <CADbaWgF53sPZbR3uahemgZVYv8rENT7-hYBCh5X5prvd3kPo3w@mail.gmail.com>
Subject: Re: Bluetooth: mgmt: Fix heap overflow in mgmt_mesh_add
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Maiquel Paiva <maiquelpaiva@gmail.com>, luiz.von.dentz@intel.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> That seems valid, although it lacks a reproducer, since we need to
> protect the list mesh_pending.

Actually, looking at the locking semantics, 003ca042a386 is also flawed .

1. The list is already protected. The only caller of mgmt_mesh_add()
is mesh_send(), which explicitly acquires hci_dev_lock(hdev) before
the allocation and list insertion.
2. The patch uses the wrong mutex. It adds
guard(mutex)(&hdev->mgmt_pending_lock) to protect hdev->mesh_pending.
Isn't that lock meant for the mgmt_pending list? not the mesh lists?
3. The locking is asymmetric. The guard is added to the add() and
find() paths, but mgmt_mesh_remove() (which does list_del()) and
mgmt_mesh_next() are left untouched.
4. It replaces a fast path with a blocking lock. In mgmt_mesh_find(),
the patch removes a lockless list_empty() optimization, forcing the
code to acquire an expensive mutex just to iterate an empty list.

Since the execution path is already serialized by the primary device
lock, adding an orthogonal mutex here only introduces overhead and
potential deadlocks.
I suggest not merging that patch as well.


On Thu, Feb 19, 2026 at 2:49=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Maiquel,
>
> On Thu, Feb 19, 2026 at 12:08=E2=80=AFPM Maiquel Paiva <maiquelpaiva@gmai=
l.com> wrote:
> >
> > Thank you for the detailed follow-up.
> > The explanation about EXPORT_SYMBOL makes perfect sense.
> >
> > I was analyzing the function's limits in complete isolation,
> > and didn't realize the context of the trust limit within the module its=
elf.
> >
> > I will certainly use this as a great learning experience,
> > (it's never too late to learn!)
> >
> > I fully agree with reverting commit ac0c6f1b6a58
> > ("Bluetooth: mgmt: Fix heap overflow in mgmt_mesh_add")
> > to avoid confusion and unnecessary code changes,
> > since the function that calls mesh_send already handles sanitization.
> >
> > Just to confirm: what will happen to the other commit in this series th=
at addresses the blocking problem
> > (003ca042a386)? The handling of the mesh_pending list was indeed unprot=
ected
> > that's exactly what guard(mutex) is for.
>
> That seems valid, although it lacks a reproducer, since we need to
> protect the list mesh_pending.
>
> > Thank you for the review.
> >
> > Thanks,
> > Maiquel Paiva
> >
> > Em qui., 19 de fev. de 2026 =C3=A0s 13:23, Daniel Matsumoto <insidetf2@=
gmail.com> escreveu:
> >>
> >> Hi Luiz,
> >>
> >> Makes perfect sense regarding EXPORT_SYMBOL. Thanks for taking a look
> >> and dropping it.
> >>
> >> Regards,
> >> Daniel
> >>
> >>
> >> On Thu, Feb 19, 2026 at 1:16=E2=80=AFPM Luiz Augusto von Dentz
> >> <luiz.dentz@gmail.com> wrote:
> >> >
> >> > Hi Daniel,
> >> >
> >> > On Tue, Feb 17, 2026 at 1:09=E2=80=AFPM Daniel Matsumoto <me@celes.i=
n> wrote:
> >> > >
> >> > > Regarding commit ac0c6f1b6a58 ("Bluetooth: mgmt: Fix heap overflow=
 in
> >> > > mgmt_mesh_add"):
> >> > >
> >> > > I reviewed the call path for this patch and the overflow condition
> >> > > appears to be unreachable in the current tree.
> >> > > The only caller of mgmt_mesh_add() is mesh_send() in
> >> > > net/bluetooth/mgmt_util.c. The length parameter is explicitly
> >> > > sanitized before the call:
> >> > >
> >> > > if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED) ||
> >> > >    len <=3D MGMT_MESH_SEND_SIZE ||
> >> > >    len > (MGMT_MESH_SEND_SIZE + 31))
> >> > > return mgmt_cmd_status(sk, hdev->id, MGMT_OP_MESH_SEND,
> >> > >       MGMT_STATUS_REJECTED);
> >> > >
> >> > > Given that mgmt_mesh_add() allocates sizeof(*mesh_tx), which inclu=
des
> >> > > the param buffer sized for this maximum length, the bounds check
> >> > > introduced in the commit is redundant.
> >> > > While defensive programming is valid, tagging this as a fix for a =
heap
> >> > > overflow is misleading for backporters and security scanners, as t=
he
> >> > > overflow cannot be triggered.
> >> >
> >> > Yeah, well I would say it would only be valid to apply defensive
> >> > programming if that function would be marked with EXPORT_SYMBOL so i=
t
> >> > could be used outside of net/bluetooth context.
> >> >
> >> > > Please consider dropping this from the stable queue to avoid
> >> > > unnecessary code churn.
> >> >
> >> > +1, will drop it entirely, it seems I will need to ask for more
> >> > evidence as apparently people are relying too much on LLVM nowadays.
> >> >
> >> > --
> >> > Luiz Augusto von Dentz
> >> >
>
>
>
> --
> Luiz Augusto von Dentz
