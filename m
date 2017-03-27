Return-Path: <joshua.weng.onn.wong@intel.com>
From: "Wong, Joshua Weng Onn" <joshua.weng.onn.wong@intel.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>
CC: Bluez mailing list <linux-bluetooth@vger.kernel.org>, "Wong, Mun choy"
	<mun.choy.wong@intel.com>, "Zulqarnain, Adam" <adam.zulqarnain@intel.com>
Subject: RE: Unexpected SMP Command 0x0a
Date: Mon, 27 Mar 2017 03:35:32 +0000
Message-ID: <E3B98393E6037849B63EA428240A6513607424@PGSMSX103.gar.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Thank you for your reply. We are using the 4.1.x kernel as our group has pe=
rformed validation work on it and achieved 'Gold release' standard for our =
customers.
I have attached my logs during the LE pairing process at the end of this em=
ail. There are two logs namely master and slave device. Note that the logs =
I provided is for secure connections on.
The log I sent previously was ford secure connections turned off. Nonethele=
ss, the LE pairing fails on both settings i.e. when secured connections is =
turned on and when secured connections is turned off.

Also, I've realized that my title was wrong previously. I've updated it to =
reflect 0x0a instead of 0x17.

> Hi Joshua,
>=20
> > I am seeing an error during the LE pairing process which makes the pair=
ing to
> fail. I have two DUTs which uses the Marvell 88W8897.
> > Here are my BT settings for both master and slave:
> >
> > Master:
> > $ btmgmt info
> > current settings: powered connectable discoverable bondable ssp br/edr =
le
> secure-conn
> >
> > Slave:
> > $ btmgmt info
> > Current settings: powered connectable bondable le advertising secure-co=
nn
> >
> > When I initiate the pairing process from the master, I observed the mes=
sage:
> > "Bluetooth: hci0 unexpected SMP command 0x0a from 74:c6:3b:ab:68:ea"
> >
> > Where 74:c6:3b:ab:68:ea is the address of the slave device.
> >
> > In the btmon log of the master device, it is observed that after the Sl=
ave device
> has transmitted the keys, the Master does not transmit it. Hence, the Sla=
ve is not
> receiving the keys and thus disconnects the link and pairing is failed.
> >
> >> ACL Data RX: Handle 128 flags 0x02 dlen 21                            =
   [hci0]
> 124.801098
> >      SMP: Encryption Information (0x06) len 16
> >        Long term key: 9ac691e96e85e82ca68f4b6d2abec80f
> >> HCI Event: Encryption Change (0x08) plen 4                            =
   [hci0]
> 124.801261
> >        Status: Success (0x00)
> >        Handle: 128
> >        Encryption: Enabled with AES-CCM (0x01)
> >> ACL Data RX: Handle 128 flags 0x02 dlen 15                            =
   [hci0]
> 124.812761
> >      SMP: Master Identification (0x07) len 10
> >        EDIV: 0xea3f
> >        Rand: 0x806e542a78f55d7c
> >> ACL Data RX: Handle 128 flags 0x02 dlen 21                            =
   [hci0]
> 124.812782
> >      SMP: Signing Information (0x0a) len 16
> >        Signature key: 4451b8ae0eff90f0a47fb96be53479fb
> >> HCI Event: Disconnect Complete (0x05) plen 4                          =
   [hci0]
> 154.839591
> >        Status: Success (0x00)
> >        Handle: 128
> >        Reason: Remote User Terminated Connection (0x13)
> >
> > =3D> At this point, Master should start sending LTK to slave, but Maste=
r doesn't
> send the LTK so Slave disconnects the link and pairing is failed.
> >
> > What could possibly cause the master to not send the LTK? My kernel ver=
sion
> is v4.1.27 and bluez stack is v5.40. I would appreciate advice on this.
>=20
> if this is LE Secure Connections, then the LTK is no longer distributed. =
It is being
> calculated from ECDH. Please include the complete SMP exchanges. Only the=
n
> we can see what is going on.
>=20
> Also keep in mind that 4.1.x kernels are actually rather old. The latest =
one is
> 4.10.x and if there is a bug, you should verify that it also happens with=
 the latest
> kernel.
>=20
> Regards
>=20
> Marcel

