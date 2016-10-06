Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ++LGPjjWSxz4DyjgjNRm2Qyq6F50bbLDfKgJAdXSVYLA@mail.gmail.com>
References: <CAAu3APY4HhpFyBBu9nLqPyO6SvQpC_tTj1pokSCn4DtxQQZbRg@mail.gmail.com>
 <CABBYNZ++LGPjjWSxz4DyjgjNRm2Qyq6F50bbLDfKgJAdXSVYLA@mail.gmail.com>
From: Barry Byford <31baz66@gmail.com>
Date: Thu, 6 Oct 2016 09:49:55 +0100
Message-ID: <CAAu3APYkBV3OfrEeB8QQrTLPL86sVoSaawdyew7qkEv210Br2A@mail.gmail.com>
Subject: Re: Fatbeacons and 'streamed read' of a characteristic
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Luiz,


On 6 October 2016 at 09:23, Luiz Augusto von Dentz <luiz.dentz@gmail.com> w=
rote:
> Hi Barry,
>
> On Wed, Oct 5, 2016 at 11:31 PM, Barry Byford <31baz66@gmail.com> wrote:
>> Hello,
>>
>> I've been doing some experiments with Googles Physical Web Fatbeacon
>> https://github.com/google/physical-web/issues/784#issuecomment-251571858
>>
>> The experiments have been with BlueZ 5.40 using the DBus API with
>> Python 3. BlueZ is advertising a connectable Eddystone beacon. When
>> the Physical Web Android app connects there is one service with one
>> characteristic that it is looking for. That characteristic contains a
>> string that is the HTML content.
>> All is working well if the web page contained in the characteristic is
>> nice and short.
>> However if I make the web page content slightly longer then I end up
>> getting stuck in a loop where the Physical Web app is just reading the
>> first part of the characteristic over and over again.
>
> How big is it? The spec actually limits the attribute contents to 512
> bytes. On the other hand I remember the Android App returning
> different parts of the data on every read, so it essentially doing its
> own fragmentation.

My content is bigger than 512 bytes when it starts failing. The app is
definitely making multi-read requests of my characteristic. The bit
that I'm missing is how to make the beacon/service give the next chunk
of content on each read.


>> I'm assuming that it is not that uncommon for data to be larger than
>> can be retrieved in one read although I've not been able to find an
>> example. I'm a little bit at a loss as to what the ReadValue method
>> should look like for this characteristic.
>> Is anyone able to give me some pointers as to what I need to do to get
>> this to work?
>
> Check out the Android physical web application:
>
> https://play.google.com/store/apps/details?id=3Dphysical_web.org.physical=
web&hl=3Den
>

It is that app that I'm using to connect to the
beacon/service/characteristic I've created with BlueZ.

I seem to be missing something obvious. The app is making multiple
reads and I had expected the ReadValue to be called with an offset
given in the options. This isn't the case.

I've captured what options that are being given to the characteristic
ReadValue when it is called:

Reading value:  dbus.Dictionary({dbus.String('device'):
dbus.ObjectPath('/org/bluez/hci0/dev_60_51_1E_E0_17_2D',
variant_level=3D1)}, signature=3Ddbus.Signature('sv'))
Reading value:  dbus.Dictionary({dbus.String('device'):
dbus.ObjectPath('/org/bluez/hci0/dev_60_51_1E_E0_17_2D',
variant_level=3D1)}, signature=3Ddbus.Signature('sv'))
Reading value:  dbus.Dictionary({dbus.String('device'):
dbus.ObjectPath('/org/bluez/hci0/dev_60_51_1E_E0_17_2D',
variant_level=3D1)}, signature=3Ddbus.Signature('sv'))
Reading value:  dbus.Dictionary({dbus.String('device'):
dbus.ObjectPath('/org/bluez/hci0/dev_60_51_1E_E0_17_2D',
variant_level=3D1)}, signature=3Ddbus.Signature('sv'))
etc...

The btmon log for the connection and read attempts.


