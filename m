Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC 3/5 v2] Bluetooth: make use sk_priority to priritize
 RFCOMM packets
From: Marcel Holtmann <marcel@holtmann.org>
To: Gustavo Padovan <padovan@profusion.mobi>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Date: Tue, 20 Sep 2011 15:04:49 +0200
In-Reply-To: <20110919214505.GM2643@joana>
References: <1315846853-27442-1-git-send-email-luiz.dentz@gmail.com>
	 <1315846853-27442-3-git-send-email-luiz.dentz@gmail.com>
	 <20110919214505.GM2643@joana>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316523890.1937.101.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  net/bluetooth/rfcomm/core.c |   51 +++++++++++++++++++++++++++++-------------
> >  net/bluetooth/rfcomm/sock.c |    2 +
> >  2 files changed, 37 insertions(+), 16 deletions(-)
> > 
> > diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> > index 85580f2..bfc6bce 100644
> > --- a/net/bluetooth/rfcomm/core.c
> > +++ b/net/bluetooth/rfcomm/core.c
> > @@ -65,7 +65,8 @@ static DEFINE_MUTEX(rfcomm_mutex);
> >  
> >  static LIST_HEAD(session_list);
> >  
> > -static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, int len);
> > +static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, int len,
> > +							u32 priority);
> >  static int rfcomm_send_sabm(struct rfcomm_session *s, u8 dlci);
> >  static int rfcomm_send_disc(struct rfcomm_session *s, u8 dlci);
> >  static int rfcomm_queue_disc(struct rfcomm_dlc *d);
> > @@ -747,19 +748,34 @@ void rfcomm_session_getaddr(struct rfcomm_session *s, bdaddr_t *src, bdaddr_t *d
> >  }
> >  
> >  /* ---- RFCOMM frame sending ---- */
> > -static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, int len)
> > +static int rfcomm_send_frame(struct rfcomm_session *s, u8 *data, int len,
> > +							u32 priority)
> >  {
> >  	struct socket *sock = s->sock;
> > +	struct sock *sk = sock->sk;
> >  	struct kvec iv = { data, len };
> >  	struct msghdr msg;
> >  
> > -	BT_DBG("session %p len %d", s, len);
> > +	BT_DBG("session %p len %d priority %u", s, len, priority);
> > +
> > +	if (sk->sk_priority != priority) {
> > +		lock_sock(sk);
> > +		sk->sk_priority = priority;
> > +		release_sock(sk);
> > +	}
> >  
> >  	memset(&msg, 0, sizeof(msg));
> >  
> >  	return kernel_sendmsg(sock, &msg, &iv, 1, len);
> >  }
> >  
> > +static int rfcomm_send_cmd(struct rfcomm_session *s, struct rfcomm_cmd *cmd)
> > +{
> > +	BT_DBG("%p cmd %u", s, cmd->ctrl);
> > +
> > +	return rfcomm_send_frame(s, (void *) cmd, sizeof(*cmd), HCI_PRIO_MAX);
> 
> 
> What's the idea here? Prioritize commands over data? But does this really
> happen? Because we have only one queue to receive the data in L2CAP. There
> is no separation between data and cmd there.
> 
> Also, did you check if we can send RFCOMM commands and data out of order?
> 
> I really would like to rewrite l2cap-rfcomm iteraction before adding new
> features here.

lets just forget RFCOMM for now and make SO_PRIORITY setsockopt calls
return an error code. Priority on RFCOMM links is also rather pointless
since they all go via the same L2CAP PSM anyway. You would end up
prioritizing all RFCOMM connections over any other L2CAP connection.

So if you try to prioritize HFP then you also prioritize PBAP in the end
and we are back where we started. We could implement the 27.007 priority
support inside RFCOMM, but that seems even more pointless endeavor.

What we really want is prioritized L2CAP links and hopefully in the
future everything moves over to use L2CAP directly anyway and RFCOMM
will be slowly dying out.

Regards

Marcel


