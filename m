Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH] Add new method - service discovery to mgmt 
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1414084535-23864-2-git-send-email-jpawlowski@google.com>
Date: Thu, 23 Oct 2014 15:29:50 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <2CFD961F-C939-4667-8853-4F70C3B21A7E@holtmann.org>
References: <1414084535-23864-1-git-send-email-jpawlowski@google.com> <1414084535-23864-2-git-send-email-jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

I am doing a basic review first here. I will do a more thorough one once we get the basics in place.

Every single kernel patch needs a proper commit message explain in detail what you are doing. I want to be able read the commit message and then compare that you implement exactly the feature / fix you are describing here.

> ---
> include/net/bluetooth/hci_core.h |  16 ++
> include/net/bluetooth/mgmt.h     |  26 ++
> net/bluetooth/hci_core.c         |  42 ++++
> net/bluetooth/hci_event.c        |   3 +-
> net/bluetooth/mgmt.c             | 499 ++++++++++++++++++++++++++++++++++++++-
> 5 files changed, 582 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index b8685a7..d2b6661 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -143,6 +143,14 @@ struct oob_data {
> 	u8 randomizer256[16];
> };
> 
> +struct uuid_filter {
> +	struct list_head list;
> +	u8 range_method;
> +	s8 pathloss;
> +	s8 rssi;
> +	u8 uuid[16];
> +};
> +
> #define HCI_MAX_SHORT_NAME_LENGTH	10
> 
> /* Default LE RPA expiry time, 15 minutes */
> @@ -307,6 +315,10 @@ struct hci_dev {
> 	struct discovery_state	discovery;
> 	struct hci_conn_hash	conn_hash;
> 
> +	struct list_head discov_uuid_filter;
> +	bool service_filter_enabled;
> +	bool scan_restart;
> +
> 	struct list_head	mgmt_pending;
> 	struct list_head	blacklist;
> 	struct list_head	whitelist;
> @@ -334,6 +346,7 @@ struct hci_dev {
> 	unsigned long		dev_flags;
> 
> 	struct delayed_work	le_scan_disable;
> +	struct delayed_work	le_scan_restart;

the scan restart handling should be its own separate patch. I rather not have that mixed into this. I know it is related, but could be also useful without it. In addition you want a HCI_QUIRK setting to control it since on a lot of chips this is not even needed. And where it is not needed, you are just wasting energy to stop and restart scanning.

> 	__s8			adv_tx_power;
> 	__u8			adv_data[HCI_MAX_AD_LENGTH];
> @@ -1303,6 +1316,8 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
> #define DISCOV_INTERLEAVED_INQUIRY_LEN	0x04
> #define DISCOV_BREDR_INQUIRY_LEN	0x08
> 
> +#define DISCOV_LE_RESTART_DELAY msecs_to_jiffies(300)
> +
> int mgmt_control(struct sock *sk, struct msghdr *msg, size_t len);
> int mgmt_new_settings(struct hci_dev *hdev);
> void mgmt_index_added(struct hci_dev *hdev);
> @@ -1369,6 +1384,7 @@ void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
> 			 u16 max_interval, u16 latency, u16 timeout);
> void mgmt_reenable_advertising(struct hci_dev *hdev);
> void mgmt_smp_complete(struct hci_conn *conn, bool complete);
> +void clean_up_service_discovery(struct hci_dev *hdev);
> 
> u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
> 		      u16 to_multiplier);
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 414cd2f..8d652b3 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -495,6 +495,32 @@ struct mgmt_cp_set_public_address {
> } __packed;
> #define MGMT_SET_PUBLIC_ADDRESS_SIZE	6
> 
> +#define MGMT_OP_START_SERVICE_DISCOVERY		0x003A
> +
> +#define MGMT_RANGE_NONE     0X00
> +#define MGMT_RANGE_RSSI     0X01
> +#define MGMT_RANGE_PATHLOSS 0X02
> +
> +struct mgmt_uuid_filter {
> +	__u8 range_method;
> +	__s8 pathloss;
> +	__s8 rssi;
> +	__u8 uuid[16];
> +} __packed;

