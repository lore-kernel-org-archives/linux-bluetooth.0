Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_OfccWTVuphRQfjfouY3m8_HgSeGwE-XSyHetzy+tjFFw@mail.gmail.com>
References: <CACUGKYONE6a2PWtOEY4Kgg9TQkX3pCwhW9UJLk5KGVtpL5eVaw@mail.gmail.com>
	<CACUGKYPwTxRS8JN78J-oPSwz0mhnKvxHg=ybm5vyiKivEpM03A@mail.gmail.com>
	<20120910235838.GA26986@samus>
	<CACUGKYMP7YRu1=P4Uf9T_RfOKQFPvZq8sK+GGi0T1jB6GDXcDQ@mail.gmail.com>
	<CACUGKYN-+AKvVOZwxR7b6cvSujBMRHnjzNGcGezYynP2gTm6KA@mail.gmail.com>
	<CAJdJm_OfccWTVuphRQfjfouY3m8_HgSeGwE-XSyHetzy+tjFFw@mail.gmail.com>
Date: Thu, 13 Sep 2012 10:50:06 -0700
Message-ID: <CACUGKYMv_X4DgU+C0V=PA_PfYRQYnKO1LM4SoDbfcB2O-XkJvQ@mail.gmail.com>
Subject: Re: Dropping connection (bit off-topic)
From: John Tobias <john.tobias.ph@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

Here are the logs after reading the characteristic from my iPad apps
that do the advertising.

HCI sniffer - Bluetooth packet analyzer ver 2.2
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
    type 0x01 (active)
    interval 10.000ms window 10.000ms
    own address: 0x00 (Public) policy: All
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Parameters (0x08|0x000b) ncmd 1
    status 0x00
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
    value 0x01 (scanning enabled)
    filter duplicates 0x01 (enabled)
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Enable (0x08|0x000c) ncmd 1
    status 0x00
> HCI Event: LE Meta Event (0x3e) plen 43
    LE Advertising Report
      ADV_IND - Connectable undirected advertising (0)
      bdaddr 60:36:25:4A:6B:75 (Random)
      Flags: 0x1a
      Unknown type 0x07 with 16 bytes data
      Complete local name: 'Appl0001'
      RSSI: -62
> HCI Event: LE Meta Event (0x3e) plen 12
    LE Advertising Report
      SCAN_RSP - Scan Response (4)
      bdaddr 60:36:25:4A:6B:75 (Random)
      RSSI: -62
> HCI Event: LE Meta Event (0x3e) plen 43
    LE Advertising Report
      ADV_IND - Connectable undirected advertising (0)
      bdaddr 60:36:25:4A:6B:75 (Random)
      Flags: 0x1a
      Unknown type 0x07 with 16 bytes data
      Complete local name: 'Appl0001'
      RSSI: -60
> HCI Event: LE Meta Event (0x3e) plen 12
    LE Advertising Report
      SCAN_RSP - Scan Response (4)
      bdaddr 60:36:25:4A:6B:75 (Random)
      RSSI: -60
> HCI Event: LE Meta Event (0x3e) plen 43
    LE Advertising Report
      ADV_IND - Connectable undirected advertising (0)
      bdaddr 60:36:25:4A:6B:75 (Random)
      Flags: 0x1a
      Unknown type 0x07 with 16 bytes data
      Complete local name: 'Appl0001'
      RSSI: -62
> HCI Event: LE Meta Event (0x3e) plen 12
    LE Advertising Report
      SCAN_RSP - Scan Response (4)
      bdaddr 60:36:25:4A:6B:75 (Random)
      RSSI: -62
> HCI Event: LE Meta Event (0x3e) plen 43
    LE Advertising Report
      ADV_IND - Connectable undirected advertising (0)
      bdaddr 60:36:25:4A:6B:75 (Random)
      Flags: 0x1a
      Unknown type 0x07 with 16 bytes data
      Complete local name: 'Appl0001'
      RSSI: -69
> HCI Event: LE Meta Event (0x3e) plen 12
    LE Advertising Report
      SCAN_RSP - Scan Response (4)
      bdaddr 60:36:25:4A:6B:75 (Random)
      RSSI: -69
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
    value 0x00 (scanning disabled)
    filter duplicates 0x01 (enabled)
> HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Enable (0x08|0x000c) ncmd 1
    status 0x00
< HCI Command: LE Create Connection (0x08|0x000d) plen 25
    bdaddr 60:36:25:4A:6B:75 type 1
> HCI Event: Command Status (0x0f) plen 4
    LE Create Connection (0x08|0x000d) status 0x00 ncmd 1
> HCI Event: LE Meta Event (0x3e) plen 19
    LE Connection Complete
      status 0x00 handle 76, role master
      bdaddr 60:36:25:4A:6B:75 (Random)
> ACL data: handle 76 flags 0x02 dlen 11
    ATT: Read By Type req (0x08)
      start 0x0001, end 0xffff
      type-uuid 0x2a00
