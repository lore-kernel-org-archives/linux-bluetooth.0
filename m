Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Deepesh S Gujarathi <d_gujarathi@hotmail.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <LAW11-OE33GHeqXipAS00015cf1@hotmail.com>
References: <LAW11-OE33GHeqXipAS00015cf1@hotmail.com>
Content-Type: text/plain
Message-Id: <1073314449.2508.1.camel@pegasus>
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
Date: Mon, 05 Jan 2004 15:54:09 +0100

Hi,

> I'm implementing the firmware for a bluetooth HID mouse using an
> Ericsson module and using the bluez stack to test my implementation. 
> For a start I was trying to make the MS Intelliexplorer mouse work
> with Marcels bthid program, but somehow havent been able to see the
> cursor move, heres what all I did
>  
> - downloaded a crisp new linux2.4.22 kernel from kernel.org
>  
> - patched the kenel with patch-2.4.22-mh2.gz 
>  
> - recompiled the kenel with Input Core support (uinput.o) + BlueZ
> modules + usb support (usb_ohci) modules etc. 
>  
> - reboot with linux2.4.22-mh2 kernel
>  
> - downloaded the latest rpms and did a rpm update to bluez.
>  
> - downloaded and compiled the libs2 and utils2 as per Marcel's
> instructions (using --prefix /opt/bluetooth etc.) from cvs
>  
> - added the following to the XFree86config-4 file
>  
> Section "InputDevice"
>         Identifier "MSmouse"
>         driver "mouse"
>         option "Protocol" "IMPS/2"
>         option "Device" "/dev/input/mice"
>         option "ZAxisMapping" "4 5"
>         option "Buttons" "5"
>         option "Emulate3Buttons" "false"
> EndSection
>     
> and added 
> InputDevice  "MSmouse" "SendCoreEvents" to the ServerLayout section
>  
> - the following modules are present (lsmod)
>  
> l2cap.o
> bluez.o
> input.o
> uinput.o
> usb_uhci.o
> hci_usb.o
> usb_core.o
>  
> - run hcid daemon
>  
> - run bthid daemon 
>  
> -run /opt/bluetooth/sbin/bthid -c 00:50:F2:E5:89:15 (here the
> /var/log/messages shows the following )
>  
> bthid[2040]: cant open input device: no such file or directory (2)
> bthid[2040]: connected: Microsoft Five Button Mouse 
>  
> when I do a hcitool scan, the local device detects the MS
> IntelliExplorer mouse. but nothing happens further.
>  
> am I missing something relevant ?

what about creating the /dev/input/uinput device node?

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
