Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Deepesh S Gujarathi <d_gujarathi@hotmail.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Law11-OE46C3SpmFZfs000064c7@hotmail.com>
References: <LAW11-OE33GHeqXipAS00015cf1@hotmail.com>
	 <1073314449.2508.1.camel@pegasus> <LAW11-OE14JMxg22Civ0001db81@hotmail.com>
	 <1073394980.2508.59.camel@pegasus>
	 <Law11-OE46C3SpmFZfs000064c7@hotmail.com>
Content-Type: text/plain
Message-Id: <1073481066.2508.150.camel@pegasus>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: blueZ-bthid testing
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
Date: Wed, 07 Jan 2004 14:11:06 +0100

Hi Deepesh,

> I created the uinput node with the following command
> # mknod /dev/input/uinput c 10 223
> and the bthid error (bthid[2040]: can't open input device: no such file or
> directory (2))  is gone, but for some reason I still cant move the cursor.
> 
> - I checked the hcidump and it shows all the data coming from the MS
> wireless mouse as I move the mouse and click
> 
> - the tail -f /var/log/messages shows the following
>     Bluetooth HID service started
>     Connected: Microsoft Five Button Mouse
>     Vendor HID usage 0xff00fe01 value 0x1
>     adequate battery
> 
> - when I do an lsmod I see
>     Module         Used by                Not     tainted
>     uinput            1
>     hci_usb          1
>     l2cap              5
>     bluez              4 [hci_usb l2cap]
>     input              0 (autoclean)    [uinput]
> 
> I doubt the following, if anyone can verify it would be great
> 
> - my XF86Config-4 file consists
> 
> Section "InputDevice"
>          Identifier "MSmouse"
>          driver "mouse"
>          option "Protocol" "IMPS/2"
>          option "Device" "/dev/input/mice"
>          option "ZAxisMapping" "4 5"
>          option "Buttons" "5"
>          option "Emulate3Buttons" "false"
> EndSection
> 
> now is the protocol IMPS/2 correct for a MS Intelliexplorer mouse (I copied
> it from the Logitech example) ?

yes it is, but maybe you need to have additional CorePointer options.
Look at some XFree config howto's.

> - also in the option "Device" the value specified as "/dev/input/mice" does
> it need to be /dev/input/uinput or something else ?

No. The mice device is correct.

> - does the mousedev module need to be loaded to make it work ?

Yes.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
