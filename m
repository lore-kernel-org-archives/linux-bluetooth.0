Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Tue, 20 Sep 2011 13:59:36 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 3/5 v2] Bluetooth: make use sk_priority to priritize RFCOMM
 packets
Message-ID: <20110920165936.GA11558@joana>
References: <1315846853-27442-1-git-send-email-luiz.dentz@gmail.com>
 <1315846853-27442-3-git-send-email-luiz.dentz@gmail.com>
 <20110919214505.GM2643@joana>
 <1316523890.1937.101.camel@aeonflux>
 <CABBYNZJokixjJmLt2359Uz0tLZp79HMe+YswXxr7m5GL+VZn7A@mail.gmail.com>
 <1316531500.1937.106.camel@aeonflux>
 <CABBYNZ+jQ2tF2aZQgjMFgwBRAumanPZ91aDxiJWjk773Zem8yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CABBYNZ+jQ2tF2aZQgjMFgwBRAumanPZ91aDxiJWjk773Zem8yQ@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

* Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2011-09-20 19:06:30 +0300]:

> Hi Marcel,
>=20
> On Tue, Sep 20, 2011 at 6:11 PM, Marcel Holtmann <marcel@holtmann.org> wr=
ote:
> > Hi Luiz,
> >
> >> >> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >> >> > ---
> >> >> > =A0net/bluetooth/rfcomm/core.c | =A0 51 +++++++++++++++++++++++++=
++++-------------
> >> >> > =A0net/bluetooth/rfcomm/sock.c | =A0 =A02 +
> >> >> > =A02 files changed, 37 insertions(+), 16 deletions(-)
> >> >> >
> >> >> > diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/c=
ore.c
> >> >> > index 85580f2..bfc6bce 100644
> >> >> > --- a/net/bluetooth/rfcomm/core.c
> >> >> > +++ b/net/bluetooth/rfcomm/core.c
> >> >> > @@ -65,7 +65,8 @@ static DEFINE_MUTEX(rfcomm_mutex);
> >> >> >
> >> >> > =A0static LIST_HEAD(session_list);
> >> >> >
> >> >> > -static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data,=
 int len);
> >> >> > +static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data,=
 int len,
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 priority);
> >> >> > =A0static int rfcomm_send_sabm(struct rfcomm_session *s, u8 dlci);
> >> >> > =A0static int rfcomm_send_disc(struct rfcomm_session *s, u8 dlci);
> >> >> > =A0static int rfcomm_queue_disc(struct rfcomm_dlc *d);
> >> >> > @@ -747,19 +748,34 @@ void rfcomm_session_getaddr(struct rfcomm_s=
ession *s, bdaddr_t *src, bdaddr_t *d
> >> >> > =A0}
> >> >> >
> >> >> > =A0/* ---- RFCOMM frame sending ---- */
> >> >> > -static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data,=
 int len)
> >> >> > +static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data,=
 int len,
> >> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 priority)
> >> >> > =A0{
> >> >> > =A0 =A0 struct socket *sock =3D s->sock;
> >> >> > + =A0 struct sock *sk =3D sock->sk;
> >> >> > =A0 =A0 struct kvec iv =3D { data, len };
> >> >> > =A0 =A0 struct msghdr msg;
> >> >> >
> >> >> > - =A0 BT_DBG("session %p len %d", s, len);
> >> >> > + =A0 BT_DBG("session %p len %d priority %u", s, len, priority);
> >> >> > +
> >> >> > + =A0 if (sk->sk_priority !=3D priority) {
> >> >> > + =A0 =A0 =A0 =A0 =A0 lock_sock(sk);
> >> >> > + =A0 =A0 =A0 =A0 =A0 sk->sk_priority =3D priority;
> >> >> > + =A0 =A0 =A0 =A0 =A0 release_sock(sk);
> >> >> > + =A0 }
> >> >> >
> >> >> > =A0 =A0 memset(&msg, 0, sizeof(msg));
> >> >> >
> >> >> > =A0 =A0 return kernel_sendmsg(sock, &msg, &iv, 1, len);
> >> >> > =A0}
> >> >> >
> >> >> > +static int rfcomm_send_cmd(struct rfcomm_session *s, struct rfco=
mm_cmd *cmd)
> >> >> > +{
> >> >> > + =A0 BT_DBG("%p cmd %u", s, cmd->ctrl);
> >> >> > +
> >> >> > + =A0 return rfcomm_send_frame(s, (void *) cmd, sizeof(*cmd), HCI=
_PRIO_MAX);
> >> >>
> >> >>
> >> >> What's the idea here? Prioritize commands over data? But does this =
really
> >> >> happen? Because we have only one queue to receive the data in L2CAP=
=2E There
> >> >> is no separation between data and cmd there.
> >> >>
> >> >> Also, did you check if we can send RFCOMM commands and data out of =
order?
> >> >>
> >> >> I really would like to rewrite l2cap-rfcomm iteraction before addin=
g new
> >> >> features here.
> >> >
> >> > lets just forget RFCOMM for now and make SO_PRIORITY setsockopt calls
> >> > return an error code. Priority on RFCOMM links is also rather pointl=
ess
> >> > since they all go via the same L2CAP PSM anyway. You would end up
> >> > prioritizing all RFCOMM connections over any other L2CAP connection.
> >>
> >> Currently the priority is set per skb not per channel, so it is not as
> >> broken as you may think it is. Other than that you can't really ignore
> >> the priority for RFCOMM because as the priority will be not set in its
> >> skb it will be left 0 so it is low priority which for RFCOMM commands
> >> may cause problems due latency being increased (remember it not a
> >> simple fair scheduler anymore), also iirc SO_PRIORITY is not RFCOMM
> >> specific and currently no error is return.
> >
> > and we have to super careful with any sort of potential re-ordering
> > here. I rather not touch SKBs coming in from RFCOMM. They should stay as
> > they are.
>=20
> The order is kept, and Im not sure how you want the queue discipline
> to work but afaik that how other implementation handle it, by setting
> skb->priority. The other option is to have the hci_chan handling the
> priority, but that way it will just work as you assume per channel and
> that cannot support RFCOMM at all.

But in this way we will prioritize all RFCOMM channel at once, and this is =
not
the behaviour we want. It will be pointless if we all rfcomm based profiles
are updated in the priority queue at the same time.

	Gustavo
