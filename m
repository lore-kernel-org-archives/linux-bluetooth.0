Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 31 Jul 2006 18:33:01 +0200 (CEST)
From: Peter Wippich <pewi@gw-instruments.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1154369637.4982.8.camel@aeonflux.holtmann.net>
Message-ID: <Pine.LNX.4.63.0607311820370.31025@redbean.intranet.gw-instruments.de>
References: <Pine.LNX.4.63.0607311627330.31025@redbean.intranet.gw-instruments.de>
	<1154369637.4982.8.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Refcounting problem in rfcomm
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



Hi Marcel, 

> the RFCOMM module reference counting is not funny and you can mess it up
> on so many level. So be careful with it. I haven't looked at it, but
> from past experience I know that you can easily break things. So please
> give us some more details or code to show the problem.

You're right, the ref counting is realy something I don't want to change. 
For now I've fixed it by a module_put() right after accept() returns with 
a BT_CONNECTED state. I will do some more testing and code clean up and 
then send in a patch for tty.c. Maybe I will send it in two steps because 
I also don't like some general things in tty.c. E.g. rfcomm_dlc_lock / 
unlock is used there several times but in parts of the codes which realy 
don't deal with dlcs. 
So adding a dev_lock is something which is independend of my other 
changes. 

Best regards, 

Peter 
 



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