This is something we really need to discuss. I am not convinced that pathloss calculation should be done in the kernel. However that is something to discuss with a patch changing doc/mgmt-api.txt.

> +
> +struct mgmt_cp_start_service_discovery {
> +	__u8 type;
> +	__le16 filter_count;
> +	struct mgmt_uuid_filter filter[0];
> +} __packed;
> +#define MGMT_START_SERVICE_DISCOVERY_SIZE	1
> +
> +#define MGMT_OP_STOP_SERVICE_DISCOVERY		0x003B
> +struct mgmt_cp_stop_service_discovery {
> +	__u8 type;
> +} __packed;
> +#define MGMT_STOP_SERVICE_DISCOVERY_SIZE	1
> +
> #define MGMT_EV_CMD_COMPLETE		0x0001
> struct mgmt_ev_cmd_complete {
> 	__le16	opcode;
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index cb05d7f..af6bf39 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2580,6 +2580,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
> 		cancel_delayed_work(&hdev->service_cache);
> 
> 	cancel_delayed_work_sync(&hdev->le_scan_disable);
> +	cancel_delayed_work_sync(&hdev->le_scan_restart);
> 
> 	if (test_bit(HCI_MGMT, &hdev->dev_flags))
> 		cancel_delayed_work_sync(&hdev->rpa_expired);
> @@ -3846,6 +3847,7 @@ static void le_scan_disable_work(struct work_struct *work)
> 
> 	BT_DBG("%s", hdev->name);
> 
> +	clean_up_service_discovery(hdev);
> 	hci_req_init(&req, hdev);
> 
> 	hci_req_add_le_scan_disable(&req);
> @@ -3855,6 +3857,41 @@ static void le_scan_disable_work(struct work_struct *work)
> 		BT_ERR("Disable LE scanning request failed: err %d", err);
> }
> 
> +static void le_scan_restart_work_complete(struct hci_dev *hdev, u8 status)
> +{
> +	hdev->scan_restart = false;
> +
> +	if (status) {
> +		BT_ERR("Failed to restart LE scanning: status %d", status);
> +		return;
> +	}

The return is useless here. Might want to just print the error only.

> +}
> +
> +static void le_scan_restart_work(struct work_struct *work)
> +{
> +	struct hci_dev *hdev = container_of(work, struct hci_dev,
> +					    le_scan_restart.work);
> +	struct hci_request req;
> +	struct hci_cp_le_set_scan_enable cp;
> +	int err;
> +
> +	BT_DBG("%s", hdev->name);
> +
> +	hci_req_init(&req, hdev);
> +
> +	hci_req_add_le_scan_disable(&req);
> +
> +	memset(&cp, 0, sizeof(cp));
> +	cp.enable = LE_SCAN_ENABLE;
> +	hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
> +
> +	hdev->scan_restart = true;
> +
> +	err = hci_req_run(&req, le_scan_restart_work_complete);
> +	if (err)
> +		BT_ERR("Disable LE scanning request failed: err %d", err);
> +}
> +
> static void set_random_addr(struct hci_request *req, bdaddr_t *rpa)
> {
> 	struct hci_dev *hdev = req->hdev;
> @@ -4010,6 +4047,10 @@ struct hci_dev *hci_alloc_dev(void)
> 	mutex_init(&hdev->lock);
> 	mutex_init(&hdev->req_lock);
> 
> +	INIT_LIST_HEAD(&hdev->discov_uuid_filter);
> +	hdev->service_filter_enabled = false;
> +	hdev->scan_restart = false;
> +
> 	INIT_LIST_HEAD(&hdev->mgmt_pending);
> 	INIT_LIST_HEAD(&hdev->blacklist);
> 	INIT_LIST_HEAD(&hdev->whitelist);
> @@ -4032,6 +4073,7 @@ struct hci_dev *hci_alloc_dev(void)
> 	INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
> 	INIT_DELAYED_WORK(&hdev->discov_off, hci_discov_off);
> 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
> +	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart_work);
> 
> 	skb_queue_head_init(&hdev->rx_q);
> 	skb_queue_head_init(&hdev->cmd_q);
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 9629153..b372b02 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1155,7 +1155,8 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
> 		/* Cancel this timer so that we don't try to disable scanning
> 		 * when it's already disabled.
> 		 */
> -		cancel_delayed_work(&hdev->le_scan_disable);
> +		if(!hdev->scan_restart)
> +			cancel_delayed_work(&hdev->le_scan_disable);

