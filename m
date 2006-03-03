Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4407C5CF.6060208@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] SCO stuck on a Netgear WGT634U (mips)
References: <20060303011433.c498e85e.henryk@ploetzli.ch>
In-Reply-To: <20060303011433.c498e85e.henryk@ploetzli.ch>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Thu, 02 Mar 2006 21:27:59 -0700

Henryk

> I'm currently trying to get btsco working on a my Netgear WGT634U
> running OpenWgt (with a lot of custom packages) on kernel 2.6.12-rc3
> and current btsco cvs. I can't seem to get it working: Each program
> that wants to play audio simply stalls (when using aplay it stops in a
> poll(), when using oss the write blocks).

very impressive. Did you have to put a hub in place since it only has
one usb port? The hub has often been a problem on x86. If you have to
use a hub, try both 1.1 and 2.0.

I'm not certain at all on the mips side of things. I've occasionally
seen complaints about bluez problems on mips but it's almost invariably
someone using kernel 2.4.

Brad


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
