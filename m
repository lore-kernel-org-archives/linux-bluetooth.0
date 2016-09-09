Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+UZiFDmzZOLTyutiAVOa9Y7wYhVNNDpDYZ9tEnwR9niw@mail.gmail.com>
References: <20160909122720.2404-1-tobias.svehagen@gmail.com> <CABBYNZ+UZiFDmzZOLTyutiAVOa9Y7wYhVNNDpDYZ9tEnwR9niw@mail.gmail.com>
From: Tobias Svehagen <tobias.svehagen@gmail.com>
Date: Sat, 10 Sep 2016 01:32:03 +0200
Message-ID: <CADwkJjLnKpYw6m1eoU-aMQomDNWFhwgJsAMVUOf-FMFihS5MWQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] src/device: Use BT_ATT_DEFAULT_LE_MTU as default MTU
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

I have a scenario where I think there is an obvious problem with the
current implementation. Maybe I have missed something and that the
patch provided actually messes something else up which I didn't notice
:) Anyway, here is the problem scenario

1. Bluez with some additional gatt services registered is running on
adapter A with device maximum MTU (ie dev->att_mtu) of 517. This means
that also attrib->att->mtu is 517 since it is set in
device_attach_att()
2. gatttool is started on adapter B, which does not support MTU
exchange, and connects to adapter A
3. Bluez will send MTU exchange request, which will fail, and Bluez
MTU will remain at 517 but gatttool MTU will be at
BT_ATT_DEFAULT_LE_MTU
4. gatttool asks for the primary services and Bluez answers with a
packet which is larger than the negotiated MTU. This makes all the
read routines behave strange and gatttool will fail to parse the
answer.

> This is not complete right since latter on if the MTU is negotiated by
> bt_gatt_client, but I remember fixing something like this:

Yes it is negotiated in bt_gatt_client but the problem is that if
negotiation fails, the MTU will remain at device maximum and not at
the expected BT_ATT_DEFAULT_LE_MTU. Maybe I'm missing something?

> Btw, it would be good to have some logs what exactly is the scenario
> where this happens.

Below is a log of a failure taken by btmon on the adapter running
Bluez. The interesting part are the following lines

< ACL Data TX: Handle 64 flags 0x00 dlen 27
                             [hci0] 8.022432
< ACL Data TX: Handle 64 flags 0x01 dlen 27
                             [hci0] 8.022446
< ACL Data TX: Handle 64 flags 0x01 dlen 12
                             [hci0] 8.022449
      ATT: Read By Group Type Response (0x11) len 61

What happens on the other side (ie gatttool) is this

# ./gatttool -b 5c:f3:70:74:02:52 --primary
Discover all primary services failed: Internal application error: I/O

This is because too much data, 61 bytes in this case, has been
received in one chunk since Bluez tries to send all services in one
go. Bluez does not honor the minimum MTU which it should in case of a
failed MTU exchange.

--- btmon-log failure ---

> HCI Event: LE Meta Event (0x3e) plen 19                                                           [hci0] 7.645659
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 64
        Role: Slave (0x01)
        Peer address type: Public (0x00)
        Peer address: 5C:F3:70:2C:0F:BF (CC&C Technologies, Inc)
        Connection interval: 67.50 msec (0x0036)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x00
@ Device Connected: 5C:F3:70:2C:0F:BF (1) flags 0x0000
= bluetoothd: No cache for 5C:F3:70:2C:0F:BF
                                    7.649629
< ACL Data TX: Handle 64 flags 0x00 dlen 7
                             [hci0] 7.647408
      ATT: Exchange MTU Request (0x02) len 2
        Client RX MTU: 517
> ACL Data RX: Handle 64 flags 0x02 dlen 9                                                          [hci0] 7.884921
      ATT: Error Response (0x01) len 4
        Exchange MTU Request (0x02)
        Handle: 0x0000
        Error: Request Not Supported (0x06)
