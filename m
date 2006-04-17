Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Neil Tucker <tuckernj@ntlworld.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200604170852.24545.tuckernj@ntlworld.com>
Subject: [Bluez-devel] Installing Bluetooth-alsa ./configure fails
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
Date: Mon, 17 Apr 2006 08:52:24 +0100

Hi

I'm attempting to install Bluetooth-alsa on my Fedora Core 5 machine.  I'm 
reasonablly good with using linux but have little experience compiling 
packages but have made a few custom kernels before by following the howto.

It is a 2.6.* kernel. The kernel source package is installed and linked 
to  /usr/src/linux

The ./configure fails because it can't find the bluetooth.h header files see 
below.  Here are the steps I take:

	#yum install bluez-libs bluez-pin bluez-utils bluez-hcidump bluez-utils-cup

	#yum install alsa-tools alsa-lib alsa-utils alsa-lib-devel

	#yum install automake

	$ cvs -d:pserver:anonymous@cvs.sf.net:/cvsroot/bluetooth-alsa log
	$ cvs -d:pserver:anonymous@cvs.sf.net:/cvsroot/bluetooth-alsa co btsco
	
	$ cd btsco

	$ ./bootstrap
	$ ./configure
		.
		.
		.	
		checking bluetooth/bluetooth.h usability... no
		checking bluetooth/bluetooth.h presence... no
		checking for bluetooth/bluetooth.h... no
		configure: error: Bluetooth header files not found


Can body help me please? 



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
