Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 Nov 2014 10:35:58 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4 3/3] Bluetooth: start service discovery and stop
 service discovery
Message-ID: <20141105083558.GA7393@t440s.lan>
References: <1415121804-12065-1-git-send-email-jpawlowski@google.com>
 <1415121804-12065-3-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1415121804-12065-3-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Tue, Nov 04, 2014, Jakub Pawlowski wrote:
> +void clean_up_service_discovery(struct hci_dev *hdev)
> +{
> +	struct uuid_filter *filter = NULL;
> +	struct uuid_filter *tmp = NULL;

I don't think either one of these needs initialization to NULL.

> +	if (!test_bit(HCI_SERVICE_FILTER, &hdev->dev_flags))
> +		return;
> +
> +	clear_bit(HCI_SERVICE_FILTER, &hdev->dev_flags);
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

The list_empty() check is probably unnecessary here since you're not
really saving any cpu cycles compared to calling
list_for_each_entry_safe() on an empty list.

> +void free_uuids_list(struct list_head *uuids)
> +{
> +	struct parsed_uuid *uuidptr, *tmp_uuid;

Minor thing, but I'd just call these *uuid and *tmp.

> +static int eir_parse(u8 *eir, u8 eir_len, struct list_head *uuids)
> +{
> +	size_t offset;
> +	u8 uuid[16];
> +	int i, ret;
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
> +			return -EINVAL;
> +
> +		switch (eir[1]) {
> +		case EIR_UUID16_ALL:
> +		case EIR_UUID16_SOME:
> +			for (i = 0; i + 3 <= field_len; i += 2) {
> +				memcpy(uuid, reverse_base_uuid, 16);
> +				uuid[13] = eir[i + 3];
> +				uuid[12] = eir[i + 2];
> +				ret = add_uuid_to_list(uuids, uuid);
> +				if (ret)
> +					return ret;
> +			}
> +			break;
> +		case EIR_UUID32_ALL:
> +		case EIR_UUID32_SOME:
> +			for (i = 0; i + 5 <= field_len; i += 4) {
> +				memcpy(uuid, reverse_base_uuid, 16);
> +				uuid[15] = eir[i + 5];
> +				uuid[14] = eir[i + 4];
> +				uuid[13] = eir[i + 3];
> +				uuid[12] = eir[i + 2];
> +				ret = add_uuid_to_list(uuids, uuid);
> +				if (ret)
> +					return ret;
> +			}
> +			break;
> +		case EIR_UUID128_ALL:
> +		case EIR_UUID128_SOME:
> +			for (i = 0; i + 17 <= field_len; i += 4) {

The i += 4 looks wrong to me. Shouldn't it be 16?

> +uint8_t find_match(struct uuid_filter *filter, u8 *uuid, s8 rssi)
> +{
> +	if (memcmp(filter->uuid, uuid, 16) != 0)
> +		return NO_MATCH;
> +
> +	if (rssi >= filter->rssi)
> +		return FULL_MATCH;

Is this really the right way to compare RSSI values considering that
they can be both positive and negative?

> +int find_matches(struct hci_dev *hdev, s8 rssi, struct list_head *uuids)
> +{
> +	struct uuid_filter *filter;
> +	struct parsed_uuid *uuidptr, *tmp_uuid;
> +	int match_type = 0, tmp;

Shouldn't this be initialized to NO_MATCH instead of 0?

>  void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
>  		       u8 addr_type, u8 *dev_class, s8 rssi, u32 flags,
>  		       u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len)
> @@ -6823,6 +7024,9 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
>  	char buf[512];
>  	struct mgmt_ev_device_found *ev = (void *) buf;
>  	size_t ev_size;
> +	LIST_HEAD(uuids);
> +	int ret = 0;
> +	u8 match_type = 0;

Same here, and it looks like the ret initialization is unnecessary.

> @@ -6861,7 +7065,29 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
>  	ev->eir_len = cpu_to_le16(eir_len + scan_rsp_len);
>  	ev_size = sizeof(*ev) + eir_len + scan_rsp_len;
>  
> -	mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
> +	if (test_bit(HCI_SERVICE_FILTER, &hdev->dev_flags)) {
> +		mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
> +		return;
> +	}

Shouldn't the above be if (!test_bit...)? Also I don't see anywhere
where you'd actually be setting this flag?

> +	ret = eir_parse(eir, eir_len, &uuids);
> +	if (list_empty(&uuids) || ret != 0)
> +		return;

Doesn't this leak memory if there are items in the list but ret != 0?

Johan
