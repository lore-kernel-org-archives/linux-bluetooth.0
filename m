Return-Path: <cyrus@holtmann.org>
Message-ID: <53304433.30507@openbossa.org>
Date: Mon, 24 Mar 2014 11:41:55 -0300
From: Andre Guedes <andre.guedes@openbossa.org>
MIME-Version: 1.0
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 2/4] Bluetooth: Don't send device found events during
 passive scanning
References: <1395650883-25577-1-git-send-email-johan.hedberg@gmail.com> <1395650883-25577-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1395650883-25577-2-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 03/24/2014 05:48 AM, johan.hedberg@gmail.com wrote:
> From: Johan Hedberg <johan.hedberg@intel.com>
>
> Passive LE scanning is only used by the kernel-internal connection
> establishment procedure. It makes therefore little sense to send device
> found events to user space.

Not sure this patch is necessary. This feature is already garanteed by 
this patch 12602d0cc005354a519b3eba443d7912ab71313a .

> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>   net/bluetooth/hci_event.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 43872af20aa4..403c1d96331a 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3944,8 +3944,12 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
>   static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
>   			       u8 bdaddr_type, s8 rssi, u8 *data, u8 len)
>   {
> -	if (type == LE_ADV_IND || type == LE_ADV_DIRECT_IND)
> -		check_pending_le_conn(hdev, bdaddr, bdaddr_type);
> +	/* Passive scanning shouldn't trigger any device found events */
> +	if (hdev->le_scan_type == LE_SCAN_PASSIVE) {
> +		if (type == LE_ADV_IND || type == LE_ADV_DIRECT_IND)
> +			check_pending_le_conn(hdev, bdaddr, bdaddr_type);
> +	    return;
> +	}

Additionally, as a side effect of this change, automatic connection 
won't be establish while discovery is running anymore. So it can add 
even more delay to our reconnection procedure (10.24 seconds max). Did 
you considered this?

BR,

Andre
