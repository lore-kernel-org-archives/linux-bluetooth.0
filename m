Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jorge Miranda <jmiranda@dei.uminho.pt>
Content-Type: multipart/mixed;
 boundary="Apple-Mail=_A225BF13-29D0-47FC-BB02-08963F5FBFB7"
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Subject: Pair devices & Register service's DBus object paths
Message-Id: <65B92F54-29F3-462B-AD13-0C0F68D0CA96@dei.uminho.pt>
Date: Thu, 26 Jan 2017 13:06:22 +0000
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--Apple-Mail=_A225BF13-29D0-47FC-BB02-08963F5FBFB7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi,

I=E2=80=99m currently working with BlueZ 5.43 on Ubuntu 16.04.1 and I =
have two questions about the 1) pairing devices and 2) the DBus object =
paths of paired devices.

I do the normal process for adding pairing a new device: 1) discover it, =
2) pair/bond with the device, 3) connect and 4) read.
The first issue I found is related with the pair/bond. For devices that =
I=E2=80=99m currently testing (weight scale A&D UC-352BLE and blood =
pressure monitor A&D UA-651BLE), I=E2=80=99m unable to use the BlueZ=E2=80=
=99s DBus Pair method, because it fails on the authentication. I can=E2=80=
=99t understand if it is an issue with the devices, or if it is some =
limitation (or configuration) of BlueZ. Could you please shed some light =
into this?
I also found out that when I try to connect with a not paired device, it =
successfully pairs/bonds with them - I do steps 1 and 3. After that, the =
device stays paired and I=E2=80=99m able to connect and read values from =
it. Attached follows two files with the logs taken from btmon, for the =
situations described above.

The second question comes in line with the first, as the device=E2=80=99s =
object paths are registered after the pair and connect. But I noticed =
that once I disconnect (may no be immediately), the services and =
characteristics' object paths disappear. One I connect, they are =
registered again - I presume it takes some time because the device is =
being inquired for its services. I could not understand if this is by =
design, or if something is wrong=E2=80=A6 I believe on the first option, =
but would like to know why it is designed as such. Is there any way to =
get the status of the object paths, i.e. are they registered? Also, how =
does the DBus Device=E2=80=99s ServicesResolved property relates to =
this?

King regards
Jorge Miranda


--Apple-Mail=_A225BF13-29D0-47FC-BB02-08963F5FBFB7
Content-Disposition: attachment;
	filename=btmon-pair-failed.txt
Content-Type: text/plain;
	x-unix-mode=0644;
	name="btmon-pair-failed.txt"
Content-Transfer-Encoding: quoted-printable

Bluetooth monitor ver 5.43
=3D New Index: 00:1A:7D:DA:71:11 (Primary,USB,hci0)                   =
[hci0] 0.674514
=3D Open Index: 00:1A:7D:DA:71:11                                     =
[hci0] 0.674515
=3D Index Info: 00:1A:7D:DA:71:11 (Cambridge Silicon Radio)           =
[hci0] 0.674515
< HCI Command: LE Remove Device =46rom White... (0x08|0x0012) plen 7  =
[hci0] 2.857432
        Address type: Public (0x00)
        Address: AC:BC:32:7D:74:A6 (Apple, Inc.)
> HCI Event: Command Complete (0x0e) plen 4                         =
[hci0] 2.865500
      LE Remove Device =46rom White List (0x08|0x0012) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Add Device To White List (0x08|0x0011) plen 7     =
[hci0] 2.865559
        Address type: Public (0x00)
        Address: B4:99:4C:5A:B1:17 (Texas Instruments)
> HCI Event: Command Complete (0x0e) plen 4                         =
[hci0] 2.867599
      LE Add Device To White List (0x08|0x0011) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7          =
[hci0] 2.867641
        Type: Passive (0x00)
        Interval: 60.000 msec (0x0060)
        Window: 30.000 msec (0x0030)
        Own address type: Public (0x00)
        Filter policy: Ignore not in white list (0x01)
