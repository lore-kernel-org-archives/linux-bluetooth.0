Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1298456785-1572-2-git-send-email-szymon.janc@tieto.com>
References: <1298456785-1572-1-git-send-email-szymon.janc@tieto.com>
	<1298456785-1572-2-git-send-email-szymon.janc@tieto.com>
Date: Wed, 23 Feb 2011 10:14:44 -0300
Message-ID: <AANLkTin=5B6E26nzSkGad0W7FfTc+3S0_7F7ErsBLbbp@mail.gmail.com>
Subject: Re: [PATCH 2/3] Bluetooth: Move index to common header in management interface
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com,
	henrik.possung@stericsson.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Feb 23, 2011 at 7:26 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
> @@ -567,22 +558,20 @@ static int update_class(struct hci_dev *hdev)
>        return hci_send_cmd(hdev, HCI_OP_WRITE_CLASS_OF_DEV, sizeof(cod), cod);
>  }
>
> -static int add_uuid(struct sock *sk, unsigned char *data, u16 len)
> +static int add_uuid(struct sock *sk, u16 index, unsigned char *data, u16 len)
>  {
>        struct mgmt_cp_add_uuid *cp;
>        struct hci_dev *hdev;
>        struct bt_uuid *uuid;
> -       u16 dev_id;
>        int err;
>
>        cp = (void *) data;
> -       dev_id = get_unaligned_le16(&cp->index);
>
> -       BT_DBG("request for hci%u", dev_id);
> +       BT_DBG("request for hci%u", index);
>
> -       hdev = hci_dev_get(dev_id);
> +       hdev = hci_dev_get(index);
>        if (!hdev)
> -               return cmd_status(sk, MGMT_OP_ADD_UUID, ENODEV);
> +               return cmd_status(sk, index, MGMT_OP_ADD_UUID, ENODEV);
>
>        hci_dev_lock_bh(hdev);
>
> @@ -601,7 +590,7 @@ static int add_uuid(struct sock *sk, unsigned char *data, u16 len)
>        if (err < 0)
>                goto failed;
>
> -       err = cmd_complete(sk, MGMT_OP_ADD_UUID, &dev_id, sizeof(dev_id));
> +       err = cmd_complete(sk, index, MGMT_OP_ADD_UUID, &index, sizeof(index));

Is index still required to be passed as return parameter, now that it
is part of the header? This is the case for various other commands.

>
>  failed:
>        hci_dev_unlock_bh(hdev);
> @@ -610,23 +599,21 @@ failed:
>        return err;
>  }
>
> -static int remove_uuid(struct sock *sk, unsigned char *data, u16 len)
> +static int remove_uuid(struct sock *sk, u16 index, unsigned char *data, u16 len)
>  {
>        struct list_head *p, *n;
>        struct mgmt_cp_remove_uuid *cp;
>        struct hci_dev *hdev;
>        u8 bt_uuid_any[] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
> -       u16 dev_id;
>        int err, found;
>
>        cp = (void *) data;
> -       dev_id = get_unaligned_le16(&cp->index);
>
> -       BT_DBG("request for hci%u", dev_id);
> +       BT_DBG("request for hci%u", index);
>
> -       hdev = hci_dev_get(dev_id);
> +       hdev = hci_dev_get(index);
>        if (!hdev)
> -               return cmd_status(sk, MGMT_OP_REMOVE_UUID, ENODEV);
> +               return cmd_status(sk, index, MGMT_OP_REMOVE_UUID, ENODEV);
>
>        hci_dev_lock_bh(hdev);
>
> @@ -648,7 +635,7 @@ static int remove_uuid(struct sock *sk, unsigned char *data, u16 len)
>        }
>
>        if (found == 0) {
> -               err = cmd_status(sk, MGMT_OP_REMOVE_UUID, ENOENT);
> +               err = cmd_status(sk, index, MGMT_OP_REMOVE_UUID, ENOENT);
>                goto unlock;
>        }
>
> @@ -656,7 +643,7 @@ static int remove_uuid(struct sock *sk, unsigned char *data, u16 len)
>        if (err < 0)
>                goto unlock;
>
> -       err = cmd_complete(sk, MGMT_OP_REMOVE_UUID, &dev_id, sizeof(dev_id));
> +       err = cmd_complete(sk, index, MGMT_OP_REMOVE_UUID, NULL, 0);

Here controller index is not being passed as return parameter anymore,
so it looks inconsistent to me.

>
>  unlock:
>        hci_dev_unlock_bh(hdev);
> @@ -665,21 +652,20 @@ unlock:

In general, I think all commands which used to have controller index
as parameters (both cp and rp), would need to be modified because
index is already part of the header.

Also be sure to update doc/mgmt-api.txt from BlueZ.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
