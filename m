Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4263F8DF.1040400@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] error on connect
References: <425FFF54.6000701@gmx.ch> <1113607202.16433.42.camel@pegasus>	 <42616275.1090103@gmx.ch> <1113682195.18450.0.camel@pegasus>	 <4261BCFB.8040204@gmx.ch> <1113702363.18450.26.camel@pegasus> <426237CF.5060604@gmx.ch>
In-Reply-To: <426237CF.5060604@gmx.ch>
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
Date: Mon, 18 Apr 2005 20:13:51 +0200

Hello Marcel

have you already had luck regarding this topic?


regards
Marco


Marco Trudel wrote:
> Marcel Holtmann wrote:
> 
>> Hi Marco,
>>
>>
>>>>> Yes. Broadcom dongles cause the problem.
>>>>> Actually it's only the slave (listening dongle).
>>>>
>>>>
>>>> what kind of Broadcom dongle is this?
>>>
>>>
>>> I sent you pretty exactly one week ago the data from two broadcom 1.2 
>>> dongles (ednet and acer). Inform me if you need the informations again.
>>> both dongles now make the problem...
>>
>>
>>
>> include them again, because my mailboxes are a little bit bigger ;)
> 
> 
> here we go:
> the file acer and ednet. my hcidump was from the acer.
> 
>>>>> I tested all combinations with a minimal slave and master (only 
>>>>> connects/accept connection and quit directly again).
>>>>> the master (connecting one) doesn't care, csr and broadcom worked 
>>>>> fine.
>>>>>
>>>>> but the listening one gives the mentioned error (on more than 50% 
>>>>> of the tries) I tried with a acer and ednet broadcom dongle.
>>>>> A csr works just perfectly fine...
>>>>>
>>>>> after the error, the dongle keeps waiting for a slave but won't 
>>>>> access any more connections. so, basically the dongle is completly 
>>>>> freezed.
>>>>
>>>>
>>>>
>>>> Send in the "hcidump -X -V" for it.
>>>
>>>
>>> I attached a successfull and a failed attemp from the listening acer 
>>> dongle.
>>> Hope they are informative...
>>
>>
>>
>> These dumps gives no information about why you should receive a data
>> packet with an invalid connection handle. However maybe the change of
>> the packet types confuses the Broadcom dongle.
> 
> 
> change of packet type? i'm not doing anything like these intentionally.
> 
>> With what programs do you tested these things? I must try to reproduce
>> it reliable.
> 
> 
> gallerie-connect.cpp and arm-listen.cpp
> please note these are quick and dirty pasts of a c++ project. another 
> thing to mention is that you have to edit the macaddresses because I 
> hardcoded them (the pc's have multiple dongles).
> 
> thanks a lot!
> 
> 
> regards
> Marco
> 
> 
> ------------------------------------------------------------------------
> 
> hci0:   Type: USB
>         BD Address: 00:02:72:C3:26:F5 ACL MTU: 377:10 SCO MTU: 16:0
>         UP RUNNING PSCAN ISCAN
>         RX bytes:390 acl:0 sco:0 events:17 errors:0
>         TX bytes:311 acl:0 sco:0 commands:17 errors:0
>         Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: MASTER
>         Name: 'BlueZ (0)'
>         Class: 0x3e0100
>         Service Classes: Networking, Rendering, Capturing
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.2 (0x2) HCI Rev: 0xa LMP Ver: 1.2 (0x2) LMP Subver: 0x309
>         Manufacturer: Broadcom Corporation (15)
> 
> T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
> B:  Alloc= 46/900 us ( 5%), #Int=  2, #Iso=  0
> D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=0000 ProdID=0000 Rev= 0.00
> S:  Product=USB OHCI Root Hub
> S:  SerialNumber=c5056000
> C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  4 Spd=12  MxCh= 0
> D:  Ver= 2.00 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0a12 ProdID=0001 Rev=15.86
> C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> I:  If#= 2 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)
> T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  3 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0a5c ProdID=200a Rev= 0.01
> S:  Manufacturer=Broadcom
> S:  Product=CCBT2035BDGP23-1
> S:  SerialNumber=000272C326F5
> C:* #Ifs= 3 Cfg#= 1 Atr=a0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  32 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  32 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
> I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
> 
> 
> ------------------------------------------------------------------------
> 
> hci0:   Type: USB
>         BD Address: 00:02:72:C3:F2:10 ACL MTU: 377:10  SCO MTU: 16:0
>         UP RUNNING PSCAN ISCAN
>         RX bytes:526 acl:0 sco:0 events:42 errors:0
>         TX bytes:323 acl:0 sco:0 commands:19 errors:0
>         Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: ACCEPT MASTER
>         Name: 'btLapi'
>         Class: 0x100100
>         Service Classes:
>         Device Class: Computer, Uncategorized
>         HCI Ver: 1.2 (0x2) HCI Rev: 0x14 LMP Ver: 1.2 (0x2) LMP Subver: 0x309
>         Manufacturer: Broadcom Corporation (15)
> 
> 
> T:  Bus=04 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 6
> B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
> D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS= 8 #Cfgs=  1
> P:  Vendor=0000 ProdID=0000 Rev= 2.06
> S:  Manufacturer=Linux 2.6.8-24.14-default ehci_hcd
> S:  Product=EHCI Host Controller
> S:  SerialNumber=0000:00:1d.7
> C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms
> 
> T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
> B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
> D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=0000 ProdID=0000 Rev= 2.06
> S:  Manufacturer=Linux 2.6.8-24.14-default uhci_hcd
> S:  Product=UHCI Host Controller
> S:  SerialNumber=0000:00:1d.2
> C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
> 
> T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
> B:  Alloc= 23/900 us ( 3%), #Int=  1, #Iso=  0
> D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=0000 ProdID=0000 Rev= 2.06
> S:  Manufacturer=Linux 2.6.8-24.14-default uhci_hcd
> S:  Product=UHCI Host Controller
> S:  SerialNumber=0000:00:1d.1
> C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
> 
> T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 16 Spd=12  MxCh= 0
> D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0a5c ProdID=200a Rev= 0.01
> S:  Manufacturer=Broadcom
> S:  Product=CCBT2035BDGP23-2
> S:  SerialNumber=000272C3F210
> C:* #Ifs= 3 Cfg#= 1 Atr=a0 MxPwr=100mA
> I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  32 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  32 Ivl=1ms
> I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
> I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
> E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
> I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
> E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
> 
> T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
> B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
> D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> P:  Vendor=0000 ProdID=0000 Rev= 2.06
> S:  Manufacturer=Linux 2.6.8-24.14-default uhci_hcd
> S:  Product=UHCI Host Controller
> S:  SerialNumber=0000:00:1d.0
> C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
> E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
> 
> 
> ------------------------------------------------------------------------
> 
> // g++ -O2 -lbluetooth gallerie-connect.cpp -o gallerie-connect
> 
> #include <sys/ioctl.h>
> #include <sys/socket.h>
> #include <sys/poll.h>
> #include <bluetooth/bluetooth.h>
> #include <bluetooth/rfcomm.h>
> #include <bluetooth/hci.h>
> #include <bluetooth/hci_lib.h>
> #include <unistd.h>
> 
> #include <iostream>
> 
> using namespace std;
> 
> 
> int main()
> {
> 	struct sockaddr_rc laddr, raddr;
> 	int sock;
> 
> 	str2ba("00:02:72:C3:F2:10", &laddr.rc_bdaddr);
> 	laddr.rc_family = AF_BLUETOOTH;
> 	laddr.rc_channel = 1;
> 
> 	str2ba("00:02:72:C3:26:F5", &raddr.rc_bdaddr);
> 	raddr.rc_family = AF_BLUETOOTH;
> 	raddr.rc_channel = 5;
> 
> 	if((sock = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < 0)
> 	{
> 		cout << "Can't create RFCOMM socket" << endl;
> 		exit(1);
> 	}
> 
> 	if(bind(sock, (struct sockaddr *)&laddr, sizeof(laddr)) < 0)
> 	{
> 		cout << "Can't bind RFCOMM socket" << endl;
> 		close(sock);
> 		exit(1);
> 	}
> 
> 	if(connect(sock, (struct sockaddr *)&raddr, sizeof(raddr)) < 0)
> 	{
> 		cout << "Can't connect RFCOMM socket" << endl;
> 		close(sock);
> 		exit(1);
> 	}
> 
> 	cout << "connected" << endl;
> 
> 	close(sock);
> }
> 
> 
> ------------------------------------------------------------------------
> 
> // arm-linux-g++ -O2 -lbluetooth arm-listen.cpp -o arm-listen
> 
> #include <sys/ioctl.h>
> #include <sys/socket.h>
> #include <sys/poll.h>
> #include <bluetooth/bluetooth.h>
> #include <bluetooth/rfcomm.h>
> #include <bluetooth/hci.h>
> #include <bluetooth/hci_lib.h>
> #include <unistd.h>
> 
> #include <iostream>
> 
> using namespace std;
> 
> 
> int main()
> {
> 	int sock, client;
> 	socklen_t alen;
> 	struct sockaddr_rc addr;
> 
> 	str2ba("00:02:72:C3:26:F5", &addr.rc_bdaddr);
> 	addr.rc_family = AF_BLUETOOTH;
> 	addr.rc_channel = 5;
> 	alen = sizeof(addr);
> 
> 	if((sock = socket(AF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < 0)
> 	{
> 		cout << "clientService: socket(...) failed" << endl;
> 		exit(1);
> 	}
> 
> 	if(bind(sock, (struct sockaddr *)&addr, alen) < 0)
> 	{
> 		cout << "clientService: bind(...) failed" << endl;
> 		close(sock);
> 		exit(1);
> 	}
> 
> 	if(listen(sock, 1) < 0)
> 	{
> 		cout << "clientService: listen(...) failed\n" << endl;
> 		exit(1);
> 	}
> 
> 	client = accept(sock, (struct sockaddr *)&addr, &alen);
> 	cout << "connection here" << endl;
> 	close(client);
> 
> 	close(sock);
> 
> 	return 0;
> }


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
