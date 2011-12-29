Return-Path: <cyrus@holtmann.org>
Date: Thu, 29 Dec 2011 13:23:36 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv2 01/20] Bluetooth: A2MP: Create A2MP socket
Message-ID: <20111229112334.GA3821@aemeltch-MOBL1>
References: <1324551986-29431-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1324551986-29431-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1324574296.1965.217.camel@aeonflux>
 <20111222181240.GF2730@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111222181240.GF2730@joana>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel, Gustavo,

On Thu, Dec 22, 2011 at 04:12:40PM -0200, Gustavo Padovan wrote:
...
> > > +static struct socket *open_a2mp_sock(struct l2cap_conn *conn)
> > > +{
> > > +	int err;
> > > +	struct socket *sock;
> > > +	struct sockaddr_l2 addr;
> > > +	struct sock *sk;
> > > +
> > > +	err = sock_create_kern(PF_BLUETOOTH, SOCK_SEQPACKET,
> > > +					BTPROTO_L2CAP, &sock);
> > > +	if (err) {
> > > +		BT_ERR("sock_create_kern failed %d", err);
> > > +		return NULL;
> > > +	}
> > > +
> > > +	sk = sock->sk;
> > > +	memset(&addr, 0, sizeof(addr));
> > > +	bacpy(&addr.l2_bdaddr, conn->src);
> > > +	addr.l2_family = AF_BLUETOOTH;
> > > +	addr.l2_cid = L2CAP_CID_A2MP;
> > > +	err = kernel_bind(sock, (struct sockaddr *) &addr, sizeof(addr));
> > > +	if (err) {
> > > +		BT_ERR("kernel_bind failed %d", err);
> > > +		sock_release(sock);
> > > +		return NULL;
> > > +	}
> > > +
> > > +	l2cap_fixed_channel_config(sk);
> > > +
> > > +	memset(&addr, 0, sizeof(addr));
> > > +	bacpy(&addr.l2_bdaddr, conn->dst);
> > > +	addr.l2_family = AF_BLUETOOTH;
> > > +	addr.l2_cid = L2CAP_CID_A2MP;
> > > +	err = kernel_connect(sock, (struct sockaddr *) &addr, sizeof(addr),
> > > +							O_NONBLOCK);
> > > +	if ((err == 0) || (err == -EINPROGRESS))
> > > +		return sock;
> > > +	else {
> > > +		BT_ERR("kernel_connect failed %d", err);
> > > +		sock_release(sock);
> > > +		return NULL;
> > > +	}
> > > +}
> > 
> > And now I am confused. So either we use the socket inside the kernel
> > directly or we make internal calls to L2CAP. However this looks like a
> > really weird mix between we do whatever we please.
> > 
> > If this is has a long term plan that I am not away, I like to see these
> > parts properly commented in the code. Otherwise we end up in a disaster
> > area later on.
> 
> We can also understand this as another call to create a proper way to access
> L2CAP inside the kernel. A big part of the work to create such interface is
> done, though the hardest part was left to the final.

The main idea is to use existing code to handle L2CAP fixed channel
without L2CAP channel initialization (Connect Req/Rsp, ...). The amount of
code change is really small.

The other patch "[RFCv2 19/20] Bluetooth: A2MP: Handling fixed channel"
continues this idea.

Do you think that approach is a bit hackish? 

Best regards 
Andrei Emeltchenko 

> We could go L2CAP and fix this first and then create clean A2DP right from the
> beginning.
> 
> 	Gustavo
