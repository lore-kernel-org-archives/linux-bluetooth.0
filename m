Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA121509B6
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Nov 2024 14:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729217; cv=none; b=k+hkCK+HCFvhfmzVgMG41ONKBhCJ04tvzQgAyxL+25wMP+vlAFYLCmhUqTkn4we+BchpgjFnSLLBrM+uIUQ9Iotiw9RGoLsSmmyxwXjI+prkR9RaUTofcUUkiFDExOaOsbyT+8pjZaULMtoYDUVzjO+vOBNKHxvD6PD9VaZXOnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729217; c=relaxed/simple;
	bh=bRbzdUBYm3OAw29tQsmz3p5+P90geA9ui5PLudJxiOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XlR1HsUsvdHyjAvRSl+HCkc7CZ0nCQ3BuAmykjCSPjn7lDG99H4M8NEdmL06umeTJD6ULgLc0tN8a0HhpBQzGSgyU3KQZDTftfWnRmCD18AW198t0elNBnhtF6wN3sodGZxCygJ9g/SC/WUYV9derr66SMscsEAcY0YzFcLBTvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIkvm038; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIkvm038"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb559b0b00so34093251fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Nov 2024 06:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730729214; x=1731334014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XKIrlkzT0JFeqZZITyVduSGRymgwjnDI5K04WOOZHs=;
        b=hIkvm038oyrwc6JfGxfi4DBPu9tyQ+oECJZoBVc7EXgNW/r2omTIRslELCefPk4TCN
         sJtfVprX6Td5bCQ9UBi+QsRrI7HrMGfHOyb/DWCnmydo+wUMt+TWv7EW4ANnGMPafNTA
         KxNEi85lx1PnU08hPgWru/wS+q1i6Sp7qdb7z8AzOrvKV6Po21a52lNeHcMUG2Cn5I1P
         yJw7k2FwJAdXMC9iHKI6VKxMzUncUloroPkfp/MAEq+jkUHve6BMfr/GBHFK5+IJdft5
         rWZRziTN15VJ1mbOZ7M88i2sxkGChprgvBsB/pXKAtgs2P7pv2LG0K/EycU/bFpUn6Qd
         xe9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730729214; x=1731334014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6XKIrlkzT0JFeqZZITyVduSGRymgwjnDI5K04WOOZHs=;
        b=VyRPmeF88Cx20HRgMQsv8PJh2T2957wokmhpr4iJ7iQlEE2df8/hNIgkubAvIS5zOl
         Plybd5aQ4uY5MC30ghE/EPTGm1yp22+CDcI4yMzYlse+yh8MHDtZGOoFVyb0tXs/jXqA
         vEfawzmfFHJfoOeIy0Jhy8gR5E9rI4e39kzeYQIG4mjSBF+DOAkl+tmNouCfDaE3N6qb
         Q3dhApVmapAIdB2rDoqDFBK/QmSN+QOWlbHmob5ntdGq/DXq8HBVffaokH/7aq4xVggs
         SUnMBhkvuEADKRwcBjsi9bduFUaNKWtQs6VtLe0BviWZherfWQGhe4g5CnuUrpRCzJo/
         gPEA==
X-Forwarded-Encrypted: i=1; AJvYcCW2OF4kJn1kSPv+yEWxd66nrTCubTQtBtjU5LxQ5q9FOGG3NhNYYJ00KU0gEIPO6gLiueH5Bbi6g1oLhVPpr48=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysn3sWx/u5yNK/KfcPvdN6hk+CWtjo3HZsrLTkfyMVqjcB4y7G
	9myHq7YV/kTWKjhfEu1nP1E0wiXtJjwWNOGPkU7M07N3KwPhQVIIMy9LYZfWi4NcHxBPD9qmMZn
	n9ioxL0qT9SfPwJm4uzjG34JAllfjXgP2