< ACL data: handle 76 flags 0x00 dlen 11
    ATT: Read By Type req (0x08)
      start 0x0001, end 0xffff
      type-uuid 0x2803
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 76 packets 1
> ACL data: handle 76 flags 0x02 dlen 27
    ATT: Read By Type resp (0x09)
      length: 7
        handle 0x0002, value 0x02 0x03 0x00 0x00 0x2a
        handle 0x0004, value 0x02 0x05 0x00 0x01 0x2a
        handle 0x0007, value 0x20 0x08 0x00 0x05 0x2a
< ACL data: handle 76 flags 0x00 dlen 11
    ATT: Read By Type req (0x08)
      start 0x0008, end 0xffff
      type-uuid 0x2803
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 76 packets 1
> ACL data: handle 76 flags 0x02 dlen 27
    ATT: Read By Type resp (0x09)
      length: 21
        handle 0x000b, value 0x02 0x0c 0x00 0x31 0x3d 0x35 0x06 0x1e
0x60 0x70 0xa3 0x8d 0x4e 0x58 0x9c 0x2d 0x6a 0x3c 0x16
< ACL data: handle 76 flags 0x00 dlen 11
    ATT: Read By Type req (0x08)
      start 0x000c, end 0xffff
      type-uuid 0x2803
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 76 packets 1
> ACL data: handle 76 flags 0x02 dlen 27
    ATT: Read By Type resp (0x09)
      length: 21
        handle 0x000d, value 0x8a 0x0e 0x00 0x32 0x3d 0x35 0x06 0x1e
0x60 0x70 0xa3 0x8d 0x4e 0x58 0x9c 0x2d 0x6a 0x3c 0x16
< ACL data: handle 76 flags 0x00 dlen 11
    ATT: Read By Type req (0x08)
      start 0x000e, end 0xffff
      type-uuid 0x2803
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 76 packets 1
> ACL data: handle 76 flags 0x02 dlen 27
    ATT: Read By Type resp (0x09)
      length: 21
        handle 0x0010, value 0x88 0x11 0x00 0x33 0x3d 0x35 0x06 0x1e
0x60 0x70 0xa3 0x8d 0x4e 0x58 0x9c 0x2d 0x6a 0x3c 0x16
< ACL data: handle 76 flags 0x00 dlen 11
    ATT: Read By Type req (0x08)
      start 0x0011, end 0xffff
      type-uuid 0x2803
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 76 packets 1
> ACL data: handle 76 flags 0x02 dlen 27
    ATT: Read By Type resp (0x09)
      length: 21
        handle 0x0013, value 0x9a 0x14 0x00 0x52 0x72 0x3a 0x71 0xae
0x82 0x0c 0xae 0xe0 0x49 0x1d 0x18 0xc2 0xb4 0xd8 0x37
< ACL data: handle 76 flags 0x00 dlen 11
    ATT: Read By Type req (0x08)
      start 0x0014, end 0xffff
      type-uuid 0x2803
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 76 packets 1
> ACL data: handle 76 flags 0x02 dlen 27
    ATT: Read By Type resp (0x09)
      length: 21
        handle 0x0017, value 0x9a 0x18 0x00 0x36 0x72 0x3a 0x71 0xae
0x82 0x0c 0xae 0xe0 0x49 0x1d 0x18 0xc2 0xb4 0xd8 0x37
< ACL data: handle 76 flags 0x00 dlen 11
    ATT: Read By Type req (0x08)
      start 0x0018, end 0xffff
      type-uuid 0x2803
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 76 packets 1
> ACL data: handle 76 flags 0x02 dlen 27
    ATT: Read By Type resp (0x09)
      length: 21
        handle 0x001b, value 0x9a 0x1c 0x00 0x37 0x72 0x3a 0x71 0xae
0x82 0x0c 0xae 0xe0 0x49 0x1d 0x18 0xc2 0xb4 0xd8 0x37
< ACL data: handle 76 flags 0x00 dlen 11
    ATT: Read By Type req (0x08)
      start 0x001c, end 0xffff
      type-uuid 0x2803
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 76 packets 1
> ACL data: handle 76 flags 0x02 dlen 27
    ATT: Read By Type resp (0x09)
      length: 21
        handle 0x001f, value 0x8a 0x20 0x00 0x38 0x72 0x3a 0x71 0xae
0x82 0x0c 0xae 0xe0 0x49 0x1d 0x18 0xc2 0xb4 0xd8 0x37
< ACL data: handle 76 flags 0x00 dlen 11
    ATT: Read By Type req (0x08)
      start 0x0020, end 0xffff
      type-uuid 0x2803
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 76 packets 1
> ACL data: handle 76 flags 0x02 dlen 27
    ATT: Read By Type resp (0x09)
      length: 21
        handle 0x0022, value 0x98 0x23 0x00 0x40 0x72 0x3a 0x71 0xae
