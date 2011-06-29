Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Add mgmt command for fast connectable mode
From: Marcel Holtmann <marcel@holtmann.org>
To: Antti Julku <antti.julku@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 28 Jun 2011 17:58:09 -0700
In-Reply-To: <1308737516-3303-1-git-send-email-antti.julku@nokia.com>
References: <1308737516-3303-1-git-send-email-antti.julku@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1309309092.2208.25.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antti,

> Add command to management interface for enabling/disabling the
> fast connectable mode.
> 
> Signed-off-by: Antti Julku <antti.julku@nokia.com>
> ---
>  include/net/bluetooth/hci.h  |   10 +++++++
>  include/net/bluetooth/mgmt.h |    5 +++
>  net/bluetooth/mgmt.c         |   60 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 75 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 65345cd..d7b9600 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -698,6 +698,16 @@ struct hci_rp_read_bd_addr {
>  	bdaddr_t bdaddr;
>  } __packed;
>  
> +#define HCI_OP_WRITE_PAGE_SCAN_ACTIVITY	0x0c1c
> +struct hci_cp_write_page_scan_activity {
> +	__le16   interval;
> +	__le16   window;
> +} __packed;
> +
> +#define HCI_OP_WRITE_PAGE_SCAN_TYPE	0x0c47
> +	#define PAGE_SCAN_TYPE_STANDARD		0x00
> +	#define PAGE_SCAN_TYPE_INTERLACED	0x01
> +
>  #define HCI_OP_LE_SET_EVENT_MASK	0x2001
>  struct hci_cp_le_set_event_mask {
>  	__u8     mask[8];
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 45bea25..7196d04 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -209,6 +209,11 @@ struct mgmt_cp_unblock_device {
>  	bdaddr_t bdaddr;
>  } __packed;
>  
> +#define MGMT_OP_SET_FAST_CONNECTABLE	0x001F
> +struct mgmt_cp_set_fast_connectable {
> +	__u8 enable;
> +} __packed;
> +

so I am not 100% sure that doing it this way is the best way.

What is the down side of just enabling interlaced page scan all the
time? And then maybe allow tuning of the timeout via debugfs for testing
purposes.

If we really wanna differentiate between connectable and fast
connectable, then we need to fix up also the controller information to
export this kind of detail. That will get pretty messy right now. So I
would really just prefer to go with interlaced page scan by default and
see what downside this gives us.

Regards

Marcel


