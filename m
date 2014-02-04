Return-Path: <cyrus@holtmann.org>
From: "Caleb Reinhold" <creinhold@lampreynetworks.com>
To: <linux-bluetooth@vger.kernel.org>
References: 
In-Reply-To: 
Subject: possible bug in blueZ 5.8 gatt tool or library
Date: Tue, 4 Feb 2014 16:12:31 -0500
Message-ID: <000201cf21ed$d18f02d0$74ad0870$@lampreynetworks.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0003_01CF21C3.E8C6DD80"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multipart message in MIME format.

------=_NextPart_000_0003_01CF21C3.E8C6DD80
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello all,

I am participating in an effort to make use of the BlueZ libraries to =
pull
data from Bluetooth Low Energy health devices.=20
We are working with the 5.8 version of the library, kernel version =
3.12.9,
bluetoothctl, and gatttool when we encountered a possible error.
We expected on the reconnection of two bonded devices, one of which had
stored measurements, that data would transfer. When running gatt tool in
medium security the first measurement to be indicated was lost.
First we used Bluetooth control to pair with the simulated agent device =
(a
thermometer). Then we disconnected with bluetoothctl and connected with
gatttool in order to write to the C3D (client characteristic =
configuration
descriptors). After setting the C3D to indicate, we transferred a
measurement successfully. =A0Up until this point we saw no unexpected
difference in behavior between low and medium security on the gatttool.
However upon attempting to reconnect to the simulated agent device with
medium security two unexpected behaviors occurred. First, and more
immediately apparent was that the simulated agent did not receive a
confirmation of the indication. A slightly closer look using the =
hcidump,
trying to find what had happened, showed that the indication had arrived =
at
the hci layer but was not received at events_handler. =A0While the =
indication
is sent very swiftly upon the reconnection of the devices we understand =
this
to be the manner in which low energy devices are supposed to behave =
given
stored measurements and a bonded device.
Records of hcidumps are attached.

Caleb Reinhold

P.S. Resending after failing to attach traces

------=_NextPart_000_0003_01CF21C3.E8C6DD80
Content-Type: text/plain;
	name="hci_dump.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="hci_dump.txt"

< HCI Command: LE Create Connection (0x08|0x000d) plen 25                =
     [hci0] 5199.285444
        Scan interval: 60.000 msec (0x0060)
        Scan window: 30.000 msec (0x0030)
        Filter policy: White list is not used (0x00)
        Peer address type: Public (0x00)
        Peer address: 00:02:72:C6:A0:6B (CC&C Technologies, Inc.)
        Own address type: Public (0x00)
        Min connection interval: 50.00 msec (0x0028)
        Max connection interval: 70.00 msec (0x0038)
        Connection latency: 0x0000
        Supervision timeout: 420 msec (0x002a)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                                =
     [hci0] 5199.288196
      LE Create Connection (0x08|0x000d) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19                                =
     [hci0] 5209.096157
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 64
        Role: Master (0x00)
        Peer address type: Public (0x00)
        Peer address: 00:02:72:C6:A0:6B (CC&C Technologies, Inc.)
        Connection interval: 67.50 msec (0x0036)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x05
@ Device Connected: 00:02:72:C6:A0:6B (1) flags 0x0000
> ACL Data RX: Handle 64 flags 0x02 dlen 19                              =
     [hci0] 5209.129475
      ATT: Handle Value Indication (0x1d) len 14
        Handle: 0x0004
          Data: 0363000000de0702030f1b0e
< ACL Data TX: Handle 64 flags 0x00 dlen 5                               =
     [hci0] 5209.129824
      ATT: Handle Value Confirmation (0x1e) len 0
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
     [hci0] 5209.338106
        Num handles: 1
        Handle: 64
        Count: 1
< HCI Command: Disconnect (0x01|0x0006) plen 3                           =
     [hci0] 5258.609760
        Handle: 64
        Reason: Remote User Terminated Connection (0x13)
> HCI Event: Command Status (0x0f) plen 4                                =
     [hci0] 5258.611935
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)
> HCI Event: Disconnect Complete (0x05) plen 4                           =
     [hci0] 5258.674959
        Status: Success (0x00)
        Handle: 64
        Reason: Connection Terminated By Local Host (0x16)
@ Device Disconnected: 00:02:72:C6:A0:6B (1) reason 2

       =20

       =20