> HCI Event: Command Complete (0x0e) plen 4                         =
[hci0] 2.869609
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2              =
[hci0] 2.869696
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                         =
[hci0] 2.872715
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 25                           =
[hci0] 2.893635
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: B4:99:4C:5A:B1:17 (Texas Instruments)
        Data length: 13
        Flags: 0x05
          LE Limited Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (partial): 1 entry
          Weight Scale (0x181d)
        Slave Conn. Interval: 0x0040 - 0x0050
        RSSI: -73 dBm (0xb7)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2              =
[hci0] 2.893723
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                         =
[hci0] 2.904763
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Create Connection (0x08|0x000d) plen 25           =
[hci0] 2.904803
        Scan interval: 60.000 msec (0x0060)
        Scan window: 60.000 msec (0x0060)
        Filter policy: White list is not used (0x00)
        Peer address type: Public (0x00)
        Peer address: B4:99:4C:5A:B1:17 (Texas Instruments)
        Own address type: Public (0x00)
        Min connection interval: 50.00 msec (0x0028)
        Max connection interval: 70.00 msec (0x0038)
        Connection latency: 0x0000
        Supervision timeout: 420 msec (0x002a)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                           =
[hci0] 2.912609
      LE Create Connection (0x08|0x000d) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19                           =
[hci0] 2.924763
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 70
        Role: Master (0x00)
        Peer address type: Public (0x00)
        Peer address: B4:99:4C:5A:B1:17 (Texas Instruments)
        Connection interval: 70.00 msec (0x0038)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x00
< HCI Command: LE Read Remote Used Features (0x08|0x0016) plen 2    =
[hci0] 2.924861
        Handle: 70
> HCI Event: Command Status (0x0f) plen 4                           =
[hci0] 2.927573
      LE Read Remote Used Features (0x08|0x0016) ncmd 1
        Status: Success (0x00)
@ Device Connected: B4:99:4C:5A:B1:17 (1) flags 0x0000
        02 01 05 03 02 1d 18 05 12 40 00 50 00           .........@.P.
> ACL Data RX: Handle 70 flags 0x02 dlen 6                          =
[hci0] 2.971489
      SMP: Security Request (0x0b) len 1
        Authentication requirement: Bonding, No MITM, Legacy, No =
Keypresses (0x01)
> HCI Event: LE Meta Event (0x3e) plen 12                           =
[hci0] 3.035754
      LE Read Remote Used Features (0x04)
        Status: Success (0x00)
        Handle: 70
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          LE Encryption
< ACL Data TX: Handle 70 flags 0x00 dlen 11                         =
[hci0] 3.035869
      SMP: Pairing Request (0x01) len 6
        IO capability: NoInputNoOutput (0x03)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, No MITM, SC, No Keypresses =
(0x09)
        Max encryption key size: 16
        Initiator key distribution: EncKey Sign LinkKey (0x0d)
        Responder key distribution: EncKey IdKey Sign LinkKey (0x0f)
< ACL Data TX: Handle 70 flags 0x00 dlen 7                          =
[hci0] 3.036305
      ATT: Exchange MTU Request (0x02) len 2
        Client RX MTU: 517
> HCI Event: Number of Completed Packets (0x13) plen 5              =
[hci0] 3.105539
        Num handles: 1
        Handle: 70
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5              =
[hci0] 3.113668
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 11                         =
[hci0] 3.182469
      SMP: Pairing Response (0x02) len 6
        IO capability: NoInputNoOutput (0x03)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, No MITM, Legacy, No =
Keypresses (0x01)
        Max encryption key size: 16
        Initiator key distribution: EncKey Sign (0x05)
        Responder key distribution: EncKey IdKey Sign (0x07)
< ACL Data TX: Handle 70 flags 0x00 dlen 21                         =
[hci0] 3.182600
      SMP: Pairing Confirm (0x03) len 16
        Confim value: 6f2087d79d33feec1a52262a21bbd901