X-Google-Smtp-Source: AGHT+IGpD6ZtEHNvf1GVMOoYi/K8qdWgphL+BIvbXGkBlAIaAzYoe7s0Gj0i31FSFzErkrRRDdVQzyXOgE7UcnPrJvk=
X-Received: by 2002:a2e:be89:0:b0:2fa:c9ad:3d3c with SMTP id
 38308e7fff4ca-2fedb794df5mr61615171fa.6.1730729213388; Mon, 04 Nov 2024
 06:06:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101114410.234311-1-dmantipov@yandex.ru> <CABBYNZK=H9JtzaQudQ1b7TGU5VaJ_qX_bbSJhKSwWKh+5_1uUQ@mail.gmail.com>
 <5cc24ab9-80c0-4280-8c4c-d8b052524e1d@yandex.ru> <CABBYNZKvP3u+7juqNNUHOS0PTb=QVzxob+rC3PVq-XXu9vGU+A@mail.gmail.com>
 <fe1588ee-1f00-429c-a917-d1c5e08f3831@yandex.ru> <CABBYNZJiYHWgtBExZ2jbuemJdyo6inpiYMGF7qc9Xbjqu__L7w@mail.gmail.com>
 <CABBYNZJXMyJ0bjVAe=sY+zonvFwS2Eh2wiSuzGd+a6U-3-8=fg@mail.gmail.com> <2554961e-37b3-477a-8a78-724dfb092c02@yandex.ru>
In-Reply-To: <2554961e-37b3-477a-8a78-724dfb092c02@yandex.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 4 Nov 2024 09:06:40 -0500
Message-ID: <CABBYNZKNzVyKS7Fb4hnSf7xJmaXRzQxqHqc-7GtfKa7X=g_KBw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: fix use-after-free in device_for_each_child()
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	linux-bluetooth@vger.kernel.org, lvc-project@linuxtesting.org, 
	syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Sat, Nov 2, 2024 at 5:51=E2=80=AFAM Dmitry Antipov <dmantipov@yandex.ru>=
 wrote:
