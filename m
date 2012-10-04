Return-Path: <cyrus@holtmann.org>
Message-ID: <1349344897.27233.13.camel@aeonflux>
Subject: Re: [PATCH v2 resend 1/2] Introduced a load_firmware callback to
 struct hci_dev
From: Marcel Holtmann <marcel@holtmann.org>
To: Jesse Sung <jesse.sung@canonical.com>
Cc: Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Date: Thu, 04 Oct 2012 12:01:37 +0200
In-Reply-To: <1349335847-1615-2-git-send-email-jesse.sung@canonical.com>
References: <cover.1347959921.git.jesse.sung@canonical.com>
	 <1349335847-1615-1-git-send-email-jesse.sung@canonical.com>
	 <1349335847-1615-2-git-send-email-jesse.sung@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jesse,

> load_firmware will be called at the end of hci_dev_open() if it
> is defined.
> 
> Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_core.c         |    2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 593cd1d..40972a3 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -281,6 +281,7 @@ struct hci_dev {
>  	int (*send)(struct sk_buff *skb);
>  	void (*notify)(struct hci_dev *hdev, unsigned int evt);
>  	int (*ioctl)(struct hci_dev *hdev, unsigned int cmd, unsigned long arg);
> +	void (*load_firmware)(struct hci_dev *hdev);
>  };
>  
>  struct hci_conn {
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index d4de5db..49be87a 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -725,6 +725,8 @@ int hci_dev_open(__u16 dev)
>  done:
>  	hci_req_unlock(hdev);
>  	hci_dev_put(hdev);
> +	if (!ret && hdev->load_firmware)
> +		hdev->load_firmware(hdev);
>  	return ret;
>  }
>  

has anybody thought this through actually? Do we need to reload the
firmware after every HCI_Reset? Since hci_dev_open() is used at least
twice during normal operation. And for every RFKILL or power down/up
cycle of the chip.

And there is an internal process of hci_dev_open() trigger on
registration and others triggered by hciconfig hci0 up. I am pretty much
against having to wait for all this firmware loading crap during every
bring up of the device. Especially since it always does a trip via
request_firmware().

Regards

Marcel


