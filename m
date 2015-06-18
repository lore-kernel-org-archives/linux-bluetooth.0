Return-Path: <cyrus@holtmann.org>
Message-ID: <1434609317.2794.18.camel@linux.intel.com>
Subject: Re: [PATCH 3/5] Bluetooth: 6lowpan: Move netdev sysfs device
 reference
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
Cc: lukasz.duda@nordicsemi.no, linux-bluetooth@vger.kernel.org
Date: Thu, 18 Jun 2015 09:35:17 +0300
In-Reply-To: <1434551547-11210-4-git-send-email-glenn.ruben.bakke@nordicsemi.no>
References: <1434551547-11210-1-git-send-email-glenn.ruben.bakke@nordicsemi.no>
	 <1434551547-11210-4-git-send-email-glenn.ruben.bakke@nordicsemi.no>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Glenn,

On ke, 2015-06-17 at 07:32 -0700, Glenn Ruben Bakke wrote:
> This patch moves the sysfs device used by the netdev from the device of
> the first connected peer to the hci sysfs device. Using the sysfs device
> of hci instead of the first connected device fixes this issue such that
> the sysfs group of tx-0 and bt0 kobject are still present after the last
> peer has been deleted and all sysfs entries can be removed.
> 
> Signed-off-by: Lukasz Duda <lukasz.duda@nordicsemi.no>
> Signed-off-by: Glenn Ruben Bakke <glenn.ruben.bakke@nordicsemi.no>
> ---
>  net/bluetooth/6lowpan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index 7ee591a..bc105a9 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -856,7 +856,7 @@ static int setup_netdev(struct l2cap_chan *chan, struct lowpan_dev **dev)
>  	set_dev_addr(netdev, &chan->src, chan->src_type);
>  
>  	netdev->netdev_ops = &netdev_ops;
> -	SET_NETDEV_DEV(netdev, &chan->conn->hcon->dev);
> +	SET_NETDEV_DEV(netdev, &chan->conn->hcon->hdev->dev);
>  	SET_NETDEV_DEVTYPE(netdev, &bt_type);
>  
>  	err = register_netdev(netdev);

you had a very nice analysis of the patches in the cover letter.

I have seen the sysfs_remove_group error myself but did never had time
to investigate this fully. Thanks for your hard efforts to nail this
bug!

Cheers,
Jukka


