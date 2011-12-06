Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABUK1ahtres=AGcpSNowRSdpWGY9pUfCCnsxtBs8MRU2XJ-4mg@mail.gmail.com>
References: <CABUK1ahtres=AGcpSNowRSdpWGY9pUfCCnsxtBs8MRU2XJ-4mg@mail.gmail.com>
Date: Tue, 6 Dec 2011 15:14:27 -0600
Message-ID: <CABUK1aguf4g8LjJKqNh-kRa6rWcUAA4hcAq_Epd7yVD9z+2gNQ@mail.gmail.com>
Subject: Re: kpanic during hciconfig hci0 down.
From: Pavan Savoy <pavan_savoy@sify.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Nov 17, 2011 at 12:57 PM, Pavan Savoy <pavan_savoy@sify.com> wrote:
> Hi,
>
> I am running some robustness tests in my btwilink driver - and every
> time I have a back to back hciconfig hci0 up/down, I see this crash.
> This is somehow not on the 2.6.xx-bluetooth-next but exists on the 3.0 kernel.
>
> Any pointers ???

I still face this issue ....
> [ 1721.079681] [<c049d9b4>] (__skb_recv_datagram+0x0/0x2a0) from
> [<c049dc7c>] (skb_recv_datagram+0x28/0x30)
> [ 1721.089935] [<c049dc54>] (skb_recv_datagram+0x0/0x30) from
> [<c05af690>] (hci_sock_recvmsg+0x50/0x12c)

Something is not quite right with hci_sock_recvmsg() - A simple script
which does hciconfig hci0 up/down should be enough to reproduce this.



>
> [ 1720.013305] Unable to handle kernel NULL pointer dereference at
> virtual address 00000000
> [ 1720.022216] pgd = c5fc4000
> [ 1720.025115] [00000000] *pgd=85f75831, *pte=00000000, *ppte=00000000
> [ 1720.031951] Internal error: Oops: 817 [#1] PREEMPT SMP
> [ 1720.037506] Modules linked in: wl12xx_sdio(-) wl12xx mac80211
> cfg80211 compat [last unloaded: wl12xx_sdio]
> [ 1720.048034] CPU: 0    Tainted: G        W    (3.0.8-00163-gd335b7f #1)
> [ 1720.055084] PC is at __skb_recv_datagram+0x10c/0x2a0
> [ 1720.060485] LR is at 0x1
> [ 1720.063232] pc : [<c049dac0>]    lr : [<00000001>]    psr: 60000093
> [ 1720.063232] sp : c5dfbd48  ip : 00000000  fp : c5dfbda4
> [ 1720.075683] r10: c5fb5c70  r9 : c5ff5000  r8 : c5dfa000
> [ 1720.081329] r7 : c5dfbd70  r6 : c5fb5c64  r5 : c5dfbd64  r4 : c5fb5c00
> [ 1720.088409] r3 : 00000000  r2 : 00000000  r1 : 60000013  r0 : 00000000
> [ 1720.095458] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
> Segment user
> [ 1720.103271] Control: 10c5387d  Table: 85fc404a  DAC: 00000015
> [ 1720.109497]
> <snip ... >
> [ 1721.079681] [<c049d9b4>] (__skb_recv_datagram+0x0/0x2a0) from
> [<c049dc7c>] (skb_recv_datagram+0x28/0x30)
> [ 1721.089935] [<c049dc54>] (skb_recv_datagram+0x0/0x30) from
> [<c05af690>] (hci_sock_recvmsg+0x50/0x12c)
> [ 1721.099945] [<c05af640>] (hci_sock_recvmsg+0x0/0x12c) from
> [<c0490c28>] (sock_aio_read+0x18c/0x190)
> [ 1721.109741]  r8:00000404 r7:c5dfbe90 r6:00000000 r5:c6121400 r4:c5dfbe18
> [ 1721.117034] [<c0490a9c>] (sock_aio_read+0x0/0x190) from
> [<c01266cc>] (do_sync_read+0xb4/0xe4)
> [ 1721.126312] [<c0126618>] (do_sync_read+0x0/0xe4) from [<c012733c>]
> (vfs_read+0x130/0x138)
> [ 1721.135162] [<c012720c>] (vfs_read+0x0/0x138) from [<c0127420>]
> (sys_read+0x44/0x74)
> [ 1721.143524]  r8:00000000 r7:00000003 r6:00000404 r5:beaad6f8 r4:c69766c0
> [ 1721.150848] [<c01273dc>] (sys_read+0x0/0x74) from [<c0054f00>]
> (ret_fast_syscall+0x0/0x30)
> [ 1721.159820]  r9:c5dfa000 r8:c00550a8 r6:00000000 r5:000114a0 r4:beaad6f8
> [ 1721.167114] Code: e599c000 e5990004 e5893000 e5893004 (e580c000)
> [ 1721.173797] ---[ end trace 5ff7245745f21217 ]---
> [ 1721.178771] Kernel panic - not syncing: Fatal exception
