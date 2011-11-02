Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Define HCI reasons instead of magic number
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 02 Nov 2011 15:17:09 +0100
In-Reply-To: <1320221534-13765-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1320221534-13765-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1320243430.15441.280.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Use HCI error reasons instead of magic numbers.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/hci.h      |    8 ++++++++
>  include/net/bluetooth/hci_core.h |    2 +-
>  net/bluetooth/hci_conn.c         |    2 +-
>  net/bluetooth/hci_event.c        |    4 ++--
>  net/bluetooth/l2cap_core.c       |    8 ++++----
>  5 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index c5fcd13..b9b0ca9 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -288,6 +288,10 @@ struct hci_cp_create_conn {
>  	__u8     role_switch;
>  } __packed;
>  
> +#define HCI_REASON_DISC_AUTH_FAILURE	0x05
> +#define HCI_REASON_DISC_REMOTE_USER	0x13
> +#define HCI_REASON_DISC_LOCAL_HOST	0x16
> +

actually these are HCI error/status codes that are well defined and go
beyond just disconnect reason. Using REASON_DISC seems to be wrong here.
Can you come up with better naming?

Regards

Marcel


