Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] uinput and modules.conf
References: <200403160905.27291.cijoml@volny.cz> <1079426897.3307.64.camel@pegasus>
In-Reply-To: <1079426897.3307.64.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200403161337.13936.cijoml@volny.cz>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 16 Mar 2004 13:37:13 +0100

Hmm I have it and module is not autoloaded  :(

crw-r--r--    1 root     root      10, 223 led 11 23:22 /dev/input/uinput

I runs /opt/bluetooth/sbin/bthid -d in script, daemon starts but not auto=20
accepts my mouse which wants reconnect. Blue Led blinks on microsoft BT=20
dongle, but I have to call bthid -c and then mouse is connected.
How to instruct your bthid, Marcel, to auto accept my devices?

Second problem is follows:
My keyboard doesn't work:
Mar 16 13:30:06 notas bthid[740]: Connected: Microsoft Bluetooth keyboard=20
(045e:007b)
Mar 16 13:30:06 notas bthid[740]: Vendor HID usage 0xff00fe01 value 0x1
Mar 16 13:30:06 notas bthid[740]: adequate battery
Mar 16 13:30:06 notas bthid[740]: Vendor HID usage 0xff00fe03 value 0x0
Mar 16 13:30:06 notas bthid[740]: Vendor HID usage 0xff00fe04 value 0x0
Mar 16 13:30:06 notas bthid[740]: Unknown HID usage (0xff00fe04 + 0)

At first time it worked, then I switched off computer and wanted started it=
=20
again, but then bthid writes this into syslog.
I write on keyboard, but no reply is sent into console :(

hcidump but shows data when I writes on keyboard:
notas:/home/cijoml# hcidump
HCIDump - HCI packet analyzer ver 1.7
device: hci0 snap_len: 1028 filter: 0xffffffff
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> HCI Event: Mode Change(0x14) plen 6
> HCI Event: Mode Change(0x14) plen 6
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 0]
> ACL data: handle 0x0029 flags 0x02 dlen 14


Michal

Dne =FAt 16. b=F8ezna 2004 09:48 Marcel Holtmann napsal(a):
> Hi Michal,
>
> > what should I add to modules.conf to get uinput module autoload?
>
> 	alias char-major-10-223 uinput
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dcli=
ck
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
