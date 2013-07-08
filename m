Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH v8 8/8] Bluetooth: Prevent transparent SCO on older devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1373036503-1349-9-git-send-email-frederic.dalleau@linux.intel.com>
Date: Mon, 8 Jul 2013 12:25:32 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <2F173411-4542-47EE-8DF5-65D21856ADAF@holtmann.org>
References: <1373036503-1349-1-git-send-email-frederic.dalleau@linux.intel.com> <1373036503-1349-9-git-send-email-frederic.dalleau@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Older Bluetooth devices may not support Setup Synchronous Connection. This is
> indicated by the eSCO support feature bit. It is not possible to know if the
> adapter support eSCO before setting BT_VOICE option since the socket is not
> bound to an adapter. An adapter can also be added after the socket is created.
> The socket can be bound to an address before adapter is plugged in.
> 
> Thus, on a such adapters, if user requested something else than
> BT_VOICE_CVSD_16BIT, outgoing connections fail on connect() and returns
> -ECONNABORTED. Incoming connections do not fail. However, they should only be
> allowed depending on what was specified in Write_Voice_Settings command.
> 
> Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
> ---
> net/bluetooth/sco.c |    5 +++++
> 1 file changed, 5 insertions(+)
> 
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index 546b7f6..02a602e 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -176,6 +176,11 @@ static int sco_connect(struct sock *sk)
> 	else
> 		type = SCO_LINK;
> 
> +	if (type == SCO_LINK && sco_pi(sk)->setting != BT_VOICE_CVSD_16BIT) {
> +		err = -ECONNABORTED;
> +		goto done;
> +	}
> +

we should check for eSCO and transparent SCO support. We do need both. And we also need to figure out on how to handle the incoming situation correctly,

Is the error ECONNABORTED a correct one.

Regards

Marcel

