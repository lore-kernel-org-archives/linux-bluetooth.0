Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH] Bluetooth: Add hdev parameter to hdev->send driver callback
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1381500064-24414-1-git-send-email-marcel@holtmann.org>
Date: Fri, 11 Oct 2013 16:03:00 +0200
Message-Id: <1D46381C-51B2-48D1-A6D5-BEBED159A0A7@holtmann.org>
References: <1381500064-24414-1-git-send-email-marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Instead of masking hdev inside the skb->dev parameter, hand it
> directly to the driver as a parameter to hdev->send. This makes
> the driver interface more clear and simpler.
> 
> This patch fixes all drivers to accept and handle the new parameter
> of hdev->send callback. Special care has been taken for bpa10x
> and btusb drivers that require having skb->dev set to hdev for
> the URB transmit complete handlers.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
> drivers/bluetooth/bfusb.c        | 3 +--
> drivers/bluetooth/bluecard_cs.c  | 3 +--
> drivers/bluetooth/bpa10x.c       | 5 +++--
> drivers/bluetooth/bt3c_cs.c      | 3 +--
> drivers/bluetooth/btmrvl_main.c  | 4 +---
> drivers/bluetooth/btsdio.c       | 3 +--
> drivers/bluetooth/btuart_cs.c    | 3 +--
> drivers/bluetooth/btusb.c        | 5 +++--
> drivers/bluetooth/btwilink.c     | 5 +----
> drivers/bluetooth/dtl1_cs.c      | 3 +--
> drivers/bluetooth/hci_ldisc.c    | 3 +--
> drivers/bluetooth/hci_ll.c       | 1 -
> drivers/bluetooth/hci_vhci.c     | 3 +--
> include/net/bluetooth/hci_core.h | 2 +-
> net/bluetooth/hci_core.c         | 4 +---
> 15 files changed, 18 insertions(+), 32 deletions(-)

I accidentally send this one twice. So just ignore it.

Regards

Marcel

