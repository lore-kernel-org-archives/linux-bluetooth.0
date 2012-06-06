Return-Path: <cyrus@holtmann.org>
Date: Wed, 6 Jun 2012 13:44:00 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Fix deadlock and crash when SMP pairing
 times out
Message-ID: <20120606164400.GA11387@samus>
References: <1338979451-15851-1-git-send-email-johan.hedberg@gmail.com>
 <1338979451-15851-2-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338979451-15851-2-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 18:44 Wed 06 Jun, Johan Hedberg wrote:
> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> The l2cap_conn_del function tries to cancel_sync the security timer, but
> when it's called from the timeout function itself a deadlock occurs.
> Subsequently the "hcon->l2cap_data = NULL" that's supposed to protect
> multiple calls to l2cap_conn_del never gets cleared and when the
> connection finally drops we double free's etc which will crash the
> kernel.

I wonder if (inside l2cap_conn_del()) we move "hcon->l2cap_data = NULL"
up in the function, probably next to the check for "!conn", would be a
safer alternative.

> 
> This patch fixes the issue by using the HCI_CONN_LE_SMP_PEND for
> protecting against this. The same flag is also used for the same purpose
> in other places in the SMP code.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/l2cap_core.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index f9bffe3..4ca8824 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1314,7 +1314,12 @@ static void security_timeout(struct work_struct *work)
>  	struct l2cap_conn *conn = container_of(work, struct l2cap_conn,
>  						security_timer.work);
>  
> -	l2cap_conn_del(conn->hcon, ETIMEDOUT);
> +	BT_DBG("conn %p", conn);
> +
> +	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags)) {
> +		smp_chan_destroy(conn);
> +		l2cap_conn_del(conn->hcon, ETIMEDOUT);
> +	}
>  }
>  
>  static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
> -- 
> 1.7.10
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
