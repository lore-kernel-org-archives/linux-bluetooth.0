Return-Path: <cyrus@holtmann.org>
Message-ID: <1322745177.26198.34.camel@aeonflux>
Subject: Re: [PATCHv2 8/8] Bluetooth: Complete Read Local Version HCI cmd
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 01 Dec 2011 14:12:57 +0100
In-Reply-To: <1322743335-8671-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1322743335-8671-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1322743335-8671-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Mark request status as done for Read Local Version HCI command.
> ---
>  net/bluetooth/hci_event.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index a646310..e064aa1 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -598,7 +598,7 @@ static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
>  	BT_DBG("%s status 0x%x", hdev->name, rp->status);
>  
>  	if (rp->status)
> -		return;
> +		goto done;
>  
>  	hdev->hci_ver = rp->hci_ver;
>  	hdev->hci_rev = __le16_to_cpu(rp->hci_rev);
> @@ -612,6 +612,9 @@ static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
>  
>  	if (test_bit(HCI_INIT, &hdev->flags))
>  		hci_setup(hdev);
> +
> +done:
> +	hci_req_complete(hdev, HCI_OP_READ_LOCAL_VERSION, rp->status);
>  }

this is all getting out of control. We call hci_req_complete for random
functions now. And that is because our init handling sucks.

Regards

Marcel


