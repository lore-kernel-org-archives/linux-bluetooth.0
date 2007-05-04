Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200705010532.30291.daff@dword.org>
References: <200705010532.30291.daff@dword.org>
Date: Fri, 04 May 2007 08:43:26 +0200
Message-Id: <1178261006.25425.29.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] K800i sends correct usage IDs,
	get	mis-interpreted by Xorg
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Andreas,

> this is my first post here and I am not sure whether I've come to the 
> right forum for my problem. I'll try nonetheless.
> 
> Using bluez-* 3.9 on Kubuntu 7.04 (Feisty), with Xorg 7.2.
> 
> I use my Sony Ericsson K800i to remote control my desktop and it works 
> almost fine. I defined an HID profile using the USB HID usage tables 
> [1] and the Bluetooth HID remote control developer information [2] by 
> Sony Ericsson.
> 
> The problem is that some usage IDs don't get interpreted correctly by 
> Xorg. An example:
> 
> <KEY_VOL_UP>
>   <ACTION>
>     <KEYBOARD MODIFIERS = "00" USAGEID = "4E" />  <!-- Page Down -->
>   </ACTION>
> </KEY_VOL_UP>
> 
> This sets the phone's volume up key to send the usage ID 4E (unmodified) 
> which is the keyboard equivalent of Page Down according to the HID 
> specs.
> 
> However, testing this with xev yields the following:
> 
> KeyPress event, serial 31, synthetic NO, window 0x1800001,
>     root 0x1a5, subw 0x0, time 3560039, (107,75), root:(1705,822),
>     state 0x0, keycode 117 (keysym 0xffaf, KP_Divide), same_screen YES,
>     XKeysymToKeycode returns keycode: 112
>     XLookupString gives 1 bytes: (2f) "/"
>     XmbLookupString gives 1 bytes: (2f) "/"
>     XFilterEvent returns: False
> 
> Apparently Xorg interprets that usage ID as KP_Divide ("/") or keycode 
> 117, which it definitely is not.
> 
> This is just a real example, other usage IDs are also problematic. 
> 
> Also of note should be that I set up an Xorg input device for the phone. 
> Without it no mouse events would ever occur:
> 
> Section "InputDevice"
>     Identifier              "k800i"
>     Driver                  "evdev"
>     Option  "Protocol"      "Auto"
>     Option "Name"           "Sony Ericsson Remote Control of PC 
> applications and other devices"
>     Option  "Buttons"       "3"
>     Option  "SendCoreEvents"
> EndSection
> 
> Before getting into any more detail, could this a problem of Xorg or is 
> this the doing of bluez? 

this is not a BlueZ problem. It is either Xorg or the HID<->Input
translation in the kernel.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
