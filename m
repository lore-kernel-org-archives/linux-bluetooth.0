Return-Path: <cyrus@holtmann.org>
Message-ID: <1322497029.29909.30.camel@aeonflux>
Subject: Re: [PATCH v2 1/9] Bluetooth: Add dev_flags to struct hci_dev
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 28 Nov 2011 17:17:09 +0100
In-Reply-To: <1322265226-6404-2-git-send-email-andre.guedes@openbossa.org>
References: <1322265226-6404-1-git-send-email-andre.guedes@openbossa.org>
	 <1322265226-6404-2-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds the dev_flags field to struct hci_dev. This new
> flags variable should be used to define flags related to BR/EDR
> and/or LE controller itself. It should be used to define flags
> which represents states from the controller. The dev_flags is
> cleared in case the controller sends a Reset Command Complete
> Event to the host.
> 
> Also, this patch adds the HCI_LE_SCAN flag which was created to
> track if the controller is performing LE scan or not. The flag
> is set/cleared when the controller starts/stops scanning.
> 
> This is an initial effort to stop using hdev->flags to define
> internal flags since it is exported to userspace by an ioctl.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci.h      |    8 ++++++++
>  include/net/bluetooth/hci_core.h |    2 ++
>  net/bluetooth/hci_core.c         |    1 +
>  net/bluetooth/hci_event.c        |    6 ++++++
>  4 files changed, 17 insertions(+), 0 deletions(-)

looks good to me.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


