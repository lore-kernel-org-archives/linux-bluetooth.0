Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1316523890.1937.101.camel@aeonflux>
References: <1315846853-27442-1-git-send-email-luiz.dentz@gmail.com>
	<1315846853-27442-3-git-send-email-luiz.dentz@gmail.com>
	<20110919214505.GM2643@joana>
	<1316523890.1937.101.camel@aeonflux>
Date: Tue, 20 Sep 2011 17:34:02 +0300
Message-ID: <CABBYNZJokixjJmLt2359Uz0tLZp79HMe+YswXxr7m5GL+VZn7A@mail.gmail.com>
Subject: Re: [RFC 3/5 v2] Bluetooth: make use sk_priority to priritize RFCOMM packets
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <padovan@profusion.mobi>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Sep 20, 2011 at 4:04 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Gustavo,
>
>> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> > ---
>> > =A0net/bluetooth/rfcomm/core.c | =A0 51 +++++++++++++++++++++++++++++-=
------------
>> > =A0net/bluetooth/rfcomm/sock.c | =A0 =A02 +
>> > =A02 files changed, 37 insertions(+), 16 deletions(-)
>> >
>> > diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
>> > index 85580f2..bfc6bce 100644
>> > --- a/net/bluetooth/rfcomm/core.c
>> > +++ b/net/bluetooth/rfcomm/core.c
>> > @@ -65,7 +65,8 @@ static DEFINE_MUTEX(rfcomm_mutex);
>> >
>> > =A0static LIST_HEAD(session_list);
>> >
>> > -static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, int =
len);
>> > +static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, int =
len,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 priority);
>> > =A0static int rfcomm_send_sabm(struct rfcomm_session *s, u8 dlci);
>> > =A0static int rfcomm_send_disc(struct rfcomm_session *s, u8 dlci);
>> > =A0static int rfcomm_queue_disc(struct rfcomm_dlc *d);
>> > @@ -747,19 +748,34 @@ void rfcomm_session_getaddr(struct rfcomm_sessio=
n *s, bdaddr_t *src, bdaddr_t *d
>> > =A0}
>> >
>> > =A0/* ---- RFCOMM frame sending ---- */
>> > -static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, int =
len)
>> > +static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, int =
len,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 priority)
>> > =A0{
>> > =A0 =A0 struct socket *sock =3D s->sock;
>> > + =A0 struct sock *sk =3D sock->sk;
>> > =A0 =A0 struct kvec iv =3D { data, len };
>> > =A0 =A0 struct msghdr msg;
>> >
>> > - =A0 BT_DBG("session %p len %d", s, len);
>> > + =A0 BT_DBG("session %p len %d priority %u", s, len, priority);
>> > +
>> > + =A0 if (sk->sk_priority !=3D priority) {
>> > + =A0 =A0 =A0 =A0 =A0 lock_sock(sk);
>> > + =A0 =A0 =A0 =A0 =A0 sk->sk_priority =3D priority;
>> > + =A0 =A0 =A0 =A0 =A0 release_sock(sk);
>> > + =A0 }
>> >
>> > =A0 =A0 memset(&msg, 0, sizeof(msg));
>> >
>> > =A0 =A0 return kernel_sendmsg(sock, &msg, &iv, 1, len);
>> > =A0}
>> >
>> > +static int rfcomm_send_cmd(struct rfcomm_session *s, struct rfcomm_cm=
d *cmd)
>> > +{
>> > + =A0 BT_DBG("%p cmd %u", s, cmd->ctrl);
>> > +
>> > + =A0 return rfcomm_send_frame(s, (void *) cmd, sizeof(*cmd), HCI_PRIO=
_MAX);
>>
>>
>> What's the idea here? Prioritize commands over data? But does this reall=
y
>> happen? Because we have only one queue to receive the data in L2CAP. The=
re
>> is no separation between data and cmd there.
>>
>> Also, did you check if we can send RFCOMM commands and data out of order=
?
>>
>> I really would like to rewrite l2cap-rfcomm iteraction before adding new
>> features here.
>
> lets just forget RFCOMM for now and make SO_PRIORITY setsockopt calls
> return an error code. Priority on RFCOMM links is also rather pointless
> since they all go via the same L2CAP PSM anyway. You would end up
> prioritizing all RFCOMM connections over any other L2CAP connection.

Currently the priority is set per skb not per channel, so it is not as
broken as you may think it is. Other than that you can't really ignore
the priority for RFCOMM because as the priority will be not set in its
skb it will be left 0 so it is low priority which for RFCOMM commands
may cause problems due latency being increased (remember it not a
simple fair scheduler anymore), also iirc SO_PRIORITY is not RFCOMM
specific and currently no error is return.

> So if you try to prioritize HFP then you also prioritize PBAP in the end
> and we are back where we started. We could implement the 27.007 priority
> support inside RFCOMM, but that seems even more pointless endeavor.

That is not the way it work, take a look at rfcomm_send_frame:

+       if (sk->sk_priority !=3D priority) {
+               lock_sock(sk);
+               sk->sk_priority =3D priority;
+               release_sock(sk);
+       }

This is suppose to dynamically updates the priority if it changes.

> What we really want is prioritized L2CAP links and hopefully in the
> future everything moves over to use L2CAP directly anyway and RFCOMM
> will be slowly dying out.

The problem here is not really RFCOMM as for L2CAP we also give
maximum priority to commands to avoid latency problems, this is
specially important when connecting because it will page but if either
L2CAP or RFCOMM commands are not properly prioritized they may timeout
so all the paging is wasted, btw this was very easy to emulate with
hid+a2dp then try to connect anything else.

--=20
Luiz Augusto von Dentz
