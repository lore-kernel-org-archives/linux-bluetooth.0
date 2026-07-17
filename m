Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42751302753
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303182; cv=pass; b=DOLhar45WU0hyYPQpX9MqB013WrFLFZInoHGufKfpYD3DII8Wre1KVKp0ZFuK37Il7ABjaI24UJhjYwxjQxxefCoiBswb7kIqDc7odLKUqm5IZCqPHTdawozowXjQyYXfech7A3iy043tOwDzi2/rGejyqIW4lUxZbaZvHaBSqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303182; c=relaxed/simple;
	bh=+UKobus1uJF2lYKmDUpgh5cqzsGlu93Xz7vSkRHGWwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1/X8cxnTAl2zcIEd6d3TIoMIzcNp3SZuWkhm1QBiorkYNOs4+SSH5vwCxDsmr7oNW7+BapX0TdTRAXqeL/S5S9nzCKCeI15bCuLS8EKPQnalHOzi++RL/iwdR68u4wVlnA+LhpEawbxs6AgZ8C090m7pdHKyiuSDjy/3kwQhCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtXozctY; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtXozctY"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81e9d8f3289so57913667b3.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 08:46:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784303180; cv=none;
        d=google.com; s=arc-20260327;
        b=hIBeJ2z0vroI5kTI4w6qHF6jL7TJaZwATkx0xtGPtJngQZI2SphGKSW7UwD1ZnmPFT
         f8A3MsQLDdG6ux1AxXWw02tYoIBYnho861EpsWFO2//1ZQe0406cHi34QaPF6RpY21+Z
         IakZYw8n7gPpkECVaWauy/BDVvqesSK12g+b5U0dQwYiItyYZSY8jzezUEx6UmO/LGAm
         lxc40+1E5s3SN/ZowEyoal9H0vboiXu3EvDeaEKldP3YMLrkOMc6MthwvY6N3Kw0H8Oh
         DPigZX6Keu1+NmstjZs2Q9Fx5ge5BRu3+qzbEX4cdcYWEcEWrh4KQtx1KvEi84T3XOfJ
         wfHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vj0gJgcYNoaSbkKhtDMLLLraKsDVUFl0+9RAnK1M0CU=;
        fh=SPVv+hyDtCYw/w4JWDVLs++kFTWEVgRFrw593GpkOsc=;
        b=HzepzDizw50k7H83+UynI0gojoKOxwCF0zTP6ak/Xr2DxV0PlgCShCwB9Wh9BJClQG
         QaVzlQszNgpzKxKmH6u6H9thsDeXUwJMsRJm2vrx4xb1qMUqOce43XXynadgRTkf9MYj
         IaTEJRAAsAOwPhFM1rS8IQYNtxTibTQg1Q9KiE9j2nK3i3F0TdpTHt3w/IBmw6l0Ta5F
         KN86uatX4k7Qa5jypIWZwV8vctfVn/s6PzwG4FTol6n8HXwvwEYlB9gjn89HKtkz/LfC
         kl1cUcA7lsiQHQjh7DTHMFxFWwiEDmJpSx0F/5sOXEcteQrxBowpjKB3msMZDhvgvRem
         SSbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784303180; x=1784907980; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vj0gJgcYNoaSbkKhtDMLLLraKsDVUFl0+9RAnK1M0CU=;
        b=JtXozctYbXlYhhMd9ZVSorbH7mnmLmm+ZyJL9nSjsJXv8d2u1IHWYOG2B3J5gdVquA
         oZ1q1b+6IxwJIviXbnjrUSxBXypj92p0ntCkKC5OVc4n1RCl/eAdRp03AG6S24zlndva
         THuFlO3GrQOpJmKAbQzhsXl5zXUpNw0yCyZokBz0B2rcK1oLDGniDGx+dsWuRa8cgE5X
         7e7m6Jcw5nuh6V1702bH7t26Bp4U9rPqgTUgI1qasPK9hVWwL7pYIa8phUfsd1UhudJs
         0CZu7TVMUe3PbkfvHa/GRTtpYLTjZTBr/ZRRngYqr6HW4GVX3ISbjGSnKh/LD2vyGfKt
         InJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784303180; x=1784907980;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vj0gJgcYNoaSbkKhtDMLLLraKsDVUFl0+9RAnK1M0CU=;
        b=iyNdXWDxPg1/wtGJ47NCx2iXsrJ/swo8ESXkxyqNj8cMJh9rAPyib0vy0CAK951CtU
         zq5Su4U43oVgdOASSiD/jazMgmYxZCocCR3VSZNnMB/jcXO3SzAswBbHCEKULfAiky8B
         Noyi4iqaIXxV9k1E/MMgetblTFOSY3DkTgKuatVn947FjZUgLxeHvqy8GYrkOtC94FOp
         52hLuvEc5+WQDGHBCVMuAJTE/C1qzC3WCCtxYMkk1443lw1uRvPNpUTamG+T90gUaG4l
         IZErFPlbB3AGn8NFt6q6LTY21zuDQhKF+B7++B5soTkWLrZidTIy8/Y0+G18nQWQIPnS
         RsxA==
