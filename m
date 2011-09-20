Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1316531500.1937.106.camel@aeonflux>
References: <1315846853-27442-1-git-send-email-luiz.dentz@gmail.com>
	<1315846853-27442-3-git-send-email-luiz.dentz@gmail.com>
	<20110919214505.GM2643@joana>
	<1316523890.1937.101.camel@aeonflux>
	<CABBYNZJokixjJmLt2359Uz0tLZp79HMe+YswXxr7m5GL+VZn7A@mail.gmail.com>
	<1316531500.1937.106.camel@aeonflux>
Date: Tue, 20 Sep 2011 19:06:30 +0300
Message-ID: <CABBYNZ+jQ2tF2aZQgjMFgwBRAumanPZ91aDxiJWjk773Zem8yQ@mail.gmail.com>
Subject: Re: [RFC 3/5 v2] Bluetooth: make use sk_priority to priritize RFCOMM packets
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <padovan@profusion.mobi>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Sep 20, 2011 at 6:11 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Luiz,
>
>> >> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> >> > ---
>> >> > =A0net/bluetooth/rfcomm/core.c | =A0 51 +++++++++++++++++++++++++++=
++-------------
>> >> > =A0net/bluetooth/rfcomm/sock.c | =A0 =A02 +
>> >> > =A02 files changed, 37 insertions(+), 16 deletions(-)
>> >> >
>> >> > diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/cor=
e.c
>> >> > index 85580f2..bfc6bce 100644
>> >> > --- a/net/bluetooth/rfcomm/core.c
>> >> > +++ b/net/bluetooth/rfcomm/core.c
>> >> > @@ -65,7 +65,8 @@ static DEFINE_MUTEX(rfcomm_mutex);
>> >> >
>> >> > =A0static LIST_HEAD(session_list);
>> >> >
>> >> > -static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, i=
nt len);
>> >> > +static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, i=
nt len,
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 priority);
>> >> > =A0static int rfcomm_send_sabm(struct rfcomm_session *s, u8 dlci);
>> >> > =A0static int rfcomm_send_disc(struct rfcomm_session *s, u8 dlci);
>> >> > =A0static int rfcomm_queue_disc(struct rfcomm_dlc *d);
>> >> > @@ -747,19 +748,34 @@ void rfcomm_session_getaddr(struct rfcomm_ses=
sion *s, bdaddr_t *src, bdaddr_t *d
>> >> > =A0}
>> >> >
>> >> > =A0/* ---- RFCOMM frame sending ---- */
>> >> > -static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, i=
nt len)
>> >> > +static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, i=
nt len,
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 priority)
>> >> > =A0{
>> >> > =A0 =A0 struct socket *sock =3D s->sock;
>> >> > + =A0 struct sock *sk =3D sock->sk;
>> >> > =A0 =A0 struct kvec iv =3D { data, len };
>> >> > =A0 =A0 struct msghdr msg;
>> >> >
>> >> > - =A0 BT_DBG("session %p len %d", s, len);
>> >> > + =A0 BT_DBG("session %p len %d priority %u", s, len, priority);
>> >> > +
>> >> > + =A0 if (sk->sk_priority !=3D priority) {
>> >> > + =A0 =A0 =A0 =A0 =A0 lock_sock(sk);
>> >> > + =A0 =A0 =A0 =A0 =A0 sk->sk_priority =3D priority;
>> >> > + =A0 =A0 =A0 =A0 =A0 release_sock(sk);
>> >> > + =A0 }
>> >> >
>> >> > =A0 =A0 memset(&msg, 0, sizeof(msg));
>> >> >
>> >> > =A0 =A0 return kernel_sendmsg(sock, &msg, &iv, 1, len);
>> >> > =A0}
>> >> >
>> >> > +static int rfcomm_send_cmd(struct rfcomm_session *s, struct rfcomm=
_cmd *cmd)
>> >> > +{
>> >> > + =A0 BT_DBG("%p cmd %u", s, cmd->ctrl);
>> >> > +
>> >> > + =A0 return rfcomm_send_frame(s, (void *) cmd, sizeof(*cmd), HCI_P=
RIO_MAX);
>> >>
>> >>
>> >> What's the idea here? Prioritize commands over data? But does this re=
ally
>> >> happen? Because we have only one queue to receive the data in L2CAP. =
There
>> >> is no separation between data and cmd there.
>> >>
>> >> Also, did you check if we can send RFCOMM commands and data out of or=
der?
>> >>
>> >> I really would like to rewrite l2cap-rfcomm iteraction before adding =
new
>> >> features here.
>> >
>> > lets just forget RFCOMM for now and make SO_PRIORITY setsockopt calls
>> > return an error code. Priority on RFCOMM links is also rather pointles=
s
>> > since they all go via the same L2CAP PSM anyway. You would end up
>> > prioritizing all RFCOMM connections over any other L2CAP connection.
>>
>> Currently the priority is set per skb not per channel, so it is not as
>> broken as you may think it is. Other than that you can't really ignore
>> the priority for RFCOMM because as the priority will be not set in its
>> skb it will be left 0 so it is low priority which for RFCOMM commands
>> may cause problems due latency being increased (remember it not a
>> simple fair scheduler anymore), also iirc SO_PRIORITY is not RFCOMM
>> specific and currently no error is return.
>
> and we have to super careful with any sort of potential re-ordering
> here. I rather not touch SKBs coming in from RFCOMM. They should stay as
> they are.

The order is kept, and Im not sure how you want the queue discipline
to work but afaik that how other implementation handle it, by setting
skb->priority. The other option is to have the hci_chan handling the
priority, but that way it will just work as you assume per channel and
that cannot support RFCOMM at all.

>> > So if you try to prioritize HFP then you also prioritize PBAP in the e=
nd
>> > and we are back where we started. We could implement the 27.007 priori=
ty
>> > support inside RFCOMM, but that seems even more pointless endeavor.
>>
>> That is not the way it work, take a look at rfcomm_send_frame:
>>
>> + =A0 =A0 =A0 if (sk->sk_priority !=3D priority) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 lock_sock(sk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sk->sk_priority =3D priority;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_sock(sk);
>> + =A0 =A0 =A0 }
>>
>> This is suppose to dynamically updates the priority if it changes.
>
> As I said above, I rather not mess with this. Keep the RFCOMM stream as
> it is. L2CAP priority is essentially something different than RFCOMM
> priority. And I do not wanna go there right now.

Ordering is not a problem here just latency of commands, so the
messing is the other way round, if we don't prioritize the commands
its latency is messed.

>> > What we really want is prioritized L2CAP links and hopefully in the
>> > future everything moves over to use L2CAP directly anyway and RFCOMM
>> > will be slowly dying out.
>>
>> The problem here is not really RFCOMM as for L2CAP we also give
>> maximum priority to commands to avoid latency problems, this is
>> specially important when connecting because it will page but if either
>> L2CAP or RFCOMM commands are not properly prioritized they may timeout
>> so all the paging is wasted, btw this was very easy to emulate with
>> hid+a2dp then try to connect anything else.
>
> As pointed our earlier, we have to be really careful to not reorder
> command wrongly. If that happens we have a serious problem with the
> overall system.

Let me try to be clear, there is no reordering in the channel, it
continue to be a FIFO but it is now one for each channel not one per
connection and Im fine to skip this patch but Im not sure if you guys
really understand what I was trying to solve with it.

--=20
Luiz Augusto von Dentz
