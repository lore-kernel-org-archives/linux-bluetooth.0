Return-Path: <cyrus@holtmann.org>
Message-ID: <1337358645.2058.4.camel@aeonflux>
Subject: Re: [PATCH 1/2] Bluetooth: Use defined link key size
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 18 May 2012 09:30:45 -0700
In-Reply-To: <1337350806-20326-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1337350806-20326-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Remove magic number with defined link key size. This is especially
> useful for calculation other keys which are 2 * key_size, etc that
> makes usage of magic numbers too much.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/bluetooth.h |    2 ++
>  include/net/bluetooth/hci.h       |    4 ++--
>  include/net/bluetooth/hci_core.h  |    2 +-
>  net/bluetooth/hci_core.c          |    2 +-
>  net/bluetooth/hci_event.c         |    2 +-
>  net/bluetooth/mgmt.c              |    2 +-
>  6 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 961669b..4abedfe 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -68,6 +68,8 @@ struct bt_security {
>  #define BT_SECURITY_MEDIUM	2
>  #define BT_SECURITY_HIGH	3
>  
> +#define BT_SEC_LINK_KEY_SIZE		16
> +

where is the _SEC_ part of this coming from? Any reason for it? And why
is it defined in the middle of socket options? Seems the absolute wrong
place for this.

>  #define BT_DEFER_SETUP	7
>  
>  #define BT_FLUSHABLE	8
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 66a7b57..6ab8d0b 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -371,7 +371,7 @@ struct hci_cp_reject_conn_req {
>  #define HCI_OP_LINK_KEY_REPLY		0x040b
>  struct hci_cp_link_key_reply {
>  	bdaddr_t bdaddr;
> -	__u8     link_key[16];
> +	__u8     link_key[BT_SEC_LINK_KEY_SIZE];
>  } __packed;

Putting it in hci.h with HCI_LINK_KEY_SIZE seems more reasonable. Or do
you have other plans for this constant?

Regards

Marcel


