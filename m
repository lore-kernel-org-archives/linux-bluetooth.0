Return-Path: <cyrus@holtmann.org>
Message-ID: <1329472180.28848.167.camel@aeonflux>
Subject: Re: [PATCHv2 1/3] Bluetooth: Move scope of state_to_string
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 17 Feb 2012 10:49:40 +0100
In-Reply-To: <1329471657-18278-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1329471657-18278-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1329471657-18278-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Function state_to_string will be used in other files in debug
> statements.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/bluetooth.h |   27 +++++++++++++++++++++++++++
>  net/bluetooth/l2cap_core.c        |   26 --------------------------
>  2 files changed, 27 insertions(+), 26 deletions(-)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 4a82ca0..0a47c20 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -129,6 +129,33 @@ enum {
>  	BT_CLOSED
>  };
>  
> +/* If unused will be removed by compiler */
> +static inline char *state_to_string(int state)
> +{

actually const char * please.

> +	switch (state) {
> +	case BT_CONNECTED:
> +		return "BT_CONNECTED";
> +	case BT_OPEN:
> +		return "BT_OPEN";
> +	case BT_BOUND:
> +		return "BT_BOUND";
> +	case BT_LISTEN:
> +		return "BT_LISTEN";
> +	case BT_CONNECT:
> +		return "BT_CONNECT";
> +	case BT_CONNECT2:
> +		return "BT_CONNECT2";
> +	case BT_CONFIG:
> +		return "BT_CONFIG";
> +	case BT_DISCONN:
> +		return "BT_DISCONN";
> +	case BT_CLOSED:
> +		return "BT_CLOSED";
> +	}
> +
> +	return "invalid state";
> +}
> +

Otherwise it is fine.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


