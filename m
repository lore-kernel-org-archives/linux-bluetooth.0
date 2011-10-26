Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/2] Bluetooth: Ignore hci_unregister_dev return value
From: Marcel Holtmann <marcel@holtmann.org>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Date: Wed, 26 Oct 2011 10:55:17 +0200
In-Reply-To: <1319618599-10938-1-git-send-email-dh.herrmann@googlemail.com>
References: <1319618599-10938-1-git-send-email-dh.herrmann@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1319619318.15441.251.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> Make all bluetooth drivers ignore the return value of hci_unregister_dev as it
> always returns 0. In the next step, hci_unregister_dev can be modified to return
> void.
> Some of the drivers already ignore the return value (including btusb), hence,
> this will increase consitency in the bluetooth drivers.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
>  drivers/bluetooth/bfusb.c       |    4 +---
>  drivers/bluetooth/bluecard_cs.c |    4 +---
>  drivers/bluetooth/bt3c_cs.c     |    4 +---
>  drivers/bluetooth/btuart_cs.c   |    4 +---
>  drivers/bluetooth/dtl1_cs.c     |    4 +---
>  drivers/bluetooth/hci_vhci.c    |    5 +----
>  6 files changed, 6 insertions(+), 19 deletions(-)

I am totally fine with this.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


