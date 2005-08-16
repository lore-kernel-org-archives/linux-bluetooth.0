Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Broadcom BCM2035 Firmware
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <dc98d8d905081408412d2c43b5@mail.gmail.com>
References: <dc98d8d905081408412d2c43b5@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1124206678.7466.21.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 16 Aug 2005 17:37:58 +0200

Hi Paul,

> I have a laptop with a built in BCM2035 USB bluetooth module
> ("plugged" and "unplugged" by way of a "wireless" button). Downloaded
> and installed the latest bluez packages from source, including the
> firmware one. I notice that it only has BCM2033 firmware, and I'm
> fairly sure this is being loaded when I modprobe the bcm203x kernel
> module, however utilities all report BD Address as 00:00:00:00:00:00
> regardless of whether the interface is up or down. Aside from this, it
> all works ok, except that I have to specify the device (hci0) with
> each tool command. I assume this is because they "use the first
> available hci device by default", but because mine has a null address,
> it isn't recognised.
> 
> Therefore, I have 2 questions:
> 
> Is there anywhere I can get 2035 firmware from? Can it be extracted
> from the windows drivers, and if so, how?

show us the content of /proc/bus/usb/devices after you activated your
Bluetooth dongle. What happens if you load the hci_usb.ko module with
the "reset=1" kernel parameter?

Regards

Marcel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
