Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH] Bluetooth: Use continuous scanning when creating LE connections
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1448880520-12810-1-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 1 Dec 2015 21:42:34 -1000
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A56C1B29-8433-42B7-80E5-580E28BBCB53@holtmann.org>
References: <1448880520-12810-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> All LE connections are now triggered through a preceding passive scan
> and waiting for a connectable advertising report. This means we've got
> the best possible guarantee that the device is within range and should
> be able to request the controller to perform continuous scanning. This
> way we minimize the risk that we miss out on any advertising packets.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_conn.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index e2600213cd50..f28741d78e0b 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -726,8 +726,12 @@ static void hci_req_add_le_create_conn(struct hci_request *req,
> 	if (hci_update_random_address(req, false, &own_addr_type))
> 		return;
> 
> +	/* Set interval and window to same value to enable continuous
> +	 * scanning.
> +	 */

I think we want to phrase this as using a scan window as large as the scan interval to trigger a full duty / continuous scan. Just to be a bit more clearer.

> 	cp.scan_interval = cpu_to_le16(hdev->le_scan_interval);
> -	cp.scan_window = cpu_to_le16(hdev->le_scan_window);
> +	cp.scan_window = cp.scan_interval;
> +

And I know you try to optimize the cpu_to_le16 out here, but honestly I would prefer this:

	cp.scan_window = cpu_to_le16(hdev->le_scan_interval);

Regards

Marcel

