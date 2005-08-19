Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5A45F.9E7B518A"
Subject: RE: [Bluez-users] RE: Port BlueZ lib and utility on embedded uClinux
Message-ID: <E64BAD5A8AD46740828069A678D9DD73011AA1@netbe01.net.unimis>
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
Date: Fri, 19 Aug 2005 09:45:03 +0800

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5A45F.9E7B518A
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
     How did you get name for other bluetooth device to find? Give the =
name
in codes instead of from /etc/bluetooth/hcid.conf ? Are other utilities =
functional
ok while disabling those options?
=20
Thanks for helps,
=20
Al

	-----Original Message-----=20
	From: bluez-users-admin@lists.sourceforge.net =A5N=B2z blookk -=20
	Sent: 2005/8/19 [=ACP=B4=C1=A4=AD] =A4W=A4=C8 03:21=20
	To: bluez-users@lists.sourceforge.net=20
	Cc:=20
	Subject: RE: [Bluez-users] RE: Port BlueZ lib and utility on embedded =
uClinux
=09
=09

	Hi,

	When I am porting BlueZ to uCLinux, I found the same problem.
	I try with "select()" instead of "poll()", but I did not  solve the =
problem.

	I decided disable this option, and do not read the local name or other =
characteristics that I do not remenber.
=09

	Regards.
=09

	=09
  _____ =20

		From:  "Al" <Al_chane@issc.com.tw>
		Reply-To:  bluez-users@lists.sourceforge.net
		To:  <bluez-users@lists.sourceforge.net>
		Subject:  [Bluez-users] RE: Port BlueZ lib and utility on embedded =
uClinux
		Date:  Thu, 18 Aug 2005 14:42:09 +0800
		>
		>Hi,
		>
		>      The poll() always return error :
		>
		>      while ((n =3D poll(&p, 1, to)) < 0) in funcion int hci_send_req =
() (file: hci.c) results in "Can't read local name on hci0: Connection =
timed out (110)"
		>
		>      Has anyone had same problem using poll() in embedded linux?
		>
		>thanks a lot,
		>
		>Al
		>-----Original Message-----
		>From: Al on behalf of Al
		>Sent: Wed 8/17/2005 3:48 PM
		>To: bluez-users@lists.sourceforge.net
		>Cc:
		>Subject: Port BlueZ lib and utility on embedded uClinux
		>Hi, there:
		>
		>      I'm trying to port BlueZ on embedded uClinux. Kernel part seems =
ok so far.
		>
		>     For the HCI utility on user space part, I first have /hci-lib =
and /hcid
		>compiled to hcid. Then have /hci-lib and /hciconfig compiled to =
hciconfig.
		>Copy two applications, hcid and hciconfig, to ramdisk. Also I have =
hcid.conf
		>copied to ramdisk /etc/bluetooth/
		>
		>      After boot up, run hcid, then hciconfig hci0 up to bring up the =
device.
		>MAC address is read correctly. But when running hciconfig -a, it =
can't read local name correctly.
		>Are those steps correct? What do I miss?
		>
		>thanks a lot,
		>
		>Al
		>
		>--------------------------------------
		>If I rn hcid -n to see the printout:
		>
		>/>hcid -n
		>hcid[18]: Bluetooth HCI deamon
		>hcid[18]: Starting security manager 0
		>
		>---------------------------------------------------------------
		>/> hcid
		>/> hciconfig hci0 up
		>/> hciconfig -a
		>hci0:   Type: USB
		>         BD Address: 00:11:67:03:DB:62 ACL MTU: 678:8 SCO MTU: 48:10
		>         UP RUNNING PSCAN ISCAN
		>         RX bytes:323 acl:0 sco:0 events:9 errors:0
		>         TX bytes:33 acl:0 sco:0 commands:9 errors:0
		>         Features: 0xff 0xff 0x8d 0x78 0x08 0x18 0x00 0x00
		>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
		>         Link policy:
		>         Link mode: SLAVE ACCEPT
		>
		>
		>Can't read local name on hci0: Connection timed out (110)
		>pid 17: failed 256
		>/>
		=
>------------------------------------------------------------------------=
-------------------
		>
		>
		>
		>
		>
	=09

		><< winmail.dat >>=20

	=09

	------------------------------------------------------- SF.Net email is =
Sponsored by the Better Software Conference & EXPO September 19-22, 2005 =
* San Francisco, CA * Development Lifecycle Practices Agile & =
Plan-Driven Development * Managing Projects & Teams * Testing & QA =
Security * Process Improvement & Measurement * =
http://www.sqe.com/bsce5sf =
_______________________________________________ Bluez-users mailing list =
Bluez-users@lists.sourceforge.net =
https://lists.sourceforge.net/lists/listinfo/bluez-users=20


