Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66512114;
	Tue, 29 Oct 2024 14:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730210449; cv=none; b=kk9qaR4XBEiLr5WafAzWaOs5NnuhVcGKoxxXBcj7RoY6fLGmtbTeiAlTddlb1bj0dkBfIKCwvvDtM94i9ir0rlK4rrAgQPHwHzpoW58glOC7TpxPWu/Qwwf9KaBXBqfCmruKUMZjUk0q3rtqtW/BrTAldRZspq5PvSFoFBVhBuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730210449; c=relaxed/simple;
	bh=lHwjzQwwi2GIbhYJDSVVMLbyCXgotdotxz1qHcAHyCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RADgbwZ/Qu6G73WjBbfetiHt2xtOXC4CyaYZxrvUyk479/yvne+3WtKpBr9rZ/gtG+Q3llKZeHvykQpmORJJRaAWVjFuAlxfs80uvGw7N4ld+TTP3a3EpN3dIY0HVp9mAjxhy0pxJnXTSQm17rs6Jm/6HVZy7uNuswcFR8RcdJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpwdL1ZH; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpwdL1ZH"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb5743074bso44777711fa.1;
        Tue, 29 Oct 2024 07:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730210445; x=1730815245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojZC2nOVUDIw/kk3Ky4Vr0ESQa/hg/6z1X5oOfns3vs=;
        b=EpwdL1ZHNQHx4PhBcgfB1Iy/Lme1z1YZI9HZfG7KPO+YoS3nEjtSUIVgDfEIQefpOm
         eiQNU0GBdqj1rI7N0l90EqC3Ob8EDFAPf7zjET2Sp8DeeXQK5LcBrhP8dGm7QuXKic1z
         14pdm0PkenOwmciXxJyTzEcBl4J7m28+lnso/vo0Qo/ViCYQj5IeI7uICnasYVEEp1tw
         sqD2QDDx1MVhZgV53HQ0XiIxUXlRUFZWZmjF3OonnRSlQGzTY+kMyKGyMRQfO3ukGVhk
         v/GMecScCdWUVEiMRMMwD44/BuB+mdKADd5851DeFKPvM7n0e4ywDWi70xL1cLEYeogl
         DF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730210445; x=1730815245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojZC2nOVUDIw/kk3Ky4Vr0ESQa/hg/6z1X5oOfns3vs=;
        b=vdES1E2WWY3GKnw76zIXaGXbodUgGXehOFMu1Bj4QDrBOfnGGrhjtX2mWDi4IhoUxI
         i3uIPxQ2OPyYB3BlfLVGy0hYjJtzGReVgJa4ilwZYsRyC7WqQzARe7pNU7WAwxxshbKr
         cc7S34wrEXL+MQpap059k+Nfab7VVkEYr6B9g0AsbQh17IpRrCLCokByna5nt/kxLxGe
         evC0SUXkANlevolKgxtskEhyNGivvb+RhekDCxVACP7854njZHxBhO/Bx0S37qRWMgv2
         9SQBFBzfRPqw/6Y1LaX3KGyxXXb8f2lZxQd2VPOe6APZKgSoT8PplBi6YUulIy8YERfU
         nPlw==
X-Forwarded-Encrypted: i=1; AJvYcCWT+W7vaJec15jW3blRt3+01kyFy7hrPWNoCa7hrNbFNljMdAMII3lbSgtYXkuj+TqCvZBuM7DA1zGWR5zP@vger.kernel.org, AJvYcCX45TVC8vbQJkq2jR2yr57Szfd/dD+AEtuDrYUc4xioDt3Ln/yaiPOCcqh56fE6aVPYmLbLx2Dot7sNZXOVAzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvHeq4G1C20L7+nyFUL2HAhWoq+gaW08Y3K5h41cmzgOoS4fhZ
	Na/XB5zpT+YMT6mNGtQUHZJGAI5X7GZ9l51jsD0Od3+380BNzAfirGSMulptmF7JZn1nzbZ0Y85
	s718ea8N1He6M/fOlof8sHLq4GHk=
X-Google-Smtp-Source: AGHT+IGyLicUjMryDek+bmwKdouHVchiYaZzGyv6G1gDH2j/bTbYVOYl/80NFLgKqsCXy4pIKu4L6SRBQzYsw7rj3+c=
X-Received: by 2002:a2e:a983:0:b0:2fb:5d19:4689 with SMTP id
 38308e7fff4ca-2fcdc7604b2mr7487751fa.1.1730210444584; Tue, 29 Oct 2024
 07:00:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706225124.1247944-1-iam@sung-woo.kim> <CAJNyHp+2eAeau9peWPL7J2Mq3p26FdFzk8mPOCchxCw+26sevA@mail.gmail.com>
In-Reply-To: <CAJNyHp+2eAeau9peWPL7J2Mq3p26FdFzk8mPOCchxCw+26sevA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 29 Oct 2024 10:00:31 -0400
Message-ID: <CABBYNZJp102JWcUt-qke0QYB1Tfta6C+hYAStCcopDckgT_EUw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci: fix null-ptr-deref in hci_read_supported_codecs
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: daveti@purdue.edu, benquike@gmail.com, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sungwoo,

On Mon, Oct 28, 2024 at 10:41=E2=80=AFPM Sungwoo Kim <iam@sung-woo.kim> wro=
te:
>
> Dear Luiz, could you review this? This bug and fix are still valid but
> have been forgotten for some reason.

Please resend.

