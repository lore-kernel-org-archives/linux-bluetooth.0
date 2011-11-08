Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1320777616-15794-3-git-send-email-johan.hedberg@gmail.com>
References: <1320777616-15794-1-git-send-email-johan.hedberg@gmail.com>
	<1320777616-15794-3-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 8 Nov 2011 23:30:56 +0200
Message-ID: <CAMXE1-qLHUj_QzkuyT9NQmj+DBVvWLD_djoXG4x_FyVast=_SQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] Bluetooth: Add missing hci_dev locking when calling
 mgmt functions
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Nov 8, 2011 at 8:40 PM,  <johan.hedberg@gmail.com> wrote:
> From: Johan Hedberg <johan.hedberg@intel.com>
>
> Now that the pending commands are within struct hci_dev we can properly
> control access to them throught the hci_dev locking mechanism.
>
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_core.c  |   12 ++++++++++--
>  net/bluetooth/hci_event.c |   45 ++++++++++++++++++++++++++++++++++++++++-----
>  net/bluetooth/mgmt.c      |   13 +++++++------
>  3 files changed, 57 insertions(+), 13 deletions(-)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index e5cf013..f87bf24 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -549,8 +549,11 @@ int hci_dev_open(__u16 dev)
>                hci_dev_hold(hdev);
>                set_bit(HCI_UP, &hdev->flags);
>                hci_notify(hdev, HCI_DEV_UP);
> -               if (!test_bit(HCI_SETUP, &hdev->flags))
> +               if (!test_bit(HCI_SETUP, &hdev->flags)) {
> +                       hci_dev_lock_bh(hdev);
>                        mgmt_powered(hdev, 1);
> +                       hci_dev_unlock_bh(hdev);

Shall we acquire lock before test_bit here and below?

Regards,
Andrei

> +               }
>        } else {
>                /* Init failed, cleanup */
>                tasklet_kill(&hdev->rx_task);
> @@ -642,7 +645,9 @@ static int hci_dev_do_close(struct hci_dev *hdev)
>         * and no tasks are scheduled. */
>        hdev->close(hdev);
>
> +       hci_dev_lock_bh(hdev);
>        mgmt_powered(hdev, 0);
> +       hci_dev_unlock_bh(hdev);
>
>        /* Clear flags */
>        hdev->flags = 0;
> @@ -1561,8 +1566,11 @@ void hci_unregister_dev(struct hci_dev *hdev)
>                kfree_skb(hdev->reassembly[i]);
>
>        if (!test_bit(HCI_INIT, &hdev->flags) &&
> -                                       !test_bit(HCI_SETUP, &hdev->flags))
> +                                       !test_bit(HCI_SETUP, &hdev->flags)) {
> +               hci_dev_lock_bh(hdev);
>                mgmt_index_removed(hdev);
> +               hci_dev_unlock_bh(hdev);
> +       }
>
>        /* mgmt_index_removed should take care of emptying the
>         * pending list */
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 8303f8f..a89cf1f 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -60,7 +60,9 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
>
>        clear_bit(HCI_INQUIRY, &hdev->flags);
>
> +       hci_dev_lock(hdev);
>        mgmt_discovering(hdev, 0);
> +       hci_dev_unlock(hdev);
>
>        hci_req_complete(hdev, HCI_OP_INQUIRY_CANCEL, status);
>
> @@ -201,13 +203,15 @@ static void hci_cc_write_local_name(struct hci_dev *hdev, struct sk_buff *skb)
>        if (!sent)
>                return;
>
> +       hci_dev_lock(hdev);
> +
>        if (test_bit(HCI_MGMT, &hdev->flags))
>                mgmt_set_local_name_complete(hdev, sent, status);
>
> -       if (status)
> -               return;
> +       if (status == 0)
> +               memcpy(hdev->dev_name, sent, HCI_MAX_NAME_LENGTH);
>
> -       memcpy(hdev->dev_name, sent, HCI_MAX_NAME_LENGTH);
> +       hci_dev_unlock(hdev);
>  }
>
>  static void hci_cc_read_local_name(struct hci_dev *hdev, struct sk_buff *skb)
> @@ -282,6 +286,8 @@ static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
>
>        param = *((__u8 *) sent);
>
> +       hci_dev_lock(hdev);
> +
>        if (status != 0) {
>                mgmt_write_scan_failed(hdev, param, status);
>                hdev->discov_timeout = 0;
> @@ -311,6 +317,7 @@ static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
>                mgmt_connectable(hdev, 0);
>
>  done:
> +       hci_dev_unlock(hdev);
>        hci_req_complete(hdev, HCI_OP_WRITE_SCAN_ENABLE, status);
>  }
>
> @@ -834,19 +841,24 @@ static void hci_cc_pin_code_reply(struct hci_dev *hdev, struct sk_buff *skb)
>
>        BT_DBG("%s status 0x%x", hdev->name, rp->status);
>
> +       hci_dev_lock(hdev);
> +
>        if (test_bit(HCI_MGMT, &hdev->flags))
>                mgmt_pin_code_reply_complete(hdev, &rp->bdaddr, rp->status);
>
>        if (rp->status != 0)
> -               return;
> +               goto unlock;
>
>        cp = hci_sent_cmd_data(hdev, HCI_OP_PIN_CODE_REPLY);
>        if (!cp)
> -               return;
> +               goto unlock;
>
>        conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->bdaddr);
>        if (conn)
>                conn->pin_length = cp->pin_len;
> +
> +unlock:
> +       hci_dev_unlock(hdev);
>  }
>
>  static void hci_cc_pin_code_neg_reply(struct hci_dev *hdev, struct sk_buff *skb)
> @@ -855,10 +867,15 @@ static void hci_cc_pin_code_neg_reply(struct hci_dev *hdev, struct sk_buff *skb)
>
>        BT_DBG("%s status 0x%x", hdev->name, rp->status);
>
> +       hci_dev_lock(hdev);
> +
>        if (test_bit(HCI_MGMT, &hdev->flags))
>                mgmt_pin_code_neg_reply_complete(hdev, &rp->bdaddr,
>                                                                rp->status);
> +
> +       hci_dev_unlock(hdev);
>  }
> +
>  static void hci_cc_le_read_buffer_size(struct hci_dev *hdev,
>                                       struct sk_buff *skb)
>  {
> @@ -885,9 +902,13 @@ static void hci_cc_user_confirm_reply(struct hci_dev *hdev, struct sk_buff *skb)
>
>        BT_DBG("%s status 0x%x", hdev->name, rp->status);
>
> +       hci_dev_lock(hdev);
> +
>        if (test_bit(HCI_MGMT, &hdev->flags))
>                mgmt_user_confirm_reply_complete(hdev, &rp->bdaddr,
>                                                                rp->status);
> +
> +       hci_dev_unlock(hdev);
>  }
>
>  static void hci_cc_user_confirm_neg_reply(struct hci_dev *hdev,
> @@ -897,9 +918,13 @@ static void hci_cc_user_confirm_neg_reply(struct hci_dev *hdev,
>
>        BT_DBG("%s status 0x%x", hdev->name, rp->status);
>
> +       hci_dev_lock(hdev);
> +
>        if (test_bit(HCI_MGMT, &hdev->flags))
>                mgmt_user_confirm_neg_reply_complete(hdev, &rp->bdaddr,
>                                                                rp->status);
> +
> +       hci_dev_unlock(hdev);
>  }
>
>  static void hci_cc_read_local_oob_data_reply(struct hci_dev *hdev,
> @@ -909,8 +934,10 @@ static void hci_cc_read_local_oob_data_reply(struct hci_dev *hdev,
>
>        BT_DBG("%s status 0x%x", hdev->name, rp->status);
>
> +       hci_dev_lock(hdev);
>        mgmt_read_local_oob_data_reply_complete(hdev, rp->hash,
>                                                rp->randomizer, rp->status);
> +       hci_dev_unlock(hdev);
>  }
>
>  static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
> @@ -985,14 +1012,18 @@ static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
>        if (status) {
>                hci_req_complete(hdev, HCI_OP_INQUIRY, status);
>                hci_conn_check_pending(hdev);
> +               hci_dev_lock(hdev);
>                if (test_bit(HCI_MGMT, &hdev->flags))
>                        mgmt_inquiry_failed(hdev, status);
> +               hci_dev_unlock(hdev);
>                return;
>        }
>
>        set_bit(HCI_INQUIRY, &hdev->flags);
>
> +       hci_dev_lock(hdev);
>        mgmt_discovering(hdev, 1);
> +       hci_dev_unlock(hdev);
>  }
>
>  static inline void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
> @@ -1378,7 +1409,9 @@ static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff
>        if (!test_and_clear_bit(HCI_INQUIRY, &hdev->flags))
>                return;
>
> +       hci_dev_lock(hdev);
>        mgmt_discovering(hdev, 0);
> +       hci_dev_unlock(hdev);
>  }
>
>  static inline void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
> @@ -1572,7 +1605,9 @@ static inline void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff
>        BT_DBG("%s status %d", hdev->name, ev->status);
>
>        if (ev->status) {
> +               hci_dev_lock(hdev);
>                mgmt_disconnect_failed(hdev);
> +               hci_dev_unlock(hdev);
>                return;
>        }
>
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index be198f3..be4c3d0 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -1335,16 +1335,19 @@ static void pairing_complete(struct pending_cmd *cmd, u8 status)
>  static void pairing_complete_cb(struct hci_conn *conn, u8 status)
>  {
>        struct pending_cmd *cmd;
> +       struct hci_dev *hdev = conn->hdev;
>
>        BT_DBG("status %u", status);
>
> +       hci_dev_lock_bh(hdev);
> +
>        cmd = find_pairing(conn);
> -       if (!cmd) {
> +       if (!cmd)
>                BT_DBG("Unable to find a pending command");
> -               return;
> -       }
> +       else
> +               pairing_complete(cmd, status);
>
> -       pairing_complete(cmd, status);
> +       hci_dev_unlock_bh(hdev);
>  }
>
>  static int pair_device(struct sock *sk, u16 index, unsigned char *data, u16 len)
> @@ -2302,9 +2305,7 @@ int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status)
>                goto failed;
>        }
>
> -       hci_dev_lock_bh(hdev);
>        update_eir(hdev);
> -       hci_dev_unlock_bh(hdev);
>
>        err = cmd_complete(cmd->sk, hdev->id, MGMT_OP_SET_LOCAL_NAME, &ev,
>                                                                sizeof(ev));
> --
> 1.7.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
