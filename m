Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] access to hci devices
From: Marcel Holtmann <marcel@holtmann.org>
To: Rob Shepherd <robshep@informatics.bangor.ac.uk>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <40F69A7B.7040802@informatics.bangor.ac.uk>
References: <40F69A7B.7040802@informatics.bangor.ac.uk>
Content-Type: text/plain
Message-Id: <1089913632.4517.34.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 15 Jul 2004 19:47:12 +0200

Hi Rob,

> I've written a basic bluetooth stack in java which is fine for my embedded java systems 
> and talks H4 to a device out of a serial port.
> 
> I would like to talk to USB devices in Linux using my stack also.
> Rather than re-invent the wheel, how hard would it be for me to fire my HCI packets at a 
> usb device using the HCI-USB / HCI_UART bluez drivers?

it is possible with BlueZ, but in that case you better should use the
BlueTTY driver you can found under the USB subsystem, when you disable
the Bluetooth subsystem in your kernel config.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
