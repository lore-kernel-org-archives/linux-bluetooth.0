Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [ANN] Zaurus BlueZ kernel packages for ROM v3.10
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Stephen Crane <steve.crane@rococosoft.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1054908696.4791.157.camel@baroque.rococosoft.com>
References: <1054908696.4791.157.camel@baroque.rococosoft.com>
Content-Type: text/plain
Message-Id: <1054913828.26827.45.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: 06 Jun 2003 17:37:01 +0200

Hi Stephen,

> I don't want to preempt the official packager of the Zaurus BlueZ
> distribution but I couldn't wait for Sharp to get around to distributing
> the kernel source and needed to try out BlueZ on the new ROM.
> 
> So I built BlueZ kernel modules from a vanilla 2.4.18 plus Marcel's
> 2.4.18-mh6 patch-set and a bit of tweaking to the 2.4.6 kernel config
> file. 
> 
> >From cursory testing, they seem to be ok: bluecard_cs is successfully
> loaded and the latest versions of hciconfig, hcitool and sdptool all
> work fine. (However YMMV, no warranty, don't blame me if your Z catches
> fire, etc.)
> 
> I've uploaded them to our anonymous ftp area, along with the PCMCIA
> configuration files, bluetooth and bluetooth.conf. Get them from
> ftp://rococosoft.com/pub/zaurus
> 
> Installation:
> * unpack the tar-ball in the /home/root/modules/2.4.18-rmk7-pxa3-embedix
> directory
> * run depmod -ae
> * install bluetooth and bluetooth.conf in /etc/pcmcia
> * run /etc/rc.d/init.d/pcmcia restart

the current Zaurus packages are done by Joseph Ecker and the kernel
modules are based on the deprecated bluez-kernel-2.3 package. It seems
that it is really time to have up-to-date kernel modules for the Zaurus.
Frist I don't like Joseph last choise to put the userspace tools and the
kernel modules into one big package. I like to see the kernel stuff
seperated from the userspace tools. However I have no Zaurus, so I can't
help with that. But some time ago I put some scripts in the BlueZ kernel
CVS repository which makes it possible to compile and install the
Bluetooth modules outside the kernel source. Maybe you should take a
look at it and provide some easy to install ipk packages.

The OpenZaurus project will use a 2.4.19 in future and hopefully they
include my patch. Do anyone have details about this.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
