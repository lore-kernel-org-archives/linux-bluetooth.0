Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <406005DB.2090109@ntlworld.com>
From: Oli Ellis <oliver.ellis@ntlworld.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] dinovo multimedia keys
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
Date: Tue, 23 Mar 2004 09:39:39 +0000

I have had a poke around utils2/hid/, specifically parser.c and 
uinput.h. Correct me if I am wrong, but I am figuring that bthid 
collects events from hcid and converts them into events that the kernel 
input system can understand. (uinput.h repeats the kernel's input.h key 
definitions.)

My question is, are the consumer keymaps in parser.c some sort of 
immutable bluetooth standard or just what your personal keyboard is? For 
example, you have the following for volumes:
        case 0xe2:    butt = KEY_MUTE;    break;
        case 0xe9:    butt = KEY_VOLUMEUP;    break;
        case 0xea:    butt = KEY_VOLUMEDOWN;    break;
Whereas, my dinovo works with
        case 0xe3:    butt = KEY_MUTE;    break;
        case 0xea:    butt = KEY_VOLUMEUP;    break;
        case 0xeb:    butt = KEY_VOLUMEDOWN;    break;
What sort of keyboard do you have?

Presumably for now it would not matter if the events reported to the 
kernel input system did not match what was written on the button labels, 
as most people use, for example, gnome acme, which maps arbitrary keys 
to program executions. However, the names in kernel input.h must be 
there for a reason. I think the long term plan is for things like X to 
read /dev/eventX, where it might become important to get it right. Does 
this mean that bthid should become configurable?

I am happy to help with this as best I can (patches, testing etc), but 
my c/c++ is a little flaky...

    Regards,
       
        Oli Ellis


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
