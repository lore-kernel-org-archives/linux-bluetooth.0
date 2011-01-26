Return-Path: <cyrus@holtmann.org>
Date: Wed, 26 Jan 2011 15:13:06 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3] Bluetooth: fix crash by disabling tasklet in sock
 accept
Message-ID: <20110126171306.GB27017@joana>
References: <1295859204-20599-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1295859204-20599-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-01-24 10:53:24 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> 
> Crash can happen when tasklet handling connect/disconnect requests
> preempts socket accept. Can be reproduced with "l2test -r" on one
> side and several "l2test -c -b 1000 -i hci0 -P 10 <bdaddr>" on the
> other side.
> 
> disable taskets in socket accept and change lock_sock and release_sock
> to bh_lock_sock and bh_unlock_sock since we have to use spinlocks and
> there is no need to mark sock as owned by user.
> 
> ...
> [ 3555.897247] Unable to handle kernel NULL pointer dereference at virtual
> address 000000bc
> [ 3555.915039] pgd = cab9c000
> [ 3555.917785] [000000bc] *pgd=8bf3d031, *pte=00000000, *ppte=00000000
> [ 3555.928314] Internal error: Oops: 17 [#1] PREEMPT
> [ 3555.999786] CPU: 0    Not tainted  (2.6.32.21-13874-g67918ef #65)
> ...
> [ 3556.005981] PC is at bt_accept_unlink+0x20/0x58 [bluetooth]
> [ 3556.011627] LR is at bt_accept_dequeue+0x3c/0xe8 [bluetooth]
> ...
> [ 3556.161285] [<bf0007fc>] (bt_accept_unlink+0x20/0x58 [bluetooth]) from
> [<bf000870>] (bt_accept_dequeue+0x3c/0xe8 [bluetooth])
> [ 3556.172729] [<bf000870>] (bt_accept_dequeue+0x3c/0xe8 [bluetooth]) from
> [<bf324df8>] (l2cap_sock_accept+0x100/0x15c [l2cap])
> [ 3556.184082] [<bf324df8>] (l2cap_sock_accept+0x100/0x15c [l2cap]) from
> [<c026a0a8>] (sys_accept4+0x120/0x1e0)
> [ 3556.193969] [<c026a0a8>] (sys_accept4+0x120/0x1e0) from [<c002c9a0>]
> (ret_fast_syscall+0x0/0x2c)
> [ 3556.202819] Code: e5813000 e5901164 e580c160 e580c15c (e1d13bbc)
> ...
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> ---
>  net/bluetooth/af_bluetooth.c |   13 +++++++++----
>  1 files changed, 9 insertions(+), 4 deletions(-)

Patch is applied now. Thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
