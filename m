Return-Path: <cyrus@holtmann.org>
Message-id: <442B171E16C14289B5160678267146C3@sisodomain.com>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
References: <20121128122318.GA30710@x220.ger.corp.intel.com>
 <1355918497-21944-1-git-send-email-tomasz.bursztyka@linux.intel.com>
 <CAMOw1v40+w62ToR4SKnNLnKfLzBSz_MKK1fXwoW66z7cXbTw4A@mail.gmail.com>
 <50D2C258.4000908@linux.intel.com>
In-reply-to: <50D2C258.4000908@linux.intel.com>
Subject: Authentication issue during connection if remote deletes link key
Date: Thu, 20 Dec 2012 20:18:26 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=response
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I am facing one issue with authentication during profile connection.
Two devices are there A and B which are paired.
>From B I deleted the pairing of A.
Now from A I initiated a file transfer to B which failed during 
authentication
since remote link key is not there.
Please see the hcidump logs.
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 12
< ACL data: handle 12 flags 0x00 dlen 12
    L2CAP(s): Disconn req: dcid 0x0046 scid 0x0040
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr BC:85:1F:74:7F:29
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr BC:85:1F:74:7F:29 key 0E7B8C5C01CBF6CA7FF08050591C21BB
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr BC:85:1F:74:7F:29
> ACL data: handle 12 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0046 scid 0x0040
> HCI Event: Auth Complete (0x06) plen 3
    status 0x06 handle 12
    Error: PIN or Key Missing

But the same scenario with legacy pairing it is working fine. Pin code 
request is coming
from the controller.
< HCI Command: Authentication Requested (0x01|0x0011) plen 2
    handle 11
< ACL data: handle 11 flags 0x00 dlen 12
    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
> HCI Event: Command Status (0x0f) plen 4
    Authentication Requested (0x01|0x0011) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:80:98:E7:34:07
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:80:98:E7:34:07 key 0E174763D381917A5AF973E22C49A3FE
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:80:98:E7:34:07
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:80:98:E7:34:07
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 11 packets 1
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
    bdaddr 00:80:98:E7:34:07 len 1 pin '0'
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Reply (0x01|0x000d) ncmd 1
    status 0x00 bdaddr 00:80:98:E7:34:07
> HCI Event: Link Key Notification (0x18) plen 23
    bdaddr 00:80:98:E7:34:07 key 573CC496BB0C02EE461B4A18C2D758C0 type 0
    Type: Combination Key
> HCI Event: Auth Complete (0x06) plen 3
    status 0x00 handle 11


Is it controller issue or BlueZ has to take care this?
Please let me know your opinion.

Thanks,
Jaganath
 

