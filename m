Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v1 4/7] Bluetooth: Implement the Add Advertising command
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426906090-9026-5-git-send-email-armansito@chromium.org>
Date: Fri, 20 Mar 2015 20:29:44 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C6183388-49D8-46EB-83AA-C07E0586FB17@holtmann.org>
References: <1426906090-9026-1-git-send-email-armansito@chromium.org> <1426906090-9026-5-git-send-email-armansito@chromium.org>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> This patch adds the most basic implementation for the
> "Add Advertisement" command. All state updates between the
> various HCI settings (POWERED, ADVERTISING, ADVERTISING_INSTANCE,
> and LE_ENABLED) has been implemented. The command currently
> supports only setting the advertising data fields, with no flags
> and no scan response data.

> 
> Signed-off-by: Arman Uguray <armansito@chromium.org>
> ---
> net/bluetooth/mgmt.c | 281 +++++++++++++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 272 insertions(+), 9 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 8c771e7..e71b011 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -100,6 +100,7 @@ static const u16 mgmt_commands[] = {
> 	MGMT_OP_READ_LOCAL_OOB_EXT_DATA,
> 	MGMT_OP_READ_EXT_INDEX_LIST,
> 	MGMT_OP_READ_ADV_FEATURES,
> +	MGMT_OP_ADD_ADVERTISING,
> };
> 
> static const u16 mgmt_events[] = {
> @@ -135,6 +136,8 @@ static const u16 mgmt_events[] = {
> 	MGMT_EV_EXT_INDEX_ADDED,
> 	MGMT_EV_EXT_INDEX_REMOVED,
> 	MGMT_EV_LOCAL_OOB_DATA_UPDATED,
> +	MGMT_EV_ADVERTISING_ADDED,
> +	MGMT_EV_ADVERTISING_REMOVED,
> };
> 
> #define CACHE_TIMEOUT	msecs_to_jiffies(2 * 1000)
> @@ -864,7 +867,7 @@ static u8 get_adv_discov_flags(struct hci_dev *hdev)
> 	return 0;
> }
> 
> -static u8 create_adv_data(struct hci_dev *hdev, u8 *ptr)
> +static u8 create_default_adv_data(struct hci_dev *hdev, u8 *ptr)
> {
> 	u8 ad_len = 0, flags = 0;
> 
> @@ -896,6 +899,17 @@ static u8 create_adv_data(struct hci_dev *hdev, u8 *ptr)
> 	return ad_len;
> }
> 
> +static u8 create_instance_adv_data(struct hci_dev *hdev, u8 *ptr)
> +{
> +	/* TODO: Set the appropriate entries based on advertising instance flags
> +	 * here once flags other than 0 are supported.
> +	 */
> +	memcpy(ptr, hdev->adv_instance.adv_data,
> +	       hdev->adv_instance.adv_data_len);
> +
> +	return hdev->adv_instance.adv_data_len;
> +}
> +
> static void update_adv_data(struct hci_request *req)
> {
> 	struct hci_dev *hdev = req->hdev;
> @@ -907,8 +921,17 @@ static void update_adv_data(struct hci_request *req)
> 
> 	memset(&cp, 0, sizeof(cp));
> 
> -	len = create_adv_data(hdev, cp.data);
> +	/* The "Set Advertising" setting supercedes the "Add Advertising"
> +	 * setting. Here we set the advertising data based on which
> +	 * setting was set. Default to the global settings when neither apply.
> +	 */
> +	if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) &&
> +	    !hci_dev_test_flag(hdev, HCI_ADVERTISING))
> +		len = create_instance_adv_data(hdev, cp.data);
> +	else
> +		len = create_default_adv_data(hdev, cp.data);
> 
> +	/* There's nothing to do if the data hasn't changed */
> 	if (hdev->adv_data_len == len &&
> 	    memcmp(cp.data, hdev->adv_data, len) == 0)
> 		return;
> @@ -4374,10 +4397,17 @@ static int set_device_id(struct sock *sk, struct hci_dev *hdev, void *data,
> 	return err;
> }
> 
> +static void enable_advertising_instance(struct hci_dev *hdev, u8 status,
> +					u16 opcode)
> +{
> +	BT_DBG("status %d", status);
> +}
> +
> static void set_advertising_complete(struct hci_dev *hdev, u8 status,
> 				     u16 opcode)
> {
> 	struct cmd_lookup match = { NULL, hdev };
> +	struct hci_request req;
> 
> 	hci_dev_lock(hdev);
> 
> @@ -4402,6 +4432,21 @@ static void set_advertising_complete(struct hci_dev *hdev, u8 status,
> 	if (match.sk)
> 		sock_put(match.sk);
> 
> +	/* If "Set Advertising" was just disabled and instance advertising was
> +	 * set up earlier, then enable the advertising instance.
> +	 */
> +	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
> +	    !hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))
> +		goto unlock;
> +
> +	hci_req_init(&req, hdev);
> +
> +	update_adv_data(&req);
> +	enable_advertising(&req);
> +
> +	if (hci_req_run(&req, enable_advertising_instance) < 0)
> +		BT_ERR("Failed to re-configure advertising");
> +
> unlock:
> 	hci_dev_unlock(hdev);
> }
> @@ -4484,10 +4529,19 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
> 	else
> 		hci_dev_clear_flag(hdev, HCI_ADVERTISING_CONNECTABLE);
> 
> -	if (val)
> +	if (val) {
> +		/* Set the HCI_ADVERTISING bit temporarily so that
> +		 * update_adv_data knows to use the default advertising
> +		 * settings.
> +		 */
> +		hci_dev_set_flag(hdev, HCI_ADVERTISING);
> +		update_adv_data(&req);
> +		hci_dev_clear_flag(hdev, HCI_ADVERTISING);
> +

This sounds a bit dangerous to me. Why not add u8 instance parameter to update_adv_data and call it with instance = 0 here.

> 		enable_advertising(&req);
> -	else
> +	} else {
> 		disable_advertising(&req);
> +	}
> 
> 	err = hci_req_run(&req, set_advertising_complete);
> 	if (err < 0)
> @@ -6299,12 +6353,21 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
> 	struct mgmt_rp_read_adv_features *rp;
> 	size_t rp_len;
> 	int err;
> +	bool instance;
> 
> 	BT_DBG("%s", hdev->name);
> 
> 	hci_dev_lock(hdev);
> 
> 	rp_len = sizeof(*rp);
> +
> +	/* Currently only one instance is supported, so just add 1 to the
> +	 * response length.
> +	 */
> +	instance = hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE);
> +	if (instance)
> +		rp_len++;
> +
> 	rp = kmalloc(rp_len, GFP_ATOMIC);
> 	if (!rp) {
> 		hci_dev_unlock(hdev);
> @@ -6314,8 +6377,17 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
> 	rp->supported_flags = cpu_to_le32(0);
> 	rp->max_adv_data_len = HCI_MAX_AD_LENGTH;
> 	rp->max_scan_rsp_len = HCI_MAX_AD_LENGTH;
> -	rp->max_instances = 0;
> -	rp->num_instances = 0;
> +	rp->max_instances = 1;
> +
> +	/* Currently only one instance is supported, so simply return the
> +	 * current instance number.
> +	 */
> +	if (instance) {
> +		rp->num_instances = 1;
> +		rp->instance[0] = 1;
> +	} else {
> +		rp->num_instances = 0;
> +	}
> 
> 	hci_dev_unlock(hdev);
> 
> @@ -6327,6 +6399,187 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
> 	return err;
> }
> 
> +static bool adv_data_is_valid(struct hci_dev *hdev, u32 adv_flags, u8 *adv_data,
> +			      u8 adv_data_len)
> +{
> +	u8 max_adv_len = HCI_MAX_AD_LENGTH;
> +	int i, cur_len;
> +
> +	/* TODO: Correctly reduce adv_len based on adv_flags. */
> +
> +	/* The only global settings that affects the maximum length is BREDR
> +	 * support, which must be included in the "flags" AD field.
> +	 */
> +	if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
> +		max_adv_len -= 3;

Since we currently have supported_flags = 0, this check is bogus. We actually allow the caller of Add Advertising to violate the specification.

> +
> +	if (adv_data_len > max_adv_len)
> +		return false;
> +
> +	/* Make sure that adv_data is correctly formatted and doesn't contain
> +	 * any fields that are managed by adv_flags and global settings.
> +	 */

The comment indicates that it does more than it actually does. Adjust the comment to say that it only checks the basic length structure.

> +	for (i = 0, cur_len = 0; i < adv_data_len; i += (cur_len + 1)) {
> +		cur_len = adv_data[i];
> +
> +		/* If the current field length would exceed the total data
> +		 * length, then it's invalid.
> +		 */
> +		if (i + cur_len >= adv_data_len)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +static void advertising_added(struct sock *sk, struct hci_dev *hdev,
> +			      u8 instance)
> +{
> +	struct mgmt_ev_advertising_added ev;
> +
> +	ev.instance = instance;
> +
> +	mgmt_event(MGMT_EV_ADVERTISING_ADDED, hdev, &ev, sizeof(ev), sk);
> +}
> +
> +static void advertising_removed(struct sock *sk, struct hci_dev *hdev,
> +				u8 instance)
> +{
> +	struct mgmt_ev_advertising_removed ev;
> +
> +	ev.instance = instance;
> +
> +	mgmt_event(MGMT_EV_ADVERTISING_REMOVED, hdev, &ev, sizeof(ev), sk);
> +}
> +
> +static void add_advertising_complete(struct hci_dev *hdev, u8 status,
> +				     u16 opcode)
> +{
> +	struct mgmt_pending_cmd *cmd;
> +	struct mgmt_rp_add_advertising rp;
> +
> +	BT_DBG("status %d", status);
> +
> +	hci_dev_lock(hdev);
> +
> +	cmd = pending_find(MGMT_OP_ADD_ADVERTISING, hdev);
> +
> +	if (status) {
> +		hci_dev_clear_flag(hdev, HCI_ADVERTISING_INSTANCE);
> +		memset(&hdev->adv_instance, 0, sizeof(hdev->adv_instance));
> +		advertising_removed(cmd ? cmd->sk : NULL, hdev, 1);
> +	}
> +
> +	if (!cmd)
> +		goto unlock;
> +
> +	rp.instance = 1;

I prefer if you use 0x01 for these.

> +
> +	if (status)
> +		mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode,
> +				mgmt_status(status));
> +	else
> +		mgmt_cmd_complete(cmd->sk, cmd->index, cmd->opcode,
> +				  mgmt_status(status), &rp, sizeof(rp));
> +
> +	mgmt_pending_remove(cmd);
> +
> +unlock:
> +	hci_dev_unlock(hdev);
> +}
> +
> +static int add_advertising(struct sock *sk, struct hci_dev *hdev,
> +			   void *data, u16 data_len)
> +{
> +	struct mgmt_cp_add_advertising *cp = data;
> +	struct mgmt_rp_add_advertising rp;
> +	u32 flags;
> +	u8 status;
> +	int err;
> +	struct mgmt_pending_cmd *cmd;
> +	struct hci_request req;
> +
> +	BT_DBG("%s", hdev->name);
> +
> +	status = mgmt_le_support(hdev);
> +	if (status)
> +		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
> +				       status);
> +
> +	flags = __le32_to_cpu(cp->flags);
> +
> +	/* The current implementation only supports adding one instance and
> +	 * doesn't support flags.
> +	 */
> +	if (cp->instance != 0x01 || flags)
> +		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
> +				       MGMT_STATUS_INVALID_PARAMS);
> +
> +	hci_dev_lock(hdev);
> +
> +	if (pending_find(MGMT_OP_ADD_ADVERTISING, hdev) ||
> +	    pending_find(MGMT_OP_SET_LE, hdev)) {
> +		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
> +				      MGMT_STATUS_BUSY);
> +		goto unlock;
> +	}
> +
> +	if (!adv_data_is_valid(hdev, flags, cp->data, cp->adv_data_len)) {
> +		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
> +				      MGMT_STATUS_INVALID_PARAMS);
> +		goto unlock;
> +	}
> +
> +	hdev->adv_instance.flags = flags;
> +	hdev->adv_instance.adv_data_len = cp->adv_data_len;
> +	hdev->adv_instance.scan_rsp_len = cp->scan_rsp_len;
> +
> +	if (cp->adv_data_len)
> +		memcpy(hdev->adv_instance.adv_data, cp->data, cp->adv_data_len);
> +
> +	if (cp->scan_rsp_len)
> +		memcpy(hdev->adv_instance.scan_rsp_data,
> +		       cp->data + cp->adv_data_len, cp->scan_rsp_len);
> +
> +	if (!hci_dev_test_and_set_flag(hdev, HCI_ADVERTISING_INSTANCE))
> +		advertising_added(sk, hdev, 1);

