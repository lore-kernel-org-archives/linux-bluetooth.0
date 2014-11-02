Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH v2 3/4] Adding HCI_QUIRK_ADV_RSSI_DEDUP
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1414607071-9801-3-git-send-email-jpawlowski@google.com>
Date: Sun, 2 Nov 2014 11:45:48 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <846CEA35-DEAF-4396-8F4B-7F63EDAD33D1@holtmann.org>
References: <1414607071-9801-1-git-send-email-jpawlowski@google.com> <1414607071-9801-3-git-send-email-jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

patch subject must start with Bluetooth:.

> When this quirk is set, the device, when in scan with deduplication is
> not sending advertising reports for device when RSSI value changes.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
> include/net/bluetooth/hci.h      | 9 +++++++++
> include/net/bluetooth/hci_core.h | 2 ++
> 2 files changed, 11 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index b15d240..d8a8e0d 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -129,6 +129,15 @@ enum {
> 	 * during the hdev->setup vendor callback.
> 	 */
> 	HCI_QUIRK_INVALID_BDADDR,
> +
> +	/* When this quirk is set, the device, when in scan with de-duplication
> +	 * is not sending advertising reports for device when RSSI value
> +	 * changes.
> +	 *
> +	 * This quirk can be set before hci_register_dev is called or
> +	 * during the hdev->setup vendor callback.
> +	 */
> +	HCI_QUIRK_DUPLICATION,
> };

This is how I would name it.

+
+       /* When this quirk is set, the duplicate filtering during
+        * scanning is based on Bluetooth devices addresses. To allow
+        * RSSI based updates, restart scanning if needed.
+        *
+        * This quirk can be set before hci_register_dev is called or
+        * during the hdev->setup vendor callback.
+        */
+       HCI_QUIRK_STRICT_DUPLICATE_FILTER,

Of course this patch has to come first to introduce this quirk. And then a second patch to actually enable it for Broadcom USB devices.

        if (id->driver_info & BTUSB_BCM_PATCHRAM) {
                hdev->setup = btusb_setup_bcm_patchram;
                hdev->set_bdaddr = btusb_set_bdaddr_bcm;
+               set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
        }

> 
> /* HCI device flags */
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 3c585885..e8e55f0 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1304,6 +1304,8 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
> #define DISCOV_INTERLEAVED_INQUIRY_LEN	0x04
> #define DISCOV_BREDR_INQUIRY_LEN	0x08
> 
> +#define DISCOV_LE_RESTART_DELAY msecs_to_jiffies(300)
> +

This one does not belong into this patch.

Regards

Marcel

