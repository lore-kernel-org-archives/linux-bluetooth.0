Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 Jun 2014 15:20:55 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Allow change security level on ATT_CID in
 slave role
Message-ID: <20140613122055.GA11990@t440s.lan>
References: <1402661302-26674-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1402661302-26674-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Fri, Jun 13, 2014, Marcin Kraglak wrote:
> Kernel supports SMP Security Request so don't block increasing security
> when we are slave.
> 
> Signed-off-by: Marcin Kraglak <marcin.kraglak@tieto.com>
> ---
>  net/bluetooth/l2cap_sock.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 6ab2822..55215eb 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -787,11 +787,6 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
>  
>  		/*change security for LE channels */
>  		if (chan->scid == L2CAP_CID_ATT) {
> -			if (!conn->hcon->out) {
> -				err = -EINVAL;
> -				break;
> -			}
> -
>  			if (smp_conn_security(conn->hcon, sec.level))
>  				break;
>  			sk->sk_state = BT_CONFIG;

Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Though this could potentially have used a bit more verbose description.
The code in question seems to originate from the early days of SMP where
we probably didn't yet have fully functioning slave-role support. Now
it's there and calls to smp_conn_security() as slave should just do the
right thing.

Johan
