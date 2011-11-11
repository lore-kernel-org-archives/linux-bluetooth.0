Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/6] Bluetooth: Add hci_flags to struct hci_dev
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Sat, 12 Nov 2011 08:09:53 +0900
In-Reply-To: <1321051824-5216-2-git-send-email-andre.guedes@openbossa.org>
References: <1321051824-5216-1-git-send-email-andre.guedes@openbossa.org>
	 <1321051824-5216-2-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321052996.15441.408.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds the hci_flags field to struct hci_dev. This new
> flags variable should be used to define flags related to BR/EDR
> and/or LE controller itself. It should be used to define flags
> which represents states from the controller. The hci_flags is
> cleared in case the controller sends a Reset Command Complete
> Event to the host.
> 
> Also, this patch adds the HCI_LE_SCAN flag which was created to
> track if the controller is performing LE scan or not. The flag
> is set/cleared when the controller starts/stops scanning.
> 
> This is an initial effort to stop using hdev->flags to define
> internal flags since it is exported to userspace by an ioctl.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci.h      |    8 ++++++++
>  include/net/bluetooth/hci_core.h |    2 ++
>  net/bluetooth/hci_core.c         |    1 +
>  net/bluetooth/hci_event.c        |    6 ++++++
>  4 files changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 139ce2a..70321a1 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -88,6 +88,14 @@ enum {
>  	HCI_RESET,
>  };
>  
> +/*
> + * BR/EDR and/or LE controller flags: the flags defined here should represent
> + * states from the controller.
> + */
> +enum {
> +	HCI_LE_SCAN,
> +};
> +
>  /* HCI ioctl defines */
>  #define HCIDEVUP	_IOW('H', 201, int)
>  #define HCIDEVDOWN	_IOW('H', 202, int)
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 1795257..f6d5d90 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -250,6 +250,8 @@ struct hci_dev {
>  
>  	struct module		*owner;
>  
> +	unsigned long		hci_flags;
> +

so I remember that I said, we call these mgmt_flags and make sure that
all the flags are bound the mgmt interface. Why are we calling this
hci_flags now?

Regards

Marcel


