Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC] Bluetooth: Provide access to reassembled Rx packets
From: Marcel Holtmann <marcel@holtmann.org>
To: Suraj Sumangala <suraj@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, Jothikumar.Mothilal@Atheros.com
In-Reply-To: <1280124157-16693-1-git-send-email-suraj@atheros.com>
References: <1280124157-16693-1-git-send-email-suraj@atheros.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 25 Jul 2010 23:13:08 -0700
Message-ID: <1280124788.2621.37.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

> Provide the HCI transport driver access to reassembled Rx packets before
> sending to Host.
> 
> Signed-off-by: Suraj Sumangala <suraj@atheros.com>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_core.c         |    4 ++++
>  2 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 350b3e6..769530b 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -156,6 +156,7 @@ struct hci_dev {
>  	int (*close)(struct hci_dev *hdev);
>  	int (*flush)(struct hci_dev *hdev);
>  	int (*send)(struct sk_buff *skb);
> +	int (*recv)(struct hci_dev *hdev, struct sk_buff *skb);

besides the fact that skb->dev == hdev, why would be doing something
like this? This is highly inefficient.

Regards

Marcel


