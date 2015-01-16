Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 15 Jan 2015 22:18:56 -0800
Message-ID: <CAD81oNYp51=Aowb50gqfdm4Yy7vLxPAy5vse7izHZVVFqNGvOQ@mail.gmail.com>
Subject: GATT server tool does not accept incoming connection
From: Artem Rakhov <arakhov@chromium.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I'm having an issue with running btgatt-server and btgatt-client
communication. I'm using implementations from tools/
GATT server basically hangs on accept() stage. It doesn't pick up the
connection, though client sends an initial MTU request to it.
The problem is reproducible on the latest bluetooth-next checkout
(3.19.0-rc2-12542-g2b8df32), but everything works good for kernel 3.8
(server-side).
Debugging l2cap_sock_accept() showed that a while loop there completes
its first iteration fine, but on the second iteration it fails
signal_pending(current) condition and finishes with an error. For now,
it's not clear for me where it hangs.

When I was testing this, I stopped bluetoothd on both machines, and
used btmgmt to configure client as: powered connectable bondable ssp
br/edr le. Server had same settings plus discoverable and advertising.

Here is btmon log from server:
= New Index: 24:0A:64:5A:AF:1B (BR/EDR,USB,hci0)
                 [hci0] 0.630514
> HCI Event: LE Meta Event (0x3e) plen 19                                              [hci0] 36.063409
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
> ACL Data RX: Handle 32 flags 0x02 dlen 7                                             [hci0] 36.075237
      ATT: Exchange MTU Request (0x02) len 2
        Client RX MTU: 23
> HCI Event: Vendor (0xff) plen 7                                                      [hci0] 68.138437
        82 12 95 40 10 36 59                             ...@.6Y
> HCI Event: Disconnect Complete (0x05) plen 4                                         [hci0] 68.139432
        Status: Success (0x00)
        Handle: 32
        Reason: Remote User Terminated Connection (0x13)
@ Device Disconnected: 3C:77:E6:60:5C:B2 (1) reason 3
< HCI Command: LE Set Advertising Parameters (0x08|0x0006) plen 15
                [hci0] 68.148469
        Min advertising interval: 1280.000 msec (0x0800)
        Max advertising interval: 1280.000 msec (0x0800)
        Type: Connectable undirected - ADV_IND (0x00)
        Own address type: Public (0x00)
        Direct address type: Public (0x00)
        Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
        Channel map: 37, 38, 39 (0x07)
        Filter policy: Allow Scan Request from Any, Allow Connect
Request from Any (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                            [hci0] 68.149430
      LE Set Advertising Parameters (0x08|0x0006) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Advertise Enable (0x08|0x000a) plen 1
                [hci0] 68.149474
        Advertising: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                                            [hci0] 68.150431
      LE Set Advertise Enable (0x08|0x000a) ncmd 1
        Status: Success (0x00)

Does anyone have any clues on this issue?

Thanks,
Artem
