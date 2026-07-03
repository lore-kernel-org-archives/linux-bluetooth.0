Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD4522B8AB
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783097672; cv=pass; b=UJeOVyGbMVUFlECo9EOb3wOYmqlE5Lx5Q9j2m676DuQSirtxQ6LwYqDhdyzZzEOXrgwFBNhx+fIYhN43cUtcpc3pYwVGYqb/0avFdffVTrEF3KZe+dJDvtTLGMqk0lqLXq0i3f6gRD7hJPTZI+wcDCpwUzs+fcicZcTO5m6+uC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783097672; c=relaxed/simple;
	bh=OXBTO1jQ3mnQrfsDnj1eoVKQJwiWYTF1FQexh6Spy/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=omX1hgiAI0v7J8wT7+hdBQck8hqWMWAGsUE/ZB4SS2P5wKUK1kmUqbeN4zaQRQfeQ9ELTTNbabqlr0EboD8uPAWx29NoeOM0cQq/dKO3Agkl/gXEkx4HnKAw7ya4qS3uyAIlqqyZMwc5QbQyk5JOC4iIjpMdM7iEtgOyQ0c2XeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjlA5zxB; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjlA5zxB"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-664d78637f8so1038434d50.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 09:54:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783097670; cv=none;
        d=google.com; s=arc-20260327;
        b=EEmF7Pm+0qZWarKUBvNuBoB5y/MhoPqKbZwOKtL1CxAcXtycvXJ/U2Wg/ulsTh0NzJ
         ip/X7Nzw/gMqAa0EcpU6QkTYoNmwHtyvaabVwEIaapu9wqC5NXW4TLmOD0TcNLAd1Fb6
         PNEFEmB/pUTwt5TDV40l5JQhowHDbWKGfuicnm7P4kNVpSyEz02FHIpkdCDv5UirvRhQ
         9bhOErTdxCvwzrxnVVpaZtFJB15rRxt/GWi7fwsghn0W31jS0aIkVdaZ+CJwP8t/tJ7y
         67p83Bic+iu3deMi6VwVbCr2OkrgAbDLLkE58ceaqUjWssZQqCLt745BpJPCA/vEj6q6
         uIug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8IHVIq6aTVeicJxwNAdXsAWRL7IQFuAQm5hj4aed5cs=;
        fh=fcledGqQStPJeaqWplRJenpnRFwDw06rK+VOD46pTOo=;
        b=iCUkeOD+foyRN1SLRuJsIXz0zuol51AL+nqfsmrFmOfw9p1A/NpuThTWs3HUh6sGXe
         XjCWbJC8dzdq2iFItMCIWJGGLB/ZQh1M9yWEXL8iklMtUVh+d7CLFjXfOQ1OXKaqoCBq
         w2G2dZvc+mj2DAHzrkJLF4N6DtOpwySAVzU1hHWxiRMxd3AHop+eFCbUZL5EgYqpcGKJ
         RLhxl/RbDhkznSq6NicCO4uG39loVqBWwzQgq3rMXJVPe4B4UZkurGlxSc642Qir527l
         /nv2IqraHd6ZAruHdeC3gBPS9dHS53meHH1rEG93tZf8in7DKIxVo7/hYov4UluQ0ArY
         DtJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783097670; x=1783702470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8IHVIq6aTVeicJxwNAdXsAWRL7IQFuAQm5hj4aed5cs=;
        b=AjlA5zxB0EmaVRKGYj2ckvbkA1o/gTS4VRCr3moD1zi05yAyqaadPrSB43n8gO6nrY
         qCksnsR1frZKcufMNXcAFbRXxW0XpjB+VQxxY75NJ3M1++GgC3u0vMxIw8y7WgpirV/G
         FJ/Hf6TjZpthjKQ0RTmBzfqskXesw5A4DMQ1sOZNmznhf2vpkFXz4DCJI//+zI4XzcXD
         kbg4FYUSYMcymsU3KBUoBG2qS3+yElx5jU3tdgFUngbxeWR9cwKW8x8GI1J7BdLbxnfE
         rj6LErIGwkXjYBabbk8cJ5P67v/P9SZM8ppmyl7q9P7QJtE4/YM7BCyFbLQOgig6GPUD
         +RlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783097670; x=1783702470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8IHVIq6aTVeicJxwNAdXsAWRL7IQFuAQm5hj4aed5cs=;
        b=mpx0WkJEHRNOEa/z/vDchILziIDy4HSigRd0X12Yl+InDg11w1lQLWlJihF7cLJXLS
         cuvR5IfbQYyRkZ/JLMk5sxZLydB53jYSXMkVoLsAaynaPg3w8L5rycM309+X6EW0j1uw
         FYapy5x9cBGACE+R2KkJOeARf09q85+EBiwnbJrzwGBPebFMKCzROFntmF2w1U5zbvP8
         DzY9E1m4xEvw4uzS9aCH6dzAdT2I4RTECGywu1oYelCIAA05EuFckAOtK4vxayB7fitF
         9V4+b+xnWabFNztXeSOsFcQCxoO14bs0mpNrVqwIhtMT0DvPOCckTPJIRNQVlJe9WxmD
         nurA==
