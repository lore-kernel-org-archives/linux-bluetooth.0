Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1326966173-20105-2-git-send-email-johan.hedberg@gmail.com>
References: <1326966173-20105-1-git-send-email-johan.hedberg@gmail.com>
	<1326966173-20105-2-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 19 Jan 2012 07:38:58 -0400
Message-ID: <CAJdJm_Pa7EbOE7uxPajMvS5ZVZ=djbuTMgcswH5ZuOud_DDrSA@mail.gmail.com>
Subject: Re: [PATCH 1/3] Bluetooth: Merge boolean members of struct hci_conn
 into flags
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

Not sure if this is actually a bug, but mentioning anyway.

On Thu, Jan 19, 2012 at 5:42 AM,  <johan.hedberg@gmail.com> wrote:
> @@ -105,7 +105,8 @@ void hci_acl_connect(struct hci_conn *conn)
>                }
>
>                memcpy(conn->dev_class, ie->data.dev_class, 3);
> -               conn->ssp_mode = ie->data.ssp_mode;
> +               if (ie->data.ssp_mode > 0)
> +                       set_bit(HCI_CONN_SSP_ENABLED, &conn->flags);
>        }

Note that the code above is not semantically equivalent to the old
one. Given "conn" was not created on this function, the old code was
actually equivalent to:

if (ie->data.ssp_mode)
    conn->ssp_mode = 1;
else
    conn->ssp_mode = 0;

So I think you need set_bit/clear_bit branches here.

>
>        cp.pkt_type = cpu_to_le16(conn->pkt_type);
> [...]
> @@ -2780,7 +2783,8 @@ static inline void hci_remote_ext_features_evt(struct hci_dev *hdev, struct sk_b
>                if (ie)
>                        ie->data.ssp_mode = (ev->features[0] & 0x01);
>
> -               conn->ssp_mode = (ev->features[0] & 0x01);
> +               if (ev->features[0] & 0x01)
> +                       set_bit(HCI_CONN_SSP_ENABLED, &conn->flags);
>        }

Same here.

>
>        if (conn->state != BT_CONFIG)
> [...]
> @@ -2998,8 +3002,9 @@ static inline void hci_io_capa_reply_evt(struct hci_dev *hdev, struct sk_buff *s
>                goto unlock;
>
>        conn->remote_cap = ev->capability;
> -       conn->remote_oob = ev->oob_data;
>        conn->remote_auth = ev->authentication;
> +       if (ev->oob_data)
> +               set_bit(HCI_CONN_REMOTE_OOB, &conn->flags);

Same here.

>
>  unlock:
>        hci_dev_unlock(hdev);

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
