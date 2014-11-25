Return-Path: <cyrus@holtmann.org>
Date: Tue, 25 Nov 2014 13:00:20 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v9 3/3] Bluetooth: start and stop service discovery
Message-ID: <20141125110020.GC15104@t440s.ger.corp.intel.com>
References: <1416728993-4189-1-git-send-email-jpawlowski@google.com>
 <1416728993-4189-3-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1416728993-4189-3-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Sat, Nov 22, 2014, Jakub Pawlowski wrote:
> This patch introduces start service discovery and stop service
> discovery methods. The reason behind that is to enable users to find
> specific services in range by UUID. Whole filtering is done in
> mgmt_device_found.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
>  include/net/bluetooth/hci.h      |   1 +
>  include/net/bluetooth/hci_core.h |   6 +
>  include/net/bluetooth/mgmt.h     |  16 ++
>  net/bluetooth/hci_core.c         |   1 +
>  net/bluetooth/mgmt.c             | 333 ++++++++++++++++++++++++++++++++++-----
>  5 files changed, 321 insertions(+), 36 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 2f0bce2..97b0893 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -204,6 +204,7 @@ enum {
>  	HCI_BREDR_ENABLED,
>  	HCI_LE_SCAN_INTERRUPTED,
>  	HCI_LE_SCAN_RESTARTING,
> +	HCI_SERVICE_FILTER,
>  };

As I mentioned earlier these will not fit in the hdev->dev_flags
variable on 32-bit systems. The flag you're adding here would already be
the 34th flag.

> +/* cleans up the state set up by the start_service_discovery function. */
> +void mgmt_clean_up_service_discovery(struct hci_dev *hdev)
> +{
> +	if (!test_and_clear_bit(HCI_SERVICE_FILTER, &hdev->dev_flags))
> +		return;
> +
> +	cancel_delayed_work_sync(&hdev->le_scan_restart);
> +	if (hdev->discovery.sd_num_uuid > 0)
> +		kfree(hdev->discovery.sd_uuid);

"if (hdev->discovery.sd_uuid)" would be a more correct check here,
however since it's valid to pass NULL to kfree I think this all can be
made unconditional.

> +static int init_service_discovery(struct hci_dev *hdev, s8 rssi, u16 num_uuid,
> +				  u8 (*uuid)[16])
> +{
> +	hdev->discovery.sd_rssi = rssi;
> +	hdev->discovery.sd_num_uuid = num_uuid;
> +
> +	if (num_uuid > 0) {
> +		hdev->discovery.sd_uuid = kmalloc(16 * num_uuid, GFP_KERNEL);
> +		if (!hdev->discovery.sd_uuid)
> +			return -ENOMEM;
> +		memcpy(hdev->discovery.sd_uuid, uuid, 16 * num_uuid);
> +	}

What I mentioned earlier is particularly valid since you're failing to
set sd_num_uuid back to 0 if kmalloc fails here.

> +		if (expected_len != len) {
> +			return cmd_complete(sk, hdev->id, opcode,
> +					    MGMT_STATUS_INVALID_PARAMS, &type,
> +					    sizeof(type));
> +		}

The { } can be dropped here since it's a single-statement branch.

Johan