< ACL Data TX: Handle 64 flags 0x00 dlen 11
                             [hci0] 7.885640
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)
> ACL Data RX: Handle 64 flags 0x02 dlen 11                                                         [hci0] 7.886024
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)
< ACL Data TX: Handle 64 flags 0x00 dlen 18
                             [hci0] 7.886720
      ATT: Read By Group Type Response (0x11) len 13
        Attribute data length: 6
        Attribute group list: 2 entries
        Handle range: 0x0001-0x0005
        UUID: Generic Access Profile (0x1800)
        Handle range: 0x0006-0x0009
        UUID: Generic Attribute Profile (0x1801)
> HCI Event: Number of Completed Packets (0x13) plen 5                                              [hci0] 7.954078
        Num handles: 1
        Handle: 64
        Count: 2
> ACL Data RX: Handle 64 flags 0x02 dlen 9                                                          [hci0] 8.019656
      ATT: Error Response (0x01) len 4
        Read By Group Type Request (0x10)
        Handle: 0x0000
        Error: Request Not Supported (0x06)
> ACL Data RX: Handle 64 flags 0x02 dlen 11                                                         [hci0] 8.021654
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x000a-0xffff
        Attribute group type: Primary Service (0x2800)
< ACL Data TX: Handle 64 flags 0x00 dlen 27
                             [hci0] 8.022432
< ACL Data TX: Handle 64 flags 0x01 dlen 27
                             [hci0] 8.022446
< ACL Data TX: Handle 64 flags 0x01 dlen 12
                             [hci0] 8.022449
      ATT: Read By Group Type Response (0x11) len 61
        Attribute data length: 20
        Attribute group list: 3 entries
        Handle range: 0x000a-0x0010
        UUID: Vendor specific (00000001-000a-0003-1234-567890abcdef)
        Handle range: 0x0011-0x001e
        UUID: Vendor specific (00000001-0002-0003-1234-567890abcdef)
        Handle range: 0x001f-0x0024
        UUID: Vendor specific (10000000-0002-0003-1234-567890abcdef)
> HCI Event: Number of Completed Packets (0x13) plen 5                                              [hci0] 8.089016
        Num handles: 1
        Handle: 64
        Count: 2
> HCI Event: Number of Completed Packets (0x13) plen 5                                              [hci0] 8.155043
        Num handles: 1
        Handle: 64
        Count: 2
> HCI Event: Disconnect Complete (0x05) plen 4                                                     [hci0] 10.248239
        Status: Success (0x00)
        Handle: 64
        Reason: Remote User Terminated Connection (0x13)
@ Device Disconnected: 5C:F3:70:2C:0F:BF (1) reason 3


In the log below, which has the patch applied, the MTU is honored and
one packet per service is sent instead.

--- btmon-log success ---

> HCI Event: LE Meta Event (0x3e) plen 19                                                          [hci0] 13.013157
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 64
        Role: Slave (0x01)
        Peer address type: Public (0x00)
        Peer address: 5C:F3:70:2C:0F:BF (CC&C Technologies, Inc)
        Connection interval: 67.50 msec (0x0036)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x00
@ Device Connected: 5C:F3:70:2C:0F:BF (1) flags 0x0000
= bluetoothd: No cache for 5C:F3:70:2C:0F:BF
                                   13.018786
< ACL Data TX: Handle 64 flags 0x00 dlen 7
                            [hci0] 13.014360
      ATT: Exchange MTU Request (0x02) len 2
        Client RX MTU: 517
> ACL Data RX: Handle 64 flags 0x02 dlen 9                                                         [hci0] 13.252181
      ATT: Error Response (0x01) len 4
        Exchange MTU Request (0x02)
        Handle: 0x0000
        Error: Request Not Supported (0x06)
