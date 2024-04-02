Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49EE15B542
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 19:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712087097; cv=pass; b=ljKDUiheT80EEwVznxCqtVUfWm2ayAPfn2whvfsouohJFU3LDGUEAEGk0+d7FZ9n+cbVKUkE9XKa5khZ6/nkkmKqG1lOJ7b39raTJQkroxmwWs9yCS3q0EDvHgKkHb2gh+n8ZN9B3/X0xEh5HqLFeje1/aGjtqaTtd0hBxAVEXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712087097; c=relaxed/simple;
	bh=b+VTGk4HEgCV3nYNyn/fmrcPoW3bJnnQWNn4yhADzlo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=njFJxOGsQ0oK1VSiT3XLNfYj14/bAA8g925v2DsZMmLLCNCvapqlanez/hHtialHlFYxSvy++RQbh6DCL1n8i2u6G6DjH/wMtj4Uxn0f2DFQa5+cwrPEs2k3bPElFLQZdWGpdAlGTGedeOEXRg5UvaniqqaOetLoH6gO1CGn/Rg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=GozosTBi; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="GozosTBi"
Received: from [192.168.1.195] (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4V8JHm0lMfz49Pwl;
	Tue,  2 Apr 2024 22:44:51 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712087092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jB2kh+2SeJbLxmABazkkQO84AGOadK7Hs6nmQH3WMjs=;
	b=GozosTBisaWIFqAz6kyJYEA6Sa1zdeijiYhYh3d147rfszurU78rcuYFNLN+MQT31zlJQS
	2fxdseGbsyLYuNaB7nb+aqlRhM6vGXD+EMDuvgQaZ1E1Veb1p7u330e7Yb0wNHsrmub11q
	4TuAcdVFD2QoxBHN2ySc0XVXTv95CqnyYiQMqjMnsV3SPROqu5U12QPKjsmVmHPvtYH+ki
	UAoPHgLjDfVd3S19hTPhHeTnTe/Ae4xbBwU9w5i1G0BNiFb7Mh9g/G9cn4NePMJMuSy/3O
	moKoEeT2NQgdYviPQb84chArdYHc/eVgE7FWdSfaM1udFvXVwUcj+Pw/s4jGVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712087092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jB2kh+2SeJbLxmABazkkQO84AGOadK7Hs6nmQH3WMjs=;
	b=NsOjf/3xkqaSgU3WOvH5ZmyOSFEauWT1yYg2trVEgY58LJ4TYQ5OhtTaz2tzALRtthmrhl
	XaesEuhciAmbNECxKKVdsGgrQnwefSeluNqAjaIn542HgEtDFGleOmSRKzO9bEQLzFUh6D
	hQOLfjlgK1Zp0BLx83sfhJgFKjNxC3A2XHNJ6u+LpYGz3zSe/otSye73XoJmPBcqHDNZR9
	N48OJzj593aPDK8p8djYfnM85a83oamGAfsJbB8U/MlEaIeJdK6DNV1oKJias2tdSu7mSI
	i7285v1s7m6Guxit1EVEEX1d0J/56cRC3jtcnBygD5AM3uMVYRpGL4tF62CgLA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712087092; a=rsa-sha256;
	cv=none;
	b=NlGjH/gR6+zNoqkxzByh9tleHHTllUPmnCkwJe6Yu0ru24rpxLDR60KSl1y7HyFTz6Ykjq
	VoPwJBAYjNlQ+nwlelogdTYbxgPeVGtdzfTG2SCcLY0ds0Lwau1y2JOfXNAaPcNIyxjVqD
	MnBsovoaPxfVVWnSFB1GIqWvsokR3RKrNjrXdvuOG77in0+sR4ARMF2LGjWdb3BIoEOLZX
	kiZqi3teyFUQxCmZr87E4ae+4dVGcHYZFAImz60h1XMqsLx6c4R9GQ92MMNOveypMCQrvX
	Z4qpdluPPWivury4tGzuVBO03zNyZByOsAYxEMVNUnySVBy+pmmrTx1uSApC5w==
Message-ID: <f8a5d7b19dfb9b747533f5012041d96bf93d981a.camel@iki.fi>
Subject: Re: [PATCH v3] Bluetooth: add experimental BT_NO_ERRQUEUE_POLL
 socket option
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 02 Apr 2024 22:44:50 +0300
In-Reply-To: <CABBYNZJoAjqF2Ay_gWhvU-Am+FZ4hXxuB3PM6yHR4-DZ+QOymA@mail.gmail.com>
References: 
	<b44e1da7ebbfe99b74c136b8750981a4fb0ab243.1712075760.git.pav@iki.fi>
	 <CABBYNZJoAjqF2Ay_gWhvU-Am+FZ4hXxuB3PM6yHR4-DZ+QOymA@mail.gmail.com>
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

ti, 2024-04-02 kello 14:10 -0400, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
>=20
> On Tue, Apr 2, 2024 at 12:41=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote=
:
> >=20
> > Add experimental feature that enables a SOL_BLUETOOTH socket option to
> > disable POLLERR on non-empty socket error queue.  Add corresponding MGM=
T
> > experimental feature UUID for it.
> >=20
> > This is intended to allow applications disable the POLLERR wakeups due
> > to TX timestamps, and allow upper layers of the stack to enable and
> > consume TX timestamps, without needing to complicate the lower layer
> > POLLERR handling which is only interested in real socket errors.
> >=20
> > It is a socket option disabled by default, as it enables a deviation
> > from the common net/ TX timestamping API.
> >=20
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > ---
> >  include/net/bluetooth/bluetooth.h | 12 +++-
> >  net/bluetooth/af_bluetooth.c      | 98 ++++++++++++++++++++++++++++++-
> >  net/bluetooth/iso.c               |  8 +--
> >  net/bluetooth/l2cap_sock.c        |  8 +--
> >  net/bluetooth/mgmt.c              | 63 +++++++++++++++++++-
> >  net/bluetooth/sco.c               |  8 +--
> >  6 files changed, 181 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/=
bluetooth.h
> > index c95afcd9c605..0f11b436e5b3 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -242,6 +242,8 @@ struct bt_codecs {
> >=20
> >  #define BT_ISO_BASE            20
> >=20
> > +#define BT_NO_ERRQUEUE_POLL    21
>=20
> Perhaps we should revert the logic here and have it as
> BT_POLL_ERRQUEUE which by default shall be considered enabled,

I'll change it and remove the negation in the name -> v4

> that said don't we have a race if SO_TXTIMESTAMP is send ahead it could
> enqueue events on errqueue thus triggering the socket to wake up even
> if it later sends BT_POLL_ERRQUEUE? Or that stops the wake ups
> regardless?

Setting BT_NO_ERRQUEUE_POLL disables POLLERR wakeup in subsequent
poll() also if errqueue already has items. If you are doing poll() and
in another thread set SO_TIMESTAMPING while sending data and then set
BT_NO_ERRQUEUE_POLL there can be POLLERR wakeup, but I guess this is
expected.

Idea here was that the application that enables timestamping does it in
order

	setsockopt(BT_NO_ERRQUEUE_POLL)
	setsockopt(SO_TIMESTAMPING)

IOW, BlueZ wouldn't enable any of these socket options, and leaves it
to sound server.

SO_TIMESTAMPING only affects skbs that are created after setting it.

If the flags are set as above, the racing scenario would have to be
something like:

1. T1: enter poll()
2. T2: set BT_NO_ERRQUEUE_POLL -> set_bit(BT_SK_NO_ERRQUEUE_POLL)
3. T2: set SO_TIMESTAMPING
4. T3: send() generates skb with enabled TX tstamp flag, and queues it
5. hdev->workqueue: push skb to driver, TX SCHED tstamp to errqueue
6. T1: wake up, see stale value for test_bit(BT_SK_NO_ERRQUEUE_POLL)
   but fresh value for sk->sk_error_queue content

The two setsockopt are ordered by lock_sock(),=C2=A0so if 4. generates
timestamped skb it is ordered after 2. by lock_sock(), so it looks like
6. should not be possible. (Did not think memory barriers through,
though feels unlikely when there's lock & atomics in between...)

***

The read_exp_features_info() below also needs fixup to return the new
option only for Index None -> v4

>=20
> >  __printf(1, 2)
> >  void bt_info(const char *fmt, ...);
> >  __printf(1, 2)
> > @@ -389,7 +391,8 @@ struct bt_sock {
> >  enum {
> >         BT_SK_DEFER_SETUP,
> >         BT_SK_SUSPEND,
> > -       BT_SK_PKT_STATUS
> > +       BT_SK_PKT_STATUS,
> > +       BT_SK_NO_ERRQUEUE_POLL
> >  };
> >=20
> >  struct bt_sock_list {
> > @@ -412,6 +415,10 @@ int  bt_sock_stream_recvmsg(struct socket *sock, s=
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
> > @@ -652,4 +659,7 @@ void mgmt_cleanup(struct sock *sk);
> >=20
> >  void bt_sock_reclassify_lock(struct sock *sk, int proto);
> >=20
> > +int bt_no_errqueue_poll_set_enabled(bool enabled);
> > +bool bt_no_errqueue_poll_enabled(void);
> > +
> >  #endif /* __BLUETOOTH_H */
> > diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.=
c
> > index 67604ccec2f4..cee4814f2aae 100644
> > --- a/net/bluetooth/af_bluetooth.c
> > +++ b/net/bluetooth/af_bluetooth.c
> > @@ -68,6 +68,8 @@ static const char *const bt_slock_key_strings[BT_MAX_=
PROTO] =3D {
> >         "slock-AF_BLUETOOTH-BTPROTO_ISO",
> >  };
> >=20
> > +static bool no_errqueue_poll_enabled;
> > +
> >  void bt_sock_reclassify_lock(struct sock *sk, int proto)
> >  {
> >         BUG_ON(!sk);
> > @@ -500,6 +502,26 @@ static inline __poll_t bt_accept_poll(struct sock =
*parent)
> >         return 0;
> >  }
> >=20
> > +int bt_no_errqueue_poll_set_enabled(bool enabled)
> > +{
> > +       if (enabled !=3D no_errqueue_poll_enabled) {
> > +               WRITE_ONCE(no_errqueue_poll_enabled, enabled);
> > +               return 0;
> > +       }
> > +       return 1;
> > +}
> > +
> > +bool bt_no_errqueue_poll_enabled(void)
> > +{
> > +       return READ_ONCE(no_errqueue_poll_enabled);
> > +}
> > +
> > +static bool bt_sock_error_queue_poll(struct sock *sk)
> > +{
> > +       return !test_bit(BT_SK_NO_ERRQUEUE_POLL, &bt_sk(sk)->flags) &&
> > +               !skb_queue_empty_lockless(&sk->sk_error_queue);
> > +}
> > +
> >  __poll_t bt_sock_poll(struct file *file, struct socket *sock,
> >                       poll_table *wait)
> >  {
> > @@ -511,7 +533,7 @@ __poll_t bt_sock_poll(struct file *file, struct soc=
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
> > @@ -582,6 +604,80 @@ int bt_sock_ioctl(struct socket *sock, unsigned in=
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
> > +               if (!bt_no_errqueue_poll_enabled()) {
> > +                       err =3D -ENOPROTOOPT;
> > +                       break;
> > +               }
> > +
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
> > +               if (!bt_no_errqueue_poll_enabled()) {
> > +                       err =3D -ENOPROTOOPT;
> > +                       break;
> > +               }
> > +
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
> > index 42b4495e019e..3c5cf7789d38 100644
> > --- a/net/bluetooth/iso.c
> > +++ b/net/bluetooth/iso.c
> > @@ -1602,8 +1602,8 @@ static int iso_sock_setsockopt(struct socket *soc=
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
> > @@ -1673,8 +1673,8 @@ static int iso_sock_getsockopt(struct socket *soc=
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
> > index 7846a068bf60..a0f7c1bcdec8 100644
> > --- a/net/bluetooth/l2cap_sock.c
> > +++ b/net/bluetooth/l2cap_sock.c
> > @@ -698,8 +698,8 @@ static int l2cap_sock_getsockopt(struct socket *soc=
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
> > @@ -1103,8 +1103,8 @@ static int l2cap_sock_setsockopt(struct socket *s=
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
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index 32ed6e9245a3..8f62850023a0 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -4339,6 +4339,12 @@ static const u8 mgmt_mesh_uuid[16] =3D {
> >         0x8d, 0x4d, 0x03, 0x7a, 0xd7, 0x63, 0xe4, 0x2c,
> >  };
> >=20
> > +/* 69518c4c-b69f-4679-8bc1-c021b47b5733 */
> > +static const u8 no_errqueue_poll_uuid[16] =3D {
> > +       0x33, 0x57, 0x7b, 0xb4, 0x21, 0xc0, 0xc1, 0x8b,
> > +       0x79, 0x46, 0x9f, 0xb6, 0x4c, 0x8c, 0x51, 0x69,
> > +};
> > +
> >  static int read_exp_features_info(struct sock *sk, struct hci_dev *hde=
v,
> >                                   void *data, u16 data_len)
> >  {
> > @@ -4350,8 +4356,8 @@ static int read_exp_features_info(struct sock *sk=
, struct hci_dev *hdev,
> >=20
> >         bt_dev_dbg(hdev, "sock %p", sk);
> >=20
> > -       /* Enough space for 7 features */
> > -       len =3D sizeof(*rp) + (sizeof(rp->features[0]) * 7);
> > +       /* Enough space for 8 features */
> > +       len =3D sizeof(*rp) + (sizeof(rp->features[0]) * 8);
> >         rp =3D kzalloc(len, GFP_KERNEL);
> >         if (!rp)
> >                 return -ENOMEM;
> > @@ -4429,6 +4435,11 @@ static int read_exp_features_info(struct sock *s=
k, struct hci_dev *hdev,
> >                 idx++;
> >         }
> >=20
> > +       flags =3D bt_no_errqueue_poll_enabled() ? BIT(0) : 0;
> > +       memcpy(rp->features[idx].uuid, no_errqueue_poll_uuid, 16);
> > +       rp->features[idx].flags =3D cpu_to_le32(flags);
> > +       idx++;
> > +
> >         rp->feature_count =3D cpu_to_le16(idx);
> >=20
> >         /* After reading the experimental features information, enable
> > @@ -4926,6 +4937,53 @@ static int set_iso_socket_func(struct sock *sk, =
struct hci_dev *hdev,
> >  }
> >  #endif
> >=20
> > +static int set_no_errqueue_poll_func(struct sock *sk, struct hci_dev *=
hdev,
> > +                                    struct mgmt_cp_set_exp_feature *cp=
,
> > +                                    u16 data_len)
> > +{
> > +       struct mgmt_rp_set_exp_feature rp;
> > +       bool val, changed =3D false;
> > +       int err;
> > +
> > +       /* Command requires to use the non-controller index */
> > +       if (hdev)
> > +               return mgmt_cmd_status(sk, hdev->id,
> > +                                      MGMT_OP_SET_EXP_FEATURE,
> > +                                      MGMT_STATUS_INVALID_INDEX);
> > +
> > +       /* Parameters are limited to a single octet */
> > +       if (data_len !=3D MGMT_SET_EXP_FEATURE_SIZE + 1)
> > +               return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
> > +                                      MGMT_OP_SET_EXP_FEATURE,
> > +                                      MGMT_STATUS_INVALID_PARAMS);
> > +
> > +       /* Only boolean on/off is supported */
> > +       if (cp->param[0] !=3D 0x00 && cp->param[0] !=3D 0x01)
> > +               return mgmt_cmd_status(sk, MGMT_INDEX_NONE,
> > +                                      MGMT_OP_SET_EXP_FEATURE,
> > +                                      MGMT_STATUS_INVALID_PARAMS);
> > +
> > +       val =3D cp->param[0] ? true : false;
> > +
> > +       err =3D bt_no_errqueue_poll_set_enabled(val);
> > +       if (!err)
> > +               changed =3D true;
> > +
> > +       memcpy(rp.uuid, no_errqueue_poll_uuid, 16);
> > +       rp.flags =3D cpu_to_le32(val ? BIT(0) : 0);
> > +
> > +       hci_sock_set_flag(sk, HCI_MGMT_EXP_FEATURE_EVENTS);
> > +
> > +       err =3D mgmt_cmd_complete(sk, MGMT_INDEX_NONE,
> > +                               MGMT_OP_SET_EXP_FEATURE, 0,
> > +                               &rp, sizeof(rp));
> > +
> > +       if (changed)
> > +               exp_feature_changed(hdev, no_errqueue_poll_uuid, val, s=
k);
> > +
> > +       return err;
> > +}
> > +
> >  static const struct mgmt_exp_feature {
> >         const u8 *uuid;
> >         int (*set_func)(struct sock *sk, struct hci_dev *hdev,
> > @@ -4943,6 +5001,7 @@ static const struct mgmt_exp_feature {
> >  #ifdef CONFIG_BT_LE
> >         EXP_FEAT(iso_socket_uuid, set_iso_socket_func),
> >  #endif
> > +       EXP_FEAT(no_errqueue_poll_uuid, set_no_errqueue_poll_func),
> >=20
> >         /* end with a null feature */
> >         EXP_FEAT(NULL, NULL)
> > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > index 99c2b713d826..d4697f147b5a 100644
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
> > @@ -1212,8 +1212,8 @@ static int sco_sock_getsockopt(struct socket *soc=
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

