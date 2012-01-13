Return-Path: <cyrus@holtmann.org>
Message-ID: <4F109766.5040703@codeaurora.org>
Date: Fri, 13 Jan 2012 12:43:18 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/8] Bluetooth: Add new structures for handling SMP Long
 Term Keys
References: <1326483580-11243-1-git-send-email-vinicius.gomes@openbossa.org> <1326483580-11243-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1326483580-11243-4-git-send-email-vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On 1/13/2012 11:39 AM, Vinicius Costa Gomes wrote:
> This includes a new list for storing the keys and a new structure used
> to represent each key.
>
> Some notes: authenticated is used to identify that the key may be used
> to setup a HIGH security link. As the same list is used to store both
> the STK's and the LTK's the type field is used so we can separate
> between those two types of keys and if the key should be used when
> in the master or slave role.
>
> Signed-off-by: Vinicius Costa Gomes<vinicius.gomes@openbossa.org>
> ---
>   include/net/bluetooth/hci.h      |    5 +++++
>   include/net/bluetooth/hci_core.h |   15 +++++++++++++++
>   net/bluetooth/hci_core.c         |   31 +++++++++++++++++++++++++++++++
>   3 files changed, 51 insertions(+), 0 deletions(-)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 8499307..3056115 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -273,6 +273,11 @@ enum {
>   #define HCI_LK_SMP_LTK			0x81
>   #define HCI_LK_SMP_IRK			0x82
>   #define HCI_LK_SMP_CSRK			0x83
> +/* The spec doesn't define types for SMP keys, the _MASTER suffix is implied */
> +#define HCI_SMP_STK			0x80
> +#define HCI_SMP_STK_SLAVE		0x81
> +#define HCI_SMP_LTK			0x82
> +#define HCI_SMP_LTK_SLAVE		0x83

This list should be contiguous, and you should probably remove the 
others at the same time.  I would also suggest adding MASTER and SLAVE 
versions of CSRK and maybe IRK as well. (IRK is used differently, and 
may not need a Master/Slave version, but it wouldn't hurt anything). 
CSRK, when implimented will definitely need both Master and Slave versions.

>
>   /* ---- HCI Error Codes ---- */
>   #define HCI_ERROR_AUTH_FAILURE		0x05
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 59e3541..9d77a66 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -88,6 +88,18 @@ struct bt_uuid {
>   	u8 svc_hint;
>   };
>
> +struct smp_ltk {
> +	struct list_head list;
> +	bdaddr_t bdaddr;
> +	u8 bdaddr_type;
> +	u8 authenticated;
> +	u8 type;
> +	u8 enc_size;
> +	__le16 ediv;
> +	u8 rand[8];
> +	u8 val[16];
> +} __packed;
> +
>   struct key_master_id {
>   	__le16 ediv;
>   	u8 rand[8];
> @@ -240,6 +252,8 @@ struct hci_dev {
>
>   	struct list_head	link_keys;
>
> +	struct list_head	ltks;
> +
>   	struct list_head	remote_oob_data;
>
>   	struct list_head	adv_entries;
> @@ -643,6 +657,7 @@ struct link_key *hci_find_link_key_type(struct hci_dev *hdev,
>   int hci_add_ltk(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
>   			u8 key_size, __le16 ediv, u8 rand[8], u8 ltk[16]);
>   int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
> +int hci_smp_ltks_clear(struct hci_dev *hdev);
>
>   int hci_remote_oob_data_clear(struct hci_dev *hdev);
>   struct oob_data *hci_find_remote_oob_data(struct hci_dev *hdev,
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index a7b7200..3b5902d 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1163,6 +1163,18 @@ int hci_link_keys_clear(struct hci_dev *hdev)
>   	return 0;
>   }
>
> +int hci_smp_ltks_clear(struct hci_dev *hdev)
> +{
> +	struct smp_ltk *k, *tmp;
> +
> +	list_for_each_entry_safe(k, tmp,&hdev->ltks, list) {
> +		list_del(&k->list);
> +		kfree(k);
> +	}
> +
> +	return 0;
> +}
> +
>   struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
>   {
>   	struct link_key *k;
> @@ -1355,6 +1367,23 @@ int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
>   	return 0;
>   }
>
> +int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr)
> +{
> +	struct smp_ltk *k, *tmp;
> +
> +	list_for_each_entry_safe(k, tmp,&hdev->ltks, list) {
> +		if (bacmp(bdaddr,&k->bdaddr))
> +			continue;
> +
> +		BT_DBG("%s removing %s", hdev->name, batostr(bdaddr));
> +
> +		list_del(&k->list);
> +		kfree(k);
> +	}
> +
> +	return 0;
> +}
> +
>   /* HCI command timer function */
>   static void hci_cmd_timer(unsigned long arg)
>   {
> @@ -1638,6 +1667,7 @@ int hci_register_dev(struct hci_dev *hdev)
>   	INIT_LIST_HEAD(&hdev->uuids);
>
>   	INIT_LIST_HEAD(&hdev->link_keys);
> +	INIT_LIST_HEAD(&hdev->ltks);
>
>   	INIT_LIST_HEAD(&hdev->remote_oob_data);
>
> @@ -1739,6 +1769,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
>   	hci_blacklist_clear(hdev);
>   	hci_uuids_clear(hdev);
>   	hci_link_keys_clear(hdev);
> +	hci_smp_ltks_clear(hdev);
>   	hci_remote_oob_data_clear(hdev);
>   	hci_adv_entries_clear(hdev);
>   	hci_dev_unlock(hdev);


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
