Return-Path: <jeffs@fairwayacademy.org>
From: Jeff Sutherland <jeffs@fairwayacademy.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] Timeout message from kernel
Date: Fri, 13 Feb 2004 18:19:10 -0500
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
References: <200402121636.02074.jeffs@fairwayacademy.org> <200402131023.03974.jeffs@fairwayacademy.org> <1076686120.2671.83.camel@pegasus>
In-Reply-To: <1076686120.2671.83.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200402131819.10939.jeffs@fairwayacademy.org>
List-ID: <bluez-users.lists.sourceforge.net>

On Friday 13 February 2004 10:28, Marcel Holtmann wrote:
> Hi Jeff,
> why don't you try what I have written? And read what "l2test -h" says.

Ok, Doh, heat of battle kind of thing, just been working on it too long.  
Making ColdFire the l2test listener seems to work ok:
/> l2test -r
l2test[25]: Waiting for connection on psm 10 ...
l2test[25]: Connect from 00:0A:4F:00:09:5E [imtu 672, omtu 672, flush_to 
65535]
                                                                                
l2test[25]: Receiving ...
l2test[25]: 672 bytes in 0.04 sec, 17.70 kB/s
l2test[25]: 672 bytes in 0.01 sec, 50.86 kB/s
l2test[25]: 672 bytes in 0.03 sec, 20.72 kB/s

and so on and so forth.  Making ColdFire the sender however produces this 
output on the pc side:

[root@Arwen test]# ./l2test -r
l2test[30292]: Waiting for connection on psm 10 ...
l2test[30293]: Connect from 00:0A:4F:00:13:5F [imtu 672, omtu 672, flush_to 
65535]
l2test[30293]: Receiving ...
l2test[30293]: 672 bytes in 0.06 sec, 11.28 kB/s
l2test[30293]: seq missmatch: 1 -> 4
l2test[30293]: 672 bytes in 0.09 sec, 7.70 kB/s
l2test[30293]: seq missmatch: 5 -> 8
l2test[30293]: 672 bytes in 0.08 sec, 8.21 kB/s
l2test[30293]: seq missmatch: 9 -> 12
etc., etc.

> Maybe this is a role switch problem. Show us both outputs from
> "hciconfig -a".

ColdFire:
/> hciconfig -a
hci0:   Type: UART
        BD Address: 00:0A:4F:00:13:5F ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:306 acl:0 sco:0 events:14 errors:0
        TX bytes:513 acl:0 sco:0 commands:12 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1) LMP Subver: 0x175
        Manufacturer: Cambridge Silicon Radio (10)

PC:
[root@Arwen test]# hciconfig -a
hci0:   Type: USB
        BD Address: 00:0A:4F:00:09:5E ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:1887092 acl:3025 sco:29743 events:1513 errors:0
        TX bytes:309425 acl:1448 sco:1709 commands:109 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d
        Manufacturer: Cambridge Silicon Radio (10)

Other than that sequence problem it looks like the link mostly works, still 
issues with most of the commands of hcitool though, on Coldfire.

Thanks,
-Jeff
-- 
Secure your email with Gnu Privacy Guard and Mozilla, the open source
cross platform solution for Windows, Linux, and Mac OS X.
See http://enigmail.mozdev.org/
