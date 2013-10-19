Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 9/9] Bluetooth: Update Set Discoverable to support LE
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1382215103-6968-10-git-send-email-johan.hedberg@gmail.com>
Date: Sun, 20 Oct 2013 00:11:51 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E4F869C8-4D12-4525-81FE-C85309D3128B@holtmann.org>
References: <1382215103-6968-1-git-send-email-johan.hedberg@gmail.com> <1382215103-6968-10-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch updates the Set Discoverable management command to also be
> applicable for LE. In particular this affects the advertising flags
> where we can say "general discoverable" or "limited discoverable".
> 
> Since the device flags may not be up-to-date when the advertising data
> is written this patch introduces a get_adv_discov_flags() helper
> function which also looks at any pending mgmt commands (a pending
> set_discoverable would be the exception when the flags are not yet
> correct).
> 
> The patch also adds HCI_DISCOVERABLE flag clearing to the
> mgmt_discoverable_timeout function, since the code was previously
> relying on the mgmt_discoverable callback to handle this, which is only
> called for the BR/EDR-only HCI_Write_Scan_Enable command.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 49 +++++++++++++++++++++++++++++++++++++++++++------
> 1 file changed, 43 insertions(+), 6 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 796db58..73ed132 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -599,12 +599,35 @@ static void update_scan_rsp_data(struct hci_request *req)
> 	hci_req_add(req, HCI_OP_LE_SET_SCAN_RSP_DATA, sizeof(cp), &cp);
> }
> 
> +static u8 get_adv_discov_flags(struct hci_dev *hdev)
> +{
> +	struct pending_cmd *cmd;
> +
> +	/* If there's a pending mgmt command the flags will not yet have
> +	 * their final values, so check for this first.
> +	 */
> +	cmd = mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, hdev);
> +	if (cmd) {
> +		struct mgmt_mode *cp = cmd->param;
> +		if (cp->val == 0x01)
> +			return LE_AD_GENERAL;
> +		else if (cp->val == 0x02)
> +			return LE_AD_LIMITED;
> +	} else {
> +		if (test_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags))
> +			return LE_AD_LIMITED;
> +		else if (test_bit(HCI_DISCOVERABLE, &hdev->dev_flags))
> +			return LE_AD_GENERAL;
> +	}
> +
> +	return 0;
> +}
> +
> static u8 create_adv_data(struct hci_dev *hdev, u8 *ptr)
> {
> 	u8 ad_len = 0, flags = 0;
> 
> -	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags))
> -		flags |= LE_AD_GENERAL;
> +	flags |= get_adv_discov_flags(hdev);
> 
> 	if (test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
> 		if (lmp_le_br_capable(hdev))
> @@ -1120,15 +1143,15 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
> 	struct pending_cmd *cmd;
> 	struct hci_request req;
> 	u16 timeout;
> -	u8 scan, status;
> +	u8 scan;
> 	int err;
> 
> 	BT_DBG("request for %s", hdev->name);
> 
> -	status = mgmt_bredr_support(hdev);
> -	if (status)
> +	if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags) &&
> +	    !test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
> 		return cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
> -				  status);
> +				  MGMT_STATUS_REJECTED);
> 
> 	if (cp->val != 0x00 && cp->val != 0x01 && cp->val != 0x02)
> 		return cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
> @@ -1228,6 +1251,12 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
> 
> 	hci_req_init(&req, hdev);
> 
> +	/* The procedure for LE-only controllers is much simpler - just
> +	 * update the advertising data.
> +	 */
> +	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
> +		goto update_ad;
> +
> 	scan = SCAN_PAGE;
> 
> 	if (cp->val) {
> @@ -1260,6 +1289,10 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
> 
> 	hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, sizeof(scan), &scan);
> 
> +update_ad:
> +	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
> +		update_adv_data(&req);
> +

actually update_adv_data() check for HCI_LE_ENABLED all by itself. So this check is just duplicated and not needed here.

Regards

Marcel

