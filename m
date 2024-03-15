Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD68E17584
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Mar 2024 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710499784; cv=pass; b=PqUSxtHNIe+F7Njfkgzhj87yA2cpgUPJvGAB1exnrvA6jIEtKJ4GMstbglF9afSTglTB755eIRkxjNalmj9MpPbhJXNB0I6sQFOxwwCjGylbnM5XOqSkz87jaiU54eFxHhyV1f/pthXidwOdFO3SuBrFLGMxcI+WkH14NttBb/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710499784; c=relaxed/simple;
	bh=KxRKO+SGYNKSKtyZFTobBUcoKKtMO9YN4WEumOOkx8M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZUw9NapRf9MqLBNFzmEeGXqxIXvLFlOgPBct1ODfrRfIxwWcOcmYrC0iLPi+0TQNRRT7exdw/5nGCJYv+21l+WxT2Cf0GO4E7d/Sp3sy5UPMOQhHn5oW4woATXI+oGEhyDyorr3dJfimgPt4+VoeZjncbXvn7/uivJXiAInGtis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=mE3bxTi6; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="mE3bxTi6"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Tx1GR36F2z49Psp;
	Fri, 15 Mar 2024 12:49:35 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1710499776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZJCwxTddZ33N6Bgz0+H7sdAc88CchSTXvlPnGIfDdnE=;
	b=mE3bxTi6XwZC/ROfkvuL/f3cw9RGaH1CjEN1yNPbnEPOX2nWJo8Zrt/YPdVWSYuf6usKdS
	l0KHd2b3mNltcJ9/gFfA+3Hpn9R6UTk8VxZr1KvG/XBXMy3xWoyc6Eh/12otOsPXZqpKkU
	IIa2QGZPR3q+48XjWZC+2OCBebEraHINSQSY+uNBLCVnr5wnoBCxsSYWR/cUhjJh/aaRXq
	8azYhTviiDJd5OI6Pbc2cRZbw8GOvFVg6EdYtBVT9Ty+SPTgynnevtB5HaYyT+m98O8uuB
	jq5jvWEmmcXv47pm4w6HXOtYswMLP4iMFcAOkr5m9Y9amF4Wv6W1sbxRGNFF1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1710499776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZJCwxTddZ33N6Bgz0+H7sdAc88CchSTXvlPnGIfDdnE=;
	b=NncMGI5BvbJgTORdTI0frHfgeF5hDvYwL6VrUgsutGY5oWISw2hLv0obmdPEvi5xd26QMN
	osj1IFrKG642FfqwF+HU+wm7HLwHrcZi3yGKkZOneOmJ/uDWk2PpbluKqbvU/t1CBF4Ifq
	1OK1TuuQziU7uxtlb8Gtpg0vYhEqrE7L+6PWvwbYQXRSS0Aj12iKefmWvUQiZto6KWMMzp
	vFqejvmXgs43QrL4dhuaSrFFrGHvWhU2/jtQMrrG7oc5INxIAP86ChUJsr1BXJroqz6Hrj
	SsoNoZZGa1vJIdAw1ofWEMzDYW/okUmRjnxE4X7BbyYXocqodw5s/5v+dBHU0w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1710499776; a=rsa-sha256;
	cv=none;
	b=Ob0IDyoMqHbE6P2RCid0UT+glQNjk3BWWoi7/wLxzkoYwS9CSz1JN5ofpJQm2F1gEg2ZcA
	spcMp+wbV4r6OK4oEkrZWnTU/V12EAr/8ettYsFawqiN/4WH8ZbrAtplgLyBLbclyncJtX
	9ngIoR1bF2d+6jTfAEbqVxmfllVQt4XRNCs7wydaIE7q6tQiOmJI7AELxJoU32ssbZ9LtY
	q2rPbtnzEDuTZ6Ee4gL4AjPhFF/3Wn33VTDFz9PaqgQOgHXDTCn6BdzoF0YkcZKFMiBpdA
	1ZWDMUsuS66netvlijXhhclFTSDPcObN8KQSmPU4tWpj7QKgRnORfYJFdoYUlg==
