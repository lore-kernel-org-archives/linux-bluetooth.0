Return-Path: <cyrus@holtmann.org>
Message-ID: <1323901223.1965.70.camel@aeonflux>
Subject: Re: [RFCv0] Bluetooth: General HCI callback implementation
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 14 Dec 2011 23:20:23 +0100
In-Reply-To: <1323436248-3736-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1323436248-3736-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Add general HCI callback implementation. Can be used for executing
> HCI commands from A2MP protocol.
> ---
>  include/net/bluetooth/hci_core.h |   14 +++++++++++
>  net/bluetooth/hci_core.c         |   47 ++++++++++++++++++++++++++++++++++++++
>  net/bluetooth/hci_event.c        |    4 +++
>  3 files changed, 65 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index cc5481d..e473cd2 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -121,6 +121,15 @@ struct adv_entry {
>  	u8 bdaddr_type;
>  };
>  
> +struct hci_dev;
> +
> +struct cb_cmd {
> +	struct list_head list;
> +	u16 opcode;
> +	void *opt;
> +	void (*cb)(struct hci_dev *hdev, void *opt);
> +};
> +

so I am actually thinking that we might just update hci_request into a
bit more flexible schema.

Gustavo is working on moving everything into a process context, so we
can actually sleep. And we could just make a simple premise to only
allow one request at a time. That would also then allow us to utilize
hci_request. We just need a clean way to report back the result.

Regards

Marcel


