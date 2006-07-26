Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Felix Homann <fexpop@onlinehome.de>
To: Filippo Giunchedi <filippo@esaurito.net>
Date: Wed, 26 Jul 2006 12:07:41 +0200
References: <20060725165124.GB14679@esaurito.net>
	<1153848241.31069.31.camel@localhost>
	<20060726094906.GB6549@esaurito.net>
In-Reply-To: <20060726094906.GB6549@esaurito.net>
MIME-Version: 1.0
Message-Id: <200607261207.41398.fexpop@onlinehome.de>
Cc: Kay Sievers <kay.sievers@vrfy.org>,
        BlueZ development <bluez-devel@lists.sourceforge.net>,
        bluez-devel@lists.sf.net
Subject: Re: [Bluez-devel] bluez udev rules for pcmcia devices
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Wednesday 26 July 2006 11:49, Filippo Giunchedi wrote:
> > >From a programming perspective, the TYPEID should be moved into
> >
> > start_serial, because it is its only user.
>
> I'm failing to understand this :(

It's been related to my quick-hacked script where I had TYPEID (~MANF_CARD_ID) 
set outside of start_serial() . You already fixed it.

Kind regards,

Felix

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