>
> On 11/1/24 8:37 PM, Luiz Augusto von Dentz wrote:
>
> > Looks like this doesn't solve the problem, in fact I think you are
> > getting it backwards, you are trying to reparent the parent dev not
> > the child and I assume by destroying the parent device there should be
> > some way to reset the parent which seems to be the intent the
> > following code in hci_conn_del_sysfs:
> >
> >      while (1) {
> >          struct device *dev;
> >
> >          dev =3D device_find_child(&conn->dev, NULL, __match_tty);
> >          if (!dev)
> >              break;
> >          device_move(dev, NULL, DPM_ORDER_DEV_LAST);
> >          put_device(dev);
> >      }
> >
> > But note that it only does that after matching tty, but I guess we
> > want to do it regardless otherwise we may have the child objects still
> > access it, that said we should probably use device_for_each_child
> > though if that is safe to do calls to device_move under its callback.
>
> I'm not sure that I've got your point. IIUC the problem is that a control=
ler
> (parent) instance may be freed _after_ the child (connection) has passed
> 'device_unregister(&conn->dev)' but _before_ an actual removal of 'conn->=
dev'
> from the devices hierarchy, thus leaving the dangling 'conn->dev.parent'
> pointer. The latter may be fixed by reparenting 'conn->dev' to NULL expli=
citly.
> And handling children of 'conn->dev' (i.e. the grandchilren of the contro=
ller)
> is out of this problem's scope at all.
>
> And nothing to say about syzbot's innards but manual testing shows that t=
he
> following thing:
>
> void hci_conn_del_sysfs(struct hci_conn *conn)
> {
>          struct hci_dev *hdev =3D conn->hdev;
>
>          bt_dev_dbg(hdev, "conn %p", conn);
>
>          if (!device_is_registered(&conn->dev)) {
>                  /* If device_add() has *not* succeeded, use *only* put_d=
evice()
>                   * to drop the reference count.
>                   */
>                  put_device(&conn->dev);
>                  return;
>          }
>
>          while (1) {
>                  struct device *dev;
>
>                  dev =3D device_find_any_child(&conn->dev);
>                  if (!dev)
>                          break;
>                  printk(KERN_ERR "%s:%d: reparent dev@%p(%s) with parent@=
%p(%s)\n",
>                         __FILE__, __LINE__, dev, dev_name(dev), dev->pare=
nt,
>                         (dev->parent ? dev_name(dev->parent) : "<none>"))=
;
>                  device_move(dev, NULL, DPM_ORDER_DEV_LAST);
>                  put_device(dev);
>          }
>
>          device_unregister(&conn->dev);
> }
>
> occasionally triggers the following crash:
>
> net/bluetooth/hci_sysfs.c:82: reparent dev@ffff888114be86f8(bnep0) with p=
arent@ffff888111c64b68(hci4:200)
> Oops: general protection fault, probably for non-canonical address 0xdfff=
fc000000000b: 0000 [#1] PREEMPT SMP KASI
> KASAN: null-ptr-deref in range [0x0000000000000058-0x000000000000005f]
> CPU: 3 UID: 0 PID: 6033 Comm: repro Not tainted 6.12.0-rc5-00299-g1106680=
1dd4b-dirty #8
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41=
 04/01/2014
> RIP: 0010:klist_put+0x4d/0x1d0
> Code: c1 ea 03 80 3c 02 00 0f 85 74 01 00 00 48 b8 00 00 00 00 00 fc ff d=
f 4c 8b 23 49 83 e4 fe 49 8d 7c 24 58 49
> RSP: 0018:ffffc9000423f9b0 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: ffff88810f43ac60 RCX: 0000000000000000
> RDX: 000000000000000b RSI: ffffffff8a92d415 RDI: 0000000000000058
> RBP: 0000000000000001 R08: 0000000000000000 R09: fffffbfff1fad62c
> R10: ffffffff8fd6b163 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000001 R14: ffffc9000423fa30 R15: ffffffff8a92d805
> FS:  00007f24ebb78740(0000) GS:ffff888135f00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055c52afb6950 CR3: 0000000020c1c000 CR4: 00000000000006f0
> Call Trace:
>   <TASK>
>   ? die_addr.cold+0x8/0xd
>   ? exc_general_protection+0x147/0x240
>   ? asm_exc_general_protection+0x26/0x30
>   ? klist_remove+0x155/0x2b0
>   ? klist_put+0x15/0x1d0
>   ? klist_put+0x4d/0x1d0
>   klist_remove+0x15a/0x2b0
>   ? __pfx_klist_remove+0x10/0x10
>   device_move+0x12d/0x10b0
>   hci_conn_del_sysfs.cold+0xcf/0x14a
>   hci_conn_del+0x467/0xd60
>   hci_conn_hash_flush+0x18f/0x270
>   hci_dev_close_sync+0x549/0x1260
>   hci_dev_do_close+0x2e/0x90
>   hci_unregister_dev+0x213/0x630
>   vhci_release+0x79/0xf0
>   ? __pfx_vhci_release+0x10/0x10
>   __fput+0x3f6/0xb30
>   task_work_run+0x151/0x250
>   ? __pfx_task_work_run+0x10/0x10
>   do_exit+0xa79/0x2c30
>   ? do_raw_spin_lock+0x12a/0x2b0
>   ? __pfx_do_exit+0x10/0x10
>   do_group_exit+0xd5/0x2a0
>   __x64_sys_exit_group+0x3e/0x50
>   x64_sys_call+0x14af/0x14b0
>   do_syscall_64+0xc7/0x250
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f

Weird, this was not reproduced by syzbot when I asked it to test, how
are you reproducing this? This looks like to be a problem with klist
being corrupted somehow, anyway if we can't unparent the objects we
need a way to unregister the child without waiting for the bnep thread
to clean it up.

> Dmitry



--=20
Luiz Augusto von Dentz
