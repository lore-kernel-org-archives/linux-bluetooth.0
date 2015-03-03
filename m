Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v3] Bluetooth: fix service discovery behaviour for empty uuids filter
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1424365130-26193-1-git-send-email-jpawlowski@google.com>
Date: Mon, 2 Mar 2015 16:57:57 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <52958157-D1FE-4DE9-90CA-2EBC008CD42D@holtmann.org>
References: <1424365130-26193-1-git-send-email-jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> This patch fixes service discovery behaviour, when provided uuid filter
> is empty and HCI_QUIRK_STRICT_DUPLICATE_FILTER is set. Before this
> patch, empty uuid filter was unable to trigger scan restart, and that
> caused inconsistent behaviour in applications.
> 
> Example: two DBus clients call BlueZ, one to find all devices with
> service abcd, second to find all devices with rssi smaller than -90.
> Sum of those filters, that is passed to mgmt_service_scan is empty
> filter, with no rssi or uuids set.
> That caused kernel not to restart scan when quirk was set.
> That was inconsistent with what happen when there's only one of those
> two filters set (scan is restarted and reports devices).
> 
> To fix that, new variable hdev->discovery.service_discovery was
> introduced. It can indicate that filtered scan is running, no matter
> what uuid or rssi filter is set.

I think that a name like hdev->discovery.result_filtering would be a bit more descriptive and not duplicate the "discovery" wording.

