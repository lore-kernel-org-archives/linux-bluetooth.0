Return-Path: <cyrus@holtmann.org>
Message-ID: <a8e1da0801011700q72f63ce1wf2a224900b459b37@mail.gmail.com>
Date: Wed, 2 Jan 2008 09:00:39 +0800
From: "Dave Young" <hidave.darkstar@gmail.com>
To: "David Miller" <davem@davemloft.net>
Subject: Re: [BUG][PATCH] bluetooth: put_device before device_del fix
Cc: marcel@holtmann.org, akpm@linux-foundation.org, greg@kroah.com,
	linux-kernel@vger.kernel.org, bluez-devel@lists.sourceforge.net
In-Reply-To: <20071229.191855.100656438.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071227052750.GA6296@darkstar.te-china.tietoenator.com>
	 <20071229.191855.100656438.davem@davemloft.net>
List-ID: <bluez-devel.lists.sourceforge.net>

On Dec 30, 2007 11:18 AM, David Miller <davem@davemloft.net> wrote:
> From: Dave Young <hidave.darkstar@gmail.com>
> Date: Thu, 27 Dec 2007 13:27:50 +0800
>
> > Because of workqueue delay, the put_device could be called before device_del, so move it to del_conn.
> >
> > Signed-off-by: Dave Young <hidave.darkstar@gmail.com>
>
> Applied, thanks Dave.
>
> Please post bluetooth patches, just like any other networking patches,
> to netdev@vger.kernel.org (CC:'ing me) so that other networking
> developers can process them during times like these when most
> maintainers aren't around and thus not looking at bug fixes like
> your's.
>

Ok, thanks for pointing out, I didn't know this before.

Regards
dave