X-Gm-Message-State: AOJu0YwumLRWMzXWMAybcatmi3qpDf//gBMuuM0svEB/gYi80xmowMKg
	tVxhekOmEmhvctxXlC6WUn5VuxBnGcKJ4dnzLWzwGzwxOX2tSSUs8B7ab4PtZmWTTA415r2BT3i
	IFWojkdwcEAexiVAuhnopuduUMb8NfhE=
X-Gm-Gg: AfdE7cm197EuhqwbPR/m/1CpAnruAoVT+ENhRUi6LY/01uMLHoRx6ta0dcw3kEzlWZt
	nHXbncOsZ+F6o8w9IOhB7fKyORqZ00bczfvGu6QujZvBWzHMS1bp94UelUuiQhItmG5AQQzWVkO
	09GQ6YWLRfXoUUQ0/W75GrBdH0vurBAP73JEx5fmHuhI5ZMdiJWDfAUzgnVyM4JgRbX+eNSpAmi
	kjJcnoKpwPLYapIP2Y+uFqgeWZDg/shaAoq3LuQncRTF6tE8KzBjYMR47hA7yTL
X-Received: by 2002:a05:690c:6385:b0:81e:8a49:1ff8 with SMTP id
 00721157ae682-81ef2610bf8mr10734927b3.45.1784303179983; Fri, 17 Jul 2026
 08:46:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703060024.570535-1-zzzccc427@gmail.com>
In-Reply-To: <20260703060024.570535-1-zzzccc427@gmail.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Fri, 17 Jul 2026 23:46:08 +0800
X-Gm-Features: AUfX_mzVTaaeVi1yuf1QCGAQkkQCAk1wsoVusXoyj1Ua_mLgVU-FonclRwhVhOA
Message-ID: <CAFRLqsVdaKE63gAKVuAjv++CM1z8hX1hYh6N3BxHkVaoyKnKVw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: MGMT: dequeue queued mesh send before freeing
 canceled tx
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marcel, Luiz,

Gentle ping on this patch.

Could you please take a look when you have a chance?

Thanks!

Best regards,
Cen Zhang