Bluetooth monitor ver 5.40
=3D New Index: 00:02:5B:03:44:07 (BR/EDR,USB,hci0)         [hci0] 21:24:19.=
404971
@ Advertising Added: 1
< HCI Command: LE Set Advertisi.. (0x08|0x0006) plen 15  [hci0] 21:24:29.20=
1962
        Min advertising interval: 1280.000 msec (0x0800)
        Max advertising interval: 1280.000 msec (0x0800)
        Type: Connectable undirected - ADV_IND (0x00)
        Own address type: Public (0x00)
        Direct address type: Public (0x00)
        Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
        Channel map: 37, 38, 39 (0x07)
        Filter policy: Allow Scan Request from Any, Allow Connect
Request from Any (0x00)
> HCI Event: Command Complete (0x0e) plen 4              [hci0] 21:24:29.20=
3772
      LE Set Advertising Parameters (0x08|0x0006) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Advertise... (0x08|0x000a) plen 1  [hci0] 21:24:29.20=
3967
        Advertising: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4              [hci0] 21:24:29.20=
5736
      LE Set Advertise Enable (0x08|0x000a) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19                [hci0] 21:24:35.21=
0461
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 40
        Role: Slave (0x01)
        Peer address type: Random (0x01)
        Peer address: 60:51:1E:E0:17:2D (Resolvable)
        Connection interval: 45.00 msec (0x0024)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 20000 msec (0x07d0)
        Master clock accuracy: 0x00
< ACL Data TX: Handle 40 flags 0x00 dlen 16              [hci0] 21:24:35.21=
1145
      LE L2CAP: Connection Parameter Update Request (0x12) ident 1 len 8
        Min interval: 40
        Max interval: 56
        Slave latency: 0
        Timeout multiplier: 2000
@ Device Connected: 60:51:1E:E0:17:2D (2) flags 0x0000
< ACL Data TX: Handle 40 flags 0x00 dlen 7               [hci0] 21:24:35.25=
2343
      ATT: Exchange MTU Request (0x02) len 2
        Client RX MTU: 517
> HCI Event: Number of Completed Packets (0x13) plen 5   [hci0] 21:24:35.29=
7516
        Num handles: 1
        Handle: 40
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5   [hci0] 21:24:35.34=
2506
        Num handles: 1
        Handle: 40
        Count: 1
> ACL Data RX: Handle 40 flags 0x02 dlen 13              [hci0] 21:24:35.34=
2643
      ATT: Find By Type Value Request (0x06) len 8
        Handle range: 0x0001-0xffff
        Attribute type: Primary Service (0x2800)
          UUID: Generic Attribute Profile (0x1801)
< ACL Data TX: Handle 40 flags 0x00 dlen 9               [hci0] 21:24:35.34=
3457
      ATT: Find By Type Value Response (0x07) len 4
        Handle range: 0x0006-0x0009
> ACL Data RX: Handle 40 flags 0x02 dlen 10              [hci0] 21:24:35.34=
4035
      LE L2CAP: Connection Parameter Update Response (0x13) ident 1 len 2
        Result: Connection Parameters accepted (0x0000)
> ACL Data RX: Handle 40 flags 0x02 dlen 7               [hci0] 21:24:35.34=
4138
      ATT: Exchange MTU Response (0x03) len 2
        Server RX MTU: 517
< ACL Data TX: Handle 40 flags 0x00 dlen 11              [hci0] 21:24:35.34=
4716
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5   [hci0] 21:24:35.38=
7506
        Num handles: 1
        Handle: 40
        Count: 1
> ACL Data RX: Handle 40 flags 0x02 dlen 11              [hci0] 21:24:35.43=
1780
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)
< ACL Data TX: Handle 40 flags 0x00 dlen 18              [hci0] 21:24:35.43=
2608
      ATT: Read By Group Type Response (0x11) len 13
        Attribute data length: 6
        Attribute group list: 2 entries
        Handle range: 0x0001-0x0005
        UUID: Generic Access Profile (0x1800)
        Handle range: 0x0006-0x0009
        UUID: Generic Attribute Profile (0x1801)
