Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1320427013-5684-1-git-send-email-andre.guedes@openbossa.org>
References: <1320427013-5684-1-git-send-email-andre.guedes@openbossa.org>
Date: Fri, 4 Nov 2011 14:20:14 -0400
Message-ID: <CAJdJm_PMUz4L=Vm3=nAdU7c8Y5DicMbGywoczOfcsuZ1K+oSDA@mail.gmail.com>
Subject: Re: [PATCH 1/3] Bluetooth: Create hci_do_inquiry()
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Guedes,

On Fri, Nov 4, 2011 at 1:16 PM, Andre Guedes <andre.guedes@openbossa.org> wrote:
> -       err = hci_send_cmd(hdev, HCI_OP_INQUIRY, sizeof(cp), &cp);
> +       err = hci_do_inquiry(hdev, 0x08);

In a later patch in your tree you introduce this new definition:

net/bluetooth/mgmt.c:#define INQUIRY_LEN_BREDR 0x08 /* TGAP(100) */

Does it make sense to introduce it already here and use it above?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
