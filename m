Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 26 Jul 2012 15:49:48 +0800
Message-ID: <CADX0rsbmzFwwPu4VteS+0m7oqow4-rY0P1O33GgaFrQZc4YTAg@mail.gmail.com>
Subject: After pairing, get "Link Key Request Negative Reply"
From: victor yeo <victoryeo1974@gmail.com>
To: victor yeo <victoryeo1974@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I have a device with address 00:09:1F:80:12:21, i can pair the device
to Bluez, the linkkeys file contains:

# cat /var/lib/bluetooth/00\:07\:80\:56\:F8\:70/linkkeys
00:09:1F:80:12:21    41F80F349B12603669616D178B0F5974 4 0

from hcidump, the "Link Key Request Negative Reply" is received, then
"Unauthenticated Combination Key" is received, then  "Connection
refused - security block" is received.

Is this a Bluez or device problem?  There is a "Fix l2cap conn
failures for ssp devices", is it related?

Thanks,
Victor


------------------------------- hcidump log
-------------------------------------------
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 43
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:09:1F:80:12:21
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
    bdaddr 00:09:1F:80:12:21
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Negative Reply (0x01|0x000c) ncmd 1
    status 0x00 bdaddr 00:09:1F:80:12:21
......
> HCI Event: User Confirmation Request (0x33) plen 10
    bdaddr 00:09:1F:80:12:21 passkey 912806
< HCI Command: User Confirmation Request Reply (0x01|0x002c) plen 6
    bdaddr 00:09:1F:80:12:21
> HCI Event: Command Complete (0x0e) plen 10
    User Confirmation Request Reply (0x01|0x002c) ncmd 1
    status 0x00 bdaddr 00:09:1F:80:12:21
> HCI Event: Simple Pairing Complete (0x36) plen 7
    status 0x00 bdaddr 00:09:1F:80:12:21
> HCI Event: Link Key Notification (0x18) plen 23
    bdaddr 00:09:1F:80:12:21 key F8BA145BCB649DCA8948D3110D6A19D6 type 4
    Type: Unauthenticated Combination Key
> HCI Event: Auth Complete (0x06) plen 3
    status 0x00 handle 43
.....
< ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 43 packets 1
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
> ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
.......
> ACL data: handle 43 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 4097 scid 0x0041
< ACL data: handle 43 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0041 result 3 status 0
      Connection refused - security block
