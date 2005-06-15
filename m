Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ronny L Nilsson <bb@arbetsmyra.dyndns.org>
To: bluez-devel@lists.sourceforge.net, Peter Wippich <pewi@gw-instruments.de>
Subject: Re: [Bluez-devel] varying time to connect
Cc: Albert Huang <ashuang@gmail.com>
References: <Pine.LNX.4.33.0506151256440.16795-100000@redbean.intranet.gw-instruments.de>
In-Reply-To: <Pine.LNX.4.33.0506151256440.16795-100000@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
Message-Id: <20050615131507.384A0810@arbetsmyra.dyndns.org>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 15 Jun 2005 15:14:08 +0200


> the clock offset is only usefull (if at all.....) if the most recent
> inquiry wasn't to long ago and both devices were not powered down (or
> reset) in between. From our experiences it doesn't help alot under
> normal conditions to speed up connection setup.

Hi
Ok. If one is sure of none of the devices has reset, for aprox how long 
is a clock offset cache usable? I suspect they drift somewhat. 
Seconds, minutes or hours?

/Ronny



-----
> Of cause you can do an inquiry just before connection setup to get
> the actual clock offset, but in total your connection setup time will
> increase.
> Further, if I remember right, most Bluetooth modules cache clock
> offsets internaly.
> I think these are the reasons why BlueZ doen't make use of it.
> Peter


-------
> On Wed, 15 Jun 2005, Ronny L Nilsson wrote:
> > http://sourceforge.net/mailarchive/forum.php?thread_id=7501858&foru
> > Anyone who can confirm this? Or is there a reason why the clock
> > offset parameter ain't used? I'm thinking of perhaps modifying hcid
> > to cache clocks from most resent inqury to reuse them later, at a
> > subsequent connect. Or is there a better way?
> > /Ronny Nilsson



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
