Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Peter Wippich <pewi@gw-instruments.de>
To: <bluez-devel@lists.sourceforge.net>
Cc: Albert Huang <ashuang@gmail.com>
Subject: Re: [Bluez-devel] varying time to connect
In-Reply-To: <20050615113734.035D26EC@arbetsmyra.dyndns.org>
Message-ID: <Pine.LNX.4.33.0506151256440.16795-100000@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Wed, 15 Jun 2005 13:04:46 +0200 (CEST)


Hello Ronny,

the clock offset is only usefull (if at all.....) if the most recent
inquiry wasn't to long ago and both devices were not powered down (or
reset) in between. From our experiences it doesn't help alot under normal
conditions to speed up connection setup.
Of cause you can do an inquiry just before connection setup to get the
actual clock offset, but in total your connection setup time will
increase.

Further, if I remember right, most Bluetooth modules cache clock offsets
internaly.

I think these are the reasons why BlueZ doen't make use of it.

Ciao,

Peter

On Wed, 15 Jun 2005, Ronny L Nilsson wrote:

>
>
> Hi
> Following up my own question on the users-list at
> http://sourceforge.net/mailarchive/forum.php?thread_id=7501858&forum_id=1883
> I've made futher investigations regarding the optimise-connect issue.
>
> Reading the BT 1.2 spec it seems like HCI support an optional clock
> offset parameter when doing connects. However, it seems like BlueZ
> doesn't utilise it. My guess is this might be the case to the very much
> varying delays when establishing a connection with
>    hcitool cc 00:11:22:33:44:55
>
> Anyone who can confirm this? Or is there a reason why the clock offset
> parameter ain't used? I'm thinking of perhaps modifying hcid to cache
> clocks from most resent inqury to reuse them later, at a subsequent
> connect. Or is there a better way?
>
> Regards
> /Ronny Nilsson
>
>
>
>
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>

|	Peter Wippich 			Voice: +49 30 46776411		|
|	G&W Instruments GmbH		fax:   +49 30 46776419		|
|	Gustav-Meyer-Allee 25, Geb. 12	Email: pewi@gw-instruments.de	|
|	D-13355 Berlin  / Germany					|




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