> HCI Event: Number of Completed Packets (0x13) plen 5   [hci0] 21:24:35.43=
2535
        Num handles: 1
        Handle: 40
        Count: 1
> ACL Data RX: Handle 40 flags 0x02 dlen 18              [hci0] 21:24:35.43=
3165
      ATT: Read By Group Type Response (0x11) len 13
        Attribute data length: 6
        Attribute group list: 2 entries
        Handle range: 0x0001-0x0005
        UUID: Generic Attribute Profile (0x1801)
        Handle range: 0x0014-0xffff
        UUID: Generic Access Profile (0x1800)
> HCI Event: LE Meta Event (0x3e) plen 10                [hci0] 21:24:35.60=
9546
      LE Connection Update Complete (0x03)
        Status: Success (0x00)
        Handle: 40
        Connection interval: 67.50 msec (0x0036)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 20000 msec (0x07d0)
> ACL Data RX: Handle 40 flags 0x02 dlen 13              [hci0] 21:24:35.61=
2057
      ATT: Find By Type Value Request (0x06) len 8
        Handle range: 0x000a-0xffff
        Attribute type: Primary Service (0x2800)
          UUID: Generic Attribute Profile (0x1801)
> HCI Event: Number of Completed Packets (0x13) plen 5   [hci0] 21:24:35.61=
2548
        Num handles: 1
        Handle: 40
        Count: 1
< ACL Data TX: Handle 40 flags 0x00 dlen 9               [hci0] 21:24:35.61=
3006
      ATT: Error Response (0x01) len 4
        Find By Type Value Request (0x06)
        Handle: 0x000a
        Error: Attribute Not Found (0x0a)
> ACL Data RX: Handle 40 flags 0x02 dlen 11              [hci0] 21:24:35.74=
7199
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x000a-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5   [hci0] 21:24:35.74=
7560
        Num handles: 1
        Handle: 40
        Count: 1
< ACL Data TX: Handle 40 flags 0x00 dlen 26              [hci0] 21:24:35.74=
8134
      ATT: Read By Group Type Response (0x11) len 21
        Attribute data length: 20
        Attribute group list: 1 entry
        Handle range: 0x000d-0x000f
        UUID: Unknown (ae5946d4-e587-4ba8-b6a5-a97cca6affd3)
> ACL Data RX: Handle 40 flags 0x02 dlen 11              [hci0] 21:24:35.88=
2342
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0001-0x0009
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5   [hci0] 21:24:35.88=
2562
        Num handles: 1
        Handle: 40
        Count: 1
< ACL Data TX: Handle 40 flags 0x00 dlen 27              [hci0] 21:24:35.88=
3319
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 7
        Attribute data list: 3 entries
        Handle: 0x0002
        Value: 020300002a
        Handle: 0x0004
        Value: 020500012a
        Handle: 0x0007
        Value: 200800052a
> HCI Event: LE Meta Event (0x3e) plen 10                [hci0] 21:24:36.08=
9593
      LE Connection Update Complete (0x03)
        Status: Success (0x00)
        Handle: 40
        Connection interval: 7.50 msec (0x0006)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 20000 msec (0x07d0)
> ACL Data RX: Handle 40 flags 0x02 dlen 11              [hci0] 21:24:36.09=
2488
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0010-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5   [hci0] 21:24:36.09=
2693
        Num handles: 1
        Handle: 40
        Count: 1
< ACL Data TX: Handle 40 flags 0x00 dlen 9               [hci0] 21:24:36.09=
3376
      ATT: Error Response (0x01) len 4
        Read By Group Type Request (0x10)
        Handle: 0x0010
        Error: Attribute Not Found (0x0a)
> HCI Event: Number of Completed Packets (0x13) plen 5   [hci0] 21:24:36.10=
7631
        Num handles: 1
        Handle: 40
        Count: 1
> ACL Data RX: Handle 40 flags 0x02 dlen 11              [hci0] 21:24:36.10=
7721
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0008-0x0009
        Attribute type: Characteristic (0x2803)
