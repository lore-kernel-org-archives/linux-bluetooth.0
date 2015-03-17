Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v4 4/7] Bluetooth: Add simultaneous dual mode scan
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426556254-1480-4-git-send-email-jpawlowski@google.com>
Date: Mon, 16 Mar 2015 19:18:35 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4B5FED89-8F4B-4F7A-A132-67409F920202@holtmann.org>
References: <1426556254-1480-1-git-send-email-jpawlowski@google.com> <1426556254-1480-4-git-send-email-jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> When doing scan through mgmt api, some controllers can do both le and
> classic scan at same time. They can be distinguished by
> HCI_QUIRK_SIMULTANEOUS_DISCOVERY set.
> 
> This patch enables them to use this feature when doing dual mode scan.
> Instead of doing le, then classic scan, both scans are run at once.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
> net/bluetooth/hci_core.c  | 24 +++++++++++++++++++-----
> net/bluetooth/hci_event.c | 18 ++++++++++++++++--
> net/bluetooth/mgmt.c      | 36 ++++++++++++++++++++++++++++++------
> 3 files changed, 65 insertions(+), 13 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 750d344..3d51bf7 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2902,12 +2902,26 @@ static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status,
> 
> 		hci_dev_lock(hdev);
> 
> -		hci_inquiry_cache_flush(hdev);
> +		if (test_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY,
> +			     &hdev->quirks)) {
> +			/* If we were running le only scan, change discovery

Please name it LE only scan.

> +			 * state. If we were running both le and classic scans

LE scan and BR/EDR inquiry.

> +			 * simultaneously, and classic is already finished,

BR/EDR inquiry.

> +			 * stop discovery, otherwise  classic scan will stop

Single spaces are fine. And please also call it BR/EDR inquiry.

> +			 * discovery when finished.
> +			 */

			/* When only LE scanning is running, then change discovery
			 * state to indicate that it completed. In case LE scanning
			 * and BR/EDR inquiry is active and the inquiry completed
			 * already, then also change the discovery state.
			 *
			 * In case only BR/EDR inquiry is running, then it will
			 * change the discovery state when it finished. Nothing to
			 * do here in that case.
			 */

So I would have written it something like this to make why we are doing it this way. If I understood you correctly.

> +			if (!test_bit(HCI_INQUIRY, &hdev->flags))
> +				hci_discovery_set_state(hdev,
> +							DISCOVERY_STOPPED);
> +		} else {
> +			hci_inquiry_cache_flush(hdev);
> 
> -		err = hci_req_run(&req, inquiry_complete);
> -		if (err) {
> -			BT_ERR("Inquiry request failed: err %d", err);
> -			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> +			err = hci_req_run(&req, inquiry_complete);
> +			if (err) {
> +				BT_ERR("Inquiry request failed: err %d", err);
> +				hci_discovery_set_state(hdev,
> +							DISCOVERY_STOPPED);
> +			}
> 		}
> 
> 		hci_dev_unlock(hdev);
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index d800f0c..4a3cc58 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2126,7 +2126,14 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
> 		goto unlock;
> 
> 	if (list_empty(&discov->resolve)) {
> -		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> +		/* if we were running BR/EDR inquiry change discovery state.

> +		 * If we were running both BR/EDR inquiry and LE scan
> +		 * simultaneously, and LE is already finished, change state,
> +		 * otherwise LE scan will stop discovery when finished.
> +		 */

		/* When BR/EDR inquiry is active and not LE scanning is in
		 * progress, then change discovery state to indicate completion.
		 *
		 * When running LE scanning and BR/EDR inquiry simultaneously
		 * and the LE scan already finished, then change the discovery
		 * state to indicate completion.
		 */

> +		if (!hci_dev_test_flag(hdev, HCI_LE_SCAN) ||
> +		    !test_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks))
> +			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> 		goto unlock;
> 	}
> 
> @@ -2135,7 +2142,14 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
> 		e->name_state = NAME_PENDING;
> 		hci_discovery_set_state(hdev, DISCOVERY_RESOLVING);
> 	} else {
> -		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> +		/* if we were running classic discovery change discovery state.
> +		 * If we were running both le and classic scans simultaneously,
> +		 * and le is already finished, change state, otherwise le
> +		 * scan will stop discovery when finished.
> +		 */

I leave this as an exercise to reword it similar to the two other statements.

> +		if (!hci_dev_test_flag(hdev, HCI_LE_SCAN) ||
> +		    !test_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks))
> +			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> 	}
> 
> unlock:
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 9d3c7a1..ef4db8a 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1402,7 +1402,9 @@ static bool hci_stop_discovery(struct hci_request *req)
> 	case DISCOVERY_FINDING:
> 		if (test_bit(HCI_INQUIRY, &hdev->flags)) {
> 			hci_req_add(req, HCI_OP_INQUIRY_CANCEL, 0, NULL);
> -		} else {
> +		}
> +

