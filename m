Return-Path: <cyrus@holtmann.org>
MIME-version: 1.0
Content-type: text/plain; CHARSET=US-ASCII
Subject: Re: LE mouse reconnect problem
From: d.eriksson@me.com
In-reply-to: <5A1EE16D-11BB-414E-B572-92FBF305B4E5@holtmann.org>
Date: Thu, 03 Jul 2014 17:18:58 +0200
Cc: Ryan Press <ryan@presslab.us>, Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-id: <35F01C64-F255-433B-A07A-1AD84CA6574A@me.com>
References: 
 <CABx3TkUE_qFJggDNw8wUCcQzrdo6L5p3Ag3djpiUewwk_uJu5Q@mail.gmail.com>
 <CABBYNZLhONv81vAN8OAFX1dK5UCm44AYb2sZLyUp2gRQ4CywcA@mail.gmail.com>
 <CABx3TkVgs6J1UR8Z5Rbyd2e90p74RfggpzsvnxzgWGgN9c2Epg@mail.gmail.com>
 <CABx3TkUbD+svVpNW+0vjWS3pujZsECTOO0XxJmUQY6wOEkkZQw@mail.gmail.com>
 <CABBYNZKyd_jgSO-NpzbMhVo=Y1ZzWC29bX4q1YBQd73Mm4HWaQ@mail.gmail.com>
 <CABx3TkW-PhVeD2=Nr2pj5iL2uUm8T0B+w+WFB2EwaeW7OtChtQ@mail.gmail.com>
 <CABBYNZK2v-US-kOh6v28EKnqsLyjXrDUGpNJE6Wcfqv3YBwm9A@mail.gmail.com>
 <CABx3TkU+JvmekRYBS1iYuriJaprMznH=g6vw2MVYi+2Vqc7Y5w@mail.gmail.com>
 <CABx3TkXsRXUNG4RudXnYifyN4Tq4MssVGXZE6uQtPtxU34bw7A@mail.gmail.com>
 <20140629051442.GA31085@t440s.P-661HNU-F1> <20140629052949.GA32130@t440s>
 <E8C350F2-6B3C-4ECD-A281-DDC25C339489@holtmann.org>
 <CABx3TkUP3Y9nJJk=u2ghFnunQRh9x-v6PG_ncyiM+mUqaoRtWg@mail.gmail.com>
 <5A1EE16D-11BB-414E-B572-92FBF305B4E5@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Somewhat hijacking this thread as we've been working on similar issues. 
In the Nordic Semi HID code they by default set 5sec for the "FIRST_CONN_PARAMS_UPDATE_DELAY". As a temporary fix we just se this to 50msec to force a quicker re-connect.

We're doing our pairing using mgmt, could there be something we do wrong on our end causing the CCCDs not being stored in our nrf51822, and/or on the linux side?

best
David

< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7                                                                      [hci0] 134.414928
        Type: Active (0x01)
        Interval: 11.250 msec (0x0012)
        Window: 11.250 msec (0x0012)
        Own address type: Public (0x00)
        Filter policy: Accept all advertisement (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                                                                     [hci0] 134.421589
      LE Set Scan Parameters (0x08|0x000b) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2                                                                          [hci0] 134.421659
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
> HCI Event: Command Complete (0x0e) plen 4                                                                                     [hci0] 134.422590
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 12                                                                                       [hci0] 134.424481
      LE Advertising Report (0x02)
        Num reports: 1
        Event type: Connectable directed - ADV_DIRECT_IND (0x01)
        Address type: Random (0x01)
        Address: F1:4A:67:6A:B7:FF (Static)
        Data length: 0
        RSSI: -73 dBm (0xb7)
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2                                                                          [hci0] 134.425082
        Scanning: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
> HCI Event: Command Complete (0x0e) plen 4                                                                                     [hci0] 134.425657
      LE Set Scan Enable (0x08|0x000c) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Create Connection (0x08|0x000d) plen 25                                                                       [hci0] 134.426180
        Scan interval: 2.500 msec (0x0004)
        Scan window: 2.500 msec (0x0004)
        Filter policy: White list is not used (0x00)
        Peer address type: Random (0x01)
        Peer address: F1:4A:67:6A:B7:FF (Static)
        Own address type: Public (0x00)
        Min connection interval: 50.00 msec (0x0028)
        Max connection interval: 70.00 msec (0x0038)
        Connection latency: 0x0000
        Supervision timeout: 420 msec (0x002a)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                                                                                       [hci0] 134.426831
      LE Create Connection (0x08|0x000d) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19                                                                                       [hci0] 134.432082
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 1025
        Role: Master (0x00)
        Peer address type: Random (0x01)
        Peer address: F1:4A:67:6A:B7:FF (Static)
        Connection interval: 70.00 msec (0x0038)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x01
< HCI Command: LE Start Encryption (0x08|0x0019) plen 28                                                                        [hci0] 134.441984
        Handle: 1025
        Random number: 0x3e0636865278ea8f
        Encrypted diversifier: 0x9bf8
        Long term key: fd90856caeb6478e9ff9cbeea73bdd4a
> HCI Event: Command Status (0x0f) plen 4                                                                                       [hci0] 134.442966
      LE Start Encryption (0x08|0x0019) ncmd 1
        Status: Success (0x00)
@ Discovering: 0x01 (6)
@ Device Found: F1:4A:67:6A:B7:FF (2) rssi -73 flags 0x0000
@ Discovering: 0x00 (6)
@ Device Connected: F1:4A:67:6A:B7:FF (2) flags 0x0000
> HCI Event: Encryption Change (0x08) plen 4                                                                                    [hci0] 135.019652
        Status: Success (0x00)
        Handle: 1025
        Encryption: Enabled with AES-CCM (0x01)
< ACL Data TX: Handle 1025 flags 0x00 dlen 11                                                                                   [hci0] 135.021069
      ATT: Read By Type Request (0x08) len 6
        Handle range: 0x000c-0x0010
        Attribute type: Characteristic (0x2803)
> ACL Data RX: Handle 1025 flags 0x02 dlen 20                                                                                   [hci0] 135.298900
      ATT: Read By Type Response (0x09) len 15
        Attribute data length: 7
        Attribute data list: 2 entries
        Handle: 0x000d
        Value: 020e00292a
        Handle: 0x000f
        Value: 021000502a
< ACL Data TX: Handle 1025 flags 0x00 dlen 7                                                                                    [hci0] 135.299576
      ATT: Exchange MTU Request (0x02) len 2
        Client RX MTU: 672
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                          [hci0] 135.327848
        Num handles: 1
        Handle: 1025
        Count: 1
> ACL Data RX: Handle 1025 flags 0x02 dlen 7                                                                                    [hci0] 135.438638
      ATT: Exchange MTU Response (0x03) len 2
        Server RX MTU: 23
< ACL Data TX: Handle 1025 flags 0x00 dlen 7                                                                                    [hci0] 135.439219
      ATT: Read Request (0x0a) len 2
        Handle: 0x0010
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                          [hci0] 135.467853
        Num handles: 1
        Handle: 1025
        Count: 1
> ACL Data RX: Handle 1025 flags 0x02 dlen 12                                                                                   [hci0] 135.578881
      ATT: Read Response (0x0b) len 7
        Value: 02672302000100
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                          [hci0] 135.607860
        Num handles: 1
        Handle: 1025
        Count: 1
> ACL Data RX: Handle 1025 flags 0x02 dlen 16                                                                                   [hci0] 139.499097
      LE L2CAP: Connection Parameter Update Request (0x12) ident 2 len 8
        Min interval: 6
        Max interval: 24
        Slave latency: 6
        Timeout multiplier: 30
< ACL Data TX: Handle 1025 flags 0x00 dlen 10                                                                                   [hci0] 139.499205
      LE L2CAP: Connection Parameter Update Response (0x13) ident 2 len 2
        Result: Connection Parameters accepted (0x0000)
< HCI Command: LE Connection Update (0x08|0x0013) plen 14                                                                       [hci0] 139.499244
        Handle: 1025
        Min connection interval: 7.50 msec (0x0006)
        Max connection interval: 30.00 msec (0x0018)
        Connection latency: 0x0006
        Supervision timeout: 300 msec (0x001e)
        Min connection length: 0.625 msec (0x0001)
        Max connection length: 0.625 msec (0x0001)
> HCI Event: Command Status (0x0f) plen 4                                                                                       [hci0] 139.499818
      LE Connection Update (0x08|0x0013) ncmd 1
        Status: Success (0x00)
> HCI Event: Number of Completed Packets (0x13) plen 5                                                                          [hci0] 139.738212
        Num handles: 1
        Handle: 1025
        Count: 1
> ACL Data RX: Handle 1025 flags 0x02 dlen 10                                                                                   [hci0] 139.997853
      ATT: Handle Value Notification (0x1b) len 5
        Handle: 0x0019
          Data: 012401
> HCI Event: LE Meta Event (0x3e) plen 10                                                                                       [hci0] 139.999622
      LE Connection Update Complete (0x03)
        Status: Success (0x00)
        Handle: 1025
        Connection interval: 28.75 msec (0x0017)
        Connection latency: 7.50 msec (0x0006)
        Supervision timeout: 300 msec (0x001e)




On 29 Jun 2014, at 19:52, Marcel Holtmann <marcel@holtmann.org> wrote:

> this is a kernel issue with not remembering the previous connection parameters. What you see is that we start connecting with the default values and then the slave (the mouse) will correct us and tell us what connection parameters it needs. We accept them and actually change the LE link to use these parameters. However we end up forgetting them. So every time you connect this procedure keeps repeating itself.
> 
> I fixed this as well, but for that you will need a bluetooth-next kernel where I enabled the management API for passive scanning and a modified bluetoothd that will then allow you a smooth experience. If the slave updates the connection parameters we remember them for devices using auto-connection. So once the connection is triggered via passive scanning the values will be remembered.
> 
> At the moment, I have one minor issue with the re-connection within bluetoothd and once that is fixed this should be pretty instant.
> 
> Regards
> 
> Marcel
