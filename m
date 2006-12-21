Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <458A2914.1060800@idlum.be>
References: <45896C24.2070106@pracucci.com>
	<1166631806.17802.10.camel@violet>  <458A2914.1060800@idlum.be>
Date: Thu, 21 Dec 2006 13:53:18 +0100
Message-Id: <1166705598.9307.7.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Inquiry cache management (clock offset)
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

Hi Pierre-Yves,

> > the main disadvantage is that it gives you nothing. You can't move the
> > clock offset around from adapter A to adapter B. As the word says, it is
> > a clock _offset_ and this means it depends on the local clock on the
> > chip. So a received clock offset on adapter A is invalid on adapter B
> > and it might happen that the connection establishment takes longer than
> > if you would have used no clock offset at all.
> 
> And what about computing the clock offset between local adapters, and 
> then based on this information compute the proper clock offset with the 
> remote device for the adapter actually used to connect it?

with Bluetooth 1.2 you can even read the local clock and do your
computation from there. However I doubt that this will give any real
improvement. Feel free to prove me otherwise, but please make sure that
your testing is done with real life scenarios. Meaning moving targets.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
