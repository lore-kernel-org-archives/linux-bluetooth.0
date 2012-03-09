Return-Path: <cyrus@holtmann.org>
Message-ID: <1331313161.14217.17.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Remove redundant hdev->parent field
From: Marcel Holtmann <marcel@holtmann.org>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Date: Fri, 09 Mar 2012 09:12:41 -0800
In-Reply-To: <1331304822-426-1-git-send-email-dh.herrmann@googlemail.com>
References: <1331304822-426-1-git-send-email-dh.herrmann@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> We initialize the "struct device" in hci_alloc_dev() for a long time now
> so we can access hdev->dev.parent directly. Hence, we can drop the
> temporary field hdev->parent which is used in no other place than
> hci_add_sysfs().
> 
> SET_HCIDEV_DEV() is never called after registering a device by the drivers
> so we do not overwrite internal device-state. Furthermore, hdev->dev is
> initialized to 0 by kzalloc() inside hci_alloc_dev() so the default
> behavior with dev.parent = NULL is kept.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
>  drivers/bluetooth/hci_ldisc.c    |    2 +-
>  include/net/bluetooth/hci_core.h |    3 +--
>  net/bluetooth/hci_sysfs.c        |    1 -
>  3 files changed, 2 insertions(+), 4 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


