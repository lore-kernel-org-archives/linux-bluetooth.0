Return-Path: <charles@bueche.ch>
Subject: Re: [Bluez-devel] Getting in touch with libs2 and utils2
From: Charles Bueche <charles@bueche.ch>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1071436139.4356.124.camel@pegasus>
References: <1071436139.4356.124.camel@pegasus>
Content-Type: text/plain
Message-Id: <1071695000.6361.13.camel@bluez.bueche.ch>
Mime-Version: 1.0
Date: Wed, 17 Dec 2003 22:03:20 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Hi,

success !!! Works much better than the hacked bthid under gentoo
2.6test11.

I followed your guide below (preceded by a cvs checkout of course). I
then ran 

- hcid (from the gentoo bluez packages)
- /opt/bluetooth/sbin/bthid --daemon
- moving mouse --> discover message in syslog : WORKS. YOUPI !!!

With the hacked bthid, I had problems in startup (mouse not always
discovered, etc).

I don't have any other Bluetooth hardware (beside my Ericsson T68 which
isn't a HID device AFAIK), so I can't make much more tests.

Apparently, gentoo creates the uinput device in /dev/misc instead of the
usual /dev/input. Thanks to Marcel for testing both in parser.c !

I will now take the time to update my Web page. THX.

Charles

On Sun, 2003-12-14 at 22:08, Marcel Holtmann wrote:
> Hi Folks,
> 
> this is a mini HOWTO to give you directions how to test the new
> generations of the Bluetooth library and utils. For most people the
> important thing will be the HID support ;)
> 
> The first thing I have to tell you is that this code is only available
> in CVS and until the new Bluetooth device manager and SDP daemon are not
> ready this will definitely not change. So you have to check out the
> libs2 and utils2 repositories by yourself. If you have done so, you can
> use this commands to install them without effecting anything of your
> current Bluetooth setups.
> 
> 	cd libs2
> 	./bootstrap
> 	./configure --prefix=/opt/bluetooth
> 	make && make install
> 
> 	cd utils2
> 	./bootstrap
> 	./configure --prefix=/opt/bluetooth --with-bluetooth=/opt/bluetooth
> 	make && make install
> 
> After that you have installed your software under /opt/bluetooth or any
> other prefix you have choosen. At the moment we don't link the library
> search path into the programs so you have to modify your /etc/ld.so.conf
> to make your library found by the loader.
> 
> 	echo /opt/bluetooth/lib >> /etc/ld.so.conf
> 	ldconfig
> 
> Feel free to play with it and send bug reports to the mailing list.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
-- 
Charles Bueche <charles@bueche.ch>
sand, snow, wave, wind and net -surfer
