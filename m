Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] 2.6.0-test9 SiW works sometimes
From: Marcel Holtmann <marcel@holtmann.org>
To: Andreas Sundstrom <sunkan@zappa.cx>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <3FA8F301.4000008@zappa.cx>
References: <3FA8D9AC.4080907@zappa.cx> <1068031366.10389.175.camel@pegasus>
	 <3FA8E805.1050909@zappa.cx> <1068034736.10389.186.camel@pegasus>
	 <3FA8F301.4000008@zappa.cx>
Content-Type: text/plain
Message-Id: <1068041709.1288.36.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 05 Nov 2003 15:15:09 +0100

Hi Andreas,

> >>This is what I'v run:
> >>
> >>//inserts the device into the USB hub
> >># echo blue_on:1 > /proc/acpi/toshiba/bluetooth
> > 
> > 
> > Where is this documented?
> Apparently many notebooks (atleast many toshiba's) have devices that can 
> be plugged in and out via software. The USB BT dongle in my notebook is 
> one of these.. There's a button on the side of the notebook that can be 
> used to be sure that the device is off (like in an airplane).
> I found a patch for linux/driver/acpi/toshiba_acpi.c on this site:
> 
> http://nicolas.bettenburg.free.fr/linux/#c4
> 
> I hade to fiddle alot with it to make it work with 2.4.22 (I guess he 
> has not written it against a recent kernel). I came up with a patch that 
> worked ok with 2.4.22, and to my surprice it worked fine with 2.6.0 too.
> 
> My guess is that the ACPI stuff has been backported into 2.4.22 and 
> that's why it's almost the same.. I put the patch I use here so you can 
> look if you want: ftp://zappa.cx/pub/echinacea/toshiba_bluetooth.patch
> It currently doesn't apply cleanly on 2.6.0-test9 but not important 
> stuff just comments doesn't apply.

this should be included in the mainstream kernel source, but the code
must be a little bit cleaned up. I will check this later and send you a
patch for testing. After that I'll forward it to the maintainer.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
