Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHv1 1/2] Bluetooth: Check sk is not owned before freeing
 l2cap_conn
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <AANLkTi=GB-QCBmB-2dKoZPrpDU_ZfQupjgD3p0ygv486@mail.gmail.com>
References: <1274883694-18120-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1274883694-18120-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1278429662.2789.52.camel@localhost.localdomain>
	 <AANLkTi=GB-QCBmB-2dKoZPrpDU_ZfQupjgD3p0ygv486@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 12 Aug 2010 07:27:05 -0400
Message-ID: <1281612425.12579.253.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> >> Check that socket sk is not locked in user process before removing
> >> l2cap connection handler.
> >>
> >> krfcommd kernel thread may be preempted with l2cap tasklet which remove
> >> l2cap_conn structure. If krfcommd is in process of sending of RFCOMM reply
> >> (like "RFCOMM UA" reply to "RFCOMM DISC") then kernel crash happens.
> >>
> >> ...
> >> [  694.175933] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> >> [  694.184936] pgd = c0004000
> >> [  694.187683] [00000000] *pgd=00000000
> >> [  694.191711] Internal error: Oops: 5 [#1] PREEMPT
> >> [  694.196350] last sysfs file: /sys/devices/platform/hci_h4p/firmware/hci_h4p/loading
> >> [  694.260375] CPU: 0    Not tainted  (2.6.32.10 #1)
> >> [  694.265106] PC is at l2cap_sock_sendmsg+0x43c/0x73c [l2cap]
> >> [  694.270721] LR is at 0xd7017303
> >> ...
> >> [  694.525085] Backtrace:
> >> [  694.527587] [<bf266be0>] (l2cap_sock_sendmsg+0x0/0x73c [l2cap]) from [<c02f2cc8>] (sock_sendmsg+0xb8/0xd8)
> >> [  694.537292] [<c02f2c10>] (sock_sendmsg+0x0/0xd8) from [<c02f3044>] (kernel_sendmsg+0x48/0x80)
> >> ...
> >>
> >> Modified version after comments of Gustavo F. Padovan <gustavo@padovan.org>
> >>
> >> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> >
> > the patch seems to be fine, but I have some extra questions/concerns.
> >
> > Who is now taking care of deleting the channel in this case? I think you
> > need to show that the code flow is still valid.
> 
> I have the other version of the I have sent already to ML where I use
> standard l2cap
> timer which will delete channel like the code below:
> 
> +       /* don't delete l2cap channel if sk is owned by user */
> +       if (sock_owned_by_user(sk)) {
> +               sk->sk_state = BT_DISCONN;
> +               l2cap_sock_clear_timer(sk);
> +               l2cap_sock_set_timer(sk, HZ);
> +               bh_unlock_sock(sk);
> +               return 0;
> +       }
> 
> > Also the question is how RFCOMM can send this UA or DISC with not
> > locking the socket. The comment on l2cap_chan_del clearly states that
> > the socket must be locked and inside L2CAP we do that. Is RFCOMM maybe
> > at fault here?
> 
> when RFCOMM send packets it lock_sock which marks sk as owned
> sk->sk_lock.owned = 1;
> and then can be preempted.

I need a new patch with a proper and most likely lengthy commit message
explaining every single detail here. Since right now you lost me.

Regards

Marcel


