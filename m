Return-Path: <cyrus@holtmann.org>
Message-ID: <1359114021.8989.9.camel@aeonflux>
Subject: Re: [PATCH 1/6 v2] Bluetooth: Split UUIDs to three separate lists
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 25 Jan 2013 12:40:21 +0100
In-Reply-To: <1359097050-17552-2-git-send-email-johan.hedberg@gmail.com>
References: <1359097050-17552-1-git-send-email-johan.hedberg@gmail.com>
	 <1359097050-17552-2-git-send-email-johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The primary purpose of the UUIDs is to eable generation of EIR and AD
> data. In these data formats the UUIDs are split into separate fields
> based on whether they're 16, 32 or 128 bit UUIDs. To make the generation
> of these data fields simple this patch splits the UUIDs into three
> separate lists based on their type.
> 
> To keep cases needing access to all UUIDs easy the UUIDs are also kept
> in an "all" list. This is particularly useful for exposing the UUIDs
> through sysfs as well as removing UUIDs (whether removing a specific one
> or all UUIDs).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> v2: Removed enum bt_uuid_t since all it was needed for was selecting
> which list to add to.
> 
>  include/net/bluetooth/hci_core.h |    4 +++
>  net/bluetooth/hci_core.c         |   14 ++++----
>  net/bluetooth/hci_sysfs.c        |    2 +-
>  net/bluetooth/mgmt.c             |   67 +++++++++++++++++++-------------------
>  4 files changed, 45 insertions(+), 42 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index bcf8ffe..d3b1d1b 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -85,6 +85,7 @@ struct bdaddr_list {
>  
>  struct bt_uuid {
>  	struct list_head list;
> +	struct list_head all;
>  	u8 uuid[16];
>  	u8 svc_hint;
>  };

I am not 100% convinced we should be doing this actually. If we store
the UUIDs as 128-bit values anyway, why do we need three lists.

> @@ -256,6 +257,9 @@ struct hci_dev {
>  	struct list_head	blacklist;
>  
>  	struct list_head	uuids;
> +	struct list_head	uuid16;
> +	struct list_head	uuid32;
> +	struct list_head	uuid128;

I would name them uuid16_list etc. if we stick with this.

And are we adding each entry twice? Or how does that work? I am getting
a bad feeling here.

>  	struct list_head	link_keys;
>  
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index e061b35..8818521 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1183,14 +1183,11 @@ static void hci_discov_off(struct work_struct *work)
>  
>  int hci_uuids_clear(struct hci_dev *hdev)
>  {
> -	struct list_head *p, *n;
> -
> -	list_for_each_safe(p, n, &hdev->uuids) {
> -		struct bt_uuid *uuid;
> +	struct bt_uuid *uuid, *tmp;
>  
> -		uuid = list_entry(p, struct bt_uuid, list);
> -
> -		list_del(p);
> +	list_for_each_entry_safe(uuid, tmp, &hdev->uuids, all) {
> +		list_del(&uuid->list);
> +		list_del(&uuid->all);
>  		kfree(uuid);
>  	}
>  
> @@ -1718,6 +1715,9 @@ struct hci_dev *hci_alloc_dev(void)
>  	INIT_LIST_HEAD(&hdev->mgmt_pending);
>  	INIT_LIST_HEAD(&hdev->blacklist);
>  	INIT_LIST_HEAD(&hdev->uuids);
> +	INIT_LIST_HEAD(&hdev->uuid16);
> +	INIT_LIST_HEAD(&hdev->uuid32);
> +	INIT_LIST_HEAD(&hdev->uuid128);
>  	INIT_LIST_HEAD(&hdev->link_keys);
>  	INIT_LIST_HEAD(&hdev->long_term_keys);
>  	INIT_LIST_HEAD(&hdev->remote_oob_data);
> diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
> index 23b4e24..9a60c74 100644
> --- a/net/bluetooth/hci_sysfs.c
> +++ b/net/bluetooth/hci_sysfs.c
> @@ -483,7 +483,7 @@ static int uuids_show(struct seq_file *f, void *p)
>  
>  	hci_dev_lock(hdev);
>  
> -	list_for_each_entry(uuid, &hdev->uuids, list)
> +	list_for_each_entry(uuid, &hdev->uuids, all)
>  		print_bt_uuid(f, uuid->uuid);

This all thing makes is not so pretty code. You would expect list here.

>  
>  	hci_dev_unlock(hdev);
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index e7f944f..1257ed0 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -435,28 +435,6 @@ static u32 get_current_settings(struct hci_dev *hdev)
>  
>  #define PNP_INFO_SVCLASS_ID		0x1200
>  
> -static u8 bluetooth_base_uuid[] = {
> -			0xFB, 0x34, 0x9B, 0x5F, 0x80, 0x00, 0x00, 0x80,
> -			0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -};
> -
> -static u16 get_uuid16(u8 *uuid128)
> -{
> -	u32 val;
> -	int i;
> -
> -	for (i = 0; i < 12; i++) {
> -		if (bluetooth_base_uuid[i] != uuid128[i])
> -			return 0;
> -	}
> -
> -	val = get_unaligned_le32(&uuid128[12]);
> -	if (val > 0xffff)
> -		return 0;
> -
> -	return (u16) val;
> -}
> -
>  static void create_eir(struct hci_dev *hdev, u8 *data)
>  {
>  	u8 *ptr = data;
> @@ -510,13 +488,10 @@ static void create_eir(struct hci_dev *hdev, u8 *data)
>  	memset(uuid16_list, 0, sizeof(uuid16_list));
>  
>  	/* Group all UUID16 types */
> -	list_for_each_entry(uuid, &hdev->uuids, list) {
> +	list_for_each_entry(uuid, &hdev->uuid16, list) {
>  		u16 uuid16;
>  
> -		uuid16 = get_uuid16(uuid->uuid);
> -		if (uuid16 == 0)
> -			return;
> -
> +		uuid16 = get_unaligned_le16(&uuid->uuid[12]);
>  		if (uuid16 < 0x1100)
>  			continue;

Why are we not storing the UUID size with it. So we just loop the same
list three times.

You have to keep the list of all UUIDs anyway. And we are not expecting
a bunch of hundred UUIDs. This list will be in the range of 10-20 max.
 
> @@ -592,7 +567,7 @@ static u8 get_service_classes(struct hci_dev *hdev)
>  	struct bt_uuid *uuid;
>  	u8 val = 0;
>  
> -	list_for_each_entry(uuid, &hdev->uuids, list)
> +	list_for_each_entry(uuid, &hdev->uuids, all)
>  		val |= uuid->svc_hint;
>  
>  	return val;
> @@ -1304,11 +1279,34 @@ unlock:
>  	return err;
>  }
>  
> +static u8 bluetooth_base_uuid[] = {
> +			0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
> +			0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +};
> +
> +static struct list_head *select_uuid_list(struct hci_dev *hdev, u8 *uuid)
> +{
> +	u32 val;
> +	int i;
> +
> +	for (i = 0; i < 12; i++) {
> +		if (bluetooth_base_uuid[i] != uuid[i])
> +			return &hdev->uuid128;
> +	}

I know it is in the original code as well, but what is wrong with
memcmp.

> +
> +	val = get_unaligned_le32(&uuid[12]);
> +	if (val > 0xffff)
> +		return &hdev->uuid32;
> +
> +	return &hdev->uuid16;
> +}
> +
>  static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
>  {
>  	struct mgmt_cp_add_uuid *cp = data;
>  	struct pending_cmd *cmd;
>  	struct bt_uuid *uuid;
> +	struct list_head *l;
>  	int err;
>  
>  	BT_DBG("request for %s", hdev->name);
> @@ -1330,7 +1328,10 @@ static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
>  	memcpy(uuid->uuid, cp->uuid, 16);
>  	uuid->svc_hint = cp->svc_hint;
>  
> -	list_add(&uuid->list, &hdev->uuids);
> +	l = select_uuid_list(hdev, cp->uuid);
> +	list_add_tail(&uuid->list, l);
> +
> +	list_add_tail(&uuid->all, &hdev->uuids);
>  
>  	err = update_class(hdev);
>  	if (err < 0)
> @@ -1374,7 +1375,7 @@ static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
>  {
>  	struct mgmt_cp_remove_uuid *cp = data;
>  	struct pending_cmd *cmd;
> -	struct list_head *p, *n;
> +	struct bt_uuid *match, *tmp;
>  	u8 bt_uuid_any[] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
>  	int err, found;
>  
> @@ -1402,13 +1403,11 @@ static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
>  
>  	found = 0;
>  
> -	list_for_each_safe(p, n, &hdev->uuids) {
> -		struct bt_uuid *match = list_entry(p, struct bt_uuid, list);
> -
> +	list_for_each_entry_safe(match, tmp, &hdev->uuids, all) {
>  		if (memcmp(match->uuid, cp->uuid, 16) != 0)
>  			continue;
> -
>  		list_del(&match->list);
> +		list_del(&match->all);
>  		kfree(match);
>  		found++;
>  	}

Regards

Marcel


