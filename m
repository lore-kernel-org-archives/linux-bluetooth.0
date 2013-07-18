Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH v9 8/9] Bluetooth: Prevent transparent SCO on older devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1373645143-7494-9-git-send-email-frederic.dalleau@linux.intel.com>
Date: Wed, 17 Jul 2013 18:15:09 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4E1AED96-C11F-46CC-A2F0-1AB4D6E221CC@holtmann.org>
References: <1373645143-7494-1-git-send-email-frederic.dalleau@linux.intel.com> <1373645143-7494-9-git-send-email-frederic.dalleau@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Older Bluetooth devices may not support Setup Synchronous Connection or SCO
> transparent data. This is indicated by the corresponding LMP feature bits.
> It is not possible to know if the adapter support these features before setting
> BT_VOICE option since the socket is not bound to an adapter. An adapter can
> also be added after the socket is created.  The socket can be bound to an
> address before adapter is plugged in.
> 
> Thus, on a such adapters, if user request BT_VOICE_TRANSPARENT, outgoing
> connections fail on connect() and returns -EOPNOTSUPP. Incoming connections
> do not fail. However, they should only be allowed depending on what was
> specified in Write_Voice_Settings command.
> 
> Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
> ---
> net/bluetooth/sco.c |    6 ++++++
> 1 file changed, 6 insertions(+)
> 
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index 934002c..190765c 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -176,6 +176,12 @@ static int sco_connect(struct sock *sk)
> 	else
> 		type = SCO_LINK;
> 
> +	if (sco_pi(sk)->setting == BT_VOICE_TRANSPARENT &&
> +	    (!lmp_transp_capable(hdev) || !lmp_esco_capable(hdev))) {
> +		err = -ECONNABORTED;

the error message does not match the commit description. It seems you want to return EOPNOTSUPP here.

> +		goto done;
> +	}
> +
> 	hcon = hci_connect_sco(hdev, type, dst, sco_pi(sk)->setting);
> 	if (IS_ERR(hcon)) {
> 		err = PTR_ERR(hcon);

Regards

Marcel

