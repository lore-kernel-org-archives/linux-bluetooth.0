Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] MS Optical Desktop for bluetooth - Stops working
	after a time
From: Marcel Holtmann <marcel@holtmann.org>
To: Daniel Scott <danieljamesscott@gmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <6835906b04091702575f479226@mail.gmail.com>
References: <6835906b04091701465c5e3c7c@mail.gmail.com>
	 <1095411684.3280.20.camel@pegasus>
	 <6835906b04091702575f479226@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1095415567.3280.35.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 17 Sep 2004 12:06:07 +0200

Hi Daniel,

> > show us the output of "hciconfig -a".
> > 
> 
> Here it is, I see there are quite a few errors, is this the problem?
> 
> hci0:   Type: USB
>         BD Address: 00:50:F2:E4:C2:F5 ACL MTU: 192:8  SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN
>         RX bytes:543843 acl:38475 sco:0 events:262 errors:0
>         TX bytes:4403 acl:176 sco:0 commands:36 errors:0
>         Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy:
>         Link mode: SLAVE ACCEPT
>         Name: 'SCOTTD'
>         Class: 0x000000
>         Service Classes: Unspecified
>         Device Class: Miscellaneous,
>         HCI Ver: 1.1 (0x1) HCI Rev: 0x1f9 LMP Ver: 1.1 (0x1) LMP Subver: 0x1f9
>         Manufacturer: Cambridge Silicon Radio (10)

the correct settings for the link policy are missing. A Bluetooth mouse
or keyboard needs at least role switch and sniff mode to work correctly.

# hciconfig hci0 lp
hci0:   Type: USB
        BD Address: 00:02:xx:xx:xx:xx ACL MTU: 384:8  SCO MTU: 64:8
        Link policy: RSWITCH HOLD SNIFF PARK 

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
