Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5A3BF.F52EA48C"
Message-ID: <E64BAD5A8AD46740828069A678D9DD73011A99@netbe01.net.unimis>
From: "Al" <Al_chane@issc.com.tw>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] RE: Port BlueZ lib and utility on embedded uClinux
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
Date: Thu, 18 Aug 2005 14:42:09 +0800

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5A3BF.F52EA48C
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable


Hi,

     The poll() always return error :

     while ((n =3D poll(&p, 1, to)) < 0) in funcion int hci_send_req () =
(file: hci.c) results in "Can't read local name on hci0: Connection =
timed out (110)"

     Has anyone had same problem using poll() in embedded linux?

thanks a lot,

Al
-----Original Message-----
From:	Al on behalf of Al
Sent:	Wed 8/17/2005 3:48 PM
To:	bluez-users@lists.sourceforge.net
Cc:=09
Subject:	Port BlueZ lib and utility on embedded uClinux
Hi, there:
=20
     I'm trying to port BlueZ on embedded uClinux. Kernel part seems ok =
so far.
=20
    For the HCI utility on user space part, I first have /hci-lib and =
/hcid=20
compiled to hcid. Then have /hci-lib and /hciconfig compiled to =
hciconfig.
Copy two applications, hcid and hciconfig, to ramdisk. Also I have =
hcid.conf
copied to ramdisk /etc/bluetooth/
=20
     After boot up, run hcid, then hciconfig hci0 up to bring up the =
device.
MAC address is read correctly. But when running hciconfig -a, it can't =
read local name correctly.
Are those steps correct? What do I miss?
=20
thanks a lot,
=20
Al
=20
--------------------------------------
If I rn hcid -n to see the printout:
=20
/>hcid -n
hcid[18]: Bluetooth HCI deamon
hcid[18]: Starting security manager 0
=20
---------------------------------------------------------------
/> hcid
/> hciconfig hci0 up
/> hciconfig -a
hci0:   Type: USB
        BD Address: 00:11:67:03:DB:62 ACL MTU: 678:8 SCO MTU: 48:10
        UP RUNNING PSCAN ISCAN
        RX bytes:323 acl:0 sco:0 events:9 errors:0
        TX bytes:33 acl:0 sco:0 commands:9 errors:0
        Features: 0xff 0xff 0x8d 0x78 0x08 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT


Can't read local name on hci0: Connection timed out (110)
pid 17: failed 256
/>
-------------------------------------------------------------------------=
------------------

=20




------_=_NextPart_001_01C5A3BF.F52EA48C
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

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
A7+jxQFAAAgwOpA69b+jxQEDAN4/5AQAAAMA8T8JBAAAHgD4PwEAAAADAAAAQWwAAAIB+T8BAAAA
XQAAAAAAAADcp0DIwEIQGrS5CAArL+GCAQAAAAAAAAAvTz1VTklNSVMvT1U9RklSU1QgQURNSU5J
U1RSQVRJVkUgR1JPVVAvQ049UkVDSVBJRU5UUy9DTj1BTC5JU1NDAAAAAB4A+j8BAAAAFQAAAFN5
c3RlbSBBZG1pbmlzdHJhdG9yAAAAAAIB+z8BAAAAHgAAAAAAAADcp0DIwEIQGrS5CAArL+GCAQAA
AAAAAAAuAAAAAwD9P7YDAAADABlAAAAAAAMAGkAAAAAAAwAdQAAAAAADAB5AAAAAAB4AMEABAAAA
CAAAAEFMLklTU0MAHgAxQAEAAAAIAAAAQUwuSVNTQwAeADJAAQAAACgAAABibHVlei11c2Vycy1h
ZG1pbkBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAHgAzQAEAAAAVAAAAQWxfY2hhbmVAaXNzYy5jb20u
dHcAAAAAHgA4QAEAAAAIAAAAQUwuSVNTQwAeADlAAQAAAAIAAAAuAAAACwApAAAAAAALACMAAAAA
AAMABhA8j30qAwAHEMAFAAADABAQAAAAAAMAERAAAAAAHgAIEAEAAABlAAAASEksVEhFUE9MTCgp
QUxXQVlTUkVUVVJORVJST1I6V0hJTEUoKE49UE9MTCgmUCwxLFRPKSk8MClJTkZVTkNJT05JTlRI
Q0lTRU5EUkVRKCkoRklMRTpIQ0lDKVJFU1VMVFNJTgAAAAACAX8AAQAAADwAAAA8RTY0QkFENUE4
QUQ0Njc0MDgyODA2OUE2NzhEOURENzMwMTFBOTlAbmV0YmUwMS5uZXQudW5pbWlzPgDEbg==

------_=_NextPart_001_01C5A3BF.F52EA48C--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
