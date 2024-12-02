Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F6C1DDC19
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Dec 2024 22:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733176851; cv=none; b=N/eQVoo5VQPu3LYbHDOAtRcEUNDdy5++cxdZWpOu3A3lHCBphTKflG2HI5sSPYJw0HumpxsnxTPGyd/FBLXbQw5wUWG/f5E2V/X4MO+bv19/fGieUFiy9jAE5koel7+PB75VS5TUM3IAyaF9WYbaTyyMB4BiT4RGVGwZJ9EfYbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733176851; c=relaxed/simple;
	bh=kIyrvWXBoa06S1CxJnug8IjhKIaUJ+sDgm/33EDXbpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gPfQg9oZnQ1Hhw7G8ObgxYj0hYD1d5Ya/KKhHBlMcfSjeT7Xyc0TZhg+vzqFLZb1zJuP1YjN5ZGAP2tfCwMvV6BqtPvtXBZvrpmsEDh+B1aN4v1peVJTok6yupjwzJrGitMmWiRZcyd4nNu92w8XT2W+tdO/9HOZSKh6L76A0vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9gtQsEc; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9gtQsEc"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ffc1f72a5bso49072981fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Dec 2024 14:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733176848; x=1733781648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0c0QisB1QAuHU4zZWHbuhTLNgOaeXFYlQqCCzAs9B0=;
        b=h9gtQsEc7Ni9jLJVY9deQONqDGETUw7B98ze0vA81IuU26w3oqEKnjiKxZxUMbJZBX
         eKQuXZr6xmVPLmCD/xm3geMUlpmu8vTCqOhuIlH+vtXbtD1LxQrIs40LU+VToBAVPY50
         2uQEpwFig8OO7VHr1xB0QqJbbnc0ZwfEimyglqNbaHQJ3AgPLMSj7YU8EUWxc7d3vEGc
         1iK8J0pHHsR1dpYQF+B+axVGpb+2aN0VOJDU0FxaZ+kJ2lq1C0l+VDqvuzamVZ3R3GGC
         VAh5T4C80ApCOXoNk2y0xI167CvxzcN0RWd1aHfuBiFmNH2sXughvOhMJ5DJPRLAb159
         p3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733176848; x=1733781648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0c0QisB1QAuHU4zZWHbuhTLNgOaeXFYlQqCCzAs9B0=;
        b=j+jmjRF5+I8ERw/IYc3qZrqmNO6HNA4Sf/zFQzZBFdlf+IowGGoARcnMZxpVCcddVP
         QbEjk2oah5hCbrD21jy0EbX9tNs8fpk5xLN3MIhDflF6lkq8unLdaGMItle3KagCjWE1
         w16kx4HHZreiuXxdsBxDb4qmOkuAacgYavpf10tngxZgIXfi7MZvhCW2xiaLIhSWwf9u
         ESKjceQi8XPhAqWbTgl0pJgUTrqEU3yA/alsQ/TGHHL/1Nm6z3rzT/tU+dtw/VozOKyl
         9JuDqF+rFK/H0qBdvulFQx6JigcCUsmerBz7n4lS4S2t7+AcBqaCZxM0LB7xOa7ImAbK
         XwNw==
X-Gm-Message-State: AOJu0YyRVFh3b07FZhSd0S4o5b00MVWpAQf0EHOLggLDSb80KU0dSydZ
	NdOxjGh362K1raLGSZwvR2Dpl84T8gdo/cLDCeYdrxCxDMSGxRyM7/Axeh0dibR1Q/FhnKAW4/O
	o2moX80zdGwq4v2bUAb7f2F1vL3I=
X-Gm-Gg: ASbGncsf8HAtez9N1wbBdqfWttmG66exN5L6RMymqfwhZ/NM0UhO0QFGDqQfLT0czT4
	SplUM8LXjti70tZRrqebxdsm8nVdWt6WX
X-Google-Smtp-Source: AGHT+IEbaZyydGJLIY1XWisHxym8i1Z8JjXMubClppfdS9KGtRf2zk5IcV9r8hRlHK4I89IfiPHr5WTHR6vGOIqlLgM=
X-Received: by 2002:a2e:a917:0:b0:2ff:7d2e:f49f with SMTP id
 38308e7fff4ca-2ffde2254c4mr68150801fa.17.1733176847702; Mon, 02 Dec 2024
 14:00:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128155405.14910-1-iulia.tanasescu@nxp.com> <20241128155405.14910-2-iulia.tanasescu@nxp.com>
In-Reply-To: <20241128155405.14910-2-iulia.tanasescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 2 Dec 2024 17:00:35 -0500
Message-ID: <CABBYNZLHBdW7oF-kGWF2-eiz4f39xU8=LHjVt04DTnyTD3GCyQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Bluetooth: iso: Allow BIG re-sync
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com, 
	mihai-octavian.urzica@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Iulia,