Please obey the coding style "if (!hdev..)".

> 
> 		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 9c4daf7..08d48a7 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -93,6 +93,8 @@ static const u16 mgmt_commands[] = {
> 	MGMT_OP_READ_CONFIG_INFO,
> 	MGMT_OP_SET_EXTERNAL_CONFIG,
> 	MGMT_OP_SET_PUBLIC_ADDRESS,
> +	MGMT_OP_START_SERVICE_DISCOVERY,
> +	MGMT_OP_STOP_SERVICE_DISCOVERY
> };
> 
> static const u16 mgmt_events[] = {
> @@ -1258,6 +1260,26 @@ static void clean_up_hci_complete(struct hci_dev *hdev, u8 status)
> 	}
> }
> 
> +void clean_up_service_discovery(struct hci_dev *hdev)
> +{
> +	if (hdev->service_filter_enabled) {
> +		struct uuid_filter *filterptr = NULL;
> +		struct uuid_filter *tmp = NULL;
> +
> +		hdev->service_filter_enabled = false;
> +		cancel_delayed_work_sync(&hdev->le_scan_restart);
> +
> +		if(!list_empty(&hdev->discov_uuid_filter)) {

Here as well. Space after if.

> +			list_for_each_entry_safe(filterptr, tmp,
> +				&hdev->discov_uuid_filter, list)
> +			{

The { has to be on the previous line and the multi-line parameters need to be properly aligned.

> +				__list_del_entry(&(filterptr->list));
> +				kfree(filterptr);
> +			}
> +		}
> +	}
> +}

The whole function could need some restructure. For example.

	if (!hdev->service_filter_enabled)
		return;

And of course service_filter_enabled could be just a hdev->dev_flags.

Same as with this:

	if (list_empty())
		return;


> +
> static bool hci_stop_discovery(struct hci_request *req)
> {
> 	struct hci_dev *hdev = req->hdev;
> @@ -1270,6 +1292,7 @@ static bool hci_stop_discovery(struct hci_request *req)
> 			hci_req_add(req, HCI_OP_INQUIRY_CANCEL, 0, NULL);
> 		} else {
> 			cancel_delayed_work(&hdev->le_scan_disable);
> +			clean_up_service_discovery(hdev);
> 			hci_req_add_le_scan_disable(req);
> 		}
> 
> @@ -5641,6 +5664,345 @@ unlock:
> 	return err;
> }
> 
> +static int mgmt_start_service_discovery_failed(struct hci_dev *hdev, u8 status)
> +{
> +	struct pending_cmd *cmd;
> +	u8 type;
> +	int err;
> +
> +	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> +
> +	cmd = mgmt_pending_find(MGMT_OP_START_SERVICE_DISCOVERY, hdev);
> +	if (!cmd)
> +		return -ENOENT;
> +
> +	type = hdev->discovery.type;
> +
> +	err = cmd_complete(cmd->sk, hdev->id, cmd->opcode, mgmt_status(status),
> +			   &type, sizeof(type));
> +	mgmt_pending_remove(cmd);
> +
> +	return err;
> +}
> +
> +static void start_service_discovery_complete(struct hci_dev *hdev, u8 status)
> +{
> +	unsigned long timeout = 0;
> +
> +	BT_DBG("status %d", status);
> +
> +	if (status) {
> +		hci_dev_lock(hdev);
> +		mgmt_start_service_discovery_failed(hdev, status);
> +		hci_dev_unlock(hdev);
> +		return;
> +	}
> +
> +	hci_dev_lock(hdev);
> +	hci_discovery_set_state(hdev, DISCOVERY_FINDING);
> +	hci_dev_unlock(hdev);
> +
> +	switch (hdev->discovery.type) {
> +	case DISCOV_TYPE_LE:
> +		timeout = msecs_to_jiffies(DISCOV_LE_TIMEOUT);
> +		break;
> +
> +	case DISCOV_TYPE_INTERLEAVED:
> +		timeout = msecs_to_jiffies(hdev->discov_interleaved_timeout);
> +		break;
> +
> +	case DISCOV_TYPE_BREDR:
> +		break;
> +
> +	default:
> +		BT_ERR("Invalid discovery type %d", hdev->discovery.type);
> +	}
> +
> +	if (!timeout)
> +		return;
> +
> +	queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable, timeout);
> +}
> +
> +static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
> +			   void *data, u16 len)
> +{
> +	struct mgmt_cp_start_service_discovery *cp = data;
> +	struct pending_cmd *cmd;
> +	struct hci_cp_le_set_scan_param param_cp;
> +	struct hci_cp_le_set_scan_enable enable_cp;
> +	struct hci_cp_inquiry inq_cp;
> +	struct hci_request req;
> +	/* General inquiry access code (GIAC) */
> +	u8 lap[3] = { 0x33, 0x8b, 0x9e };
> +	u8 status, own_addr_type;
> +	int i, err;
> +	u16 filter_count, expected_len;
> +
> +	BT_DBG("%s", hdev->name);
> +
> +	filter_count = __le16_to_cpu(cp->filter_count);
> +
> +	expected_len = sizeof(*cp) + filter_count * sizeof(struct mgmt_uuid_filter);
> +	if (expected_len != len) {
> +		BT_ERR("start_service_discovery: expected %u bytes, got %u bytes",
> +		       expected_len, len);
> +
> +		return cmd_status(sk, hdev->id, MGMT_OP_START_SERVICE_DISCOVERY,
> +				  MGMT_STATUS_INVALID_PARAMS);
> +	}
> +
> +	hci_dev_lock(hdev);
> +
> +	if (!hdev_is_powered(hdev)) {
> +		err = cmd_status(sk, hdev->id, MGMT_OP_START_SERVICE_DISCOVERY,
> +				 MGMT_STATUS_NOT_POWERED);
> +		goto failed;
> +	}
> +
> +	if (test_bit(HCI_PERIODIC_INQ, &hdev->dev_flags)) {
> +		err = cmd_status(sk, hdev->id, MGMT_OP_START_SERVICE_DISCOVERY,
> +				 MGMT_STATUS_BUSY);
> +		goto failed;
> +	}
> +
> +	if (hdev->discovery.state != DISCOVERY_STOPPED) {
> +		err = cmd_status(sk, hdev->id, MGMT_OP_START_SERVICE_DISCOVERY,
> +				 MGMT_STATUS_BUSY);
> +		goto failed;
> +	}
> +
> +	cmd = mgmt_pending_add(sk, MGMT_OP_START_SERVICE_DISCOVERY, hdev, NULL, 0);
> +	if (!cmd) {
> +		err = -ENOMEM;
> +		goto failed;
> +	}
> +
> +	hdev->discovery.type = cp->type;
> +
> +	hci_req_init(&req, hdev);
> +
> +	switch (hdev->discovery.type) {
> +	case DISCOV_TYPE_BREDR:
> +		status = mgmt_bredr_support(hdev);
> +		if (status) {
> +			err = cmd_status(sk, hdev->id, MGMT_OP_START_SERVICE_DISCOVERY,
> +					 status);
> +			mgmt_pending_remove(cmd);
> +			goto failed;
> +		}
> +
> +		if (test_bit(HCI_INQUIRY, &hdev->flags)) {
> +			err = cmd_status(sk, hdev->id, MGMT_OP_START_SERVICE_DISCOVERY,
> +					 MGMT_STATUS_BUSY);
> +			mgmt_pending_remove(cmd);
> +			goto failed;
> +		}
> +
> +		hci_inquiry_cache_flush(hdev);
> +
> +		memset(&inq_cp, 0, sizeof(inq_cp));
> +		memcpy(&inq_cp.lap, lap, sizeof(inq_cp.lap));
> +		inq_cp.length = DISCOV_BREDR_INQUIRY_LEN;
> +		hci_req_add(&req, HCI_OP_INQUIRY, sizeof(inq_cp), &inq_cp);
> +		break;
> +
> +	case DISCOV_TYPE_LE:
> +	case DISCOV_TYPE_INTERLEAVED:
> +		status = mgmt_le_support(hdev);
> +		if (status) {
> +			err = cmd_status(sk, hdev->id, MGMT_OP_START_SERVICE_DISCOVERY,
> +					 status);
> +			mgmt_pending_remove(cmd);
> +			goto failed;
> +		}
> +
> +		if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
> +		    !test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
> +			err = cmd_status(sk, hdev->id, MGMT_OP_START_SERVICE_DISCOVERY,
> +					 MGMT_STATUS_NOT_SUPPORTED);
> +			mgmt_pending_remove(cmd);
> +			goto failed;
> +		}
> +
> +		if (test_bit(HCI_LE_ADV, &hdev->dev_flags)) {
> +			/* Don't let discovery abort an outgoing
> +			 * connection attempt that's using directed
> +			 * advertising.
> +			 */
> +			if (hci_conn_hash_lookup_state(hdev, LE_LINK,
> +						       BT_CONNECT)) {
> +				err = cmd_status(sk, hdev->id,
> +						 MGMT_OP_START_SERVICE_DISCOVERY,
> +						 MGMT_STATUS_REJECTED);
> +				mgmt_pending_remove(cmd);
> +				goto failed;
> +			}
> +
> +			disable_advertising(&req);
> +		}
> +
> +		/* If controller is scanning, it means the background scanning
> +		 * is running. Thus, we should temporarily stop it in order to
> +		 * set the discovery scanning parameters.
> +		 */
> +		if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
> +			hci_req_add_le_scan_disable(&req);
> +
> +		memset(&param_cp, 0, sizeof(param_cp));
> +
> +		/* All active scans will be done with either a resolvable
> +		 * private address (when privacy feature has been enabled)
> +		 * or unresolvable private address.
> +		 */
> +		err = hci_update_random_address(&req, true, &own_addr_type);
> +		if (err < 0) {
> +			err = cmd_status(sk, hdev->id, MGMT_OP_START_SERVICE_DISCOVERY,
> +					 MGMT_STATUS_FAILED);
> +			mgmt_pending_remove(cmd);
> +			goto failed;
> +		}
> +
> +		param_cp.type = LE_SCAN_ACTIVE;
> +		param_cp.interval = cpu_to_le16(DISCOV_LE_SCAN_INT);
> +		param_cp.window = cpu_to_le16(DISCOV_LE_SCAN_WIN);
> +		param_cp.own_address_type = own_addr_type;
> +		hci_req_add(&req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
> +			    &param_cp);
> +
> +		memset(&enable_cp, 0, sizeof(enable_cp));
> +		enable_cp.enable = LE_SCAN_ENABLE;
> +		enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
> +		hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
> +			    &enable_cp);
> +		break;
> +
> +	default:
> +		err = cmd_status(sk, hdev->id, MGMT_OP_START_SERVICE_DISCOVERY,
> +				 MGMT_STATUS_INVALID_PARAMS);
> +		mgmt_pending_remove(cmd);
> +		goto failed;
> +	}

