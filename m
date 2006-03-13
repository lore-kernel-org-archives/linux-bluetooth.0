Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C64659.5352ACC0"
Subject: RE: [Bluez-users] ISSC USB dongle can't ping with size 1000
Message-ID: <E64BAD5A8AD46740828069A678D9DD73011B21@netbe01.net.unimis>
From: "Al" <Al_chane@issc.com.tw>
To: <bluez-users@lists.sourceforge.net>
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
Date: Mon, 13 Mar 2006 12:48:09 +0800

This is a multi-part message in MIME format.

------_=_NextPart_001_01C64659.5352ACC0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Hi, Marcel:
=20
       There is no default size and packet number assigned to ISSC chip
if no HCI_Host_Buffer_Size command is sent from Host.
It sends whatever the size it receives to host. But it has problem to=20
send the packets with size more than 970 bytes from my current
observation.
=20
BRs,
=20
Al

	-----Original Message-----=20
	From: bluez-users-admin@lists.sourceforge.net =A5N=B2z Marcel Holtmann=20
	Sent: 2006/3/9 [=ACP=B4=C1=A5|] =A4U=A4=C8 09:49=20
	To: bluez-users@lists.sourceforge.net=20
	Cc:=20
	Subject: RE: [Bluez-users] ISSC USB dongle can't ping with size 1000
=09
=09

	Hi Al,
=09
	>      I think the problem may not be the buffer size (678) that ISSC =
device
	> has. When I ping with size 1400 bytes, hcidump shows host breaks 1400 =
bytes
	> into serveal 678 byte packets and sends them to device. Both ping =
request and ping reply from the other side can be captured in air.
	>
	>      Most likely the problem is occured when ISSC device trys to send
	> packets with large size to host. From the hcidump, I observe that if =
devices
	> like CSR receiving packets with size 1400, it breaks 1400 into =
serveral 300 (something) packets and sends to host. On the other hand, =
when ISSC device receives packet with size 900, it sends 900 byte packet =
to host without breaking. But when the size is more than 1000, hcidump =
shows ISSC device does not send any packet to host.
=09
	there exists the HCI_MAX_ACL_SIZE constant which is 1024 and the
	HCI_MAX_FRAME_SIZE which is 4 times HCI_MAX_ACL_SIZE.
=09
	What is the default frame size and max packets number an ISSC chips
	sends to the host if no HCI_Host_Buffer_Size has been called?
=09
	>          After sending HCI_Host_Buffer_Size command, hcidump shows =
ISSC
	> device sends max size of 256 byte to host. Ping with 1500 bytes and =
Internet
	> access work  so far. I only try this with PAN to implement NAP.
=09
	The kernel has the HCI_Host_Buffer_Size command in its code, but it is
	commented out. I forget the reason why this has been done, but I assume
	there was a reason for it.
=09
	Regards
=09
	Marcel
=09
=09
=09
=09
	-------------------------------------------------------
	This SF.Net email is sponsored by xPML, a groundbreaking scripting =
language
	that extends applications into web and mobile media. Attend the live =
webcast
	and join the prime developer group breaking into this new coding =
territory!
	=
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D110944&bid=3D241720&dat=3D=
121642
	_______________________________________________
	Bluez-users mailing list
	Bluez-users@lists.sourceforge.net
	https://lists.sourceforge.net/lists/listinfo/bluez-users
=09


