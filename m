Return-Path: <cyrus@holtmann.org>
Date: Wed, 07 Jan 2009 17:23:28 -0800 (PST)
Message-Id: <20090107.172328.193611931.davem@davemloft.net>
To: marcel@holtmann.org
Cc: shemminger@vyatta.com, netdev@vger.kernel.org,
 linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 03/42] bluetooth: driver API update
From: David Miller <davem@davemloft.net>
In-Reply-To: <1231293232.14901.13.camel@californication>
References: <20090107003316.784424362@vyatta.com>
	<20090107003345.753201945@vyatta.com>
	<1231293232.14901.13.camel@californication>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcel Holtmann <marcel@holtmann.org>
Date: Wed, 07 Jan 2009 02:53:52 +0100

> > Convert to net_device_ops and use internal net_device_stats in bnep
> > device. 
> > 
> > Note: no need for bnep_net_ioctl since if ioctl is not set, then
> > dev_ifsioc handles it by returning -EOPNOTSUPP
> > 
> > Signed-off-by: Stephen Hemminger <shemminger@vyatta.com>
> 
> looks good to me.
> 
> Acked-by: Marcel Holtmann <marcel@holtmann.org>

Applied.

> Dave, I assume you take the whole series in one go, so I leave it up to
> you to apply.

Yep, thanks.
