Return-Path: <cyrus@holtmann.org>
Date: Sat, 29 Dec 2007 19:18:55 -0800 (PST)
Message-Id: <20071229.191855.100656438.davem@davemloft.net>
To: hidave.darkstar@gmail.com
Cc: marcel@holtmann.org, akpm@linux-foundation.org, greg@kroah.com,
 linux-kernel@vger.kernel.org, bluez-devel@lists.sourceforge.net
Subject: Re: [BUG][PATCH] bluetooth: put_device before device_del fix
From: David Miller <davem@davemloft.net>
In-Reply-To: <20071227052750.GA6296@darkstar.te-china.tietoenator.com>
References: <20071227052750.GA6296@darkstar.te-china.tietoenator.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

From: Dave Young <hidave.darkstar@gmail.com>
Date: Thu, 27 Dec 2007 13:27:50 +0800

> Because of workqueue delay, the put_device could be called before device_del, so move it to del_conn.
> 
> Signed-off-by: Dave Young <hidave.darkstar@gmail.com> 

Applied, thanks Dave.

Please post bluetooth patches, just like any other networking patches,
to netdev@vger.kernel.org (CC:'ing me) so that other networking
developers can process them during times like these when most
maintainers aren't around and thus not looking at bug fixes like
your's.

Thanks.
