Return-Path: <cyrus@holtmann.org>
Date: Tue, 4 Nov 2014 11:37:37 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 3/3] Bluetooth: start service discovery and stop
 service discovery
Message-ID: <20141104093737.GB6330@t440s.lan>
References: <1415041125-1161-1-git-send-email-jpawlowski@google.com>
 <1415041125-1161-3-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1415041125-1161-3-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Mon, Nov 03, 2014, Jakub Pawlowski wrote:
> @@ -1392,6 +1402,7 @@ void mgmt_new_conn_param(struct hci_dev *hdev, bdaddr_t *bdaddr,
>  void mgmt_reenable_advertising(struct hci_dev *hdev);
>  void mgmt_smp_complete(struct hci_conn *conn, bool complete);
>  void restart_le_scan(struct hci_dev *hdev, unsigned long delay);
> +void clean_up_service_discovery(struct hci_dev *hdev);

Please stick to the name-spacing here. I think all functions in
hci_core.h are either mgmt_* (for mgmt.c) or hci_* (for hci_core.c).

> +static s8 add_uuid_to_list(struct list_head *uuids, u8 *uuid)
> +{
> +	struct parsed_uuid *tmp_uuid;
> +
> +	tmp_uuid = kmalloc(sizeof(*tmp_uuid), GFP_KERNEL);
> +	if (tmp_uuid == NULL)
> +		return -ENOMEM;
> +
> +	memcpy(tmp_uuid->uuid, uuid, 16);
> +	INIT_LIST_HEAD(&tmp_uuid->list);
> +	list_add(&tmp_uuid->list, uuids);
> +	return 0;
> +}

For functions returning 0 or a negative error the convention is to use
int as the return value type.

> +static s8 eir_parse(u8 *eir, u8 eir_len, struct list_head *uuids)

Same here.

> +{
> +	size_t offset;
> +	u8 uuid[16];
> +	int loop, ret;

We use i for iterator variables (referring to your 'loop' here).

> +	offset = 0;
> +	while (offset < eir_len) {
> +		uint8_t field_len = eir[0];
> +
> +		/* Check for the end of EIR */
> +		if (field_len == 0)
> +			break;
> +
> +		if (offset + field_len > eir_len)
> +			return -1;

For consistency -EINVAL is probably better here (after all you're
returning -ENOMEM when add_uuid_to_list fails).

> +/* returns 0 for no match, 1 for service match (no proximity match), and 2 for
> + * full match
> + */

To improve readability please create an enum for these possible values.

> +int find_matches(struct hci_dev *hdev, s8 rssi, struct list_head *uuids)
> +{
> +	struct uuid_filter *filter = NULL;
> +	struct parsed_uuid *uuidptr = NULL;
> +	struct parsed_uuid *tmp_uuid = NULL;

I don't think any of the above variables need initialization upon
declaration. We try to avoid than when possible.

> +	u8 match_type = 0, tmp;
> +
> +	list_for_each_entry_safe(uuidptr, tmp_uuid, uuids, list) {
> +		list_for_each_entry(filter, &hdev->discov_uuid_filter, list) {
> +			tmp = find_match(filter, uuidptr->uuid, rssi);
> +			if (tmp > match_type)
> +				match_type = tmp;
> +			__list_del_entry(&uuidptr->list);
> +			kfree(uuidptr);
> +		}

This looks like it'll access freed memory as soon as you have more than
one entry in hdev->discov_uuid_filter (since you free uuidptr but keep
looping).

I think it'd be good if you'd implement an extensive set of mgmt-tester
tests for the full API. That would let you catch things like this and
it'd let us (as maintainers) easily verify that your patches work.

> +	}
> +	return match_type;
> +}

Why is the return value of this function int but you're returning a u8
variable? Please be consistent.

> +
>  void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
>  		       u8 addr_type, u8 *dev_class, s8 rssi, u32 flags,
>  		       u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len)
> @@ -6823,6 +7014,9 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
>  	char buf[512];
>  	struct mgmt_ev_device_found *ev = (void *) buf;
>  	size_t ev_size;
> +	LIST_HEAD(uuids);
> +	s8 ret = 0;

I guess int would be a more appropriate type for 'ret'.

  
> -	mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
> +	if (test_bit(HCI_SERVICE_FILTER, &hdev->dev_flags)) {
> +		mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
> +		return;
> +	}
> +
> +	ret = eir_parse(eir, eir_len, &uuids);
> +	if (list_empty(&uuids) || ret != 0)
> +		return;
> +
> +	match_type = find_matches(hdev, rssi, &uuids);
> +	if (match_type == 0)
> +		return;

The lifetime of the memory allocated in uuids is a bit unclear here imo.
find_matches doesn't sound like something that'd be responsible for
freeing it (and in fact it doesn't if hdev->discov_uuid_filter list is
empty. Probably an explicit freeing function (or inline code here) would
be better.

Johan
