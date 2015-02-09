Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH] Bluetooth: Restrict access for raw-only controllers
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAE2MWk=4BB_VFrNwo+yY9A+yT_FwCAHhLQG9_c7gZwVUon6cew@mail.gmail.com>
Date: Mon, 9 Feb 2015 08:55:12 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <070A5502-B85F-4DFF-ABBE-33D5B05CE1BB@holtmann.org>
References: <CAE2MWk=4BB_VFrNwo+yY9A+yT_FwCAHhLQG9_c7gZwVUon6cew@mail.gmail.com>
To: Ujjal Roy <royujjal@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ujjal,

>>> /* Clear flags */
>>> - hdev->flags = 0;
>>> + hdev->flags &= BIT(HCI_RAW);
> 
> Is it for clearing the HCI_RAW flag? If so then it should be as below
> am I right?
> 
>  /* Clear flags */
> - hdev->flags = 0;
> + hdev->flags &= ~BIT(HCI_RAW);

this is for clearing all flags except the HCI_RAW bit.

Regards

Marcel

