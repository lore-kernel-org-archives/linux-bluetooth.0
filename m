Return-Path: <cyrus@holtmann.org>
Message-ID: <1328303718.2062.48.camel@aeonflux>
Subject: Re: [PATCH v5 3/6] Bluetooth: Add hci_do_le_scan()
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 03 Feb 2012 13:15:18 -0800
In-Reply-To: <1328302082-17405-3-git-send-email-andre.guedes@openbossa.org>
References: <1328302082-17405-1-git-send-email-andre.guedes@openbossa.org>
	 <1328302082-17405-3-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds to hci_core the hci_do_le_scan function which
> should be used to scan LE devices.
> 
> In order to enable LE scan, hci_do_le_scan() sends commands (Set
> LE Scan Parameters and Set LE Scan Enable) to the controller and
> waits for its results. If commands were executed successfully a
> delayed work is scheduled to disable the ongoing scanning after
> some amount of time. This function blocks.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |    8 ++++
>  net/bluetooth/hci_core.c         |   74 ++++++++++++++++++++++++++++++++++++++
>  net/bluetooth/hci_event.c        |   13 +++++--
>  3 files changed, 92 insertions(+), 3 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