< ACL Data TX: Handle 40 flags 0x00 dlen 9               [hci0] 21:24:36.10=
8460
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0008
        Error: Attribute Not Found (0x0a)
> HCI Event: Number of Completed Packets (0x13) plen 5   [hci0] 21:24:36.13=
7603
        Num handles: 1
        Handle: 40
        Count: 1
> ACL Data RX: Handle 40 flags 0x02 dlen 11              [hci0] 21:24:36.13=
7743
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0001-0x0005
        Attribute type: Include (0x2802)
< ACL Data TX: Handle 40 flags 0x00 dlen 9               [hci0] 21:24:36.13=
8865
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0001
        Error: Attribute Not Found (0x0a)
> ACL Data RX: Handle 40 flags 0x02 dlen 9               [hci0] 21:24:36.15=
1625
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0008-0x0009
< ACL Data TX: Handle 40 flags 0x00 dlen 14              [hci0] 21:24:36.15=
2325
      ATT: Find Information Response (0x05) len 9
        Format: UUID-16 (0x01)
        Handle: 0x0008
        UUID: Service Changed (0x2a05)
        Handle: 0x0009
        UUID: Client Characteristic Configuration (0x2902)
> HCI Event: Number of Completed Packets (0x13) plen 5   [hci0] 21:24:36.15=
2649
        Num handles: 1
        Handle: 40
        Count: 1
> ACL Data RX: Handle 40 flags 0x02 dlen 11              [hci0] 21:24:36.16=
6752
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0001-0x0005
        Attribute type: Characteristic (0x2803)
< ACL Data TX: Handle 40 flags 0x00 dlen 20              [hci0] 21:24:36.16=
7472
      ATT: Read By Type Response (0x09) len 15
        Attribute data length: 7
        Attribute data list: 2 entries
        Handle: 0x0002
        Value: 020300002a
        Handle: 0x0004
        Value: 020500012a
> HCI Event: Number of Completed Packets (0x13) plen 5   [hci0] 21:24:36.16=
7636
        Num handles: 1
        Handle: 40
        Count: 1
> ACL Data RX: Handle 40 flags 0x02 dlen 9               [hci0] 21:24:36.18=
1881
      ATT: Write Request (0x12) len 4
        Handle: 0x0009
          Data: 0200
> HCI Event: Number of Completed Packets (0x13) plen 5   [hci0] 21:24:36.18=
2632
        Num handles: 1
        Handle: 40
        Count: 1
< ACL Data TX: Handle 40 flags 0x00 dlen 5               [hci0] 21:24:36.18=
2996
      ATT: Write Response (0x13) len 0
> ACL Data RX: Handle 40 flags 0x02 dlen 11              [hci0] 21:24:36.19=
7011
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0005-0x0005
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5   [hci0] 21:24:36.19=
7628
        Num handles: 1
        Handle: 40
        Count: 1
< ACL Data TX: Handle 40 flags 0x00 dlen 9               [hci0] 21:24:36.19=
7902
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0005
        Error: Attribute Not Found (0x0a)
> ACL Data RX: Handle 40 flags 0x02 dlen 11              [hci0] 21:24:36.21=
2128
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0006-0x0009
        Attribute type: Include (0x2802)
> HCI Event: Number of Completed Packets (0x13) plen 5   [hci0] 21:24:36.21=
2624
        Num handles: 1
        Handle: 40
        Count: 1
< ACL Data TX: Handle 40 flags 0x00 dlen 9               [hci0] 21:24:36.21=
3598
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0006
        Error: Attribute Not Found (0x0a)
> ACL Data RX: Handle 40 flags 0x02 dlen 11              [hci0] 21:24:36.22=
7253
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0006-0x0009
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5   [hci0] 21:24:36.22=
7617
        Num handles: 1
        Handle: 40
        Count: 1
< ACL Data TX: Handle 40 flags 0x00 dlen 13              [hci0] 21:24:36.22=
8693
      ATT: Read By Type Response (0x09) len 8
        Attribute data length: 7
        Attribute data list: 1 entry
        Handle: 0x0007
        Value: 200800052a
