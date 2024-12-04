Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EE01BD014
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Dec 2024 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322160; cv=none; b=qqIUHqCnX7Q+MCgkrsaQ5ATniHLNAZ+HplExk81K/Q4Ygq0gjwuM9Dq3SCtzrKa9OlqGQqZI7QjtsutNd+Rmt+BEWWukTPIbbVknekqTsO5zGnh4wgyWifo47gUd4ldm11CNPn2jy8y3e9GZgt0kjraBwvtPxLFYRp2Mciuh05k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322160; c=relaxed/simple;
	bh=6YnLo7bYEx8kui/h1NZZ71HlD2VyOuG57pAF8jGIzoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WCgPGUJ2m92SvRr6M6zAPqsaavLLVtmHwd6lI4hyapDRZ9oWM7BeLuz7hvFYNw3rPHapu15FVEr/s5XEKQfvtk0k3LcEWpRq0ku+j8rLprutiqxChwoat9o8VAlowx3hgq/8cfR+6FQZGAzsvCNwAbkOJbdCUPUdVG7BuAGcHQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbckMzaD; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbckMzaD"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ffa49f623cso86923551fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Dec 2024 06:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733322156; x=1733926956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrejBLru6j9HinA3sfitlH4Y6j29cT8LD9EqR22okiY=;
        b=fbckMzaDQ6549hJ3PwZGRwq9U2ZFwmC6wOLqV67kZCoqnavWt9pw1uYIiWnnAz488E
         37KvaSbB9c8Y224NR5RB5HQiyoRTNuEQs+PQAKTbBmOXhFsybgItnp/xXFOzqrqenqaD
         vW+FDssFTOYAQMm0gqeejXAXK5jL1kR6Oqn0d/O/3oqiHyu9dz5LUXur1C/lBy5sUal+
         UqbwSVCcwR/zFTUrtnsMsMehc4jAdpbL2S5iy4/9YLO/con3Gygpu5FcPLrPcBDph4q1
         p2A1hqidc1raq4b+Mj3x/6JDVPjK+lsS8ZLr80bcpbEwDyCHpBoG5yJaWqkMsVxS4evt
         N/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733322156; x=1733926956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrejBLru6j9HinA3sfitlH4Y6j29cT8LD9EqR22okiY=;
        b=SLTggsUVS6M5UH+qtxkhND4Mp1lNhqG2UW0fvUShoWzgCqhfieYW7cZGHZM9kgR4d8
         eiYtPbPvJCunfz7E1p4tuSS1FjC0jFM2rTTpv4oAioFYd5WOlTULWIUQHteXeq1SEJmt
         lenC47ZdWffpAY4D9rRYYPSwCULrf/Ez8CC/faxs54Z9nr4Ok5Bw7Mgcx/RrTm8wDOyn
         2pUkusxJWxWhpkf5mgBm6roZwmToa+OYauqEhOKR0HcFLtMR6FUeGRdxBfq/BXZhzKBj
         oKNlfo0Ny/SB6nDpnRBCDtnCX0P3Cp7UBGmNlLY/4vzPrbevMdvnUrIT3TeVAvkUAo0U
         /68A==
X-Gm-Message-State: AOJu0YxRsYX+Ik9mXvQJ0PprO59JUv7ws+33kopGlPooKfB0p8Cggn8z
	YX/Paj30NVHJtbN8UBywAWUbX/V4PVZ9hZfmyLtdoLY6h7k9QqwToXhksLxlvITqAYUW005MnKv
	mT8J/oYUhoXXegH8q6Kjs1XpfBrlXYEvG
X-Gm-Gg: ASbGnctiqM1bxwnx7+3EcerWp1ZkhbRn+3Px1JVEVyEIHkETPwuZOnOHWIWrNcTscRD
	6ccrlcvIk2p/dsnIKxNEIK0htOZLrv+Qa
X-Google-Smtp-Source: AGHT+IFWLXD2CZZeNpAJXB3gCUMtZLS6bWih0stiNwGA0BclYGfetuibZvl1EDe1gWcWbtM2pME9bhGE2YW3ZuZaIXg=
X-Received: by 2002:a2e:80c7:0:b0:300:1889:633a with SMTP id
 38308e7fff4ca-300188965ffmr10165391fa.4.1733322156013; Wed, 04 Dec 2024
 06:22:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204122849.9000-1-iulia.tanasescu@nxp.com> <20241204122849.9000-2-iulia.tanasescu@nxp.com>