btmon log of master device:
< HCI Command: LE Create Connection (0x08|0x000d) plen 25                  =
[hci0] 752.498799
        Scan interval: 60.000 msec (0x0060)
        Scan window: 30.000 msec (0x0030)
        Filter policy: White list is not used (0x00)
        Peer address type: Public (0x00)
        Peer address: 74:C6:3B:AB:68:EA (OUI 74-C6-3B)
        Own address type: Public (0x00)
        Min connection interval: 50.00 msec (0x0028)
        Max connection interval: 70.00 msec (0x0038)
        Connection latency: 0x0000
        Supervision timeout: 420 msec (0x002a)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                                  =
[hci0] 752.505320
      LE Create Connection (0x08|0x000d) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19                                  =
[hci0] 753.061210
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 128
        Role: Master (0x00)
        Peer address type: Public (0x00)
        Peer address: 74:C6:3B:AB:68:EA (OUI 74-C6-3B)
        Connection interval: 67.50 msec (0x0036)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x01
@ Device Connected: 74:C6:3B:AB:68:EA (1) flags 0x0000
< HCI Command: LE Read Remote Used Features (0x08|0x0016) plen 2           =
[hci0] 753.063118
        Handle: 128
> HCI Event: Command Status (0x0f) plen 4                                  =
[hci0] 753.068964
      LE Read Remote Used Features (0x08|0x0016) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 12                                  =
[hci0] 753.249205
      LE Read Remote Used Features (0x04)
        Status: Success (0x00)
        Handle: 128
        Features: 0x4f 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          LE Encryption
          Connection Parameter Request Procedure
          Extended Reject Indication
          Slave-initiated Features Exchange
          LL Privacy
< ACL Data TX: Handle 128 flags 0x00 dlen 11                               =
[hci0] 753.250193
      SMP: Pairing Request (0x01) len 6
        IO capability: KeyboardDisplay (0x04)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, MITM, SC, No Keypresses (0x0d)
        Max encryption key size: 16
        Initiator key distribution: EncKey Sign LinkKey (0x0d)
        Responder key distribution: EncKey IdKey Sign LinkKey (0x0f)
< ACL Data TX: Handle 128 flags 0x00 dlen 7                                =
[hci0] 753.262956
      ATT: Exchange MTU Request (0x02) len 2
        Client RX MTU: 517
> ACL Data RX: Handle 128 flags 0x02 dlen 7                                =
[hci0] 753.315441
      ATT: Exchange MTU Request (0x02) len 2
        Client RX MTU: 517
> HCI Event: Number of Completed Packets (0x13) plen 5                     =
[hci0] 753.315718
        Num handles: 1
        Handle: 128
        Count: 1
< ACL Data TX: Handle 128 flags 0x00 dlen 7                                =
[hci0] 753.316060
      ATT: Exchange MTU Response (0x03) len 2
        Server RX MTU: 517
> HCI Event: Number of Completed Packets (0x13) plen 5                     =
[hci0] 753.316008
        Num handles: 1
        Handle: 128
        Count: 1
> ACL Data RX: Handle 128 flags 0x02 dlen 11                               =
[hci0] 753.382935
      SMP: Pairing Response (0x02) len 6
        IO capability: DisplayYesNo (0x01)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, MITM, SC, No Keypresses (0x0d)
        Max encryption key size: 16
        Initiator key distribution: EncKey Sign (0x05)
        Responder key distribution: EncKey Sign (0x05)
> HCI Event: Number of Completed Packets (0x13) plen 5                     =
[hci0] 753.383085
        Num handles: 1
        Handle: 128
        Count: 1
> ACL Data RX: Handle 128 flags 0x02 dlen 7                                =
[hci0] 753.383401
      ATT: Exchange MTU Response (0x03) len 2
        Server RX MTU: 517
< ACL Data TX: Handle 128 flags 0x00 dlen 69                               =
[hci0] 753.385376
      SMP: Pairing Public Key (0x0c) len 64
        X: 17780eede45fb83689cabb6803f5f0de1da6cfe3d51a3cf5553eafb94910c5b5
        Y: 85e0b332945e7190afd622a1fdd5aa5d365722319a25fc8d7d860d02dc60b4af
< ACL Data TX: Handle 128 flags 0x00 dlen 11                               =
[hci0] 753.385625
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)
> ACL Data RX: Handle 128 flags 0x02 dlen 11                               =
[hci0] 753.451682
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5                     =
[hci0] 753.451999
        Num handles: 1
        Handle: 128
        Count: 1
