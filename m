Return-Path: <cyrus@holtmann.org>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Message-Id: <05565665-4792-4522-B346-DD1C5EEDB4CE@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: Ben Collins <ben.collins@canonical.com>
In-Reply-To: <1216656014.7585.146.camel@cunning>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v928.1)
Subject: Re: [PATCH 3/7] bluetooth: Add quirks for a few hci_usb devices
Date: Tue, 22 Jul 2008 01:30:14 +0200
References: <E1KKl4I-00068H-S6@swissweb.swissdisk.com> <1216616891.8411.114.camel@violet.holtmann.net> <1216656014.7585.146.camel@cunning>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ben,

> Preface: The "Broadcom" device is on unreleased hardware, so I can't
> disclose the actual model.

then put on your todo list to update this entry once you can.

> When the Dell 370 and 410 BT adapters are put into BT radio mode, they
> need to be prepared like many other Broadcom adapters.
>
> Also, add quirk Broadcom 2046 devices with HCI_RESET. Reference for  
> this
> bug: https://launchpad.net/bugs/249448
>
> CC: linux-bluetooth@vger.kernel.org
> Signed-off-by: Michael Frey <michael.frey@canonical.com>
> Signed-off-by: Mario Limonciello <Mario_Limonciello@Dell.com>
> Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
> Signed-off-by: Ben Collins <ben.collins@canonical.com>

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

