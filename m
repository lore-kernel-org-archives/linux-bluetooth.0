Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 Jan 2013 17:40:30 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix incorrect strncpy() in hidp_setup_hid()
Message-ID: <20130109194030.GA30225@joana>
References: <1357511333-5276-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1357511333-5276-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

* Anderson Lizardo <anderson.lizardo@openbossa.org> [2013-01-06 18:28:53 -0400]:

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

Patch has been applied to bluetooth.git. Thanks. I'm also sending it to
stable.

	Gustavo
