Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Dec 2010 19:08:14 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org,
	Anderson Briglia <anderson.briglia@openbossa.org>
Subject: Re: [RFC v2 3/9] Bluetooth: Start SMP procedure
Message-ID: <20101207220814.GF4797@eris>
References: <1291671832-13435-1-git-send-email-vinicius.gomes@openbossa.org>
 <1291671832-13435-4-git-send-email-vinicius.gomes@openbossa.org>
 <20101207161109.GD2944@vigoh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20101207161109.GD2944@vigoh>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On 14:11 Tue 07 Dec, Gustavo F. Padovan wrote:
> Hi Vinicius,
> 
> * Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2010-12-06 18:43:46 -0300]:
> 
> > From: Anderson Briglia <anderson.briglia@openbossa.org>
> > 
> > Start SMP procedure for LE connections. This modification intercepts l2cap
> > received frames and call proper SMP functions to start the SMP procedure. By
> > now, no keys are being used.
> > 
> > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> > Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
> > ---
> >  net/bluetooth/l2cap_core.c |    7 +++++++
> >  net/bluetooth/smp.c        |    2 +-
> >  2 files changed, 8 insertions(+), 1 deletions(-)
> > 
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 69e5f80..674799c 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -54,6 +54,7 @@
> >  #include <net/bluetooth/bluetooth.h>
> >  #include <net/bluetooth/hci_core.h>
> >  #include <net/bluetooth/l2cap.h>
> > +#include <net/bluetooth/smp.h>
> >  
> >  #define VERSION "2.15"
> >  
> > @@ -642,6 +643,8 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
> >  			l2cap_sock_clear_timer(sk);
> >  			sk->sk_state = BT_CONNECTED;
> >  			sk->sk_state_change(sk);
> > +			if (smp_conn_security(conn, l2cap_pi(sk)->sec_level))
> > +				BT_DBG("Insufficient security");
> >  		}
> >  
> >  		if (sk->sk_type != SOCK_SEQPACKET &&
> > @@ -4626,6 +4629,10 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
> >  		l2cap_conless_channel(conn, psm, skb);
> >  		break;
> >  
> > +	case L2CAP_CID_SMP:
> > +		smp_sig_channel(conn, skb);
> > +		break;
> > +
> >  	default:
> >  		l2cap_data_channel(conn, cid, skb);
> >  		break;
> > diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> > index e427d11..e9dde5f 100644
> > --- a/net/bluetooth/smp.c
> > +++ b/net/bluetooth/smp.c
> > @@ -86,7 +86,7 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
> >  		return 1;
> >  	}
> >  
> > -	if (conn->hcon->link_mode & HCI_LM_MASTER) {
> > +	if (conn->hcon->out) {
> 
> This change should not belong to this patch.
> 

My bad. Will fix.

> -- 
> Gustavo F. Padovan
> http://profusion.mobi

Cheers,
-- 
Vinicius
