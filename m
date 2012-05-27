Return-Path: <cyrus@holtmann.org>
Date: Sun, 27 May 2012 16:00:20 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: Re: [PATCH -v2 07/12] Bluetooth: Create DEFER_SETUP flag in
 conf_state
Message-ID: <20120527190020.GA14106@joana>
References: <1337949064-26187-1-git-send-email-gustavo@padovan.org>
 <1337949064-26187-8-git-send-email-gustavo@padovan.org>
 <1338095235.15105.103.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338095235.15105.103.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2012-05-27 07:07:15 +0200]:

> Hi Gustavo,
> 
> > Remove another socket usage from l2cap_core.c
> > 
> > Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> > ---
> >  include/net/bluetooth/l2cap.h |    1 +
> >  net/bluetooth/l2cap_core.c    |   12 ++++++------
> >  net/bluetooth/l2cap_sock.c    |    8 ++++++--
> >  3 files changed, 13 insertions(+), 8 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> > index 3b05f3e..c55b28f 100644
> > --- a/include/net/bluetooth/l2cap.h
> > +++ b/include/net/bluetooth/l2cap.h
> > @@ -599,6 +599,7 @@ enum {
> >  	CONF_LOC_CONF_PEND,
> >  	CONF_REM_CONF_PEND,
> >  	CONF_NOT_COMPLETE,
> > +	CONF_DEFER_SETUP,
> >  };
> >  
> >  #define L2CAP_CONF_MAX_CONF_REQ 2
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 01171b1..388bc70 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -569,7 +569,7 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
> >  			struct l2cap_conn_rsp rsp;
> >  			__u16 result;
> >  
> > -			if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags))
> > +			if (test_bit(CONF_DEFER_SETUP, &chan->conf_state))
> >  				result = L2CAP_CR_SEC_BLOCK;
> >  			else
> >  				result = L2CAP_CR_BAD_PSM;
> > @@ -1056,8 +1056,8 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
> >  
> >  			if (l2cap_chan_check_security(chan)) {
> >  				lock_sock(sk);
> > -				if (test_bit(BT_SK_DEFER_SETUP,
> > -					     &bt_sk(sk)->flags)) {
> > +				if (test_bit(CONF_DEFER_SETUP,
> > +					     &chan->conf_state)) {
> >  					struct sock *parent = bt_sk(sk)->parent;
> >  					rsp.result = __constant_cpu_to_le16(L2CAP_CR_PEND);
> >  					rsp.status = __constant_cpu_to_le16(L2CAP_CS_AUTHOR_PEND);
> > @@ -3376,7 +3376,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
> >  
> >  	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE) {
> >  		if (l2cap_chan_check_security(chan)) {
> > -			if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
> > +			if (test_bit(CONF_DEFER_SETUP, &chan->conf_state)) {
> >  				__l2cap_state_change(chan, BT_CONNECT2);
> >  				result = L2CAP_CR_PEND;
> >  				status = L2CAP_CS_AUTHOR_PEND;
> > @@ -5406,8 +5406,8 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
> >  			lock_sock(sk);
> >  
> >  			if (!status) {
> > -				if (test_bit(BT_SK_DEFER_SETUP,
> > -					     &bt_sk(sk)->flags)) {
> > +				if (test_bit(CONF_DEFER_SETUP,
> > +					     &chan->conf_state)) {
> >  					struct sock *parent = bt_sk(sk)->parent;
> >  					res = L2CAP_CR_PEND;
> >  					stat = L2CAP_CS_AUTHOR_PEND;
> > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > index d2d91b3..51d05a7 100644
> > --- a/net/bluetooth/l2cap_sock.c
> > +++ b/net/bluetooth/l2cap_sock.c
> > @@ -623,10 +623,14 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
> >  			break;
> >  		}
> >  
> > -		if (opt)
> > +		if (opt) {
> >  			set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
> > -		else
> > +			set_bit(CONF_DEFER_SETUP, &chan->conf_state);
> > +		} else {
> >  			clear_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
> > +			clear_bit(CONF_DEFER_SETUP, &chan->conf_state);
> > +		}
> > +
> >  		break;
> 
> and what about the lines above testing this together with BT_SECURITY?

I'm ok with those lines using BT_SK_DEFER_SETUP. CONF_DEFER_SETUP is meant for
l2cap_core.c use where we should not have access to sk.

	Gustavo
