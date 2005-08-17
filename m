Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5A300.00000484"
Message-ID: <E64BAD5A8AD46740828069A678D9DD73011A94@netbe01.net.unimis>
From: "Al" <Al_chane@issc.com.tw>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Port BlueZ lib and utility on embedded uClinux
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
Date: Wed, 17 Aug 2005 15:48:04 +0800

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5A300.00000484
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

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


------_=_NextPart_001_01C5A300.00000484
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IgUHAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAAtgMAAAAAAAC5AAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEALwAAAFBvcnQgQmx1ZVogbGliIGFu
ZCB1dGlsaXR5IG9uIGVtYmVkZGVkIHVDbGludXgA1BABBYADAA4AAADVBwgAEQAPADAABAADADsB
ASCAAwAOAAAA1QcIABEADwAwAAQAAwA7AQEJgAEAIQAAAEJENkNFOEI4QUE0QTY0NEE4MUNDQzlG
NUIzNDRGNDcwAHAHAQOQBgD8EgAANgAAAAMANgAAAAAAQAA5AIQEAAAAo8UBHgA9AAEAAAABAAAA
AAAAAAIBRwABAAAALwAAAGM9dXM7YT0gO3A9dW5pbWlzO2w9TkVUQkUwMS0wNTA4MTcwNzQ4MDRa
LTExNjgAAB4ASQABAAAAKAAAAFJlOiBbQmx1ZXotdXNlcnNdIElTU0MgVVNCIGRvbmdsZSBwYXRj
aABAAE4AAEAjVgl7xQEeAFoAAQAAACgAAABibHVlei11c2Vycy1hZG1pbkBsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQAAgFbAAEAAABtAAAAAAAAAIErH6S+oxAZnW4A3QEPVAIAAAAAYmx1ZXotdXNlcnMt
YWRtaW5AbGlzdHMuc291cmNlZm9yZ2UubmV0AFNNVFAAYmx1ZXotdXNlcnMtYWRtaW5AbGlzdHMu
c291cmNlZm9yZ2UubmV0AAAAAAIBXAABAAAALQAAAFNNVFA6QkxVRVotVVNFUlMtQURNSU5ATElT
VFMuU09VUkNFRk9SR0UuTkVUAAAAAB4AXQABAAAAEAAAAE1hcmNlbCBIb2x0bWFubgACAV4AAQAA
AEEAAAAAAAAAgSsfpL6jEBmdbgDdAQ9UAgAAAABNYXJjZWwgSG9sdG1hbm4AU01UUABtYXJjZWxA
aG9sdG1hbm4ub3JnAAAAAAIBXwABAAAAGQAAAFNNVFA6TUFSQ0VMQEhPTFRNQU5OLk9SRwAAAAAe
AGYAAQAAAAUAAABTTVRQAAAAAB4AZwABAAAAKAAAAGJsdWV6LXVzZXJzLWFkbWluQGxpc3RzLnNv
dXJjZWZvcmdlLm5ldAAeAGgAAQAAAAUAAABTTVRQAAAAAB4AaQABAAAAFAAAAG1hcmNlbEBob2x0
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
Uk9VUC9DTj1SRUNJUElFTlRTL0NOPUFMLklTU0MAAAAAHgD6PwEAAAAVAAAAU3lzdGVtIEFkbWlu
aXN0cmF0b3IAAAAAAgH7PwEAAAAeAAAAAAAAANynQMjAQhAatLkIACsv4YIBAAAAAAAAAC4AAAAD
AP0/tgMAAAMAGUAAAAAAAwAaQAAAAAADAB1AAAAAAAMAHkAAAAAAHgAwQAEAAAAIAAAAQUwuSVNT
QwAeADFAAQAAAAgAAABBTC5JU1NDAB4AMkABAAAAKAAAAGJsdWV6LXVzZXJzLWFkbWluQGxpc3Rz
LnNvdXJjZWZvcmdlLm5ldAAeADNAAQAAABQAAABtYXJjZWxAaG9sdG1hbm4ub3JnAB4AOEABAAAA
CAAAAEFMLklTU0MAHgA5QAEAAAACAAAALgAAAAsAKQAAAAAACwAjAAAAAAADAAYQFs9mWgMABxBV
BAAAAwAQEAAAAAADABEQAAAAAB4ACBABAAAAZQAAAEhJLFRIRVJFOklNVFJZSU5HVE9QT1JUQkxV
RVpPTkVNQkVEREVEVUNMSU5VWEtFUk5FTFBBUlRTRUVNU09LU09GQVJGT1JUSEVIQ0lVVElMSVRZ
T05VU0VSU1BBQ0VQQVJULEkAAAAAAgF/AAEAAAA8AAAAPEU2NEJBRDVBOEFENDY3NDA4MjgwNjlB
Njc4RDlERDczMDExQTk0QG5ldGJlMDEubmV0LnVuaW1pcz4AAQg=

------_=_NextPart_001_01C5A300.00000484--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
