Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Fri, 25 Jul 2014 18:33:28 -0700
Message-ID: <CAD81oNZL0qATu_z_TJT8psaMhpmV34w6xmA2+=OKerSE1NSvOw@mail.gmail.com>
Subject: [A2DP] Incoming connections do not succeed
From: Artem Rakhov <arakhov@chromium.org>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I have a problem with A2DP incoming connections. I have a BT speaker
(Monster Clarity HD), which automatically reconnects on startup to the
last connected source. It works fine with BlueZ 4, but it never
reconnects successfully when using BlueZ 5.19

Here is btmon log:
< ACL Data TX: Handle 21 flags 0x00 dlen 16
               [hci0] 3471.224113
      L2CAP: Connection Response (0x03) ident 2 len 8
        Destination CID: 64
        Source CID: 108
        Result: Connection pending (0x0001)
        Status: Authorization pending (0x0002)
< ACL Data TX: Handle 21 flags 0x00 dlen 16
               [hci0] 3471.224313
      L2CAP: Connection Response (0x03) ident 2 len 8
        Destination CID: 64
        Source CID: 108
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)
< ACL Data TX: Handle 21 flags 0x00 dlen 12
               [hci0] 3471.224417
      L2CAP: Configure Request (0x04) ident 2 len 4
        Destination CID: 108
        Flags: 0x0000
> HCI Event: Number of Completed Packets (0x13) plen 5                                [hci0] 3471.226831
        Num handles: 1
        Handle: 21
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5                                [hci0] 3471.227794
        Num handles: 1
        Handle: 21
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5                                [hci0] 3471.228807
        Num handles: 1
        Handle: 21
        Count: 1
> ACL Data RX: Handle 21 flags 0x02 dlen 12                                           [hci0] 3471.256507
      L2CAP: Disconnection Request (0x06) ident 3 len 4
        Destination CID: 64
        Source CID: 108
< ACL Data TX: Handle 21 flags 0x00 dlen 12
               [hci0] 3471.256592
      L2CAP: Disconnection Response (0x07) ident 3 len 4
        Destination CID: 64
        Source CID: 108
> HCI Event: Number of Completed Packets (0x13) plen 5                                [hci0] 3471.258773
        Num handles: 1
        Handle: 21
        Count: 1
> HCI Event: Vendor (0xff) plen 7                                                     [hci0] 3471.549833
        82 00 01 00 01 15 00                             .......
> HCI Event: Disconnect Complete (0x05) plen 4                                        [hci0] 3471.550757
        Status: Success (0x00)
        Handle: 21
        Reason: Remote User Terminated Connection (0x13)
@ Device Disconnected: 10:B7:F6:01:31:ED (0) reason 3


As could be seen from the log, after the source sends L2CAP Configure
Request the speaker does not answer and disconnects (sends L2CAP
Disconnection Request).

Debugging avdtp.c showed that processing of incoming connections is
held in avdtp_confirm_cb() function. There, at some point after
successful authorization G_IO_ERR and G_IO_HUP events appear. And then
session_cb() function is called (as callback for these events), which
drops the connection.

Does anyone experience the same issue or have any ideas on how to fix it?

Thanks,
Artem
