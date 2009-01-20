Return-Path: <cyrus@holtmann.org>
Subject: Re: HID control channel req issue
From: Marcel Holtmann <marcel@holtmann.org>
To: sushil <skdeka@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <92aeef200901192230r33a7afa9pb3db7a816a915d0e@mail.gmail.com>
References: <92aeef200901192230r33a7afa9pb3db7a816a915d0e@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 20 Jan 2009 10:28:57 +0100
Message-Id: <1232443737.4655.0.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> In HID Host initiated connection to HID device, Host is sending L2CAP
> control channel request message twice to the device. The hcidump logs
> are as follows
> 
> 
> < ACL data: handle 47 flags 0x02 dlen 12
> 
>     L2CAP(s): Connect req: psm 17 scid 0x0040
> 
> > HCI Event: Number of Completed Packets (0x13) plen 5
> 
>     handle 47 packets 1
> 
> > ACL data: handle 47 flags 0x02 dlen 16
> 
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 0
> 
>       Connection pending - No futher information available
> 
> 
> 
> > HCI Event: Link Key Request (0x17) plen 6
> 
>     bdaddr 00:02:5B:02:97:6E
> 
> < HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
> 
>     bdaddr 00:02:5B:02:97:6E
> 
> > HCI Event: Command Complete (0x0e) plen 10
> 
>     Link Key Request Negative Reply (0x01|0x000c) ncmd 1
> 
>     status 0x00 bdaddr 00:02:5B:02:97:6E
> 
> 
> > HCI Event: PIN Code Request (0x16) plen 6
> 
>     bdaddr 00:02:5B:02:97:6E
> 
> < HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
> 
>     bdaddr 00:02:5B:02:97:6E len 4 pin '0000'
> 
> > HCI Event: Command Complete (0x0e) plen 10
> 
>     PIN Code Request Reply (0x01|0x000d) ncmd 1
> 
>     status 0x00 bdaddr 00:02:5B:02:97:6E
> 
> > HCI Event: Link Key Notification (0x18) plen 23
> 
>     bdaddr 00:02:5B:02:97:6E key B00AC8478BC923A0E1B269C5BB510584 type 0
> 
>     Type: Combination Key
> 
> > HCI Event: Encrypt Change (0x08) plen 4
> 
>     status 0x00 handle 47 encrypt 0x01
> 
> 
> < ACL data: handle 47 flags 0x02 dlen 12
> 
>     L2CAP(s): Connect req: psm 17 scid 0x0040
> 
> > ACL data: handle 47 flags 0x02 dlen 16
> 
>     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
> 
>       Connection successful
> 
> < ACL data: handle 47 flags 0x02 dlen 12
> 
>     L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> 
> > HCI Event: Number of Completed Packets (0x13) plen 5
> 
>     handle 47 packets 1
> 
> 
> After looking into the code, in l2cap.c function l2cap_encrypt_cfm()
> 
> If state is BT_CONNECT and status is 0, host again sends the second
> L2cap_conn_req for control channel.
> 
> 
> I am not sure even if encrypt== 0x01, bluez needs to send the second
> L2cap_connect_req for control channel.

no it does not. And I have never seen this behaviour. What kernel
version is this? Can you try my bluetooth-testing.git tree which is
against 2.6.29-rc2. It includes changes in that area.

Regards

Marcel


