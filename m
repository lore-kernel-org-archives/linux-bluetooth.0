Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 May 2012 02:13:57 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: notify userspace of security level change
Message-ID: <20120507051356.GA7564@joana>
References: <1336096794-16993-1-git-send-email-gustavo@padovan.org>
 <1336320446.5970.80.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336320446.5970.80.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2012-05-06 09:07:26 -0700]:

> Hi Gustavo,
> 
> > When the userspace request a security level change it needs to be notified
> > of when the change is complete.
> > This patch make the socket non writable while the security request is
> > ongoing. If it succeeds POLL_OUT is emitted, otherwise the channel is
> > disconnected.
> > 
> > Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
> > ---
> >  include/net/bluetooth/bluetooth.h |    1 +
> >  net/bluetooth/af_bluetooth.c      |    2 +-
> >  net/bluetooth/hci_event.c         |    7 +++++++
> >  net/bluetooth/l2cap_core.c        |    5 +++++
> >  net/bluetooth/l2cap_sock.c        |   10 +++++-----
> >  5 files changed, 19 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> > index 2fb268f..4e750df 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -195,6 +195,7 @@ struct bt_sock {
> >  	struct list_head accept_q;
> >  	struct sock *parent;
> >  	u32 defer_setup;
> > +	bool  suspended;
> 
> you have double spaces here. Please pay attention.

My bad, I let this pass.

> 
> >  };
> >  
> >  struct bt_sock_list {
> > diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> > index 72eb187..6fb68a9 100644
> > --- a/net/bluetooth/af_bluetooth.c
> > +++ b/net/bluetooth/af_bluetooth.c
> > @@ -450,7 +450,7 @@ unsigned int bt_sock_poll(struct file *file, struct socket *sock, poll_table *wa
> >  			sk->sk_state == BT_CONFIG)
> >  		return mask;
> >  
> > -	if (sock_writeable(sk))
> > +	if (!bt_sk(sk)->suspended && sock_writeable(sk))
> >  		mask |= POLLOUT | POLLWRNORM | POLLWRBAND;
> >  	else
> >  		set_bit(SOCK_ASYNC_NOSPACE, &sk->sk_socket->flags);
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 507fcec..86f74f6 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -2062,6 +2062,12 @@ static inline void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *
> >  
> >  		clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
> >  
> > +		if (ev->status && conn->state == BT_CONNECTED) {
> > +			hci_acl_disconn(conn, 0x13);
> > +			hci_conn_put(conn);
> > +			goto unlock;
> > +		}
> > +
> >  		if (conn->state == BT_CONFIG) {
> >  			if (!ev->status)
> >  				conn->state = BT_CONNECTED;
> > @@ -2072,6 +2078,7 @@ static inline void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *
> >  			hci_encrypt_cfm(conn, ev->status, ev->encrypt);
> >  	}
> >  
> > +unlock:
> >  	hci_dev_unlock(hdev);
> >  }
> >  
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 0f2b1be..67053f8 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -4884,6 +4884,11 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
> >  
> >  		if (!status && (chan->state == BT_CONNECTED ||
> >  						chan->state == BT_CONFIG)) {
> 
> You do know that this one will be showing up in Dave's coding style
> complaint. You might wanna fix this with a pre-patch first.

Code style fixes are not suitable for 3.4-rc6, I don't we have a problem here.

> 
> > +			struct sock *sk = chan->sk;
> > +
> > +			bt_sk(sk)->suspended = false;
> > +			sk->sk_state_change(sk);
> > +
> >  			l2cap_check_encryption(chan, encrypt);
> >  			l2cap_chan_unlock(chan);
> >  			continue;
> > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > index 82b6368..7e3386f 100644
> > --- a/net/bluetooth/l2cap_sock.c
> > +++ b/net/bluetooth/l2cap_sock.c
> > @@ -596,12 +596,12 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
> >  			sk->sk_state = BT_CONFIG;
> >  			chan->state = BT_CONFIG;
> >  
> > -		/* or for ACL link, under defer_setup time */
> > -		} else if (sk->sk_state == BT_CONNECT2 &&
> > -					bt_sk(sk)->defer_setup) {
> > -			err = l2cap_chan_check_security(chan);
> > +		/* or for ACL link */
> >  		} else {
> > -			err = -EINVAL;
> > +			if (!l2cap_chan_check_security(chan))
> > +				bt_sk(sk)->suspended = true;
> > +			else
> > +				sk->sk_state_change(sk);
> >  		}
> >  		break;
> 
> Why is this change correct? You are changing this from applying to only
> incoming connections (CONNECT2) to also outgoing connections (CONNECT).

It wrong, what I want here actually is:

 ((sk->sk_state == BT_CONNECT2 && bt_sk(sk)->defer_setup) ||
  sk->sk_state == BT_CONNECTED)

 We need to allow connected links to increase the security level too.

	Gustavo