------_=_NextPart_001_01C64659.5352ACC0
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IgoEAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAAtgMAAAAAAAC5AAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEAPAAAAFJFOiBbQmx1ZXotdXNlcnNd
IElTU0MgVVNCIGRvbmdsZSBjYW4ndCBwaW5nIHdpdGggc2l6ZSAxMDAwAFITAQWAAwAOAAAA1gcD
AA0ADAAwAAkAAQAzAQEggAMADgAAANYHAwANAAwAMAAJAAEAMwEBCYABACEAAABEQzlEODgwQTFG
RThGQzQ1OTFBMTVCQjUxOThGQTAwMgBQBwEDkAYAkBUAADYAAAADADYAAAAAAEAAOQDArFJTWUbG
AR4APQABAAAABQAAAFJFOiAAAAAAAgFHAAEAAAAtAAAAYz11czthPSA7cD11bmltaXM7bD1ORVRC
RTAxLTA2MDMxMzA0NDgwOVotMzMAAAAAHgBJAAEAAAA8AAAAUkU6IFtCbHVlei11c2Vyc10gSVNT
QyBVU0IgZG9uZ2xlIGNhbid0IHBpbmcgd2l0aCBzaXplIDEwMDAAQABOAIBLHDyAQ8YBHgBaAAEA
AAAoAAAAYmx1ZXotdXNlcnMtYWRtaW5AbGlzdHMuc291cmNlZm9yZ2UubmV0AAIBWwABAAAAbQAA
AAAAAACBKx+kvqMQGZ1uAN0BD1QCAAAAAGJsdWV6LXVzZXJzLWFkbWluQGxpc3RzLnNvdXJjZWZv
cmdlLm5ldABTTVRQAGJsdWV6LXVzZXJzLWFkbWluQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAAAAAAC
AVwAAQAAAC0AAABTTVRQOkJMVUVaLVVTRVJTLUFETUlOQExJU1RTLlNPVVJDRUZPUkdFLk5FVAAA
AAAeAF0AAQAAABAAAABNYXJjZWwgSG9sdG1hbm4AAgFeAAEAAABBAAAAAAAAAIErH6S+oxAZnW4A
3QEPVAIAAAAATWFyY2VsIEhvbHRtYW5uAFNNVFAAbWFyY2VsQGhvbHRtYW5uLm9yZwAAAAACAV8A
AQAAABkAAABTTVRQOk1BUkNFTEBIT0xUTUFOTi5PUkcAAAAAHgBmAAEAAAAFAAAAU01UUAAAAAAe
AGcAAQAAACgAAABibHVlei11c2Vycy1hZG1pbkBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAHgBoAAEA
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
cy/fUtkoJto435j/7Y/un9pW4Ijwz/Hf2lbheE/ZN1Mp90+ynjky2NAv3kHZENff2O/Z/F/+H/8v
D//6+x/8L9n8Qmx1Zf566+Ek8Lxv0d8w1r+CwqPfDPEBDwIfAy8ENkAHwuwA/ZbAdaaBjPPmIggP
CR/Z//vbD9wec+tRC8/mIxKTEoPzDyCM8C9iBBjiH+Mv5Dr/El8TbxR/FYDpT+peGH8Zj/0an3P4
j/hfD7/6fw2PDp8PIy8lgmcxJJBGT05U/yYpIa85cAWyIugnKAWjJy9XBRbg8CSBUCTOMBDxLwBC
TE9DS1FVT+xURSlfLX9nIjEFzzMPiQVDNTgwEk9EWSTNlyRwNI83ETckgUhUwPAFJiB9OUAAHgA1
EAEAAAA8AAAAPEU2NEJBRDVBOEFENDY3NDA4MjgwNjlBNjc4RDlERDczMDExQjIxQG5ldGJlMDEu
bmV0LnVuaW1pcz4AHgBHEAEAAAAPAAAAbWVzc2FnZS9yZmM4MjIAAAsA8hABAAAAHwDzEAEAAACE
AAAAUgBFACUAMwBBACAAWwBCAGwAdQBlAHoALQB1AHMAZQByAHMAXQAgAEkAUwBTAEMAIABVAFMA
QgAgAGQAbwBuAGcAbABlACAAYwBhAG4AJwB0ACAAcABpAG4AZwAgAHcAaQB0AGgAIABzAGkAegBl
ACAAMQAwADAAMAAuAEUATQBMAAAACwD2EAAAAABAAAcwumBHTVlGxgFAAAgwHqtxU1lGxgEDAN4/
tgMAAAMA8T8EBAAAHgD4PwEAAAADAAAAQWwAAAIB+T8BAAAAXQAAAAAAAADcp0DIwEIQGrS5CAAr
L+GCAQAAAAAAAAAvTz1VTklNSVMvT1U9RklSU1QgQURNSU5JU1RSQVRJVkUgR1JPVVAvQ049UkVD
SVBJRU5UUy9DTj1BTC5JU1NDAAAAAB4A+j8BAAAAFQAAAFN5c3RlbSBBZG1pbmlzdHJhdG9yAAAA
AAIB+z8BAAAAHgAAAAAAAADcp0DIwEIQGrS5CAArL+GCAQAAAAAAAAAuAAAAAwD9P7YDAAADABlA
AAAAAAMAGkAAAAAAAwAdQAAAAAADAB5AAAAAAB4AMEABAAAACAAAAEFMLklTU0MAHgAxQAEAAAAI
AAAAQUwuSVNTQwAeADJAAQAAACgAAABibHVlei11c2Vycy1hZG1pbkBsaXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQAHgAzQAEAAAAUAAAAbWFyY2VsQGhvbHRtYW5uLm9yZwAeADhAAQAAAAgAAABBTC5JU1ND
AB4AOUABAAAAAgAAAC4AAAALACkAAAAAAAsAIwAAAAAAAwAGEHprOBIDAAcQswcAAAMAEBAAAAAA
AwAREAAAAAAeAAgQAQAAAGUAAABISSxNQVJDRUw6VEhFUkVJU05PREVGQVVMVFNJWkVBTkRQQUNL
RVROVU1CRVJBU1NJR05FRFRPSVNTQ0NISVBJRk5PSENJSE9TVEJVRkZFUlNJWkVDT01NQU5ESVNT
RU5URlJPAAAAAAIBfwABAAAAPAAAADxFNjRCQUQ1QThBRDQ2NzQwODI4MDY5QTY3OEQ5REQ3MzAx
MUIyMUBuZXRiZTAxLm5ldC51bmltaXM+AH4r

------_=_NextPart_001_01C64659.5352ACC0--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