Message-ID: <985fa44991c27e773f2a4b4fafaf5879719eb6fb.camel@iki.fi>
Subject: Re: [PATCH v2 5/5] Bluetooth: add BT_NO_ERRQUEUE_POLL socket option
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 15 Mar 2024 12:49:31 +0200
In-Reply-To: <CABBYNZLWbwTGOuZeYvFou=+98_XNdYVu-hWiqrUFvZvuU50_yw@mail.gmail.com>
References: <cover.1710440392.git.pav@iki.fi>
	 <134027f3cbaeb7095d080c27cd4b1053d2eb560e.1710440392.git.pav@iki.fi>
	 <CABBYNZLWbwTGOuZeYvFou=+98_XNdYVu-hWiqrUFvZvuU50_yw@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Luiz,

to, 2024-03-14 kello 23:18 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Thu, Mar 14, 2024 at 2:23=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote=
:
> >=20
> > Add socket option to disable POLLERR on non-empty socket error queue.
> >=20
> > Applications can use this for sleeping socket error POLLERR waits, also
> > when using TX timestamping. This is useful when multiple layers of the
> > stack are using the same socket.
>=20
> So the idea here is that bluetoothd would set BT_NO_ERRQUEUE_POLL to
> not be awakened by timestamps? I wonder why this works on per
> fd/socket level while SO_TIMESTAMPING does apply to all sockets
> though, or perhaps that is not really related to SO_TIMESTAMPING but
> errqueue being the same to all cloned sockets? I'm a little hesitant
> to start introducing new socket options if the whole point was to
> avoid doing so with the use of SO_TIMESTAMPING.

It works the same as SO_TIMESTAMPING, setting BT_NO_ERRQUEUE_POLL
applies to all fds referring to the socket, so it is not per fd either.

The idea is that Pipewire sets BT_NO_ERRQUEUE_POLL before enabling
SO_TIMESTAMPING. Then nobody gets POLLERR on errqueue messages.

Instead, it reads MSG_ERRQUEUE always when sending the next packet,
instead of using POLLERR. This works fine in practice and is tested.


I'd appreciate if we can agree on the whole-stack plan.


***

For sockets vs. fds, see net/socket.c:sockfd_lookup

dup() of fd creates new int fd pointing to the same struct file &
struct socket, but not duplicate struct socket/sock, see fs/file.c:1412

Passing fds via unix socket like in DBus seems the same, see
include/net/scm.h:scm_recv_one_fd & fs/file.c:receive_fd

Indeed, you can also see this in debug logs, e.g.=C2=A0

[53573.676885] iso_sock_getname:1103: sock 0000000018c143a2, sk 000000002af=
f8d2b  (from BlueZ)
[53580.831753] iso_sock_getname:1103: sock 00000000419df212, sk 00000000526=
df659  (from BlueZ)
...
[53592.472038] iso_sock_sendmsg:1127: sock 0000000018c143a2, sk 000000002af=
f8d2b  (from PW)
[53592.472062] iso_sock_sendmsg:1127: sock 00000000419df212, sk 00000000526=
df659  (from PW)

setsockopt(), errqueue, RX queue etc. are struct socket level stuff.

