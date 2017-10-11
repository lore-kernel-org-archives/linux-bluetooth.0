Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH 1/2] Bluetooth: hci_bcm: fix build error without CONFIG_PM
To: Arnd Bergmann <arnd@arndb.de>, Marcel Holtmann <marcel@holtmann.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>
Cc: Loic Poulain <loic.poulain@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20171011134640.3152236-1-arnd@arndb.de>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <e76549b8-f4eb-f7a9-6614-23fb28e6f44a@redhat.com>
Date: Wed, 11 Oct 2017 16:29:13 +0200
MIME-Version: 1.0
In-Reply-To: <20171011134640.3152236-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 11-10-17 15:46, Arnd Bergmann wrote:
> This was introduced by the rework adding PM support:
> 
> drivers/bluetooth/hci_bcm.c: In function 'bcm_device_exists':
> drivers/bluetooth/hci_bcm.c:156:22: error: 'struct bcm_device' has no member named 'hu'
>    if (device && device->hu && device->hu->serdev)
>                        ^~
> 
> The pointer is not available otherwise, so I'm enclosing
> all references in an #ifdef here.
> 
> Fixes: 8a92056837fd ("Bluetooth: hci_bcm: Add (runtime)pm support to the serdev driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I had this on my TODO after the buildbot errors, thank you for fixing
this.

The fix looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>   drivers/bluetooth/hci_bcm.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index ab1455e63b92..089bd0473451 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -152,9 +152,11 @@ static bool bcm_device_exists(struct bcm_device *device)
>   {
>   	struct list_head *p;
>   
> +#ifdef CONFIG_PM
>   	/* Devices using serdev always exist */
>   	if (device && device->hu && device->hu->serdev)
>   		return true;
> +#endif
>   
>   	list_for_each(p, &bcm_device_list) {
>   		struct bcm_device *dev = list_entry(p, struct bcm_device, list);
> @@ -965,7 +967,9 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
>   		return -ENOMEM;
>   
>   	bcmdev->dev = &serdev->dev;
> +#ifdef CONFIG_PM
>   	bcmdev->hu = &bcmdev->serdev_hu;
> +#endif
>   	bcmdev->serdev_hu.serdev = serdev;
>   	serdev_device_set_drvdata(serdev, bcmdev);
>   
> 
