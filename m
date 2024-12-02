Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588FB1DF746
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Dec 2024 22:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733178555; cv=none; b=a12LDh9OoCQkYVNS9YxUQILCxE0juCmwpWfRyFfT1z16y2coEn3PuRA6sX6Mf8+IOhRshly37aow+T7sPfnf/055KKcQ87ubVuHnVK9o931ELUZHq9APHpPpoTcWmQa3+z8LUlkOYGjDabbv87NzQSoH+vmQYfrc5PbpjQs1pU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733178555; c=relaxed/simple;
	bh=cme9VtyK4Uyo9tedURoOzx4+XKJz6VOCP25yJFtPfXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mthvwIw9+evUIz8oW8lXSsRgX0eVxBivpalTgw4y6aaGGCThIQyQT44lLFRLm42frUPtG9WhXiJyVGQ0Hy15QiGMwztcCcIlvpcQX5dSoSBCj2cq2W4+5v19+PBoKkNCgD6nxaDTGW3V0blsmtXt4WOrGgWPGmYH9Va8DDn2sNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5WvMPau; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5WvMPau"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fff2ca7425so20318531fa.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Dec 2024 14:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733178551; x=1733783351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9+3+X0X1Kh4ocR5T5zYw5MwrFCB8GloTBUqPq6EP3g=;
        b=E5WvMPauxJfNQFDnVKhWWH5A0Oj6IDDh1vgH4YolQ8f9LII3HDW70zhRxZN+p00Vzb
         BZ3Nh3ughbzzJE2f8CB0RSIxvN8GHK7QDhqsPf3aTrmX8tQBdRxVGAAbF4Sv9DNNv20L
         UPmQgWZJaU9QMBThzyXb5FCCAof73zv9J/zrMRmBddq9N0tG7bTanhUS1bc4dV+Xixf7
         xDrIkPLhoPoy7HzMaahKjRkK344RfFGwqqvl4DmqPC6VYrBJyiaG7uE70VvNlBewRAC/
         J7xGwyUkM7OdZF3EKrAhi7vwHeuookO3lEZz9UJCstdgdGSIVEOySTWvHGbslqwZ81/S
         2Rjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733178551; x=1733783351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9+3+X0X1Kh4ocR5T5zYw5MwrFCB8GloTBUqPq6EP3g=;
        b=ugTn6vWCsA3CaIJdySyCGUo3KYpCKNUARoVnKs0rHor4FzYuAdt9nM01kS2j8UmELY
         0FK/GjODzVndr+DUmJ+pqFxe8tg0PI9t0ekH2bGWRbew7UJ1yDVpkLfBd6YXsXAoLsnH
         TJaiQG9O+nNKsbz9wDOPBGUrfCH8hPunUEeDgcPTrPgRk84xZmyC1wx/mAEni1X6Dm4o
         mqLvr8F+Rx3NSmhEQw7lABJIg/iRTyNaQ5yn/OTi0Wbr2WYspSRDZnJUBGQom71whE6Y
         LAR4A4r/5fMLGBGcNF2eHVLAY4HFXLCgiY/FuFkbVAtpFFSyV24/HOozDWB4iCg2u++K
         tKRQ==
X-Gm-Message-State: AOJu0YxAgvDeAQgSrMvOV/5ZvbVcYw1VOzk3rsj07jlTo9FpZNdcw+Dd
	vxEINU1Khe5iJllkQwfaJ/QQEEVUfjC1To+LY/EdRRU1mYhilytXP//IY+xA+93+LhUsL0+y3ch
	3oMWiT44Rb1Elkxj9aLRd+6Id02VR8pq2
X-Gm-Gg: ASbGncvNbS+2x+VyvTuWrQQ9Gr6qXY079hTgoV1Bw7fisqfCgXmVCKM6ZZVQ/9YVK0p
	xoifWiY4kjh0pTjXoUDNK3kPS66RekN1e
