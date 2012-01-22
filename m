Return-Path: <cyrus@holtmann.org>
Message-ID: <1327224111.1955.72.camel@aeonflux>
Subject: Re: [PATCH v4] Bluetooth: silence lockdep warning
From: Marcel Holtmann <marcel@holtmann.org>
To: Octavian Purdila <tavi.purdila@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, kirill.shutemov@linux.intel.com,
	Octavian Purdila <octavian.purdila@intel.com>
Date: Sun, 22 Jan 2012 10:21:51 +0100
In-Reply-To: <1327184914-2902-1-git-send-email-octavian.purdila@intel.com>
References: <1327184914-2902-1-git-send-email-octavian.purdila@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ocatvian,

> Since bluetooth uses multiple protocols types, to avoid lockdep
> warnings, we need to use different lockdep classes (one for each
> protocol type).
> 
> This is already done in bt_sock_create but it misses a couple of cases
> when new connections are created. This patch corrects that to fix the
> following warning:
> 
> <4>[ 1864.732366] =======================================================
> <4>[ 1864.733030] [ INFO: possible circular locking dependency detected ]
> <4>[ 1864.733544] 3.0.16-mid3-00007-gc9a0f62 #3
> <4>[ 1864.733883] -------------------------------------------------------
> <4>[ 1864.734408] t.android.btclc/4204 is trying to acquire lock:
> <4>[ 1864.734869]  (rfcomm_mutex){+.+.+.}, at: [<c14970ea>] rfcomm_dlc_close+0x15/0x30
> <4>[ 1864.735541]
> <4>[ 1864.735549] but task is already holding lock:
> <4>[ 1864.736045]  (sk_lock-AF_BLUETOOTH){+.+.+.}, at: [<c1498bf7>] lock_sock+0xa/0xc
> <4>[ 1864.736732]
> <4>[ 1864.736740] which lock already depends on the new lock.
> <4>[ 1864.736750]
> <4>[ 1864.737428]
> <4>[ 1864.737437] the existing dependency chain (in reverse order) is:
> <4>[ 1864.738016]
> <4>[ 1864.738023] -> #1 (sk_lock-AF_BLUETOOTH){+.+.+.}:
> <4>[ 1864.738549]        [<c1062273>] lock_acquire+0x104/0x140
> <4>[ 1864.738977]        [<c13d35c1>] lock_sock_nested+0x58/0x68
> <4>[ 1864.739411]        [<c1493c33>] l2cap_sock_sendmsg+0x3e/0x76
> <4>[ 1864.739858]        [<c13d06c3>] __sock_sendmsg+0x50/0x59
> <4>[ 1864.740279]        [<c13d0ea2>] sock_sendmsg+0x94/0xa8
> <4>[ 1864.740687]        [<c13d0ede>] kernel_sendmsg+0x28/0x37
> <4>[ 1864.741106]        [<c14969ca>] rfcomm_send_frame+0x30/0x38
> <4>[ 1864.741542]        [<c1496a2a>] rfcomm_send_ua+0x58/0x5a
> <4>[ 1864.741959]        [<c1498447>] rfcomm_run+0x441/0xb52
> <4>[ 1864.742365]        [<c104f095>] kthread+0x63/0x68
> <4>[ 1864.742742]        [<c14d5182>] kernel_thread_helper+0x6/0xd
> <4>[ 1864.743187]
> <4>[ 1864.743193] -> #0 (rfcomm_mutex){+.+.+.}:
> <4>[ 1864.743667]        [<c1061ada>] __lock_acquire+0x988/0xc00
> <4>[ 1864.744100]        [<c1062273>] lock_acquire+0x104/0x140
> <4>[ 1864.744519]        [<c14d2c70>] __mutex_lock_common+0x3b/0x33f
> <4>[ 1864.744975]        [<c14d303e>] mutex_lock_nested+0x2d/0x36
> <4>[ 1864.745412]        [<c14970ea>] rfcomm_dlc_close+0x15/0x30
> <4>[ 1864.745842]        [<c14990d9>] __rfcomm_sock_close+0x5f/0x6b
> <4>[ 1864.746288]        [<c1499114>] rfcomm_sock_shutdown+0x2f/0x62
> <4>[ 1864.746737]        [<c13d275d>] sys_socketcall+0x1db/0x422
> <4>[ 1864.747165]        [<c14d42f0>] syscall_call+0x7/0xb
> 
> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> ---
>  include/net/bluetooth/bluetooth.h |    2 ++
>  net/bluetooth/af_bluetooth.c      |   12 +++++-------
>  net/bluetooth/l2cap_sock.c        |    2 ++
>  net/bluetooth/rfcomm/sock.c       |    2 ++
>  4 files changed, 11 insertions(+), 7 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


