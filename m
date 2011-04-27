Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1303945480-25756-7-git-send-email-johan.hedberg@gmail.com>
References: <1303945480-25756-1-git-send-email-johan.hedberg@gmail.com>
	<1303945480-25756-7-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 27 Apr 2011 19:47:33 -0400
Message-ID: <BANLkTikpQZ9MLvfnCH7oDMN2+_+M=M-QNQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] Bluetooth: Fix link key persistent storage criteria
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Apr 27, 2011 at 7:04 PM,  <johan.hedberg@gmail.com> wrote:
> @@ -1042,6 +1078,20 @@ int hci_add_link_key(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
>
>        BT_DBG("%s key for %s type %u", hdev->name, batostr(bdaddr), type);
>
> +       /* Some buggy controller combinations generate a changed
> +        * combination key for legacy pairing even when there's no
> +        * previous key */
> +       if (type == HCI_LK_CHANGED_COMBINATION &&
> +                                       (!conn || conn->remote_auth == 0xff) &&
> +                                       old_key_type == 0xff)
> +               type = HCI_LK_COMBINATION;
> +
> +       if (new_key && !hci_persistent_key(hdev, conn, type, old_key_type)) {
> +               list_del(&key->list);
> +               kfree(key);
> +               return 0;

Just to make sure, is this condition possible?

* new_key parameter not zero
* old_key variable not NULL

If so, "key" will point to an entry from hdev->link_keys , which will
be freed on the if() above without removing it from the list.

> +       }
> +
>        bacpy(&key->bdaddr, bdaddr);
>        memcpy(key->val, val, 16);
>        key->type = type;

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
