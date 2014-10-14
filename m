Return-Path: <cyrus@holtmann.org>
Message-ID: <1413275501.2705.110.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH bluetooth] Bluetooth: Fix missing channel unlock in
 l2cap_le_credits
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Martin Townsend <mtownsend1973@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	johan.hedberg@gmail.com
Date: Tue, 14 Oct 2014 11:31:41 +0300
In-Reply-To: <1413224685-3700-1-git-send-email-mtownsend1973@gmail.com>
References: <1413224685-3700-1-git-send-email-mtownsend1973@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On ma, 2014-10-13 at 19:24 +0100, Martin Townsend wrote:
> In the error case where credits is greater than max_credits there
> is a missing l2cap_chan_unlock before returning.
> 
> Signed-off-by: Martin Townsend <mtownsend1973@gmail.com>
> ---
>  net/bluetooth/l2cap_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 46547b9..bfb6af8 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -5544,6 +5544,7 @@ static inline int l2cap_le_credits(struct l2cap_conn *conn,
>  	if (credits > max_credits) {
>  		BT_ERR("LE credits overflow");
>  		l2cap_send_disconn_req(chan, ECONNRESET);
> +		l2cap_chan_unlock(chan);
>  
>  		/* Return 0 so that we don't trigger an unnecessary
>  		 * command reject packet.

I did some testing with this patch and although it did not fix the
inconsistent lock issue I am seeing, it did fix the mutex hang. I have
two locking issue and this patch fixed the other one.

Tested-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>


Cheers,
Jukka
