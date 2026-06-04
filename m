Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16C3326D51
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588382; cv=none; b=PXm6bjzjSDlVdeqWbltc0m9FKBWLisjdVTmBX6AoRqek0Z0FMQP84lwQ/ivEMm5+xNax5KeURaQBMo6R8cVo56uWB0tUwxLTD0HHHVGoZ2ybVk/9Z2YVrgGk2bxAUzoVoX3tO+uQUD+5MTqIWcY4CiJ62ScsSVXcGuy+SzO0hUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588382; c=relaxed/simple;
	bh=Uqu/39NmdRixgonhqmWwIFIMGnq21wdpiXPNnK4szR4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ctHJ6lyxCSahNyb5AaqF2iXRHdN77uXUIi5wb+WWmzAwQTwT1J/cU/ojDBCeU5Ob26B6HqQt+ZBw0Vt2R3gaMd1I9/PxebYFGO5IHoioonzYU0yq3xYw8k+5AqfjOcZmiKGzAZp5s4ft/zxUYj+ODjNZHM9GqJ6Md2QadpVKdwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=KD09O+oN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jjo/w8dM; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="KD09O+oN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jjo/w8dM"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 02688EC01CC;
	Thu,  4 Jun 2026 11:52:59 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Thu, 04 Jun 2026 11:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780588378;
	 x=1780674778; bh=qM4+L44EF3fnqZXm6B+ZohVsdVQaQJLYGPmQ0Y6gCyY=; b=
	KD09O+oNCyatJJ1ifVoKZkEs9Asa51kfb550x0wyAlGCesEPtrM9TWiSh0ghl0yL
	bCvj9mv+qB3fHRVLFGinfqJY8Qae1tsXL6hLLxYxMDhSbgUYB6aT4lAxm96+6pQV
	Si6U/5QZBzEvKU2qonjye7VTqgBr1b0M9rRaWNo0fVH0eISZwxMPBP7yzHFE5vJ6
	tXKpCXtUscIWdskDnOH2LmeDVd20qGhixVK6UlOXdTgRf2Ba4HUv4ga8pVY2lhm8
	1rr2HqRgBa4PY1sL1Vb01wbXqLZu1o39I7Qw7ae6v4zXTKdjq0wc7f14GTQMPwSF
	IiWjZtNaJXhd4vE3FZhakQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780588378; x=
	1780674778; bh=qM4+L44EF3fnqZXm6B+ZohVsdVQaQJLYGPmQ0Y6gCyY=; b=J
	jo/w8dMw/DyhdsmzoKtpKN3Gjhc6zA8unClaY/aI9blvwpOR5yzMh+hdqkEFQvq4
	b/r4wfXKvavpFMYAhrfd49aBKJ0CwmWK0orVw9LmPLAaD5bGOQ/esGdyXXmrSIT3
	s7uyNiAsVbtMISt40QcSrmtjWX76jsYNh6xd8nwJCZQKNsobKF7qQkwCWC+p7D9Q
	FBc4wlU8/YkVVldiV2gd0k1AmvnW4xz+jzuVBciAQwD1ciEpsNTibye69zomhMhy
	+vepgyKoMEiq2ONHo/gvgD1f3vYLmcAEGp9IOjPkpgmR6ESluOWDLThQk0rQsrQD
	biGn2iLCFovQgPIot+rdw==
X-ME-Sender: <xms:Wp8harszg86vvYUb8Ot8WfHHYdHjnWEPvuE5BuSz7qARu-r_HSLyzA>
    <xme:Wp8hanTcSYSimkfUhbdTdGqrmggUMtcnenHG_azptg3pljDCuOXps5YYU7hjbrtOP
    Abk1i6AmvUpWkmCEWmjzfY46Tk6HR6mVHrxJqYXN0gD0PTYuWavA6o>