Feels like we are duplicated a lot of code. A separate patch splitting this out into its own function seems to be needed here.

> +
> +	for (i = 0; i < filter_count; i++) {
> +		struct mgmt_uuid_filter *key = &cp->filter[i];
> +		struct uuid_filter *tmp_uuid;
> +
> +		tmp_uuid = kmalloc(sizeof(struct uuid_filter), GFP_KERNEL);
> +		if (!tmp_uuid)
> +			return -ENOMEM;
> +
> +		memcpy(tmp_uuid->uuid, key->uuid, 16);
> +		tmp_uuid->range_method = key->range_method;
> +		tmp_uuid->pathloss = key->pathloss;
> +		tmp_uuid->rssi = key->rssi;
> +		INIT_LIST_HEAD( &tmp_uuid->list ) ;
> +
> +		list_add(&tmp_uuid->list, &hdev->discov_uuid_filter);
> +	}
> +	hdev->service_filter_enabled = true;
> +
> +	err = hci_req_run(&req, start_service_discovery_complete);
> +	if (err < 0)
> +		mgmt_pending_remove(cmd);
> +	else
> +		hci_discovery_set_state(hdev, DISCOVERY_STARTING);
> +
> +failed:
> +	hci_dev_unlock(hdev);
> +	return err;
> +}
> +
> +static int mgmt_stop_service_discovery_failed(struct hci_dev *hdev, u8 status)
> +{
> +	struct pending_cmd *cmd;
> +	int err;
> +
> +	cmd = mgmt_pending_find(MGMT_OP_STOP_SERVICE_DISCOVERY, hdev);
> +	if (!cmd)
> +		return -ENOENT;
> +
> +	hdev->service_filter_enabled = false;
> +	err = cmd_complete(cmd->sk, hdev->id, cmd->opcode, mgmt_status(status),
> +			   &hdev->discovery.type, sizeof(hdev->discovery.type));
> +	mgmt_pending_remove(cmd);
> +
> +	return err;
> +}
> +
> +static void stop_service_discovery_complete(struct hci_dev *hdev, u8 status)
> +{
> +	BT_DBG("status %d", status);
> +
> +	hci_dev_lock(hdev);
> +
> +	if (status) {
> +		mgmt_stop_service_discovery_failed(hdev, status);
> +		goto unlock;
> +	}
> +
> +	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> +
> +unlock:
> +	hci_dev_unlock(hdev);
> +}
> +
> +static int stop_service_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
> +			  u16 len)
> +{
> +	struct mgmt_cp_stop_service_discovery *mgmt_cp = data;
> +	struct pending_cmd *cmd;
> +	struct hci_request req;
> +	int err;
> +
> +	BT_DBG("%s", hdev->name);
> +
> +	hci_dev_lock(hdev);
> +
> +	if (!hci_discovery_active(hdev)) {
> +		err = cmd_complete(sk, hdev->id, MGMT_OP_STOP_SERVICE_DISCOVERY,
> +				   MGMT_STATUS_REJECTED, &mgmt_cp->type,
> +				   sizeof(mgmt_cp->type));
> +		goto unlock;
> +	}
> +
> +	if (hdev->discovery.type != mgmt_cp->type) {
> +		err = cmd_complete(sk, hdev->id, MGMT_OP_STOP_SERVICE_DISCOVERY,
> +				   MGMT_STATUS_INVALID_PARAMS, &mgmt_cp->type,
> +				   sizeof(mgmt_cp->type));
> +		goto unlock;
> +	}
> +
> +	cmd = mgmt_pending_add(sk, MGMT_OP_STOP_SERVICE_DISCOVERY, hdev, NULL, 0);
> +	if (!cmd) {
> +		err = -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	hci_req_init(&req, hdev);
> +
> +	hci_stop_discovery(&req);
> +
> +	err = hci_req_run(&req, stop_service_discovery_complete);
> +	if (!err) {
> +		hci_discovery_set_state(hdev, DISCOVERY_STOPPING);
> +		goto unlock;
> +	}
> +
> +	mgmt_pending_remove(cmd);
> +
> +	/* If no HCI commands were sent we're done */
> +	if (err == -ENODATA) {
> +		err = cmd_complete(sk, hdev->id, MGMT_OP_STOP_SERVICE_DISCOVERY, 0,
> +				   &mgmt_cp->type, sizeof(mgmt_cp->type));
> +		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
> +	}
> +
> +unlock:
> +	hci_dev_unlock(hdev);
> +	return err;
> +}
> +
> static const struct mgmt_handler {
> 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
> 		     u16 data_len);
> @@ -5705,6 +6067,8 @@ static const struct mgmt_handler {
> 	{ read_config_info,       false, MGMT_READ_CONFIG_INFO_SIZE },
> 	{ set_external_config,    false, MGMT_SET_EXTERNAL_CONFIG_SIZE },
> 	{ set_public_address,     false, MGMT_SET_PUBLIC_ADDRESS_SIZE },
> +	{ start_service_discovery,true, MGMT_START_SERVICE_DISCOVERY_SIZE },
> +	{ stop_service_discovery, false, MGMT_STOP_SERVICE_DISCOVERY_SIZE },

Please the fields here.

> };
> 
> int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
> @@ -6774,6 +7138,85 @@ void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
> 	mgmt_pending_remove(cmd);
> }
> 
> +struct parsed_uuid {
> +	struct list_head list;
> +	u8 uuid[16];
> +};
> +
> +//static u8 baseUUID[16] = {0x00,0x00,0x00,0x00,/*-*/0x00,0x00,/*-*/0x10,0x00,/*-*/ 0x80,0x00,/*-*/0x00,0x80,0x5f,0x9b,0x34,0xfb};
> +static u8 reverse_base_uuid[16] = {0xfb,0x34,0x9b,0x5f,0x80,0x00,0x00,0x80,0x00,0x10,0x00,0x00,0x00,0x00,0x00,0x00};

