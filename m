Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1412859828-6224-1-git-send-email-fons@spotify.com>
References: <1412859828-6224-1-git-send-email-fons@spotify.com>
From: Alfonso Acosta <fons@spotify.com>
Date: Thu, 9 Oct 2014 15:26:47 +0200
Message-ID: <CAHF=Y4oTZjk6k0YeBA6xEpksZRWU1TTtkZfB+YESWmmRxNs0GA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Defer connection-parameter removal when
 unpairing without disconnecting
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

As an alternative to this patch, I am thinking that it may be worth
considering two other options:

1. Adding an additional repairing operation: MGMT_OP_REPAIR_DEVICE.
Making the repairing semantics explicit  would allow us to keep the connection
parameters even if we choose to disconnect when unpairing.  On the
other hand, one could argue that it clutters the API with an extra
operation which is the composite of two already existing operations.

2. Make MGMT_OP_PAIR_DEVICE behave like the repairing operation in (1)
if the device was already paired. If I recall properly, Johan suggested
this on IRC.

Comments?

Thanks,

Fons

On Thu, Oct 9, 2014 at 3:03 PM, Alfonso Acosta <fons@spotify.com> wrote:
> Systematically removing the LE connection parameters and autoconnect
> action is inconvenient for rebonding without disconnecting from
> userland (i.e. unpairing followed by repairing without
> disconnecting). The parameters will be lost after unparing and
> userland needs to take care of book-keeping them and re-adding them.
>
> This patch allows userland to forget about parameter management when
> rebonding without disconnecting. It defers clearing the connection
> parameters when unparing without disconnecting, giving a chance of
> keeping the parameters if a repairing happens before the connection is
> closed.
>
> Signed-off-by: Alfonso Acosta <fons@spotify.com>
> ---
>  include/net/bluetooth/hci_core.h |  1 +
>  net/bluetooth/hci_conn.c         |  6 ++++++
>  net/bluetooth/mgmt.c             | 16 +++++++++++++---
>  3 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 07ddeed62..b8685a7 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -555,6 +555,7 @@ enum {
>         HCI_CONN_STK_ENCRYPT,
>         HCI_CONN_AUTH_INITIATOR,
>         HCI_CONN_DROP,
> +       HCI_CONN_PARAM_REMOVAL_PEND,
>  };
>
>  static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index b9517bd..d106f29 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -356,6 +356,9 @@ static void hci_conn_timeout(struct work_struct *work)
>                 conn->state = BT_CLOSED;
>                 break;
>         }
> +
> +       if (test_and_clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->flags))
> +               hci_conn_params_del(conn->hdev, &conn->dst, conn->dst_type);
>  }
>
>  /* Enter sniff mode */
> @@ -544,6 +547,9 @@ int hci_conn_del(struct hci_conn *conn)
>
>         hci_conn_del_sysfs(conn);
>
> +       if (test_and_clear_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->flags))
> +               hci_conn_params_del(conn->hdev, &conn->dst, conn->dst_type);
> +
>         hci_dev_put(hdev);
>
>         hci_conn_put(conn);
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 3fd88b0..0f2c0e9 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -2700,6 +2700,7 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
>         struct hci_cp_disconnect dc;
>         struct pending_cmd *cmd;
>         struct hci_conn *conn;
> +       struct hci_conn *le_conn = NULL;
>         int err;
>
>         memset(&rp, 0, sizeof(rp));
> @@ -2736,7 +2737,17 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
>
>                 hci_remove_irk(hdev, &cp->addr.bdaddr, addr_type);
>
> -               hci_conn_params_del(hdev, &cp->addr.bdaddr, addr_type);
> +               le_conn = hci_conn_hash_lookup_ba(hdev, LE_LINK,
> +                                                 &cp->addr.bdaddr);
> +
> +               /* If the BLE connection is being used, defer clearing up
> +                * the connection parameters until closing to give a
> +                * chance of keeping them if a repairing happens.
> +                */
> +               if (le_conn && !cp->disconnect)
> +                       set_bit(HCI_CONN_PARAM_REMOVAL_PEND, &le_conn->flags);
> +               else
> +                       hci_conn_params_del(hdev, &cp->addr.bdaddr, addr_type);
>
>                 err = hci_remove_ltk(hdev, &cp->addr.bdaddr, addr_type);
>         }
> @@ -2752,8 +2763,7 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
>                         conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
>                                                        &cp->addr.bdaddr);
>                 else
> -                       conn = hci_conn_hash_lookup_ba(hdev, LE_LINK,
> -                                                      &cp->addr.bdaddr);
> +                       conn = le_conn;
>         } else {
>                 conn = NULL;
>         }
> --
> 1.9.1
>



-- 
Alfonso Acosta

Embedded Systems Engineer at Spotify
Birger Jarlsgatan 61, Stockholm, Sweden
http://www.spotify.com