< HCI Command: LE Create Connection (0x08|0x000d) plen 25                =
     [hci0] 5302.994402
        Scan interval: 60.000 msec (0x0060)
        Scan window: 30.000 msec (0x0030)
        Filter policy: White list is not used (0x00)
        Peer address type: Public (0x00)
        Peer address: 00:02:72:C6:A0:6B (CC&C Technologies, Inc.)
        Own address type: Public (0x00)
        Min connection interval: 50.00 msec (0x0028)
        Max connection interval: 70.00 msec (0x0038)
        Connection latency: 0x0000
        Supervision timeout: 420 msec (0x002a)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                                =
     [hci0] 5302.996878
      LE Create Connection (0x08|0x000d) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19                                =
     [hci0] 5311.264930
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 64
        Role: Master (0x00)
        Peer address type: Public (0x00)
        Peer address: 00:02:72:C6:A0:6B (CC&C Technologies, Inc.)
        Connection interval: 67.50 msec (0x0036)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x05
< HCI Command: LE Start Encryption (0x08|0x0019) plen 28                 =
     [hci0] 5311.265128
        Handle: 64
        Random number: 0d996e4936b9603f
        Encryption diversifier: 0x13a1
        Long term key: d43f4e489cc5b0746f86eac218c976e9
@ Device Connected: 00:02:72:C6:A0:6B (1) flags 0x0000
> HCI Event: Command Status (0x0f) plen 4                                =
     [hci0] 5311.267895
      LE Start Encryption (0x08|0x0019) ncmd 1
        Status: Success (0x00)
> ACL Data RX: Handle 64 flags 0x02 dlen 19                              =
     [hci0] 5311.326262
      ATT: Handle Value Indication (0x1d) len 14
        Handle: 0x0004
          Data: 0363000000de0702030f1c38
> HCI Event: Encryption Change (0x08) plen 4                             =
     [hci0] 5311.730919
        Status: Success (0x00)
        Handle: 64
        Encryption: Enabled with AES-CCM (0x01)
        
------=_NextPart_000_0003_01CF21C3.E8C6DD80
Content-Type: text/plain;
	name="BlueZ Trace-2 indications.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="BlueZ Trace-2 indications.txt"

< HCI Command: LE Create Connection (0x08|0x000d) plen 25                =
     [hci0] 5302.994402
        Scan interval: 60.000 msec (0x0060)
        Scan window: 30.000 msec (0x0030)
        Filter policy: White list is not used (0x00)
        Peer address type: Public (0x00)
        Peer address: 00:02:72:C6:A0:6B (CC&C Technologies, Inc.)
        Own address type: Public (0x00)
        Min connection interval: 50.00 msec (0x0028)
        Max connection interval: 70.00 msec (0x0038)
        Connection latency: 0x0000
        Supervision timeout: 420 msec (0x002a)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                                =
     [hci0] 5302.996878
      LE Create Connection (0x08|0x000d) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19                                =
     [hci0] 5311.264930
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 64
        Role: Master (0x00)
        Peer address type: Public (0x00)
        Peer address: 00:02:72:C6:A0:6B (CC&C Technologies, Inc.)
        Connection interval: 67.50 msec (0x0036)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x05
< HCI Command: LE Start Encryption (0x08|0x0019) plen 28                 =
     [hci0] 5311.265128
        Handle: 64
        Random number: 0d996e4936b9603f
        Encryption diversifier: 0x13a1
        Long term key: d43f4e489cc5b0746f86eac218c976e9
@ Device Connected: 00:02:72:C6:A0:6B (1) flags 0x0000
> HCI Event: Command Status (0x0f) plen 4                                =
     [hci0] 5311.267895
      LE Start Encryption (0x08|0x0019) ncmd 1
        Status: Success (0x00)
> ACL Data RX: Handle 64 flags 0x02 dlen 19                              =
     [hci0] 5311.326262
      ATT: Handle Value Indication (0x1d) len 14
        Handle: 0x0004
          Data: 0363000000de0702030f1c38
> HCI Event: Encryption Change (0x08) plen 4                             =
     [hci0] 5311.730919
        Status: Success (0x00)
        Handle: 64
        Encryption: Enabled with AES-CCM (0x01)
> ACL Data RX: Handle 64 flags 0x02 dlen 19                              =
     [hci0] 5556.355293
      ATT: Handle Value Indication (0x1d) len 14
        Handle: 0x0004
          Data: 0363000000de0702030f2101
< ACL Data TX: Handle 64 flags 0x00 dlen 5                               =
     [hci0] 5556.355579
      ATT: Handle Value Confirmation (0x1e) len 0
> HCI Event: Number of Completed Packets (0x13) plen 5                   =
     [hci0] 5556.622163
        Num handles: 1
        Handle: 64
        Count: 1
------=_NextPart_000_0003_01CF21C3.E8C6DD80--

