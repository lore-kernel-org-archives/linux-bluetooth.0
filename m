Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] USB bluetooth dongle support
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <4351C1A5.4090204@felton.felton.ca.us>
References: <4351C1A5.4090204@felton.felton.ca.us>
Content-Type: text/plain
Message-Id: <1129469810.24835.12.camel@blade>
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
Date: Sun, 16 Oct 2005 15:36:50 +0200

Hi Bob,

> It would appear as though no support for my Zeevo, Inc.
> USB bluetooth dongle exists for Linux.
> 
> dmesg shows:
> ALSA sound/usb/usbaudio.c:1143: 9:1:1: cannot get freq at ep 0x5
> ALSA sound/usb/usbaudio.c:1143: 9:1:2: cannot get freq at ep 0x5
> input: USB HID v1.10 Device [Zeevo Bluetooth Audio Dongle] on 
> usb-0000:00:1d.7-2
> 
> When I plug in.
> 
> lsusb shows:
> ID 0b7a:0100 Zeevo, Inc.
> AudioDongle: uniqueID: tCIZ.IGVSOCvzpxA
> 
> When I click in the lower right hand corner in the KDE panel on the 
> bluetooth
> ICON it states "No working Bluetooth adapter found.  Only local services 
> will
> be displayed.".
> 
> Please advise if I have any hope of getting this supported or if it is 
> best I purchase
> a supported dongle.   Apparently Zeevo has been bought out by Broadcom.

this looks like an A2DP Source Dongle and not a HCI dongle.

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
