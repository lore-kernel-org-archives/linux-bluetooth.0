Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <3F04233D.3080106@superbug.demon.co.uk>
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Cozza <ac2crp@blueyonder.co.uk>
CC: bluez Dev <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Bluetooth headset problems.
References: <3F02DBA9.1060305@superbug.demon.co.uk>
	<004701c34153$0e650ba0$fd02a8c0@troll>
In-Reply-To: <004701c34153$0e650ba0$fd02a8c0@troll>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 03 Jul 2003 13:36:13 +0100
Content-Type: text/plain; CHARSET=us-ascii; FORMAT=flowed

Cozza wrote:
> Hi,
> 
> I believe that there is a problem with the hci-usb driver. I performed some
> brief investigations which I posted earlier to this mailing list.
> 
> Are you using a USB device? I've used the same code and Bluetooth headset
> with a PC card Bluetooth adaptor and everything worked fine.
> 
> Both Bluetooth devices use the CSR chipset, but the UART one using the BCSP
> protocol works whereas the USB one misses half the data packets, as you
> suggest.
> 
> My earlier message was posted on 20th June, entitled "SCO problem with USB
> devices" - I'd be interested to see if your problem looks the same. I think
> it possibly is, from what you've posted.
> 
> I haven't yet got around to investigating the problem with the USB stack -
> but I have the same problem, if it helps! If you are in a rush, then PC card
> devices seem to work at the moment...
> 
> Regards,
> 
> Colin
> 
> 
> 
> 
I looked at your previous email, and it seems that we both have exactly 
the same problem. I will have to look into this further, because I think 
it is better to get usb dongles working, than just use different 
hardware. As you have already tried it in windows and it works, I will 
proceed with that assumption, as I don't have windows to test with.
The "hstest" program in it's current state would never handle full 
duplex, but at least I can maybe get the recording working.

I am using a USB dongle. Mitsumi WML-C52APR, contains FCC ID: POOWML-C06
Relevent info from usb.
T:  Bus=01 Lev=02 Prnt=02 Port=00 Cnt=01 Dev#=  7 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=03ee ProdID=6440 Rev= 3.09
C:* #Ifs= 3 Cfg#= 1 Atr=c0 MxPwr=200mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:  If#= 2 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)


hciconfig -a hci0
hci0:   Type: USB
         BD Address: 00:A0:96:1F:42:BF ACL MTU: 192:8  SCO MTU: 64:8
         UP RUNNING PSCAN ISCAN
         RX bytes:99 acl:0 sco:0 events:13 errors:0
         TX bytes:296 acl:0 sco:0 commands:12 errors:0
         Features: 0xff 0xff 0x0f 0x00
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
         Name: 'BlueZ (0)'
         Class: 0x000100
         Service Classes: Unspecified
         Device Class: Computer, Uncategorized
         HCI Ver: 1.1 (0x1) HCI Rev: 0x135 LMP Ver: 1.1 (0x1) LMP 
Subver: 0x135
         Manufacturer: Cambridge Silicon Radio (10)

hcitool info 00:0A:D9:48:00:6E
Requesting information ...
         BD Address:  00:0A:D9:48:00:6E
         Device Name: HBH-30
         LMP Version: 1.1 (0x1) LMP Subversion: 0x8b40
         Manufacturer: Ericsson Mobile Comunications (0)
         Features: 0x1c 0x28 0x01 0x00
                 <encryption> <slot offset> <timing accuracy> <SCO link>
                 <HV3 packets> <CVSD>




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