X-Forwarded-Encrypted: i=1; AHgh+RrLqCpcM88bdsc0PofI64gTtlbvtiZhTPa4ZciPOuaicYIIN27HPkhSyqwk6vb5KneBGev+obhYTSuLvmg0C9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzccIFd61zzQY+9tH7dw4EaHJlY7gjjMXLiTZZv4IHGdMYefCRz
	sN+g4prodvTZK+ZOSirO8/infMWm+vOByeAVLv9SKBz2M15bBYPOsaZxoEwXGJLPXzgHQgd0oQ7
	R0AKAY4zgdAlQZy/pCD8Et6qb9a5pyjo=
X-Gm-Gg: AfdE7ckRK8dW5f6Due6VZm4YTLHq/c10rR1Nz5vt/OXTHrYrcD1qow27ulQFdT8P0zo
	GvTMftItN4Ty0neu8+kDTF5VoxdlEN+qQdwMBXhMzXEjBmqURb7Kez6i//gfFNidr0hEGfIqXm4
	VUG+w1CU4nPH9SFX6+t8ycD/3rbiO0x+6V8vsGOkRQ9hutbuDL0BvexL1fsEW5THrXcVffvmv6n
	P8+JBmOJ9TkiV1pPTBMNKrXo6pKsOWPTsZKf/2hx6DzaJcot3VFYBT+2lEqTo4K1UnV+pzzImLv
	Fp8pWMEXEQ==
X-Received: by 2002:a05:690c:350a:b0:80c:85e5:8736 with SMTP id
 00721157ae682-8173a4dca80mr692977b3.68.1783097669943; Fri, 03 Jul 2026
 09:54:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703060016.570188-1-zzzccc427@gmail.com> <CABBYNZ+G-=3Np-9+-LJGnzW2W4HDhQdAEJ_EJHEJR=PiP6+dZg@mail.gmail.com>
In-Reply-To: <CABBYNZ+G-=3Np-9+-LJGnzW2W4HDhQdAEJ_EJHEJR=PiP6+dZg@mail.gmail.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Sat, 4 Jul 2026 00:54:18 +0800
X-Gm-Features: AVVi8CefWcj4VQHWAQoHzbUZTZ8q4Fern0mZOjrg_O-1fsM62TyySlpJOxDA4Uk
Message-ID: <CAFRLqsUnwHZ5O4-W_7SDn3UkymTFA7UwC3nToif8E28hWKViGw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: MGMT: snapshot LOAD_CONN_PARAM data before
 queueing update
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

Thanks for the review and suggestion. That makes sense.

I reworked this for v2 and I will send it soon.

Best regards,
Cen Zhang


