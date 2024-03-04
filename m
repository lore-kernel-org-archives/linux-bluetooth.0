Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8A948CC7
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Mar 2024 19:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709578857; cv=none; b=cvXq0em610fGdbhhNcyqQairUk52zTpn1mPfIhMOGa7YgnDB7XtO1UV5KTPsAXN+dxnPjFFaMlQdWEFL53KTVNJQu7dWpiQdom3Mqw4P+BbB1A/hIQBgoRuiacDjx1RKO8b34+JmsaEx1LLAqXDyQJNrhM4hYlQFNm/amJ+JN+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709578857; c=relaxed/simple;
	bh=MhXZ6JQSW2iT4Cgcsphq77J+k4PL9YKvEWUtyirtzMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RdVcDyDmZKighBZ10K+xT4WNZjPr3HrhzAzqjx+J1EMkLR1U9F7/90iltIW8xAHJWUvAUiEBkwtUU0y11q3Xv9/Jyyrxnit2OVFDA8UfSz/LQOS2P8iFpUqzJBm0bcsiTV77nC0IpCUSkAMqKEWpk79RBJOP+VDZnz9RU6Zkl18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ODuq9/nf; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ODuq9/nf"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d2628e81b8so56307981fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Mar 2024 11:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709578854; x=1710183654; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7rglJnrqbc4yHiJ9QUwbTI3qgOYr1MCf77cTTv1Mcg=;
        b=ODuq9/nfLNUUYh1w6I+ZCXP+hGkN1K85vlINcuIiW2IqUd35HkLFrtTAO8zcbjEv3E
         2Rs7fV7VxPLpmab07hzl9ESK8nCgNmUY2awhptCH1vvZ8pbmkz6D7QNkbn9gqpA3Rx4W
         NWy2jobFokLoa7Zsn8tQ1eiP6EYrv4P0ZYZvvMlRQKx7gJdnhYZ/yyxG8V7Z6B7PoBB8
         KH9gMPUY+7fJbNV/MMG/aXZdMtWsstKDBF5cXnncsEjeTWQdLaAeuya7dd9USeq+WuKp
         BFJCptc8C3SC5AahSVGakaT19cOPgrEJwfhH0AvUFytmKjZ+kDbOL6gcPxSuNk5vB04g
         AY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709578854; x=1710183654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7rglJnrqbc4yHiJ9QUwbTI3qgOYr1MCf77cTTv1Mcg=;
        b=hd1Y0Dlw+E8I1VGJyYw6qYKaoD0SXX2XcRvalqmNVM/tMl2SelO7M5if1O58nbos6h
         149cXK6hBTD8T9inh6lPmc2BJj5QC6WclkIxWkDJ8prSuzQxCrrE2r1nKE7Y5e/v3PYO
         Wvke6ALXONxfpxZ7ax2sgRdiwuNv3Lgdz8CPkXTAcTEMDQ/3stRIOxxIxVH+d0C7fy9f
         ILkg7dCaN+Ki+X/NlR54gRoEdapuYSrJ+stP90sYV3Pvt+HcYk9/jUWVlvUrHtGIxahm
         hnYef9uqBrGp31CtxjgRVbk7McP1tu/H6tsv1kRomDYX6jrvnXO7gASFJNBmJMTusVUG
         c5JA==
X-Gm-Message-State: AOJu0YxpE2wGUqxU/g7WyigaUFA4XgZHw4/fVXVNGdbDYXvC0k4/f2at
	RrL/7jH6NEi3mIypvwilt4ByfOEwaK4NzgFngj+I8HAHs1juFiD81h83o0gPfDTSW5HwmU4y6VO
	jkbAyfsLpyl8xWbhRT0w9DERQRaGI8aX2
X-Google-Smtp-Source: AGHT+IGzeTGxEN1cwAGo3Y1iQu86pEZrSwUHgg3O1biFDyOArrzQ4kUhjlCQKhAD01yaNQeevK1RqxsIviQlIF1XX/o=
X-Received: by 2002:a2e:a1c7:0:b0:2d2:2c74:ff02 with SMTP id
 c7-20020a2ea1c7000000b002d22c74ff02mr119033ljm.9.1709578853631; Mon, 04 Mar
 2024 11:00:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304165050.3430-1-iulia.tanasescu@nxp.com> <20240304165050.3430-2-iulia.tanasescu@nxp.com>
