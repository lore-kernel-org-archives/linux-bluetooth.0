Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5A180.48A7DC3A"
Subject: RE: [Bluez-devel] Porting BlueZ on embedded uClinux
Message-ID: <E64BAD5A8AD46740828069A678D9DD73011A90@netbe01.net.unimis>
From: "Al" <Al_chane@issc.com.tw>
To: <bluez-devel@lists.sourceforge.net>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 15 Aug 2005 18:01:19 +0800

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5A180.48A7DC3A
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Hi,

     I resolved the problem of integrating HCI driver. I can now use
"hciconfig hci0 up" to bring up the device. MAC address can be read
correctly. Kernel porting seems ok so far.

    But when I use "hciconfig -a", it has problem to read "Name", =
"Class",
and so on from /etc/bluetooth/hcid.conf (which I created already in the=20
embedded
ramdisk). Any dependancy among those utilities? For example, if I need =
to=20
use "hciconfig",
"hcid" is needed?

thanks for helps,

Al

----- Original Message -----=20
From: "durai" <durai@isofttech.com>
To: <bluez-devel@lists.sourceforge.net>
Sent: Monday, August 15, 2005 3:22 PM
Subject: Re: [Bluez-devel] Porting BlueZ on embedded uClinux

-----Original Message-----=20
From: bluez-devel-admin@lists.sourceforge.net =A5N=B2z durai=20
Sent: 2005/8/15 [=ACP=B4=C1=A4@] =A4U=A4=C8 03:22=20
To: bluez-devel@lists.sourceforge.net=20
Cc:=20
Subject: Re: [Bluez-devel] Porting BlueZ on embedded uClinux



	Hi Al,
	I recently ported bluez stack in a embedded linux running 2.4.18 =
kernel.
	First I downloaded the MH patch from  =
http://www.holtmann.org/linux/kernel/.
	and
	applied it. Now both statically compiled driver as well as modules are
	working correctly.
	You can also try finding an appropriate patch and patch it with your =
kernel.
	But what is
	surprising for me is, though your kernel is 2.4.21 and you are not able =
to
	find the options in
	make menuconfig.  I guess something  is messed up in your package.
=09
	Can you find "hci_usb_init" in your System.map? Is it integrated =
correctly?
	regards
	durai
=09


