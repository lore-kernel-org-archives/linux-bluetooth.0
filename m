Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH v1 4/4] Introducing start service discovery and stop service discovery methods.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1414442504-14290-5-git-send-email-jpawlowski@google.com>
Date: Tue, 28 Oct 2014 09:47:57 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <68591BA0-E3CB-4F13-B035-6229AB69DBD2@holtmann.org>
References: <1414442504-14290-1-git-send-email-jpawlowski@google.com> <1414442504-14290-5-git-send-email-jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

we are not accepting patches that do not have a detailed commit message explaining what is done here. Kernel patches are a lot more stricter than userspace patches in this regard.

Also I can not accept any kernel patch without signed-off-by.

> On Oct 27, 2014, at 13:41, Jakub Pawlowski <jpawlowski@google.com> wrote:
> 
> ---
> include/net/bluetooth/hci_core.h |  13 ++
> include/net/bluetooth/mgmt.h     |  26 +++
> net/bluetooth/hci_core.c         |   3 +
> net/bluetooth/mgmt.c             | 341 ++++++++++++++++++++++++++++++++-------
> 4 files changed, 323 insertions(+), 60 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 0865bc1..d2b6661 100644
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
> @@ -307,6 +315,8 @@ struct hci_dev {
> 	struct discovery_state	discovery;
> 	struct hci_conn_hash	conn_hash;
> 
> +	struct list_head discov_uuid_filter;
> +	bool service_filter_enabled;

I think using hdev->dev_flags or some other kind of discovery flags/state would be a lot simpler here.

> 	bool scan_restart;
> 
> 	struct list_head	mgmt_pending;
> @@ -1306,6 +1316,8 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
> #define DISCOV_INTERLEAVED_INQUIRY_LEN	0x04
> #define DISCOV_BREDR_INQUIRY_LEN	0x08
> 
> +#define DISCOV_LE_RESTART_DELAY msecs_to_jiffies(300)
> +

This should be in the patch that handles the restart quirk.

> int mgmt_control(struct sock *sk, struct msghdr *msg, size_t len);
> int mgmt_new_settings(struct hci_dev *hdev);
> void mgmt_index_added(struct hci_dev *hdev);
> @@ -1372,6 +1384,7 @@ void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
> 			 u16 max_interval, u16 latency, u16 timeout);
> void mgmt_reenable_advertising(struct hci_dev *hdev);
> void mgmt_smp_complete(struct hci_conn *conn, bool complete);
> +void clean_up_service_discovery(struct hci_dev *hdev);
> 
> u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
> 		      u16 to_multiplier);
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 414cd2f..46588d7 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -495,6 +495,32 @@ struct mgmt_cp_set_public_address {
> } __packed;
> #define MGMT_SET_PUBLIC_ADDRESS_SIZE	6
> 
> +#define MGMT_OP_START_SERVICE_DISCOVERY		0x003A
> +#define MGMT_START_SERVICE_DISCOVERY_SIZE	1
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
> +
> +struct mgmt_cp_start_service_discovery {
> +	__u8 type;
> +	__le16 filter_count;
> +	struct mgmt_uuid_filter filter[0];
> +} __packed;
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
> index 343279c..2bbcadb 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3848,6 +3848,7 @@ static void le_scan_disable_work(struct work_struct *work)
> 	BT_DBG("%s", hdev->name);
> 
> 	cancel_delayed_work_sync(&hdev->le_scan_restart);
> +	clean_up_service_discovery(hdev);
> 
> 	hci_req_init(&req, hdev);
> 
> @@ -4043,6 +4044,8 @@ struct hci_dev *hci_alloc_dev(void)
> 	hdev->conn_info_min_age = DEFAULT_CONN_INFO_MIN_AGE;
> 	hdev->conn_info_max_age = DEFAULT_CONN_INFO_MAX_AGE;
> 
> +	INIT_LIST_HEAD(&hdev->discov_uuid_filter);
> +	hdev->service_filter_enabled = false;
> 	hdev->scan_restart = false;
> 
> 	mutex_init(&hdev->lock);
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index f2b80b7..9d08f83 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -93,6 +93,8 @@ static const u16 mgmt_commands[] = {
> 	MGMT_OP_READ_CONFIG_INFO,
> 	MGMT_OP_SET_EXTERNAL_CONFIG,
> 	MGMT_OP_SET_PUBLIC_ADDRESS,
> +	MGMT_OP_START_SERVICE_DISCOVERY,
> +	MGMT_OP_STOP_SERVICE_DISCOVERY,
> };
> 
> static const u16 mgmt_events[] = {
> @@ -1258,6 +1260,26 @@ static void clean_up_hci_complete(struct hci_dev *hdev, u8 status)
> 	}
> }
> 
> +void clean_up_service_discovery(struct hci_dev *hdev)
> +{
> +	struct uuid_filter *filter = NULL;
> +	struct uuid_filter *tmp = NULL;
> +
> +	if (!hdev->service_filter_enabled)
> +		return;
> +
> +	hdev->service_filter_enabled = false;
> +	cancel_delayed_work_sync(&hdev->le_scan_restart);
> +
> +	if (list_empty(&hdev->discov_uuid_filter))
> +		return;
> +
> +	list_for_each_entry_safe(filter, tmp, &hdev->discov_uuid_filter, list) {
> +		__list_del_entry(&filter->list);
> +		kfree(filter);
> +	}
> +}
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
> @@ -5675,6 +5698,53 @@ unlock:
> 	return err;
> }
> 
> +static void start_service_discovery_complete(struct hci_dev *hdev, u8 status)
> +{
> +	generic_start_discovery_complete(hdev, status,
> +					 MGMT_OP_START_SERVICE_DISCOVERY);
> +}
> +
> +static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
> +				   void *data, u16 len)
> +{
> +	struct mgmt_cp_start_service_discovery *cp = data;
> +	u16 expected_len, filter_count;
> +
> +	BT_DBG("%s", hdev->name);
> +
> +	filter_count = __le16_to_cpu(cp->filter_count);
> +
> +	expected_len = sizeof(*cp) +
> +		       filter_count * sizeof(struct mgmt_uuid_filter);
> +	if (expected_len != len) {
> +		BT_ERR("start_service_discovery: expected %u, got %u bytes",
> +		       expected_len, len);
> +
> +		return cmd_status(sk, hdev->id, MGMT_OP_START_SERVICE_DISCOVERY,
> +				  MGMT_STATUS_INVALID_PARAMS);
> +	}
> +
> +	return generic_start_discovery(sk, hdev,
> +				       MGMT_OP_START_SERVICE_DISCOVERY,
> +				       start_service_discovery_complete,
> +				       cp->type, cp->filter, cp->filter_count);
> +}
> +
> +static void stop_service_discovery_complete(struct hci_dev *hdev, u8 status)
> +{
> +	generic_stop_discovery_complete(hdev, status,
> +					MGMT_OP_STOP_SERVICE_DISCOVERY);
> +}
> +
> +static int stop_service_discovery(struct sock *sk, struct hci_dev *hdev,
> +				  void *data, u16 len)
> +{
> +	struct mgmt_cp_stop_service_discovery *mgmt_cp = data;
> +
> +	return generic_stop_discovery(sk, hdev, mgmt_cp->type,
> +					stop_service_discovery_complete);
> +}
> +
> static const struct mgmt_handler {
> 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
> 		     u16 data_len);
> @@ -5682,63 +5752,65 @@ static const struct mgmt_handler {
> 	size_t data_len;
> } mgmt_handlers[] = {
> 	{ NULL }, /* 0x0000 (no command) */
> -	{ read_version,           false, MGMT_READ_VERSION_SIZE },
> -	{ read_commands,          false, MGMT_READ_COMMANDS_SIZE },
> -	{ read_index_list,        false, MGMT_READ_INDEX_LIST_SIZE },
> -	{ read_controller_info,   false, MGMT_READ_INFO_SIZE },
> -	{ set_powered,            false, MGMT_SETTING_SIZE },
> -	{ set_discoverable,       false, MGMT_SET_DISCOVERABLE_SIZE },
> -	{ set_connectable,        false, MGMT_SETTING_SIZE },
> -	{ set_fast_connectable,   false, MGMT_SETTING_SIZE },
> -	{ set_bondable,           false, MGMT_SETTING_SIZE },
> -	{ set_link_security,      false, MGMT_SETTING_SIZE },
> -	{ set_ssp,                false, MGMT_SETTING_SIZE },
> -	{ set_hs,                 false, MGMT_SETTING_SIZE },
> -	{ set_le,                 false, MGMT_SETTING_SIZE },
> -	{ set_dev_class,          false, MGMT_SET_DEV_CLASS_SIZE },
> -	{ set_local_name,         false, MGMT_SET_LOCAL_NAME_SIZE },
> -	{ add_uuid,               false, MGMT_ADD_UUID_SIZE },
> -	{ remove_uuid,            false, MGMT_REMOVE_UUID_SIZE },
> -	{ load_link_keys,         true,  MGMT_LOAD_LINK_KEYS_SIZE },
> -	{ load_long_term_keys,    true,  MGMT_LOAD_LONG_TERM_KEYS_SIZE },
> -	{ disconnect,             false, MGMT_DISCONNECT_SIZE },
> -	{ get_connections,        false, MGMT_GET_CONNECTIONS_SIZE },
> -	{ pin_code_reply,         false, MGMT_PIN_CODE_REPLY_SIZE },
> -	{ pin_code_neg_reply,     false, MGMT_PIN_CODE_NEG_REPLY_SIZE },
> -	{ set_io_capability,      false, MGMT_SET_IO_CAPABILITY_SIZE },
> -	{ pair_device,            false, MGMT_PAIR_DEVICE_SIZE },
> -	{ cancel_pair_device,     false, MGMT_CANCEL_PAIR_DEVICE_SIZE },
> -	{ unpair_device,          false, MGMT_UNPAIR_DEVICE_SIZE },
> -	{ user_confirm_reply,     false, MGMT_USER_CONFIRM_REPLY_SIZE },
> -	{ user_confirm_neg_reply, false, MGMT_USER_CONFIRM_NEG_REPLY_SIZE },
> -	{ user_passkey_reply,     false, MGMT_USER_PASSKEY_REPLY_SIZE },
> -	{ user_passkey_neg_reply, false, MGMT_USER_PASSKEY_NEG_REPLY_SIZE },
> -	{ read_local_oob_data,    false, MGMT_READ_LOCAL_OOB_DATA_SIZE },
> -	{ add_remote_oob_data,    true,  MGMT_ADD_REMOTE_OOB_DATA_SIZE },
> -	{ remove_remote_oob_data, false, MGMT_REMOVE_REMOTE_OOB_DATA_SIZE },
> -	{ start_discovery,        false, MGMT_START_DISCOVERY_SIZE },
> -	{ stop_discovery,         false, MGMT_STOP_DISCOVERY_SIZE },
> -	{ confirm_name,           false, MGMT_CONFIRM_NAME_SIZE },
> -	{ block_device,           false, MGMT_BLOCK_DEVICE_SIZE },
> -	{ unblock_device,         false, MGMT_UNBLOCK_DEVICE_SIZE },
> -	{ set_device_id,          false, MGMT_SET_DEVICE_ID_SIZE },
> -	{ set_advertising,        false, MGMT_SETTING_SIZE },
> -	{ set_bredr,              false, MGMT_SETTING_SIZE },
> -	{ set_static_address,     false, MGMT_SET_STATIC_ADDRESS_SIZE },
> -	{ set_scan_params,        false, MGMT_SET_SCAN_PARAMS_SIZE },
> -	{ set_secure_conn,        false, MGMT_SETTING_SIZE },
> -	{ set_debug_keys,         false, MGMT_SETTING_SIZE },
> -	{ set_privacy,            false, MGMT_SET_PRIVACY_SIZE },
> -	{ load_irks,              true,  MGMT_LOAD_IRKS_SIZE },
> -	{ get_conn_info,          false, MGMT_GET_CONN_INFO_SIZE },
> -	{ get_clock_info,         false, MGMT_GET_CLOCK_INFO_SIZE },
> -	{ add_device,             false, MGMT_ADD_DEVICE_SIZE },
> -	{ remove_device,          false, MGMT_REMOVE_DEVICE_SIZE },
> -	{ load_conn_param,        true,  MGMT_LOAD_CONN_PARAM_SIZE },
> -	{ read_unconf_index_list, false, MGMT_READ_UNCONF_INDEX_LIST_SIZE },
> -	{ read_config_info,       false, MGMT_READ_CONFIG_INFO_SIZE },
> -	{ set_external_config,    false, MGMT_SET_EXTERNAL_CONFIG_SIZE },
> -	{ set_public_address,     false, MGMT_SET_PUBLIC_ADDRESS_SIZE },
> +	{ read_version,            false, MGMT_READ_VERSION_SIZE },
> +	{ read_commands,           false, MGMT_READ_COMMANDS_SIZE },
> +	{ read_index_list,         false, MGMT_READ_INDEX_LIST_SIZE },
> +	{ read_controller_info,    false, MGMT_READ_INFO_SIZE },
> +	{ set_powered,             false, MGMT_SETTING_SIZE },
> +	{ set_discoverable,        false, MGMT_SET_DISCOVERABLE_SIZE },
> +	{ set_connectable,         false, MGMT_SETTING_SIZE },
> +	{ set_fast_connectable,    false, MGMT_SETTING_SIZE },
> +	{ set_bondable,            false, MGMT_SETTING_SIZE },
> +	{ set_link_security,       false, MGMT_SETTING_SIZE },
> +	{ set_ssp,                 false, MGMT_SETTING_SIZE },
> +	{ set_hs,                  false, MGMT_SETTING_SIZE },
> +	{ set_le,                  false, MGMT_SETTING_SIZE },
> +	{ set_dev_class,           false, MGMT_SET_DEV_CLASS_SIZE },
> +	{ set_local_name,          false, MGMT_SET_LOCAL_NAME_SIZE },
> +	{ add_uuid,                false, MGMT_ADD_UUID_SIZE },
> +	{ remove_uuid,             false, MGMT_REMOVE_UUID_SIZE },
> +	{ load_link_keys,          true,  MGMT_LOAD_LINK_KEYS_SIZE },
> +	{ load_long_term_keys,     true,  MGMT_LOAD_LONG_TERM_KEYS_SIZE },
> +	{ disconnect,              false, MGMT_DISCONNECT_SIZE },
> +	{ get_connections,         false, MGMT_GET_CONNECTIONS_SIZE },
> +	{ pin_code_reply,          false, MGMT_PIN_CODE_REPLY_SIZE },
> +	{ pin_code_neg_reply,      false, MGMT_PIN_CODE_NEG_REPLY_SIZE },
> +	{ set_io_capability,       false, MGMT_SET_IO_CAPABILITY_SIZE },
> +	{ pair_device,             false, MGMT_PAIR_DEVICE_SIZE },
> +	{ cancel_pair_device,      false, MGMT_CANCEL_PAIR_DEVICE_SIZE },
> +	{ unpair_device,           false, MGMT_UNPAIR_DEVICE_SIZE },
> +	{ user_confirm_reply,      false, MGMT_USER_CONFIRM_REPLY_SIZE },
> +	{ user_confirm_neg_reply,  false, MGMT_USER_CONFIRM_NEG_REPLY_SIZE },
> +	{ user_passkey_reply,      false, MGMT_USER_PASSKEY_REPLY_SIZE },
> +	{ user_passkey_neg_reply,  false, MGMT_USER_PASSKEY_NEG_REPLY_SIZE },
> +	{ read_local_oob_data,     false, MGMT_READ_LOCAL_OOB_DATA_SIZE },
> +	{ add_remote_oob_data,     true,  MGMT_ADD_REMOTE_OOB_DATA_SIZE },
> +	{ remove_remote_oob_data,  false, MGMT_REMOVE_REMOTE_OOB_DATA_SIZE },
> +	{ start_discovery,         false, MGMT_START_DISCOVERY_SIZE },
> +	{ stop_discovery,          false, MGMT_STOP_DISCOVERY_SIZE },
> +	{ confirm_name,            false, MGMT_CONFIRM_NAME_SIZE },
> +	{ block_device,            false, MGMT_BLOCK_DEVICE_SIZE },
> +	{ unblock_device,          false, MGMT_UNBLOCK_DEVICE_SIZE },
> +	{ set_device_id,           false, MGMT_SET_DEVICE_ID_SIZE },
> +	{ set_advertising,         false, MGMT_SETTING_SIZE },
> +	{ set_bredr,               false, MGMT_SETTING_SIZE },
> +	{ set_static_address,      false, MGMT_SET_STATIC_ADDRESS_SIZE },
> +	{ set_scan_params,         false, MGMT_SET_SCAN_PARAMS_SIZE },
> +	{ set_secure_conn,         false, MGMT_SETTING_SIZE },
> +	{ set_debug_keys,          false, MGMT_SETTING_SIZE },
> +	{ set_privacy,             false, MGMT_SET_PRIVACY_SIZE },
> +	{ load_irks,               true,  MGMT_LOAD_IRKS_SIZE },
> +	{ get_conn_info,           false, MGMT_GET_CONN_INFO_SIZE },
> +	{ get_clock_info,          false, MGMT_GET_CLOCK_INFO_SIZE },
> +	{ add_device,              false, MGMT_ADD_DEVICE_SIZE },
> +	{ remove_device,           false, MGMT_REMOVE_DEVICE_SIZE },
> +	{ load_conn_param,         true,  MGMT_LOAD_CONN_PARAM_SIZE },
> +	{ read_unconf_index_list,  false, MGMT_READ_UNCONF_INDEX_LIST_SIZE },
> +	{ read_config_info,        false, MGMT_READ_CONFIG_INFO_SIZE },
> +	{ set_external_config,     false, MGMT_SET_EXTERNAL_CONFIG_SIZE },
> +	{ set_public_address,      false, MGMT_SET_PUBLIC_ADDRESS_SIZE },
> +	{ start_service_discovery, true,  MGMT_START_SERVICE_DISCOVERY_SIZE },
> +	{ stop_service_discovery,  false, MGMT_STOP_SERVICE_DISCOVERY_SIZE },
> };