Use 0x01 as instance number.

> +
> +	/* If the HCI_ADVERTISING flag is set or the device isn't powered then
> +	 * we have no HCI communication to make. Simply return.
> +	 */
> +	if (!hdev_is_powered(hdev) ||
> +	    hci_dev_test_flag(hdev, HCI_ADVERTISING)) {
> +		rp.instance = 1;
> +		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
> +					MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
> +		goto unlock;
> +	}
> +
> +	/* We're good to go, update advertising data, parameters, and start
> +	 * advertising.
> +	 */
> +	cmd = mgmt_pending_add(sk, MGMT_OP_ADD_ADVERTISING, hdev, data,
> +			       data_len);
> +	if (!cmd) {
> +		err = -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	hci_req_init(&req, hdev);
> +
> +	update_adv_data(&req);
> +	enable_advertising(&req);
> +
> +	err = hci_req_run(&req, add_advertising_complete);
> +	if (err < 0)
> +		mgmt_pending_remove(cmd);
> +
> +unlock:
> +	hci_dev_unlock(hdev);
> +
> +	return err;
> +}
> +
> static const struct hci_mgmt_handler mgmt_handlers[] = {
> 	{ NULL }, /* 0x0000 (no command) */
> 	{ read_version,            MGMT_READ_VERSION_SIZE,
> @@ -6411,6 +6664,8 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
> 						HCI_MGMT_NO_HDEV |
> 						HCI_MGMT_UNTRUSTED },
> 	{ read_adv_features,       MGMT_READ_ADV_FEATURES_SIZE },
> +	{ add_advertising,	   MGMT_ADD_ADVERTISING_SIZE,
> +						HCI_MGMT_VAR_LEN },
> };
> 
> void mgmt_index_added(struct hci_dev *hdev)
> @@ -6582,7 +6837,8 @@ static int powered_update_hci(struct hci_dev *hdev)
> 			update_scan_rsp_data(&req);
> 		}
> 
> -		if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
> +		if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
> +		    hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))
> 			enable_advertising(&req);
> 
> 		restart_le_actions(&req);
> @@ -6694,7 +6950,13 @@ void mgmt_discoverable_timeout(struct hci_dev *hdev)
> 			    sizeof(scan), &scan);
> 	}
> 	update_class(&req);
> -	update_adv_data(&req);
> +
> +	/* Advertising instances don't use the global discoverable setting, so
> +	 * only update AD if advertising was enabled using Set Advertising.
> +	 */
> +	if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
> +		update_adv_data(&req);
> +
> 	hci_req_run(&req, NULL);
> 
> 	hdev->discov_timeout = 0;
> @@ -7595,7 +7857,8 @@ void mgmt_reenable_advertising(struct hci_dev *hdev)
> {
> 	struct hci_request req;
> 
> -	if (!hci_dev_test_flag(hdev, HCI_ADVERTISING))
> +	if (!hci_dev_test_flag(hdev, HCI_ADVERTISING) &&
> +	    !hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))
> 		return;
> 
> 	hci_req_init(&req, hdev);

Regards

Marcel