In-Reply-To: <20241204122849.9000-2-iulia.tanasescu@nxp.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 4 Dec 2024 09:22:23 -0500
Message-ID: <CABBYNZJgWphnGVLyoU4sZBT3WB2d=tB_J+E_GvRZR++S=CMBkA@mail.gmail.com>
Subject: Re: [PATCH 1/3] Bluetooth: iso: Fix circular locking dependency warnings
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com, 
	mihai-octavian.urzica@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Iulia,

On Wed, Dec 4, 2024 at 7:29=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nxp=
.com> wrote:
>
> This fixes circular locking dependency warnings, by ensuring
> the hci_dev_lock -> lock_sk order for all ISO functions.
>
> Below is an example of a warning generated because of locking
> dependencies:
>
> [   75.307983] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   75.307984] WARNING: possible circular locking dependency detected
> [   75.307985] 6.12.0-rc6+ #22 Not tainted
> [   75.307987] ------------------------------------------------------
> [   75.307987] kworker/u81:2/2623 is trying to acquire lock:
> [   75.307988] ffff8fde1769da58 (sk_lock-AF_BLUETOOTH-BTPROTO_ISO)
>                at: iso_connect_cfm+0x253/0x840 [bluetooth]
> [   75.308021]
>                but task is already holding lock:
> [   75.308022] ffff8fdd61a10078 (&hdev->lock)
>                at: hci_le_per_adv_report_evt+0x47/0x2f0 [bluetooth]
> [   75.308053]
>                which lock already depends on the new lock.
>
> [   75.308054]
>                the existing dependency chain (in reverse order) is:
> [   75.308055]
>                -> #1 (&hdev->lock){+.+.}-{3:3}:
> [   75.308057]        __mutex_lock+0xad/0xc50
> [   75.308061]        mutex_lock_nested+0x1b/0x30
> [   75.308063]        iso_sock_listen+0x143/0x5c0 [bluetooth]
> [   75.308085]        __sys_listen_socket+0x49/0x60
> [   75.308088]        __x64_sys_listen+0x4c/0x90
> [   75.308090]        x64_sys_call+0x2517/0x25f0
> [   75.308092]        do_syscall_64+0x87/0x150
> [   75.308095]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   75.308098]
>                -> #0 (sk_lock-AF_BLUETOOTH-BTPROTO_ISO){+.+.}-{0:0}:
> [   75.308100]        __lock_acquire+0x155e/0x25f0
> [   75.308103]        lock_acquire+0xc9/0x300
> [   75.308105]        lock_sock_nested+0x32/0x90
> [   75.308107]        iso_connect_cfm+0x253/0x840 [bluetooth]
> [   75.308128]        hci_connect_cfm+0x6c/0x190 [bluetooth]
> [   75.308155]        hci_le_per_adv_report_evt+0x27b/0x2f0 [bluetooth]
> [   75.308180]        hci_le_meta_evt+0xe7/0x200 [bluetooth]
> [   75.308206]        hci_event_packet+0x21f/0x5c0 [bluetooth]
> [   75.308230]        hci_rx_work+0x3ae/0xb10 [bluetooth]
> [   75.308254]        process_one_work+0x212/0x740
> [   75.308256]        worker_thread+0x1bd/0x3a0
> [   75.308258]        kthread+0xe4/0x120
> [   75.308259]        ret_from_fork+0x44/0x70
> [   75.308261]        ret_from_fork_asm+0x1a/0x30
> [   75.308263]
>                other info that might help us debug this:
>
> [   75.308264]  Possible unsafe locking scenario:
>
> [   75.308264]        CPU0                CPU1
> [   75.308265]        ----                ----
> [   75.308265]   lock(&hdev->lock);
> [   75.308267]                            lock(sk_lock-
>                                                 AF_BLUETOOTH-BTPROTO_ISO)=
;
> [   75.308268]                            lock(&hdev->lock);
> [   75.308269]   lock(sk_lock-AF_BLUETOOTH-BTPROTO_ISO);
> [   75.308270]
>                 *** DEADLOCK ***
>
> [   75.308271] 4 locks held by kworker/u81:2/2623:
> [   75.308272]  #0: ffff8fdd66e52148 ((wq_completion)hci0#2){+.+.}-{0:0},
>                 at: process_one_work+0x443/0x740
> [   75.308276]  #1: ffffafb488b7fe48 ((work_completion)(&hdev->rx_work)),
>                 at: process_one_work+0x1ce/0x740
> [   75.308280]  #2: ffff8fdd61a10078 (&hdev->lock){+.+.}-{3:3}
>                 at: hci_le_per_adv_report_evt+0x47/0x2f0 [bluetooth]
> [   75.308304]  #3: ffffffffb6ba4900 (rcu_read_lock){....}-{1:2},
>                 at: hci_connect_cfm+0x29/0x190 [bluetooth]
>
> Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> ---
>  net/bluetooth/iso.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 8ed818254dc8..cb004b678d65 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -1102,6 +1102,7 @@ static int iso_sock_connect(struct socket *sock, st=
ruct sockaddr *addr,
>         return err;
>  }
>
> +/* This function requires the caller to hold sk lock */
>  static int iso_listen_bis(struct sock *sk)
>  {
>         struct hci_dev *hdev;
> @@ -1128,7 +1129,15 @@ static int iso_listen_bis(struct sock *sk)
>         if (!hdev)
>                 return -EHOSTUNREACH;
>
> +       /* Prevent sk from being freed whilst unlocked */
> +       sock_hold(sk);
> +
> +       /* To avoid circular locking dependencies,
> +        * hdev should be locked first before sk.
> +        */
> +       release_sock(sk);
>         hci_dev_lock(hdev);
> +       lock_sock(sk);
>
>         /* Fail if user set invalid QoS */
>         if (iso_pi(sk)->qos_user_set && !check_bcast_qos(&iso_pi(sk)->qos=
)) {
> @@ -1161,7 +1170,13 @@ static int iso_listen_bis(struct sock *sk)
>         hci_dev_put(hdev);
>
>  unlock:
> +       /* Unlock order should be in reverse from lock order. */
> +       release_sock(sk);
>         hci_dev_unlock(hdev);
> +       lock_sock(sk);
> +
> +       sock_put(sk);
> +
>         return err;
>  }
>
> @@ -1417,6 +1432,7 @@ static void iso_conn_defer_accept(struct hci_conn *=
conn)
>         hci_send_cmd(hdev, HCI_OP_LE_ACCEPT_CIS, sizeof(cp), &cp);
>  }
>
> +/* This function requires the caller to hold sk lock */
>  static void iso_conn_big_sync(struct sock *sk)
>  {
>         int err;
> @@ -1428,6 +1444,14 @@ static void iso_conn_big_sync(struct sock *sk)
>         if (!hdev)
>                 return;
>
> +       /* Prevent sk from being freed whilst unlocked */
> +       sock_hold(sk);
> +
> +       /* To avoid circular locking dependencies, hdev should be
> +        * locked first before sk.
> +        */
> +       release_sock(sk);
> +
>         /* hci_le_big_create_sync requires hdev lock to be held, since
>          * it enqueues the HCI LE BIG Create Sync command via
>          * hci_cmd_sync_queue_once, which checks hdev flags that might
> @@ -1435,6 +1459,8 @@ static void iso_conn_big_sync(struct sock *sk)
>          */
>         hci_dev_lock(hdev);
>
> +       lock_sock(sk);
> +
>         if (!test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
>                 err =3D hci_le_big_create_sync(hdev, iso_pi(sk)->conn->hc=
on,
>                                              &iso_pi(sk)->qos,
> @@ -1446,7 +1472,12 @@ static void iso_conn_big_sync(struct sock *sk)
>                                    err);
>         }
>
> +       /* Unlock order should be in reverse from lock order. */
> +       release_sock(sk);
>         hci_dev_unlock(hdev);
> +       lock_sock(sk);
> +
> +       sock_put(sk);
>  }
>
>  static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
> --
> 2.40.1

We should probably avoid having to do hci_dev_lock while holding
lock_sock to begin with, like we are doing in iso_sock_connect which
calls iso_connect_bis without holding any locks so we don't have
multiple unlock/lock sequences.

--=20
Luiz Augusto von Dentz