------_=_NextPart_001_01C5A45F.9E7B518A
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IgUBAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAAtgMAAAAAAAC5AAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEARQAAAFJFOiBbQmx1ZXotdXNlcnNd
IFJFOiBQb3J0IEJsdWVaIGxpYiBhbmQgdXRpbGl0eSBvbiBlbWJlZGRlZCB1Q2xpbnV4AO8XAQWA
AwAOAAAA1QcIABMACQAtAAMABQA1AQEggAMADgAAANUHCAATAAkALQADAAUANQEBCYABACEAAAA1
ODRFNkZDNkVDODA4MDQzQTdFOTExQjBFOUQ2NDJDMwA4BwEDkAYAZB4AADYAAAADADYAAAAAAEAA
OQCKUXueX6TFAR4APQABAAAABQAAAFJFOiAAAAAAAgFHAAEAAAAvAAAAYz11czthPSA7cD11bmlt
aXM7bD1ORVRCRTAxLTA1MDgxOTAxNDUwM1otMTI0MgAAHgBJAAEAAABFAAAAUkU6IFtCbHVlei11
c2Vyc10gUkU6IFBvcnQgQmx1ZVogbGliIGFuZCB1dGlsaXR5IG9uIGVtYmVkZGVkIHVDbGludXgA
AAAAQABOAIDQww8qpMUBHgBaAAEAAAAoAAAAYmx1ZXotdXNlcnMtYWRtaW5AbGlzdHMuc291cmNl
Zm9yZ2UubmV0AAIBWwABAAAAbQAAAAAAAACBKx+kvqMQGZ1uAN0BD1QCAAAAAGJsdWV6LXVzZXJz
LWFkbWluQGxpc3RzLnNvdXJjZWZvcmdlLm5ldABTTVRQAGJsdWV6LXVzZXJzLWFkbWluQGxpc3Rz
LnNvdXJjZWZvcmdlLm5ldAAAAAACAVwAAQAAAC0AAABTTVRQOkJMVUVaLVVTRVJTLUFETUlOQExJ
U1RTLlNPVVJDRUZPUkdFLk5FVAAAAAAeAF0AAQAAAAkAAABibG9va2sgLQAAAAACAV4AAQAAADkA
AAAAAAAAgSsfpL6jEBmdbgDdAQ9UAgAAAABibG9va2sgLQBTTVRQAGJsb29ra0Bob3RtYWlsLmNv
bQAAAAACAV8AAQAAABgAAABTTVRQOkJMT09LS0BIT1RNQUlMLkNPTQAeAGYAAQAAAAUAAABTTVRQ
AAAAAB4AZwABAAAAKAAAAGJsdWV6LXVzZXJzLWFkbWluQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAAe
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
AHUAdABpAGwAaQB0AHkAIABvAG4AIABlAG0AYgBlAGQAZABlAGQAIAB1AEMAbABpAG4AdQB4AC4A
RQBNAEwAAAAAAAsA9hAAAAAAQAAHMM4c+dVepMUBQAAIMDpkjp5fpMUBAwDeP7YDAAADAPE/BAQA
AB4A+D8BAAAAAwAAAEFsAAACAfk/AQAAAF0AAAAAAAAA3KdAyMBCEBq0uQgAKy/hggEAAAAAAAAA
L089VU5JTUlTL09VPUZJUlNUIEFETUlOSVNUUkFUSVZFIEdST1VQL0NOPVJFQ0lQSUVOVFMvQ049
QUwuSVNTQwAAAAAeAPo/AQAAABUAAABTeXN0ZW0gQWRtaW5pc3RyYXRvcgAAAAACAfs/AQAAAB4A
AAAAAAAA3KdAyMBCEBq0uQgAKy/hggEAAAAAAAAALgAAAAMA/T/kBAAAAwAZQAAAAAADABpAAAAA
AAMAHUAAAAAAAwAeQAAAAAAeADBAAQAAAAgAAABBTC5JU1NDAB4AMUABAAAACAAAAEFMLklTU0MA
HgAyQAEAAAAoAAAAYmx1ZXotdXNlcnMtYWRtaW5AbGlzdHMuc291cmNlZm9yZ2UubmV0AB4AM0AB
AAAAEwAAAGJsb29ra0Bob3RtYWlsLmNvbQAAHgA4QAEAAAAIAAAAQUwuSVNTQwAeADlAAQAAAAIA
AAAuAAAACwApAAAAAAALACMAAAAAAAMABhDd+Vs9AwAHEHkKAAADABAQAAAAAAMAERAAAAAAHgAI
EAEAAABlAAAASEksSE9XRElEWU9VR0VUTkFNRUZPUk9USEVSQkxVRVRPT1RIREVWSUNFVE9GSU5E
P0dJVkVUSEVOQU1FSU5DT0RFU0lOU1RFQURPRkZST00vRVRDL0JMVUVUT09USC9IQ0lEQwAAAAAC
AX8AAQAAADwAAAA8RTY0QkFENUE4QUQ0Njc0MDgyODA2OUE2NzhEOURENzMwMTFBQTFAbmV0YmUw
MS5uZXQudW5pbWlzPgByYQ==

------_=_NextPart_001_01C5A45F.9E7B518A--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