Luiz Augusto von Dentz <luiz.dentz@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=
=883=E6=97=A5=E5=91=A8=E4=BA=94 23:10=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Cen,
>
> On Fri, Jul 3, 2026 at 2:00=E2=80=AFAM Cen Zhang <zzzccc427@gmail.com> wr=
ote:
> >
> > MGMT_OP_LOAD_CONN_PARAM queues conn_update_sync() when a single paramet=
er
> > update changes an existing LE central connection. The queued work curre=
ntly
> > stores the hci_conn_params object from hdev->le_conn_params. A later
> > LOAD_CONN_PARAM request can clear disabled parameters and free that obj=
ect
> > before hci_cmd_sync_work() runs the queued callback.
> >
> > The buggy scenario involves two paths, with each column showing the ord=
er
> > within that path:
> >
> >   LOAD_CONN_PARAM update path:        LOAD_CONN_PARAM clear path:
> >   1. update the existing params       1. process a later multi-param lo=
ad
> >   2. queue conn_update_sync(params)   2. clear disabled parameters
> >   3. return while the callback        3. free the queued params object
> >      is still pending
> >   4. callback dereferences params
>
> This is valid though, which means the first update shouldn't even take
> place if the parameters are freed while the callback is pending.
>
> > Validation reproduced this kernel report:
> > BUG: KASAN: slab-use-after-free in conn_update_sync+0x2a/0xf0 [bluetoot=
h]
> > Read of size 1 at addr ffff88810c697126 by task kworker/u17:0/377
> > Workqueue: hci0 hci_cmd_sync_work [bluetooth]
> >
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x66/0xa0
> >  print_report+0xce/0x5f0
> >  ? conn_update_sync+0x2a/0xf0 [bluetooth]
> >  ? __virt_addr_valid+0x19f/0x330
> >  ? conn_update_sync+0x2a/0xf0 [bluetooth]
> >  kasan_report+0xe0/0x110
> >  ? conn_update_sync+0x2a/0xf0 [bluetooth]
> >  ? __pfx_conn_update_sync+0x10/0x10 [bluetooth]
> >  conn_update_sync+0x2a/0xf0 [bluetooth]
> >  hci_cmd_sync_work+0x187/0x210 [bluetooth]
> >  process_one_work+0x4fd/0xbc0
> >  worker_thread+0x2d8/0x570
> >  kthread+0x1ad/0x1f0
> >  ret_from_fork+0x3c9/0x540
> >  ret_from_fork_asm+0x1a/0x30
> >
> > Allocated by task 466:
> >  kasan_save_stack+0x33/0x60
> >  kasan_save_track+0x17/0x60
> >  __kasan_kmalloc+0xaa/0xb0
> >  hci_conn_params_add+0xa6/0x240 [bluetooth]
> >  load_conn_param+0x4e1/0x850 [bluetooth]
> >  hci_sock_sendmsg+0x96b/0xf80 [bluetooth]
> >  sock_write_iter+0x28e/0x2a0
> >  vfs_write+0x6e4/0x810
> >  ksys_write+0x147/0x170
> >  do_syscall_64+0x115/0x6a0
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Freed by task 474:
> >  kasan_save_stack+0x33/0x60
> >  kasan_save_track+0x17/0x60
> >  kasan_save_free_info+0x3b/0x60
> >  __kasan_slab_free+0x5f/0x80
> >  kfree+0x313/0x590
> >  hci_conn_params_clear_disabled+0x9b/0xc0 [bluetooth]
> >  load_conn_param+0x4bf/0x850 [bluetooth]
> >  hci_sock_sendmsg+0x96b/0xf80 [bluetooth]
> >  sock_write_iter+0x28e/0x2a0
> >  vfs_write+0x6e4/0x810
> >  ksys_write+0x147/0x170
> >  do_syscall_64+0x115/0x6a0
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Queue a private copy of the address and connection parameter values
> > instead, and free that copy from the sync-work destroy callback. The li=
ve
> > hdev->le_conn_params entry can then be cleared without invalidating que=
ued
> > work.
> >
> > Fixes: 0ece498c27d8c ("Bluetooth: MGMT: Make MGMT_OP_LOAD_CONN_PARAM up=
date existing connection")
> > Assisted-by: Codex:gpt-5.5
> > Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> > ---
> >  net/bluetooth/mgmt.c | 30 +++++++++++++++++++++++++++---
> >  1 file changed, 27 insertions(+), 3 deletions(-)
> >
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index 733a4b70e10c..4a38f7663445 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -7947,6 +7947,11 @@ static int conn_update_sync(struct hci_dev *hdev=
, void *data)
> >         return hci_le_conn_update_sync(hdev, conn, params);
> >  }
> >
> > +static void conn_update_sync_destroy(struct hci_dev *hdev, void *data,=
 int err)
> > +{
> > +       kfree(data);
> > +}
> > +
> >  static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void=
 *data,
> >                            u16 len)
> >  {
> > @@ -8054,9 +8059,28 @@ static int load_conn_param(struct sock *sk, stru=
ct hci_dev *hdev, void *data,
> >                             (conn->le_conn_min_interval !=3D min ||
> >                              conn->le_conn_max_interval !=3D max ||
> >                              conn->le_conn_latency !=3D latency ||
> > -                            conn->le_supv_timeout !=3D timeout))
> > -                               hci_cmd_sync_queue(hdev, conn_update_sy=
nc,
> > -                                                  hci_param, NULL);
> > +                            conn->le_supv_timeout !=3D timeout)) {
> > +                               struct hci_conn_params *update;
> > +
> > +                               /* Queue a private snapshot so the live=
 params
> > +                                * entry can be freed later.
> > +                                */
> > +                               update =3D kzalloc_obj(*update);
> > +                               if (!update)
> > +                                       continue;
> > +
> > +                               update->addr =3D hci_param->addr;
> > +                               update->addr_type =3D hci_param->addr_t=
ype;
> > +                               update->conn_min_interval =3D min;
> > +                               update->conn_max_interval =3D max;
> > +                               update->conn_latency =3D latency;
> > +                               update->supervision_timeout =3D timeout=
;
> > +
> > +                               if (hci_cmd_sync_queue(hdev, conn_updat=
e_sync,
> > +                                                      update,
> > +                                                      conn_update_sync=
_destroy) < 0)
> > +                                       kfree(update);
> > +                       }
>
> So this will probably need to do a lookup to check if hci_conn_params
> have been removed then don't perform any update.
>
> >                 }
> >         }
> >
> > --
> > 2.43.0
> >
>
>
> --
> Luiz Augusto von Dentz