< ACL Data TX: Handle 128 flags 0x00 dlen 18                               =
[hci0] 753.452165
      ATT: Read By Group Type Response (0x11) len 13
        Attribute data length: 6
        Attribute group list: 2 entries
        Handle range: 0x0001-0x0005
        UUID: Generic Access Profile (0x1800)
        Handle range: 0x0006-0x0009
        UUID: Generic Attribute Profile (0x1801)
> HCI Event: Number of Completed Packets (0x13) plen 5                     =
[hci0] 753.452420
        Num handles: 1
        Handle: 128
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5                     =
[hci0] 753.518890
        Num handles: 1
        Handle: 128
        Count: 1
> ACL Data RX: Handle 128 flags 0x02 dlen 69                               =
[hci0] 753.518986
      SMP: Pairing Public Key (0x0c) len 64
        X: 1da0aaa663fe5fd9da217d0da76c3ee298ba52150bbf2785fddd38f464faef84
        Y: 8f378562b6e025f2e2dc4e1e05e501f599f4bb63efde8c46cc98a12cf8cc16f5
> ACL Data RX: Handle 128 flags 0x02 dlen 21                               =
[hci0] 753.519023
      SMP: Pairing Confirm (0x03) len 16
        Confim value: 906ada103cf5a740c67a316e15c5e133
> ACL Data RX: Handle 128 flags 0x02 dlen 18                               =
[hci0] 753.519487
      ATT: Read By Group Type Response (0x11) len 13
        Attribute data length: 6
        Attribute group list: 2 entries
        Handle range: 0x0001-0x0005
        UUID: Generic Access Profile (0x1800)
        Handle range: 0x0006-0x0009
        UUID: Generic Attribute Profile (0x1801)
< ACL Data TX: Handle 128 flags 0x00 dlen 21                               =
[hci0] 753.523611
      SMP: Pairing Random (0x04) len 16
        Random value: 52bd97adce116ec51777d770ac159c35
< ACL Data TX: Handle 128 flags 0x00 dlen 11                               =
[hci0] 753.524480
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x000a-0xffff
        Attribute group type: Primary Service (0x2800)
> ACL Data RX: Handle 128 flags 0x02 dlen 11                               =
[hci0] 753.586528
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x000a-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5                     =
[hci0] 753.586580
        Num handles: 1
        Handle: 128
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5                     =
[hci0] 753.586824
        Num handles: 1
        Handle: 128
        Count: 1
< ACL Data TX: Handle 128 flags 0x00 dlen 9                                =
[hci0] 753.586903
      ATT: Error Response (0x01) len 4
        Read By Group Type Request (0x10)
        Handle: 0x000a
        Error: Attribute Not Found (0x0a)
> ACL Data RX: Handle 128 flags 0x02 dlen 21                               =
[hci0] 753.652953
      SMP: Pairing Random (0x04) len 16
        Random value: e7af794cd9f6401a29aaedc8fac8db18
> HCI Event: Number of Completed Packets (0x13) plen 5                     =
[hci0] 753.653123
        Num handles: 1
        Handle: 128
        Count: 1
> ACL Data RX: Handle 128 flags 0x02 dlen 9                                =
[hci0] 753.653417
      ATT: Error Response (0x01) len 4
        Read By Group Type Request (0x10)
        Handle: 0x000a
        Error: Attribute Not Found (0x0a)
@ User Confirmation Request: 74:C6:3B:AB:68:EA (1) hint 0 value 706962
< ACL Data TX: Handle 128 flags 0x00 dlen 9                                =
[hci0] 753.685954
      ATT: Write Request (0x12) len 4
        Handle: 0x0009
          Data: 0200
> HCI Event: Number of Completed Packets (0x13) plen 5                     =
[hci0] 753.720303
        Num handles: 1
        Handle: 128
        Count: 1
> ACL Data RX: Handle 128 flags 0x02 dlen 5                                =
[hci0] 753.856549
      ATT: Write Response (0x13) len 0
> ACL Data RX: Handle 128 flags 0x02 dlen 9                                =
[hci0] 753.856852
      ATT: Write Request (0x12) len 4
        Handle: 0x0009
          Data: 0200
< ACL Data TX: Handle 128 flags 0x00 dlen 5                                =
[hci0] 753.857115
      ATT: Write Response (0x13) len 0
