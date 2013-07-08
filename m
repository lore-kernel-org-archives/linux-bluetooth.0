Return-Path: <cyrus@holtmann.org>
Date: Sun, 7 Jul 2013 23:33:09 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Dalleau
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v8 8/8] Bluetooth: Prevent transparent SCO on older
 devices
Message-ID: <20130708023309.GA31844@echo>
References: <1373036503-1349-1-git-send-email-frederic.dalleau@linux.intel.com>
 <1373036503-1349-9-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1373036503-1349-9-git-send-email-frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On 17:01 Fri 05 Jul, Frédéric Dalleau wrote:
> Older Bluetooth devices may not support Setup Synchronous Connection. This is
> indicated by the eSCO support feature bit. It is not possible to know if the
> adapter support eSCO before setting BT_VOICE option since the socket is not
> bound to an adapter. An adapter can also be added after the socket is created.
> The socket can be bound to an address before adapter is plugged in.

I remember seeing a couple of 2.0 controllers that have Transparent SCO
feature bit set but don't have support for eSCO. 

I wonder if it would be better to use Setup Synchronous Connection if
transparent SCO is needed (and the controller supports it).

Another problem is in the accepting side, we are using Add SCO if the
controller doesn't support eSCO, this fails (IIRC Invalid LMP Parameters 
or somehing) if the other side has requested a SCO link expecting
transparent SCO data.

> 
> Thus, on a such adapters, if user requested something else than
> BT_VOICE_CVSD_16BIT, outgoing connections fail on connect() and returns
> -ECONNABORTED. Incoming connections do not fail. However, they should only be
> allowed depending on what was specified in Write_Voice_Settings command.
> 
> Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
> ---
>  net/bluetooth/sco.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index 546b7f6..02a602e 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -176,6 +176,11 @@ static int sco_connect(struct sock *sk)
>  	else
>  		type = SCO_LINK;
>  
> +	if (type == SCO_LINK && sco_pi(sk)->setting != BT_VOICE_CVSD_16BIT) {
> +		err = -ECONNABORTED;
> +		goto done;
> +	}
> +
>  	hcon = hci_connect_sco(hdev, type, dst, sco_pi(sk)->setting);
>  	if (IS_ERR(hcon)) {
>  		err = PTR_ERR(hcon);
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
