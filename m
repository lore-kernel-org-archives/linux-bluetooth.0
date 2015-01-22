Return-Path: <cyrus@holtmann.org>
Date: Thu, 22 Jan 2015 13:54:08 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v9 2/2] Bluetooth: Add restarting to service discovery
Message-ID: <20150122115408.GA15904@t440s.lan>
References: <1421412071-18881-1-git-send-email-jpawlowski@google.com>
 <1421412071-18881-2-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421412071-18881-2-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Fri, Jan 16, 2015, Jakub Pawlowski wrote:
> When using LE_SCAN_FILTER_DUP_ENABLE, some controllers would send
> advertising report from each LE device only once. That means that we
> don't get any updates on RSSI value, and makes Service Discovery very
> slow. This patch adds restarting scan when in Service Discovery, and
> device with filtered uuid is found, but it's not in RSSI range to send
> event yet. This way if device moves into range, we will quickly get RSSI
> update.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/mgmt.c             | 48 ++++++++++++++++++++++++++++++++++++----
>  2 files changed, 45 insertions(+), 4 deletions(-)

A couple of minor things with this one still:

> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index de019eb..cbfc18e 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1328,6 +1328,7 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
>  #define DISCOV_INTERLEAVED_TIMEOUT	5120	/* msec */
>  #define DISCOV_INTERLEAVED_INQUIRY_LEN	0x04
>  #define DISCOV_BREDR_INQUIRY_LEN	0x08
> +#define DISCOV_LE_RESTART_DELAY		200	/* msec */

Please put the msecs_to_jiffies() straight into the definition here (see
our other similar defines in include/net/bluetooth/hci.h for examples).
This makes the code using the define simpler (e.g. less need for line
breaks).

>  void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
>  		       u8 addr_type, u8 *dev_class, s8 rssi, u32 flags,
>  		       u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len)
> @@ -7224,7 +7238,9 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
>  	 * the results are also dropped.
>  	 */
>  	if (hdev->discovery.rssi != HCI_RSSI_INVALID &&
> -	    (rssi < hdev->discovery.rssi || rssi == HCI_RSSI_INVALID))
> +	    (rssi == HCI_RSSI_INVALID ||
> +	    (rssi < hdev->discovery.rssi &&
> +		!test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks))))

This doesn't look like it's correctly aligned: the !test_bit should start
at the same place as the 'r' of the rssi on the line above.

> @@ -7296,7 +7320,15 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
>  						     hdev->discovery.uuid_count,
>  						     hdev->discovery.uuids))
>  				return;
> -		}
> +
> +			/* we have service match. If duplicate filtering doesn't
> +			 * honour RSSI hanges, restart scan to make sure we'll
> +			 * get RSSI updates
> +			 */
> +			if (test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER,
> +				     &hdev->quirks))
> +				restart_le_scan(hdev);
> +			}

Something's not quite right here indentation-wise. The closing } seems
to be on the same level as the 'if' which can't be right?

Johan
