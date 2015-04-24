Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1428633041-18415-3-git-send-email-fgrandel@gmail.com>
References: <20150409094913.GB10676@t440s.lan>
	<1428633041-18415-1-git-send-email-fgrandel@gmail.com>
	<1428633041-18415-3-git-send-email-fgrandel@gmail.com>
Date: Thu, 23 Apr 2015 18:33:39 -0700
Message-ID: <CAHrH25TvFm1ZTbVG51qpJ0HmcUhJMPHt+zqDvi9-VR2RUt_TLg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] Bluetooth: mgmt: Start using multi-adv inst list
From: Arman Uguray <armansito@chromium.org>
To: Florian Grandel <fgrandel@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Florian,

> On Thu, Apr 9, 2015 at 7:30 PM, Florian Grandel <fgrandel@gmail.com> wrote:
> To prepare the mgmt api for multiple advertising instances it must be
> refactored to use the new advertising instance linked list:
> - refactor all prior references to the adv_instance member of the
>   hci_dev struct to use the new dynamic list,
> - remove the then unused adv_instance member,
> - replace hard coded instance ids by references to the current
>   instance id saved in the hci_dev struct
>
> Signed-off-by: Florian Grandel <fgrandel@gmail.com>
> ---
>  include/net/bluetooth/hci_core.h |   7 +-
>  net/bluetooth/hci_core.c         |   2 +-
>  net/bluetooth/mgmt.c             | 349 +++++++++++++++++++++------------------
>  3 files changed, 191 insertions(+), 167 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 98678eb..8c19f38 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -157,6 +157,7 @@ struct oob_data {
>
>  struct adv_info {
>         struct list_head list;
> +       struct hci_dev *hdev;
>         struct delayed_work timeout_exp;
>         __u8    instance;
>         __u32   flags;
> @@ -376,7 +377,6 @@ struct hci_dev {
>         __u8                    scan_rsp_data[HCI_MAX_AD_LENGTH];
>         __u8                    scan_rsp_data_len;
>
> -       struct adv_info         adv_instance;
>         struct list_head        adv_instances;
>         __u8                    cur_adv_instance;
>
> @@ -566,11 +566,6 @@ static inline void hci_discovery_filter_clear(struct hci_dev *hdev)
>         hdev->discovery.scan_duration = 0;
>  }
>
> -static inline void adv_info_init(struct hci_dev *hdev)
> -{
> -       memset(&hdev->adv_instance, 0, sizeof(struct adv_info));
> -}
> -
>  bool hci_discovery_active(struct hci_dev *hdev);
>
>  void hci_discovery_set_state(struct hci_dev *hdev, int state);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 1859e67..8ac53cf 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2698,6 +2698,7 @@ int hci_add_adv_instance(struct hci_dev *hdev, u8 instance, u32 flags,
>                         return -ENOMEM;
>
>                 memset(adv_instance, 0, sizeof(*adv_instance));
> +               adv_instance->hdev = hdev;

Include this fix in your previous patch (1/2) rather than here.

>                 INIT_DELAYED_WORK(&adv_instance->timeout_exp, timeout_work);
>                 adv_instance->instance = instance;
>                 list_add(&adv_instance->list, &hdev->adv_instances);
> @@ -3194,7 +3195,6 @@ struct hci_dev *hci_alloc_dev(void)
>
>         hci_init_sysfs(hdev);
>         discovery_init(hdev);
> -       adv_info_init(hdev);
>
>         return hdev;
>  }
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 7fd87e7..199e312 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -858,31 +858,53 @@ static u8 create_default_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
>         return ad_len;
>  }
>
> -static u8 create_instance_scan_rsp_data(struct hci_dev *hdev, u8 *ptr)
> +static u8 create_instance_scan_rsp_data(struct hci_dev *hdev, u8 instance,
> +                                       u8 *ptr)
>  {
> -       /* TODO: Set the appropriate entries based on advertising instance flags
> -        * here once flags other than 0 are supported.
> +       struct adv_info *adv_instance;
> +
> +       adv_instance = hci_find_adv_instance(hdev, instance);
> +       if (adv_instance) {
> +               /* TODO: Set the appropriate entries based on advertising
> +                * instance flags here once flags other than 0 are supported.
> +                */
> +               memcpy(ptr, adv_instance->scan_rsp_data,
> +                      adv_instance->scan_rsp_len);
> +
> +               return adv_instance->scan_rsp_len;
> +       }
> +
> +       return 0;
> +}
> +
> +static u8 get_current_adv_instance(struct hci_dev *hdev)
> +{
> +       /* The "Set Advertising" setting supersedes the "Add Advertising"
> +        * setting. Here we set the advertising data based on which
> +        * setting was set. When neither apply, default to the global settings,
> +        * represented by instance "0".
>          */
> -       memcpy(ptr, hdev->adv_instance.scan_rsp_data,
> -              hdev->adv_instance.scan_rsp_len);
> +       if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) &&
> +           !hci_dev_test_flag(hdev, HCI_ADVERTISING))
> +               return hdev->cur_adv_instance;
>
> -       return hdev->adv_instance.scan_rsp_len;
> +       return 0x00;
>  }
>
> -static void update_scan_rsp_data_for_instance(struct hci_request *req,
> -                                             u8 instance)
> +static void update_scan_rsp_data(struct hci_request *req)
>  {
>         struct hci_dev *hdev = req->hdev;
>         struct hci_cp_le_set_scan_rsp_data cp;
> -       u8 len;
> +       u8 instance, len;
>
>         if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
>                 return;
>
>         memset(&cp, 0, sizeof(cp));
>
> +       instance = get_current_adv_instance(hdev);
>         if (instance)
> -               len = create_instance_scan_rsp_data(hdev, cp.data);
> +               len = create_instance_scan_rsp_data(hdev, instance, cp.data);
>         else
>                 len = create_default_scan_rsp_data(hdev, cp.data);
>
> @@ -898,25 +920,6 @@ static void update_scan_rsp_data_for_instance(struct hci_request *req,
>         hci_req_add(req, HCI_OP_LE_SET_SCAN_RSP_DATA, sizeof(cp), &cp);
>  }
>
> -static void update_scan_rsp_data(struct hci_request *req)
> -{
> -       struct hci_dev *hdev = req->hdev;
> -       u8 instance;
> -
> -       /* The "Set Advertising" setting supersedes the "Add Advertising"
> -        * setting. Here we set the scan response data based on which
> -        * setting was set. When neither apply, default to the global settings,
> -        * represented by instance "0".
> -        */
> -       if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) &&
> -           !hci_dev_test_flag(hdev, HCI_ADVERTISING))
> -               instance = 0x01;
> -       else
> -               instance = 0x00;
> -
> -       update_scan_rsp_data_for_instance(req, instance);
> -}
> -
>  static u8 get_adv_discov_flags(struct hci_dev *hdev)
>  {
>         struct mgmt_pending_cmd *cmd;
> @@ -941,20 +944,6 @@ static u8 get_adv_discov_flags(struct hci_dev *hdev)
>         return 0;
>  }
>
> -static u8 get_current_adv_instance(struct hci_dev *hdev)
> -{
> -       /* The "Set Advertising" setting supersedes the "Add Advertising"
> -        * setting. Here we set the advertising data based on which
> -        * setting was set. When neither apply, default to the global settings,
> -        * represented by instance "0".
> -        */
> -       if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) &&
> -           !hci_dev_test_flag(hdev, HCI_ADVERTISING))
> -               return 0x01;
> -
> -       return 0x00;
> -}
> -
>  static bool get_connectable(struct hci_dev *hdev)
>  {
>         struct mgmt_pending_cmd *cmd;
> @@ -975,40 +964,54 @@ static bool get_connectable(struct hci_dev *hdev)
>  static u32 get_adv_instance_flags(struct hci_dev *hdev, u8 instance)
>  {
>         u32 flags;
> +       struct adv_info *adv_instance;
>
> -       if (instance > 0x01)
> -               return 0;
> +       if (instance == 0x00) {
> +               /* Instance 0 always manages the "Tx Power" and "Flags"
> +                * fields.
> +                */
> +               flags = MGMT_ADV_FLAG_TX_POWER | MGMT_ADV_FLAG_MANAGED_FLAGS;
>
> -       if (instance == 0x01)
> -               return hdev->adv_instance.flags;
> +               /* For instance 0, the HCI_ADVERTISING_CONNECTABLE setting
> +                * corresponds to the "connectable" instance flag.
> +                */
> +               if (hci_dev_test_flag(hdev, HCI_ADVERTISING_CONNECTABLE))
> +                       flags |= MGMT_ADV_FLAG_CONNECTABLE;
>
> -       /* Instance 0 always manages the "Tx Power" and "Flags" fields */
> -       flags = MGMT_ADV_FLAG_TX_POWER | MGMT_ADV_FLAG_MANAGED_FLAGS;
> +               return flags;
> +       }
>
> -       /* For instance 0, the HCI_ADVERTISING_CONNECTABLE setting corresponds
> -        * to the "connectable" instance flag.
> -        */
> -       if (hci_dev_test_flag(hdev, HCI_ADVERTISING_CONNECTABLE))
> -               flags |= MGMT_ADV_FLAG_CONNECTABLE;
> +       adv_instance = hci_find_adv_instance(hdev, instance);
> +       if (adv_instance)
> +               return adv_instance->flags;
>
> -       return flags;

Add a comment right here saying that "instance" is invalid so we're returning 0.

> +       return 0;
>  }
>
> -static u8 get_adv_instance_scan_rsp_len(struct hci_dev *hdev, u8 instance)
> +static u8 get_cur_adv_instance_scan_rsp_len(struct hci_dev *hdev)
>  {
> -       /* Ignore instance 0 and other unsupported instances */
> -       if (instance != 0x01)
> +       u8 instance = get_current_adv_instance(hdev);
> +       struct adv_info *adv_instance;
> +
> +       /* Ignore instance 0 */
> +       if (instance == 0x00)
> +               return 0;
> +
> +       adv_instance = hci_find_adv_instance(hdev, instance);
> +       if (!adv_instance)
>                 return 0;
>
>         /* TODO: Take into account the "appearance" and "local-name" flags here.
>          * These are currently being ignored as they are not supported.
>          */
> -       return hdev->adv_instance.scan_rsp_len;
> +       return adv_instance->scan_rsp_len;
>  }
>
> -static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
> +static u8 create_adv_data(struct hci_dev *hdev, u8 *ptr)
>  {
> +       struct adv_info *adv_instance;
>         u8 ad_len = 0, flags = 0;
> +       u8 instance = get_current_adv_instance(hdev);
>         u32 instance_flags = get_adv_instance_flags(hdev, instance);
>
>         /* The Add Advertising command allows userspace to set both the general
> @@ -1044,11 +1047,13 @@ static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
>         }
>
>         if (instance) {

Maybe we should do this check earlier and just return 0 if instance
doesn't exist. This code worked before since the only valid instances
were 0x00 and 0x01. Now you may need to do a look up earlier and
return 0 if instance is non-zero and hci_find_adv_instance returns
NULL.

> -               memcpy(ptr, hdev->adv_instance.adv_data,
> -                      hdev->adv_instance.adv_data_len);
> -
> -               ad_len += hdev->adv_instance.adv_data_len;
> -               ptr += hdev->adv_instance.adv_data_len;
> +               adv_instance = hci_find_adv_instance(hdev, instance);
> +               if (adv_instance) {
> +                       memcpy(ptr, adv_instance->adv_data,
> +                              adv_instance->adv_data_len);
> +                       ad_len += adv_instance->adv_data_len;
> +                       ptr += adv_instance->adv_data_len;
> +               }
>         }
>
>         /* Provide Tx Power only if we can provide a valid value for it */
> @@ -1065,7 +1070,7 @@ static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
>         return ad_len;
>  }
>
> -static void update_adv_data_for_instance(struct hci_request *req, u8 instance)
> +static void update_adv_data(struct hci_request *req)
>  {
>         struct hci_dev *hdev = req->hdev;
>         struct hci_cp_le_set_adv_data cp;
> @@ -1076,7 +1081,7 @@ static void update_adv_data_for_instance(struct hci_request *req, u8 instance)
>
>         memset(&cp, 0, sizeof(cp));
>
> -       len = create_instance_adv_data(hdev, instance, cp.data);
> +       len = create_adv_data(hdev, cp.data);
>
>         /* There's nothing to do if the data hasn't changed */
>         if (hdev->adv_data_len == len &&
> @@ -1091,14 +1096,6 @@ static void update_adv_data_for_instance(struct hci_request *req, u8 instance)
>         hci_req_add(req, HCI_OP_LE_SET_ADV_DATA, sizeof(cp), &cp);
>  }
>
> -static void update_adv_data(struct hci_request *req)
> -{
> -       struct hci_dev *hdev = req->hdev;
> -       u8 instance = get_current_adv_instance(hdev);
> -
> -       update_adv_data_for_instance(req, instance);
> -}
> -
>  int mgmt_update_adv_data(struct hci_dev *hdev)
>  {
>         struct hci_request req;
> @@ -1277,7 +1274,7 @@ static void enable_advertising(struct hci_request *req)
>
>         if (connectable)
>                 cp.type = LE_ADV_IND;
> -       else if (get_adv_instance_scan_rsp_len(hdev, instance))
> +       else if (get_cur_adv_instance_scan_rsp_len(hdev))
>                 cp.type = LE_ADV_SCAN_IND;
>         else
>                 cp.type = LE_ADV_NONCONN_IND;
> @@ -1459,27 +1456,27 @@ static void advertising_removed(struct sock *sk, struct hci_dev *hdev,
>         mgmt_event(MGMT_EV_ADVERTISING_REMOVED, hdev, &ev, sizeof(ev), sk);
>  }
>
> -static void clear_adv_instance(struct hci_dev *hdev)
> +static void clear_adv_instance(struct sock *sk, struct hci_dev *hdev,
> +                              u8 instance)
>  {
> -       struct hci_request req;
> -
> -       if (!hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))
> -               return;
> -
> -       if (hdev->adv_instance.timeout)
> -               cancel_delayed_work(&hdev->adv_instance.timeout_exp);
> -
> -       memset(&hdev->adv_instance, 0, sizeof(hdev->adv_instance));
> -       advertising_removed(NULL, hdev, 1);
> -       hci_dev_clear_flag(hdev, HCI_ADVERTISING_INSTANCE);
> -
> -       if (!hdev_is_powered(hdev) ||
> -           hci_dev_test_flag(hdev, HCI_ADVERTISING))
> -               return;
> +       struct adv_info *adv_instance, *n;
> +       int err;
>
> -       hci_req_init(&req, hdev);
> -       disable_advertising(&req);
> -       hci_req_run(&req, NULL);

Why did you remove this logic? Advertising needs to be disabled if
HCI_ADVERTISING_INSTANCE is set and HCI_ADVERTISING wasn't. Hence most
of the logic above (within this function) is still needed.

> +       /* A value of 0 indicates that all instances should be cleared. */
> +       if (instance == 0x00) {
> +               list_for_each_entry_safe(adv_instance, n,
> +                                        &hdev->adv_instances, list) {

Didn't you add a hci_adv_instances_clear for this purpose? Now you
have nested loops for iterating through the list and doing the lookup.
If you've added this loop just to send the removed event, then perhaps
it makes more sense to make advertising_removed public (like
mgmt_advertising_removed) and to call it from hci.c. Or, just do a
loop first to send the removed events and then call
hci_adv_instances_clear.

> +                       err = hci_remove_adv_instance(hdev,
> +                                                     adv_instance->instance);
> +                       if (!err)

This error check isn't really necessary since you're looping through
valid instances.

> +                               advertising_removed(sk, hdev,
> +                                                   adv_instance->instance);
> +               }
> +       } else {
> +               err = hci_remove_adv_instance(hdev, instance);
> +               if (!err)
> +                       advertising_removed(sk, hdev, instance);
> +       }
>  }
>
>  static int clean_up_hci_state(struct hci_dev *hdev)
> @@ -1497,8 +1494,7 @@ static int clean_up_hci_state(struct hci_dev *hdev)
>                 hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
>         }
>
> -       if (hdev->adv_instance.timeout)
> -               clear_adv_instance(hdev);
> +       clear_adv_instance(NULL, hdev, 0x00);
>
>         if (hci_dev_test_flag(hdev, HCI_LE_ADV))
>                 disable_advertising(&req);
> @@ -4669,6 +4665,7 @@ static void set_advertising_complete(struct hci_dev *hdev, u8 status,
>  {
>         struct cmd_lookup match = { NULL, hdev };
>         struct hci_request req;
> +       struct adv_info *adv_instance;
>
>         hci_dev_lock(hdev);
>
> @@ -4697,11 +4694,14 @@ static void set_advertising_complete(struct hci_dev *hdev, u8 status,
>          * set up earlier, then enable the advertising instance.
>          */
>         if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
> -           !hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))
> +           !hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) ||
> +           list_empty(&hdev->adv_instances))