> ACL Data RX: Handle 70 flags 0x02 dlen 7                          =
[hci0] 3.183575
      ATT: Exchange MTU Response (0x03) len 2
        Server RX MTU: 23
< ACL Data TX: Handle 70 flags 0x00 dlen 11                         =
[hci0] 3.183939
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5              =
[hci0] 3.245584
        Num handles: 1
        Handle: 70
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5              =
[hci0] 3.253473
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 21                         =
[hci0] 3.314961
      SMP: Pairing Confirm (0x03) len 16
        Confim value: 6b6f8218d288f81a520e0e8cda85811a
< ACL Data TX: Handle 70 flags 0x00 dlen 21                         =
[hci0] 3.315052
      SMP: Pairing Random (0x04) len 16
        Random value: 7dc11d7d2ab0de4212a21211e64a8a39
> ACL Data RX: Handle 70 flags 0x02 dlen 24                         =
[hci0] 3.322323
      ATT: Read By Group Type Response (0x11) len 19
        Attribute data length: 6
        Attribute group list: 3 entries
        Handle range: 0x0001-0x000b
        UUID: Generic Access Profile (0x1800)
        Handle range: 0x000c-0x000f
        UUID: Generic Attribute Profile (0x1801)
        Handle range: 0x0010-0x0017
        UUID: Weight Scale (0x181d)
< ACL Data TX: Handle 70 flags 0x00 dlen 11                         =
[hci0] 3.322564
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0018-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5              =
[hci0] 3.385589
        Num handles: 1
        Handle: 70
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5              =
[hci0] 3.393280
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 6                          =
[hci0] 3.462935
      SMP: Pairing Failed (0x05) len 1
        Reason: Confirm value failed (0x04)
< HCI Command: Disconnect (0x01|0x0006) plen 3                      =
[hci0] 3.463054
        Handle: 70
        Reason: Authentication Failure (0x05)
> ACL Data RX: Handle 70 flags 0x02 dlen 18                         =
[hci0] 3.464011
      ATT: Read By Group Type Response (0x11) len 13
        Attribute data length: 6
        Attribute group list: 2 entries
        Handle range: 0x0018-0x0028
        UUID: Device Information (0x180a)
        Handle range: 0x0029-0x002b
        UUID: Battery Service (0x180f)
@ Authentication Failed: B4:99:4C:5A:B1:17 (1) status 0x05
> HCI Event: Command Status (0x0f) plen 4                           =
[hci0] 3.468496
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)
> HCI Event: Disconnect Complete (0x05) plen 4                      =
[hci0] 3.525525
        Status: Success (0x00)
        Handle: 70
        Reason: Connection Terminated By Local Host (0x16)=

--Apple-Mail=_A225BF13-29D0-47FC-BB02-08963F5FBFB7
Content-Disposition: attachment;
	filename=btmon-connect-pair-success.txt
Content-Type: text/plain;
	x-unix-mode=0644;
	name="btmon-connect-pair-success.txt"
Content-Transfer-Encoding: quoted-printable

=3D New Index: 00:1A:7D:DA:71:11 (Primary,USB,hci0)                      =
                        [hci0] 0.870196
=3D Open Index: 00:1A:7D:DA:71:11                                        =
                        [hci0] 0.870197
=3D Index Info: 00:1A:7D:DA:71:11 (Cambridge Silicon Radio)              =
                        [hci0] 0.870197
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7               =
                      [hci0] 3.642972
        Type: Passive (0x00)
        Interval: 60.000 msec (0x0060)
        Window: 30.000 msec (0x0030)
        Own address type: Public (0x00)
        Filter policy: Ignore not in white list (0x01)
