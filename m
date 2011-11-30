Return-Path: <cyrus@holtmann.org>
Message-ID: <1322662397.26198.0.camel@aeonflux>
Subject: Re: [PATCHv3 3/3] Bluetooth: trivial: correct check for LMP version
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 30 Nov 2011 15:13:17 +0100
In-Reply-To: <1322642695-5784-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1322642695-5784-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1322642695-5784-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Make sure that code match exactly what comment says about pre 1.2
> LMP version.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  net/bluetooth/hci_event.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 60651fa..27b1ede 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -498,7 +498,7 @@ static void hci_setup_event_mask(struct hci_dev *hdev)
>  
>  	/* CSR 1.1 dongles does not accept any bitfield so don't try to set
>  	 * any event mask for pre 1.2 devices */
> -	if (hdev->lmp_ver <= BLUETOOTH_VER_1_1)
> +	if (hdev->lmp_ver < BLUETOOTH_VER_1_2)
>  		return;

However, even here you need to use hci_ver since it is a HCI detail and
has nothing to do with the LMP version.

Regards

Marcel