We should make sure that the HCI_ADVERTISING_INSTANCE setting is set
as long as hdev->adv_instances is non-empty and it's not set if the
list is empty.

>                 goto unlock;
>
>         hci_req_init(&req, hdev);
> -
> +       adv_instance = list_first_entry(&hdev->adv_instances,
> +                                       struct adv_info, list);
> +       hdev->cur_adv_instance = adv_instance->instance;

Add a comment here explaining why we're picking the first instance.
Why does this make sense and will this need to be updated in the
future? Add a TODO if necessary.

>         update_adv_data(&req);
>         enable_advertising(&req);
>
> @@ -4792,8 +4792,9 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
>
>         if (val) {
>                 /* Switch to instance "0" for the Set Advertising setting. */
> -               update_adv_data_for_instance(&req, 0);
> -               update_scan_rsp_data_for_instance(&req, 0);
> +               hdev->cur_adv_instance = 0x00;
> +               update_adv_data(&req);
> +               update_scan_rsp_data(&req);
>                 enable_advertising(&req);
>         } else {
>                 disable_advertising(&req);
> @@ -6781,8 +6782,10 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
>  {
>         struct mgmt_rp_read_adv_features *rp;
>         size_t rp_len;
> -       int err;
> +       int err, i;
>         bool instance;
> +       int num_adv_instances = 0;
> +       struct adv_info *adv_instance;
>         u32 supported_flags;
>
>         BT_DBG("%s", hdev->name);
> @@ -6795,12 +6798,11 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
>
>         rp_len = sizeof(*rp);
>
> -       /* Currently only one instance is supported, so just add 1 to the
> -        * response length.
> -        */
>         instance = hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE);
> -       if (instance)
> -               rp_len++;
> +       if (instance) {
> +               num_adv_instances = hci_num_adv_instances(hdev);
> +               rp_len += num_adv_instances;
> +       }
>
>         rp = kmalloc(rp_len, GFP_ATOMIC);
>         if (!rp) {
> @@ -6813,16 +6815,15 @@ static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
>         rp->supported_flags = cpu_to_le32(supported_flags);
>         rp->max_adv_data_len = HCI_MAX_AD_LENGTH;
>         rp->max_scan_rsp_len = HCI_MAX_AD_LENGTH;
> -       rp->max_instances = 1;
> +       rp->max_instances = HCI_MAX_ADV_INSTANCES;

Saw that you've done this here, so ignore my comment about this in
your previous patch.

> +       rp->num_instances = num_adv_instances;
>
> -       /* Currently only one instance is supported, so simply return the
> -        * current instance number.
> -        */
>         if (instance) {
> -               rp->num_instances = 1;
> -               rp->instance[0] = 1;
> -       } else {
> -               rp->num_instances = 0;
> +               i = 0;
> +               list_for_each_entry(adv_instance, &hdev->adv_instances, list) {
> +                       rp->instance[i] = adv_instance->instance;
> +                       i++;
> +               }
>         }
>
>         hci_dev_unlock(hdev);
> @@ -6882,24 +6883,37 @@ static void add_advertising_complete(struct hci_dev *hdev, u8 status,
>                                      u16 opcode)
>  {
>         struct mgmt_pending_cmd *cmd;
> +       struct mgmt_cp_add_advertising *cp = NULL;
>         struct mgmt_rp_add_advertising rp;
> +       struct adv_info *adv_instance;
>
>         BT_DBG("status %d", status);
>
>         hci_dev_lock(hdev);
>
>         cmd = pending_find(MGMT_OP_ADD_ADVERTISING, hdev);
> +       if (cmd)
> +               cp = cmd->param;

This makes the code complicated. Just check if (!cmd) and goto unlock,
so you won't need all the nested checks.
>
>         if (status) {
> +               /* TODO: Start advertising another adv instance if any? */
>                 hci_dev_clear_flag(hdev, HCI_ADVERTISING_INSTANCE);
> -               memset(&hdev->adv_instance, 0, sizeof(hdev->adv_instance));
> -               advertising_removed(cmd ? cmd->sk : NULL, hdev, 1);
> +
> +               if (cmd) {

If "cmd" is NULL for whatever reason, then we'll end up leaking the
instance. Maybe there is a better way to propagate the pending
instance ID?

> +                       adv_instance = hci_find_adv_instance(hdev,
> +                                                            cp->instance);
> +                       if (adv_instance) {
> +                               hci_remove_adv_instance(hdev, cp->instance);
> +                               advertising_removed(cmd ? cmd->sk : NULL, hdev,
> +                                                   cp->instance);
> +                       }
> +               }
>         }
>
>         if (!cmd)
>                 goto unlock;
>
> -       rp.instance = 0x01;
> +       rp.instance = cp->instance;
>
>         if (status)
>                 mgmt_cmd_status(cmd->sk, cmd->index, cmd->opcode,
> @@ -6916,13 +6930,33 @@ unlock:
>
>  static void adv_timeout_expired(struct work_struct *work)
>  {
> -       struct hci_dev *hdev = container_of(work, struct hci_dev,
> -                                           adv_instance.timeout_exp.work);
> +       struct adv_info *adv_instance;
> +       struct hci_dev *hdev;
> +       int err;
> +       struct hci_request req;
>
> -       hdev->adv_instance.timeout = 0;
> +       adv_instance = container_of(work, struct adv_info, timeout_exp.work);
> +       hdev = adv_instance->hdev;
> +
> +       adv_instance->timeout = 0;
>
>         hci_dev_lock(hdev);
> -       clear_adv_instance(hdev);
> +       err = hci_remove_adv_instance(hdev, adv_instance->instance);
> +       if (!err)
> +               advertising_removed(NULL, hdev, adv_instance->instance);
> +
> +       /* TODO: Schedule the next advertisement instance here if any. */
> +       hci_dev_clear_flag(hdev, HCI_ADVERTISING_INSTANCE);
> +
> +       if (!hdev_is_powered(hdev) ||
> +           hci_dev_test_flag(hdev, HCI_ADVERTISING))
> +               goto unlock;
> +
> +       hci_req_init(&req, hdev);
> +       disable_advertising(&req);
> +       hci_req_run(&req, NULL);

clr_adv_instance did/does exactly the code above, why are you
duplicating it here again?

> +
> +unlock:
>         hci_dev_unlock(hdev);
>  }
>
> @@ -6981,38 +7015,31 @@ static int add_advertising(struct sock *sk, struct hci_dev *hdev,
>                 goto unlock;
>         }
>
> -       INIT_DELAYED_WORK(&hdev->adv_instance.timeout_exp, adv_timeout_expired);
> -
> -       hdev->adv_instance.flags = flags;
> -       hdev->adv_instance.adv_data_len = cp->adv_data_len;
> -       hdev->adv_instance.scan_rsp_len = cp->scan_rsp_len;
> -
> -       if (cp->adv_data_len)
> -               memcpy(hdev->adv_instance.adv_data, cp->data, cp->adv_data_len);
> -
> -       if (cp->scan_rsp_len)
> -               memcpy(hdev->adv_instance.scan_rsp_data,
> -                      cp->data + cp->adv_data_len, cp->scan_rsp_len);
> -
> -       if (hdev->adv_instance.timeout)
> -               cancel_delayed_work(&hdev->adv_instance.timeout_exp);
> -
> -       hdev->adv_instance.timeout = timeout;
> +       err = hci_add_adv_instance(hdev, cp->instance, flags,
> +                                  cp->adv_data_len, cp->data,
> +                                  cp->scan_rsp_len,
> +                                  cp->data + cp->adv_data_len,
> +                                  adv_timeout_expired, timeout);
> +       if (err < 0) {
> +               err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
> +                                     MGMT_STATUS_FAILED);
> +               goto unlock;
> +       }
>
> -       if (timeout)
> -               queue_delayed_work(hdev->workqueue,
> -                                  &hdev->adv_instance.timeout_exp,
> -                                  msecs_to_jiffies(timeout * 1000));
> +       hdev->cur_adv_instance = cp->instance;
>
> +       /* TODO: Trigger an advertising added event even when instance
> +        * advertising is already switched on?
> +        */

With a single instance, what this prevents is sending an "added" event
for an instance that was previously added. So the TODO doesn't make
sense in that context but the new code needs to correctly abide by
that logic. What you actually need to pay attention to is to not send
any HCI commands to update advertising data every time you add a new
instance. So maybe add a TODO for that.

>         if (!hci_dev_test_and_set_flag(hdev, HCI_ADVERTISING_INSTANCE))
> -               advertising_added(sk, hdev, 1);
> +               advertising_added(sk, hdev, cp->instance);
>
>         /* If the HCI_ADVERTISING flag is set or the device isn't powered then
>          * we have no HCI communication to make. Simply return.
>          */
>         if (!hdev_is_powered(hdev) ||
>             hci_dev_test_flag(hdev, HCI_ADVERTISING)) {
> -               rp.instance = 0x01;
> +               rp.instance = cp->instance;
>                 err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_ADVERTISING,
>                                         MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
>                 goto unlock;
> @@ -7083,12 +7110,12 @@ static int remove_advertising(struct sock *sk, struct hci_dev *hdev,
>
>         BT_DBG("%s", hdev->name);
>
> -       /* The current implementation only allows modifying instance no 1. A
> -        * value of 0 indicates that all instances should be cleared.
> -        */
> -       if (cp->instance > 1)
> -               return mgmt_cmd_status(sk, hdev->id, MGMT_OP_REMOVE_ADVERTISING,
> -                                      MGMT_STATUS_INVALID_PARAMS);
> +       if (cp->instance != 0x00) {
> +               if (!hci_find_adv_instance(hdev, cp->instance))

if (cp->instance != 0x00 && !hci_find_adv_instance(hdev, cp->instance))

> +                       return mgmt_cmd_status(sk, hdev->id,
> +                                              MGMT_OP_REMOVE_ADVERTISING,
> +                                              MGMT_STATUS_INVALID_PARAMS);
> +       }
>
>         hci_dev_lock(hdev);
>
> @@ -7106,21 +7133,23 @@ static int remove_advertising(struct sock *sk, struct hci_dev *hdev,
>                 goto unlock;
>         }
>
> -       if (hdev->adv_instance.timeout)
> -               cancel_delayed_work(&hdev->adv_instance.timeout_exp);
> -
> -       memset(&hdev->adv_instance, 0, sizeof(hdev->adv_instance));
> -
> -       advertising_removed(sk, hdev, 1);
> +       clear_adv_instance(sk, hdev, cp->instance);
>
> +       /* TODO: Only switch off advertising if the instance list is empty
> +        * else switch to the next remaining adv instance.
> +        */
>         hci_dev_clear_flag(hdev, HCI_ADVERTISING_INSTANCE);
>
> -       /* If the HCI_ADVERTISING flag is set or the device isn't powered then
> -        * we have no HCI communication to make. Simply return.
> +       /* If the HCI_ADVERTISING[_INSTANCE] flag is set or the device
> +        * isn't powered then we have no HCI communication to make.
> +        * Simply return.
> +        */
> +       /* TODO: Only switch off instance advertising when the flag has
> +        * actually been unset (see TODO above).
>          */
>         if (!hdev_is_powered(hdev) ||
>             hci_dev_test_flag(hdev, HCI_ADVERTISING)) {
> -               rp.instance = 1;
> +               rp.instance = cp->instance;
>                 err = mgmt_cmd_complete(sk, hdev->id,
>                                         MGMT_OP_REMOVE_ADVERTISING,
>                                         MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


I think, aside from a few issues, this is going in the right
direction, so thanks for the patch. The patch is still a bit too large
for linux-bluetooth standards and it's a bit difficult to get through,
so if you can break it down into smaller logical pieces it will be
easier for the others to review it. I'm not an official maintainer on
the kernel side so either Johan or Marcel will need to sign off on
your patches.

Thanks,
Arman
