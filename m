Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 1/6] Bluetooth: Add HCI_RSSI_INVALID for unknown RSSI value
Date: Thu, 04 Dec 2014 10:59:27 +0100
Message-ID: <2879632.J5o8eFvCrV@uw000953>
In-Reply-To: <1417684441-103825-1-git-send-email-marcel@holtmann.org>
References: <1417684441-103825-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thursday 04 of December 2014 10:13:56 Marcel Holtmann wrote:
> The Bluetooth core specification defines the value 127 as invalid for
> RSSI values. So instead of hard coding it, lets add a constant for it.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 569c077778b6..b6f7be1eb919 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -412,6 +412,7 @@ enum {
>  
>  /* The core spec defines 127 as the "not available" value */
>  #define HCI_TX_POWER_INVALID	127
> +#define HCI_RSSI_INVALID	127

Isn't that value depending on command, event, link and controller type?

>  
>  #define HCI_ROLE_MASTER		0x00
>  #define HCI_ROLE_SLAVE		0x01
> 

-- 
Best regards, 
Szymon Janc
