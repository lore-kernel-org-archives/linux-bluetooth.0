Return-Path: <maxk@qualcomm.com>
Message-Id: <5.1.0.14.2.20030722165832.098360c8@unixmail.qualcomm.com>
Date: Tue, 22 Jul 2003 17:07:29 -0700
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] Problem with security mode 3
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1057279722.27638.1.camel@pegasus>
References: <5.1.0.14.2.20030703173538.063183a8@unixmail.qualcomm.com>
	<5.1.0.14.2.20030703173538.063183a8@unixmail.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

At 05:48 PM 7/3/2003, Marcel Holtmann wrote:
>Hi Max,
>
>> >there is a little problem with local devices in security mode 3
>> >(hciconfig hci0 auth). If you have already paired two devices, but you
>> >have used your dongle within another OS and paired it again to the same
>> >remote device. The local link key stored by the hcid is outdated. But
>> >this can not be known by the hcid and so it sends it on the next
>> >connection request. The remote device will deny the connection because
>> >of the wrong link key, but the error you get is not an authentication
>> >failure. You get the timeout error from the L2CAP layer.
>> >
>> >        < HCI Command: Write Authentication Enable(0x03|0x0020) plen 1
>> >          01 
>> >        > HCI Event: Command Complete(0x0e) plen 4
>> >          01 20 0C 00 
>> >        < HCI Command: Create Connection(0x01|0x0005) plen 13
>> >          FD 06 81 0E 04 00 18 CC 01 00 00 00 01 
>> >        > HCI Event: Command Status(0x0f) plen 4
>> >          00 01 05 04 
>> >        > HCI Event: Link Key Request(0x17) plen 6
>> >          FD 06 81 0E 04 00 
>> >        < HCI Command: Link Key Request Reply(0x01|0x000b) plen 22
>> >          FD 06 81 0E 04 00 38 06 D7 5D E2 DD FD 10 88 EF 5A 65 66 C2 
>> >          80 26 
>> >        > HCI Event: Connect Complete(0x03) plen 11
>> >          05 00 00 FD 06 81 0E 04 00 01 00 
>> >
>> >I have looked at hci_conn_complete_evt() and l2cap_connect_cfm() and the
>> >code seems correct to me.
>> >
>> >If you try to connect again after the timeout, you will get a "Operation
>> >already in progress" error.
>> >
>> >Where is the problem?
>> Did you pull all of my latest fixes ? That bug was introduced by 
>> SO_LINGER patch (bt_sock_wait_state() to be more specific). I fixed it 
>> some time ago (should be in -pre2). The bug is unrelated to security 
>> and stuff and affects connect in general (ie it'd timeout instead of an error).
>
>it is still present in 2.4.22-pre2 :(

I can't reproduce that. I just did like you said paired two device, saved link_key file,
repaired them and restored old link_key file. So my laptop that is running latest and greatest
2.4.BK has old key now. I even got exactly the same hcidump traces.

< HCI Command: Write Authentication Enable(0x03|0x0020) plen 1
  01 

[root@champ bluetooth]# l2ping 00:04:23:00:3D:06
Can't connect.: Permission denied

> HCI Event: Command Complete(0x0e) plen 4
  01 20 0C 00 
< HCI Command: Create Connection(0x01|0x0005) plen 13
  06 3D 00 23 04 00 18 CC 01 00 00 00 01 
> HCI Event: Command Status(0x0f) plen 4
  00 01 05 04 
> HCI Event: Link Key Request(0x17) plen 6
  06 3D 00 23 04 00 
< HCI Command: Link Key Request Reply(0x01|0x000b) plen 22
  06 3D 00 23 04 00 EC 91 7B 09 2F C9 17 F6 0D A4 1F 51 99 D7 
  98 7E 
> HCI Event: Command Complete(0x0e) plen 10
  01 0B 04 00 06 3D 00 23 04 00 
> HCI Event: Connect Complete(0x03) plen 11
  05 28 00 06 3D 00 23 04 00 01 00 

[root@champ utils]# sdptool browse 00:04:23:00:3D:06
Failed to connect to SDP server on 00:04:23:00:3D:06: Permission denied

< HCI Command: Create Connection(0x01|0x0005) plen 13
  06 3D 00 23 04 00 18 CC 01 00 00 00 01 
> HCI Event: Command Status(0x0f) plen 4
  00 01 05 04 
> HCI Event: Link Key Request(0x17) plen 6
  06 3D 00 23 04 00 
< HCI Command: Link Key Request Reply(0x01|0x000b) plen 22
  06 3D 00 23 04 00 EC 91 7B 09 2F C9 17 F6 0D A4 1F 51 99 D7 
  98 7E 
> HCI Event: Command Complete(0x0e) plen 10
  01 0B 04 00 06 3D 00 23 04 00 
> HCI Event: Connect Complete(0x03) plen 11
  05 28 00 06 3D 00 23 04 00 01 00 

As you see I get correct error and no timeouts. If I remove link_key from 
laptop I can pair again and everything works fine.

Max