< ACL Data TX: Handle 128 flags 0x00 dlen 7                                =
[hci0] 753.857138
      ATT: Read Request (0x0a) len 2
        Handle: 0x0003
> HCI Event: Number of Completed Packets (0x13) plen 5                     =
[hci0] 753.922945
        Num handles: 1
        Handle: 128
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5                     =
[hci0] 753.923257
        Num handles: 1
        Handle: 128
        Count: 1
> ACL Data RX: Handle 128 flags 0x02 dlen 7                                =
[hci0] 753.991563
      ATT: Read Request (0x0a) len 2
        Handle: 0x0003
> ACL Data RX: Handle 128 flags 0x02 dlen 10                               =
[hci0] 753.991866
      ATT: Read Response (0x0b) len 5
        Value: 426c75655a
< ACL Data TX: Handle 128 flags 0x00 dlen 12                               =
[hci0] 753.992217
      ATT: Read Response (0x0b) len 7
        Value: 67697261666665
< ACL Data TX: Handle 128 flags 0x00 dlen 7                                =
[hci0] 753.992256
      ATT: Read Request (0x0a) len 2
        Handle: 0x0005
> HCI Event: Number of Completed Packets (0x13) plen 5                     =
[hci0] 754.057946
        Num handles: 1
        Handle: 128
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5                     =
[hci0] 754.058278
        Num handles: 1
        Handle: 128
        Count: 1
> ACL Data RX: Handle 128 flags 0x02 dlen 7                                =
[hci0] 754.126628
      ATT: Read Response (0x0b) len 2
        Value: 0000
> ACL Data RX: Handle 128 flags 0x02 dlen 7                                =
[hci0] 754.126945
      ATT: Read Request (0x0a) len 2
        Handle: 0x0005
< ACL Data TX: Handle 128 flags 0x00 dlen 7                                =
[hci0] 754.127655
      ATT: Read Response (0x0b) len 2
        Value: 1001
> HCI Event: Number of Completed Packets (0x13) plen 5                     =
[hci0] 754.192985
        Num handles: 1
        Handle: 128
        Count: 1
< ACL Data TX: Handle 128 flags 0x00 dlen 21                               =
[hci0] 760.114731
      SMP: Pairing DHKey Check (0x0d) len 16
        E: f3373b60ba9063449ebef0f3dd7d9781
> HCI Event: Number of Completed Packets (0x13) plen 5                     =
[hci0] 760.132942
        Num handles: 1
        Handle: 128
        Count: 1
> ACL Data RX: Handle 128 flags 0x02 dlen 21                               =
[hci0] 760.200373
      SMP: Pairing DHKey Check (0x0d) len 16
        E: 975be5ee4a205e1ac4811baa970abf10
< HCI Command: LE Start Encryption (0x08|0x0019) plen 28                   =
[hci0] 760.200595
        Handle: 128
        Random number: 0x0000000000000000
        Encrypted diversifier: 0x0000
        Long term key: 7ee01e3f27750b9393533941a4f3e198
> HCI Event: Command Status (0x0f) plen 4                                  =
[hci0] 760.206677
      LE Start Encryption (0x08|0x0019) ncmd 1
        Status: Success (0x00)
> ACL Data RX: Handle 128 flags 0x02 dlen 21                               =
[hci0] 760.470529
      SMP: Signing Information (0x0a) len 16
        Signature key: 1866336f92238bf953611245b7ad51f7
> HCI Event: Encryption Change (0x08) plen 4                               =
[hci0] 760.470733
        Status: Success (0x00)
        Handle: 128
        Encryption: Enabled with AES-CCM (0x01)
> HCI Event: Disconnect Complete (0x05) plen 4                             =
[hci0] 790.576443
        Status: Success (0x00)
        Handle: 128
        Reason: Remote User Terminated Connection (0x13)
@ Device Disconnected: 74:C6:3B:AB:68:EA (1) reason 3


btmon log of slave device:
> HCI Event: LE Meta Event (0x3e) plen 19                     [hci0] 201.87=
5863
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 128
        Role: Slave (0x01)
        Peer address type: Public (0x00)
        Peer address: 74:C6:3B:AB:68:E0 (OUI 74-C6-3B)
        Connection interval: 67.50 msec (0x0036)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x01
@ Device Connected: 74:C6:3B:AB:68:E0 (1) flags 0x0000
< HCI Command: LE Read Remote Used Fe.. (0x08|0x0016) plen 2  [hci0] 201.87=
7629
        Handle: 128
