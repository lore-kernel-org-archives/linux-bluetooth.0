Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Logitech diNovo hub not recognized
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <434C6E2E.9070105@imap.cc>
References: <434C6E2E.9070105@imap.cc>
Content-Type: text/plain
Message-Id: <1129097566.4922.1.camel@localhost.localdomain>
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
Date: Wed, 12 Oct 2005 08:12:46 +0200

Hi Alex,

> I am having trouble getting the hub from my Logitech diNovo Cordless 
> Desktop Keyboard & Mouse recognized by the Bluetooth system. (The system 
> is able to communicate flawlessly with a Palm Tungsten E2, over a D-Link 
> DBT-120 USB Bluetooth dongle.) I have looked at earlier posts on this 
> list dealing with this device, but all previous posters were able to get 
> this hub recognized as a Bluetooth device, as far as I have been able to 
> tell. The keyboard and mouse work fine in HID mode.
> 
> I am running a Fedora-modified 2.6.13 kernel. My understanding is that 
> recent kernels should have sufficient Bluetooth support, so that a Bluez 
> patch is not necessary. (Anyway, I tried patch-2.6.13-mh1, and the 
> resulting kernel didn't work any better.) I am using the current Fedora 
> Core 4 version of bluez-utils, bluez-utils-2.15-7.

the latest version is bluez-utils-2.21 and you might wanna try it.

> Here is what the system log shows when the device is insterted:
> 
> Oct 11 21:20:03 georg kernel: usb 2-4.2: new low speed USB device using 
> ohci_hcd and address 39
> Oct 11 21:20:03 georg kernel: input: USB HID v1.10 Keyboard [Logitech 
> USB Receiver] on usb-0000:00:02.0-4.2
> Oct 11 21:20:03 georg hal.hotplug[32675]: DEVPATH is not set (subsystem 
> input)
> Oct 11 21:20:03 georg kernel: input,hiddev96: USB HID v1.10 Mouse 
> [Logitech USB Receiver] on usb-0000:00:02.0-4.2
> Oct 11 21:20:04 georg hal.hotplug[32706]: DEVPATH is not set (subsystem 
> input)

What does /proc/bus/usb/devices shows you?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