Cen Zhang <zzzccc427@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=883=E6=97=A5=
=E5=91=A8=E4=BA=94 14:00=E5=86=99=E9=81=93=EF=BC=9A
>
> mesh_next() queues mesh_send_sync() with a raw mgmt_mesh_tx pointer after
> a previous mesh send completes. MGMT_OP_MESH_SEND_CANCEL can already be
> queued on the same hci_cmd_sync_work list. If cancel runs before the queu=
ed
> send, it can remove and free the same mgmt_mesh_tx while mesh_send_sync()
> still carries that pointer as callback data.
>
> The buggy scenario involves two paths, with each column showing the order
> within that path:
>
>   mesh completion path:              cancel command path:
>   1. mesh_send_done_sync() returns   1. send_cancel is already queued
>   2. mesh_next() selects next_tx     2. send_cancel finds next_tx
>   3. mesh_next() queues              3. send_cancel frees next_tx
>      mesh_send_sync(next_tx)
>   4. mesh_send_sync() later
>      dereferences next_tx
>
> Validation reproduced this kernel report:
> BUG: KASAN: slab-use-after-free in mesh_send_sync+0x5a/0x1c0 [bluetooth]
> Read of size 1 at addr ffff88811a01d13b by task kworker/u17:0/562
> Workqueue: hci0 hci_cmd_sync_work [bluetooth]
>
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x66/0xa0
>  print_report+0xce/0x5f0
>  ? mesh_send_sync+0x5a/0x1c0 [bluetooth]
>  ? __virt_addr_valid+0x19f/0x330
>  ? mesh_send_sync+0x5a/0x1c0 [bluetooth]
>  kasan_report+0xe0/0x110
>  ? mesh_send_sync+0x5a/0x1c0 [bluetooth]
>  ? __pfx_mesh_send_sync+0x10/0x10 [bluetooth]
>  mesh_send_sync+0x5a/0x1c0 [bluetooth]
>  ? mesh_send_sync+0x9/0x1c0 [bluetooth]
>  ? __pfx_mesh_send_sync+0x10/0x10 [bluetooth]
>  hci_cmd_sync_work+0x187/0x210 [bluetooth]
>  process_one_work+0x4fd/0xbc0
>  worker_thread+0x2d8/0x570
>  kthread+0x1ad/0x1f0
>  ret_from_fork+0x3c9/0x540
>  ret_from_fork_asm+0x1a/0x30
>
> Allocated by task 602:
>  kasan_save_stack+0x33/0x60
>  kasan_save_track+0x17/0x60
>  __kasan_kmalloc+0xaa/0xb0
>  mgmt_mesh_add+0x41/0x1a0 [bluetooth]
>  mesh_send+0x197/0x3a0 [bluetooth]
>  hci_sock_sendmsg+0x96b/0xf80 [bluetooth]
>  __sys_sendto+0x2bc/0x2d0
>  __x64_sys_sendto+0x76/0x90
>  do_syscall_64+0x115/0x6a0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 562:
>  kasan_save_stack+0x33/0x60
>  kasan_save_track+0x17/0x60
>  kasan_save_free_info+0x3b/0x60
>  __kasan_slab_free+0x5f/0x80
>  kfree+0x313/0x590
>  send_cancel+0x1d8/0x210 [bluetooth]
>  hci_cmd_sync_work+0x187/0x210 [bluetooth]
>  process_one_work+0x4fd/0xbc0
>  worker_thread+0x2d8/0x570
>  kthread+0x1ad/0x1f0
>  ret_from_fork+0x3c9/0x540
>  ret_from_fork_asm+0x1a/0x30
>
> Dequeue any queued mesh_send_sync() for the target tx from send_cancel().
> When a queued send is found, the dequeue path invokes
> mesh_send_start_complete(), which completes and frees the tx; send_cancel=
()
> must not complete it again.
>
> Fixes: b338d91703fa ("Bluetooth: Implement support for Mesh")
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> ---
>  net/bluetooth/mgmt.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 733a4b70e10c..ac4922cb39b5 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -2416,17 +2416,28 @@ static int send_cancel(struct hci_dev *hdev, void=
 *data)
>         struct mgmt_mesh_tx *mesh_tx;
>
>         if (!cancel->handle) {
> -               do {
> +               for (;;) {
>                         mesh_tx =3D mgmt_mesh_next(hdev, cmd->sk);
>
> -                       if (mesh_tx)
> -                               mesh_send_complete(hdev, mesh_tx, false);
> -               } while (mesh_tx);
> +                       if (!mesh_tx)
> +                               break;
> +
> +                       /* Dequeue any queued send before freeing the tx.=
 */
> +                       if (hci_cmd_sync_dequeue(hdev, mesh_send_sync, me=
sh_tx,
> +                                                mesh_send_start_complete=
))
> +                               continue;
> +
> +                       mesh_send_complete(hdev, mesh_tx, false);
> +               }
>         } else {
>                 mesh_tx =3D mgmt_mesh_find(hdev, cancel->handle);
>
> -               if (mesh_tx && mesh_tx->sk =3D=3D cmd->sk)
> -                       mesh_send_complete(hdev, mesh_tx, false);
> +               if (mesh_tx && mesh_tx->sk =3D=3D cmd->sk) {
> +                       /* Dequeue any queued send before freeing the tx.=
 */
> +                       if (!hci_cmd_sync_dequeue(hdev, mesh_send_sync, m=
esh_tx,
> +                                                 mesh_send_start_complet=
e))
> +                               mesh_send_complete(hdev, mesh_tx, false);
> +               }
>         }
>
>         mgmt_cmd_complete(cmd->sk, hdev->id, MGMT_OP_MESH_SEND_CANCEL,
> --
> 2.43.0