< ACL Data TX: Handle 64 flags 0x00 dlen 11
                            [hci0] 13.252623
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)
> ACL Data RX: Handle 64 flags 0x02 dlen 11                                                        [hci0] 13.253078
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)
< ACL Data TX: Handle 64 flags 0x00 dlen 18
                            [hci0] 13.253371
      ATT: Read By Group Type Response (0x11) len 13
        Attribute data length: 6
        Attribute group list: 2 entries
        Handle range: 0x0001-0x0005
        UUID: Generic Access Profile (0x1800)
        Handle range: 0x0006-0x0009
        UUID: Generic Attribute Profile (0x1801)
> HCI Event: Number of Completed Packets (0x13) plen 5                                             [hci0] 13.321076
        Num handles: 1
        Handle: 64
        Count: 2
> ACL Data RX: Handle 64 flags 0x02 dlen 9                                                         [hci0] 13.386815
      ATT: Error Response (0x01) len 4
        Read By Group Type Request (0x10)
        Handle: 0x0000
        Error: Request Not Supported (0x06)
> ACL Data RX: Handle 64 flags 0x02 dlen 11                                                        [hci0] 13.392490
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x000a-0xffff
        Attribute group type: Primary Service (0x2800)
< ACL Data TX: Handle 64 flags 0x00 dlen 26
                            [hci0] 13.398941
      ATT: Read By Group Type Response (0x11) len 21
        Attribute data length: 20
        Attribute group list: 1 entry
        Handle range: 0x000a-0x0010
        UUID: Vendor specific (00000001-000a-0003-1234-567890abcdef)
> ACL Data RX: Handle 64 flags 0x02 dlen 11                                                        [hci0] 13.522237
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0011-0xffff
        Attribute group type: Primary Service (0x2800)
< ACL Data TX: Handle 64 flags 0x00 dlen 26
                            [hci0] 13.522544
      ATT: Read By Group Type Response (0x11) len 21
        Attribute data length: 20
        Attribute group list: 1 entry
        Handle range: 0x0011-0x001e
        UUID: Vendor specific (00000001-0002-0003-1234-567890abcdef)
> HCI Event: Number of Completed Packets (0x13) plen 5                                             [hci0] 13.524591
        Num handles: 1
        Handle: 64
        Count: 2
> ACL Data RX: Handle 64 flags 0x02 dlen 11                                                        [hci0] 13.657102
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x001f-0xffff
        Attribute group type: Primary Service (0x2800)
< ACL Data TX: Handle 64 flags 0x00 dlen 26
                            [hci0] 13.657408
      ATT: Read By Group Type Response (0x11) len 21
        Attribute data length: 20
        Attribute group list: 1 entry
        Handle range: 0x001f-0x0024
        UUID: Vendor specific (10000000-0002-0003-1234-567890abcdef)
> ACL Data RX: Handle 64 flags 0x02 dlen 11                                                        [hci0] 13.792225
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0025-0xffff
        Attribute group type: Primary Service (0x2800)
< ACL Data TX: Handle 64 flags 0x00 dlen 9
                            [hci0] 13.792849
      ATT: Error Response (0x01) len 4
        Read By Group Type Request (0x10)
        Handle: 0x0025
        Error: Attribute Not Found (0x0a)
> HCI Event: Number of Completed Packets (0x13) plen 5                                             [hci0] 13.793919
        Num handles: 1
        Handle: 64
        Count: 2
> HCI Event: Number of Completed Packets (0x13) plen 5                                             [hci0] 14.093431
        Num handles: 1
        Handle: 64
        Count: 1
> HCI Event: Disconnect Complete (0x05) plen 4                                                     [hci0] 16.020489
        Status: Success (0x00)
        Handle: 64
        Reason: Remote User Terminated Connection (0x13)


Maybe this should be solved in some other way than what this patch
suggests but I think it is clear that something is a bit strange. I
guess you should be able to reproduce it easily as long as you can
make the MTU exchange fail. What do you think, does the patch create
any problems which I didn't see? Should it be solved in some other
way? Another possible fix is to call bt_att_set_mtu(client->att,
BT_ATT_DEFAULT_LE_MTU) when it is noticed that MTU exchange was not
supported at (src/shared/gatt-client.c:1174).

Regards,
Tobias