> HCI Event: Command Complete (0x0e) plen 4                              =
                      [hci0] 3.657109
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2                   =
                      [hci0] 3.657179
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                              =
                      [hci0] 3.660373
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 25                                =
                      [hci0] 3.691582
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable undirected - ADV_IND (0x00)
        Address type: Public (0x00)
        Address: B4:99:4C:5A:B1:17 (Texas Instruments)
        Data length: 13
        Flags: 0x05
          LE Limited Discoverable Mode
          BR/EDR Not Supported
        16-bit Service UUIDs (partial): 1 entry
          Weight Scale (0x181d)
        Slave Conn. Interval: 0x0040 - 0x0050
        RSSI: -72 dBm (0xb8)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2                   =
                      [hci0] 3.691663
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                              =
                      [hci0] 3.694600
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Create Connection (0x08|0x000d) plen 25                =
                      [hci0] 3.694653
        Scan interval: 60.000 msec (0x0060)
        Scan window: 60.000 msec (0x0060)
        Filter policy: White list is not used (0x00)
        Peer address type: Public (0x00)
        Peer address: B4:99:4C:5A:B1:17 (Texas Instruments)
        Own address type: Public (0x00)
        Min connection interval: 50.00 msec (0x0028)
        Max connection interval: 70.00 msec (0x0038)
        Connection latency: 0x0000
        Supervision timeout: 420 msec (0x002a)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                                =
                      [hci0] 3.704121
      LE Create Connection (0x08|0x000d) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19                                =
                      [hci0] 3.723758
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 70
        Role: Master (0x00)
        Peer address type: Public (0x00)
        Peer address: B4:99:4C:5A:B1:17 (Texas Instruments)
        Connection interval: 70.00 msec (0x0038)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x00
< HCI Command: LE Read Remote Used Features (0x08|0x0016) plen 2         =
                      [hci0] 3.723883
        Handle: 70
@ Device Connected: B4:99:4C:5A:B1:17 (1) flags 0x0000
        02 01 05 03 02 1d 18 05 12 40 00 50 00           .........@.P.
> HCI Event: Command Status (0x0f) plen 4                                =
                      [hci0] 3.728065
      LE Read Remote Used Features (0x08|0x0016) ncmd 1
        Status: Success (0x00)
> ACL Data RX: Handle 70 flags 0x02 dlen 6                               =
                      [hci0] 3.750619
      SMP: Security Request (0x0b) len 1
        Authentication requirement: Bonding, No MITM, Legacy, No =
Keypresses (0x01)
> HCI Event: LE Meta Event (0x3e) plen 12                                =
                      [hci0] 3.814706
      LE Read Remote Used Features (0x04)
        Status: Success (0x00)
        Handle: 70
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          LE Encryption
< ACL Data TX: Handle 70 flags 0x00 dlen 11                              =
                      [hci0] 3.814791
      SMP: Pairing Request (0x01) len 6
        IO capability: NoInputNoOutput (0x03)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, No MITM, Legacy, No =
Keypresses (0x01)
        Max encryption key size: 16
        Initiator key distribution: EncKey Sign (0x05)
        Responder key distribution: EncKey IdKey Sign (0x07)
< ACL Data TX: Handle 70 flags 0x00 dlen 7                               =
                      [hci0] 3.815307
      ATT: Exchange MTU Request (0x02) len 2
        Client RX MTU: 517
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 3.883675
        Num handles: 1
        Handle: 70
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 3.887715
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 11                              =
                      [hci0] 3.953584
      SMP: Pairing Response (0x02) len 6
        IO capability: NoInputNoOutput (0x03)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, No MITM, Legacy, No =
Keypresses (0x01)
        Max encryption key size: 16
        Initiator key distribution: EncKey Sign (0x05)
        Responder key distribution: EncKey IdKey Sign (0x07)
< ACL Data TX: Handle 70 flags 0x00 dlen 21                              =
                      [hci0] 3.953669
      SMP: Pairing Confirm (0x03) len 16
        Confim value: 7f8a4c7d0bc1672f67a528852f542a93
> ACL Data RX: Handle 70 flags 0x02 dlen 7                               =
                      [hci0] 3.956821
      ATT: Exchange MTU Response (0x03) len 2
        Server RX MTU: 23
