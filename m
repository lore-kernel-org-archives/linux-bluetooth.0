Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <000701c5cffd$f4e8cc20$6701a8c0@mainframe>
From: "Jonathan Leong" <aptos@gmx.net>
To: <bluez-users@lists.sourceforge.net>
References: <001901c5cfe1$29a64180$6701a8c0@mainframe> <1129201609.6951.1.camel@localhost.localdomain> <000401c5cff4$d138d620$6701a8c0@mainframe> <1129210251.6308.0.camel@localhost.localdomain>
Subject: Re: [Bluez-users] Help with Digianswer protocol analyzer
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
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
Date: Thu, 13 Oct 2005 21:56:43 +0800

Hi Marcel,

It should be the BPA-100. According to your website, I reckon it belongs to 
the first generation (08fd:0001) .
The device isnt marked Tektronix but Digianswer A/S Bluetooth Protocol 
Analyzer but shouldn't be much of a difference.
The loaded driver is hci_usb instead of bpa10x, maybe the driver was 
missing? modprobe bpa10x.ko gave me an error.

Regards,

Jonathan Leong

----- Original Message ----- 
From: "Marcel Holtmann" <marcel@holtmann.org>
To: <bluez-users@lists.sourceforge.net>
Sent: Thursday, October 13, 2005 9:30 PM
Subject: Re: [Bluez-users] Help with Digianswer protocol analyzer


> Hi Jonathan,
>
>> > show me the content of /proc/bus/usb/devices and check if you have the
>> > bpa10x kernel driver. If not then you might need to install a newer
>> > kernel.
>>
>> here we go,
>>
>> T:  Bus=02 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
>> D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS= 8 #Cfgs=  1
>> P:  Vendor=08fd ProdID=0001 Rev= 1.00
>> C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr=300mA
>> I:  If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=hci_usb
>> E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>> E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
>> E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
>> I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=hci_usb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
>> I:  If#= 1 Alt= 1 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=hci_usb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  16 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  16 Ivl=1ms
>> I:  If#= 1 Alt= 2 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=hci_usb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  32 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  32 Ivl=1ms
>> I:  If#= 1 Alt= 3 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=hci_usb
>> E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
>> E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
>>
>> Meanwhile, I'll go upgrade my kernel to 2.6.13 and get it patch.
>> I'll post the results in a bit.
>
> this won't help, I think. Is this the BPA-100 or the BPA-105?
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Power Architecture Resource Center: Free content, downloads, discussions,
> and more. http://solutions.newsforge.com/ibmarch.tmpl
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
