Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Kropf Johannes <Johannes.Kropf@ait.ac.at>
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: AW: 5.41 - Authentication Failed with kernel 4.2.0
Date: Wed, 10 Aug 2016 11:06:05 +0000
Message-ID: <E92610C73D6DE84EB154DC52F5ECCE541D748ADC@S0MSMAIL111.arc.local>
References: <E92610C73D6DE84EB154DC52F5ECCE541D74740E@S0MSMAIL111.arc.local>
 <20160808094255.GA8136@t440s.lan>
 <E92610C73D6DE84EB154DC52F5ECCE541D7479B6@S0MSMAIL111.arc.local>
 <20160809143212.GA10222@t440s.P-661HNU-F1>
In-Reply-To: <20160809143212.GA10222@t440s.P-661HNU-F1>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> -----Ursprüngliche Nachricht-----
> Von: Johan Hedberg [mailto:johan.hedberg@gmail.com]
> Gesendet: Dienstag, 9. August 2016 16:32
> An: Kropf Johannes
> Cc: linux-bluetooth@vger.kernel.org
> Betreff: Re: 5.41 - Authentication Failed with kernel 4.2.0
> 
> Hi Johannes,
> 
> Please don't drop the mailing list from the thread (added it back now).
> 
> On Tue, Aug 09, 2016, Kropf Johannes wrote:
> > > On Mon, Aug 08, 2016, Kropf Johannes wrote:
> > > > we had a problem when attempting to pair low energy devices on
> > > > Ubuntu
> > > with kernel version 4.2.0-42-generic:
> > > > After scanning there always occured an "authentication failed" error.
> > > > The devices we tried to pair were a A&D UC-352-BLE weighing scale
> > > > and a
> > > A&D UA-651BLE blood pressure monitor.
> > > > Both devices can be paired on the same machine with the same setup
> > > > but
> > > with kernel version 3.13.0.92.
> > > > Unfortunately the log doesn't give me an idea what the problem is.
> > > >
> > > > Here is the output using bluetoothctl:
> > > > [bluetooth]# pair 5C:31:3E:5E:54:5E Attempting to pair with
> > > > 5C:31:3E:5E:54:5E [CHG] Device 5C:31:3E:5E:54:5E Connected: yes
> > > > Failed to pair:
> > > > org.bluez.Error.AuthenticationFailed
> > > > [CHG] Device 5C:31:3E:5E:54:5E Connected: no
> > >
> > > Did you also have an agent registered? (e.g. "agent KeyboardDisplay"
> > > in
> > > bluetoothctl)
> > Yes, an agent was registered in bluetoothctl with "agent on"
> 
> Ok, good. It shouldn't make a difference for pairings initiated from the local
> side, but just in case, did you also issue "default-agent"?
> 
> > > What would give an even better view of what's going on is the HCI logs.
> > > You can get those with the btmon tool (found under monitor/ in the
> > > BlueZ source tree).
> > Here is the output of btmon. Does it mean anything to you?
> > ....
> > < ACL Data TX: Handle 70 flags 0x00 dlen 11                    [hci0] 28.489379
> >       ATT: Read By Group Type Request (0x10) len 6
> >         Handle range: 0x0018-0xffff
> >         Attribute group type: Primary Service (0x2800)
> > > HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
> 28.559451
> >         Num handles: 1
> >         Handle: 70
> >         Count: 1
> > > HCI Event: Number of Completed Packets (0x13) plen 5         [hci0]
> 28.560451
> >         Num handles: 1
> >         Handle: 70
> >         Count: 1
> > > ACL Data RX: Handle 70 flags 0x02 dlen 6                     [hci0] 28.628456
> >       SMP: Pairing Failed (0x05) len 1
> >         Reason: Confirm value failed (0x04)
> > < HCI Command: Disconnect (0x01|0x0006) plen 3                 [hci0] 28.628506
> >         Handle: 70
> >         Reason: Authentication Failure (0x05)
> 
> To me this looks like the remote either rejected the pairing, or something else
> went wrong there. It'd help to see the full HCI log, particularly from the
> beginning of the SMP session, i.e. including the Pairing Request and Response
> PDUs.
> 
> Johan

Here is the whole log:

> HCI Event: Command Status (0x0f) plen 4                      [hci0] 28.080411
      LE Create Connection (0x08|0x000d) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19                      [hci0] 28.086410
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 70
        Role: Master (0x00)
        Peer address type: Public (0x00)
        Peer address: 5C:31:3E:5E:54:5E (OUI 5C-31-3E)
        Connection interval: 70.00 msec (0x0038)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x00
< HCI Command: LE Read Remote Used Fea.. (0x08|0x0016) plen 2  [hci0] 28.086498
        Handle: 70
