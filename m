Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Logitech diNovo hub not recognized?
From: Marcel Holtmann <marcel@holtmann.org>
To: Holger Frydrych <h.frydrych@gmx.de>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40EF0F10.8050302@gmx.de>
References: <40EEC9CD.8030003@gmx.de> <1089396942.22528.10.camel@pegasus>
	 <40EF0F10.8050302@gmx.de>
Content-Type: text/plain
Message-Id: <1089413516.13519.16.camel@pegasus>
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
Date: Sat, 10 Jul 2004 00:51:56 +0200

Hi Holger,

> > use 2.6.7-mh2 and bluez-libs-2.8 and bluez-utils-2.8 to get this really
> > working. To use hid2hci you must enable CONFIG_USB_HIDDEV in your kernel
> > config and it is a good idea to use udev for creation of the hiddev
> > device nodes.
> 
> well, I had 2.8 libs and tools already installed and HIDDEV enabled. So 
> I just tried the mh2 patch, but nothing's changed so far. Maybe the hub 
> even is in bluetooth mode because the MediaPad automatically connected 
> during boot (which it has never done before), but apart from that, 
> hcitool still complains about non-existing devices, so this can't be 
> right, I guess.

did hid2hci showed any error messages. Is there anything in the logfiles
or visible through dmesg. What kind of machine do you use? Do you have
the hiddevX devices nodes?

> T:  Bus=01 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  3 Spd=1.5 MxCh= 0
> D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=046d ProdID=c704 Rev=24.04
> S:  Manufacturer=Logitech
> S:  Product=USB Receiver
> S:  SerialNumber=0DC4DF
> C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr= 98mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
> E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
> I:  If#= 1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=usbhid
> E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=10ms

This is fine. We actually support this hub.

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
