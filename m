Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1073660187.2532.2.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Bluetooth kernel patch for 2.6.1
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
Date: Fri, 09 Jan 2004 15:56:28 +0100

Hi Folks,

the first Bluetooth kernel patch for 2.6.1 is now available [1] and it
is only a resync with the previous 2.6.0-mh2 patch. Here is the full
changelog:

  o Convert interrupt handlers to use irqreturn_t
  o Support for Broadcom Blutonium
  o Improve blacklist handling
  o Add missing maintainer entries for the Bluetooth subsystem
  o Add CAPI message transport protocol support
  o Update the Kconfig entry for the BlueFRITZ! USB driver
  o Add module aliases for the Bluetooth protocols
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

[1] http://www.holtmann.org/linux/kernel/patch-2.6.1-mh1.gz




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
