Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] dinovo multimedia keys
From: Marcel Holtmann <marcel@holtmann.org>
To: Oli Ellis <oliver.ellis@ntlworld.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <406005DB.2090109@ntlworld.com>
References: <406005DB.2090109@ntlworld.com>
Content-Type: text/plain
Message-Id: <1080051605.2515.20.camel@pegasus>
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
Date: Tue, 23 Mar 2004 15:20:05 +0100

Hi Oli,

> I have had a poke around utils2/hid/, specifically parser.c and 
> uinput.h. Correct me if I am wrong, but I am figuring that bthid 
> collects events from hcid and converts them into events that the kernel 
> input system can understand. (uinput.h repeats the kernel's input.h key 
> definitions.)

the hcid has nothing to do with it. It reads the HID reports from the
L2CAP control and interrupts sockets.

> My question is, are the consumer keymaps in parser.c some sort of 
> immutable bluetooth standard or just what your personal keyboard is? For 
> example, you have the following for volumes:
>         case 0xe2:    butt = KEY_MUTE;    break;
>         case 0xe9:    butt = KEY_VOLUMEUP;    break;
>         case 0xea:    butt = KEY_VOLUMEDOWN;    break;
> Whereas, my dinovo works with
>         case 0xe3:    butt = KEY_MUTE;    break;
>         case 0xea:    butt = KEY_VOLUMEUP;    break;
>         case 0xeb:    butt = KEY_VOLUMEDOWN;    break;
> What sort of keyboard do you have?
> 
> Presumably for now it would not matter if the events reported to the 
> kernel input system did not match what was written on the button labels, 
> as most people use, for example, gnome acme, which maps arbitrary keys 
> to program executions. However, the names in kernel input.h must be 
> there for a reason. I think the long term plan is for things like X to 
> read /dev/eventX, where it might become important to get it right. Does 
> this mean that bthid should become configurable?

Maybe there is a bit error somewhere in parser.c. Actually the consumer
usages are defined in the USB HID standard and should be general for all
Bluetooth keyboards.

> I am happy to help with this as best I can (patches, testing etc), but 
> my c/c++ is a little flaky...

Go ahead and try. Every patch is welcome.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
