Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 May 2012 14:09:37 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [RFC 2/3] Bluetooth: Move bt_accept_enqueue() call to
 l2cap_sock.c
Message-ID: <20120524170937.GH3105@joana>
References: <1337821964-4618-9-git-send-email-gustavo@padovan.org>
 <1337839374-20443-1-git-send-email-gustavo@padovan.org>
 <1337839374-20443-2-git-send-email-gustavo@padovan.org>
 <20120524092425.GH24715@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120524092425.GH24715@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com> [2012-05-24 12:24:26 +0300]:

> Hi Gustavo,
> 
> On Thu, May 24, 2012 at 03:02:53AM -0300, Gustavo Padovan wrote:
> > From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> > 
> > bt_accept_enqueue() can be easily placed at the end of
> > l2cap_sock_new_connection_cb().
> > 
> > Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> > ---
> >  net/bluetooth/l2cap_core.c |    4 ----
> >  net/bluetooth/l2cap_sock.c |    2 ++
> >  2 files changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index c9de4f5..5ff294f9 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -1165,8 +1165,6 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
> >  	bacpy(&bt_sk(sk)->src, conn->src);
> >  	bacpy(&bt_sk(sk)->dst, conn->dst);
> >  
> > -	bt_accept_enqueue(parent, sk);
> > -
> 
> Shall we also move to l2cap_sock_new_connection_cb bacpys above?

I don't think so, bacpy and bacmp are used everywhere, they need to fixed
differently.

	Gustavo