X-ME-Proxy-Cause: dmFkZTE9qSh412wQtFDPlT/WkhQYum9Vsk410WMR1DZRsDNGIPqH4AL9tyLa88gAueq/xz
    kM6ppTGwmIOBHSLIfJJHwPKBrEmkiY9aRNHC3RhMeYvowz8ZeV4Qu/P7bR+3PUi4EWZP3H
    BXutZAXOPgORjc3ZXYo34XBTT1NbBfCvDnWNKH/x9QkcciBuO5BOHGkcFgEVQFFoF5qTE5
    iqADWbSiNMnLaEfOFgRO54VvEEPUkYQln5s/ecyoAr94Gjvs8U46cL27wt3PCo1J+u38qj
    FED8CZIWQAuInwKI3BfnU1IgRZ8G9qghOm9d0Qa/Z9tQuAPRgIDyPWsjJyfRkOwMrJ7Afl
    K4HU3NXTVFKBMjTBjUkjbYjSgNhPsfPkW26zjnrV3CQ9KnHrwmIwGjv9+qj8gDriZcZPeD
    XXjqeLLKuL9gcqYidtsy+b5AOa7DJvy9tTFl011PWnr7MDBcZwta0BOq9roPrbUq582/oW
    wJJU8ok1pV5kuLvJfUOLyRc53EtI2GbZ2LRqfNr0AU6dVwJOkJ5x5oKG80kY8vh9jJKLAu
    4nsqjwEz25j8JK51p6OHQBtcCoupHzulHB8wCFXLevfu/CJVEYfiT/j0nVThf3o1ltJ3Qr
    uhb0bDKaLP6L1ErY1a+rjeQkNogykCdWSX2kXkYYKkCXrdD2m0p2V/qRHXYw
X-ME-Proxy: <xmx:Wp8haqb_vQGo1zT9AeXwYAo8esrLEl65zDXmFbuClmsIdmGp4i52ww>
    <xmx:Wp8harVGdzokVjSkKhjeumwmfIXQtMx4IxDD2JWBMQJ8QrTQ2pnP6w>
    <xmx:Wp8hasg28hyF--lhzq98m6_-QWePj_yVgHDEcYBwpmf-VmUiNc_VgA>
    <xmx:Wp8hapXuUH4YlglrV-ykhVQvbuaCVFyBDQufZb66ximx0m20FdO3dQ>
    <xmx:Wp8hasA1cBKF_5yZmYvObI264AHReve3bbrvl6oZ70wWqY30Nf5ez707>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B9BAE216008A; Thu,  4 Jun 2026 11:52:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ark7h5MHViQF
Date: Thu, 04 Jun 2026 11:52:38 -0400
From: "Siwei Zhang" <oss@fourdim.xyz>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <d01691b5-1651-4399-9208-b845dfeffb9c@app.fastmail.com>
In-Reply-To: 
 <CABBYNZ+zZCTDqoJo4X9oqo-8gGkEXv6-Y=50oU-CVXmTztAsAA@mail.gmail.com>
References: <20260603150835.3539963-1-oss@fourdim.xyz>
 <20260603150835.3539963-2-oss@fourdim.xyz>
 <CABBYNZ+zZCTDqoJo4X9oqo-8gGkEXv6-Y=50oU-CVXmTztAsAA@mail.gmail.com>
Subject: Re: [PATCH v9 1/1] Bluetooth: L2CAP: Fix use-after-free in
 l2cap_sock_new_connection_cb()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Wed, Jun 3, 2026, at 2:17 PM, Luiz Augusto von Dentz wrote:
