Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1071436139.4356.124.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Getting in touch with libs2 and utils2
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 14 Dec 2003 22:08:59 +0100

Hi Folks,

this is a mini HOWTO to give you directions how to test the new
generations of the Bluetooth library and utils. For most people the
important thing will be the HID support ;)

The first thing I have to tell you is that this code is only available
in CVS and until the new Bluetooth device manager and SDP daemon are not
ready this will definitely not change. So you have to check out the
libs2 and utils2 repositories by yourself. If you have done so, you can
use this commands to install them without effecting anything of your
current Bluetooth setups.

	cd libs2
	./bootstrap
	./configure --prefix=/opt/bluetooth
	make && make install

	cd utils2
	./bootstrap
	./configure --prefix=/opt/bluetooth --with-bluetooth=/opt/bluetooth
	make && make install

After that you have installed your software under /opt/bluetooth or any
other prefix you have choosen. At the moment we don't link the library
search path into the programs so you have to modify your /etc/ld.so.conf
to make your library found by the loader.

	echo /opt/bluetooth/lib >> /etc/ld.so.conf
	ldconfig

Feel free to play with it and send bug reports to the mailing list.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