< ACL Data TX: Handle 70 flags 0x00 dlen 11                              =
                      [hci0] 3.957050
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 4.023499
        Num handles: 1
        Handle: 70
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 4.027304
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 21                              =
                      [hci0] 4.093654
      SMP: Pairing Confirm (0x03) len 16
        Confim value: 04e8fb183f7ad33c192c5a9f7832720a
< ACL Data TX: Handle 70 flags 0x00 dlen 21                              =
                      [hci0] 4.093714
      SMP: Pairing Random (0x04) len 16
        Random value: 903f505b2cea77fe740995bfc0d87295
> ACL Data RX: Handle 70 flags 0x02 dlen 24                              =
                      [hci0] 4.096383
      ATT: Read By Group Type Response (0x11) len 19
        Attribute data length: 6
        Attribute group list: 3 entries
        Handle range: 0x0001-0x000b
        UUID: Generic Access Profile (0x1800)
        Handle range: 0x000c-0x000f
        UUID: Generic Attribute Profile (0x1801)
        Handle range: 0x0010-0x0017
        UUID: Weight Scale (0x181d)
< ACL Data TX: Handle 70 flags 0x00 dlen 11                              =
                      [hci0] 4.096657
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0018-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 4.163486
        Num handles: 1
        Handle: 70
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 4.172843
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 21                              =
                      [hci0] 4.233599
      SMP: Pairing Random (0x04) len 16
        Random value: fba433429fd4bda947f2e473268b3a58
< HCI Command: LE Start Encryption (0x08|0x0019) plen 28                 =
                      [hci0] 4.233673
        Handle: 70
        Random number: 0x0000000000000000
        Encrypted diversifier: 0x0000
        Long term key: d80492d7d0b6fe8073ce6b7cdd0e5ffd
> ACL Data RX: Handle 70 flags 0x02 dlen 18                              =
                      [hci0] 4.242011
      ATT: Read By Group Type Response (0x11) len 13
        Attribute data length: 6
        Attribute group list: 2 entries
        Handle range: 0x0018-0x0028
        UUID: Device Information (0x180a)
        Handle range: 0x0029-0x002b
        UUID: Battery Service (0x180f)
< ACL Data TX: Handle 70 flags 0x00 dlen 11                              =
                      [hci0] 4.242132
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x002c-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Command Status (0x0f) plen 4                                =
                      [hci0] 4.251607
      LE Start Encryption (0x08|0x0019) ncmd 1
        Status: Success (0x00)
> HCI Event: Encryption Change (0x08) plen 4                             =
                      [hci0] 4.654281
        Status: Success (0x00)
        Handle: 70
        Encryption: Enabled with AES-CCM (0x01)
> ACL Data RX: Handle 70 flags 0x02 dlen 21                              =
                      [hci0] 4.723336
      SMP: Encryption Information (0x06) len 16
        Long term key: 6d69de2e99daad69b2bea77702fb3043
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 4.724125
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 26                              =
                      [hci0] 4.800961
      ATT: Read By Group Type Response (0x11) len 21
        Attribute data length: 20
        Attribute group list: 1 entry
        Handle range: 0x002c-0xffff
        UUID: Vendor specific (233bf000-5a34-1b6d-975c-000d5690abe4)
< ACL Data TX: Handle 70 flags 0x00 dlen 11                              =
                      [hci0] 4.801186
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Secondary Service (0x2801)
> ACL Data RX: Handle 70 flags 0x02 dlen 15                              =
                      [hci0] 4.801891
      SMP: Master Identification (0x07) len 10
        EDIV: 0xbf54
        Rand: 0xfdc297afbf313157
> ACL Data RX: Handle 70 flags 0x02 dlen 21                              =
                      [hci0] 4.869934
      SMP: Identity Information (0x08) len 16
        Identity resolving key: 3a586f919e2ded6a764e7ba47ba21b22
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 4.877280
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 9                               =
                      [hci0] 4.933130
      ATT: Error Response (0x01) len 4
        Read By Group Type Request (0x10)
        Handle: 0x0001
        Error: Unsupported Group Type (0x10)