> HCI Event: Number of Completed Packets (0x13) plen 5   [hci0] 21:24:36.24=
9536
        Num handles: 1
        Handle: 40
        Count: 1
> ACL Data RX: Handle 40 flags 0x02 dlen 11              [hci0] 21:24:36.24=
9900
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0008-0x0009
        Attribute type: Characteristic (0x2803)
< ACL Data TX: Handle 40 flags 0x00 dlen 9               [hci0] 21:24:36.25=
0687
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0008
        Error: Attribute Not Found (0x0a)
> HCI Event: Number of Completed Packets (0x13) plen 5   [hci0] 21:24:36.26=
4613
        Num handles: 1
        Handle: 40
        Count: 1
> ACL Data RX: Handle 40 flags 0x02 dlen 9               [hci0] 21:24:36.26=
5032
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0009-0x0009
< ACL Data TX: Handle 40 flags 0x00 dlen 10              [hci0] 21:24:36.26=
5670
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x0009
        UUID: Client Characteristic Configuration (0x2902)
> HCI Event: Number of Completed Packets (0x13) plen 5   [hci0] 21:24:36.27=
9612
        Num handles: 1
        Handle: 40
        Count: 1
> ACL Data RX: Handle 40 flags 0x02 dlen 11              [hci0] 21:24:36.28=
0146
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x000d-0x000f
        Attribute type: Include (0x2802)
< ACL Data TX: Handle 40 flags 0x00 dlen 9               [hci0] 21:24:36.28=
0771
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x000d
        Error: Attribute Not Found (0x0a)
> HCI Event: Number of Completed Packets (0x13) plen 5   [hci0] 21:24:36.29=
4616
        Num handles: 1
        Handle: 40
        Count: 1
> ACL Data RX: Handle 40 flags 0x02 dlen 11              [hci0] 21:24:36.29=
5275
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x000d-0x000f
        Attribute type: Characteristic (0x2803)
< ACL Data TX: Handle 40 flags 0x00 dlen 27              [hci0] 21:24:36.29=
5927
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 21
        Attribute data list: 1 entry
        Handle: 0x000e
        Value: 020f00fa66c9c19b80cc9cca469924f017a5d1
> ACL Data RX: Handle 40 flags 0x02 dlen 11              [hci0] 21:24:36.30=
9139
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x000f-0x000f
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5   [hci0] 21:24:36.30=
9637
        Num handles: 1
        Handle: 40
        Count: 1
< ACL Data TX: Handle 40 flags 0x00 dlen 9               [hci0] 21:24:36.31=
0143
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x000f
        Error: Attribute Not Found (0x0a)
> HCI Event: Number of Completed Packets (0x13) plen 5   [hci0] 21:24:36.32=
4618
        Num handles: 1
        Handle: 40
        Count: 1
> ACL Data RX: Handle 40 flags 0x02 dlen 7               [hci0] 21:24:36.33=
1766
      ATT: Exchange MTU Request (0x02) len 2
        Client RX MTU: 505
< ACL Data TX: Handle 40 flags 0x00 dlen 7               [hci0] 21:24:36.33=
2463
      ATT: Exchange MTU Response (0x03) len 2
        Server RX MTU: 517
> HCI Event: Number of Completed Packets (0x13) plen 5   [hci0] 21:24:36.34=
7622
        Num handles: 1
        Handle: 40
        Count: 1
> ACL Data RX: Handle 40 flags 0x02 dlen 7               [hci0] 21:24:36.35=
4404
      ATT: Read Request (0x0a) len 2
        Handle: 0x000f
< ACL Data TX: Handle 40 flags 0x00 dlen 310             [hci0] 21:24:36.36=
7639
< ACL Data TX: Handle 40 flags 0x01 dlen 196             [hci0] 21:24:36.36=
7737
      ATT: Read Response (0x0b) len 501
        Value: 3c68746d6c3e3c686561643e3c7374796c653e0a626f6479207b20626163=
