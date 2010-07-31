Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] bluetooth: Use list_head for hci blacklist head.
From: Marcel Holtmann <marcel@holtmann.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: David Miller <davem@davemloft.net>, linux-bluetooth@vger.kernel.org
In-Reply-To: <20100731173259.GA1661@jh-x301>
References: <20100730.215449.226772568.davem@davemloft.net>
	 <1280592977.12579.1.camel@localhost.localdomain>
	 <20100731173259.GA1661@jh-x301>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 31 Jul 2010 16:08:34 -0700
Message-ID: <1280617714.12579.2.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> > > The bdaddr in the list root is completely unused and just
> > > taking up space.
> > > 
> > > Signed-off-by: David S. Miller <davem@davemloft.net>
> > 
> > looks fine to me.
> > 
> > Acked-by: Marcel Holtmann <marcel@holtmann.org>
> > 
> > in case you wanna add it directly to net-next-2.6 tree.
> > 
> > Johan, wanna do a quick test-run of this patch and add Tested-by.
> 
> Seems to work fine.
> 
> Tested-by: Johan Hedberg <johan.hedberg@nokia.com>

thanks.

Dave, I have put the patch into my tree now and will send it to John
shortly. I think it is better that way for the Bluetooth 3.0 guys that
are rebasing against wireless-next-2.6.

Regards

Marcel


