Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 Mar 2012 12:26:59 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	padovan@profusion.mobi
Subject: Re: [PATCH] Bluetooth: Remove redundant hdev->parent field
Message-ID: <20120316152659.GG20650@x220>
References: <1331304822-426-1-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331304822-426-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Fri, Mar 09, 2012, David Herrmann wrote:
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

Applied to my bluetooth-next tree. Thanks.

Johan
