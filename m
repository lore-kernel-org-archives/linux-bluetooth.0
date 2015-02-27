Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Fix collision in AVCTP connection
Date: Fri, 27 Feb 2015 09:01:11 +0100
Message-Id: <1425024072-6259-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some headsets try connect AVCTP during our outgoing AVCTP connection. In effect
both connections are rejected, and session is closed. Daemon logs:

localhost.localdomain bluetoothd[11189]: Control: Refusing unexpected connect
localhost.localdomain bluetoothd[11189]: connect error: Connection refused (111)

In BTSNOOP:

< ACL Data TX: Handle 256 flags 0x00 dlen 12
      L2CAP: Connection Request (0x02) ident 11 len 4
        PSM: 23 (0x0017)
        Source CID: 68
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 16
      L2CAP: Connection Response (0x03) ident 11 len 8
        Destination CID: 69
        Source CID: 68
        Result: Connection pending (0x0001)
        Status: Authorization pending (0x0002)
< ACL Data TX: Handle 256 flags 0x00 dlen 12
      L2CAP: Disconnection Request (0x06) ident 12 len 4
        Destination CID: 64
        Source CID: 64
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 12
      L2CAP: Disconnection Response (0x07) ident 12 len 4
        Destination CID: 64
        Source CID: 64
> ACL Data RX: Handle 256 flags 0x02 dlen 12
      L2CAP: Connection Request (0x02) ident 9 len 4
        PSM: 23 (0x0017)
        Source CID: 70
< ACL Data TX: Handle 256 flags 0x00 dlen 16
      L2CAP: Connection Response (0x03) ident 9 len 8
        Destination CID: 64
        Source CID: 70
        Result: Connection pending (0x0001)
        Status: Authorization pending (0x0002)
< ACL Data TX: Handle 256 flags 0x00 dlen 16
      L2CAP: Connection Response (0x03) ident 9 len 8
        Destination CID: 64
        Source CID: 70
        Result: Connection refused - security block (0x0003)
        Status: No further information available (0x0000)
> ACL Data RX: Handle 256 flags 0x02 dlen 16
      L2CAP: Connection Response (0x03) ident 11 len 8
        Destination CID: 0
        Source CID: 68
        Result: Connection refused - no resources available (0x0004)
        Status: No further information available (0x0000)

With provided fix, we accept incoming connection and close outgoing connection.
If accepting won't succeed, we try reconnect as initiator. Btsnoop after fix:

< ACL Data TX: Handle 256 flags 0x00 dlen 12
      L2CAP: Connection Request (0x02) ident 11 len 4
        PSM: 23 (0x0017)
        Source CID: 67
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 16
      L2CAP: Connection Response (0x03) ident 11 len 8
        Destination CID: 87
        Source CID: 67
        Result: Connection pending (0x0001)
        Status: Authorization pending (0x0002)
> ACL Data RX: Handle 256 flags 0x02 dlen 12
      L2CAP: Connection Request (0x02) ident 5 len 4
        PSM: 23 (0x0017)
        Source CID: 88
< ACL Data TX: Handle 256 flags 0x00 dlen 16
      L2CAP: Connection Response (0x03) ident 5 len 8
        Destination CID: 68
        Source CID: 88
        Result: Connection pending (0x0001)
        Status: Authorization pending (0x0002)
< ACL Data TX: Handle 256 flags 0x00 dlen 16
      L2CAP: Connection Response (0x03) ident 5 len 8
        Destination CID: 68
        Source CID: 88
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)
< ACL Data TX: Handle 256 flags 0x00 dlen 12
      L2CAP: Configure Request (0x04) ident 12 len 4
        Destination CID: 88
        Flags: 0x0000
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 256
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 256
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 256
        Count: 1
> ACL Data RX: Handle 256 flags 0x02 dlen 16
      L2CAP: Connection Response (0x03) ident 11 len 8
        Destination CID: 0
        Source CID: 67
        Result: Connection refused - no resources available (0x0004)
        Status: No further information available (0x0000)

Issue reproduced with NOKIA BH-505 and Motorola HT820.
Comments are welcome.

Marcin Kraglak (1):
  audio/avctp: Accept incoming connection in case of colission

 profiles/audio/avctp.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

-- 
2.1.0
S
