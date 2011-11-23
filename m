Return-Path: <cyrus@holtmann.org>
Message-ID: <1322059738.29909.6.camel@aeonflux>
Subject: Re: [PATCH 2/2] Bluetooth: Remove magic bluetooth version numbers
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 23 Nov 2011 15:48:58 +0100
In-Reply-To: <1322040215-640-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1322040215-640-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1322040215-640-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Use bluetooth names instead of BT SIG assigned numbers
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  include/net/bluetooth/bluetooth.h |    5 +++++
>  net/bluetooth/hci_conn.c          |    2 +-
>  net/bluetooth/hci_event.c         |    6 +++---
>  3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 38cd3da..98ea1b1 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -36,6 +36,11 @@
>  #define PF_BLUETOOTH	AF_BLUETOOTH
>  #endif
>  
> +/* Bluetooth versions */
> +#define BLUETOOTH_VER_1_1	1
> +#define BLUETOOTH_VER_1_2	2
> +#define BLUETOOTH_VER_2_0_EDR	3
> +

I am fine with the patch, but you need to use BLUETOOTH_VER_2_0 here
since you have have 2.0 without EDR. Have a fun night reading with the
Bluetooth SIG branding guidelines.

Once you did that change, ACK.

Regards

Marcel


