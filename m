Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v4 09/14] Bluetooth: Send mgmt_discovering events
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 20 Sep 2011 14:45:23 +0200
In-Reply-To: <1316468136-12472-10-git-send-email-andre.guedes@openbossa.org>
References: <1316468136-12472-1-git-send-email-andre.guedes@openbossa.org>
	 <1316468136-12472-10-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316522725.1937.87.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_event.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index c9d641b..47abba4 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -897,12 +897,16 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
>  		return;
>  
>  	if (cp->enable == 0x01) {
> +		mgmt_discovering(hdev->id, 1);
> +
>  		del_timer(&hdev->adv_timer);
>  
>  		hci_dev_lock(hdev);
>  		hci_adv_entries_clear(hdev);
>  		hci_dev_unlock(hdev);
>  	} else if (cp->enable == 0x00) {
> +		mgmt_discovering(hdev->id, 0);
> +

do we wanna send discovering on/off for BR/EDR and then again for LE.
Don't we wanna have something like this:

	discovering on
	BR/EDR inquiry
	LE scan
	discovering off

Regards

Marcel


