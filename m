Received: from smtp153-170.sina.com.cn (smtp153-170.sina.com.cn [61.135.153.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472E23C5849
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 00:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785804466; cv=none; b=DfzeLeYFMTeRAf761IKUvxg9Gq5Q8CsUsvhAKKSwo94ov8K8jCi+/8F4Ko2FM0BQ1I0bLTKi7stMYX7Gw6dKK+s5t6T6zshUn8lfmYsglkXp8aurzip0HD1BOYeqBDiBvbhjtzgK0YsdfUEhTxleWRXQeTceuD12Gyr/nCdhDVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785804466; c=relaxed/simple;
	bh=RwfhE0nCJyyH+f+M4aNiiUP0BZN1S7dVwwq0k3gfi3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kHJWBikAqADJqEInC7zTDcOfpoVNyNWUMu98/+0/Hk49cVxqFev9i8n5zzz+wk9jf/RPJMHWvLcQwciC+9yJHSjEhxqqHk6CzelW37aipSPzgTgOxa7KzZErY7JY3SgcStt73U2Q/sl302EdcPmfAPyGJq1Q/XIqeLJso0Xwago=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=HWJVNb7j; arc=none smtp.client-ip=61.135.153.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="HWJVNb7j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1785804458;
	bh=h3MllRhGRAiWTbUMsPUR6tWVm6AVeotBb0BSXJYSd7Q=;
	h=From:Subject:Date:Message-ID;
	b=HWJVNb7jX5TuNc8pwvevthknZhiwlz9n6ecOvg/MiDJPGJJ/3d46P1D2dsVQGftDY
	 nTRxgjLu/Eiuz+7l4XdeWTf+TDq2QeuwRPSKjJNqhHEJoVu4Fxrt3A5iAlyQQpdeXb
	 iRlPA7sscN4Kjy/pU08Ou9kU9vFmHjw62gxLrmog=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([221.216.154.155])
	by sina.com (10.54.253.34) with ESMTP
	id 6A71369D00004D5E; Tue, 4 Aug 2026 08:47:28 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5350396292118
X-SMAIL-UIID: 56B45D9821AC4D459F37AE1B4901F390-20260804-084728-1
From: Hillf Danton <hdanton@sina.com>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	syzbot+e6382a2f53f5fc7453ac@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] Bluetooth: L2CAP: fix race l2cap_sock_cleanup_listen() vs. put_chan
Date: Tue,  4 Aug 2026 08:47:13 +0800
Message-ID: <20260804004717.919-1-hdanton@sina.com>
In-Reply-To: <192fb711930f4f0b7d06266f78d638664e982318.camel@iki.fi>
References: 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 03 Aug 2026 19:53:31 +0300 Pauli Virtanen wrote:
> ma, 2026-08-03 kello 14:13 +0800, Hillf Danton kirjoitti:
> > On Sun,  2 Aug 2026 15:12:28 +0300 Pauli Virtanen wrote:
> > > For L2CAP sockets without owning sk->sk_socket, reading
> > > l2cap_pi(sk)->chan may race against concurrent l2cap_sock_kill() ->
> > > l2cap_sock_put_chan().  This excludes simultaneous proto_ops callbacks,
> > > but access in l2cap_sock_cleanup_listen() has unsafe lockless read.
> > > 
> > > Fix the race by taking lock_sock() in l2cap_sock_kill() to
> > > synchronize with l2cap_sock_cleanup_listen().  hold_unless_zero() is not
> > > needed here, l2cap_pi(sk)->chan owns reference if it is non-NULL.
> > > 
> > > Fixes: 0e2c0392b9dc ("Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()")
> > > Reported-by: syzbot+e6382a2f53f5fc7453ac@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=e6382a2f53f5fc7453ac
> > > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > > ---
> > >  include/net/bluetooth/l2cap.h |  5 +++++
> > >  net/bluetooth/l2cap_sock.c    | 23 +++++++++++++----------
> > >  2 files changed, 18 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> > > index ef6ce1c20a4f..3d9a32094347 100644
> > > --- a/include/net/bluetooth/l2cap.h
> > > +++ b/include/net/bluetooth/l2cap.h
> > > @@ -699,7 +699,12 @@ struct l2cap_rx_busy {
> > >  
> > >  struct l2cap_pinfo {
> > >  	struct bt_sock		bt;
> > > +
> > > +	/* With owning sk_socket chan may be read without lock, other access
> > > +	 * should hold lock_sock.
> > > +	 */
> > >  	struct l2cap_chan	*chan;
> > > +
> > >  	struct list_head	rx_busy;
> > >  };
> > >  
> > > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > > index 735167f73f31..9540617a0e6c 100644
> > > --- a/net/bluetooth/l2cap_sock.c
> > > +++ b/net/bluetooth/l2cap_sock.c
> > > @@ -1312,7 +1312,12 @@ static void l2cap_sock_kill(struct sock *sk)
> > >  
> > >  	BT_DBG("sk %p state %s", sk, state_to_string(sk->sk_state));
> > >  
> > > +	/* Take lock to synchronize against access without owning sk->sk_socket,
> > > +	 * eg. in l2cap_sock_cleanup_listen(). proto_ops etc. don't need lock.
> > > +	 */
> > > +	lock_sock(sk);
> > >  	l2cap_sock_put_chan(sk);
> > > +	release_sock(sk);
> > >  
> > >  	/* Kill poor orphan */
> > >  	sock_set_flag(sk, SOCK_DEAD);
> > 
> > In l2cap_sock_teardown_cb(), sock is only zapped after cleanup including unlink,
> > so why do you see a linked and zapped sock in l2cap_sock_cleanup_listen()?
> 
> l2cap_sock_cleanup_listen() is not a single critical section.
> 
> There is the following race:
> 
>    [Task 1]                         [Task 2 (hdev->workqueue)]
>    l2cap_sock_release(parent)       l2cap_disconn_cfm
>      l2cap_sock_cleanup_listen        l2cap_conn_del
>        bt_accept_dequeue                l2cap_chan_del
>          lock_sock(sk)                    l2cap_sock_teardown_cb
>          bt_accept_unlink
>            bt_sk(sk)->parent = NULL
>          release_sock(sk) ----------------> lock_sock(sk)
>                                             parent = bt_sk(sk)->parent /* == NULL */
>        lock_sock(sk) <--------------------- release_sock(sk)
>                                             sock_set_flag(sk, SOCK_ZAPPED)
>                                         l2cap_sock_close_cb
>                                           l2cap_sock_kill(sk)
>                                             l2cap_sock_put_chan
>        chan = READ l2cap_pi(sk)->chan         l2cap_pi(sk)->chan = NULL
>        l2cap_chan_hold_unless_zero            l2cap_put_chan(chan)
>          kref_get_unless_zero(&chan->ref)
>
The race window is still open after this work.

					     release_sock(sk)
                                             sock_set_flag(sk, SOCK_ZAPPED)
                                         l2cap_sock_close_cb
                                           l2cap_sock_kill(sk)
                                             l2cap_sock_put_chan
					       l2cap_pi(sk)->chan = NULL
					       l2cap_put_chan(chan)
					     sock_set_flag(sk, SOCK_DEAD);
					     sock_put(sk); // free sk
        lock_sock(sk) // uaf
        chan = READ l2cap_pi(sk)->chan
        l2cap_chan_hold_unless_zero
