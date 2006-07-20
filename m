Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: "Collin R. Mulliner" <collin@betaversion.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <4688DDA1-7466-48A2-A968-1636CE3E4C50@infitsrl.com>
References: <4688DDA1-7466-48A2-A968-1636CE3E4C50@infitsrl.com>
Date: Fri, 21 Jul 2006 00:02:01 +0200
Message-Id: <1153432921.23838.27.camel@panic>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Many simultaneous BtOBEX_TransportConnect ?
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

I think this is a OpenOBEX limitation, the workaround is to create the
rfcomm connections "by hand" and then use the OpenOBEX file descriptor
interface.

...
context.libObex = OBEX_Init(OBEX_TRANS_FD, eventhandler, 0);
...
FdOBEX_TransportSetup(...)
...

Collin

On Thu, 2006-07-20 at 22:36 +0200, Fabrizio Guglielmino wrote:
> I'm facing a problem with bluez and I can't found the solution.
> Situation is:
>       bluez-libs-3.1
>       openobex-1.2
>       linux kernel 2.6.12
> 
> I'm simply trying to send a file (vcard) to two cellular phones
> simultaneous using object push profile.
> I've writed a little C program based on obex_test that take btaddr,
> channel and filename and push the last.
> If I send to only one device all it'ok, but if I try to send
> simultaneous launcing two commands in cascade the first go ok but the
> second
> always fail in BtOBEX_TransportConnect of openobex ibrary.
> 
> Testing two rfcomm connection to same devices all works....
> 
> Is this a bluez (or openopex) limitation?
> 
> I've implemented the same on windows xp with microsoft stack without  
> problems and
> I'm testing the solutions with the same bluetooth usd dongles.
> 
> 
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
--
Collin R. Mulliner <collin@betaversion.net>
BETAVERSiON Systems [www.betaversion.net]
info/pgp: finger collin@betaversion.net
He is dead Jim! --Dr. McCoy


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
