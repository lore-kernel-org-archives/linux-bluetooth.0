Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Suspend locks up usb
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <4308887E.9010400@gmx.de>
References: <4308887E.9010400@gmx.de>
Content-Type: text/plain
Message-Id: <1124709328.23599.24.camel@pegasus>
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
Date: Mon, 22 Aug 2005 13:15:27 +0200

Hi Christian,

> i have a little problem with bluetooth on my Thinkpad 600e. Every time
> when suspending (apm -s) while the usb bluetooth dongle is still plugged
> in (that means: the modules are still loaded), usb is no longer
> operational after the wakeup. (Un)Plugging of the dongle or any other
> device is not recognized. As the module-use-count is not zero, i cannot
> unload the modules and try it again.
> Module                  Size  Used by
> hci_usb                12360  1
> bluetooth              41700  1 hci_usb
> bcm203x                 4772  0
> firmware_class          7520  1 bcm203x
> 
> The log states:
> Aug 21 14:48:53 alpha apmd[9065]: Suspending now
> Aug 21 14:49:16 alpha hub 1-0:1.0: resubmit --> -108
> Aug 21 14:49:16 alpha hub 1-0:1.0: hub_port_status failed (err = -108)
> 
> I have the newest bluez versions in use (Gentoo):
> bluez-hciemu-1.0
> bluez-firmware-1.0
> bluez-hcidump-1.21
> bluez-libs-2.19
> bluez-utils-2.19
> Linux version 2.6.12-mh2
> 
> The problem seems to be independend of the used dongle: I tried LevelOne
> MDU-0005USB and Broadcom WTB-3020.
> 
> Unloading the modules before suspend might help - i just try not to
> forget to unplug it before suspending ;-)

I can't tell you anything about the APM. Did you tried to use ACPI? What
kernel version is this?

However to unload you module you need to do a "hciconfig hci0 down"
first. This will deactivate the interface.

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
