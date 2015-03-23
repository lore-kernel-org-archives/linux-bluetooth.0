Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v2 6/7] Bluetooth: Add support for instance scan response
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426921417-3419-7-git-send-email-armansito@chromium.org>
Date: Mon, 23 Mar 2015 11:37:49 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <304DABF6-C512-4CC8-9A80-E0E4D5100C00@holtmann.org>
References: <1426921417-3419-1-git-send-email-armansito@chromium.org> <1426921417-3419-7-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> This patch implements setting the Scan Response data provided as part
> of an advertising instance through the Add Advertising command.
> 
> Signed-off-by: Arman Uguray <armansito@chromium.org>
> ---
> net/bluetooth/mgmt.c | 66 +++++++++++++++++++++++++++++++++++++++++-----------
> 1 file changed, 52 insertions(+), 14 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 3991380..280346f 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -793,7 +793,7 @@ static struct mgmt_pending_cmd *pending_find_data(u16 opcode,
> 	return mgmt_pending_find_data(HCI_CHANNEL_CONTROL, opcode, hdev, data);
> }
> 
> -static u8 create_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
> +static u8 create_default_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
> {
> 	u8 ad_len = 0;
> 	size_t name_len;
> @@ -819,7 +819,19 @@ static u8 create_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
> 	return ad_len;
> }
> 
> -static void update_scan_rsp_data(struct hci_request *req)
> +static u8 create_instance_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
> +{
> +	/* TODO: Set the appropriate entries based on advertising instance flags
> +	 * here once flags other than 0 are supported.
> +	 */
> +	memcpy(ptr, hdev->adv_instance.scan_rsp_data,
> +	       hdev->adv_instance.scan_rsp_len);
> +
> +	return hdev->adv_instance.scan_rsp_len;
> +}
> +
> +static void update_scan_rsp_data_for_instance(struct hci_request *req,
> +					      u8 instance)
> {
> 	struct hci_dev *hdev = req->hdev;
> 	struct hci_cp_le_set_scan_rsp_data cp;
> @@ -830,7 +842,10 @@ static void update_scan_rsp_data(struct hci_request *req)
> 
> 	memset(&cp, 0, sizeof(cp));
> 
> -	len = create_scan_rsp_data(hdev, cp.data);
> +	if (instance)
> +		len = create_instance_scan_rsp_data(hdev, cp.data);
> +	else
> +		len = create_default_scan_rsp_data(hdev, cp.data);
> 
> 	if (hdev->scan_rsp_data_len == len &&
> 	    memcmp(cp.data, hdev->scan_rsp_data, len) == 0)

Use !memcmp here. We are trying to remove the == 0 usages. There might be some still left in the code in multiple places, but for new code we try not to use it anymore.

> @@ -844,6 +859,25 @@ static void update_scan_rsp_data(struct hci_request *req)
> 	hci_req_add(req, HCI_OP_LE_SET_SCAN_RSP_DATA, sizeof(cp), &cp);
> }
> 
> +static void update_scan_rsp_data(struct hci_request *req)
> +{
> +	struct hci_dev *hdev = req->hdev;
> +	u8 instance;
> +
> +	/* The "Set Advertising" setting supersedes the "Add Advertising"
> +	 * setting. Here we set the scan response data based on which
> +	 * setting was set. When neither apply, default to the global settings,
> +	 * represented by instance "0".
> +	 */
> +	if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) &&
> +	    !hci_dev_test_flag(hdev, HCI_ADVERTISING))
> +		instance = 1;
> +	else
> +		instance = 0;

here I would also use 0x01 and 0x00.

> +
> +	update_scan_rsp_data_for_instance(req, instance);
> +}
> +
> static u8 get_adv_discov_flags(struct hci_dev *hdev)
> {
> 	struct mgmt_pending_cmd *cmd;
> @@ -945,7 +979,7 @@ static void update_adv_data(struct hci_request *req)
> 	struct hci_dev *hdev = req->hdev;
> 	u8 instance;
> 
> -	/* The "Set Advertising" setting supercedes the "Add Advertising"
> +	/* The "Set Advertising" setting supersedes the "Add Advertising"

So this one should be just fixed in your previous patch ;)

> 	 * setting. Here we set the advertising data based on which
> 	 * setting was set. When neither apply, default to the global settings,
> 	 * represented by instance "0".
> @@ -4547,6 +4581,7 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
> 	if (val) {
> 		/* Switch to instance "0" for the Set Advertising setting. */
> 		update_adv_data_for_instance(&req, 0);
> +		update_scan_rsp_data_for_instance(&req, 0);
> 		enable_advertising(&req);
> 	} else {
> 		disable_advertising(&req);
> @@ -6408,25 +6443,25 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
> 	return err;
> }
> 
> -static bool adv_data_is_valid(struct hci_dev *hdev, u32 adv_flags, u8 *adv_data,
> -			      u8 adv_data_len)
> +static bool tlv_data_is_valid(struct hci_dev *hdev, u32 adv_flags, u8 *data,
> +			      u8 len)
> {
> -	u8 max_adv_len = HCI_MAX_AD_LENGTH;
> +	u8 max_len = HCI_MAX_AD_LENGTH;
> 	int i, cur_len;
> 
> -	/* TODO: Correctly reduce adv_len based on adv_flags. */
> +	/* TODO: Correctly reduce len based on adv_flags. */
> 
> -	if (adv_data_len > max_adv_len)
> +	if (len > max_len)
> 		return false;
> 
> -	/* Make sure that adv_data is correctly formatted. */
> -	for (i = 0, cur_len = 0; i < adv_data_len; i += (cur_len + 1)) {
> -		cur_len = adv_data[i];
> +	/* Make sure that the data is correctly formatted. */
> +	for (i = 0, cur_len = 0; i < len; i += (cur_len + 1)) {
> +		cur_len = data[i];
> 
> 		/* If the current field length would exceed the total data
> 		 * length, then it's invalid.
> 		 */
> -		if (i + cur_len >= adv_data_len)
> +		if (i + cur_len >= len)
> 			return false;
> 	}
> 
> @@ -6526,7 +6561,9 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
> 		goto unlock;
> 	}
> 
> -	if (!adv_data_is_valid(hdev, flags, cp->data, cp->adv_data_len)) {
> +	if (!tlv_data_is_valid(hdev, flags, cp->data, cp->adv_data_len) ||
> +	    !tlv_data_is_valid(hdev, flags, cp->data + cp->adv_data_len,
> +			       cp->scan_rsp_len)) {
> 		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
> 				      MGMT_STATUS_INVALID_PARAMS);
> 		goto unlock;
> @@ -6570,6 +6607,7 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
> 	hci_req_init(&req, hdev);
> 
> 	update_adv_data(&req);
> +	update_scan_rsp_data(&req);
> 	enable_advertising(&req);
> 
> 	err = hci_req_run(&req, add_advertising_complete);

Regards

Marcel

