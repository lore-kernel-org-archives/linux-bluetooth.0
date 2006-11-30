Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Andrew Kohlsmith <akohlsmith-bluez@mixdown.ca>
To: bluez-devel@lists.sourceforge.net
Date: Thu, 30 Nov 2006 12:12:39 -0500
References: <002901c710a8$0eab3580$0100a8c0@kayleigh>
	<000701c712dc$8e44ff20$3978f052@kayleigh>
	<Pine.LNX.4.63.0611281215240.29749@redbean.intranet.gw-instruments.de>
In-Reply-To: <Pine.LNX.4.63.0611281215240.29749@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
Message-Id: <200611301212.39250.akohlsmith-bluez@mixdown.ca>
Subject: Re: [Bluez-devel] Master / Slave question
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

On Tuesday 28 November 2006 06:34, Peter Wippich wrote:
> You should try to get a newer BT 2.0 device. If I remember right the newer
> CSR devices support two slaves at a time (at least they support one slave
> and one Master connection simultaniously).

I'm confused; I thought the limitation was with early early BT 1.0B 
implementations, but now you're saying that BT2.0 even has this limit?  I 
can't, for example, have one BT dongle and work with 2, 3, 4 or more devices 
at the same time?

> For a server application like yours I would suggest to use the role
> switch feature in a more relaxed way. So, once a connection comes in try
> to do a role switch. If it succeed it is fine and you're able to accept an
> additional connection. If it fails you're out of resources but at least
> can service the current connection.

Interesting.  Always try to become a slave (i.e. let the phone be the master 
if it'll let you), correct?

Regards,
Andrew

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
