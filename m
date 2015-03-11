Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v1 2/5] Bluetooth: Add simultaenous dual mode scan
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1425331850-31906-2-git-send-email-jpawlowski@google.com>
Date: Tue, 10 Mar 2015 19:55:21 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FC19377C-9356-4B0E-B35B-C20A67817AC2@holtmann.org>
References: <1425331850-31906-1-git-send-email-jpawlowski@google.com> <1425331850-31906-2-git-send-email-jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> When doing scan through mgmt api, some controllers can do both le and
> classic scan at same time. They can be distinguished by
> HCI_QUIRK_SIMULTAENOUS_DISCOVERY set.
> 
> This patch enables them to use this feature when doing dual mode scan.
> Instead of doing le, then classic scan, both scans are run at once.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
> include/net/bluetooth/hci_core.h |  1 +
> net/bluetooth/hci_core.c         | 26 ++++++++++++----
> net/bluetooth/hci_event.c        | 18 +++++++++--
> net/bluetooth/mgmt.c             | 66 ++++++++++++++++++++++++++++------------
> 4 files changed, 84 insertions(+), 27 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index acec914..5cd9451 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1285,6 +1285,7 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
> #define DISCOV_LE_SCAN_WIN		0x12
> #define DISCOV_LE_SCAN_INT		0x12
> #define DISCOV_LE_TIMEOUT		10240	/* msec */
> +#define DISCOV_LE_SIMULTAENOUS_SCAN_WIN	0x24

actually to keep the number of constants to a minimum, I would just make sure the code uses DISCOV_LE_SCAN_WIN * 2 with a comment on top of explaining why. And that comment should be above the code that widens the scan window.

> #define DISCOV_INTERLEAVED_TIMEOUT	5120	/* msec */
> #define DISCOV_INTERLEAVED_INQUIRY_LEN	0x04
> #define DISCOV_BREDR_INQUIRY_LEN	0x08
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index dbd26bc..c4f2316 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2866,12 +2866,26 @@ static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status,
> 
> 		hci_dev_lock(hdev);
> 
> -		hci_inquiry_cache_flush(hdev);
> -
> -		err = hci_req_run(&req, inquiry_complete);
> -		if (err) {
> -			BT_ERR("Inquiry request failed: err %d", err);
> -			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> +		if (!test_bit(HCI_QUIRK_SIMULTAENOUS_DISCOVERY,
> +			      &hdev->quirks)) {
> +			hci_inquiry_cache_flush(hdev);
> +
> +			err = hci_req_run(&req, inquiry_complete);
> +			if (err) {
> +				BT_ERR("Inquiry request failed: err %d", err);
> +				hci_discovery_set_state(hdev,
> +							DISCOVERY_STOPPED);
> +			}
> +		} else {
> +			/* If we were running le only scan, change discovery
> +			 * state. If we were running both le and classic scans
> +			 * simultaenously, and classic is already finished,
> +			 * stop discovery, otherwise  classic scan will stop
> +			 * discovery when finished.
> +			 */
> +			if (!test_bit(HCI_INQUIRY, &hdev->flags))
> +				hci_discovery_set_state(hdev,
> +							DISCOVERY_STOPPED);
> 		}

I we have an else branch anyway and they are both roughly the same size, then there is no good reason to start the negative one. Just flip these around.

> 
> 		hci_dev_unlock(hdev);
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index e9b17b5..d69de31 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2127,7 +2127,14 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
> 		goto unlock;
> 
> 	if (list_empty(&discov->resolve)) {
> -		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> +		/* if we were running classic discovery change discovery state.
> +		 * If we were running both le and classic scans simultaenously,

The capitalization is off here a bit. Also spelling of simultaneously seems wrong.

> +		 * and le is already finished, change state, otherwise le
> +		 * scan will stop discovery when finished.

Personally I prefer to use LE and BR/EDR terms in clear uppercase in comments. We want to be a bit consistent in our comments. Classic discovery is actually BR/EDR inquiry and we have LE scan. We should use these terms.

> +		 */
> +		if (!test_bit(HCI_LE_SCAN, &hdev->flags) ||
> +		    !test_bit(HCI_QUIRK_SIMULTAENOUS_DISCOVERY, &hdev->quirks))
> +			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> 		goto unlock;
> 	}
> 
> @@ -2136,7 +2143,14 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
> 		e->name_state = NAME_PENDING;
> 		hci_discovery_set_state(hdev, DISCOVERY_RESOLVING);
> 	} else {
> -		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> +		/* if we were running classic discovery change discovery state.
> +		 * If we were running both le and classic scans simultaenously,
> +		 * and le is already finished, change state, otherwise le
> +		 * scan will stop discovery when finished.
> +		 */
> +		if (!test_bit(HCI_LE_SCAN, &hdev->flags) ||
> +		    !test_bit(HCI_QUIRK_SIMULTAENOUS_DISCOVERY, &hdev->quirks))
> +			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> 	}

I wonder now if it would not be better if hci_discovery_set_state handle this for us. Seems we are calling that function in all cases. So it could just do the right thing. Any reason you did it otherwise here?

> 
> unlock:
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 1e4635a..9d95290 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3783,34 +3783,44 @@ done:
> 	return err;
> }
> 
> -static bool trigger_discovery(struct hci_request *req, u8 *status)
> +static bool trigger_classic_discovery(struct hci_request *req, u8 *status)

