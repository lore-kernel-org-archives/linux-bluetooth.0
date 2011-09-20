Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v4 11/14] Bluetooth: Report LE devices
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 20 Sep 2011 14:49:31 +0200
In-Reply-To: <1316468136-12472-12-git-send-email-andre.guedes@openbossa.org>
References: <1316468136-12472-1-git-send-email-andre.guedes@openbossa.org>
	 <1316468136-12472-12-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316522972.1937.89.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> Devices found during LE scan should be reported to userspace through
> mgmt_device_found events.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_event.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index f097649..166f8fa 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2830,6 +2830,7 @@ static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
>  {
>  	struct hci_ev_le_advertising_info *ev;
>  	u8 num_reports;
> +	s8 rssi;
>  
>  	num_reports = skb->data[0];
>  	ev = (void *) &skb->data[1];
> @@ -2838,9 +2839,18 @@ static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
>  
>  	hci_add_adv_entry(hdev, ev);
>  
> +	rssi = ev->data[ev->length];
> +	mgmt_device_found(hdev->id, &ev->bdaddr, NULL, rssi, ev->data,
> +								ev->length);
> +
>  	while (--num_reports) {
>  		ev = (void *) (ev->data + ev->length + 1);
> +
>  		hci_add_adv_entry(hdev, ev);
> +
> +		rssi = ev->data[ev->length];
> +		mgmt_device_found(hdev->id, &ev->bdaddr, NULL, rssi, ev->data,
> +								ev->length);
>  	}

any reason we are treating the first entry different than the potential
other ones? This code looks too complex to me. And we have to repeat the
same calls which easily leads to typos.

Regards

Marcel


