Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <434D4765.603@imap.cc>
From: Alex Viskovatoff <viskovatoff@imap.cc>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Logitech diNovo hub not recognized
References: <434C6E2E.9070105@imap.cc> <1129097566.4922.1.camel@localhost.localdomain>
In-Reply-To: <1129097566.4922.1.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Wed, 12 Oct 2005 13:27:01 -0400

Hi Marcel,

Thanks much for your response. I compiled and installed bluez-libs-2.21 
and bluez-utils-2.21, removing the corresponding Fedora binary packages. 
Unfortunately, hid2hci and hciconfig -a produced exactly the same results.

Here is the output of /proc/bus/usb/devices, with only the Logitech 
receiver inserted:

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh=10
B:  Alloc= 42/900 us ( 5%), #Int=  4, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.13-1.1526_av0 ohci_hcd
S:  Product=OHCI Host Controller
S:  SerialNumber=0000:00:02.0
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=02 Lev=01 Prnt=01 Port=03 Cnt=01 Dev#=  2 Spd=12  MxCh= 2
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0451 ProdID=2036 Rev= 1.01
S:  Product=General Purpose USB Hub
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms

T:  Bus=02 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  4 Spd=1.5 MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046d ProdID=abd0 Rev=41.02
S:  Manufacturer=Logitech
S:  Product=Desktop USB stand
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr= 98mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms

T:  Bus=02 Lev=02 Prnt=02 Port=01 Cnt=02 Dev#=  3 Spd=1.5 MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046d ProdID=c50c Rev=22.40
S:  Manufacturer=Logitech
S:  Product=USB Receiver
C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr= 98mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
I:  If#= 1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=usbhid
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=10ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh=10
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.13-1.1526_av0 ehci_hcd
S:  Product=EHCI Host Controller
S:  SerialNumber=0000:00:02.1
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms

(When I saw "Desktop USB stand" in the list above, I removed it and 
inserted the receiver directly into a USB port, but that didn't change 
anything.)

I am mystified.

Thanks and regards,

Alex


Marcel Holtmann wrote:
> Hi Alex,
> 
> 
>>I am having trouble getting the hub from my Logitech diNovo Cordless 
>>Desktop Keyboard & Mouse recognized by the Bluetooth system. (The system 
>>is able to communicate flawlessly with a Palm Tungsten E2, over a D-Link 
>>DBT-120 USB Bluetooth dongle.) I have looked at earlier posts on this 
>>list dealing with this device, but all previous posters were able to get 
>>this hub recognized as a Bluetooth device, as far as I have been able to 
>>tell. The keyboard and mouse work fine in HID mode.
>>
>>I am running a Fedora-modified 2.6.13 kernel. My understanding is that 
>>recent kernels should have sufficient Bluetooth support, so that a Bluez 
>>patch is not necessary. (Anyway, I tried patch-2.6.13-mh1, and the 
>>resulting kernel didn't work any better.) I am using the current Fedora 
>>Core 4 version of bluez-utils, bluez-utils-2.15-7.
> 
> 
> the latest version is bluez-utils-2.21 and you might wanna try it.
> 
> 
>>Here is what the system log shows when the device is insterted:
>>
>>Oct 11 21:20:03 georg kernel: usb 2-4.2: new low speed USB device using 
>>ohci_hcd and address 39
>>Oct 11 21:20:03 georg kernel: input: USB HID v1.10 Keyboard [Logitech 
>>USB Receiver] on usb-0000:00:02.0-4.2
>>Oct 11 21:20:03 georg hal.hotplug[32675]: DEVPATH is not set (subsystem 
>>input)
>>Oct 11 21:20:03 georg kernel: input,hiddev96: USB HID v1.10 Mouse 
>>[Logitech USB Receiver] on usb-0000:00:02.0-4.2
>>Oct 11 21:20:04 georg hal.hotplug[32706]: DEVPATH is not set (subsystem 
>>input)
> 
> 
> What does /proc/bus/usb/devices shows you?
> 
> Regards
> 
> Marcel


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
