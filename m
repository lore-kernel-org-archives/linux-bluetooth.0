Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 2/3] Bluetooth: Don't send device found events during passive scanning
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395506915-23058-2-git-send-email-johan.hedberg@gmail.com>
Date: Sat, 22 Mar 2014 11:48:53 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D104547D-CF55-4E6A-8474-9222047BBFCC@holtmann.org>
References: <1395506915-23058-1-git-send-email-johan.hedberg@gmail.com> <1395506915-23058-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Passive LE scanning is only used by the kernel-internal connection
> establishment procedure. It makes therefore little sense to send device
> found events to user space.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 43872af20aa4..403c1d96331a 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3944,8 +3944,12 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
> static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
> 			       u8 bdaddr_type, s8 rssi, u8 *data, u8 len)
> {
> -	if (type == LE_ADV_IND || type == LE_ADV_DIRECT_IND)
> -		check_pending_le_conn(hdev, bdaddr, bdaddr_type);
> +	/* Passive scanning shouldn't trigger any device found events */
> +	if (hdev->le_scan_type == LE_SCAN_PASSIVE) {
> +		if (type == LE_ADV_IND || type == LE_ADV_DIRECT_IND)
> +			check_pending_le_conn(hdev, bdaddr, bdaddr_type);
> +	    return;

the indentation is sort of screwed up here.

> +	}
> 
> 	mgmt_device_found(hdev, bdaddr, LE_LINK, bdaddr_type, NULL, rssi, 0, 1,
> 			  data, len);

And strictly speaking the mgmt_device_found checks by itself if it is discovering mode or not. So events will only be send out when discovering. However I think it is a good idea to shortcut this function when passive scanning.

One minor details is now that devices will no longer be connected when doing active discovery. So when you discover a device during discovery, it will not be connected, it has to wait for the next passive scan. Not sure if we really want that. Especially with direct advertising, we really want to connect right away.

Regards

Marcel

