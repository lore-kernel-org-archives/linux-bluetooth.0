Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [SOLVED] BCM2035 over UART on the E680I
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <434112CA.1010809@cyph.ath.cx>
References: <432D6F49.80304@cyph.ath.cx>  <4340F026.1040604@cyph.ath.cx>
	 <1128339367.22437.4.camel@blade>  <434112CA.1010809@cyph.ath.cx>
Content-Type: text/plain
Message-Id: <1128343349.22437.31.camel@blade>
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
Date: Mon, 03 Oct 2005 14:42:29 +0200

Hi,

> >what do think about writing all this stuff up and posting a patch for
> >the hciattach program?
> >  
> >
> That will be good, but will take some time. Right now I'm using a 
> program totally seperate from hciattach. The only common code is the 
> setting of line discipline and HCI protocol. The whole thing is also 
> tied together with a shell script that calls a binary program on the 
> phone firmware (to load the BCM2035 firmware, set BD_ADDR, and some 
> other stuff which have not been figured out.) Meanwhile if anyone is 
> interested, the binary is at:
> 
> http://cyph.ath.cx:8080/downloads/ezx-bluez-0.2.tar.bz2
> 
> Sources are at:
> 
> http://cyph.ath.cx:8080/downloads/ezx-bluez-init-0.2.tar.bz2
> 
> >I also read that Harald Welte is hacking on the A780 GSM interface. So
> >maybe at some point it is possible to fully replace their binary only
> >stuff.
> >  
> >
> That will be good. For some reason, Motorola's linux phone's have not 
> attracted as much hacker talent as other devices (e.g. OpenWRT, Ipaq, 
> Zaurus). Hopefully it will change. Meanwhile the most active english 
> forum seems to be at www.motorolafans.com.

try to write some notes about all the specific commands and ioctl stuff
you found. The ultimate goal for most people is to use the 2.6 kernel
series. For Bluetooth this is also important, because we don't support
the 2.4 kernels anymore.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