< ACL Data TX: Handle 70 flags 0x00 dlen 11                              =
                      [hci0] 4.933262
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0001-0x000b
        Attribute type: Include (0x2802)
> ACL Data RX: Handle 70 flags 0x02 dlen 12                              =
                      [hci0] 4.935629
      SMP: Identity Address Information (0x09) len 7
        Address type: Public (0x00)
        Address: B4:99:4C:5A:B1:17
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 5.004122
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 21                              =
                      [hci0] 5.004152
      SMP: Signing Information (0x0a) len 16
        Signature key: 73447ba43ba21fd23549af94123d258f
< ACL Data TX: Handle 70 flags 0x00 dlen 21                              =
                      [hci0] 5.004227
      SMP: Encryption Information (0x06) len 16
        Long term key: d4b5743229950548514e89827f3461e1
< ACL Data TX: Handle 70 flags 0x00 dlen 15                              =
                      [hci0] 5.004233
      SMP: Master Identification (0x07) len 10
        EDIV: 0xa3b4
        Rand: 0xbf95f53201bf0eac
< ACL Data TX: Handle 70 flags 0x00 dlen 21                              =
                      [hci0] 5.004237
      SMP: Signing Information (0x0a) len 16
        Signature key: 51138d894b8ab1ec6cc0ea33d5baa3a5
@ New IRK: B4:99:4C:5A:B1:17 (1) 00:00:00:00:00:00
@ New CSRK: B4:99:4C:5A:B1:17 (1) Remote Unauthenticated (1)
@ New CSRK: B4:99:4C:5A:B1:17 (1) Local Unauthenticated (0)
@ New Long Term Key: B4:99:4C:5A:B1:17 (1) Master (Unauthenticated) 0x00
@ New Long Term Key: B4:99:4C:5A:B1:17 (1) Slave (Unauthenticated) 0x00
> ACL Data RX: Handle 70 flags 0x02 dlen 9                               =
                      [hci0] 5.073066
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0001
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 70 flags 0x00 dlen 11                              =
                      [hci0] 5.073251
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x000c-0x000f
        Attribute type: Include (0x2802)
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 5.073943
        Num handles: 1
        Handle: 70
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 5.082022
        Num handles: 1
        Handle: 70
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 5.084085
        Num handles: 1
        Handle: 70
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 5.151097
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 9                               =
                      [hci0] 5.213022
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x000c
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 70 flags 0x00 dlen 11                              =
                      [hci0] 5.213200
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0010-0x0017
        Attribute type: Include (0x2802)
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 5.290036
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 9                               =
                      [hci0] 5.352984
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0010
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 70 flags 0x00 dlen 11                              =
                      [hci0] 5.353101
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0018-0x0028
        Attribute type: Include (0x2802)
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 5.422815
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 9                               =
                      [hci0] 5.492877
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0018
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 70 flags 0x00 dlen 11                              =
                      [hci0] 5.493015
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0029-0x002b
        Attribute type: Include (0x2802)
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 5.571736
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 9                               =
                      [hci0] 5.639527
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0029
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 70 flags 0x00 dlen 11                              =
                      [hci0] 5.639703
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x002c-0xffff
        Attribute type: Include (0x2802)
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 5.702787
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 9                               =
                      [hci0] 5.772697
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x002c
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 70 flags 0x00 dlen 11                              =
                      [hci0] 5.772846
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0001-0x000b
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 5.851078
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 27                              =
                      [hci0] 5.982759
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 7
        Attribute data list: 3 entries
        Handle: 0x0002
        Value: 020300002a
        Handle: 0x0004
        Value: 020500012a
        Handle: 0x0006
        Value: 0a0700022a
< ACL Data TX: Handle 70 flags 0x00 dlen 11                              =
                      [hci0] 5.982946
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0007-0x000b
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 6.061244
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 20                              =
                      [hci0] 6.122500
      ATT: Read By Type Response (0x09) len 15
        Attribute data length: 7
        Attribute data list: 2 entries
        Handle: 0x0008
        Value: 080900032a
        Handle: 0x000a
        Value: 020b00042a
