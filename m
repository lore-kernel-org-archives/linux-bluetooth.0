Return-Path: <cyrus@holtmann.org>
Message-ID: <1357615780.1806.26.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Fix incorrect strncpy() in hidp_setup_hid()
From: Marcel Holtmann <marcel@holtmann.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 07 Jan 2013 19:29:40 -0800
In-Reply-To: <1357511333-5276-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357511333-5276-1-git-send-email-anderson.lizardo@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> The length parameter should be sizeof(req->name) - 1 because there is no
> guarantee that string provided by userspace will contain the trailing
> '\0'.
> 
> Can be easily reproduced by manually setting req->name to 128 non-zero
> bytes prior to ioctl(HIDPCONNADD) and checking the device name setup on
> input subsystem:
> 
> $ cat /sys/devices/pnp0/00\:04/tty/ttyS0/hci0/hci0\:1/input8/name
> AAAAAA[...]AAAAAAAAf0:af:f0:af:f0:af
> 
> ("f0:af:f0:af:f0:af" is the device bluetooth address, taken from "phys"
> field in struct hid_device due to overflow.)
> 
> Signed-off-by: Anderson Lizardo <anderson.lizardo@openbossa.org>
> ---
>  net/bluetooth/hidp/core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

this is a good catch. And this should also go to -stable and the current
kernels right away.

It is actually a security issue since it leaks kernel memory to
userspace.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


