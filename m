Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] MS Wireless keyboard scans remapping
From: Marcel Holtmann <marcel@holtmann.org>
To: Olivier Bornet <Olivier.Bornet@smartdata.ch>
Cc: Michal "Semler (volny.cz)" <cijoml@volny.cz>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20031028232335.GA6411@smartdata.ch>
References: <20031028084018.GA1875@smartdata.ch>
	<1067366086.24043.153.camel@pegasus>  <20031028232335.GA6411@smartdata.ch>
Content-Type: text/plain
Message-Id: <1067386611.24043.201.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 29 Oct 2003 01:16:45 +0100

Hi Olivier,

> > this is another reason, why we should reuse the USB HID parser for the
> > Bluetooth keyboards and mice ;)
> 
> I agree with you. I'm ready to test/help on this way when you will have
> someting in progress.

I am working on the design document of the HID parser userspace to
kernel interface. My userspace bthid daemon is almost ready for daily
use, but the modification of the USB HID parser will take some time. I
am thinking of copying the needed HID stuff into an extra module.

> > So you have the new diNovo. I am interested in the "hcitool info ..."
> 
> Please note the one I have is a "Beta Release". The real diNovo from the
> market may differ.

At the moment I am colleting all information of Bluetooth HID devices. I
have worked with the old Logitech Presenter the Microsoft Desktop (with
an UK layout). You can find my notes about the current devices on

	http://www.holtmann.org/linux/bluetooth/hid.html

Is there any chance that you can tell Logitech to send some demo or beta
devices to me for testing with Linux. I like to play with the devices to
see how they have done some things.

> > output from the devices and the "hciconfig -a" from the Bluetooth hub.
> 
> This is not possible at this time. The reason is that the Bluetooth hub
> is now working as a usb hub. I can't switch it to Bluetooth mode,
> because I don't have the necessary tools on Linux for this. This tool
> exist, but on another OS... And I don't use this other OS. Of course, if
> you think there is a simple way to switch from "usb hub" to "bluetooth
> hub", let me know.
> 
> At this time, I use another bluetooth dongle for connection the
> mouse/keyboard/mediapad. But I'm also really interested to have the
> Logitech bluetooth hub working as bluetooth hub.

This is part of the HID proxy stuff and we should really have a tool to
do this for Linux, too. We should sniff the URB communication of that
tool under Windows ;)

> > If you have some extra time, please compile the new libs2 from CVS and
> > run "sdptest records ..." and/or "sdptest browse ..." for me.
> 
> Maybe tomorow... Too late now.

Would be very nice, because the HID descriptor is included in the SDP
records and the libs2 generation can show you some more nice things.
Please pipe that into a file and send them as attachments.

> The hub is seen as "USB Receiver" in usbview. Here is the full
> /proc/bus/usb/devices informations (many usb devices connected, sorry):
> 
> bol@delta:~$ cat /proc/bus/usb/devices 
> T:  Bus=03 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  3 Spd=1.5 MxCh= 0
> D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=046d ProdID=c703 Rev=99.12
> S:  Manufacturer=Logitech
> S:  Product=USB Receiver
> S:  SerialNumber=0403D3
> C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr= 98mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbkbd
> E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
> I:  If#= 1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=(none)
> E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=10ms

This is the HID proxy mode ;)

> > Do this one really support HID proxy from CSR?
> 
> Hummm. Don't event know what this is. Can you explain this to me ?

The HID proxy firmware from CSR can run on a Bluetooth chip and present
them as a USB HID device or as a Bluetooth H:2 device. If you are in the
Bluetooth H:2 mode, you need a Bluetooth stack on your host and support
for the HID profile to work with your mouse or keyboard. If you are in
USB HID mode, the Bluetooth device itself will keep track of the HID
connection to your Bluetooth keyboard and mouse. And this is called HID
proxy, because in this mode it is possible to work with your Bluetooth
keyboard at BIOS stage.

The little USB stick from the Logitech Presenter for example is a USB
HID <-> Bluetooth HID converter and you can also make it work with the
Microsoft Bluetooth Mouse. But on your host side you need only support
for USB HID.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