------_=_NextPart_001_01C5A180.48A7DC3A
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IhQKAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAAtgMAAAAAAAC5AAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEANAAAAFJFOiBbQmx1ZXotZGV2ZWxd
IFBvcnRpbmcgQmx1ZVogb24gZW1iZWRkZWQgdUNsaW51eAA8EgEFgAMADgAAANUHCAAPABIAAQAT
AAEAGgEBIIADAA4AAADVBwgADwASAAEAEwABABoBAQmAAQAhAAAANDI2M0MxMEY2NjE2QTA0REJF
MTMyOENFOEIxNzQyOTQABwcBA5AGAEgRAAA2AAAAAwA2AAAAAABAADkAOtynSIChxQEeAD0AAQAA
AAUAAABSRTogAAAAAAIBRwABAAAALwAAAGM9dXM7YT0gO3A9dW5pbWlzO2w9TkVUQkUwMS0wNTA4
MTUxMDAxMTlaLTEwNTIAAB4ASQABAAAANAAAAFJlOiBbQmx1ZXotZGV2ZWxdIFBvcnRpbmcgQmx1
ZVogb24gZW1iZWRkZWQgdUNsaW51eABAAE4AgF6eKGqhxQEeAFoAAQAAACgAAABibHVlei1kZXZl
bC1hZG1pbkBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAgFbAAEAAABtAAAAAAAAAIErH6S+oxAZnW4A
3QEPVAIAAAAAYmx1ZXotZGV2ZWwtYWRtaW5AbGlzdHMuc291cmNlZm9yZ2UubmV0AFNNVFAAYmx1
ZXotZGV2ZWwtYWRtaW5AbGlzdHMuc291cmNlZm9yZ2UubmV0AAAAAAIBXAABAAAALQAAAFNNVFA6
QkxVRVotREVWRUwtQURNSU5ATElTVFMuU09VUkNFRk9SR0UuTkVUAAAAAB4AXQABAAAABgAAAGR1
cmFpAAAAAgFeAAEAAAA3AAAAAAAAAIErH6S+oxAZnW4A3QEPVAIAAAAAZHVyYWkAU01UUABkdXJh
aUBpc29mdHRlY2guY29tAAACAV8AAQAAABkAAABTTVRQOkRVUkFJQElTT0ZUVEVDSC5DT00AAAAA
HgBmAAEAAAAFAAAAU01UUAAAAAAeAGcAAQAAACgAAABibHVlei1kZXZlbC1hZG1pbkBsaXN0cy5z
b3VyY2Vmb3JnZS5uZXQAHgBoAAEAAAAFAAAAU01UUAAAAAAeAGkAAQAAABQAAABkdXJhaUBpc29m
dHRlY2guY29tAB4AcAABAAAAMAAAAFtCbHVlei1kZXZlbF0gUG9ydGluZyBCbHVlWiBvbiBlbWJl
ZGRlZCB1Q2xpbnV4AAIBcQABAAAAGwAAAAHFoWpZHnsEdWBmQ0MghsGETZksPUUABWut+AAeAHQA
AQAAACIAAABibHVlei1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAAeABoMAQAAAAMAAABB
bAAAHgAdDgEAAAAwAAAAW0JsdWV6LWRldmVsXSBQb3J0aW5nIEJsdWVaIG9uIGVtYmVkZGVkIHVD
bGludXgAAgEJEAEAAAAhCgAAHQoAALMeAABMWkZ1DOhrL4MACgByY3BnOTUC0cEDYWh0bWwxAzAB
A58B9wqAAqQD4wIAY2gKwMBzZXQxMzYF0AuA8GdMaXUCgA/zAFAEVu0RnDIC4xDHMgYABsMSBeYz
BEYQxzAgCFUHsgKAFxITCO8J9zsYvzI1NfsSAgxgYwBQCwkBZBFgFvDJC6U0IA/yKlwOogGQXmcU
4AqjEhMd2DQU4DwAIURPQ1RZUEUAIEhUTUwgUFUAQkxJQyAiLS8QL1czQyFwRFREESCEMy4yIXBF
TiLOPh7dHn8jsTE4H+Agkjci/yQPJoAzHXAlYEVBvkQlvQ7hJt8pXyTkNg7goDxNRVRBB7BBLFCY
PSJHCfAEkGF0BbCiIhcAT05UIsBULOBZBeFFeBDhEbBlBlJ2DxdhLzEAkAIgIDYuMIAuNjQ4Ny4x
Iu4TKr8k8zc3H+BUSVQUTEUlvjQO4FJlOsggW0IKQXotAQAvMFxsXSDQGGERoSA1Alo6IC/BZQbQ
CYABAGQgSHVDbAuAdXgkXjX9H+AvMz8xbyY1NIE5ACg/DyaPPNQOMB/gQk9EWaAgZGlyPTzwcjxA
zzyzACEDMD9RZG8A4D9R+QqxXHEYoD9REOADMD+1PxbwPGsc4T1vDhARcDxE/ElWP4kAAEHHPIkw
MET/cUISSGksJGwsAD6hUvs/iwuAZQqBQc9JH0ovSz8FPRA4HXAmbmJzcMcCgEcpFcEnYTA/l05/
/0+PUJ9Rr1K/U89U31XvVv/RFvAgSSAYwHMG8C8w6TdQdGgu4HADYAJgNuDnNqBAEAuAdGUJwC1Q
NhLTOuxDNUhDW2BkBRAvMUouW1FjA5FubwfgdY8RIEufTK9NvCJoYw3gOQIgZmk2MGOxFvB1cPMt
kC1gIGIFEDYhZKBcA8s1YQ3gZV+wTUEhMF3P/UNiYTcgW4EEIF/yNwBbcT9n8GCvYb9NvAWhGMBj
dPRseV+wSwSRNZBcQDXl5xEgNuAEIG9rbbBk8Gav9UNiZgrALmkvaj9Nv3BP/3Ffcm9Yj1mfV392
f3ePeJ+nea96v1qqQnUFQHdcIA8DoFtgYHFjmi1hIiz/XPAFQBDwBCBcVmThbo9DYrNo4iFATmEH
gIFxIjeA/YHgc4Fwcx90L3U8AHA3UCduUS/BA1IgLxEwYy8rCjItYG9cEC9jsWQu+WPiICh/8A3g
QZBbYILPf0NiBQBo8F0gN1AHQGjief9c8VwDhW+Gf3U8NuaOP49Pi3U8LUBtPxBzaylfsKxBbo2g
AQBwCfBkAHC+Y42ghIACIDYwXBBvgHE/i39DYn/AAxCBoAiQcz9kIEYFsWV4hIALUGX/gYFAEFtg
LSBb4oKtko+Tn/+AXYVPm59ir4pCLZAEAJb/90NTmiIJgD+er5+/dT+kP++lT6ZZXBAAcGsEIAIQ
BcDxXCBscHOen6gPph+rP/usT61aQQ/jrl+vb61/sa9Lsr+zxS23MiBPBRBn/wuAB0AF0GgxPRAu
4Lc0ok8/Q2+1D7YfmPADYTTQImS/CHALcC2QfH888H3JPLOfrXznPCyACqNoGMBmLODXAMADEC1g
Or3DQAQAXNDrAkAFkGiKgW0i4X3qCJA0bGQ8gmbFUAuAc3SUe0ggUVIhEE5LIUD/wq/DuBfQAfHF
UBEQPPAYIP0AQXUDIcA3x18DcD+ne8nLy59CLjkf0S9BPE19Qnpnv1o+zX+6z7vf0YVU/8cwwL+/
P9F/wV/CaQoyNUXmQDeQxgBzLlugCHBmIOuqcS7QLi0gdMRPxV/Gbf/aH9svyJ/Jqt8/4E7M38yv
/9dvzs/P39Dv0f/TD7NcBmC3AjDVHV6WTQIgleB5gYCYQXVnYHAFQDE1gYBFAdAwOOAzOjIU4FCO
Teuf7K/tvXViamxh/zTQNL81z+7vugM27vI/809/s1/6f/uP/J8kxjBAH+BGgy3BbbBpemU9Mtw8
/wvxQam3M7eeuK/9//8P1591KAFCROtiQam9U+e/Lz8Jmlqq9/+6EuMpgVBkbX+NwOPf29PpD32P
fp97gTVJe4A0ZXuAYjJ7gDf+YRHvEv8UD73DBX8Gjwef/wivCb/uKguPDJ8Nr15a8XJ4Lzgv8TD1
8HuBQJAn6z6AFZE0e4Bj4jB7kCTxbDQw9sAlRDUVQSViY/0BMDDxwxmvGr8bzxzfHe//1JcfryC/
WubjL+BOIj+6D58oHykvKj8rT0GpQ2MtL/8uPyG/M8803zXvNv8ebvVF/zkvOj9a5vXP9t+RJzHv
mAR/+e88fz2PAB9J/0sPTBw1PU0BLwFiQy9Ow0d5NzJfP/fY8ucITBBMHDDYoS/YRElWUI9Oz2fm
UTL/A+hwTQJMT0NLUVWIT1RFX0Bpcj0ygDuZIN3geVyQ2YBmYFJHgd5wLVJJR0hURLD4MHB43CrY
8kwSWlHZAXNdQsPgXHHialcPWB8y1yWgRHAzLTbYoVA/6+XoeTCQMzYALwE/Ak9edkj/GYCxEKsP
TR9OLYBA2VARMP3usGyWIG1CmkEv01qBJGD7bjCNwWFGuEjDR09f/+nCIWFRcnVubvciMi6INC4x
ZWBrZXIRsPxsLmhvaX+8fVog8QGAQMBkb3dubG+EMJpC+Y4BTUiCAIzwiyGJAhYffxcvGD8+v9jG
RHDCRNaQdKBwOi8vd31QLpawV28Q3sBxIC4RYS9Iwy/9cfQv3C/dP95GfO99/38C/+Ff4mqB34Lv
fwFVz+ZPXp//6GhyX3NvTi2V8JGvjT+OTn5wmYCYsEc/b39whpiQLuwgTnXwL8BvqgBs0pig7mO3
8GvhxBFwmHCaQYSQ1mlFYJkgYapQdxAA4mD5l+Ftb73AWsCqUNkQTkHXj4+Qn05ad6qAa/ciku/3
k/9wpMQQcmuBa9GML5pPvU4tWREAltCPMI8gbBDw/XaAcmvwgBDwYPciozKScPt3cKTAaXcQuIB3
BI8xdvV/lWCYAJVgd0Ccz53fcKR5nxEBce+gf6GPioNCdaZxdmh3EG0wc6ovqz9OPHP/GVCk8WXg
9zERUZiAuIAwoPfwoHaQEQBnd0Cpaa2hpt/np+9wlXGCMjGls6lhmQL8IG6V8I8gbIB2sN8Ard//
ru9OPKPydoOk4PcQ98CYcP8QYLf/uQ9OPN7AqbCzj7Sfr3CVscBI4MQQboAQZ6oc/3h/eY9EQ2tg
8OAEwWXQyGD95RBo9yHCr8O/xM+zUrHA+wTQ+aJwbTKpY79/wI9wpP/ZAG0QBPGqH70vTi/Or8+/
PdDKQ6MxtsK684HAY2myX/DwYl8QYJVgIsr3LFN53eBGwC7ewHA/P3Wwu+Ex38x/lOfusGVn3xlg
bELX79jyn0c/0Y/Sn+vQrGuAZ9jwZK3P3g/Qnf8ZQ+B/4Y/Qr09PUF+JHlNO/1xN5i9SNovBYpFU
T0LxWXff6D/sX1+/8a/bVzVlYUMAeE9EWe3di7Dzb2DxN1OLwVugTUyMAH34IAAAAB4ANRABAAAA
PAAAADxFNjRCQUQ1QThBRDQ2NzQwODI4MDY5QTY3OEQ5REQ3MzAxMUE5MEBuZXRiZTAxLm5ldC51
bmltaXM+AB4ARxABAAAADwAAAG1lc3NhZ2UvcmZjODIyAAALAPIQAQAAAB8A8xABAAAAdAAAAFIA
RQAlADMAQQAgAFsAQgBsAHUAZQB6AC0AZABlAHYAZQBsAF0AIABQAG8AcgB0AGkAbgBnACAAQgBs
AHUAZQBaACAAbwBuACAAZQBtAGIAZQBkAGQAZQBkACAAdQBDAGwAaQBuAHUAeAAuAEUATQBMAAAA
CwD2EAAAAABAAAcwktvSB4ChxQFAAAgwkmWxSIChxQEDAN4/tgMAAAMA8T8EBAAAHgD4PwEAAAAD
AAAAQWwAAAIB+T8BAAAAXQAAAAAAAADcp0DIwEIQGrS5CAArL+GCAQAAAAAAAAAvTz1VTklNSVMv
T1U9RklSU1QgQURNSU5JU1RSQVRJVkUgR1JPVVAvQ049UkVDSVBJRU5UUy9DTj1BTC5JU1NDAAAA
AB4A+j8BAAAAFQAAAFN5c3RlbSBBZG1pbmlzdHJhdG9yAAAAAAIB+z8BAAAAHgAAAAAAAADcp0DI
wEIQGrS5CAArL+GCAQAAAAAAAAAuAAAAAwD9P7YDAAADABlAAAAAAAMAGkAAAAAAAwAdQAAAAAAD
AB5AAAAAAB4AMEABAAAACAAAAEFMLklTU0MAHgAxQAEAAAAIAAAAQUwuSVNTQwAeADJAAQAAACgA
AABibHVlei1kZXZlbC1hZG1pbkBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAHgAzQAEAAAAUAAAAZHVy
YWlAaXNvZnR0ZWNoLmNvbQAeADhAAQAAAAgAAABBTC5JU1NDAB4AOUABAAAAAgAAAC4AAAALACkA
AAAAAAsAIwAAAAAAAwAGEImSEgYDAAcQwgQAAAMAEBAAAAAAAwAREAAAAAAeAAgQAQAAAGUAAABI
SSxJUkVTT0xWRURUSEVQUk9CTEVNT0ZJTlRFR1JBVElOR0hDSURSSVZFUklDQU5OT1dVU0UiSENJ
Q09ORklHSENJMFVQIlRPQlJJTkdVUFRIRURFVklDRU1BQ0FERFJFU1NDAAAAAAIBfwABAAAAPAAA
ADxFNjRCQUQ1QThBRDQ2NzQwODI4MDY5QTY3OEQ5REQ3MzAxMUE5MEBuZXRiZTAxLm5ldC51bmlt
aXM+AG77

------_=_NextPart_001_01C5A180.48A7DC3A--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