On Thu, Nov 28, 2024 at 10:54=E2=80=AFAM Iulia Tanasescu
<iulia.tanasescu@nxp.com> wrote:
>
> A Broadcast Sink might require BIG sync to be terminated and
> re-established multiple times, while keeping the same PA sync
> handle active. This can be possible if the configuration of the
> listening (PA sync) socket is reset once all bound BISes are
> established and accepted by the user space:
>
> 1. The DEFER setup flag needs to be reset on the parent socket,
> to allow another BIG create sync procedure to be started on socket
> read.
>
> 2. The BT_SK_BIG_SYNC flag needs to be cleared on the parent socket,
> to allow another BIG create sync command to be sent.
>
> 3. The socket state needs to transition from BT_LISTEN to BT_CONNECTED,
> to mark that the listening process has completed and another one can
> be started if needed.
>
> Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> ---
>  net/bluetooth/iso.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 1b40fd2b2f02..013edb19c4a1 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -1268,6 +1268,42 @@ static int iso_sock_accept(struct socket *sock, st=
ruct socket *newsock,
>
>         BT_DBG("new socket %p", ch);
>
> +       /* A Broadcast Sink might require BIG sync to be terminated
> +        * and re-established multiple times, while keeping the same
> +        * PA sync handle active. To allow this, once all BIS
> +        * connections have been accepted on a PA sync parent socket,
> +        * "reset" socket state, to allow future BIG re-sync procedures.
> +        */
> +       if (test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags)) {
> +               /* Iterate through the list of bound BIS indices
> +                * and clear each BIS as they are accepted by the
> +                * user space, one by one.
> +                */
> +               for (int i =3D 0; i < iso_pi(sk)->bc_num_bis; i++) {
> +                       if (iso_pi(sk)->bc_bis[i] > 0) {
> +                               iso_pi(sk)->bc_bis[i] =3D 0;
> +                               iso_pi(sk)->bc_num_bis--;
> +                               break;
> +                       }
> +               }
> +
> +               if (iso_pi(sk)->bc_num_bis =3D=3D 0) {
> +                       /* Once the last BIS was accepted, reset parent
> +                        * socket parameters to mark that the listening
> +                        * process for BIS connections has been completed=
:
> +                        *
> +                        * 1. Reset the DEFER setup flag on the parent sk=
.
> +                        * 2. Clear the flag marking that the BIG create
> +                        *    sync command is pending.
> +                        * 3. Transition socket state from BT_LISTEN to
> +                        *    BT_CONNECTED.
> +                        */
> +                       set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
> +                       clear_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags);
> +                       sk->sk_state =3D BT_CONNECTED;
> +               }
> +       }
> +
>  done:
>         release_sock(sk);
>         return err;
> --
> 2.43.0

While testing this Ive run into the following problem:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: possible circular locking dependency detected
6.12.0-rc6-g47ebf099106e #7428 Not tainted
------------------------------------------------------
kworker/u5:2/38 is trying to acquire lock:
ffff88800224a248 (sk_lock-AF_BLUETOOTH-BTPROTO_ISO){+.+.}-{0:0}, at:
iso_connect_cfm+0x563/0x13e0

but task is already holding lock:
ffffffffb0438668 (hci_cb_list_lock){+.+.}-{4:4}, at:
hci_le_per_adv_report_evt+0x494/0x6d0

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (hci_cb_list_lock){+.+.}-{4:4}:
       lock_acquire+0x1b6/0x510
       __mutex_lock+0x180/0x1a60
       hci_le_per_adv_report_evt+0x494/0x6d0
       hci_event_packet+0x54a/0xec0
       hci_rx_work+0x76c/0x11c0
       process_one_work+0x7d9/0x13d0
       worker_thread+0x5b7/0xf90
       kthread+0x293/0x360
       ret_from_fork+0x2f/0x70
       ret_from_fork_asm+0x1a/0x30

-> #1 (&hdev->lock){+.+.}-{4:4}:
       lock_acquire+0x1b6/0x510
       __mutex_lock+0x180/0x1a60
       iso_sock_listen+0x2d4/0xe00
       __sys_listen+0x163/0x240
       __x64_sys_listen+0x4e/0x70
       do_syscall_64+0x71/0x140
       entry_SYSCALL_64_after_hwframe+0x76/0x7e

-> #0 (sk_lock-AF_BLUETOOTH-BTPROTO_ISO){+.+.}-{0:0}:
       check_prev_add+0x1b5/0x23f0
       __lock_acquire+0x2bdf/0x4580
       lock_acquire+0x1b6/0x510
       lock_sock_nested+0x36/0xd0
       iso_connect_cfm+0x563/0x13e0
       hci_le_per_adv_report_evt+0x4f8/0x6d0
       hci_event_packet+0x54a/0xec0
       hci_rx_work+0x76c/0x11c0
       process_one_work+0x7d9/0x13d0
       worker_thread+0x5b7/0xf90
       kthread+0x293/0x360
       ret_from_fork+0x2f/0x70
       ret_from_fork_asm+0x1a/0x30

other info that might help us debug this:

Chain exists of:
  sk_lock-AF_BLUETOOTH-BTPROTO_ISO --> &hdev->lock --> hci_cb_list_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(hci_cb_list_lock);
                               lock(&hdev->lock);
                               lock(hci_cb_list_lock);
  lock(sk_lock-AF_BLUETOOTH-BTPROTO_ISO);

 *** DEADLOCK ***

4 locks held by kworker/u5:2/38:
 #0: ffff888002213948 ((wq_completion)hci0#2){+.+.}-{0:0}, at:
process_one_work+0xce8/0x13d0
 #1: ffff8880024a7da0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0},
at: process_one_work+0x758/0x13d0
 #2: ffff888002300078 (&hdev->lock){+.+.}-{4:4}, at:
hci_le_per_adv_report_evt+0x152/0x6d0
 #3: ffffffffb0438668 (hci_cb_list_lock){+.+.}-{4:4}, at:
hci_le_per_adv_report_evt+0x494/0x6d0

While this doesn't seem to be new I think it is a good idea to try and
solve it so we don't run into deadlocks.

--=20
Luiz Augusto von Dentz