Please do not call this classic discovery. It is inquiry or bredr_inquiry.

> {
> 	struct hci_dev *hdev = req->hdev;
> -	struct hci_cp_le_set_scan_param param_cp;
> -	struct hci_cp_le_set_scan_enable enable_cp;
> 	struct hci_cp_inquiry inq_cp;
> 	/* General inquiry access code (GIAC) */
> 	u8 lap[3] = { 0x33, 0x8b, 0x9e };
> +
> +	*status = mgmt_bredr_support(hdev);
> +	if (*status)
> +		return false;
> +
> +	if (test_bit(HCI_INQUIRY, &hdev->flags)) {
> +		*status = MGMT_STATUS_BUSY;
> +		return false;
> +	}
> +
> +	hci_inquiry_cache_flush(hdev);
> +
> +	memset(&inq_cp, 0, sizeof(inq_cp));
> +	memcpy(&inq_cp.lap, lap, sizeof(inq_cp.lap));
> +	inq_cp.length = DISCOV_BREDR_INQUIRY_LEN;
> +	hci_req_add(req, HCI_OP_INQUIRY, sizeof(inq_cp), &inq_cp);
> +	return true;
> +}
> +
> +static bool trigger_discovery(struct hci_request *req, u8 *status)
> +{
> +	struct hci_dev *hdev = req->hdev;
> +	struct hci_cp_le_set_scan_param param_cp;
> +	struct hci_cp_le_set_scan_enable enable_cp;
> +	__le16 interval;
> 	u8 own_addr_type;
> 	int err;
> 
> 	switch (hdev->discovery.type) {
> 	case DISCOV_TYPE_BREDR:
> -		*status = mgmt_bredr_support(hdev);
> -		if (*status)
> -			return false;
> -
> -		if (test_bit(HCI_INQUIRY, &hdev->flags)) {
> -			*status = MGMT_STATUS_BUSY;
> +		if (!trigger_classic_discovery(req, status))
> 			return false;
> -		}
> -
> -		hci_inquiry_cache_flush(hdev);
> -
> -		memset(&inq_cp, 0, sizeof(inq_cp));
> -		memcpy(&inq_cp.lap, lap, sizeof(inq_cp.lap));
> -		inq_cp.length = DISCOV_BREDR_INQUIRY_LEN;
> -		hci_req_add(req, HCI_OP_INQUIRY, sizeof(inq_cp), &inq_cp);
> 		break;
> 
> 	case DISCOV_TYPE_LE:
> @@ -3858,8 +3868,17 @@ static bool trigger_discovery(struct hci_request *req, u8 *status)
> 			return false;
> 		}
> 
> +		/* During simultaenous scan, scan interval can't be equal to
> +		 * scan window. We must leave some time to do BR/EDR scan.
> +		 */
> +		if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
> +		    test_bit(HCI_QUIRK_SIMULTAENOUS_DISCOVERY, &hdev->quirks))
> +			interval = cpu_to_le16(DISCOV_LE_SIMULTAENOUS_SCAN_WIN);
> +		else
> +			interval = cpu_to_le16(DISCOV_LE_SCAN_INT);
> +

so I think we might need a bit of refactoring of the code now. Previously this was combining the LE and interleaved case statements into one since both start with LE scan. However now that is no longer the case.

I really dislike hacking if case in here checking for discovery.type since that is what the switch statement is for in the first place. So we need to split the inquiry start and le scan start out into nice little helpers and then call them accordingly. However it is clear the DISCOV_TYPE_INTERLEAVED now gets its own case statement.

> 		param_cp.type = LE_SCAN_ACTIVE;
> -		param_cp.interval = cpu_to_le16(DISCOV_LE_SCAN_INT);
> +		param_cp.interval = interval;
> 		param_cp.window = cpu_to_le16(DISCOV_LE_SCAN_WIN);
> 		param_cp.own_address_type = own_addr_type;
> 		hci_req_add(req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
> @@ -3870,6 +3889,11 @@ static bool trigger_discovery(struct hci_request *req, u8 *status)
> 		enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
> 		hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
> 			    &enable_cp);
> +
> +		if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
> +		    test_bit(HCI_QUIRK_SIMULTAENOUS_DISCOVERY, &hdev->quirks))
> +			if (!trigger_classic_discovery(req, status))
> +				return false;
> 		break;
> 
> 	default:
> @@ -3914,7 +3938,11 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status,
> 		timeout = msecs_to_jiffies(DISCOV_LE_TIMEOUT);
> 		break;
> 	case DISCOV_TYPE_INTERLEAVED:
> -		timeout = msecs_to_jiffies(hdev->discov_interleaved_timeout);
> +		if (test_bit(HCI_QUIRK_SIMULTAENOUS_DISCOVERY, &hdev->quirks))
> +			timeout = msecs_to_jiffies(DISCOV_LE_TIMEOUT);
> +		else
> +			timeout = msecs_to_jiffies(
> +					     hdev->discov_interleaved_timeout);

This one you need explain to me. I do not understand this change.

> 		break;
> 	case DISCOV_TYPE_BREDR:
> 		timeout = 0;

Regards

Marcel