In-Reply-To: <20240304165050.3430-2-iulia.tanasescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 4 Mar 2024 14:00:41 -0500
Message-ID: <CABBYNZJT=TM1-nrSn6GE-3wx5SKxiKBvddJTVVbkSG2UT__FWQ@mail.gmail.com>
Subject: Re: [1/2] Bluetooth: ISO: Fix circular locking dependency warning
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com, 
	mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com, 
	vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Iulia,

On Mon, Mar 4, 2024 at 11:51=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nx=
p.com> wrote:
>
> This fixes the circular locking dependency warning caused
> by iso_listen_bis acquiring the hdev lock while the socket
> has been locked in the caller function.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 6.8.0-rc5+ #1 Not tainted
> ------------------------------------------------------
> iso-tester/2950 is trying to acquire lock:
> ffff88817a048080 (&hdev->lock){+.+.}-{3:3}, at: iso_sock_listen+0x305/0x8=
d0
>
>                but task is already holding lock:
> ffff888197c39278 (sk_lock-AF_BLUETOOTH-BTPROTO_ISO){+.+.}-{0:0},
>                at: iso_sock_listen+0x91/0x8d0
>
>                which lock already depends on the new lock.
>
>                the existing dependency chain (in reverse order) is:
>
>  -> #1 (sk_lock-AF_BLUETOOTH-BTPROTO_ISO){+.+.}-{0:0}:
>         lock_sock_nested+0x3b/0xb0
>         iso_connect_cis+0x185/0x540
>         iso_sock_connect+0x445/0x7e0
>         __sys_connect_file+0xd5/0x100
>         __sys_connect+0x11e/0x150
>         __x64_sys_connect+0x42/0x60
>         do_syscall_64+0x8d/0x150
>         entry_SYSCALL_64_after_hwframe+0x6e/0x76
>
> -> #0 (&hdev->lock){+.+.}-{3:3}:
>         __lock_acquire+0x208f/0x3720
>         lock_acquire+0x16d/0x3f0
>         __mutex_lock+0x155/0x1310
>         mutex_lock_nested+0x1b/0x30
>         iso_sock_listen+0x305/0x8d0
>         __sys_listen+0x106/0x190
>         __x64_sys_listen+0x30/0x40
>         do_syscall_64+0x8d/0x150
>         entry_SYSCALL_64_after_hwframe+0x6e/0x76
>
>         other info that might help us debug this:
>
> Possible unsafe locking scenario:
>
>         CPU0                    CPU1
>         ----                    ----
>    lock(sk_lock-AF_BLUETOOTH-BTPROTO_ISO);
>                                 lock(&hdev->lock);
>                                 lock(sk_lock-AF_BLUETOOTH-BTPROTO_ISO);
>    lock(&hdev->lock);
>
>                 *** DEADLOCK ***
>
> 1 lock held by iso-tester/2950:
> 0: ffff888197c39278 (sk_lock-AF_BLUETOOTH-BTPROTO_ISO){+.+.}-{0:0},
>                 at: iso_sock_listen+0x91/0x8d0
>
> Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> ---
>  net/bluetooth/iso.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 30c777c469f9..163b07db575d 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -1069,6 +1069,7 @@ static int iso_sock_connect(struct socket *sock, st=
ruct sockaddr *addr,
>         return err;
>  }
>
> +/* This function requires the caller to hold sk lock */
>  static int iso_listen_bis(struct sock *sk)
>  {
>         struct hci_dev *hdev;
> @@ -1095,7 +1096,12 @@ static int iso_listen_bis(struct sock *sk)
>         if (!hdev)
>                 return -EHOSTUNREACH;
>
> +       /* To avoid circular locking dependencies,
> +        * hdev should be locked first before sk.
> +        */
> +       release_sock(sk);

Don't really like the idea of having to release the lock here since
that in the meantime can cause it to destroy the socket while waiting
for hci_dev_lock so perhaps we need to look into mutex_lock_nested.

>         hci_dev_lock(hdev);
> +       lock_sock(sk);
>
>         /* Fail if user set invalid QoS */
>         if (iso_pi(sk)->qos_user_set && !check_bcast_qos(&iso_pi(sk)->qos=
)) {
> @@ -1128,7 +1134,10 @@ static int iso_listen_bis(struct sock *sk)
>         hci_dev_put(hdev);
>
>  unlock:
> +       /* Unlock order should be in reverse from lock order. */
> +       release_sock(sk);
>         hci_dev_unlock(hdev);
> +       lock_sock(sk);
>         return err;
>  }
>
> --
> 2.39.2
>


--=20
Luiz Augusto von Dentz