X-Google-Smtp-Source: AGHT+IGoFqYQWlYVMBVJkg/g35staU3r6yACFROm44onuT+nj+3PLNf34rLak2B72seSt2spBh7xTSsIxSPMosQ/Qyk=
X-Received: by 2002:a05:651c:547:b0:2ff:5645:1265 with SMTP id
 38308e7fff4ca-30009d3fec6mr1365271fa.41.1733178551335; Mon, 02 Dec 2024
 14:29:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128155405.14910-1-iulia.tanasescu@nxp.com>
 <20241128155405.14910-2-iulia.tanasescu@nxp.com> <CABBYNZLHBdW7oF-kGWF2-eiz4f39xU8=LHjVt04DTnyTD3GCyQ@mail.gmail.com>
In-Reply-To: <CABBYNZLHBdW7oF-kGWF2-eiz4f39xU8=LHjVt04DTnyTD3GCyQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 2 Dec 2024 17:28:59 -0500
Message-ID: <CABBYNZKiZZQ4vpc-w1b67hyRe+k0GE5OoA_wBERC=_zoo9hxTw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Bluetooth: iso: Allow BIG re-sync
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com, 
	mihai-octavian.urzica@nxp.com, andrei.istodorescu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Iulia,

On Mon, Dec 2, 2024 at 5:00=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Iulia,
>
> On Thu, Nov 28, 2024 at 10:54=E2=80=AFAM Iulia Tanasescu
> <iulia.tanasescu@nxp.com> wrote:
> >
> > A Broadcast Sink might require BIG sync to be terminated and
> > re-established multiple times, while keeping the same PA sync
> > handle active. This can be possible if the configuration of the
> > listening (PA sync) socket is reset once all bound BISes are
> > established and accepted by the user space:
> >
> > 1. The DEFER setup flag needs to be reset on the parent socket,
> > to allow another BIG create sync procedure to be started on socket
> > read.
> >
> > 2. The BT_SK_BIG_SYNC flag needs to be cleared on the parent socket,
> > to allow another BIG create sync command to be sent.
> >
> > 3. The socket state needs to transition from BT_LISTEN to BT_CONNECTED,
> > to mark that the listening process has completed and another one can
> > be started if needed.
> >
> > Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> > ---
> >  net/bluetooth/iso.c | 36 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >
> > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> > index 1b40fd2b2f02..013edb19c4a1 100644
> > --- a/net/bluetooth/iso.c
> > +++ b/net/bluetooth/iso.c
> > @@ -1268,6 +1268,42 @@ static int iso_sock_accept(struct socket *sock, =
struct socket *newsock,
> >
> >         BT_DBG("new socket %p", ch);
> >
> > +       /* A Broadcast Sink might require BIG sync to be terminated
> > +        * and re-established multiple times, while keeping the same
> > +        * PA sync handle active. To allow this, once all BIS
> > +        * connections have been accepted on a PA sync parent socket,
> > +        * "reset" socket state, to allow future BIG re-sync procedures=
.
> > +        */
> > +       if (test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags)) {
> > +               /* Iterate through the list of bound BIS indices
> > +                * and clear each BIS as they are accepted by the
> > +                * user space, one by one.
> > +                */
> > +               for (int i =3D 0; i < iso_pi(sk)->bc_num_bis; i++) {
> > +                       if (iso_pi(sk)->bc_bis[i] > 0) {
> > +                               iso_pi(sk)->bc_bis[i] =3D 0;
> > +                               iso_pi(sk)->bc_num_bis--;
> > +                               break;
> > +                       }
> > +               }
> > +
> > +               if (iso_pi(sk)->bc_num_bis =3D=3D 0) {
> > +                       /* Once the last BIS was accepted, reset parent
> > +                        * socket parameters to mark that the listening
> > +                        * process for BIS connections has been complet=
ed:
> > +                        *
> > +                        * 1. Reset the DEFER setup flag on the parent =
sk.
> > +                        * 2. Clear the flag marking that the BIG creat=
e
> > +                        *    sync command is pending.
> > +                        * 3. Transition socket state from BT_LISTEN to
> > +                        *    BT_CONNECTED.
> > +                        */
> > +                       set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
> > +                       clear_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags);
> > +                       sk->sk_state =3D BT_CONNECTED;
> > +               }
> > +       }
> > +
> >  done:
> >         release_sock(sk);
> >         return err;
> > --
> > 2.43.0
>
> While testing this Ive run into the following problem:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 6.12.0-rc6-g47ebf099106e #7428 Not tainted
> ------------------------------------------------------
> kworker/u5:2/38 is trying to acquire lock:
> ffff88800224a248 (sk_lock-AF_BLUETOOTH-BTPROTO_ISO){+.+.}-{0:0}, at:
> iso_connect_cfm+0x563/0x13e0
>
> but task is already holding lock:
> ffffffffb0438668 (hci_cb_list_lock){+.+.}-{4:4}, at:
> hci_le_per_adv_report_evt+0x494/0x6d0
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #2 (hci_cb_list_lock){+.+.}-{4:4}:
>        lock_acquire+0x1b6/0x510
>        __mutex_lock+0x180/0x1a60
>        hci_le_per_adv_report_evt+0x494/0x6d0
>        hci_event_packet+0x54a/0xec0
>        hci_rx_work+0x76c/0x11c0
>        process_one_work+0x7d9/0x13d0
>        worker_thread+0x5b7/0xf90
>        kthread+0x293/0x360
>        ret_from_fork+0x2f/0x70
>        ret_from_fork_asm+0x1a/0x30
>
> -> #1 (&hdev->lock){+.+.}-{4:4}:
>        lock_acquire+0x1b6/0x510
>        __mutex_lock+0x180/0x1a60
>        iso_sock_listen+0x2d4/0xe00
>        __sys_listen+0x163/0x240
>        __x64_sys_listen+0x4e/0x70
>        do_syscall_64+0x71/0x140
>        entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> -> #0 (sk_lock-AF_BLUETOOTH-BTPROTO_ISO){+.+.}-{0:0}:
>        check_prev_add+0x1b5/0x23f0
>        __lock_acquire+0x2bdf/0x4580
>        lock_acquire+0x1b6/0x510
>        lock_sock_nested+0x36/0xd0
>        iso_connect_cfm+0x563/0x13e0
>        hci_le_per_adv_report_evt+0x4f8/0x6d0
>        hci_event_packet+0x54a/0xec0
>        hci_rx_work+0x76c/0x11c0
>        process_one_work+0x7d9/0x13d0
>        worker_thread+0x5b7/0xf90
>        kthread+0x293/0x360
>        ret_from_fork+0x2f/0x70
>        ret_from_fork_asm+0x1a/0x30
>
> other info that might help us debug this:
>
> Chain exists of:
>   sk_lock-AF_BLUETOOTH-BTPROTO_ISO --> &hdev->lock --> hci_cb_list_lock
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(hci_cb_list_lock);
>                                lock(&hdev->lock);
>                                lock(hci_cb_list_lock);
>   lock(sk_lock-AF_BLUETOOTH-BTPROTO_ISO);
>
>  *** DEADLOCK ***
>
> 4 locks held by kworker/u5:2/38:
>  #0: ffff888002213948 ((wq_completion)hci0#2){+.+.}-{0:0}, at:
> process_one_work+0xce8/0x13d0
>  #1: ffff8880024a7da0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0},
> at: process_one_work+0x758/0x13d0
>  #2: ffff888002300078 (&hdev->lock){+.+.}-{4:4}, at:
> hci_le_per_adv_report_evt+0x152/0x6d0
>  #3: ffffffffb0438668 (hci_cb_list_lock){+.+.}-{4:4}, at:
> hci_le_per_adv_report_evt+0x494/0x6d0
>
> While this doesn't seem to be new I think it is a good idea to try and
> solve it so we don't run into deadlocks.

Looks like this is due our usage of a mutex as locking for
hci_cb_list_lock, we could perhaps use a rwlock_t like its done for
hci_dev_list_lock but I think we may still run into possible unsafe
locking if there are multiple writers, so perhaps we could attempt to
convert use RCU which does allows us to do certain operations
lockless:

https://docs.kernel.org/next/RCU/listRCU.html

>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
