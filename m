Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1428633041-18415-2-git-send-email-fgrandel@gmail.com>
References: <20150409094913.GB10676@t440s.lan>
	<1428633041-18415-1-git-send-email-fgrandel@gmail.com>
	<1428633041-18415-2-git-send-email-fgrandel@gmail.com>
Date: Thu, 23 Apr 2015 17:37:32 -0700
Message-ID: <CAHrH25S6iCxuThBz0ZtKRu7PpoZkBjTHsFEU+NBozaNFJVyPqA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Bluetooth: hci_core: Introduce multi-adv inst list
From: Arman Uguray <armansito@chromium.org>
To: Florian Grandel <fgrandel@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Florian,

Sorry for my delayed response, please see my comments inline below.

> On Thu, Apr 9, 2015 at 7:30 PM, Florian Grandel <fgrandel@gmail.com> wrote:
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
>  include/net/bluetooth/hci_core.h |  14 +++++
>  net/bluetooth/hci_core.c         | 116 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 130 insertions(+)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index a056c2b..98678eb 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -156,6 +156,7 @@ struct oob_data {
>  };
>
>  struct adv_info {
> +       struct list_head list;
>         struct delayed_work timeout_exp;
>         __u8    instance;
>         __u32   flags;
> @@ -166,6 +167,8 @@ struct adv_info {
>         __u8    scan_rsp_data[HCI_MAX_AD_LENGTH];
>  };
>
> +#define HCI_MAX_ADV_INSTANCES          1
> +

Now that you've added this constant, this is what you should use to
populate "rp->max_instances" in
net/bluetooth/mgmt.c:read_adv_features.

>  #define HCI_MAX_SHORT_NAME_LENGTH      10
>
>  /* Default LE RPA expiry time, 15 minutes */
> @@ -374,6 +377,8 @@ struct hci_dev {
>         __u8                    scan_rsp_data_len;
>
>         struct adv_info         adv_instance;

Is this still needed?

> +       struct list_head        adv_instances;
> +       __u8                    cur_adv_instance;
>
>         __u8                    irk[16];
>         __u32                   rpa_timeout;
> @@ -1007,6 +1012,15 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
>  int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
>                                u8 bdaddr_type);
>
> +int hci_num_adv_instances(struct hci_dev *hdev);
> +void hci_adv_instances_clear(struct hci_dev *hdev);
> +struct adv_info *hci_find_adv_instance(struct hci_dev *hdev, u8 instance);
> +int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
> +                        u16 adv_data_len, u8 *adv_data,
> +                        u16 scan_rsp_len, u8 *scan_rsp_data,
> +                        work_func_t timeout_work, u16 timeout);
> +int hci_remove_adv_instance(struct hci_dev *hdev, u8 instance);
> +
>  void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
>
>  int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 476709b..1859e67 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2613,6 +2613,119 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr,
>         return 0;
>  }
>
> +struct adv_info *hci_find_adv_instance(struct hci_dev *hdev, u8 instance)
> +{

Doesn't this require a lock as well?

> +       struct adv_info *adv_instance;
> +
> +       list_for_each_entry(adv_instance, &hdev->adv_instances, list) {
> +               if (adv_instance->instance != instance)
> +                       continue;
> +               return adv_instance;

Simpler to just do:

    if (adv_instance->instance == instance)
            return adv_instance;

> +       }
> +
> +       return NULL;
> +}
> +
> +/* This function requires the caller holds hdev->lock */
> +int hci_remove_adv_instance(struct hci_dev *hdev, u8 instance)
> +{
> +       struct adv_info *adv_instance;
> +
> +       adv_instance = hci_find_adv_instance(hdev, instance);
> +       if (!adv_instance)
> +               return -ENOENT;
> +
> +       BT_DBG("%s removing %dMR", hdev->name, instance);
> +
> +       if (adv_instance->timeout)
> +               cancel_delayed_work(&adv_instance->timeout_exp);
> +
> +       list_del(&adv_instance->list);
> +       kfree(adv_instance);
> +
> +       return 0;
> +}
> +
> +/* This function requires the caller holds hdev->lock */
> +void hci_adv_instances_clear(struct hci_dev *hdev)
> +{
> +       struct adv_info *adv_instance, *n;
> +
> +       list_for_each_entry_safe(adv_instance, n, &hdev->adv_instances, list) {
> +               if (adv_instance->timeout)
> +                       cancel_delayed_work(&adv_instance->timeout_exp);
> +
> +               list_del(&adv_instance->list);
> +               kfree(adv_instance);
> +       }
> +}
> +
> +int hci_num_adv_instances(struct hci_dev *hdev)
> +{
> +       struct adv_info *adv_instance;
> +       int num = 0;
> +
> +       list_for_each_entry(adv_instance, &hdev->adv_instances, list) {
> +               num++;
> +       }

I'm not particularly opinionated on this but it would be more
efficient to keep a count in hci_dev, though that's up to Johan.

> +
> +       return num;
> +}
> +
> +/* This function requires the caller holds hdev->lock */
> +int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
> +                        u16 adv_data_len, u8 *adv_data,
> +                        u16 scan_rsp_len, u8 *scan_rsp_data,
> +                        work_func_t timeout_work, u16 timeout)
> +{
> +       struct adv_info *adv_instance;
> +
> +       adv_instance = hci_find_adv_instance(hdev, instance);
> +       if (adv_instance) {
> +               if (adv_instance->timeout)
> +                       cancel_delayed_work(&adv_instance->timeout_exp);
> +
> +               memset(adv_instance->adv_data, 0,
> +                      sizeof(adv_instance->adv_data));
> +               memset(adv_instance->scan_rsp_data, 0,
> +                      sizeof(adv_instance->scan_rsp_data));
> +       } else {
> +               if (hci_num_adv_instances(hdev) >= HCI_MAX_ADV_INSTANCES)
> +                       return -EOVERFLOW;
> +
> +               adv_instance = kmalloc(sizeof(*adv_instance), GFP_KERNEL);
> +               if (!adv_instance)
> +                       return -ENOMEM;
> +
> +               memset(adv_instance, 0, sizeof(*adv_instance));
> +               INIT_DELAYED_WORK(&adv_instance->timeout_exp, timeout_work);
> +               adv_instance->instance = instance;
> +               list_add(&adv_instance->list, &hdev->adv_instances);
> +       }
> +
> +       adv_instance->flags = flags;
> +       adv_instance->adv_data_len = adv_data_len;
> +       adv_instance->scan_rsp_len = scan_rsp_len;
> +
> +       if (adv_data_len)
> +               memcpy(adv_instance->adv_data, adv_data, adv_data_len);
> +
> +       if (scan_rsp_len)
> +               memcpy(adv_instance->scan_rsp_data,
> +                      scan_rsp_data, scan_rsp_len);
> +
> +       adv_instance->timeout = timeout;
> +
> +       if (timeout)
> +               queue_delayed_work(hdev->workqueue,
> +                                  &adv_instance->timeout_exp,
> +                                  msecs_to_jiffies(timeout * 1000));
> +
> +       BT_DBG("%s for %dMR", hdev->name, instance);
> +
> +       return 0;
> +}
> +
>  struct bdaddr_list *hci_bdaddr_list_lookup(struct list_head *bdaddr_list,
>                                          bdaddr_t *bdaddr, u8 type)
>  {
> @@ -3016,6 +3129,7 @@ struct hci_dev *hci_alloc_dev(void)
>         hdev->manufacturer = 0xffff;    /* Default to internal use */
>         hdev->inq_tx_power = HCI_TX_POWER_INVALID;
>         hdev->adv_tx_power = HCI_TX_POWER_INVALID;
> +       hdev->cur_adv_instance = 0x00;
>
>         hdev->sniff_max_interval = 800;
>         hdev->sniff_min_interval = 80;
> @@ -3057,6 +3171,7 @@ struct hci_dev *hci_alloc_dev(void)
>         INIT_LIST_HEAD(&hdev->pend_le_conns);
>         INIT_LIST_HEAD(&hdev->pend_le_reports);
>         INIT_LIST_HEAD(&hdev->conn_hash.list);
> +       INIT_LIST_HEAD(&hdev->adv_instances);
>
>         INIT_WORK(&hdev->rx_work, hci_rx_work);
>         INIT_WORK(&hdev->cmd_work, hci_cmd_work);
> @@ -3250,6 +3365,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
>         hci_smp_ltks_clear(hdev);
>         hci_smp_irks_clear(hdev);
>         hci_remote_oob_data_clear(hdev);
> +       hci_adv_instances_clear(hdev);
>         hci_bdaddr_list_clear(&hdev->le_white_list);
>         hci_conn_params_clear_all(hdev);
>         hci_discovery_filter_clear(hdev);
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Arman