> HCI Event: Command Status (0x0f) plen 4                     [hci0] 201.88=
4437
      LE Read Remote Used Features (0x08|0x0016) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 12                     [hci0] 202.06=
3367
      LE Read Remote Used Features (0x04)
        Status: Success (0x00)
        Handle: 128
        Features: 0x4f 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          LE Encryption
          Connection Parameter Request Procedure
          Extended Reject Indication
          Slave-initiated Features Exchange
          LL Privacy
< ACL Data TX: Handle 128 flags 0x00 dlen 7                   [hci0] 202.07=
6740
      ATT: Exchange MTU Request (0x02) len 2
        Client RX MTU: 517
> ACL Data RX: Handle 128 flags 0x02 dlen 11                  [hci0] 202.13=
0925
      SMP: Pairing Request (0x01) len 6
        IO capability: KeyboardDisplay (0x04)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, MITM, SC, No Keypresses (0x0d)
        Max encryption key size: 16
        Initiator key distribution: EncKey Sign LinkKey (0x0d)
        Responder key distribution: EncKey IdKey Sign LinkKey (0x0f)
> HCI Event: Number of Completed Packets (0x13) plen 5        [hci0] 202.13=
1213
        Num handles: 1
        Handle: 128
        Count: 1
> ACL Data RX: Handle 128 flags 0x02 dlen 7                   [hci0] 202.13=
1481
      ATT: Exchange MTU Request (0x02) len 2
        Client RX MTU: 517
< ACL Data TX: Handle 128 flags 0x00 dlen 11                  [hci0] 202.13=
1616
      SMP: Pairing Response (0x02) len 6
        IO capability: DisplayYesNo (0x01)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: Bonding, MITM, SC, No Keypresses (0x0d)
        Max encryption key size: 16
        Initiator key distribution: EncKey Sign (0x05)
        Responder key distribution: EncKey Sign (0x05)
< ACL Data TX: Handle 128 flags 0x00 dlen 7                   [hci0] 202.13=
2157
      ATT: Exchange MTU Response (0x03) len 2
        Server RX MTU: 517
> ACL Data RX: Handle 128 flags 0x02 dlen 7                   [hci0] 202.19=
8437
      ATT: Exchange MTU Response (0x03) len 2
        Server RX MTU: 517
> HCI Event: Number of Completed Packets (0x13) plen 5        [hci0] 202.19=
8721
        Num handles: 1
        Handle: 128
        Count: 1
< ACL Data TX: Handle 128 flags 0x00 dlen 11                  [hci0] 202.19=
9227
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)
> HCI Event: Number of Completed Packets (0x13) plen 5        [hci0] 202.26=
4636
        Num handles: 1
        Handle: 128
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5        [hci0] 202.26=
5101
        Num handles: 1
        Handle: 128
        Count: 1
> ACL Data RX: Handle 128 flags 0x02 dlen 69                  [hci0] 202.26=
5382
      SMP: Pairing Public Key (0x0c) len 64
        X: 17780eede45fb83689cabb6803f5f0de1da6cfe3d51a3cf5553eafb94910c5b5
        Y: 85e0b332945e7190afd622a1fdd5aa5d365722319a25fc8d7d860d02dc60b4af
> ACL Data RX: Handle 128 flags 0x02 dlen 11                  [hci0] 202.26=
5849
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x0001-0xffff
        Attribute group type: Primary Service (0x2800)
< ACL Data TX: Handle 128 flags 0x00 dlen 69                  [hci0] 202.28=
1447
      SMP: Pairing Public Key (0x0c) len 64
        X: 1da0aaa663fe5fd9da217d0da76c3ee298ba52150bbf2785fddd38f464faef84
        Y: 8f378562b6e025f2e2dc4e1e05e501f599f4bb63efde8c46cc98a12cf8cc16f5
< ACL Data TX: Handle 128 flags 0x00 dlen 21                  [hci0] 202.28=
1508
      SMP: Pairing Confirm (0x03) len 16
        Confim value: 906ada103cf5a740c67a316e15c5e133
