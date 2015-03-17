Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v4 2/7] Bluetooth: Refactor BREDR inquiry and LE scan triggering.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426556254-1480-2-git-send-email-jpawlowski@google.com>
Date: Mon, 16 Mar 2015 19:18:34 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <60DDD649-F7CA-43B7-A443-35B031DC2825@holtmann.org>
References: <1426556254-1480-1-git-send-email-jpawlowski@google.com> <1426556254-1480-2-git-send-email-jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> This patch refactor BREDR inquiry and LE scan triggering logic into
> separate methods.

please write it as BR/EDR which makes it generally more consistent.

> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
> net/bluetooth/mgmt.c | 145 +++++++++++++++++++++++++++++----------------------
> 1 file changed, 82 insertions(+), 63 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 32c2c75..92fa8e88 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3913,93 +3913,112 @@ done:
> 	return err;
> }
> 
> -static bool trigger_discovery(struct hci_request *req, u8 *status)
> +static bool trigger_bredr_inquiry(struct hci_request *req, u8 *status)
> {
> 	struct hci_dev *hdev = req->hdev;
> -	struct hci_cp_le_set_scan_param param_cp;
> -	struct hci_cp_le_set_scan_enable enable_cp;
> 	struct hci_cp_inquiry inq_cp;

I think you can rename this into just cp now. There is only now.

> 	/* General inquiry access code (GIAC) */
> 	u8 lap[3] = { 0x33, 0x8b, 0x9e };
> +
> +	*status = mgmt_bredr_support(hdev);
> +	if (*status)
> +		return false;
> +
> +	if (hci_dev_test_flag(hdev, HCI_INQUIRY)) {
> +		*status = MGMT_STATUS_BUSY;
> +		return false;
> +	}
> +
> +	hci_inquiry_cache_flush(hdev);
> +
> +	memset(&inq_cp, 0, sizeof(inq_cp));
> +	memcpy(&inq_cp.lap, lap, sizeof(inq_cp.lap));
> +	inq_cp.length = DISCOV_BREDR_INQUIRY_LEN;

I think we normally have an empty line between filling the structs and then calling hci_req_add.

> +	hci_req_add(req, HCI_OP_INQUIRY, sizeof(inq_cp), &inq_cp);

Extra empty line here.

> +	return true;
> +}
> +
> +static bool trigger_le_scan(struct hci_request *req, u8 *status,
> +			    __le16 interval)
> +{

Lets make the status the last parameter. Having a return value in the middle is odd.

> +	struct hci_dev *hdev = req->hdev;
> +	struct hci_cp_le_set_scan_param param_cp;
> +	struct hci_cp_le_set_scan_enable enable_cp;
> 	u8 own_addr_type;
> 	int err;
> 
> -	switch (hdev->discovery.type) {
> -	case DISCOV_TYPE_BREDR:
> -		*status = mgmt_bredr_support(hdev);
> -		if (*status)
> -			return false;
> +	*status = mgmt_le_support(hdev);
> +	if (*status)
> +		return false;
> 
> -		if (test_bit(HCI_INQUIRY, &hdev->flags)) {
> -			*status = MGMT_STATUS_BUSY;
> +	if (hci_dev_test_flag(hdev, HCI_LE_ADV)) {
> +		/* Don't let discovery abort an outgoing connection attempt
> +		 * that's using directed advertising.
> +		 */
> +		if (hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT)) {
> +			*status = MGMT_STATUS_REJECTED;
> 			return false;
> 		}
> 
> -		hci_inquiry_cache_flush(hdev);
> +		disable_advertising(req);
> +	}
> +
> +	/* If controller is scanning, it means the background scanning is
> +	 * running. Thus, we should temporarily stop it in order to set the
> +	 * discovery scanning parameters.
> +	 */
> +	if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
> +		hci_req_add_le_scan_disable(req);
> 
> -		memset(&inq_cp, 0, sizeof(inq_cp));
> -		memcpy(&inq_cp.lap, lap, sizeof(inq_cp.lap));
> -		inq_cp.length = DISCOV_BREDR_INQUIRY_LEN;
> -		hci_req_add(req, HCI_OP_INQUIRY, sizeof(inq_cp), &inq_cp);
> +	memset(&param_cp, 0, sizeof(param_cp));

This memset should go above the code that fills the param_cp.

> +
> +	/* All active scans will be done with either a resolvable private
> +	 * address (when privacy feature has been enabled) or non-resolvable
> +	 * private address.
> +	 */
> +	err = hci_update_random_address(req, true, &own_addr_type);
> +	if (err < 0) {
> +		*status = MGMT_STATUS_FAILED;
> +		return false;
> +	}
> +

Put the memset from above right here.

> +	param_cp.type = LE_SCAN_ACTIVE;
> +	param_cp.interval = interval;
> +	param_cp.window = cpu_to_le16(DISCOV_LE_SCAN_WIN);
> +	param_cp.own_address_type = own_addr_type;
> +	hci_req_add(req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
> +		    &param_cp);
> +
> +	memset(&enable_cp, 0, sizeof(enable_cp));
> +	enable_cp.enable = LE_SCAN_ENABLE;
> +	enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
> +	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
> +		    &enable_cp);
> +
> +	return true;
> +}
> +
> +static bool trigger_discovery(struct hci_request *req, u8 *status)
> +{
> +	struct hci_dev *hdev = req->hdev;
> +
> +	switch (hdev->discovery.type) {
> +	case DISCOV_TYPE_BREDR:
> +		if (!trigger_bredr_inquiry(req, status))
> +			return false;
> 		break;
> 
> 	case DISCOV_TYPE_LE:
> 	case DISCOV_TYPE_INTERLEAVED:
> -		*status = mgmt_le_support(hdev);
> -		if (*status)
> -			return false;
> -
> 		if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
> 		    !hci_dev_test_flag(hdev, HCI_BREDR_ENABLED)) {
> 			*status = MGMT_STATUS_NOT_SUPPORTED;
> 			return false;
> 		}
> 
> -		if (hci_dev_test_flag(hdev, HCI_LE_ADV)) {
> -			/* Don't let discovery abort an outgoing
> -			 * connection attempt that's using directed
> -			 * advertising.
> -			 */
> -			if (hci_conn_hash_lookup_state(hdev, LE_LINK,
> -						       BT_CONNECT)) {
> -				*status = MGMT_STATUS_REJECTED;
> -				return false;
> -			}
> -
> -			disable_advertising(req);
> -		}
> -
> -		/* If controller is scanning, it means the background scanning
> -		 * is running. Thus, we should temporarily stop it in order to
> -		 * set the discovery scanning parameters.
> -		 */
> -		if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
> -			hci_req_add_le_scan_disable(req);
> -
> -		memset(&param_cp, 0, sizeof(param_cp));
> -
> -		/* All active scans will be done with either a resolvable
> -		 * private address (when privacy feature has been enabled)
> -		 * or non-resolvable private address.
> -		 */
> -		err = hci_update_random_address(req, true, &own_addr_type);
> -		if (err < 0) {
> -			*status = MGMT_STATUS_FAILED;
> +		if (!trigger_le_scan(req, status,
> +				     cpu_to_le16(DISCOV_LE_SCAN_INT)))
> 			return false;

I had to apply the patch see the resulting code, but I prefer if we turn this actually into nice code while we are at it. I pretty much dislike entering a case block and then checking the same value again.

        switch (hdev->discovery.type) {
        case DISCOV_TYPE_BREDR:
                if (!trigger_bredr_inquiry(req, status))
                        return false;
                break;

        case DISCOV_TYPE_INTERLEAVED:
                if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED)) {
                        *status = MGMT_STATUS_NOT_SUPPORTED;
                        return false;
                }
                /* fall through */

        case DISCOV_TYPE_LE:
               if (!trigger_le_scan(req, status,
                                     cpu_to_le16(DISCOV_LE_SCAN_INT)))
                        return false;
                break;

        default:
                *status = MGMT_STATUS_INVALID_PARAMS;
                return false;
        }

Regards

Marcel

