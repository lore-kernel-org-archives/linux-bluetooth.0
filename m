Return-Path: <cyrus@holtmann.org>
Message-ID: <1410244957.7977.59.camel@jrissane-mobl.ger.corp.intel.com>
Subject: Re: [PATCH 0/3] Misc Bluetooth 6lowpan fixes
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 09 Sep 2014 09:42:37 +0300
In-Reply-To: <DDA8F0E2-BC29-408F-9535-117EE75793C0@holtmann.org>
References: 
	<1410167505-30889-1-git-send-email-jukka.rissanen@linux.intel.com>
	 <DDA8F0E2-BC29-408F-9535-117EE75793C0@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On ma, 2014-09-08 at 18:28 -0700, Marcel Holtmann wrote:
> Hi Jukka,
> 
> > there are some issues in Bluetooth 6lowpan that are fixed by these
> > patches. The patches are not related and can be applied in any order.
> > 
> > The current connection timeout value was too low so the patch 1
> > will use the default connection timeout value instead.
> > 
> > I noticed that the peer IPv6 address had wrong U/L bit set in EUI-64
> > part of the address. This is now fixed by patch 2.
> > 
> > If the 6lowpan node is part of a network, then it is expected that
> > user is also able to send packets to other nodes behind the master
> > node. This was not happening as we only checked the peer IPv6 address
> > when deciding should we send the packet or not. The patch 3 now
> > checks from the routing table where to send the packet.
> > 
> > 
> > Cheers,
> > Jukka
> > 
> > 
> > Jukka Rissanen (3):
> >  Bluetooth: 6lowpan: Increase the connection timeout value
> >  Bluetooth: 6lowpan: Set the peer IPv6 address correctly
> >  Bluetooth: 6lowpan: Route packets that are not meant to peer via
> >    correct device
> > 
> > net/bluetooth/6lowpan.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++--
> > 1 file changed, 77 insertions(+), 3 deletions(-)
> 
> I am planning to tag 1/3 and 2/3 for stable. Which kernel version do they still apply to?

These are only meant for kernel that supports 6lowpan with Coc so that
would be 3.17.


Cheers,
Jukka
