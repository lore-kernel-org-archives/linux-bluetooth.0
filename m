Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050204195518.97971.qmail@web26410.mail.ukl.yahoo.com>
From: benbouzid imad <imad_benb@yahoo.fr>
Subject: Re: [Bluez-users] installing bluez in an access point
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1107532179.6921.44.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Fri, 4 Feb 2005 20:55:18 +0100 (CET)

Hi dear Marcel,

exuse me but I think that there is a lot of staff here
;)
and please don't answear me in one line like you do
somtimes " see the howto about ..." ;))))

tanks a lot mister Holtmann,

 --- Marcel Holtmann <marcel@holtmann.org> a écrit : 
> Hi,
> 
>the protocol part of BlueZ are mostly done as kernel
>modules. Also the
>host transport drivers are kernel drivers. The
profiles >are implemented
>as applications (library + utils).

>Use a 2.6.10 kernel with the -mh3 patch and you have
a >very good kernel
>with the latest Bluetooth subsystem. Install
>bluez-{libs|utils}-2.15.
> 
> it is a kernel patch against the vanilla 2.6.10 to
> add the latest
> changes to the Bluetooth subsystem.

okay, if I understand , the protocols are modules and
the profiles are implemented like apllications(library
+utils)
in My DSP i have kernel moduls but not all the moduls
of 2.6 linux but just moduls that I need for my chip.
so I have to impleent moduls of blueZ and its profiles
apllication. I will impleent only profiles that I nedd
such PAN, CTP,etc... after that I build my kernel in a
target file that I send to my chip.

I would like to know wich profile are present in blueZ
because when I do
#man -k bluetooth
I see just pand and dund profile. how can I find the
help of other profil If there are implemented in
bluez.

and can you give me modules that I have to add in my
kernel,because I havn't bluetooth subsystem
implemented in my chip kernel.




> > > You must use a DNS or DNS-Proxy server for that.
> > 
> > ther is a DNS server in the network and I had it
> IP
> > adress. but how can I tell this adresse to my
> bnep0
> > interface. a PANU is connected to a NAP and when I
> > ping a google with his IP adresse it works well.
> but
> > when I ping www.google.fr  it dosen't work because
> he
> > hasn't the adress of my DNS how can I tell it to
> > bnep0? is there a bash command like 
> > >>>>>>>#ifconfig bnep0 dns 10.10.10.1
> 
> Enter it in /etc/resolv.conf.
> 

in mmy file '/etc/resolv.conf' I have the IP adresse
of my DNS.
nameserver 10.10.10.10
but it dosn't work what's the matter.
it work for my eth0 interface but not for bnep0????




> > Is there a probleme with 2035 broadcom chip? when
> I
> > use it with bluez I can't see it with a remote
> device
> > when I do an inquery or a scan.
> 
> What 2035 is this? USB or UART? If USB send in the
> content
> of /proc/bus/usb/devices.

okay , here is the file /proc/bus/usb/devices.
and the problem is ; when i plug this usb dongle in
one PC i cn't see it when i do a scan or an inquery.
and when I plug it in the second PC the problem is
diferent it doesn't want to set up it :

# hciconfig hci0 up
Can't init device hci0: Device or resource busy (16)


'/proc/bus/usb/devices'

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1
Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8
#Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.10-1.741_FC3 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:1f.4
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00
Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1
Spd=12  MxCh= 2
B:  Alloc= 64/900 us ( 7%), #Int=  4, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8
#Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.10-1.741_FC3 uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:1f.2
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00
Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 10
Spd=12  MxCh= 3
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8
#Cfgs=  1
P:  Vendor=0a5c ProdID=3535 Rev= 1.00
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=150mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00
Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms

T:  Bus=01 Lev=02 Prnt=10 Port=00 Cnt=01 Dev#= 11
Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64
#Cfgs=  1
P:  Vendor=0a5c ProdID=2009 Rev= 1.26
S:  Manufacturer=Broadcom Corp
S:  Product=Targus Bluetooth Adapter
S:  SerialNumber=710300020800
C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01
Driver=hci_usb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01
Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01
Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01
Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01
Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=  32 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  32 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01
Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01
Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff
Driver=(none)
E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00
Driver=(none)

T:  Bus=01 Lev=02 Prnt=10 Port=01 Cnt=02 Dev#= 12
Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8
#Cfgs=  1
P:  Vendor=0a5c ProdID=3502 Rev= 1.00
S:  SerialNumber=710300020800
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01
Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=10ms

T:  Bus=01 Lev=02 Prnt=10 Port=02 Cnt=03 Dev#= 13
Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8
#Cfgs=  1
P:  Vendor=0a5c ProdID=3503 Rev= 1.00
S:  SerialNumber=710300020800
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02
Driver=usbhid
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=10ms


	

	
		
Découvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vos mails ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com/


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
