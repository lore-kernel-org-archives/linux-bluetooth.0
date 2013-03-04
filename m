Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1362391748-21653-4-git-send-email-johan.hedberg@gmail.com>
References: <1362391748-21653-1-git-send-email-johan.hedberg@gmail.com>
	<1362391748-21653-4-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 4 Mar 2013 06:59:03 -0400
Message-ID: <CAJdJm_Pj4_O8N1uYVSg6qsJm+L7PyGyPGNo-_y-FC+dWybotqQ@mail.gmail.com>
Subject: Re: [PATCH 03/11] Bluetooth: Split HCI init sequence into three stages
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, Mar 4, 2013 at 6:09 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> From: Johan Hedberg <johan.hedberg@intel.com>
>
> Having contitional command sending during a request has always been
> problematic and caused hacks like the hdev->init_last_cmd variable. This
> patch removes these conditionals and instead splits the init sequence
> into three stages, each with its own __hci_request() call.

Typos:

contitional -> conditional
__hci_request() -> __hci_req_sync()

> +static int __hci_init(struct hci_dev *hdev)
> +{
> +       int err;
> +
> +       err = __hci_req_sync(hdev, hci_init1_req, 0, HCI_INIT_TIMEOUT);
> +       if (err < 0)
> +               return err;
> +
> +       /* AMP controllers do not need stage 2/3 init */
> +       if (hdev->dev_type != HCI_BREDR)
> +               return 0;

What about checking for "dev_type == HCI_AMP" instead? I had to check
net/bluetooth/hci.h because for a moment I thought Dual mode and
single mode LE devices were being left out as well. I then realized
you can only have BREDR vs. AMP controller types.

> +
> +       err = __hci_req_sync(hdev, hci_init2_req, 0, HCI_INIT_TIMEOUT);
> +       if (err < 0)
> +               return err;
> +
> +       return __hci_req_sync(hdev, hci_init3_req, 0, HCI_INIT_TIMEOUT);
> +}
> +

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
