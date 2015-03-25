Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH 2/7] Bluetooth: Support the "connectable mode" adv flag
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1427252582-24814-2-git-send-email-armansito@chromium.org>
Date: Wed, 25 Mar 2015 09:21:12 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F4C87549-0FC1-494E-ADB2-4388FB3BF301@holtmann.org>
References: <1427252582-24814-1-git-send-email-armansito@chromium.org> <1427252582-24814-2-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> This patch adds support for the "connectable mode" flag of the
> Add Advertising command.
> 
> Signed-off-by: Arman Uguray <armansito@chromium.org>
> ---
> net/bluetooth/mgmt.c | 32 ++++++++++++++++++++------------
> 1 file changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 38b03bd..a5995a2 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1013,11 +1013,8 @@ static void update_adv_data_for_instance(struct hci_request *req, u8 instance)
> 	hci_req_add(req, HCI_OP_LE_SET_ADV_DATA, sizeof(cp), &cp);
> }
> 
> -static void update_adv_data(struct hci_request *req)
> +static u8 get_current_adv_instance(struct hci_dev *hdev)
> {
> -	struct hci_dev *hdev = req->hdev;
> -	u8 instance;
> -
> 	/* The "Set Advertising" setting supersedes the "Add Advertising"
> 	 * setting. Here we set the advertising data based on which
> 	 * setting was set. When neither apply, default to the global settings,
> @@ -1025,9 +1022,15 @@ static void update_adv_data(struct hci_request *req)
> 	 */
> 	if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) &&
> 	    !hci_dev_test_flag(hdev, HCI_ADVERTISING))
> -		instance = 0x01;
> -	else
> -		instance = 0x00;
> +		return 0x01;
> +
> +	return 0x00;
> +}
> +
> +static void update_adv_data(struct hci_request *req)
> +{
> +	struct hci_dev *hdev = req->hdev;
> +	u8 instance = get_current_adv_instance(hdev);
> 
> 	update_adv_data_for_instance(req, instance);
> }
> @@ -1188,6 +1191,7 @@ static void enable_advertising(struct hci_request *req)
> 	struct hci_cp_le_set_adv_param cp;
> 	u8 own_addr_type, enable = 0x01;
> 	bool connectable;
> +	u8 instance;
> 
> 	if (hci_conn_num(hdev, LE_LINK) > 0)
> 		return;
> @@ -1202,7 +1206,13 @@ static void enable_advertising(struct hci_request *req)
> 	 */
> 	hci_dev_clear_flag(hdev, HCI_LE_ADV);
> 
> -	if (hci_dev_test_flag(hdev, HCI_ADVERTISING_CONNECTABLE))
> +	instance = get_current_adv_instance(hdev);
> +
> +	if (instance == 0x01 &&
> +	    hdev->adv_instance.flags & MGMT_ADV_FLAG_CONNECTABLE)
> +		connectable = true;
> +	else if (instance == 0x00 &&
> +		 hci_dev_test_flag(hdev, HCI_ADVERTISING_CONNECTABLE))
> 		connectable = true;
> 	else
> 		connectable = get_connectable(hdev);

this code seems testing the same thing over and over again. I have the feeling this needs a bit smart way of figuring out the flags and instance ids.

> @@ -6623,10 +6633,8 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
> 	flags = __le32_to_cpu(cp->flags);
> 	timeout = __le16_to_cpu(cp->timeout);
> 
> -	/* The current implementation only supports adding one instance and
> -	 * doesn't support flags.
> -	 */
> -	if (cp->instance != 0x01 || flags)
> +	/* The current implementation only supports adding one instance */
> +	if (cp->instance != 0x01)
> 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
> 				       MGMT_STATUS_INVALID_PARAMS);

I would prefer that one we take this check out, we add a new one that check that only supported flags are given. It is also fine to do this in a second patch or the one that changes the supported flags.

Regards

Marcel