No. Leftover comment, not const, wrong coding style and generally no explanation on why we would be doing this in the first place.

> +
> +static void add_uuid_to_list(struct list_head *uuids, u8 *uuid) {

Coding style. The { belongs in the next line here.

> +	struct parsed_uuid *tmp_uuid;

Empty line here.

> +	tmp_uuid = kmalloc(sizeof(struct parsed_uuid), GFP_KERNEL);
> +	if (tmp_uuid == NULL)
> +		return; //TODO: how to handle if there's no memory?
> +
> +	memcpy(tmp_uuid->uuid, uuid, 16);
> +	INIT_LIST_HEAD(&tmp_uuid->list);
> +	list_add(&tmp_uuid->list, uuids);
> +}
> +
> +static void eir_parse(u8 *eir, u8 eir_len, struct list_head *uuids,
> +	u8 *txpwr_present, s8 *txpwr)

Coding style. Align the multi-line parameters.

> +{
> +	size_t offset;
> +	u8 uuid[16];
> +	int loop;
> +
> +	offset = 0;
> +	while (offset < eir_len) {
> +		uint8_t field_len = eir[0];
> +	
> +		/* Check for the end of EIR */
> +		if (field_len == 0)
> +			break;
> +
> +		if (offset + field_len > eir_len)
> +			goto failed;
> +
> +		switch (eir[1]) {
> +		case EIR_TX_POWER:
> +			*txpwr_present = 1;
> +			*txpwr = eir[2];
> +			break;
> +		case EIR_UUID16_ALL:
> +		case EIR_UUID16_SOME:
> +			for(loop = 0; loop+3<=field_len;loop+=2) {

Empty space after for. And spaces between + and <=. And after ;.

> +				memcpy(uuid, reverse_base_uuid, 16);
> +				uuid[13] = eir[loop + 3];
> +				uuid[12] = eir[loop + 2];
> +				add_uuid_to_list(uuids, uuid);
> +			}
> +			break;
> +		case EIR_UUID32_ALL:
> +		case EIR_UUID32_SOME:
> +			for(loop = 0; loop+5<=field_len;loop+=4) {
> +				memcpy(uuid, reverse_base_uuid, 16);
> +				uuid[15] = eir[loop + 5];
> +				uuid[14] = eir[loop + 4];
> +				uuid[13] = eir[loop + 3];
> +				uuid[12] = eir[loop + 2];
> +				add_uuid_to_list(uuids, uuid);
> +			}
> +			break;
> +		case EIR_UUID128_ALL:
> +		case EIR_UUID128_SOME:
> +			for(loop = 0; loop+17<=field_len;loop+=4) {
> +				memcpy(uuid, eir + loop + 2, 16);
> +				add_uuid_to_list(uuids, uuid);
> +			}
> +			break;
> +		}
> +
> +		offset += field_len + 1;
> +		eir += field_len + 1;
> +	}

And as a site note, LE has service data and service solicitation that also has UUIDs in there.

> +
> +failed:
> +	offset = 8;
> +}
> +
> void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
> 		       u8 addr_type, u8 *dev_class, s8 rssi, u32 flags,
> 		       u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len)
> @@ -6819,7 +7262,52 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
> 	ev->eir_len = cpu_to_le16(eir_len + scan_rsp_len);
> 	ev_size = sizeof(*ev) + eir_len + scan_rsp_len;
> 
> -	mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
> +	if(hdev->service_filter_enabled) {

Space after if. You have a few of these, please fix them all.

> +		LIST_HEAD(uuids);
> +		s8 txpwr;
> +		u8 txpwr_present = 0;
> +		struct uuid_filter *filterptr = NULL;
> +		struct parsed_uuid *uuidptr = NULL;
> +		struct parsed_uuid *tmp = NULL;
> +		bool service_match = false, full_match = false;
> +
> +		eir_parse(eir, eir_len, &uuids, &txpwr_present, &txpwr);
> +		if(!list_empty(&uuids)) {
> +			list_for_each_entry_safe(uuidptr, tmp, &uuids, list)
> +			{
> +				list_for_each_entry(filterptr, &hdev->discov_uuid_filter, list)
> +				{
> +					if(memcmp(filterptr->uuid, uuidptr->uuid, 16) == 0) {
> +						service_match = true;
> +
> +						if( filterptr->range_method == MGMT_RANGE_NONE) {

No empty space after (

> +							full_match = true;
> +						} else if ( (filterptr->range_method & MGMT_RANGE_PATHLOSS)
> +							&& txpwr_present
> +							&& (txpwr - rssi) <= filterptr->pathloss ) {
> +							full_match = true;
> +						} else if( (filterptr->range_method & MGMT_RANGE_RSSI)
> +							      && rssi >= filterptr->rssi ) {
> +							full_match = true;
> +						}
> +
> +					}
> +				}

This needs to be changed to fit into the 80 chars per line.

> +				__list_del_entry(&(uuidptr->list));
> +				kfree(uuidptr);
> +			}
> +		}
> +
> +		if(full_match) {
> +			mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
> +		}
> +	if(service_match) {
> +			queue_delayed_work(hdev->workqueue, &hdev->le_scan_restart,
> +			   DISCOV_LE_RESTART_DELAY);

Coding style for parameter alignment on second line. Please make sure you get them all fixed.


> +		}
> +	} else {
> +		mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
> +	}
> }
> 
> void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
> @@ -6852,10 +7340,15 @@ void mgmt_discovering(struct hci_dev *hdev, u8 discovering)
> 
> 	BT_DBG("%s discovering %u", hdev->name, discovering);
> 
> -	if (discovering)
> +	if (discovering) {
> 		cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev);
> -	else
> +		if(cmd == NULL)
> +			cmd = mgmt_pending_find(MGMT_OP_START_SERVICE_DISCOVERY, hdev);
> +	} else {
> 		cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, hdev);
> +		if(cmd == NULL)
> +			cmd = mgmt_pending_find(MGMT_OP_STOP_SERVICE_DISCOVERY, hdev);
> +	}
> 
> 	if (cmd != NULL) {
> 		u8 type = hdev->discovery.type;

Regards

Marcel