>=20
>=20
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > ---
> >  include/net/bluetooth/bluetooth.h |  9 +++-
> >  net/bluetooth/af_bluetooth.c      | 72 ++++++++++++++++++++++++++++++-
> >  net/bluetooth/iso.c               |  8 ++--
> >  net/bluetooth/l2cap_sock.c        |  8 ++--
> >  net/bluetooth/sco.c               |  8 ++--
> >  5 files changed, 91 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/=
bluetooth.h
> > index 9280e72093ee..dcee5384d715 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -240,6 +240,8 @@ struct bt_codecs {
> >=20
> >  #define BT_ISO_BASE            20
> >=20
> > +#define BT_NO_ERRQUEUE_POLL    21
> > +
> >  __printf(1, 2)
> >  void bt_info(const char *fmt, ...);
> >  __printf(1, 2)
> > @@ -387,7 +389,8 @@ struct bt_sock {
> >  enum {
> >         BT_SK_DEFER_SETUP,
> >         BT_SK_SUSPEND,
> > -       BT_SK_PKT_STATUS
> > +       BT_SK_PKT_STATUS,
> > +       BT_SK_NO_ERRQUEUE_POLL
> >  };
> >=20
> >  struct bt_sock_list {
> > @@ -410,6 +413,10 @@ int  bt_sock_stream_recvmsg(struct socket *sock, s=
truct msghdr *msg,
> >                             size_t len, int flags);
> >  __poll_t bt_sock_poll(struct file *file, struct socket *sock, poll_tab=
le *wait);
> >  int  bt_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned lon=
g arg);
> > +int bt_sock_setsockopt(struct socket *sock, int level, int optname,
> > +                      sockptr_t optval, unsigned int optlen);
> > +int bt_sock_getsockopt(struct socket *sock, int level, int optname,
> > +                      char __user *optval, int __user *optlen);
> >  int  bt_sock_wait_state(struct sock *sk, int state, unsigned long time=
o);
> >  int  bt_sock_wait_ready(struct sock *sk, unsigned int msg_flags);
> >=20
> > diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.=
c
> > index 67604ccec2f4..997197aa7b48 100644
> > --- a/net/bluetooth/af_bluetooth.c
> > +++ b/net/bluetooth/af_bluetooth.c
> > @@ -500,6 +500,12 @@ static inline __poll_t bt_accept_poll(struct sock =
*parent)
> >         return 0;
> >  }
> >=20
> > +static bool bt_sock_error_queue_poll(struct sock *sk)
> > +{
> > +       return !test_bit(BT_SK_NO_ERRQUEUE_POLL, &bt_sk(sk)->flags) &&
> > +               !skb_queue_empty_lockless(&sk->sk_error_queue);
> > +}
> > +
> >  __poll_t bt_sock_poll(struct file *file, struct socket *sock,
> >                       poll_table *wait)
> >  {
> > @@ -511,7 +517,7 @@ __poll_t bt_sock_poll(struct file *file, struct soc=
ket *sock,
> >         if (sk->sk_state =3D=3D BT_LISTEN)
> >                 return bt_accept_poll(sk);
> >=20
> > -       if (sk->sk_err || !skb_queue_empty_lockless(&sk->sk_error_queue=
))
> > +       if (sk->sk_err || bt_sock_error_queue_poll(sk))
> >                 mask |=3D EPOLLERR |
> >                         (sock_flag(sk, SOCK_SELECT_ERR_QUEUE) ? EPOLLPR=
I : 0);
> >=20
> > @@ -582,6 +588,70 @@ int bt_sock_ioctl(struct socket *sock, unsigned in=
t cmd, unsigned long arg)
> >  }
> >  EXPORT_SYMBOL(bt_sock_ioctl);
> >=20
> > +int bt_sock_setsockopt(struct socket *sock, int level, int optname,
> > +                      sockptr_t optval, unsigned int optlen)
> > +{
> > +       struct sock *sk =3D sock->sk;
> > +       int err =3D 0;
> > +       u32 opt;
> > +
> > +       if (level !=3D SOL_BLUETOOTH)
> > +               return -ENOPROTOOPT;
> > +
> > +       lock_sock(sk);
> > +
> > +       switch (optname) {
> > +       case BT_NO_ERRQUEUE_POLL:
> > +               if (copy_from_sockptr(&opt, optval, sizeof(opt))) {
> > +                       err =3D -EFAULT;
> > +                       break;
> > +               }
> > +
> > +               if (opt)
> > +                       set_bit(BT_SK_NO_ERRQUEUE_POLL, &bt_sk(sk)->fla=
gs);
> > +               else
> > +                       clear_bit(BT_SK_NO_ERRQUEUE_POLL, &bt_sk(sk)->f=
lags);
> > +               break;
> > +
> > +       default:
> > +               err =3D -ENOPROTOOPT;
> > +               break;
> > +       }
> > +
> > +       release_sock(sk);
> > +       return err;
> > +}
> > +EXPORT_SYMBOL(bt_sock_setsockopt);
> > +
> > +int bt_sock_getsockopt(struct socket *sock, int level, int optname,
> > +                      char __user *optval, int __user *optlen)
> > +{
> > +       struct sock *sk =3D sock->sk;
> > +       int err =3D 0;
> > +       u32 opt;
> > +
> > +       if (level !=3D SOL_BLUETOOTH)
> > +               return -ENOPROTOOPT;
> > +
> > +       lock_sock(sk);
> > +
> > +       switch (optname) {
> > +       case BT_NO_ERRQUEUE_POLL:
> > +               opt =3D test_bit(BT_SK_NO_ERRQUEUE_POLL, &bt_sk(sk)->fl=
ags);
> > +               if (put_user(opt, (u32 __user *)optval))
> > +                       err =3D -EFAULT;
> > +               break;
> > +
> > +       default:
> > +               err =3D -ENOPROTOOPT;
> > +               break;
> > +       }
> > +
> > +       release_sock(sk);
> > +       return err;
> > +}
> > +EXPORT_SYMBOL(bt_sock_getsockopt);
> > +
> >  /* This function expects the sk lock to be held when called */
> >  int bt_sock_wait_state(struct sock *sk, int state, unsigned long timeo=
)
> >  {
> > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> > index a77ab9df7994..6f5af549a8cc 100644
> > --- a/net/bluetooth/iso.c
> > +++ b/net/bluetooth/iso.c
> > @@ -1596,8 +1596,8 @@ static int iso_sock_setsockopt(struct socket *soc=
k, int level, int optname,
> >                 break;
> >=20
> >         default:
> > -               err =3D -ENOPROTOOPT;
> > -               break;
> > +               release_sock(sk);
> > +               return bt_sock_setsockopt(sock, level, optname, optval,=
 optlen);
> >         }
> >=20
> >         release_sock(sk);
> > @@ -1667,8 +1667,8 @@ static int iso_sock_getsockopt(struct socket *soc=
k, int level, int optname,
> >                 break;
> >=20
> >         default:
> > -               err =3D -ENOPROTOOPT;
> > -               break;
> > +               release_sock(sk);
> > +               return bt_sock_getsockopt(sock, level, optname, optval,=
 optlen);
> >         }
> >=20
> >         release_sock(sk);
> > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > index 9a9f933a748b..06277ce1fd6b 100644
> > --- a/net/bluetooth/l2cap_sock.c
> > +++ b/net/bluetooth/l2cap_sock.c
> > @@ -697,8 +697,8 @@ static int l2cap_sock_getsockopt(struct socket *soc=
k, int level, int optname,
> >                 break;
> >=20
> >         default:
> > -               err =3D -ENOPROTOOPT;
> > -               break;
> > +               release_sock(sk);
> > +               return bt_sock_getsockopt(sock, level, optname, optval,=
 optlen);
> >         }
> >=20
> >         release_sock(sk);
> > @@ -1102,8 +1102,8 @@ static int l2cap_sock_setsockopt(struct socket *s=
ock, int level, int optname,
> >                 break;
> >=20
> >         default:
> > -               err =3D -ENOPROTOOPT;
> > -               break;
> > +               release_sock(sk);
> > +               return bt_sock_setsockopt(sock, level, optname, optval,=
 optlen);
> >         }
> >=20
> >         release_sock(sk);
> > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > index b3c2af7c7d67..b8b1b314aed4 100644
> > --- a/net/bluetooth/sco.c
> > +++ b/net/bluetooth/sco.c
> > @@ -968,8 +968,8 @@ static int sco_sock_setsockopt(struct socket *sock,=
 int level, int optname,
> >                 break;
> >=20
> >         default:
> > -               err =3D -ENOPROTOOPT;
> > -               break;
> > +               release_sock(sk);
> > +               return bt_sock_setsockopt(sock, level, optname, optval,=
 optlen);
> >         }
> >=20
> >         release_sock(sk);
> > @@ -1211,8 +1211,8 @@ static int sco_sock_getsockopt(struct socket *soc=
k, int level, int optname,
> >                 break;
> >=20
> >         default:
> > -               err =3D -ENOPROTOOPT;
> > -               break;
> > +               release_sock(sk);
> > +               return bt_sock_getsockopt(sock, level, optname, optval,=
 optlen);
> >         }
> >=20
> >         release_sock(sk);
> > --
> > 2.44.0
> >=20
> >=20
>=20
>=20

