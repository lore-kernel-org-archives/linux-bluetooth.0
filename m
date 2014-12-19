Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 18 Dec 2014 23:41:56 -0800
Message-ID: <CAD81oNYnfe-5r8hDOqP86CTCRG8iaTt7HexzMOBSsSqcy8Z1NA@mail.gmail.com>
Subject: GATT connection without BlueZ installed
From: Artem Rakhov <arakhov@chromium.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I'm testing GATT connection: running btgatt-server on one machine and
btgatt-client on the other one. Server machine doesn't have BlueZ
installed, just kernel part of Bluetooth stack is present. However, I
still use btgatt-server and btmgmt from tools/ on this machine.

Connection does not initiate correctly.

Server is stuck on listening:
"Started listening on ATT channel. Waiting for connections"
This means that bind() and listen() on socket are successful, but
accept() didn't finish. It doesn't see the incoming connection.

Client initiates MTU exchange, but doesn't receive anything in response:
btgatt-client: Opening L2CAP LE connection on ATT channel:
src: 00:00:00:00:00:00
dest: 24:0A:64:5A:AF:1B
Connecting to device... Done
[GATT client]# att: ATT op 0x02
[GATT client]# att: < 02 17 00
...
[GATT client]# att: Operation timed out: 0x02

btmon from the server:
> HCI Event: LE Meta Event (0x3e) plen 19                                              [hci0] 82.760084
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 32
        Role: Slave (0x01)
        Peer address type: Public (0x00)
        Peer address: 3C:77:E6:60:5C:B2 (OUI 3C-77-E6)
        Connection interval: 67.50 msec (0x0036)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x00
@ Device Connected: 3C:77:E6:60:5C:B2 (1) flags 0x0000
> ACL Data RX: Handle 32 flags 0x02 dlen 7                                             [hci0] 83.051725
      ATT: Exchange MTU Request (0x02) len 2
        Client RX MTU: 23
> HCI Event: Vendor (0xff) plen 7                                                     [hci0] 115.115106
        82 12 95 40 10 36 59                             ...@.6Y
> HCI Event: Disconnect Complete (0x05) plen 4                                        [hci0] 115.116099
        Status: Success (0x00)
        Handle: 32
        Reason: Remote User Terminated Connection (0x13)
@ Device Disconnected: 3C:77:E6:60:5C:B2 (1) reason 3

When I change the roles (so that server runs btgatt-client, and on the
other machine I stop bluetoothd and run btgatt-server), the connection
works fine.
When I use completely different software setup (BlueZ installed on
both, but bluetoothd stopped), everything also works fine, which makes
me believe that this is not a hardware problem.
Kernel is 3.10 on server, 3.8 on client.

Does anyone have any clues why accept() could not succeed on the server?

Thanks,
Artem
