Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1380640922-18647-4-git-send-email-johan.hedberg@gmail.com>
References: <1380640922-18647-1-git-send-email-johan.hedberg@gmail.com>
	<1380640922-18647-4-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 1 Oct 2013 11:46:40 -0400
Message-ID: <CAJdJm_MWy0d=5HgqsKQDzhhAL5CZszNOwTai9LZXx8Sy=npyVA@mail.gmail.com>
Subject: Re: [RFC 3/3] Bluetooth: Add a new mgmt_set_bredr command
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Oct 1, 2013 at 11:22 AM,  <johan.hedberg@gmail.com> wrote:
> +       if (!lmp_bredr_capable(hdev) || !lmp_le_capable(hdev))
> +               return cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
> +                                 MGMT_STATUS_REJECTED);
> +
> +       if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
> +               return cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
> +                                 MGMT_STATUS_REJECTED);
> +
> +       if (cp->val != 0x00 && cp->val != 0x01)
> +               return cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
> +                                 MGMT_STATUS_INVALID_PARAMS);

Looks like the above 3 cmd_status() should use MGMT_OP_SET_BREDR.

> +
> +       hci_dev_lock(hdev);
> +
> +       val = !!cp->val;
> +       enabled = test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
> +
> +       if (!hdev_is_powered(hdev) || val == enabled) {
> +               bool changed = false;
> +
> +               if (val != test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
> +                       change_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
> +                       changed = true;
> +               }

IMHO the trick used in another patch from Marcel (sent a while ago for
enabling/disabling HS) is easier to follow, something like (may
require adaptation if the logic is not the same than MGMT_OP_SET_HS):

if (cp->val)
    changed = !test_and_set_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
else
    changed = test_and_clear_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);


> +
> +               err = send_settings_rsp(sk, MGMT_OP_SET_BREDR, hdev);
> +               if (err < 0)
> +                       goto unlock;
> +
> +               if (changed)
> +                       err = new_settings(hdev, sk);
> +
> +               goto unlock;
> +       }

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
