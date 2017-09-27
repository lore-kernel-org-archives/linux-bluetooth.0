Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <59cb6941.c5a6620a.7783d.deb6@mx.google.com>
References: <59cb6941.c5a6620a.7783d.deb6@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 27 Sep 2017 12:49:38 +0300
Message-ID: <CABBYNZK0dT=AEqD9iyddzuwAgEchrqh+OwwmB_D1t2tFUrdPxw@mail.gmail.com>
Subject: Re: [RFC 2/2] Use whitelist along with resolving list to enable
 device filtering
To: Shermin Joy <shermin.joy@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Sep 27, 2017 at 12:04 PM, Shermin Joy <shermin.joy@gmail.com> wrote:
> Whenever a peer using RPA is to be added to the whitelist, it is added to
> the resolving list. If its IRK is not known or resolving list is full,
> then the peer cannot be added to resolving list. If the device cannot
> be added to resolving list, then the usage of whitelist is not allowed.

I think we are better off using the resolving list in a LRU fashion as
chances are that new devices would be used more than older devices,
perhaps it could be so that the resolving list is sorted based on the
last time it was connected, so devices that are most used are more
likely to be in the resolving list.

> Signed-off-by: Shermin Joy <shermin.joy@gmail.com>
> ---
>  include/net/bluetooth/hci_core.h |   4 ++
>  net/bluetooth/hci_core.c         |   8 +++
>  net/bluetooth/hci_request.c      | 149 ++++++++++++++++++++++++++++++++++++---
>  3 files changed, 150 insertions(+), 11 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 82c9589..5639b6e 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -138,6 +138,7 @@ struct smp_irk {
>         u8 addr_type;
>         u8 val[16];
>         bool in_ll_resolving_list;
> +       bool changed;
>  };
>
>  struct link_key {
> @@ -1539,6 +1540,9 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
>  void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
>                                u8 *bdaddr_type);
>
> +int hci_req_update_resolving_list(struct hci_dev *hdev,  u8 addr_type,
> +                                 bdaddr_t *bdaddr, u8 irk[16]);
> +
>  #define SCO_AIRMODE_MASK       0x0003
>  #define SCO_AIRMODE_CVSD       0x0000
>  #define SCO_AIRMODE_TRANSP     0x0003
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index ab16e71..c2860f9 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2215,6 +2215,8 @@ void hci_smp_irks_clear(struct hci_dev *hdev)
>                 list_del_rcu(&k->list);
>                 kfree_rcu(k, rcu);
>         }
> +
> +       hci_req_clear_resolving_list(hdev);
>  }
>
>  struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
> @@ -2438,6 +2440,8 @@ struct smp_irk *hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr,
>                 irk->addr_type = addr_type;
>
>                 list_add_rcu(&irk->list, &hdev->identity_resolving_keys);
> +       } else {
> +               irk->changed = true;
>         }
>
>         memcpy(irk->val, val, 16);
> @@ -2491,6 +2495,10 @@ void hci_remove_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type)
>
>                 BT_DBG("%s removing %pMR", hdev->name, bdaddr);
>
> +               if (k->in_ll_resolving_list)
> +                       hci_req_del_from_resolving_list(hdev, addr_type,
> +                                                       bdaddr);
> +
>                 list_del_rcu(&k->list);
>                 kfree_rcu(k, rcu);
>         }
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index 6dcc827..3ad0b16 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -682,6 +682,7 @@ static u8 update_white_list(struct hci_request *req)
>         struct hci_conn_params *params;
>         struct bdaddr_list *b;
>         uint8_t white_list_entries = 0;
> +       struct smp_irk *irk;
>
>         /* Go through the current white list programmed into the
>          * controller one by one and check if that address is still
> @@ -707,9 +708,19 @@ static u8 update_white_list(struct hci_request *req)
>                         continue;
>                 }
>
> -               if (hci_find_irk_by_addr(hdev, &b->bdaddr, b->bdaddr_type)) {
> -                       /* White list can not be used with RPAs */
> -                       return 0x00;
> +               irk = hci_find_irk_by_addr(hdev, &b->bdaddr, b->bdaddr_type);
> +               if ((irk) && (!irk->in_ll_resolving_list)) {
> +                       /* White list can not be used with RPAs if
> +                        * device is not added in resolving list.
> +                        */
> +                       if (!hdev->le_ll_addr_resolve_enabled)
> +                               return 0x00;
> +
> +                       if (hci_req_update_resolving_list(hdev,
> +                                                         irk->addr_type,
> +                                                         &irk->bdaddr,
> +                                                         irk->val))
> +                               return 0x00;
>                 }
>
>                 white_list_entries++;
> @@ -735,10 +746,19 @@ static u8 update_white_list(struct hci_request *req)
>                         return 0x00;
>                 }
>
> -               if (hci_find_irk_by_addr(hdev, &params->addr,
> -                                        params->addr_type)) {
> -                       /* White list can not be used with RPAs */
> -                       return 0x00;
> +               irk = hci_find_irk_by_addr(hdev, &b->bdaddr, b->bdaddr_type);
> +               if ((irk) && (!irk->in_ll_resolving_list)) {
> +                       /* White list can not be used with RPAs if
> +                        * device is not added in resolving list.
> +                        */
> +                       if (!hdev->le_ll_addr_resolve_enabled)
> +                               return 0x00;
> +
> +                       if (hci_req_update_resolving_list(hdev,
> +                                                         irk->addr_type,
> +                                                         &irk->bdaddr,
> +                                                         irk->val))
> +                               return 0x00;
>                 }
>
>                 white_list_entries++;
> @@ -759,10 +779,19 @@ static u8 update_white_list(struct hci_request *req)
>                         return 0x00;
>                 }
>
> -               if (hci_find_irk_by_addr(hdev, &params->addr,
> -                                        params->addr_type)) {
> -                       /* White list can not be used with RPAs */
> -                       return 0x00;
> +               irk = hci_find_irk_by_addr(hdev, &b->bdaddr, b->bdaddr_type);
> +               if ((irk) && (!irk->in_ll_resolving_list)) {
> +                       /* White list can not be used with RPAs if
> +                        * device is not added in resolving list.
> +                        */
> +                       if (!hdev->le_ll_addr_resolve_enabled)
> +                               return 0x00;
> +
> +                       if (hci_req_update_resolving_list(hdev,
> +                                                         irk->addr_type,
> +                                                         &irk->bdaddr,
> +                                                         irk->val))
> +                               return 0x00;
>                 }
>
>                 white_list_entries++;
> @@ -787,6 +816,104 @@ static void add_to_resolving_list(struct hci_request *req, u8 addr_type,
>         hci_req_add(req, HCI_OP_LE_ADD_TO_RESOLVING_LIST, sizeof(cp), &cp);
>  }
>
> +int hci_req_update_resolving_list(struct hci_dev *hdev, u8 addr_type,
> +                                 bdaddr_t *bdaddr, u8 irk_val[16])
> +{
> +       struct hci_request req;
> +       struct hci_cp_le_del_from_resolving_list cp;
> +       struct bdaddr_list *b;
> +       struct smp_irk *irk;
> +       u8 resolving_list_entries;
> +       bool match;
> +
> +       /* Nothing to be done if LL privacy is not supported. */
> +       if (hdev->le_features[0] & HCI_LE_LL_PRIVACY)
> +               return -1;
> +
> +       /* Resolving List cannot be updated if address resolution
> +        * in the controller is enabled and advertisement or scanning
> +        * or create connection command is ongoing.
> +        */
> +       if ((hdev->le_ll_addr_resolve_enabled) &&
> +           ((hci_dev_test_flag(hdev, HCI_LE_ADV)) ||
> +           (hci_dev_test_flag(hdev, HCI_LE_SCAN)) ||
> +           (hci_lookup_le_connect(hdev))))
> +               return -1;
> +
> +       hci_req_init(&req, hdev);
> +
> +       irk = hci_find_irk_by_addr(hdev, bdaddr, addr_type);
> +       if (!irk)
> +               return -1;
> +
> +       if (irk->in_ll_resolving_list) {
> +               /* If device is present in the resolving list, and IRK
> +                * has not changed nothing more is to be done.
> +                */
> +               if (!irk->changed)
> +                       return 0;
> +
> +               /* If IRK has changed, remove the device and add it again.*/
> +               goto remove_device;
> +       }
> +
> +       /* Add device to resolving list., if resolving list is not full.*/
> +       resolving_list_entries = 0;
> +       rcu_read_lock();
> +       list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list) {
> +               if (irk->in_ll_resolving_list)
> +                       resolving_list_entries++;
> +       }
> +       rcu_read_unlock();
> +
> +       if (resolving_list_entries < hdev->le_resolving_list_size)
> +               goto add_device;
> +
> +       /* If resolving list is full, go through the current resolving list
> +        * programmed into the controller one by one and check if that
> +        * peer is present in the whitelist. The first entry that is not present
> +        * in whitelist is queued up for deletion.
> +        */
> +       resolving_list_entries = 0;
> +       rcu_read_lock();
> +       list_for_each_entry_rcu(irk, &hdev->identity_resolving_keys, list) {
> +               if (!irk->in_ll_resolving_list)
> +                       continue;
> +
> +               match = false;
> +               list_for_each_entry(b, &hdev->le_white_list, list) {
> +                       if (bacmp(&irk->bdaddr, &b->bdaddr) == 0 &&
> +                           irk->addr_type == b->bdaddr_type) {
> +                               match = true;
> +                               resolving_list_entries++;
> +                               break;
> +                       }
> +               }
> +
> +               /* If the resolving list is still full return, without
> +                * adding the device.
> +                */
> +               if (resolving_list_entries >= hdev->le_resolving_list_size) {
> +                       rcu_read_unlock();
> +                       return -1;
> +               }
> +
> +               if (!match)
> +                       break;
> +       }
> +       rcu_read_unlock();
> +
> +remove_device:
> +       cp.peer_bdaddr_type = irk->addr_type;
> +       bacpy(&cp.peer_bdaddr, &irk->bdaddr);
> +       hci_req_add(&req, HCI_OP_LE_DEL_FROM_RESOLVING_LIST, sizeof(cp), &cp);
> +
> +add_device:
> +       add_to_resolving_list(&req, addr_type, bdaddr, irk_val);
> +       hci_req_run(&req, NULL);
> +       return 0;
> +}
> +
>  void hci_req_del_from_resolving_list(struct hci_dev *hdev, u8 addr_type,
>                                      bdaddr_t *bdaddr)
>  {
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
