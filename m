Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1412991237-20847-1-git-send-email-fons@spotify.com>
References: <1412991237-20847-1-git-send-email-fons@spotify.com>
From: Alfonso Acosta <fons@spotify.com>
Date: Sat, 11 Oct 2014 03:37:03 +0200
Message-ID: <CAHF=Y4ok8pdO=aWPwBSEBwbN--XV6KPR0sDx-WjApp5eBfUZCQ@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: Defer connection-parameter removal when unpairing
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I shortened the commit message header and moved the
clear_bit(HCI_CONN_PARAM_REMOVAL_PEND) to cover all the pairing
completion cases.

On Sat, Oct 11, 2014 at 3:33 AM, Alfonso Acosta <fons@spotify.com> wrote:
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
> index b9517bd..eb9988f 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -356,6 +356,9 @@ static void hci_conn_timeout(struct work_struct *work)
>                 conn->state = BT_CLOSED;
>                 break;
>         }
> +
> +       if (test_and_clear_bit(HCI_CONN_PARAM_REMOVAL_PEND, &conn->flags))
> +               hci_conn_params_del(conn->hdev, &conn->dst, conn->dst_type);
>  }
>
>  /* Enter sniff mode */
> @@ -544,6 +547,9 @@ int hci_conn_del(struct hci_conn *conn)
>
>         hci_conn_del_sysfs(conn);
>
> +       if (test_bit(HCI_CONN_PARAM_REMOVAL_PEND, &conn->flags))
> +               hci_conn_params_del(conn->hdev, &conn->dst, conn->dst_type);
> +
>         hci_dev_put(hdev);
>
>         hci_conn_put(conn);
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 3fd88b0..0af579d 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -2699,7 +2699,7 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
>         struct mgmt_rp_unpair_device rp;
>         struct hci_cp_disconnect dc;
>         struct pending_cmd *cmd;
> -       struct hci_conn *conn;
> +       struct hci_conn *uninitialized_var(conn);
>         int err;
>
>         memset(&rp, 0, sizeof(rp));
> @@ -2736,7 +2736,17 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
>
>                 hci_remove_irk(hdev, &cp->addr.bdaddr, addr_type);
>
> -               hci_conn_params_del(hdev, &cp->addr.bdaddr, addr_type);
> +               conn = hci_conn_hash_lookup_ba(hdev, LE_LINK,
> +                                              &cp->addr.bdaddr);
> +
> +               /* If the BLE connection is being used, defer clearing up
> +                * the connection parameters until closing to give a
> +                * chance of keeping them if a repairing happens.
> +                */
> +               if (conn && !cp->disconnect)
> +                       set_bit(HCI_CONN_PARAM_REMOVAL_PEND, &conn->flags);
> +               else
> +                       hci_conn_params_del(hdev, &cp->addr.bdaddr, addr_type);
>
>                 err = hci_remove_ltk(hdev, &cp->addr.bdaddr, addr_type);
>         }
> @@ -2748,12 +2758,12 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
>         }
>
>         if (cp->disconnect) {
> +               /* Only lookup the connection in the BR/EDR since the
> +                * LE connection was already looked up earlier.
> +                */
>                 if (cp->addr.type == BDADDR_BREDR)
>                         conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK,
>                                                        &cp->addr.bdaddr);
> -               else
> -                       conn = hci_conn_hash_lookup_ba(hdev, LE_LINK,
> -                                                      &cp->addr.bdaddr);
>         } else {
>                 conn = NULL;
>         }
> @@ -3062,6 +3072,11 @@ static void pairing_complete(struct pending_cmd *cmd, u8 status)
>         hci_conn_put(conn);
>
>         mgmt_pending_remove(cmd);
> +
> +       /* The device is paired so there is no need to remove
> +        * its connection parameters anymore.
> +        */
> +       clear_bit(HCI_CONN_PARAM_REMOVAL_PEND, &conn->flags);
>  }
>
>  void mgmt_smp_complete(struct hci_conn *conn, bool complete)
> --
> 1.9.1
>



-- 
Alfonso Acosta

Embedded Systems Engineer at Spotify
Birger Jarlsgatan 61, Stockholm, Sweden
http://www.spotify.com
