Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Andrew Kohlsmith <akohlsmith-bluez@benshaw.com>
To: bluez-devel@lists.sourceforge.net
Date: Fri, 1 Dec 2006 10:33:06 -0500
References: <002901c710a8$0eab3580$0100a8c0@kayleigh>
	<200611301212.39250.akohlsmith-bluez@mixdown.ca>
	<Pine.LNX.4.63.0612011415350.9177@redbean.intranet.gw-instruments.de>
In-Reply-To: <Pine.LNX.4.63.0612011415350.9177@redbean.intranet.gw-instruments.de>
MIME-Version: 1.0
Message-Id: <200612011033.06755.akohlsmith-bluez@benshaw.com>
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

On Friday 01 December 2006 08:22, Peter Wippich wrote:
> I think the confusion was caused by the limitations introduced with the
> device roles: master and slave. So most modern devices support the
> following:
>
> Master with up to 7 slaves.
> Master to (6 ?) slaves and Slave to 1 Master.
> Slave to 2 Masters.

...

> No, the other way round. Always try to become a master to be able to
> service additional connections and let the phone be the slave. See above
> for the reason.

Thank you for clearing this up.  I don't pretend to "get it" just yet, but 
thank you again for taking the time to explain it.  :-)

-A.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
