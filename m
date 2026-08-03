Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4829B33FE33;
	Mon,  3 Aug 2026 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785776028; cv=pass; b=m2LwUHOQ0gArxu6gfAxSIH4t2RZzydJ+y2mmrbYmOF8sVTR6F/TNmdKoLBDc9s2gsUhnQ6xD5l231NYOemM8217a/ypvpaolsy/vPF+OkplFyytW16nqSMDMIznfH3D/Vw+TM6ce3AKKYuBQpMKUjUQ62Z0EMdq6qK2PwJupUJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785776028; c=relaxed/simple;
	bh=gukFsLN4ZdS6RwfZxbTZ4JwdpjjI0jdfp0qknzgyT6I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xach+tOi/anhMssPVp504Gy+L7jkxzwff4oIx2TswM0l8nwfunR3rz+9hsTTsbMf4ML3jSOYkPQQzosUZKAvpCS+OHNpQ6xmM8rlGEQWJSCNeB2zf7RJcejlIoaOr7VDtl6887Zt/Wpjm0Lq6T89JSusY3JfFF+ab9cyzeN4NvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=CD/Mievr; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="CD/Mievr"
Received: from [192.168.1.195] (unknown [IPv6:2a03:1b20:5:f011:8::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hDN6N1rvcz4BKJG;
	Mon, 03 Aug 2026 19:53:31 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1785776012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Ooy+cA9wIrSLQxg+yknnPo8Bs/8wu2VJtMa+N+hZIg=;
	b=CD/MievrLDdcTdQXuy+Ug6DeIUpODNwnsQ/ng/0vRCQcGVRJc9bwKfLOwB2pirPszBndCN
	Qv0M5EtvhcCt0q1YD0zfRvQ3sB+d1LNLql6p1teCS0WYFLOz88LZT4Y5JZq1kqTUOUCd9R
	PUc54P78/cPrrYnqUo8f+MVwr37kH+OEA9gHJvNzZJFfZmWSFRuOnYM+Ex/sGTpVSSSCd3
	ZXRneMVllIerObJPCSu/bIZRNDpNIELPqrLZsrC3FMPSO+EfF3ly96gUixEE5BetiIl4xZ
	Q2X03x3youq9omzUF4XHlmEJ70bvUUkiPS4TjAluqRCc7KSr4kRb/SKe7vcXbg==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1785776012;
	b=Q1LwLokyMNYC4ZzApqL+4r+kdl90GDc42CHtUg2lrNNcFcEKhYw35dpdw4J7V/ju5GqzbZ
	82eEmHhlw2XY7CDVRZzlSaTmGvw+b8L7WuBVSBqZh+8nm7t0/8tZJUbDqBc52nByO7yCiy
	g17vIPctDCBpOvwKftLjYqzvcXlmjZB8j6hLZHRkSOj1RyN6OTyVeVkdIIWIOAwG68SXaM
	akceiBdKjdVb9dD6cWo+Wr5chLYF3zBZZlhmK+5mfQ0wvimiPAZ4OR16OnfmWwtkNpzJgH
	itmP6DqIRB0rmhw1WM+CFN4oUBFjmMH5L9QUsSRqWFGkWP2KN+sdsBdLRl6xAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1785776012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Ooy+cA9wIrSLQxg+yknnPo8Bs/8wu2VJtMa+N+hZIg=;
	b=s8Y1D5Rsp74G8ozfwFrHFsEsIlEeax/aphxkGouIi9R0hhgnqSXPIpvaV+EsRnF0aDwXpZ
	emhE254830XbDXayPe9AqZ9+l2PriojT2apPK7pfFPVa42foxWUKdU1RUKJQ6ISs9PGIbR
	mOPFGPSIxCBiq9USKSi7DPj51qSGKVT6e8pSNqgfJFUtjkKCtEsl6dxdpJjb++cqvV1hQY
	sHVPpPER20MNMrK0GtpUfAVdoi9CI3OOdpNr11Ok2B5+mmT8IIALKYxuSRmeZFQ1f7bE+9
	0e3qT4vKv/HuQ9oOPyJZKoj/1SzBCDDq2XfeKuY+8QMByMJQg7mFX5MPYIg3dw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <192fb711930f4f0b7d06266f78d638664e982318.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: L2CAP: fix race l2cap_sock_cleanup_listen()
 vs. put_chan
From: Pauli Virtanen <pav@iki.fi>
To: Hillf Danton <hdanton@sina.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, 	linux-kernel@vger.kernel.org, 
	syzbot+e6382a2f53f5fc7453ac@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Date: Mon, 03 Aug 2026 19:53:31 +0300
In-Reply-To: <a5db0837d52496b7b2c23072f5da036b82f1433d.1785672691.git.pav@iki.fi>
References: 
	<a5db0837d52496b7b2c23072f5da036b82f1433d.1785672691.git.pav@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ma, 2026-08-03 kello 14:13 +0800, Hillf Danton kirjoitti:
> On Sun,  2 Aug 2026 15:12:28 +0300 Pauli Virtanen wrote:
> > For L2CAP sockets without owning sk->sk_socket, reading
> > l2cap_pi(sk)->chan may race against concurrent l2cap_sock_kill() ->
> > l2cap_sock_put_chan().  This excludes simultaneous proto_ops callbacks,
> > but access in l2cap_sock_cleanup_listen() has unsafe lockless read.
> >=20
> > Fix the race by taking lock_sock() in l2cap_sock_kill() to
> > synchronize with l2cap_sock_cleanup_listen().  hold_unless_zero() is no=
t
> > needed here, l2cap_pi(sk)->chan owns reference if it is non-NULL.
> >=20
> > Fixes: 0e2c0392b9dc ("Bluetooth: L2CAP: Fix use-after-free in l2cap_soc=
k_new_connection_cb()")
> > Reported-by: syzbot+e6382a2f53f5fc7453ac@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3De6382a2f53f5fc7453ac
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > ---
> >  include/net/bluetooth/l2cap.h |  5 +++++
> >  net/bluetooth/l2cap_sock.c    | 23 +++++++++++++----------
> >  2 files changed, 18 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2ca=
p.h
> > index ef6ce1c20a4f..3d9a32094347 100644
> > --- a/include/net/bluetooth/l2cap.h
> > +++ b/include/net/bluetooth/l2cap.h
> > @@ -699,7 +699,12 @@ struct l2cap_rx_busy {
> > =20
> >  struct l2cap_pinfo {
> >  	struct bt_sock		bt;
> > +
> > +	/* With owning sk_socket chan may be read without lock, other access
> > +	 * should hold lock_sock.
> > +	 */
> >  	struct l2cap_chan	*chan;
> > +
> >  	struct list_head	rx_busy;
> >  };
> > =20
> > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > index 735167f73f31..9540617a0e6c 100644
> > --- a/net/bluetooth/l2cap_sock.c
> > +++ b/net/bluetooth/l2cap_sock.c
> > @@ -1312,7 +1312,12 @@ static void l2cap_sock_kill(struct sock *sk)
> > =20
> >  	BT_DBG("sk %p state %s", sk, state_to_string(sk->sk_state));
> > =20
> > +	/* Take lock to synchronize against access without owning sk->sk_sock=
et,
> > +	 * eg. in l2cap_sock_cleanup_listen(). proto_ops etc. don't need lock=
.
> > +	 */
> > +	lock_sock(sk);
> >  	l2cap_sock_put_chan(sk);
> > +	release_sock(sk);
> > =20
> >  	/* Kill poor orphan */
> >  	sock_set_flag(sk, SOCK_DEAD);
>=20
> In l2cap_sock_teardown_cb(), sock is only zapped after cleanup including =
unlink,
> so why do you see a linked and zapped sock in l2cap_sock_cleanup_listen()=
?

l2cap_sock_cleanup_listen() is not a single critical section.

There is the following race:

   [Task 1]                         [Task 2 (hdev->workqueue)]
   l2cap_sock_release(parent)       l2cap_disconn_cfm
     l2cap_sock_cleanup_listen        l2cap_conn_del
       bt_accept_dequeue                l2cap_chan_del
         lock_sock(sk)                    l2cap_sock_teardown_cb
         bt_accept_unlink
           bt_sk(sk)->parent =3D NULL
         release_sock(sk) ----------------> lock_sock(sk)
                                            parent =3D bt_sk(sk)->parent /*=
 =3D=3D NULL */
       lock_sock(sk) <--------------------- release_sock(sk)
                                            sock_set_flag(sk, SOCK_ZAPPED)
                                        l2cap_sock_close_cb
                                          l2cap_sock_kill(sk)
                                            l2cap_sock_put_chan
       chan =3D READ l2cap_pi(sk)->chan         l2cap_pi(sk)->chan =3D NULL
       l2cap_chan_hold_unless_zero            l2cap_put_chan(chan)
         kref_get_unless_zero(&chan->ref)

> > @@ -1516,14 +1521,10 @@ static void l2cap_sock_cleanup_listen(struct so=
ck *parent)
> >  	 * establish sk_lock -> conn->lock and invert the established
> >  	 * conn->lock -> chan->lock -> sk_lock order (lockdep deadlock).
> >  	 *
> > -	 * Instead, briefly take the child sk lock to fetch and pin its chan.
> > -	 * l2cap_conn_del() reaches the chan free only via
> > -	 * l2cap_chan_del() -> l2cap_sock_teardown_cb(), which itself takes
> > -	 * the child sk lock; holding it across l2cap_chan_hold_unless_zero()
> > -	 * therefore guarantees the chan cannot be freed while we read and
> > -	 * pin it (hold_unless_zero() additionally skips a chan already past
> > -	 * its last reference).  We then drop the sk lock before taking
> > -	 * chan->lock, so sk and chan locks are never held together.
> > +	 * Instead, briefly take the child sk lock to synchronize vs.
> > +	 * l2cap_sock_kill that puts l2cap_pi(sk)->chan. We then drop the sk
> > +	 * lock before taking chan->lock, so sk and chan locks are never held
> > +	 * together.
> >  	 *
> >  	 * Since we cannot call l2cap_chan_close() without conn->lock,
> >  	 * schedule l2cap_chan_timeout to close the channel; it already
> > @@ -1533,10 +1534,12 @@ static void l2cap_sock_cleanup_listen(struct so=
ck *parent)
> >  		struct l2cap_chan *chan;
> > =20
> >  		lock_sock_nested(sk, L2CAP_NESTING_NORMAL);
> > -		chan =3D l2cap_chan_hold_unless_zero(l2cap_pi(sk)->chan);
> > +		chan =3D l2cap_pi(sk)->chan;
> > +		if (chan)
> > +			l2cap_chan_hold(chan);
> >  		release_sock(sk);
> >  		if (!chan) {
> > -			/* l2cap_conn_del() already tearing this child down */
> > +			/* Already torn down */
> >  			sock_put(sk);
> >  			continue;
> >  		}
> > --=20
> > 2.55.0