0x82 0x0c 0xae 0xe0 0x49 0x1d 0x18 0xc2 0xb4 0xd8 0x37
< ACL data: handle 76 flags 0x00 dlen 11
    ATT: Read By Type req (0x08)
      start 0x0023, end 0xffff
      type-uuid 0x2803
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 76 packets 1
> ACL data: handle 76 flags 0x02 dlen 27
    ATT: Read By Type resp (0x09)
      length: 21
        handle 0x0026, value 0x9a 0x27 0x00 0x41 0x72 0x3a 0x71 0xae
0x82 0x0c 0xae 0xe0 0x49 0x1d 0x18 0xc2 0xb4 0xd8 0x37
< ACL data: handle 76 flags 0x00 dlen 11
    ATT: Read By Type req (0x08)
      start 0x0027, end 0xffff
      type-uuid 0x2803
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 76 packets 1
> ACL data: handle 76 flags 0x02 dlen 27
    ATT: Read By Type resp (0x09)
      length: 21
        handle 0x002a, value 0x98 0x2b 0x00 0x42 0x72 0x3a 0x71 0xae
0x82 0x0c 0xae 0xe0 0x49 0x1d 0x18 0xc2 0xb4 0xd8 0x37
< ACL data: handle 76 flags 0x00 dlen 11
    ATT: Read By Type req (0x08)
      start 0x002b, end 0xffff
      type-uuid 0x2803
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 76 packets 1
> ACL data: handle 76 flags 0x02 dlen 27
    ATT: Read By Type resp (0x09)
      length: 21
        handle 0x002e, value 0x88 0x2f 0x00 0x60 0x72 0x3a 0x71 0xae
0x82 0x0c 0xae 0xe0 0x49 0x1d 0x18 0xc2 0xb4 0xd8 0x37
< ACL data: handle 76 flags 0x00 dlen 11
    ATT: Read By Type req (0x08)
      start 0x002f, end 0xffff
      type-uuid 0x2803
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 76 packets 1
> ACL data: handle 76 flags 0x02 dlen 27
    ATT: Read By Type resp (0x09)
      length: 21
        handle 0x0031, value 0x88 0x32 0x00 0x61 0x72 0x3a 0x71 0xae
0x82 0x0c 0xae 0xe0 0x49 0x1d 0x18 0xc2 0xb4 0xd8 0x37
< ACL data: handle 76 flags 0x00 dlen 11
    ATT: Read By Type req (0x08)
      start 0x0032, end 0xffff
      type-uuid 0x2803
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 76 packets 1
> ACL data: handle 76 flags 0x02 dlen 27
    ATT: Read By Type resp (0x09)
      length: 21
        handle 0x0034, value 0x12 0x35 0x00 0x62 0x72 0x3a 0x71 0xae
0x82 0x0c 0xae 0xe0 0x49 0x1d 0x18 0xc2 0xb4 0xd8 0x37
< ACL data: handle 76 flags 0x00 dlen 11
    ATT: Read By Type req (0x08)
      start 0x0035, end 0xffff
      type-uuid 0x2803
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 76 packets 1
> ACL data: handle 76 flags 0x02 dlen 27
    ATT: Read By Type resp (0x09)
      length: 21
        handle 0x0037, value 0x8a 0x38 0x00 0x39 0x72 0x3a 0x71 0xae
0x82 0x0c 0xae 0xe0 0x49 0x1d 0x18 0xc2 0xb4 0xd8 0x37
< ACL data: handle 76 flags 0x00 dlen 11
    ATT: Read By Type req (0x08)
      start 0x0038, end 0xffff
      type-uuid 0x2803
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 76 packets 1
> ACL data: handle 76 flags 0x02 dlen 9
    ATT: Error (0x01)
      Error: Attribute not found (10)
      Read By Type req (0x08) on handle 0x0039
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 76 reason 0x13
    Reason: Remote User Terminated Connection


Regards,

John



On Thu, Sep 13, 2012 at 3:53 AM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi John,
>
> On Wed, Sep 12, 2012 at 10:52 PM, John Tobias <john.tobias.ph@gmail.com> wrote:
>> Hello again,
>>
>> I enabled the GATT in my bluetoothd and found out that there was an
>> unimplemented attribute (below) and might be the reason why the iPhone
>> connection got disconnected after 30 secs.
>>
>> 2012-09-12 15:36:55.419980 > ACL data: handle 76 flags 0x02 dlen 9
>>     ATT: Error (0x01)
>>       Error: Attribute not found (10)
>>       Read By Type req (0x08) on handle 0x0039
>>
>> I would like to know if anyone here has a patch?.
>
> Just this snippet does not say much. "Attribute not found" errors are
> common during service/characteristic discovery because they indicate
> that the discovery has finished.
>
> Could you post the whole hcidump since the connection establishment up
> to the disconnection? That should help detecting the problem.
>
> Best Regards,
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil
