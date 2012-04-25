Return-Path: <cyrus@holtmann.org>
Message-ID: <1335336358.16897.409.camel@aeonflux>
Subject: Re: [PATCH 4/8] Bluetooth: Add address type to struct sockaddr_l2
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 25 Apr 2012 08:45:58 +0200
In-Reply-To: <1335312176-21306-5-git-send-email-andre.guedes@openbossa.org>
References: <1335312176-21306-1-git-send-email-andre.guedes@openbossa.org>
	 <1335312176-21306-5-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds the address type info to struct sockaddr_l2 so
> user-space can inform the remote device address type required
> to establish LE connections.
> 
> Soon, instead of looking the advertising cache up to discover the
> address type, we'll use this address type info to establish LE
> connections.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/l2cap.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 0fac788..95741da 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -57,6 +57,7 @@ struct sockaddr_l2 {
>  	__le16		l2_psm;
>  	bdaddr_t	l2_bdaddr;
>  	__le16		l2_cid;
> +	__u8		l2_bdaddr_type;
>  };

I am warming up to this naming. Does anybody have any objections?

Regards

Marcel


