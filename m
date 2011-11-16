Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC 3/3] Bluetooth: Add AMP initialization
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 17 Nov 2011 06:49:44 +0900
In-Reply-To: <1321457422-31641-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1321457422-31641-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1321457422-31641-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1321480186.15441.554.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Define init sequence for AMP controller. Code based on Code Aurora
> sequence.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_core.c  |   58 ++++++++++++++++++++++++++++----------------
>  net/bluetooth/hci_event.c |    2 +-
>  2 files changed, 38 insertions(+), 22 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index d1eef7c..290acb2 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -219,40 +219,56 @@ static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
>  			hci_send_cmd(hdev, HCI_OP_RESET, 0, NULL);
>  	}
>  
> -	/* Read Local Supported Features */
> -	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_FEATURES, 0, NULL);
> -
>  	/* Read Local Version */
>  	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL);
>  
>  	/* Read Buffer Size (ACL mtu, max pkt, etc.) */
>  	hci_send_cmd(hdev, HCI_OP_READ_BUFFER_SIZE, 0, NULL);
>  
> -	/* Read BD Address */
> -	hci_send_cmd(hdev, HCI_OP_READ_BD_ADDR, 0, NULL);
> +	switch (hdev->dev_type) {
> +	case HCI_BREDR:

stop right here and first split this out into proper helper functions.
Making this part longer and more convoluted is not going to work well in
the long run.
 
> -	if (test_bit(HCI_INIT, &hdev->flags))
> +	if (hdev->dev_type == HCI_BREDR && test_bit(HCI_INIT, &hdev->flags))
>  		hci_setup(hdev);
>  }
>  

This is ugly. Why don't we set HCI_INIT for AMP controllers as well?

Regards

Marcel


