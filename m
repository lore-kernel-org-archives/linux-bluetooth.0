Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540512D5923
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Sep 2025 09:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758705929; cv=none; b=HF+TG63ZI23DIdY15zxwf3zcSxmriwPB5mVEaK/FAxF0gneIdgg0ADj2u12Bmx+GYCIoX02v+P9ZLyCauICVvf2EyjAodWdMeiDGtzfC0xD69Wb+PuT01vIKyU+88R49L1TWTOFXBUYKZldeAo8Xdl5MUhurlhSjmp3U2797ip8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758705929; c=relaxed/simple;
	bh=pS+IlvLEaIJ4tBBXKqLLbtg8/zzsidU12L3xTeivLQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fuw2ZO2zZvjNIO4Z8YINqdKaPVO6UsG+XYOyC1lejZ8SGNwUE07NT7mFrr4qWIHEHsKgkjgCiRyDJWg5LczIwRYTsQ0iHleYCuEJJhgXntnhogKWq2zVD/uD1lETle6FbBNELvJqUMxr+20HSpjLdEy+yltmQ0qMKskBWRN8PFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxM4ZsY0; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxM4ZsY0"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-ea63e86b79aso4999076276.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Sep 2025 02:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758705923; x=1759310723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXhsS4TYQDsQipG2bqEWA0Eq2yU/6y2r8vtgidiAyQw=;
        b=hxM4ZsY0zUsVz4eGDPkHTpxow0CjiXfYlrmCkCHPxFSleH0VLs211s9q6TsLLmLUzc
         x+fxDt79x7S2cYDS3k0y42xC9xf163D5UMoMnKr2KmtCd08OlMOc0hicJFYzVV73lb5H
         PSBdKvw2xuKD9LLV8o5RlZVHkEUwnXQGWl5d1q6V1N7QXigknrQaR7RbU2O/BdFvdEvh
         w2rkzgUAM5VdaR+QsRDDWXTqWTfZQnI2sSQrW6a7MxwNE+JkxE4geeJHP05fil1Ei8sr
         7KlBGbFERMgBKumREjexFJR3FwRbUSwGWDnDsglk81H2e3nwi1j+QPFdF4QW+sOpx62H
         xkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758705923; x=1759310723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXhsS4TYQDsQipG2bqEWA0Eq2yU/6y2r8vtgidiAyQw=;
        b=j0FaY7AysltJ2vPaw4qPUVB//hMd+VyjiWxu/2JLmcLOpoX/7azd//k33JzLN4U1lu
         zRprgNwGoQk39DbtAY/J3lTSbVpURiA11BGyEvQpGsHgbOeRdwhX57fFJ573gAy43mg7
         VeJl7PLq3icyCiAs5BR4lSQ3Nox5522KTXEDXt0jzqtqZ00leIVVEve6+p9nOe4/O1Bv
         A2u8NftNS27Ds74oVhWgKEnkMF2bFBn2WR/IICjTABTuhYyfldtkzZil7AZlRafxXxn1
         gekgEawSqpuFipG8oVdQ2hJ5PZpKXa8thf+kxw0ZxS/KdtlIpRjkADSsUpnU1JzuWnaL
         UTpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW/9Xx5tmGbSsiCPWQ3na5aOrRIreOmYcBaXi3xqQeXPEmsMH/pzSHncZzMaLgqz00GDsnhOoiaHBXJoiLlmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRTCzu4QGNebrnSMBFHnRIp5SmUpRBGkhtTructbOd4oiGhYff
	h7/ham1P69P4AM79ku03/sfb58c5wMJTNdrS4k9L0c5/oyNSSa0RUzifvMv3R0P12jIyKEqZ5vZ
	zjSJz80OEKipayCJtYSV7CTBAI3IdbUU=
X-Gm-Gg: ASbGncs2Zn2MVQaVTWiIKdjCbnFOXuiVTBdTEAdcUDuQjcB0X46N+Mko4BAtmzzHqW1
	FTnEl15UJT+/eBAQnMhCat65LWhdnSyQxjsU/Nax1lLhrjh9sozHyis/iGldKCArlU9hwUPDGDT
	NixVxXohQumEnjYtpe+pSCNGu/J0ZgNg1ahw1QCGictscRs9uF9TrdS9Coe798JnWVDGyKNa0Ij
	gj8+Q==
X-Google-Smtp-Source: AGHT+IG5RI+CkthhygK6O+jFB5eU/qgMHmvyydgjwwNBaUBcmyupjXedBsilOUmrjVzf6mx+TypvmUbYWwiicAaFSeU=
X-Received: by 2002:a05:6902:120b:b0:eb3:782c:66b1 with SMTP id
 3f1490d57ef6-eb3782c691emr761557276.21.1758705922959; Wed, 24 Sep 2025
 02:25:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFRLqsUm4M2HTQuO7ORXVE4tScuSTjhjeAVek-7JTBgb9i3wrQ@mail.gmail.com>
In-Reply-To: <CAFRLqsUm4M2HTQuO7ORXVE4tScuSTjhjeAVek-7JTBgb9i3wrQ@mail.gmail.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Wed, 24 Sep 2025 17:25:11 +0800
X-Gm-Features: AS18NWCBKCgMedF-9O18pbVUzamgu5CuffRutkm7TCJjhDTyaUIOmSLWoJWAw5w
Message-ID: <CAFRLqsVNSj=MCNWVsoXA335LAhvz=oELZi8kg+yFnwWW9A3jrg@mail.gmail.com>
Subject: Re: [BUG] Bluetooth: hci_sync: Fix race in hci_cmd_sync_dequeue_once
 causing list corruption GPF
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, johan.hedberg@gmail.com, marcel@holtmann.org
Cc: linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, 
	zhenghaoran154@gmail.com, r33s3n6@gmail.com, linux-bluetooth@vger.kernel.org, 
	"gality369@gmail.com" <gality369@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