No need for a complete reformat here. My previous comment was for aligning true and false part with the size constant.

> int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
> @@ -6808,6 +6880,121 @@ void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
> 	mgmt_pending_remove(cmd);
> }
> 
> +struct parsed_uuid {
> +	struct list_head list;
> +	u8 uuid[16];
> +};
> +
> +/* this is reversed hex representation of bluetooth base uuid
> + * 00000000-0000-1000-8000-00805F9B34FB. We need it for service uuid parsing in
> + * eir
> + */
> +static const u8 reverse_base_uuid[16] = {0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00,
> +	 0x00, 0x80, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};

This needs to be re-formatted differently to match the network subsystem coding style.

> +
> +static void add_uuid_to_list(struct list_head *uuids, u8 *uuid)
> +{
> +	struct parsed_uuid *tmp_uuid;
> +
> +	tmp_uuid = kmalloc(sizeof(*tmp_uuid), GFP_KERNEL);
> +	if (tmp_uuid == NULL)
> +		return; /* how to handle if there's no memory?*/

This needs to be answered. What is the plan here? What are the options?

> +
> +	memcpy(tmp_uuid->uuid, uuid, 16);
> +	INIT_LIST_HEAD(&tmp_uuid->list);
> +	list_add(&tmp_uuid->list, uuids);
> +}
> +
> +static void eir_parse(u8 *eir, u8 eir_len, struct list_head *uuids,
> +		      u8 *txpwr_present, s8 *txpwr)
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
> +			for (loop = 0; loop + 3 <= field_len; loop += 2) {
> +				memcpy(uuid, reverse_base_uuid, 16);
> +				uuid[13] = eir[loop + 3];
> +				uuid[12] = eir[loop + 2];
> +				add_uuid_to_list(uuids, uuid);
> +			}
> +			break;
> +		case EIR_UUID32_ALL:
> +		case EIR_UUID32_SOME:
> +			for (loop = 0; loop + 5 <= field_len; loop += 4) {
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
> +			for (loop = 0; loop + 17 <= field_len; loop += 4) {
> +				memcpy(uuid, eir + loop + 2, 16);
> +				add_uuid_to_list(uuids, uuid);
> +			}
> +			break;
> +		}
> +
> +		offset += field_len + 1;
> +		eir += field_len + 1;
> +	}
> +
> +failed:
> +	offset = 8;
> +}
> +
> +void find_matches(struct hci_dev *hdev, s8 rssi, struct list_head *uuids,
> +		  u8 txpwr_present, s8 txpwr, bool *full_match,
> +		  bool *service_match)
> +{
> +	struct uuid_filter *filter = NULL;
> +	struct parsed_uuid *uuidptr = NULL;
> +	struct parsed_uuid *tmp = NULL;
> +
> +	list_for_each_entry_safe(uuidptr, tmp, uuids, list) {
> +		list_for_each_entry(filter, &hdev->discov_uuid_filter, list) {
> +			if (memcmp(filter->uuid, uuidptr->uuid, 16) == 0) {
> +				*service_match = true;
> +				if (filter->range_method == MGMT_RANGE_NONE) {
> +					*full_match = true;
> +				} else if ((filter->range_method &
> +					MGMT_RANGE_PATHLOSS) && txpwr_present &&
> +					(txpwr - rssi) <= filter->pathloss) {
> +					*full_match = true;
> +				} else if ((filter->range_method
> +					& MGMT_RANGE_RSSI) &&
> +					rssi >= filter->rssi) {
> +					*full_match = true;
> +				}

Here you need to think about re-formatting it. Or split the code into multiple functions. I know this gets hard, but it is something that needs to be done.

> +			}
> +		}
> +		__list_del_entry(&uuidptr->list);
> +		kfree(uuidptr);
> +	}
> +}
> +
> void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
> 		       u8 addr_type, u8 *dev_class, s8 rssi, u32 flags,
> 		       u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len)
> @@ -6853,7 +7040,33 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
> 	ev->eir_len = cpu_to_le16(eir_len + scan_rsp_len);
> 	ev_size = sizeof(*ev) + eir_len + scan_rsp_len;
> 
> -	mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
> +	if (hdev->service_filter_enabled) {
> +		LIST_HEAD(uuids);
> +		s8 txpwr = 0;
> +		u8 txpwr_present = 0;
> +		bool service_match = false, full_match = false;
> +
> +		eir_parse(eir, eir_len, &uuids, &txpwr_present, &txpwr);
> +		if (!list_empty(&uuids)) {
> +			find_matches(hdev, rssi, &uuids, txpwr_present, txpwr,
> +				     &full_match, &service_match);
> +
> +			if (!service_match)
> +				return;
> +
> +			if (test_bit(HCI_QUIRK_ADV_RSSI_DEDUP, &hdev->quirks)) {
> +				queue_delayed_work(hdev->workqueue,
> +						   &hdev->le_scan_restart,
> +						   DISCOV_LE_RESTART_DELAY);
> +			}
> +
> +			if (full_match)
> +				mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev,
> +					   ev_size, NULL);
> +		}
> +	} else {
> +		mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
> +	}
> }

I would turn these around.

	if (!x) {
		mgmt_event(..
		return;
	}

	your new code

> 
> void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
> @@ -6886,10 +7099,18 @@ void mgmt_discovering(struct hci_dev *hdev, u8 discovering)
> 
> 	BT_DBG("%s discovering %u", hdev->name, discovering);
> 
> -	if (discovering)
> +	if (discovering) {
> 		cmd = mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev);
> -	else
> +		if (cmd == NULL)
> +			cmd = mgmt_pending_find(MGMT_OP_START_SERVICE_DISCOVERY,
> +						hdev);
> +
> +	} else {
> 		cmd = mgmt_pending_find(MGMT_OP_STOP_DISCOVERY, hdev);
> +		if (cmd == NULL)
> +			cmd = mgmt_pending_find(MGMT_OP_STOP_SERVICE_DISCOVERY,
> +						hdev);
> +	}
> 
> 	if (cmd != NULL) {
> 		u8 type = hdev->discovery.type;

Regards

Marcel