@ Device Connected: 5C:31:3E:5E:54:5E (1) flags 0x0000
        02 01 05 03 02 1d 18 05 12 40 00 50 00           .........@.P.   
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 28.090427
      LE Read Remote Used Features (0x08|0x0016) ncmd 1
        Status: Success (0x00)
> ACL Data RX: Handle 70 flags 0x02 dlen 6                     [hci0] 28.145172
      SMP: Security Request (0x0b) len 1
        Authentication requirement: Bonding, No MITM, Legacy, No Keypresses (0x01)
> HCI Event: LE Meta Event (0x3e) plen 12                      [hci0] 28.209459
      LE Read Remote Used Features (0x04)
        Status: Success (0x00)
        Handle: 70
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          LE Encryption
< ACL Data TX: Handle 70 flags 0x00 dlen 11                    [hci0] 28.209526
      SMP: Pairing Request (0x01) len 6
        IO capability: NoInputNoOutput (0x03)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, No MITM, SC, No Keypresses (0x09)
        Max encryption key size: 16
        Initiator key distribution: EncKey Sign LinkKey (0x0d)
        Responder key distribution: EncKey IdKey Sign LinkKey (0x0f)
< ACL Data TX: Handle 70 flags 0x00 dlen 7                     [hci0] 28.209934
      ATT: Exchange MTU Request (0x02) len 2
        Client RX MTU: 517
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 28.278449
        Num handles: 1
        Handle: 70
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 28.279449
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 11                    [hci0] 28.348460
      SMP: Pairing Response (0x02) len 6
        IO capability: NoInputNoOutput (0x03)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, No MITM, Legacy, No Keypresses (0x01)
        Max encryption key size: 16
        Initiator key distribution: EncKey Sign (0x05)
        Responder key distribution: EncKey IdKey Sign (0x07)
< ACL Data TX: Handle 70 flags 0x00 dlen 21                    [hci0] 28.348510
      SMP: Pairing Confirm (0x03) len 16
        Confim value: 12bd199ba4739a017395109cfa4621b3
> ACL Data RX: Handle 70 flags 0x02 dlen 7                     [hci0] 28.349000
      ATT: Exchange MTU Response (0x03) len 2
        Server RX MTU: 23
< ACL Data TX: Handle 70 flags 0x00 dlen 11                    [hci0] 28.349199
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 28.419459
        Num handles: 1
        Handle: 70
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 28.420450
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 21                    [hci0] 28.488508
      SMP: Pairing Confirm (0x03) len 16
        Confim value: 41f5f7a6212356d0eefa268f7994844a
< ACL Data TX: Handle 70 flags 0x00 dlen 21                    [hci0] 28.488545
      SMP: Pairing Random (0x04) len 16
        Random value: 4e8d532caf34ab845ff243acf6a0a681
> ACL Data RX: Handle 70 flags 0x02 dlen 24                    [hci0] 28.489235
      ATT: Read By Group Type Response (0x11) len 19
        Attribute data length: 6
        Attribute group list: 3 entries
        Handle range: 0x0001-0x000b
        UUID: Generic Access Profile (0x1800)
        Handle range: 0x000c-0x000f
        UUID: Generic Attribute Profile (0x1801)
        Handle range: 0x0010-0x0017
        UUID: Weight Scale (0x181d)
< ACL Data TX: Handle 70 flags 0x00 dlen 11                    [hci0] 28.489379
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0018-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 28.559451
        Num handles: 1
        Handle: 70
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 28.560451
        Num handles: 1
        Handle: 70
        Count: 1
> ACL Data RX: Handle 70 flags 0x02 dlen 6                     [hci0] 28.628456
      SMP: Pairing Failed (0x05) len 1
        Reason: Confirm value failed (0x04)
< HCI Command: Disconnect (0x01|0x0006) plen 3                 [hci0] 28.628506
        Handle: 70
        Reason: Authentication Failure (0x05)
@ Authentication Failed: 5C:31:3E:5E:54:5E (1) status 0x05
> ACL Data RX: Handle 70 flags 0x02 dlen 18                    [hci0] 28.635600
      ATT: Read By Group Type Response (0x11) len 13
        Attribute data length: 6
        Attribute group list: 2 entries
        Handle range: 0x0018-0x0028
        UUID: Device Information (0x180a)
        Handle range: 0x0029-0x002b
        UUID: Battery Service (0x180f)
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 28.639427
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)
> HCI Event: Disconnect Complete (0x05) plen 4                 [hci0] 28.699449
        Status: Success (0x00)
        Handle: 70
        Reason: Connection Terminated By Local Host (0x16)
@ Device Disconnected: 5C:31:3E:5E:54:5E (1) reason 2
