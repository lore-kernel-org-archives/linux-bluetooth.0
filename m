Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <7aa80ced0502230435a0590fa@mail.gmail.com>
From: Mohan K <kmohangda@gmail.com>
To: bluez-users@lists.sourceforge.net, sebastian.roth@esk.fhg.de
Subject: Re: [Bluez-users] Re: Can't able to send data in both direction
In-Reply-To: <cvhrtb$kn9$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <7aa80ced0502222239dd01830@mail.gmail.com>
	 <cvh9lh$2b0$1@sea.gmane.org>
	 <7aa80ced05022223273b5bba4c@mail.gmail.com>
	 <cvhkqf$2b0$2@sea.gmane.org>
	 <7aa80ced0502230228296ac5e7@mail.gmail.com>
	 <cvhrtb$kn9$1@sea.gmane.org>
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
Date: Wed, 23 Feb 2005 18:05:08 +0530

Hi Sebastian,
                   Yes. hciconfig -a is showing up. The following is
the result I am getting for  hciconfig -a. I can't move forward from
this problem.

SiW Dongle:
[root@localhost ~]# hciconfig -a
hci0:   Type: USB
        BD Address: 00:0B:0D:33:DA:F9 ACL MTU: 120:20  SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:1679 acl:42 sco:0 events:98 errors:0
        TX bytes:723 acl:30 sco:0 commands:29 errors:0
        Features: 0xff 0xff 0x05 0x38 0x18 0x18 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: ''
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.2 (0x2) HCI Rev: 0x0 LMP Ver: 1.2 (0x2) LMP Subver: 0x757
        Manufacturer: Silicon Wave (11)

CSR dongle:
[root@localhost root]# hciconfig -a
hci0:   Type: USB
        BD Address: 01:5A:4B:20:07:DB ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:273 acl:5 sco:0 events:24 errors:0
        TX bytes:175 acl:6 sco:0 commands:11 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.1 (0x1) HCI Rev: 0x110 LMP Ver: 1.1 (0x1) LMP Subver: 0x110
        Manufacturer: Cambridge Silicon Radio (10)

Regards
Mohan


On Wed, 23 Feb 2005 13:15:07 +0100, Sebastian Roth
<sebastian.roth@esk.fhg.de> wrote:
> Hi,
> 
> I compiled and tested your applications. Had the (exact) same problem
> when tried to send from a SiW dongle to one with CSR chip. But...
> This was because I forgot to starup the interface. What does
> `hciconfig -a' for the SiW dongle show? Is it up?
> 
> Best regards,
> Sebastian
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