If this is correct, then the { } can be removed now.

> +		if (hci_dev_test_flag(hdev, HCI_LE_SCAN)) {
> 			cancel_delayed_work(&hdev->le_scan_disable);
> 			hci_req_add_le_scan_disable(req);
> 		}
> @@ -4015,13 +4017,27 @@ static bool trigger_discovery(struct hci_request *req, u8 *status)
> 		break;
> 
> 	case DISCOV_TYPE_INTERLEAVED:
> -		if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED)) {
> -			*status = MGMT_STATUS_NOT_SUPPORTED;
> -			return false;
> +		if (!test_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY,
> +			      &hdev->quirks)) {
> +			if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED)) {
> +				*status = MGMT_STATUS_NOT_SUPPORTED;
> +				return false;
> +			}
> +
> +			if (!trigger_le_scan(req, status,
> +					     cpu_to_le16(DISCOV_LE_SCAN_INT)))
> +				return false;

Extra empty space here.

> +			return true;
> 		}
> 
> +		/* During simultaneous scan, we double scan interval. We must

Lets call it discovery and not scan. It is also LE scan interval.

> +		 * leave some time to do BR/EDR scan.

some time for the controller to execute BR/EDR inquiry.

> +		 */
> 		if (!trigger_le_scan(req, status,
> -				     cpu_to_le16(DISCOV_LE_SCAN_INT)))
> +				     cpu_to_le16(DISCOV_LE_SCAN_INT * 2)))
> +			return false;
> +
> +		if (!trigger_bredr_inquiry(req, status))
> 			return false;
> 		break;
> 
> @@ -4067,7 +4083,15 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status,
> 		timeout = msecs_to_jiffies(DISCOV_LE_TIMEOUT);
> 		break;
> 	case DISCOV_TYPE_INTERLEAVED:
> -		timeout = msecs_to_jiffies(hdev->discov_interleaved_timeout);
> +		/* if we're doing simultaneous discovery, LE scan should last
> +		 * whole time. If we do interleaved scan, LE scan last only half
> +		 * of that (BR/EDR inquiry takes rest of time).
> +		 */

		/* When running simultaneous discovery, the LE scanning time
		 * should occupy the whole discovery time sine BR/EDR inquiry
		 * and LE scanning are scheduled by the controller.
		 *
		 * For interleaving discovery in comparison, BR/EDR inquiry
		 * and LE scanning are done sequentially with separate
		 * timeouts.
		 */

> +		if (test_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks))
> +			timeout = msecs_to_jiffies(DISCOV_LE_TIMEOUT);
> +		else
> +			timeout = msecs_to_jiffies(
> +					     hdev->discov_interleaved_timeout);

This indentation is odd. Just go over 80 characters here.

> 		break;
> 	case DISCOV_TYPE_BREDR:
> 		timeout = 0;

Regards

Marcel