> On Sat, Jul 6, 2024 at 6:53=E2=80=AFPM Sungwoo Kim <iam@sung-woo.kim> wro=
te:
> >
> > __hci_cmd_sync_sk() returns NULL if a command returns a status event
> > as there are no parameters.
> > Fix __hci_cmd_sync_sk() to not return NULL.
> >
> > KASAN: null-ptr-deref in range [0x0000000000000070-0x0000000000000077]
> > CPU: 1 PID: 2000 Comm: kworker/u9:5 Not tainted 6.9.0-ga6bcb805883c-dir=
ty #10
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04=
/01/2014
> > Workqueue: hci7 hci_power_on
> > RIP: 0010:hci_read_supported_codecs+0xb9/0x870 net/bluetooth/hci_codec.=
c:138
> > Code: 08 48 89 ef e8 b8 c1 8f fd 48 8b 75 00 e9 96 00 00 00 49 89 c6 48=
 ba 00 00 00 00 00 fc ff df 4c 8d 60 70 4c 89 e3 48 c1 eb 03 <0f> b6 04 13 =
84 c0 0f 85 82 06 00 00 41 83 3c 24 02 77 0a e8 bf 78
> > RSP: 0018:ffff888120bafac8 EFLAGS: 00010212
> > RAX: 0000000000000000 RBX: 000000000000000e RCX: ffff8881173f0040
> > RDX: dffffc0000000000 RSI: ffffffffa58496c0 RDI: ffff88810b9ad1e4
> > RBP: ffff88810b9ac000 R08: ffffffffa77882a7 R09: 1ffffffff4ef1054
> > R10: dffffc0000000000 R11: fffffbfff4ef1055 R12: 0000000000000070
> > R13: 0000000000000000 R14: 0000000000000000 R15: ffff88810b9ac000
> > FS:  0000000000000000(0000) GS:ffff8881f6c00000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f6ddaa3439e CR3: 0000000139764003 CR4: 0000000000770ef0
> > PKRU: 55555554
> > Call Trace:
> >  <TASK>
> >  hci_read_local_codecs_sync net/bluetooth/hci_sync.c:4546 [inline]
> >  hci_init_stage_sync net/bluetooth/hci_sync.c:3441 [inline]
> >  hci_init4_sync net/bluetooth/hci_sync.c:4706 [inline]
> >  hci_init_sync net/bluetooth/hci_sync.c:4742 [inline]
> >  hci_dev_init_sync net/bluetooth/hci_sync.c:4912 [inline]
> >  hci_dev_open_sync+0x19a9/0x2d30 net/bluetooth/hci_sync.c:4994
> >  hci_dev_do_open net/bluetooth/hci_core.c:483 [inline]
> >  hci_power_on+0x11e/0x560 net/bluetooth/hci_core.c:1015
> >  process_one_work kernel/workqueue.c:3267 [inline]
> >  process_scheduled_works+0x8ef/0x14f0 kernel/workqueue.c:3348
> >  worker_thread+0x91f/0xe50 kernel/workqueue.c:3429
> >  kthread+0x2cb/0x360 kernel/kthread.c:388
> >  ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >
> > Fixes: abfeea476c68 ("Bluetooth: hci_sync: Convert MGMT_OP_START_DISCOV=
ERY")
> >
> > Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
> > ---
> > v1 -> v2: make __hci_cmd_sync_sk() not return NULL
> >
> >  net/bluetooth/hci_sync.c | 18 +++++++++++-------
> >  1 file changed, 11 insertions(+), 7 deletions(-)
> >
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index 76b283b8e..c4e4abc6e 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -201,6 +201,12 @@ struct sk_buff *__hci_cmd_sync_sk(struct hci_dev *=
hdev, u16 opcode, u32 plen,
> >                 return ERR_PTR(err);
> >         }
> >
> > +       /* If command return a status event skb will be set to NULL as =
there are
> > +        * no parameters.
> > +        */
> > +       if (!skb)
> > +               return ERR_PTR(-ENODATA);
> > +
> >         return skb;
> >  }
> >  EXPORT_SYMBOL(__hci_cmd_sync_sk);
> > @@ -250,6 +256,11 @@ int __hci_cmd_sync_status_sk(struct hci_dev *hdev,=
 u16 opcode, u32 plen,
> >         u8 status;
> >
> >         skb =3D __hci_cmd_sync_sk(hdev, opcode, plen, param, event, tim=
eout, sk);
> > +
> > +       /* If command return a status event, skb will be set to -ENODAT=
A */
> > +       if (skb =3D=3D ERR_PTR(-ENODATA))
> > +               return 0;
> > +
> >         if (IS_ERR(skb)) {
> >                 if (!event)
> >                         bt_dev_err(hdev, "Opcode 0x%4.4x failed: %ld", =
opcode,
> > @@ -257,13 +268,6 @@ int __hci_cmd_sync_status_sk(struct hci_dev *hdev,=
 u16 opcode, u32 plen,
> >                 return PTR_ERR(skb);
> >         }
> >
> > -       /* If command return a status event skb will be set to NULL as =
there are
> > -        * no parameters, in case of failure IS_ERR(skb) would have be =
set to
> > -        * the actual error would be found with PTR_ERR(skb).
> > -        */
> > -       if (!skb)
> > -               return 0;
> > -
> >         status =3D skb->data[0];
> >
> >         kfree_skb(skb);
> > --
> > 2.34.1
> >



--=20
Luiz Augusto von Dentz