> 
> This patch also closes all code responsible for filtered discovery in
> one if statement. That makes whole code shorter, much more readable,
> and easier to backport to older kernels, especially pre 3.10.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
> include/net/bluetooth/hci_core.h |   2 +
> net/bluetooth/mgmt.c             | 145 +++++++++++++++------------------------
> 2 files changed, 57 insertions(+), 90 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index a7bf773..791bb75 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -76,6 +76,7 @@ struct discovery_state {
> 	u8			last_adv_data[HCI_MAX_AD_LENGTH];
> 	u8			last_adv_data_len;
> 	bool			report_invalid_rssi;
> +	bool			service_discovery;
> 	s8			rssi;
> 	u16			uuid_count;
> 	u8			(*uuids)[16];

I actually wonder if long term (not in this patch), we might want to combine the type and these booleans into a single unsigned long with flags assigned to it.

> @@ -525,6 +526,7 @@ static inline void discovery_init(struct hci_dev *hdev)
> 
> static inline void hci_discovery_filter_clear(struct hci_dev *hdev)
> {
> +	hdev->discovery.service_discovery = false;
> 	hdev->discovery.report_invalid_rssi = true;
> 	hdev->discovery.rssi = HCI_RSSI_INVALID;
> 	hdev->discovery.uuid_count = 0;
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 3a1b537..0c5b16a 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3932,8 +3932,7 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status,
> 		 */
> 		if (test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER,
> 			     &hdev->quirks) &&
> -		    (hdev->discovery.uuid_count > 0 ||
> -		     hdev->discovery.rssi != HCI_RSSI_INVALID)) {
> +		    hdev->discovery.service_discovery) {

Since we have a comment above this statement. Does it need adjustment or is that still fine?

> 			hdev->discovery.scan_start = jiffies;
> 			hdev->discovery.scan_duration = timeout;
> 		}
> @@ -4086,6 +4085,7 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
> 	 */
> 	hci_discovery_filter_clear(hdev);
> 
> +	hdev->discovery.service_discovery = true;
> 	hdev->discovery.type = cp->type;
> 	hdev->discovery.rssi = cp->rssi;
> 	hdev->discovery.uuid_count = uuid_count;
> @@ -7286,7 +7286,6 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
> 	char buf[512];
> 	struct mgmt_ev_device_found *ev = (void *) buf;
> 	size_t ev_size;
> -	bool match;
> 
> 	/* Don't send events for a non-kernel initiated discovery. With
> 	 * LE one exception is if we have pend_le_reports > 0 in which
> @@ -7299,21 +7298,57 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
> 			return;
> 	}
> 
> -	/* When using service discovery with a RSSI threshold, then check
> -	 * if such a RSSI threshold is specified. If a RSSI threshold has
> -	 * been specified, and HCI_QUIRK_STRICT_DUPLICATE_FILTER is not set,
> -	 * then all results with a RSSI smaller than the RSSI threshold will be
> -	 * dropped. If the quirk is set, let it through for further processing,
> -	 * as we might need to restart the scan.
> -	 *
> -	 * For BR/EDR devices (pre 1.2) providing no RSSI during inquiry,
> -	 * the results are also dropped.
> -	 */
> -	if (hdev->discovery.rssi != HCI_RSSI_INVALID &&
> -	    (rssi == HCI_RSSI_INVALID ||
> -	    (rssi < hdev->discovery.rssi &&
> -	     !test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks))))
> -		return;
> +	if (hdev->discovery.service_discovery) {
> +		/* We are using service discovery */
> +
> +		/* If a RSSI threshold has been specified, and
> +		 * HCI_QUIRK_STRICT_DUPLICATE_FILTER is not set, then all
> +		 * results with a RSSI smaller than the RSSI threshold will be
> +		 * dropped. If the quirk is set, let it through for further
> +		 * processing, as we might need to restart the scan.
> +		 *
> +		 * For BR/EDR devices (pre 1.2) providing no RSSI during
> +		 * inquiry, the results are also dropped.
> +		 */
> +		if (hdev->discovery.rssi != HCI_RSSI_INVALID &&
> +		    (rssi == HCI_RSSI_INVALID ||
> +		    (rssi < hdev->discovery.rssi &&
> +		     !test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER,
> +			       &hdev->quirks))))
> +			return;
> +
> +		/* If a list of UUID is provided, results with no matching UUID
> +		 * should be dropped. If list of UUID is not provided, treat
> +		 * all devices as matches.
> +		 * Empty UUID filter might be a result of merging filters
> +		 * somewhere in highter layer, and should behave same as when
> +		 * we have UUID match.
> +		 */
> +		if (hdev->discovery.uuid_count != 0 &&
> +		    (eir_len == 0 || !eir_has_uuids(eir, eir_len,
> +				  hdev->discovery.uuid_count,
> +				  hdev->discovery.uuids)) &&
> +		    (scan_rsp_len == 0 || !eir_has_uuids(scan_rsp, scan_rsp_len,
> +				  hdev->discovery.uuid_count,
> +				  hdev->discovery.uuids)))
> +			return;
> +
> +		/* If duplicate filtering does not report RSSI changes,
> +		 * then restart scanning to ensure updated result with
> +		 * updated RSSI values.
> +		 */
> +		if (test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER,
> +			     &hdev->quirks)) {
> +			restart_le_scan(hdev);
> +
> +			/* Validate the reported RSSI value against the
> +			 * RSSI threshold once more.
> +			 */
> +			if (hdev->discovery.rssi != HCI_RSSI_INVALID &&
> +			    rssi < hdev->discovery.rssi)
> +				return;
> +		}
> +	}
> 
> 	/* Make sure that the buffer is big enough. The 5 extra bytes
> 	 * are for the potential CoD field.
> @@ -7340,87 +7375,17 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
> 	ev->rssi = rssi;
> 	ev->flags = cpu_to_le32(flags);
> 
> -	if (eir_len > 0) {
> -		/* When using service discovery and a list of UUID is
> -		 * provided, results with no matching UUID should be
> -		 * dropped. In case there is a match the result is
> -		 * kept and checking possible scan response data
> -		 * will be skipped.
> -		 */
> -		if (hdev->discovery.uuid_count > 0) {
> -			match = eir_has_uuids(eir, eir_len,
> -					      hdev->discovery.uuid_count,
> -					      hdev->discovery.uuids);
> -			/* If duplicate filtering does not report RSSI changes,
> -			 * then restart scanning to ensure updated result with
> -			 * updated RSSI values.
> -			 */
> -			if (match && test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER,
> -					      &hdev->quirks))
> -				restart_le_scan(hdev);
> -		} else {
> -			match = true;
> -		}
> -
> -		if (!match && !scan_rsp_len)
> -			return;
> -
> +	if (eir_len > 0)
> 		/* Copy EIR or advertising data into event */
> 		memcpy(ev->eir, eir, eir_len);
> -	} else {
> -		/* When using service discovery and a list of UUID is
> -		 * provided, results with empty EIR or advertising data
> -		 * should be dropped since they do not match any UUID.
> -		 */
> -		if (hdev->discovery.uuid_count > 0 && !scan_rsp_len)
> -			return;
> -
> -		match = false;
> -	}
> 
> 	if (dev_class && !eir_has_data_type(ev->eir, eir_len, EIR_CLASS_OF_DEV))
> 		eir_len = eir_append_data(ev->eir, eir_len, EIR_CLASS_OF_DEV,
> 					  dev_class, 3);
> 
> -	if (scan_rsp_len > 0) {
> -		/* When using service discovery and a list of UUID is
> -		 * provided, results with no matching UUID should be
> -		 * dropped if there is no previous match from the
> -		 * advertising data.
> -		 */
> -		if (hdev->discovery.uuid_count > 0) {
> -			if (!match && !eir_has_uuids(scan_rsp, scan_rsp_len,
> -						     hdev->discovery.uuid_count,
> -						     hdev->discovery.uuids))
> -				return;
> -
> -			/* If duplicate filtering does not report RSSI changes,
> -			 * then restart scanning to ensure updated result with
> -			 * updated RSSI values.
> -			 */
> -			if (test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER,
> -				     &hdev->quirks))
> -				restart_le_scan(hdev);
> -		}
> -
> +	if (scan_rsp_len > 0)
> 		/* Append scan response data to event */
> 		memcpy(ev->eir + eir_len, scan_rsp, scan_rsp_len);
> -	} else {
> -		/* When using service discovery and a list of UUID is
> -		 * provided, results with empty scan response and no
> -		 * previous matched advertising data should be dropped.
> -		 */
> -		if (hdev->discovery.uuid_count > 0 && !match)
> -			return;
> -	}
> -
> -	/* Validate the reported RSSI value against the RSSI threshold once more
> -	 * incase HCI_QUIRK_STRICT_DUPLICATE_FILTER forced a restart of LE
> -	 * scanning.
> -	 */
> -	if (hdev->discovery.rssi != HCI_RSSI_INVALID &&
> -	    rssi < hdev->discovery.rssi)
> -		return;

I have no chance of verifying that this code is correct. Do we actually have mgmt-tester test cases that test this behavior?

You are taking a lot of code and replacing it by completely new code. I rather not do that until I can be 100% sure we do not break existing behavior. This is just too much code for single patch. You need to break this down into smaller pieces.

Regards

Marcel

