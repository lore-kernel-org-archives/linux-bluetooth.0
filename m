Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] libs upgrading
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <cp9uj3$es1$1@sea.gmane.org>
References: <cp9uj3$es1$1@sea.gmane.org>
Content-Type: text/plain
Message-Id: <1102610726.9988.235.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 09 Dec 2004 17:45:26 +0100

Hi,

> I've installed bluez-libs-2.12 and bluez-utils-2.12 on a kernel version 
> 2.6.9 (bluez support) (fedora core3 distribution). I have seen that the 
> installation has placed .h files at /usr/include/bluetooth, but the 
> previous installation (fedora's default) had placed the tools, and 
> libraries all arround. So now I guess I have different versions of -for 
> example- bluetooth.h file, and maybe problems?

I never heard of any weird installations of the Bluetooth library and
Fedora Core 3 should be clean, because their version should be 2.10 or
so.

> So, do I have to uninstall before upgrading ?

Maybe that is a good idea. Or you try to find an already built RPM for
bluez-{libs|utils}-2.12.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
