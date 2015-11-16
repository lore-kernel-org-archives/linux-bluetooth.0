Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Nov 2015 10:57:02 +0530
Message-ID: <CAKafyqpqOgSueeyqDWPWeyaF11+WxbU28vAHdOp+yfE=Zz3gwg@mail.gmail.com>
Subject: HoG Disconnection=> Reason: Connection Time out
From: Prabhu Chawandi <foss.chaws@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

    When connecting a bonded HoG device, I am seeing the connection
unsuccessful.

When I saw hcidump, pasted comlete hcidump below. Please let me know
what is the reason.

> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 75 reason 0x08
    Reason: Connection Timeout

-------------------------Complete hci dump -------

> HCI Event: LE Meta Event (0x3e) plen 26
    LE Advertising Report
      SCAN_RSP - Scan Response (4)
      bdaddr 22:55:5B:00:15:10 (Public)
      TX power level: 254
      Complete local name: 'RCU-NBX08'
      RSSI: -76
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Enable (0x08|0x000c) ncmd 1
    status 0x00
< HCI Command: LE Create Connection (0x08|0x000d) plen 25
    bdaddr 22:55:5B:00:15:10 type 0
    interval 96 window 48 initiator_filter 0
    own_bdaddr_type 0 min_interval 40 max_interval 56
    latency 0 supervision_to 42 min_ce 0 max_ce 0
> HCI Event: Command Status (0x0f) plen 4
    LE Create Connection (0x08|0x000d) status 0x00 ncmd 1
> HCI Event: LE Meta Event (0x3e) plen 19
    LE Connection Complete
      status 0x00 handle 75, role master
      bdaddr 22:55:5B:00:15:10 (Public)
< HCI Command: LE Start Encryption (0x08|0x0019) plen 28
> HCI Event: Command Status (0x0f) plen 4
    LE Start Encryption (0x08|0x0019) status 0x00 ncmd 1
> ACL data: handle 75 flags 0x02 dlen 6
    SMP: Security Request (0x0b)
      auth req 0x01
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 75 encrypt 0x01
< ACL data: handle 75 flags 0x00 dlen 11
    ATT: Read By Group req (0x10)
      start 0x0001, end 0xffff
      type-uuid 0x2800
> ACL data: handle 75 flags 0x02 dlen 8
    ATT: Handle notify (0x1b)
      handle 0x0042
      value 0x00
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 75 packets 1
> ACL data: handle 75 flags 0x02 dlen 8
    ATT: Handle notify (0x1b)
      handle 0x0042
      value 0x00
> ACL data: handle 75 flags 0x02 dlen 24
    ATT: Read By Group resp (0x11)
      attr handle 0x0001, end group handle 0x0001
      value 0x01 0x18
      attr handle 0x0002, end group handle 0x0008
      value 0x00 0x18
      attr handle 0x0009, end group handle 0x0038
      value 0x12 0x18
< ACL data: handle 75 flags 0x00 dlen 11
    ATT: Read By Group req (0x10)
      start 0x0039, end 0xffff
      type-uuid 0x2800
> ACL data: handle 75 flags 0x02 dlen 24
    ATT: Read By Group resp (0x11)
      attr handle 0x0039, end group handle 0x003d
      value 0x0f 0x18
      attr handle 0x003e, end group handle 0x0043
      value 0x13 0x18
      attr handle 0x0044, end group handle 0x0048
      value 0x1e 0x18
< ACL data: handle 75 flags 0x00 dlen 11
    ATT: Read By Group req (0x10)
      start 0x0049, end 0xffff
      type-uuid 0x2800
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 75 packets 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 75 packets 1
> ACL data: handle 75 flags 0x02 dlen 12
    ATT: Read By Group resp (0x11)
      attr handle 0x0049, end group handle 0xffff
      value 0x0a 0x18
< ACL data: handle 75 flags 0x00 dlen 11
    ATT: Read By Type req (0x08)
      start 0x0009, end 0x0038
      type-uuid 0x2803
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 75 reason 0x08
    Reason: Connection Timeout
-----------------------------------------------------------------------

Many Thanks,
Prabhu Chawandi