6b67726f756e642d636f6c6f723a206c696e656e3b207d0a6831207b20636f6c6f723a206d6=
1726f6f6e3b206d617267696e2d6c6566743a20343070783b207d0a3c2f7374796c653e3c74=
69746c653e466174426561636f6e2044656d6f3c2f7469746c653e0a3c6d657461206368617=
27365743d275554462d38273e3c6d657461206e616d653d276465736372697074696f6e2720=
636f6e74656e743d27466174426561636f6e2044656d6f272f3e0a3c2f686561643e203c626=
f64793e203c68313e46617420426561636f6e3c2f68313e203c703e
> HCI Event: LE Meta Event (0x3e) plen 10                [hci0] 21:24:36.37=
5644
      LE Connection Update Complete (0x03)
        Status: Success (0x00)
        Handle: 40
        Connection interval: 15.00 msec (0x000c)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 20000 msec (0x07d0)
> HCI Event: Number of Completed Packets (0x13) plen 5   [hci0] 21:24:36.41=
5642
        Num handles: 1
        Handle: 40
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5   [hci0] 21:24:36.42=
2629
        Num handles: 1
        Handle: 40
        Count: 1
> ACL Data RX: Handle 40 flags 0x02 dlen 7               [hci0] 21:24:36.43=
7051
      ATT: Read Request (0x0a) len 2
        Handle: 0x000f
< ACL Data TX: Handle 40 flags 0x00 dlen 310             [hci0] 21:24:36.44=
9740
< ACL Data TX: Handle 40 flags 0x01 dlen 196             [hci0] 21:24:36.44=
9830
      ATT: Read Response (0x0b) len 501
        Value: 3c68746d6c3e3c686561643e3c7374796c653e0a626f6479207b20626163=
6b67726f756e642d636f6c6f723a206c696e656e3b207d0a6831207b20636f6c6f723a206d6=
1726f6f6e3b206d617267696e2d6c6566743a20343070783b207d0a3c2f7374796c653e3c74=
69746c653e466174426561636f6e2044656d6f3c2f7469746c653e0a3c6d657461206368617=
27365743d275554462d38273e3c6d657461206e616d653d276465736372697074696f6e2720=
636f6e74656e743d27466174426561636f6e2044656d6f272f3e0a3c2f686561643e203c626=
f64793e203c68313e46617420426561636f6e3c2f68313e203c703e
> HCI Event: Number of Completed Packets (0x13) plen 5   [hci0] 21:24:36.48=
6645
        Num handles: 1
        Handle: 40
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5   [hci0] 21:24:36.49=
7638
        Num handles: 1
        Handle: 40
        Count: 1
> ACL Data RX: Handle 40 flags 0x02 dlen 7               [hci0] 21:24:36.51=
2169
      ATT: Read Request (0x0a) len 2
        Handle: 0x000f
< ACL Data TX: Handle 40 flags 0x00 dlen 310             [hci0] 21:24:36.52=
5301
< ACL Data TX: Handle 40 flags 0x01 dlen 196             [hci0] 21:24:36.52=
5447
      ATT: Read Response (0x0b) len 501
        Value: 3c68746d6c3e3c686561643e3c7374796c653e0a626f6479207b20626163=
6b67726f756e642d636f6c6f723a206c696e656e3b207d0a6831207b20636f6c6f723a206d6=
1726f6f6e3b206d617267696e2d6c6566743a20343070783b207d0a3c2f7374796c653e3c74=
69746c653e466174426561636f6e2044656d6f3c2f7469746c653e0a3c6d657461206368617=
27365743d275554462d38273e3c6d657461206e616d653d276465736372697074696f6e2720=
636f6e74656e743d27466174426561636f6e2044656d6f272f3e0a3c2f686561643e203c626=
f64793e203c68313e46617420426561636f6e3c2f68313e203c703e
> HCI Event: Number of Completed Packets (0x13) plen 5   [hci0] 21:24:36.55=
0661
        Num handles: 1
        Handle: 40
        Count: 1
