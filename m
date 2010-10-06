Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1286390535-27462-4-git-send-email-ville.tervo@nokia.com>
References: <1286390535-27462-1-git-send-email-ville.tervo@nokia.com>
	<1286390535-27462-4-git-send-email-ville.tervo@nokia.com>
Date: Wed, 6 Oct 2010 15:57:23 -0400
Message-ID: <AANLkTin0BCnGK00=kwJxV59cHxB4X6Zgve4u-XUDpGYO@mail.gmail.com>
Subject: Re: [PATCH 3/7] Bluetooth: LE disconnection and connect cancel support
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Ville Tervo <ville.tervo@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ville,

On Wed, Oct 6, 2010 at 2:42 PM, Ville Tervo <ville.tervo@nokia.com> wrote:
> @@ -627,9 +629,6 @@ struct hci_cp_le_create_conn {
>  } __packed;
>
>  #define HCI_OP_LE_CREATE_CONN_CANCEL   0x200e
> -struct hci_cp_le_create_conn_cancel {
> -       __u8     status;
> -} __packed;
>
>  #define HCI_OP_LE_SET_ADVERTISE_ENABLE 0x200a
>        #define LE_ADVERTISE_ENABLED    0x01

The struct above is added in 1/7 then removed on this one, so you
could drop it from patch 1/7 instead?

> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 89f4b10..a430a57 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -455,10 +455,13 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
>  #define lmp_rswitch_capable(dev)   ((dev)->features[0] & LMP_RSWITCH)
>  #define lmp_encrypt_capable(dev)   ((dev)->features[0] & LMP_ENCRYPT)
>  #define lmp_sniff_capable(dev)     ((dev)->features[0] & LMP_SNIFF)
> +#define lmp_br_capable(dev)        (!((dev)->features[4] & LMP_NO_BR))
> +#define lmp_le_capable(dev)        ((dev)->features[4] & LMP_LE)
>  #define lmp_sniffsubr_capable(dev) ((dev)->features[5] & LMP_SNIFF_SUBR)
>  #define lmp_esco_capable(dev)      ((dev)->features[3] & LMP_ESCO)
>  #define lmp_ssp_capable(dev)       ((dev)->features[6] & LMP_SIMPLE_PAIR)
>
> +
>  /* ----- HCI protocols ----- */

Unrelated extra line added above.

>  struct hci_proto {
>        char            *name;
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index cb41d64..50f8973 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -66,6 +66,31 @@ void hci_le_connect(struct hci_conn *conn)
>        hci_send_cmd(hdev, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp);
>  }
>
> +static void hci_le_connect_cancel(struct hci_conn *conn)
> +{
> +       struct hci_dev *hdev = conn->hdev;
> +
> +       BT_DBG("%p", conn);

This debug message could be made more readable, e.g.:

BT_DBG("%s conn %p", hdev->name, conn);

(or simply dropped if not that useful).

> +
> +       if (!lmp_le_capable(hdev))
> +               return;
> +
> +       hci_send_cmd(conn->hdev, HCI_OP_LE_CREATE_CONN_CANCEL, 0, NULL);
> +}
> +
> +void hci_le_disconn(struct hci_conn *conn, __u8 reason)
> +{
> +       struct hci_cp_disconnect cp;
> +
> +       BT_DBG("%p", conn);

Same here.

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
