Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41F007D0.5060606@nm.ru>
From: George Kibardin <george_kibardin@nm.ru>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Tekram TM-304
References: <41EF5879.7090005@nm.ru> <1106224337.8190.168.camel@pegasus>
In-Reply-To: <1106224337.8190.168.camel@pegasus>
Content-Type: multipart/alternative;
 boundary="------------020708030004010709070000"
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
Date: Thu, 20 Jan 2005 22:34:40 +0300

This is a multi-part message in MIME format.
--------------020708030004010709070000
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 8bit

Marcel Holtmann wrote:

>Hi George,
>
>  
>
>>My usb bluetooth dongle did not recognized by kernel (2.6.7)
>>Does anybody know something about this dongle support in linux?
>>    
>>
>
>show us the content of /proc/bus/usb/devices.
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
>Tool for open source databases. Create drag-&-drop reports. Save time
>by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
>Download a FREE copy at http://www.intelliview.com/go/osdn_nl
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users
>__________
>
>http://www.newhost.ru - Ëœ“œ€…  »œ”‘…Œ«!
>
>
>
>  
>
Hi Marcel,

as you request - piece of my /proc/bus/usb/devices (related to dongle)

T:  Bus=02 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=1310 ProdID=0001 Rev=15.00
S:  Manufacturer=SiW
S:  Product=SiW
S:  SerialNumber=E234320D0B00
C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr= 50mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
 
Two questions:
1. SiW - Silicon Wave am I right?
2. "Cls=e0(unk. )", why unknown - i saw device class registration code 
in hci_usb.c and bluetooth.ko and hci_usb.ko was automatically loaded at 
startup?

Best regards,
George

--------------020708030004010709070000
Content-Type: text/html; charset=windows-1251
Content-Transfer-Encoding: 8bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=windows-1251"
 http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Marcel Holtmann wrote:
<blockquote cite="mid1106224337.8190.168.camel@pegasus" type="cite">
  <pre wrap="">Hi George,

  </pre>
  <blockquote type="cite">
    <pre wrap="">My usb bluetooth dongle did not recognized by kernel (2.6.7)
Does anybody know something about this dongle support in linux?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
show us the content of /proc/bus/usb/devices.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&amp;-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at <a class="moz-txt-link-freetext" href="http://www.intelliview.com/go/osdn_nl">http://www.intelliview.com/go/osdn_nl</a>
_______________________________________________
Bluez-users mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a>
__________

<a class="moz-txt-link-freetext" href="http://www.newhost.ru">http://www.newhost.ru</a> - Ëœ“œ€…  »œ”‘…Œ«!



  </pre>
</blockquote>
Hi Marcel,<br>
<br>
as you request - piece of my /proc/bus/usb/devices (related to dongle)<br>
<br>
<tt>T:† Bus=02 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=† 3 Spd=12† MxCh= 0<br>
D:† Ver= 1.10 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=† 1<br>
P:† Vendor=1310 ProdID=0001 Rev=15.00<br>
S:† Manufacturer=SiW<br>
S:† Product=SiW<br>
S:† SerialNumber=E234320D0B00<br>
C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr= 50mA<br>
I:† If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb<br>
E:† Ad=81(I) Atr=03(Int.) MxPS=† 16 Ivl=1ms<br>
E:† Ad=82(I) Atr=02(Bulk) MxPS=† 64 Ivl=0ms<br>
E:† Ad=02(O) Atr=02(Bulk) MxPS=† 64 Ivl=0ms<br>
I:† If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)<br>
E:† Ad=83(I) Atr=01(Isoc) MxPS=†† 0 Ivl=1ms<br>
E:† Ad=03(O) Atr=01(Isoc) MxPS=†† 0 Ivl=1ms<br>
I:† If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)<br>
E:† Ad=83(I) Atr=01(Isoc) MxPS=†† 9 Ivl=1ms<br>
E:† Ad=03(O) Atr=01(Isoc) MxPS=†† 9 Ivl=1ms<br>
I:† If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)<br>
E:† Ad=83(I) Atr=01(Isoc) MxPS=† 17 Ivl=1ms<br>
E:† Ad=03(O) Atr=01(Isoc) MxPS=† 17 Ivl=1ms<br>
I:† If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)<br>
E:† Ad=83(I) Atr=01(Isoc) MxPS=† 25 Ivl=1ms<br>
E:† Ad=03(O) Atr=01(Isoc) MxPS=† 25 Ivl=1ms<br>
I:† If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)<br>
E:† Ad=83(I) Atr=01(Isoc) MxPS=† 33 Ivl=1ms<br>
E:† Ad=03(O) Atr=01(Isoc) MxPS=† 33 Ivl=1ms<br>
I:† If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)<br>
E:† Ad=83(I) Atr=01(Isoc) MxPS=† 49 Ivl=1ms<br>
E:† Ad=03(O) Atr=01(Isoc) MxPS=† 49 Ivl=1ms<br>
</tt>†<br>
Two questions:<br>
1. SiW - Silicon Wave am I right?<br>
2. "<tt>Cls=e0(unk. )</tt>", why unknown - i saw device class
registration code in hci_usb.c and bluetooth.ko and hci_usb.ko was
automatically loaded at startup?<br>
<br>
Best regards,<br>
George<br>
</body>
</html>

--------------020708030004010709070000--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
