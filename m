Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42932655.1070005@logicacmg.com>
From: "Tomas Honzak (WN CZ)" <Tomas.T.Honzak@logicacmg.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] SOLVED: Internal Bluetooth on dell latitude d610
References: <4291DFA9.6010401@logicacmg.com>	 <1116857742.30044.88.camel@pegasus>  <4292E9B9.7080907@logicacmg.com>	 <1116925311.30044.134.camel@pegasus> <4292EEF8.80102@logicacmg.com>	 <42931C81.2010104@logicacmg.com> <1116937973.30044.144.camel@pegasus>
In-Reply-To: <1116937973.30044.144.camel@pegasus>
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
Date: Tue, 24 May 2005 15:04:21 +0200

hello,
According to laptop specification, the bluetooth chipset should be Dell 
Wireless 350.
This is the relevant part of /proc/bus/usb/devices:
T:  Bus=03 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=413c ProdID=8103 Rev=16.57
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=  0mA
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


# hciconfig hci0 revision
hci0:   Type: USB
        BD Address: XX:XX:XX:XX:XX:XX ACL MTU: 384:8  SCO MTU: 64:8
        Build 1657
        Chip version: Unknown
        Max key size: 128 bit
        SCO mapping:  HCI

If you need some more information, please let me know.

Regards,
Tomas

Marcel Holtmann wrote:

>Hi Thomas,
>
>  
>
>>Kernel 2.6.12-pre4 fixed the problem.
>>    
>>
>
>a newer USB subsystem always helps ;)
>
>Please post content of /proc/bus/usb/devices and the output of
>"hciconfig hci0 revision" (as root).
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by Oracle Space Sweepstakes
>Want to be the first software developer in space?
>Enter now for the Oracle Space Sweepstakes!
>http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users
>  
>


-- 
Tomas Honzak
Configuration Management
Wireless Networks
_________________________________________
LogicaCMG
Na Okraji 335/42
162 00 Praha 6
Czech Republic
T: +420 284 020 936 (direct)
F: +420 284 020 112
E: Tomas.T.Honzak@logicacmg.com
www.logicacmg.com


This e-mail and any attachment is for authorised use by the intended recipient(s) only. It may contain proprietary material, confidential information and/or be subject to legal privilege. It should not be copied, disclosed to, retained or used by, any other party. If you are not an intended recipient then please promptly delete this e-mail and any attachment and all copies and inform the sender. Thank you.


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
