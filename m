Return-Path: <szymon.janc@codecoup.pl>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Chriz Chow <cmcvista@gmail.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, Chriz Chow <chriz.chow@aminocom.com>
Subject: Re: [PATCH] Bluetooth: Prevent buffer overflow for large advertisement data
Date: Thu, 19 Apr 2018 14:28:52 +0200
Message-ID: <1646173.KpzMEjoeCb@ix>
In-Reply-To: <1524135789-25968-1-git-send-email-chriz.chow@aminocom.com>
References: <1524135789-25968-1-git-send-email-chriz.chow@aminocom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chriz,

On Thursday, 19 April 2018 13:03:09 CEST Chriz Chow wrote:
> In the Bluetooth Core Specifications 5.0 it has no limitation of
> the length of Advertising or Scan Response Data. Therefore,
> there are some devices sending out advertising data longer than
> HCI_MAX_AD_LENGTH, causing the buffer last_adv_data overflows.
> 
> It prevents the issue by checking the data length before copying.
> 
> Signed-off-by: Chriz Chow <chriz.chow@aminocom.com>
> ---
>  net/bluetooth/hci_event.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 139707c..1300bb0 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1118,6 +1118,9 @@ static void store_pending_adv_report(struct hci_dev
> *hdev, bdaddr_t *bdaddr, {
>  	struct discovery_state *d = &hdev->discovery;
> 
> +	if (len > HCI_MAX_AD_LENGTH)
> +		return;
> +
>  	bacpy(&d->last_adv_addr, bdaddr);
>  	d->last_adv_addr_type = bdaddr_type;
>  	d->last_adv_rssi = rssi;

This would indicate that controller is sending LE Advertising Report Event 
with illegal length value (valid range is 0x00-0x1f). If there are such broken 
controllers around we could check those but I think this should be done as 
soon as possible ie. in hci_le_adv_report_evt() function.

Also, >31 bytes of advertising data is only for Extended Advertising which 
would require using LE Set Extended Scan commands and would result in LE 
Extended Advertising Reports being generated instead (none of those are yet 
supported in kernel).

-- 
pozdrawiam
Szymon Janc