< ACL Data TX: Handle 70 flags 0x00 dlen 11                              =
                      [hci0] 6.122752
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x000b-0x000b
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 6.192532
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 9                               =
                      [hci0] 6.262468
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x000b
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 70 flags 0x00 dlen 11                              =
                      [hci0] 6.262686
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x000c-0x000f
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 6.332370
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 13                              =
                      [hci0] 6.409131
      ATT: Read By Type Response (0x09) len 8
        Attribute data length: 7
        Attribute data list: 1 entry
        Handle: 0x000d
        Value: 200e00052a
< ACL Data TX: Handle 70 flags 0x00 dlen 11                              =
                      [hci0] 6.409295
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x000e-0x000f
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 6.480441
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 9                               =
                      [hci0] 6.542296
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x000e
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 70 flags 0x00 dlen 9                               =
                      [hci0] 6.542470
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x000f-0x000f
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 6.612301
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 10                              =
                      [hci0] 6.682219
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x000f
        UUID: Client Characteristic Configuration (0x2902)
< ACL Data TX: Handle 70 flags 0x00 dlen 11                              =
                      [hci0] 6.682354
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0010-0x0017
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 6.759307
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 27                              =
                      [hci0] 6.831058
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 7
        Attribute data list: 3 entries
        Handle: 0x0011
        Value: 2012009d2a
        Handle: 0x0014
        Value: 0215009e2a
        Handle: 0x0016
        Value: 0a1700082a
< ACL Data TX: Handle 70 flags 0x00 dlen 11                              =
                      [hci0] 6.831172
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0017-0x0017
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 6.900953
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 9                               =
                      [hci0] 6.962089
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0017
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 70 flags 0x00 dlen 9                               =
                      [hci0] 6.962277
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x0013-0x0013
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 7.032195
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 10                              =
                      [hci0] 7.102042
      ATT: Find Information Response (0x05) len 5
        Format: UUID-16 (0x01)
        Handle: 0x0013
        UUID: Client Characteristic Configuration (0x2902)
< ACL Data TX: Handle 70 flags 0x00 dlen 11                              =
                      [hci0] 7.102195
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0018-0x0028
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 7.171896
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 27                              =
                      [hci0] 7.248824
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 7
        Attribute data list: 3 entries
        Handle: 0x0019
        Value: 021a00292a
        Handle: 0x001b
        Value: 021c00242a
        Handle: 0x001d
        Value: 021e00252a
< ACL Data TX: Handle 70 flags 0x00 dlen 11                              =
                      [hci0] 7.249130
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x001e-0x0028
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 7.312022
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 27                              =
                      [hci0] 7.382097
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 7
        Attribute data list: 3 entries
        Handle: 0x001f
        Value: 022000272a
        Handle: 0x0021
        Value: 022200262a
        Handle: 0x0023
        Value: 022400282a
< ACL Data TX: Handle 70 flags 0x00 dlen 11                              =
                      [hci0] 7.382249
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0024-0x0028
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 7.451921
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 20                              =
                      [hci0] 7.521826
      ATT: Read By Type Response (0x09) len 15
        Attribute data length: 7
        Attribute data list: 2 entries
        Handle: 0x0025
        Value: 022600232a
        Handle: 0x0027
        Value: 0228002a2a
< ACL Data TX: Handle 70 flags 0x00 dlen 11                              =
                      [hci0] 7.521951
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0028-0x0028
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 7.598963
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 9                               =
                      [hci0] 7.661746
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x0028
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 70 flags 0x00 dlen 11                              =
                      [hci0] 7.661982
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x0029-0x002b
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 7.740333
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 13                              =
                      [hci0] 7.801778
      ATT: Read By Type Response (0x09) len 8
        Attribute data length: 7
        Attribute data list: 1 entry
        Handle: 0x002a
        Value: 022b00192a
