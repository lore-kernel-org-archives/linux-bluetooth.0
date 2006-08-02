Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Milind Dumbare <milind@linsyssoft.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1154525531.3905.45.camel@aeonflux.holtmann.net>
References: <1154441823.5306.13.camel@Shadowfox.linsyssoft.com>
	<d23110170608011015h3bef584cn65a7d24fc73ec931@mail.gmail.com>
	<1154499074.2302.2.camel@Shadowfox.linsyssoft.com>
	<1154514862.3905.40.camel@aeonflux.holtmann.net>
	<1154508670.2302.10.camel@Shadowfox.linsyssoft.com>
	<1154525531.3905.45.camel@aeonflux.holtmann.net>
Date: Wed, 02 Aug 2006 17:38:22 +0530
Message-Id: <1154520502.2302.17.camel@shadowfox.linsyssoft.com>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Reboot notifier
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

On Wed, 2006-08-02 at 15:32 +0200, Marcel Holtmann wrote:
> Hi Milind,
> 
> > The first most useful think is doing module cleanup while rebooting.
> > About other things, you will know them more deeply. May be like keeping
> > informing user level utilities to do some interesting stuff like.
> > Keeping connection settings live post reboot or other.
> 
> there is no need for a module cleanup. And unloading of kernel modules
> still has to be considered as a race condition.
> 
> Once you reset the USB bus for example all USB Bluetooth dongles will
> disconnect and be powered off and all connections will go away anyway.
> There is no real chance to keep connections over reboot.
> So I don't see any need for this, but feel free to send in patches for
> it and convince me otherwise.
> 
I will definitly. Give me some time. :-)
> Regards
> 
> Marcel
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
> 
> 
-- 
-Milind
"There is no place like 127.0.0.1"


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
