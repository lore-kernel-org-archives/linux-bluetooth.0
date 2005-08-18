Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Message-ID: <E64BAD5A8AD46740828069A678D9DD73011A9F@netbe01.net.unimis>
From: "Al" <Al_chane@issc.com.tw>
To: <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Re: compiling hciconfig for ARM
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
Date: Thu, 18 Aug 2005 23:25:52 +0800

Hi,

     I found this email from last Dec. I have the similiar problem.
=20
     I'm trying to port BlueZ on embedded uClinux. Kernel part seems ok =
so far.

    For the HCI utility on user space part, I first have /hci-lib and =
/hcid
compiled to hcid. Then have /hci-lib and /hciconfig compiled to =
hciconfig.
Copy two applications, hcid and hciconfig, to ramdisk. Also I have =
hcid.conf
copied to ramdisk /etc/bluetooth/

     After boot up, run hcid, then hciconfig hci0 up to bring up the =
device.
MAC address is read correctly. But when running hciconfig -a, it can't =
read local name correctly.
Are those steps correct? What do I miss?

--------------------------------------
If I rn hcid -n to see the printout:

/>hcid -n
hcid[18]: Bluetooth HCI deamon
hcid[18]: Starting security manager 0

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
   The poll() always returns error :

     while ((n =3D poll(&p, 1, to)) < 0) in funcion int hci_send_req () =
(file: hci.c) results in "Can't read local name on hci0: Connection =
timed out (110)"

Best Regards,

Al

=20


   =20
> I have compiled the Bluez Utils and Libs 2.11 for a ARM platform,
> concretly for the CPU ARM7TDMI.
> I have done the compilation with uClibc-0.9.19 and in "hciconfig" tool
> I have a problem when I make"hciconfig -a" or "hciconfig hci0 name" or
> "hciconfig hci0 class" and other.
> All this problems occurs in file "hci.c", in function "int
> hci_send_req(int dd, struct hci_request *r, int to)".
> In this function when the program execute "n =3D poll(&p, 1, to)" I
> obtain a kernel panic like this (executing hciconfig -a):
=20



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
