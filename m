Return-Path: <cyrus@holtmann.org>
Date: Mon, 19 Oct 2009 19:37:29 -0700 (PDT)
Message-Id: <20091019.193729.102016721.davem@davemloft.net>
To: hidave.darkstar@gmail.com
Cc: marcel@holtmann.org, oliver@hartkopp.net, netdev@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] bluetooth: static lock key fix
From: David Miller <davem@davemloft.net>
In-Reply-To: <20091019062830.GB4102@darkstar.vlan7>
References: <20091019062830.GB4102@darkstar.vlan7>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

From: Dave Young <hidave.darkstar@gmail.com>
Date: Mon, 19 Oct 2009 14:28:30 +0800

> When shutdown ppp connection, lockdep waring about non-static key
> will happen, it is caused by the lock is not initialized properly
> at that time.
> 
> Fix with tuning the lock/skb_queue_head init order
 ...
> Reported-by: Oliver Hartkopp <oliver@hartkopp.net>
> Signed-off-by: Dave Young <hidave.darkstar@gmail.com>
> Tested-by: Oliver Hartkopp <oliver@hartkopp.net>

Applied, thanks Dave.