> Hi Siwei,
>
> On Wed, Jun 3, 2026 at 11:09=E2=80=AFAM Siwei Zhang <oss@fourdim.xyz> =
wrote:
>>
>> l2cap_sock_new_connection_cb() accesses l2cap_pi(sk)->chan after
>> release_sock(parent). Once the parent lock is released, the child
>> socket sk can be freed by another task.
>>
>> Allocate the channel outside the func to prevent this.
>>
>> Fixes: 8ffb929098a5 ("Bluetooth: Remove parent socket usage from l2ca=
p_core.c")
>> Cc: stable@kernel.org
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
>> ---
>>  include/net/bluetooth/l2cap.h | 10 +++--
>>  net/bluetooth/6lowpan.c       | 31 +++++++------
>>  net/bluetooth/l2cap_core.c    | 41 ++++++++++++-----
>>  net/bluetooth/l2cap_sock.c    | 83 +++++++++++++++++++++------------=
--
>>  net/bluetooth/smp.c           | 17 ++++---
>>  5 files changed, 113 insertions(+), 69 deletions(-)
>>
>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2=
cap.h
>> index e0a1f2293679..7f5e4647f6e0 100644
>> --- a/include/net/bluetooth/l2cap.h
>> +++ b/include/net/bluetooth/l2cap.h
>> @@ -620,7 +620,9 @@ struct l2cap_chan {
>>  struct l2cap_ops {
>>         char                    *name;
>>
>> -       struct l2cap_chan       *(*new_connection) (struct l2cap_chan=
 *chan);
>> +       int                     (*new_connection)(struct l2cap_conn *=
conn,
>> +                                                 struct l2cap_chan *=
chan,
>> +                                                 struct l2cap_chan *=
new_chan);
>>         int                     (*recv) (struct l2cap_chan * chan,
>>                                          struct sk_buff *skb);
>>         void                    (*teardown) (struct l2cap_chan *chan,=
 int err);
>> @@ -884,9 +886,11 @@ static inline __u16 __next_seq(struct l2cap_chan=
 *chan, __u16 seq)
>>         return (seq + 1) % (chan->tx_win_max + 1);
>>  }
>>
>> -static inline struct l2cap_chan *l2cap_chan_no_new_connection(struct=
 l2cap_chan *chan)
>> +static inline int l2cap_chan_no_new_connection(struct l2cap_conn *co=
nn,
>> +                                              struct l2cap_chan *cha=
n,
>> +                                              struct l2cap_chan *new=
_chan)
>>  {
>> -       return NULL;
>> +       return -EOPNOTSUPP;
>>  }
>>
>>  static inline int l2cap_chan_no_recv(struct l2cap_chan *chan, struct=
 sk_buff *skb)
>> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
>> index cb1e329d66fd..94863af97a44 100644
>> --- a/net/bluetooth/6lowpan.c
>> +++ b/net/bluetooth/6lowpan.c
>> @@ -624,6 +624,15 @@ static bool is_bt_6lowpan(struct hci_conn *hcon)
>>         return true;
>>  }
>>
>> +static void chan_init(struct l2cap_chan *chan)
>> +{
>> +       l2cap_chan_set_defaults(chan);
>> +
>> +       chan->chan_type =3D L2CAP_CHAN_CONN_ORIENTED;
>> +       chan->mode =3D L2CAP_MODE_LE_FLOWCTL;
>> +       chan->imtu =3D 1280;
>> +}
>> +
>>  static struct l2cap_chan *chan_create(void)
>>  {
>>         struct l2cap_chan *chan;
>> @@ -632,11 +641,7 @@ static struct l2cap_chan *chan_create(void)
>>         if (!chan)
>>                 return NULL;
>>
>> -       l2cap_chan_set_defaults(chan);
>> -
>> -       chan->chan_type =3D L2CAP_CHAN_CONN_ORIENTED;
>> -       chan->mode =3D L2CAP_MODE_LE_FLOWCTL;
>> -       chan->imtu =3D 1280;
>> +       chan_init(chan);
>>
>>         return chan;
>>  }
>> @@ -745,19 +750,19 @@ static inline void chan_ready_cb(struct l2cap_c=
han *chan)
>>         ifup(dev->netdev);
>>  }
>>
>> -static inline struct l2cap_chan *chan_new_conn_cb(struct l2cap_chan =
*pchan)
>> +static inline int chan_new_conn_cb(struct l2cap_conn *conn,
>> +                                  struct l2cap_chan *pchan,
>> +                                  struct l2cap_chan *chan)
>>  {
>> -       struct l2cap_chan *chan;
>> -
>> -       chan =3D chan_create();
>> -       if (!chan)
>> -               return NULL;
>> -
>> +       chan_init(chan);
>>         chan->ops =3D pchan->ops;
>>
>> +       /* Take the conn list reference; see l2cap_new_connection(). =
*/
>> +       __l2cap_chan_add(conn, chan);
>> +
>>         BT_DBG("chan %p pchan %p", chan, pchan);
>>
>> -       return chan;
>> +       return 0;
>>  }
>>
>>  static void unregister_dev(struct lowpan_btle_dev *dev)
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index c4ccfbda9d78..62acf90837fb 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -4007,6 +4007,31 @@ static inline int l2cap_command_rej(struct l2c=
ap_conn *conn,
>>         return 0;
>>  }
>>
>> +/* Allocate and initialise a channel for an incoming connection.
>> + *
>> + * ->new_connection() initialises the channel and links it into @con=
n with
>> + * __l2cap_chan_add(). The l2cap_chan_create() reference becomes the=
 one owned
>> + * by the parent subsystem (l2cap_pi(sk)->chan, conn->smp or peer->c=
han) and is
>> + * released by its teardown callback; the conn list reference is rel=
eased by
>> + * l2cap_chan_del().
>> + */
>> +static struct l2cap_chan *l2cap_new_connection(struct l2cap_conn *co=
nn,
>> +                                              struct l2cap_chan *pch=
an)
>> +{
>> +       struct l2cap_chan *chan;
>> +
>> +       chan =3D l2cap_chan_create();
>> +       if (!chan)
>> +               return NULL;
>> +
>> +       if (pchan->ops->new_connection(conn, pchan, chan) < 0) {
>> +               l2cap_chan_put(chan);
>> +               return NULL;
>> +       }
>
> I don't quite get why we can't just place __l2cap_chan_add here
> instead of having it called by new_connection callbacks?
>

It's specifically the l2cap_sock_new_connection_cb() case - the very
use-after-free this patch fixes. The __l2cap_chan_add() has to happen wh=
ile
the parent lock is still held, and only the callback holds that lock.

The reference counting on the new child chan starts at one ref,=20
owned by the new socket:

	/* l2cap_new_connection() */
	chan =3D l2cap_chan_create();		/* refcount =3D 1 */
	if (!chan)
		return NULL;

	pchan->ops->new_connection(conn, pchan, chan);

and inside the socket callback:

	/* l2cap_sock_new_connection_cb() */
	lock_sock(parent);
	...
	sk =3D l2cap_sock_alloc(..., new_chan);	/* sk owns the chan_create ref =
*/
	...
	l2cap_sock_init(sk, parent);

	__l2cap_chan_add(conn, new_chan);	/* (A) conn list takes a ref */
	bt_accept_enqueue(parent, sk, false);	/* (B) sk now on accept queue */

	release_sock(parent);			/* (C) parent lock dropped */
	return 0;

The moment we hit (C), sk is reachable through the parent's accept queue=
, so
another task can grab and tear it down:

	accept() -> l2cap_sock_kill() -> l2cap_sock_put_chan()
		chan->data =3D NULL;
		l2cap_chan_put(chan);		/* drops the sk's chan ref */

If __l2cap_chan_add() at (A) hadn't already taken the conn list referenc=
e,
that put would drop the last ref and free new_chan. Control then returns=
 up
to l2cap_new_connection(), which hands the now-freed chan back to
l2cap_connect():

	/* l2cap_connect() - runs after the callback returns */
	chan =3D l2cap_new_connection(conn, pchan);
	if (!chan)
		goto response;
	...
	bacpy(&chan->src, &conn->hcon->src);	/* <-- UAF on freed chan */
	chan->psm  =3D psm;
	chan->dcid =3D scid;

The conn list reference taken at (A), before (C), is what keeps new_chan
alive across the release_sock() window so l2cap_connect() can keep using=
 it.

So __l2cap_chan_add() can't move out to l2cap_new_connection(): by the t=
ime
the callback returns, the parent lock is already dropped and chan may al=
ready
be freed - which is exactly the race. It has to be taken inside the call=
back,
under the parent lock, before the socket is exposed.

The other callbacks (6lowpan, smp) have no equivalent lock-drop window.
 I kept __l2cap_chan_add() inside all of the ->new_connection() callbacks
just to keep the "callback links the channel into conn" contract uniform.

>> +
>> +       return chan;
>> +}
>> +
>>  static void l2cap_connect(struct l2cap_conn *conn, struct l2cap_cmd_=
hdr *cmd,
>>                           u8 *data, u8 rsp_code)
>>  {
>> @@ -4053,7 +4078,7 @@ static void l2cap_connect(struct l2cap_conn *co=
nn, struct l2cap_cmd_hdr *cmd,
>>                 goto response;
>>         }
>>
>> -       chan =3D pchan->ops->new_connection(pchan);
>> +       chan =3D l2cap_new_connection(conn, pchan);
>>         if (!chan)
>>                 goto response;
>>
>> @@ -4071,8 +4096,6 @@ static void l2cap_connect(struct l2cap_conn *co=
nn, struct l2cap_cmd_hdr *cmd,
>>         chan->psm  =3D psm;
>>         chan->dcid =3D scid;
>>
>> -       __l2cap_chan_add(conn, chan);
>> -
>>         dcid =3D chan->scid;
>>
>>         __set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
>> @@ -4955,7 +4978,7 @@ static int l2cap_le_connect_req(struct l2cap_co=
nn *conn,
>>                 goto response_unlock;
>>         }
>>
>> -       chan =3D pchan->ops->new_connection(pchan);
>> +       chan =3D l2cap_new_connection(conn, pchan);
>>         if (!chan) {
>>                 result =3D L2CAP_CR_LE_NO_MEM;
>>                 goto response_unlock;
>> @@ -4970,8 +4993,6 @@ static int l2cap_le_connect_req(struct l2cap_co=
nn *conn,
>>         chan->omtu =3D mtu;
>>         chan->remote_mps =3D mps;
>>
>> -       __l2cap_chan_add(conn, chan);
>> -
>>         l2cap_le_flowctl_init(chan, __le16_to_cpu(req->credits));
>>
>>         dcid =3D chan->scid;
>> @@ -5179,7 +5200,7 @@ static inline int l2cap_ecred_conn_req(struct l=
2cap_conn *conn,
>>                         continue;
>>                 }
>>
>> -               chan =3D pchan->ops->new_connection(pchan);
>> +               chan =3D l2cap_new_connection(conn, pchan);
>>                 if (!chan) {
>>                         result =3D L2CAP_CR_LE_NO_MEM;
>>                         continue;
>> @@ -5194,8 +5215,6 @@ static inline int l2cap_ecred_conn_req(struct l=
2cap_conn *conn,
>>                 chan->omtu =3D mtu;
>>                 chan->remote_mps =3D mps;
>>
>> -               __l2cap_chan_add(conn, chan);
>> -
>>                 l2cap_ecred_init(chan, __le16_to_cpu(req->credits));
>>
>>                 /* Init response */
>> @@ -7470,14 +7489,12 @@ static void l2cap_connect_cfm(struct hci_conn=
 *hcon, u8 status)
>>                         goto next;
>>
>>                 l2cap_chan_lock(pchan);
>> -               chan =3D pchan->ops->new_connection(pchan);
>> +               chan =3D l2cap_new_connection(conn, pchan);
>>                 if (chan) {
>>                         bacpy(&chan->src, &hcon->src);
>>                         bacpy(&chan->dst, &hcon->dst);
>>                         chan->src_type =3D bdaddr_src_type(hcon);
>>                         chan->dst_type =3D dst_type;
>> -
>> -                       __l2cap_chan_add(conn, chan);
>>                 }
>>
>>                 l2cap_chan_unlock(pchan);
>> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
>> index 025329636353..87f4c0db5c0c 100644
>> --- a/net/bluetooth/l2cap_sock.c
>> +++ b/net/bluetooth/l2cap_sock.c
>> @@ -46,7 +46,8 @@ static struct bt_sock_list l2cap_sk_list =3D {
>>  static const struct proto_ops l2cap_sock_ops;
>>  static void l2cap_sock_init(struct sock *sk, struct sock *parent);
>>  static struct sock *l2cap_sock_alloc(struct net *net, struct socket =
*sock,
>> -                                    int proto, gfp_t prio, int kern);
>> +                                    int proto, gfp_t prio, int kern,
>> +                                    struct l2cap_chan *chan);
>>  static void l2cap_sock_cleanup_listen(struct sock *parent);
>>
>>  bool l2cap_is_socket(struct socket *sock)
>> @@ -1287,6 +1288,23 @@ static int l2cap_sock_recvmsg(struct socket *s=
ock, struct msghdr *msg,
>>         return err;
>>  }
>>
>> +/* Release the sock's ref on chan and clear the pointer so that the =
ref is
>> + * dropped exactly once even if both l2cap_sock_kill() and
>> + * l2cap_sock_destruct() run. Setting chan->data to NULL first stops=
 any other
>> + * task from dereferencing the now-dead sock pointer.
>> + */
>> +static void l2cap_sock_put_chan(struct sock *sk)
>> +{
>> +       struct l2cap_chan *chan =3D l2cap_pi(sk)->chan;
>> +
>> +       if (!chan)
>> +               return;
>> +
>> +       chan->data =3D NULL;
>> +       l2cap_pi(sk)->chan =3D NULL;
>> +       l2cap_chan_put(chan);
>> +}
>> +
>>  /* Kill socket (only if zapped and orphan)
>>   * Must be called on unlocked socket, with l2cap channel lock.
>>   */
>> @@ -1297,13 +1315,9 @@ static void l2cap_sock_kill(struct sock *sk)
>>
>>         BT_DBG("sk %p state %s", sk, state_to_string(sk->sk_state));
>>
>> -       /* Sock is dead, so set chan data to NULL, avoid other task u=
se invalid
>> -        * sock pointer.
>> -        */
>> -       l2cap_pi(sk)->chan->data =3D NULL;
>> -       /* Kill poor orphan */
>> +       l2cap_sock_put_chan(sk);
>>
>> -       l2cap_chan_put(l2cap_pi(sk)->chan);
>> +       /* Kill poor orphan */
>>         sock_set_flag(sk, SOCK_DEAD);
>>         sock_put(sk);
>>  }
>> @@ -1546,12 +1560,14 @@ static void l2cap_sock_cleanup_listen(struct =
sock *parent)
>>         }
>>  }
>>
>> -static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_=
chan *chan)
>> +static int l2cap_sock_new_connection_cb(struct l2cap_conn *conn,
>> +                                       struct l2cap_chan *chan,
>> +                                       struct l2cap_chan *new_chan)
>>  {
>>         struct sock *sk, *parent =3D chan->data;
>>
>>         if (!parent)
>> -               return NULL;
>> +               return -EINVAL;
>>
>>         lock_sock(parent);
>>
>> @@ -1559,25 +1575,33 @@ static struct l2cap_chan *l2cap_sock_new_conn=
ection_cb(struct l2cap_chan *chan)
>>         if (sk_acceptq_is_full(parent)) {
>>                 BT_DBG("backlog full %d", parent->sk_ack_backlog);
>>                 release_sock(parent);
>> -               return NULL;
>> +               return -ENOBUFS;
>>         }
>>
>>         sk =3D l2cap_sock_alloc(sock_net(parent), NULL, BTPROTO_L2CAP,
>> -                             GFP_ATOMIC, 0);
>> +                             GFP_ATOMIC, 0, new_chan);
>>         if (!sk) {
>>                 release_sock(parent);
>> -               return NULL;
>> -        }
>> +               return -ENOMEM;
>> +       }
>>
>>         bt_sock_reclassify_lock(sk, BTPROTO_L2CAP);
>>
>>         l2cap_sock_init(sk, parent);
>>
>> +       /* Link the channel into conn before exposing the new socket =
via the
>> +        * accept queue. Once release_sock() below drops the parent l=
ock the
>> +        * socket may be freed by another task, dropping its referenc=
e on
>> +        * new_chan; the conn list reference taken here keeps new_cha=
n alive so
>> +        * the caller can safely use it after ->new_connection() retu=
rns.
>> +        */
>> +       __l2cap_chan_add(conn, new_chan);
>> +
>>         bt_accept_enqueue(parent, sk, false);
>>
>>         release_sock(parent);
>>
>> -       return l2cap_pi(sk)->chan;
>> +       return 0;
>>  }
>>
>>  static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buf=
f *skb)
>> @@ -1874,10 +1898,7 @@ static void l2cap_sock_destruct(struct sock *s=
k)
>>
>>         BT_DBG("sk %p", sk);
>>
>> -       if (l2cap_pi(sk)->chan) {
>> -               l2cap_pi(sk)->chan->data =3D NULL;
>> -               l2cap_chan_put(l2cap_pi(sk)->chan);
>> -       }
>> +       l2cap_sock_put_chan(sk);
>>
>>         list_for_each_entry_safe(rx_busy, next, &l2cap_pi(sk)->rx_bus=
y, list) {
>>                 kfree_skb(rx_busy->skb);
>> @@ -1978,10 +1999,10 @@ static struct proto l2cap_proto =3D {
>>  };
>>
>>  static struct sock *l2cap_sock_alloc(struct net *net, struct socket =
*sock,
>> -                                    int proto, gfp_t prio, int kern)
>> +                                    int proto, gfp_t prio, int kern,
>> +                                    struct l2cap_chan *chan)
>>  {
>>         struct sock *sk;
>> -       struct l2cap_chan *chan;
>>
>>         sk =3D bt_sock_alloc(net, sock, &l2cap_proto, proto, prio, ke=
rn);
>>         if (!sk)
>> @@ -1992,16 +2013,7 @@ static struct sock *l2cap_sock_alloc(struct ne=
t *net, struct socket *sock,
>>
>>         INIT_LIST_HEAD(&l2cap_pi(sk)->rx_busy);
>>
>> -       chan =3D l2cap_chan_create();
>> -       if (!chan) {
>> -               sk_free(sk);
>> -               if (sock)
>> -                       sock->sk =3D NULL;
>> -               return NULL;
>> -       }
>> -
>> -       l2cap_chan_hold(chan);
>> -
>> +       /* The sock takes ownership of the caller's reference on chan=
. */
>>         l2cap_pi(sk)->chan =3D chan;
>>
>>         return sk;
>> @@ -2011,6 +2023,7 @@ static int l2cap_sock_create(struct net *net, s=
truct socket *sock, int protocol,
>>                              int kern)
>>  {
>>         struct sock *sk;
>> +       struct l2cap_chan *chan;
>>
>>         BT_DBG("sock %p", sock);
>>
>> @@ -2025,10 +2038,16 @@ static int l2cap_sock_create(struct net *net,=
 struct socket *sock, int protocol,
>>
>>         sock->ops =3D &l2cap_sock_ops;
>>
>> -       sk =3D l2cap_sock_alloc(net, sock, protocol, GFP_ATOMIC, kern=
);
>> -       if (!sk)
>> +       chan =3D l2cap_chan_create();
>> +       if (!chan)
>>                 return -ENOMEM;
>>
>> +       sk =3D l2cap_sock_alloc(net, sock, protocol, GFP_ATOMIC, kern=
, chan);
>> +       if (!sk) {
>> +               l2cap_chan_put(chan);
>> +               return -ENOMEM;
>> +       }
>> +
>>         l2cap_sock_init(sk, NULL);
>>         bt_sock_link(&l2cap_sk_list, sk);
>>         return 0;
>> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
>> index 1739c1989dbd..2d31c3c7bbc0 100644
>> --- a/net/bluetooth/smp.c
>> +++ b/net/bluetooth/smp.c
>> @@ -3204,16 +3204,12 @@ static const struct l2cap_ops smp_chan_ops =3D=
 {
>>         .get_sndtimeo           =3D l2cap_chan_no_get_sndtimeo,
>>  };
>>
>> -static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *=
pchan)
>> +static inline int smp_new_conn_cb(struct l2cap_conn *conn,
>> +                                 struct l2cap_chan *pchan,
>> +                                 struct l2cap_chan *chan)
>>  {
>> -       struct l2cap_chan *chan;
>> -
>>         BT_DBG("pchan %p", pchan);
>>
>> -       chan =3D l2cap_chan_create();
>> -       if (!chan)
>> -               return NULL;
>> -
>>         chan->chan_type =3D pchan->chan_type;
>>         chan->ops       =3D &smp_chan_ops;
>>         chan->scid      =3D pchan->scid;
>> @@ -3229,9 +3225,12 @@ static inline struct l2cap_chan *smp_new_conn_=
cb(struct l2cap_chan *pchan)
>>          */
>>         atomic_set(&chan->nesting, L2CAP_NESTING_SMP);
>>
>> -       BT_DBG("created chan %p", chan);
>> +       /* Take the conn list reference; see l2cap_new_connection(). =
*/
>> +       __l2cap_chan_add(conn, chan);
>>
>> -       return chan;
>> +       BT_DBG("initialised chan %p", chan);
>> +
>> +       return 0;
>>  }
>>
>>  static const struct l2cap_ops smp_root_chan_ops =3D {
>> --
>> 2.54.0
>>
>
>
> --=20
> Luiz Augusto von Dentz

Best,
Siwei