< ACL Data TX: Handle 70 flags 0x00 dlen 11                              =
                      [hci0] 7.801989
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x002b-0x002b
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 7.871587
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 9                               =
                      [hci0] 7.950281
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x002b
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 70 flags 0x00 dlen 11                              =
                      [hci0] 7.950408
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x002c-0xffff
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 8.020184
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 27                              =
                      [hci0] 8.088490
      ATT: Read By Type Response (0x09) len 22
        Attribute data length: 21
        Attribute data list: 1 entry
        Handle: 0x002d
        Value: 0a2e00e4ab90560d005c976d1b345a01f03b23
< ACL Data TX: Handle 70 flags 0x00 dlen 11                              =
                      [hci0] 8.088604
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x002e-0xffff
        Attribute type: Characteristic (0x2803)
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 8.151427
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 9                               =
                      [hci0] 8.221321
      ATT: Error Response (0x01) len 4
        Read By Type Request (0x08)
        Handle: 0x002e
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 70 flags 0x00 dlen 9                               =
                      [hci0] 8.221493
      ATT: Find Information Request (0x04) len 4
        Handle range: 0x002f-0xffff
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 8.291494
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 9                               =
                      [hci0] 8.361393
      ATT: Error Response (0x01) len 4
        Find Information Request (0x04)
        Handle: 0x002f
        Error: Attribute Not Found (0x0a)
< ACL Data TX: Handle 70 flags 0x00 dlen 9                               =
                      [hci0] 8.364880
      ATT: Write Request (0x12) len 4
        Handle: 0x000f
          Data: 0200
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 8.431463
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 5                               =
                      [hci0] 8.516815
      ATT: Write Response (0x13) len 0
< ACL Data TX: Handle 70 flags 0x00 dlen 7                               =
                      [hci0] 8.516980
      ATT: Read Request (0x0a) len 2
        Handle: 0x0003
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 8.571233
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 25                              =
                      [hci0] 8.641288
      ATT: Read Response (0x0b) len 20
        Value: 4126445f55432d333532424c455f354142313137
< ACL Data TX: Handle 70 flags 0x00 dlen 7                               =
                      [hci0] 8.641433
      ATT: Read Request (0x0a) len 2
        Handle: 0x0005
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                      [hci0] 8.720173
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 7                               =
                      [hci0] 8.781225
      ATT: Read Response (0x0b) len 2
        Value: 0000
> ACL Data RX: Handle 70 flags 0x02 dlen 16                              =
                     [hci0] 13.888600
      LE L2CAP: Connection Parameter Update Request (0x12) ident 1 len 8
        Min interval: 64
        Max interval: 80
        Slave latency: 0
        Timeout multiplier: 300
< ACL Data TX: Handle 70 flags 0x00 dlen 10                              =
                     [hci0] 13.888662
      LE L2CAP: Connection Parameter Update Response (0x13) ident 1 len =
2
        Result: Connection Parameters accepted (0x0000)
< HCI Command: LE Connection Update (0x08|0x0013) plen 14                =
                     [hci0] 13.888671
        Handle: 70
        Min connection interval: 80.00 msec (0x0040)
        Max connection interval: 100.00 msec (0x0050)
        Connection latency: 0x0000
        Supervision timeout: 3000 msec (0x012c)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
@ New Conn Param: B4:99:4C:5A:B1:17 (1) hint 1 min 0x0040 max 0x0050 =
latency 0x0000 timeout 0x012c
> HCI Event: Command Status (0x0f) plen 4                                =
                     [hci0] 13.908558
      LE Connection Update (0x08|0x0013) ncmd 1
        Status: Success (0x00)
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
                     [hci0] 13.968352
        Num handles: 1
        Handle: 70
        Count: 1
> HCI Event: LE Meta Event (0x3e) plen 10                                =
                     [hci0] 14.377308
      LE Connection Update Complete (0x03)
        Status: Success (0x00)
        Handle: 70
        Connection interval: 100.00 msec (0x0050)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 3000 msec (0x012c)=

--Apple-Mail=_A225BF13-29D0-47FC-BB02-08963F5FBFB7--
