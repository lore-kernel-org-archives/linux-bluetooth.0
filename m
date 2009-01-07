Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 03/42] bluetooth: driver API update
From: Marcel Holtmann <marcel@holtmann.org>
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
In-Reply-To: <20090107003345.753201945@vyatta.com>
References: <20090107003316.784424362@vyatta.com>
	 <20090107003345.753201945@vyatta.com>
Content-Type: text/plain
Date: Wed, 07 Jan 2009 02:53:52 +0100
Message-Id: <1231293232.14901.13.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stephen,

> Convert to net_device_ops and use internal net_device_stats in bnep
> device. 
> 
> Note: no need for bnep_net_ioctl since if ioctl is not set, then
> dev_ifsioc handles it by returning -EOPNOTSUPP
> 
> Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>

looks good to me.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Dave, I assume you take the whole series in one go, so I leave it up to
you to apply.

Regards

Marcel


