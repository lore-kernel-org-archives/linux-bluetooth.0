Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: diNovo fancy bits
From: Marcel Holtmann <marcel@holtmann.org>
To: Oli Ellis <oliver.ellis@ntlworld.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40D77DC8.5030200@ntlworld.com>
References: <40D77DC8.5030200@ntlworld.com>
Content-Type: text/plain
Message-Id: <1087897766.4328.97.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 22 Jun 2004 11:49:26 +0200

Hi Oli,

> Ref the multimedia keys on the diNovo, they seem to be misinterpreted by 
> the hid de-scrambler in the bluetooth libraries, BUT apparently the hid 
> de-scrambler is a carbon copy of that used in the usb bit of the kernel. 
> So, four possibilities -
> 1) Logitech have blundered with their HID implementation and the 
> keyboard simply reports the wrong keypresses, and this is patched over 
> in the windows driver.

I don't know anything about Windows HID.

> 2) Key data is getting corrupted by the bluetooth stack (seems unlikely)

The Bluetooth stack is working fine.

> 3) The hid de-scrambler is in fact not a correct copy of the usb one (I 
> have checked this briefly and it seems to be ok?)

It is a copy of the USB HID without the USB and the hiddev stuff.

> 4) The kernel usb hid de-scrambler is not correct.

Actually I think it is this or Logitech simply made a mistake in their
HID report descriptor.

> The best way to test this is - see what keypress events are reported 
> with the keyboard under normal, backwards compatibility mode (ie usb, 
> but not bluetooth), and see what keypresses are reported with other (eg. 
> microsoft) keyboards. Anyone have any idea how to get this info? 
> Unfortunately, I can't help much here as I have just 'upgraded' from 
> gentoo to suse 9.1 and crazy stuff happens with the device even plugged 
> into the usb. I have not tried bluetooth mode yet. (keypresses send the 
> mouse jumping all over the place and moving icons...)

Using the HID proxy feature of the Bluetooth hub might not help if it
switches it into boot protocol mode. Read the HID report descriptors
from the hub and from the Bluetooth SDP database and compare them.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
