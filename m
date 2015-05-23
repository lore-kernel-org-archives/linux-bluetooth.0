Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v4 02/17] Bluetooth: hci_core: Introduce multi-adv inst list
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1430408000-17785-3-git-send-email-fgrandel@gmail.com>
Date: Sat, 23 May 2015 23:25:57 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <2FCCF3D0-C40F-472E-A2AB-58D1362445A0@holtmann.org>
References: <1430408000-17785-1-git-send-email-fgrandel@gmail.com> <1428633041-18415-1-git-send-email-fgrandel@gmail.com> <1430408000-17785-3-git-send-email-fgrandel@gmail.com>
To: Florian Grandel <fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Florian,

> The current hci dev structure only supports a single advertising
> instance. To support multi-instance advertising it is necessary to
> introduce a linked list of advertising instances so that multiple
> advertising instances can be dynamically added and/or removed.
> 
> In a first step, the existing adv_instance member of the hci_dev
> struct is supplemented by a linked list of advertising instances.
> This patch introduces the list and supporting list management
> infrastructure. The list is not being used yet.
> 
> Signed-off-by: Florian Grandel <fgrandel@gmail.com>
> ---
> include/net/bluetooth/hci_core.h |  16 ++++++
> net/bluetooth/hci_core.c         | 112 +++++++++++++++++++++++++++++++++++++++
> net/bluetooth/mgmt.c             |  10 ++--
> 3 files changed, 133 insertions(+), 5 deletions(-)

I dislike you intermixing userspace with kernel space patches. That makes it so hard to review. Keep them separate.

> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index a056c2b..36cc941 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -156,6 +156,9 @@ struct oob_data {
> };
> 
> struct adv_info {
> +	struct list_head list;
> +	struct hci_dev *hdev;

Why is the a copy of hci_dev needed here?

> +	bool pending;

What is this pending for. I do not see it being used in this patch.

> 	struct delayed_work timeout_exp;
> 	__u8	instance;
> 	__u32	flags;
> @@ -166,6 +169,8 @@ struct adv_info {
> 	__u8	scan_rsp_data[HCI_MAX_AD_LENGTH];
> };
> 
> +#define HCI_MAX_ADV_INSTANCES		1
> +
> #define HCI_MAX_SHORT_NAME_LENGTH	10
> 
> /* Default LE RPA expiry time, 15 minutes */
> @@ -374,6 +379,9 @@ struct hci_dev {
> 	__u8			scan_rsp_data_len;
> 
> 	struct adv_info		adv_instance;
> +	struct list_head	adv_instances;
> +	unsigned int		adv_instance_cnt;
> +	__u8			cur_adv_instance;
> 
> 	__u8			irk[16];
> 	__u32			rpa_timeout;
> @@ -1007,6 +1015,14 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
> int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
> 			       u8 bdaddr_type);
> 
> +void hci_adv_instances_clear(struct hci_dev *hdev);
> +struct adv_info *hci_find_adv_instance(struct hci_dev *hdev, u8 instance);
> +int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
> +			 u16 adv_data_len, u8 *adv_data,
> +			 u16 scan_rsp_len, u8 *scan_rsp_data,
> +			 work_func_t timeout_work, u16 timeout);
> +int hci_remove_adv_instance(struct hci_dev *hdev, u8 instance);
> +
> void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
> 
> int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 476709b..de00e21 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2613,6 +2613,114 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
> 	return 0;
> }
> 
> +/* This function requires the caller holds hdev->lock */
> +struct adv_info *hci_find_adv_instance(struct hci_dev *hdev, u8 instance)
> +{
> +	struct adv_info *adv_instance;
> +
> +	list_for_each_entry(adv_instance, &hdev->adv_instances, list) {
> +		if (adv_instance->instance == instance)
> +			return adv_instance;
> +	}
> +
> +	return NULL;
> +}
> +
> +/* This function requires the caller holds hdev->lock */
> +int hci_remove_adv_instance(struct hci_dev *hdev, u8 instance)
> +{
> +	struct adv_info *adv_instance;
> +
> +	adv_instance = hci_find_adv_instance(hdev, instance);
> +	if (!adv_instance)
> +		return -ENOENT;
> +
> +	BT_DBG("%s removing %dMR", hdev->name, instance);
> +
> +	if (adv_instance->timeout)
> +		cancel_delayed_work(&adv_instance->timeout_exp);
> +
> +	list_del(&adv_instance->list);
> +	kfree(adv_instance);
> +
> +	hdev->adv_instance_cnt--;
> +
> +	return 0;
> +}
> +
> +/* This function requires the caller holds hdev->lock */
> +void hci_adv_instances_clear(struct hci_dev *hdev)
> +{
> +	struct adv_info *adv_instance, *n;
> +
> +	list_for_each_entry_safe(adv_instance, n, &hdev->adv_instances, list) {
> +		if (adv_instance->timeout)
> +			cancel_delayed_work(&adv_instance->timeout_exp);
> +
> +		list_del(&adv_instance->list);
> +		kfree(adv_instance);
> +	}
> +
> +	hdev->adv_instance_cnt = 0;
> +}
> +
> +/* This function requires the caller holds hdev->lock */
> +int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
> +			 u16 adv_data_len, u8 *adv_data,
> +			 u16 scan_rsp_len, u8 *scan_rsp_data,
> +			 work_func_t timeout_work, u16 timeout)
> +{
> +	struct adv_info *adv_instance;
> +
> +	adv_instance = hci_find_adv_instance(hdev, instance);
> +	if (adv_instance) {
> +		if (adv_instance->timeout)
> +			cancel_delayed_work(&adv_instance->timeout_exp);
> +
> +		memset(adv_instance->adv_data, 0,
> +		       sizeof(adv_instance->adv_data));
> +		memset(adv_instance->scan_rsp_data, 0,
> +		       sizeof(adv_instance->scan_rsp_data));
> +	} else {
> +		if (hdev->adv_instance_cnt >= HCI_MAX_ADV_INSTANCES)
> +			return -EOVERFLOW;
> +
> +		adv_instance = kmalloc(sizeof(*adv_instance), GFP_KERNEL);
> +		if (!adv_instance)
> +			return -ENOMEM;
> +
> +		memset(adv_instance, 0, sizeof(*adv_instance));
> +		adv_instance->hdev = hdev;
> +		adv_instance->pending = true;
> +		INIT_DELAYED_WORK(&adv_instance->timeout_exp, timeout_work);
> +		adv_instance->instance = instance;
> +		list_add(&adv_instance->list, &hdev->adv_instances);
> +		hdev->adv_instance_cnt++;
> +	}
> +
> +	adv_instance->flags = flags;
> +	adv_instance->adv_data_len = adv_data_len;
> +	adv_instance->scan_rsp_len = scan_rsp_len;
> +
> +	if (adv_data_len)
> +		memcpy(adv_instance->adv_data, adv_data, adv_data_len);
> +
> +	if (scan_rsp_len)
> +		memcpy(adv_instance->scan_rsp_data,
> +		       scan_rsp_data, scan_rsp_len);
> +
> +	adv_instance->timeout = timeout;
> +
> +	if (timeout)
> +		queue_delayed_work(hdev->workqueue,
> +				   &adv_instance->timeout_exp,
> +				   msecs_to_jiffies(timeout * 1000));
> +
> +	BT_DBG("%s for %dMR", hdev->name, instance);
> +
> +	return 0;
> +}
> +
> struct bdaddr_list *hci_bdaddr_list_lookup(struct list_head *bdaddr_list,
> 					 bdaddr_t *bdaddr, u8 type)
> {
> @@ -3016,6 +3124,8 @@ struct hci_dev *hci_alloc_dev(void)
> 	hdev->manufacturer = 0xffff;	/* Default to internal use */
> 	hdev->inq_tx_power = HCI_TX_POWER_INVALID;
> 	hdev->adv_tx_power = HCI_TX_POWER_INVALID;
> +	hdev->adv_instance_cnt = 0;
> +	hdev->cur_adv_instance = 0x00;
> 
> 	hdev->sniff_max_interval = 800;
> 	hdev->sniff_min_interval = 80;
> @@ -3057,6 +3167,7 @@ struct hci_dev *hci_alloc_dev(void)
> 	INIT_LIST_HEAD(&hdev->pend_le_conns);
> 	INIT_LIST_HEAD(&hdev->pend_le_reports);
> 	INIT_LIST_HEAD(&hdev->conn_hash.list);
> +	INIT_LIST_HEAD(&hdev->adv_instances);
> 
> 	INIT_WORK(&hdev->rx_work, hci_rx_work);
> 	INIT_WORK(&hdev->cmd_work, hci_cmd_work);
> @@ -3250,6 +3361,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
> 	hci_smp_ltks_clear(hdev);
> 	hci_smp_irks_clear(hdev);
> 	hci_remote_oob_data_clear(hdev);
> +	hci_adv_instances_clear(hdev);
> 	hci_bdaddr_list_clear(&hdev->le_white_list);
> 	hci_conn_params_clear_all(hdev);
> 	hci_discovery_filter_clear(hdev);
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 7fd87e7..ce25b6d 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -6813,7 +6813,7 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
> 	rp->supported_flags = cpu_to_le32(supported_flags);
> 	rp->max_adv_data_len = HCI_MAX_AD_LENGTH;
> 	rp->max_scan_rsp_len = HCI_MAX_AD_LENGTH;
> -	rp->max_instances = 1;
> +	rp->max_instances = HCI_MAX_ADV_INSTANCES;
> 
> 	/* Currently only one instance is supported, so simply return the
> 	 * current instance number.
> @@ -6916,11 +6916,11 @@ unlock:
> 
> static void adv_timeout_expired(struct work_struct *work)
> {
> -	struct hci_dev *hdev = container_of(work, struct hci_dev,
> -					    adv_instance.timeout_exp.work);
> -
> -	hdev->adv_instance.timeout = 0;
> +	struct adv_info *adv_instance = container_of(work, struct adv_info,
> +						     timeout_exp.work);
> +	struct hci_dev *hdev = adv_instance->hdev;
> 
> +	adv_instance->timeout = 0;
> 	hci_dev_lock(hdev);
> 	clear_adv_instance(hdev);
> 	hci_dev_unlock(hdev);

Regards

Marcel

