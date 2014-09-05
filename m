Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Sep 2014 15:47:40 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 5/7] Bluetooth: Fix locking of the SMP context
Message-ID: <20140905124740.GA30842@t440s.lan>
References: <1409920838-30242-1-git-send-email-johan.hedberg@gmail.com>
 <1409920838-30242-6-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1409920838-30242-6-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Sep 05, 2014, johan.hedberg@gmail.com wrote:
> @@ -1192,12 +1195,19 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
>  		if (smp_ltk_encrypt(conn, hcon->pending_sec_level))
>  			return 0;
>  
> -	if (test_and_set_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags))
> -		return 0;
> +	l2cap_chan_lock(chan);
> +
> +	/* If SMP is already in progress ignore this request */
> +	if (chan->data) {
> +		ret = 0;
> +		goto unlock;
> +	}
>  
>  	smp = smp_chan_create(conn);
> -	if (!smp)
> -		return 1;
> +	if (!smp) {
> +		ret = 1;
> +		goto unlock;
> +	}
>  
>  	authreq = seclevel_to_authreq(sec_level);
>  
> @@ -1223,8 +1233,11 @@ int smp_conn_security(struct hci_conn *hcon, __u8 sec_level)
>  	}
>  
>  	set_bit(SMP_FLAG_INITIATOR, &smp->flags);
> +	ret = 0;
>  
> -	return 0;
> +unlock:
> +	l2cap_chan_unlock(conn->smp);
> +	return ret;

Seems something didn't go quite right with my rebasing skills and this
fix dropped out from the mix. I'll send another revision of this patch.

Johan