< ACL Data TX: Handle 128 flags 0x00 dlen 18                  [hci0] 202.28=
1958
      ATT: Read By Group Type Response (0x11) len 13
        Attribute data length: 6
        Attribute group list: 2 entries
        Handle range: 0x0001-0x0005
        UUID: Generic Access Profile (0x1800)
        Handle range: 0x0006-0x0009
        UUID: Generic Attribute Profile (0x1801)
> ACL Data RX: Handle 128 flags 0x02 dlen 18                  [hci0] 202.33=
4680
      ATT: Read By Group Type Response (0x11) len 13
        Attribute data length: 6
        Attribute group list: 2 entries
        Handle range: 0x0001-0x0005
        UUID: Generic Access Profile (0x1800)
        Handle range: 0x0006-0x0009
        UUID: Generic Attribute Profile (0x1801)
> HCI Event: Number of Completed Packets (0x13) plen 5        [hci0] 202.33=
4962
        Num handles: 1
        Handle: 128
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5        [hci0] 202.33=
5273
        Num handles: 1
        Handle: 128
        Count: 1
< ACL Data TX: Handle 128 flags 0x00 dlen 11                  [hci0] 202.33=
5631
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x000a-0xffff
        Attribute group type: Primary Service (0x2800)
> ACL Data RX: Handle 128 flags 0x02 dlen 21                  [hci0] 202.39=
9670
      SMP: Pairing Random (0x04) len 16
        Random value: 52bd97adce116ec51777d770ac159c35
> HCI Event: Number of Completed Packets (0x13) plen 5        [hci0] 202.39=
9938
        Num handles: 1
        Handle: 128
        Count: 1
< ACL Data TX: Handle 128 flags 0x00 dlen 21                  [hci0] 202.39=
9986
      SMP: Pairing Random (0x04) len 16
        Random value: e7af794cd9f6401a29aaedc8fac8db18
> ACL Data RX: Handle 128 flags 0x02 dlen 11                  [hci0] 202.40=
0459
      ATT: Read By Group Type Request (0x10) len 6
        Handle range: 0x000a-0xffff
        Attribute group type: Primary Service (0x2800)
@ User Confirmation Request: 74:C6:3B:AB:68:E0 (1) hint 0 value 706962
< ACL Data TX: Handle 128 flags 0x00 dlen 9                   [hci0] 202.40=
0956
      ATT: Error Response (0x01) len 4
        Read By Group Type Request (0x10)
        Handle: 0x000a
        Error: Attribute Not Found (0x0a)
> HCI Event: Number of Completed Packets (0x13) plen 5        [hci0] 202.40=
0898
        Num handles: 1
        Handle: 128
        Count: 1
> ACL Data RX: Handle 128 flags 0x02 dlen 9                   [hci0] 202.46=
8436
      ATT: Error Response (0x01) len 4
        Read By Group Type Request (0x10)
        Handle: 0x000a
        Error: Attribute Not Found (0x0a)
> HCI Event: Number of Completed Packets (0x13) plen 5        [hci0] 202.46=
8638
        Num handles: 1
        Handle: 128
        Count: 1
> ACL Data RX: Handle 128 flags 0x02 dlen 9                   [hci0] 202.53=
5940
      ATT: Write Request (0x12) len 4
        Handle: 0x0009
          Data: 0200
> HCI Event: Number of Completed Packets (0x13) plen 5        [hci0] 202.53=
6128
        Num handles: 1
        Handle: 128
        Count: 1
< ACL Data TX: Handle 128 flags 0x00 dlen 5                   [hci0] 202.59=
7986
      ATT: Write Response (0x13) len 0
< ACL Data TX: Handle 128 flags 0x00 dlen 9                   [hci0] 202.59=
8036
      ATT: Write Request (0x12) len 4
        Handle: 0x0009
          Data: 0200
> HCI Event: Number of Completed Packets (0x13) plen 5        [hci0] 202.67=
0869
        Num handles: 1
        Handle: 128
        Count: 1
> ACL Data RX: Handle 128 flags 0x02 dlen 5                   [hci0] 202.73=
7205
      ATT: Write Response (0x13) len 0
> HCI Event: Number of Completed Packets (0x13) plen 5        [hci0] 202.73=
7378
        Num handles: 1
        Handle: 128
        Count: 1
> ACL Data RX: Handle 128 flags 0x02 dlen 7                   [hci0] 202.73=
7672
      ATT: Read Request (0x0a) len 2
        Handle: 0x0003
