Return-Path: <cyrus@holtmann.org>
Date: Wed, 4 Dec 2013 14:15:48 -0200
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 19/31] Bluetooth: Implement returning of LE L2CAP credits
Message-ID: <20131204161548.GB2210@molly.amr.corp.intel.com>
References: <1386166287-13693-1-git-send-email-johan.hedberg@gmail.com>
 <1386166287-13693-20-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386166287-13693-20-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 16:11 Wed 04 Dec, Johan Hedberg wrote:
> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> We should return credits to the remote side whenever they fall below a
> certain level (in our case under half of the initially given amount).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/l2cap_core.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 8a1c528908fb..b99bdc53c57b 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -2542,8 +2542,10 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
>  	}
>  
>  	switch (chan->mode) {
> -	case L2CAP_MODE_BASIC:
>  	case L2CAP_MODE_LE_FLOWCTL:
> +		chan->tx_credits--;
> +		/* fall through */

I guess that this change makes more sense in the next commit, no?

> +	case L2CAP_MODE_BASIC:
>  		/* Check outgoing MTU */
>  		if (len > chan->omtu)
>  			return -EMSGSIZE;
> @@ -6608,6 +6610,32 @@ drop:
>  	return 0;
>  }
>  


Cheers,
-- 
Vinicius
