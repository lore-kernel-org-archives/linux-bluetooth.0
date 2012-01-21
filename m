Return-Path: <cyrus@holtmann.org>
Message-ID: <1327164299.1955.53.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: silence lockdep warning
From: Marcel Holtmann <marcel@holtmann.org>
To: Octavian Purdila <octavian.purdila@intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 21 Jan 2012 17:44:59 +0100
In-Reply-To: <1326993579-14429-1-git-send-email-octavian.purdila@intel.com>
References: <1326993579-14429-1-git-send-email-octavian.purdila@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Octavian,

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
> <4>[ 1864.747557]
> 
> Change-Id: I0e5e395e579c20d29d1fb3aef862c011a9031225

No Change-Id please. This is not some Gerrit review thing.

> Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
> ---
>  include/net/bluetooth/bluetooth.h |    2 ++
>  net/bluetooth/af_bluetooth.c      |    7 +++----
>  net/bluetooth/l2cap_sock.c        |    2 ++
>  net/bluetooth/rfcomm/sock.c       |    2 ++
>  4 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index abaad6e..4a82ca0 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -256,4 +256,6 @@ void l2cap_exit(void);
>  int sco_init(void);
>  void sco_exit(void);
>  
> +void bt_sock_reclassify_lock(struct sock *sk, int proto);
> +
>  #endif /* __BLUETOOTH_H */
> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> index ef92864..cda89e9 100644
> --- a/net/bluetooth/af_bluetooth.c
> +++ b/net/bluetooth/af_bluetooth.c
> @@ -71,10 +71,8 @@ static const char *const bt_slock_key_strings[BT_MAX_PROTO] = {
>  	"slock-AF_BLUETOOTH-BTPROTO_AVDTP",
>  };
>  
> -static inline void bt_sock_reclassify_lock(struct socket *sock, int proto)
> +void bt_sock_reclassify_lock(struct sock *sk, int proto)
>  {
> -	struct sock *sk = sock->sk;
> -
>  	if (!sk)
>  		return;

Why are we keeping the !sk check here if we already hand in the sk. It
is most likely checked by the caller already.

>  
> @@ -84,6 +82,7 @@ static inline void bt_sock_reclassify_lock(struct socket *sock, int proto)
>  			bt_slock_key_strings[proto], &bt_slock_key[proto],
>  				bt_key_strings[proto], &bt_lock_key[proto]);
>  }
> +EXPORT_SYMBOL(bt_sock_reclassify_lock);
>  
>  int bt_sock_register(int proto, const struct net_proto_family *ops)
>  {
> @@ -145,7 +144,7 @@ static int bt_sock_create(struct net *net, struct socket *sock, int proto,
>  
>  	if (bt_proto[proto] && try_module_get(bt_proto[proto]->owner)) {
>  		err = bt_proto[proto]->create(net, sock, proto, kern);
> -		bt_sock_reclassify_lock(sock, proto);
> +		bt_sock_reclassify_lock(sock->sk, proto);
>  		module_put(bt_proto[proto]->owner);
>  	}
>  
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index c61d967..46b22d9 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -849,6 +849,8 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(void *data)
>  	if (!sk)
>  		return NULL;
>  
> +	bt_sock_reclassify_lock(sk, BTPROTO_L2CAP);
> +
>  	l2cap_sock_init(sk, parent);
>  
>  	return l2cap_pi(sk)->chan;
> diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
> index f066678..22169c3 100644
> --- a/net/bluetooth/rfcomm/sock.c
> +++ b/net/bluetooth/rfcomm/sock.c
> @@ -956,6 +956,8 @@ int rfcomm_connect_ind(struct rfcomm_session *s, u8 channel, struct rfcomm_dlc *
>  	if (!sk)
>  		goto done;
>  
> +	bt_sock_reclassify_lock(sk, BTPROTO_RFCOMM);
> +
>  	rfcomm_sock_init(sk, parent);
>  	bacpy(&bt_sk(sk)->src, &src);
>  	bacpy(&bt_sk(sk)->dst, &dst);

Otherwise this looks fine to me.

Regards

Marcel