< ACL Data TX: Handle 128 flags 0x00 dlen 7                   [hci0] 202.73=
7767
      ATT: Read Request (0x0a) len 2
        Handle: 0x0003
< ACL Data TX: Handle 128 flags 0x00 dlen 10                  [hci0] 202.73=
7914
      ATT: Read Response (0x0b) len 5
        Value: 426c75655a
> HCI Event: Number of Completed Packets (0x13) plen 5        [hci0] 202.80=
5865
        Num handles: 1
        Handle: 128
        Count: 1
> ACL Data RX: Handle 128 flags 0x02 dlen 12                  [hci0] 202.87=
2207
      ATT: Read Response (0x0b) len 7
        Value: 67697261666665
> HCI Event: Number of Completed Packets (0x13) plen 5        [hci0] 202.87=
2429
        Num handles: 1
        Handle: 128
        Count: 1
> ACL Data RX: Handle 128 flags 0x02 dlen 7                   [hci0] 202.87=
2742
      ATT: Read Request (0x0a) len 2
        Handle: 0x0005
< ACL Data TX: Handle 128 flags 0x00 dlen 7                   [hci0] 202.87=
3489
      ATT: Read Response (0x0b) len 2
        Value: 0000
< ACL Data TX: Handle 128 flags 0x00 dlen 7                   [hci0] 202.87=
3543
      ATT: Read Request (0x0a) len 2
        Handle: 0x0005
> HCI Event: Number of Completed Packets (0x13) plen 5        [hci0] 202.94=
0673
        Num handles: 1
        Handle: 128
        Count: 1
> ACL Data RX: Handle 128 flags 0x02 dlen 7                   [hci0] 203.00=
9022
      ATT: Read Response (0x0b) len 2
        Value: 1001
> HCI Event: Number of Completed Packets (0x13) plen 5        [hci0] 203.00=
9069
        Num handles: 1
        Handle: 128
        Count: 1
> ACL Data RX: Handle 128 flags 0x02 dlen 21                  [hci0] 208.94=
8405
      SMP: Pairing DHKey Check (0x0d) len 16
        E: f3373b60ba9063449ebef0f3dd7d9781
< ACL Data TX: Handle 128 flags 0x00 dlen 21                  [hci0] 208.94=
8615
      SMP: Pairing DHKey Check (0x0d) len 16
        E: 975be5ee4a205e1ac4811baa970abf10
> HCI Event: Number of Completed Packets (0x13) plen 5        [hci0] 209.08=
3476
        Num handles: 1
        Handle: 128
        Count: 1
> HCI Event: LE Meta Event (0x3e) plen 13                     [hci0] 209.08=
3793
      LE Long Term Key Request (0x05)
        Handle: 128
        Random number: 0x0000000000000000
        Encrypted diversifier: 0x0000
< HCI Command: LE Long Term Key Requ.. (0x08|0x001a) plen 18  [hci0] 209.08=
3869
        Handle: 128
        Long term key: 7ee01e3f27750b9393533941a4f3e198
> HCI Event: Command Complete (0x0e) plen 6                   [hci0] 209.08=
7194
      LE Long Term Key Request Reply (0x08|0x001a) ncmd 1
        Status: Success (0x00)
        Handle: 128
> HCI Event: Encryption Change (0x08) plen 4                  [hci0] 209.21=
8486
        Status: Success (0x00)
        Handle: 128
        Encryption: Enabled with AES-CCM (0x01)
< ACL Data TX: Handle 128 flags 0x00 dlen 21                  [hci0] 209.21=
8733
      SMP: Signing Information (0x0a) len 16
        Signature key: 1866336f92238bf953611245b7ad51f7
> HCI Event: Number of Completed Packets (0x13) plen 5        [hci0] 209.35=
2241
        Num handles: 1
        Handle: 128
        Count: 1
< HCI Command: Disconnect (0x01|0x0006) plen 3                [hci0] 239.26=
1952
        Handle: 128
        Reason: Remote User Terminated Connection (0x13)
> HCI Event: Command Status (0x0f) plen 4                     [hci0] 239.26=
8876
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)
> HCI Event: Disconnect Complete (0x05) plen 4                [hci0] 239.39=
2130
        Status: Success (0x00)
        Handle: 128
        Reason: Connection Terminated By Local Host (0x16)
@ Device Disconnected: 74:C6:3B:AB:68:E0 (1) reason 2


Thank you.

Best regards,
Joshua