Apologies for the previous mail =E2=80=94 the bug report formatting was not=
 correct.

Sorry for the noise and thank you for your understanding.

Best regards,
Cen Zhang

Cen Zhang <zzzccc427@gmail.com> =E4=BA=8E2025=E5=B9=B49=E6=9C=8824=E6=97=A5=
=E5=91=A8=E4=B8=89 17:22=E5=86=99=E9=81=93=EF=BC=9A
>
> hci_cmd_sync_dequeue_once() used to: (1) call
> hci_cmd_sync_lookup_entry() which takes and releases
> cmd_sync_work_lock, returning a raw pointer to the entry (2) later
> call hci_cmd_sync_cancel_entry() (re=E2=80=91taking the lock) and
> list_del()/kfree() the same entry
>
> Between (1) and (2) the cmd_sync worker thread (hci_cmd_sync_work())
> can concurrently:
>
> lock cmd_sync_work_lock
> list_del() and remove the same entry
> unlocked
>
> So the list entry was accessed after it had already been deleted,
> leading to a wild memory access.
> The detailed stack trace is shown below.
>
> Oops: general protection fault, probably for non-canonical address
> 0xff7aaf8000000004: 0000 [#1] SMP KASAN PTI
> KASAN: maybe wild-memory-access in range [0xfbd59c0000000020-0xfbd59c0000=
000027]
> CPU: 0 UID: 0 PID: 323 Comm: kworker/u17:6 Not tainted
> 6.17.0-rc5-ge5bbb70171d1-dirty #21 PREEMPT(voluntary)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> Workqueue: hci11 hci_conn_timeout
> RIP: 0010:__list_del include/linux/list.h:195 [inline]
> RIP: 0010:__list_del_entry include/linux/list.h:218 [inline]
> RIP: 0010:list_del include/linux/list.h:229 [inline]
> RIP: 0010:_hci_cmd_sync_cancel_entry net/bluetooth/hci_sync.c:647 [inline=
]
> RIP: 0010:hci_cmd_sync_cancel_entry net/bluetooth/hci_sync.c:851 [inline]
> RIP: 0010:hci_cmd_sync_dequeue_once+0x660/0x950 net/bluetooth/hci_sync.c:=
870
> Code: c6 fc 48 8b 03 48 89 44 24 28 4c 8d 78 08 4d 89 fe 49 c1 ee 03
> 48 b9 00 00 00 00 00 fc ff df 4d 8d 24 0e 4c 89 e0 48 c1 e8 03 <0f> b6
> 04 08 84 c0 0f 85 4d 02 00 00 45 0f b6 24 24 31 ff 44 89 e6
> RSP: 0018:ffff88811a597b10 EFLAGS: 00010a02
> RAX: 1f7ab38000000004 RBX: ffff88810d76df80 RCX: dffffc0000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: dead000000000122 R08: ffff88811a597aef R09: 1ffff110234b2f5d
> R10: dffffc0000000000 R11: ffffed10234b2f5e R12: fbd59c0000000021
> R13: 1ffffda20435db7e R14: 1bd5a00000000021 R15: dead000000000108
> FS:  0000000000000000(0000) GS:ffff88826d216000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fb9aea860b8 CR3: 0000000102d50000 CR4: 00000000000006f0
> Call Trace:
>  <TASK>
>  hci_cancel_connect_sync+0x1bb/0x2e0
>  hci_abort_conn+0x4b5/0x9a0 net/bluetooth/hci_conn.c:2958
>  hci_conn_timeout+0x3a8/0x540 net/bluetooth/hci_conn.c:579
>  process_one_work kernel/workqueue.c:3236 [inline]
>  process_scheduled_works+0x7a8/0x1030 kernel/workqueue.c:3319
>  worker_thread+0xb97/0x11d0 kernel/workqueue.c:3400
>  kthread+0x3d4/0x800 kernel/kthread.c:463
>  ret_from_fork+0x13b/0x1e0 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>  </TASK>
>
> After our analysis,may be we can fix this by making these two
> operations in hci_cmd_sync_dequeue_once() atomic =E2=80=94 i.e. protectin=
g
> both under the same lock as below:
>
>  bool hci_cmd_sync_dequeue_once(struct hci_dev *hdev,
>                                hci_cmd_sync_work_func_t func,
>                                void *data, hci_cmd_sync_work_destroy_t de=
stroy)
>  {
> -       struct hci_cmd_sync_work_entry *entry;
> -
> -       entry =3D hci_cmd_sync_lookup_entry(hdev, func, data, destroy);
> -       if (!entry)
> -               return false;
> -
> -       hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
> -       return true;
> +       struct hci_cmd_sync_work_entry *entry;
> +
> +       mutex_lock(&hdev->cmd_sync_work_lock);
> +       entry =3D _hci_cmd_sync_lookup_entry(hdev, func, data, destroy);
> +       if (!entry) {
> +               mutex_unlock(&hdev->cmd_sync_work_lock);
> +               return false;
> +       }
> +       _hci_cmd_sync_cancel_entry(hdev, entry, -ECANCELED);
> +       mutex_unlock(&hdev->cmd_sync_work_lock);
> +       return true;
>  }
