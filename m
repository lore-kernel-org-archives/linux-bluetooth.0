Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1303945480-25756-1-git-send-email-johan.hedberg@gmail.com>
References: <1303945480-25756-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 27 Apr 2011 19:27:32 -0400
Message-ID: <BANLkTinxDHjLjAPqMLys3nxsjkHNnM=x0A@mail.gmail.com>
Subject: Re: [PATCH 1/7] Bluetooth: Add automated SSP user confirmation responses
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Apr 27, 2011 at 7:04 PM,  <johan.hedberg@gmail.com> wrote:
> @@ -2447,14 +2447,47 @@ static inline void hci_user_confirm_request_evt(struct hci_dev *hdev,
>                                                        struct sk_buff *skb)
>  {
>        struct hci_ev_user_confirm_req *ev = (void *) skb->data;
> +       int loc_mitm, rem_mitm;
> +       struct hci_conn *conn;
>
>        BT_DBG("%s", hdev->name);
>
>        hci_dev_lock(hdev);
>
> -       if (test_bit(HCI_MGMT, &hdev->flags))
> -               mgmt_user_confirm_request(hdev->id, &ev->bdaddr, ev->passkey);
> +       if (!test_bit(HCI_MGMT, &hdev->flags))
> +               goto unlock;

You lock hdev for checking hdev->flags, but not for reading hdev->name
on the BT_DBG() call. Is that ok?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
