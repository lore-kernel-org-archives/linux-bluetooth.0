Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1072139164.2876.39.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Bluetooth kernel patch for 2.6.0
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
Date: Tue, 23 Dec 2003 01:26:05 +0100

Hi Folks,

the first Bluetooth kernel patch for 2.6.0 is now available [1] and it
contains a bunch of updates to sync up with the Bluetooth subsystem of
the Linux 2.6 series. Here is the changelog:

  o Add missing maintainer entries for the Bluetooth subsystem
  o Add CAPI message transport protocol support
  o Update the Kconfig entry for the BlueFRITZ! USB driver
  o Add module aliases for the Bluetooth protocols
  o Correct the module alias for the network family
  o Support for AVM BlueFRITZ! USB
  o Remove USB zero packet option
  o Support inquiry results with RSSI
  o Update HCI security filter
  o Add support for an old ALPS module
  o Add support for the Digianswer USB devices
  o Always use two ISOC URB's
  o Disable credit based flow control by default

Regards

Marcel

[1] http://www.holtmann.org/linux/kernel/patch-2.6.0-mh1.gz




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
