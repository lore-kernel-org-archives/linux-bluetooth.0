Return-Path: <cyrus@holtmann.org>
Date: Sat, 31 Jul 2010 20:32:59 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: David Miller <davem@davemloft.net>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluetooth: Use list_head for hci blacklist head.
Message-ID: <20100731173259.GA1661@jh-x301>
References: <20100730.215449.226772568.davem@davemloft.net>
 <1280592977.12579.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1280592977.12579.1.camel@localhost.localdomain>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Sat, Jul 31, 2010, Marcel Holtmann wrote:
> > The bdaddr in the list root is completely unused and just
> > taking up space.
> > 
> > Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> looks fine to me.
> 
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> 
> in case you wanna add it directly to net-next-2.6 tree.
> 
> Johan, wanna do a quick test-run of this patch and add Tested-by.

Seems to work fine.

Tested-by: Johan Hedberg <johan.hedberg@nokia.com>

Johan
