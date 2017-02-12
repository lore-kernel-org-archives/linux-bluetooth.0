Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Todd McNeal <todd.mcneal@gmail.com>
Date: Sun, 12 Feb 2017 17:24:17 -0500
Message-ID: <CALgm_hFA3LZ+9onCRNe7Eh44tSOd=Ng=3nsaKaG3EhayNL6L-A@mail.gmail.com>
Subject: Connecting to HID profile connects then quickly disconnects
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello all,

I'm writing a Python program that connects my local Linux box (running
on a Raspberry Pi 3) to a Playstation 3 via a HID profile (UUID
00001124-0000-1000-8000-00805f9b34fb).  Prior to running this program,
I am able to connect to the PS3 and send commands when I initially
paired with the device.  Specifically I can successfully (a) register
a local HID profile, (b) put the local device into discovery mode, (c)
connect to my Raspberry Pi device via the PS3, and (d) observe a L2CAP
connection get established on the L2CAP control and interrupt ports of
my local server.  I am also able to send HID commands successfully.

However, later on when I try to connect to the PS3 via the Raspberry
Pi 3 I keep hitting errors.  The PS3 is showing up as 'Trusted' in
bluetoothctl, but when I connect, I see a connection get established
but quickly get disconnected a few seconds later.

I am using BlueZ v5.43.  Does anyone know if this is expected
behavior?  It's very likely I'm doing something wrong, as this is my
first project using Bluetooth.

Here is the relevant logging:

Python code (using dbus to connect to the device):

>>> HID_UUID = "00001124-0000-1000-8000-00805f9b34fb"

>>> device = dbus.Interface(bluetooth.bus.get_object(BLUEZ_SERVICE, '/org/bluez/hci0/dev_50_63_13_27_BB_BE'), BLUEZ_DEVICE)

>>> device.ConnectProfile(HID_UUID)

Traceback (most recent call last):

  File "<stdin>", line 1, in <module>

  File "/usr/lib/python3/dist-packages/dbus/proxies.py", line 145, in __call__

    **keywords)

  File "/usr/lib/python3/dist-packages/dbus/connection.py", line 651,
in call_blocking

    message, timeout)

dbus.exceptions.DBusException: org.bluez.Error.NotAvailable: Operation
currently not available


bluetoothd logs

Feb 12 11:39:46 raspberrypi bluetoothd[16313]:
src/device.c:connect_profiles() /org/bluez/hci0/dev_50_63_13_27_BB_BE
00001124-0000-1000-8000-00805f9b34fb, client :1.239

Feb 12 11:39:46 raspberrypi bluetoothd[16313]:
src/device.c:connect_profiles() Resolving services for
/org/bluez/hci0/dev_50_63_13_27_BB_BE

Feb 12 11:39:46 raspberrypi bluetoothd[16313]: bluetoothd[16313]:
src/device.c:connect_profiles() /org/bluez/hci0/dev_50_63_13_27_BB_BE
00001124-0000-1000-8000-00805f9b34fb, client :1.239

Feb 12 11:39:46 raspberrypi bluetoothd[16313]: bluetoothd[16313]:
src/device.c:connect_profiles() Resolving services for
/org/bluez/hci0/dev_50_63_13_27_BB_BE

Feb 12 11:39:46 raspberrypi bluetoothd[16313]:
src/adapter.c:connected_callback() hci0 device 50:63:13:27:BB:BE
connected eir_len 0

Feb 12 11:39:46 raspberrypi bluetoothd[16313]: bluetoothd[16313]:
src/adapter.c:connected_callback() hci0 device 50:63:13:27:BB:BE
connected eir_len 0

Feb 12 11:39:48 raspberrypi bluetoothd[16313]:
src/device.c:search_cb() 50:63:13:27:BB:BE: No service update

Feb 12 11:39:48 raspberrypi bluetoothd[16313]:
src/device.c:device_svc_resolved()
/org/bluez/hci0/dev_50_63_13_27_BB_BE err 0

Feb 12 11:39:48 raspberrypi bluetoothd[16313]:
src/device.c:connect_profiles() /org/bluez/hci0/dev_50_63_13_27_BB_BE
00001124-0000-1000-8000-00805f9b34fb, client :1.239

Feb 12 11:39:48 raspberrypi bluetoothd[16313]: bluetoothd[16313]:
src/device.c:search_cb() 50:63:13:27:BB:BE: No service update

Feb 12 11:39:48 raspberrypi bluetoothd[16313]: bluetoothd[16313]:
src/device.c:device_svc_resolved()
/org/bluez/hci0/dev_50_63_13_27_BB_BE err 0

Feb 12 11:39:48 raspberrypi bluetoothd[16313]: bluetoothd[16313]:
src/device.c:connect_profiles() /org/bluez/hci0/dev_50_63_13_27_BB_BE
00001124-0000-1000-8000-00805f9b34fb, client :1.239

Feb 12 11:39:52 raspberrypi bluetoothd[16313]: bluetoothd[16313]:
src/adapter.c:dev_disconnected() Device 50:63:13:27:BB:BE
disconnected, reason 2

Feb 12 11:39:52 raspberrypi bluetoothd[16313]: bluetoothd[16313]:
src/adapter.c:adapter_remove_connection()

Feb 12 11:39:52 raspberrypi bluetoothd[16313]:
src/adapter.c:dev_disconnected() Device 50:63:13:27:BB:BE
disconnected, reason 2

Feb 12 11:39:52 raspberrypi bluetoothd[16313]:
src/adapter.c:adapter_remove_connection()

Feb 12 11:39:52 raspberrypi bluetoothd[16313]:
plugins/policy.c:disconnect_cb() reason 2

Feb 12 11:39:52 raspberrypi bluetoothd[16313]:
src/adapter.c:bonding_attempt_complete() hci0 bdaddr 50:63:13:27:BB:BE
type 0 status 0xe

Feb 12 11:39:52 raspberrypi bluetoothd[16313]:
src/device.c:device_bonding_complete() bonding (nil) status 0x0e

Feb 12 11:39:52 raspberrypi bluetoothd[16313]:
src/device.c:device_bonding_failed() status 14

Feb 12 11:39:52 raspberrypi bluetoothd[16313]: src/adapter.c:resume_discovery()

Feb 12 11:39:52 raspberrypi bluetoothd[16313]: bluetoothd[16313]:
plugins/policy.c:disconnect_cb() reason 2

Feb 12 11:39:52 raspberrypi bluetoothd[16313]: bluetoothd[16313]:
src/adapter.c:bonding_attempt_complete() hci0 bdaddr 50:63:13:27:BB:BE
type 0 status 0xe

Feb 12 11:39:52 raspberrypi bluetoothd[16313]: bluetoothd[16313]:
src/device.c:device_bonding_complete() bonding (nil) status 0x0e

Feb 12 11:39:52 raspberrypi bluetoothd[16313]: bluetoothd[16313]:
src/device.c:device_bonding_failed() status 14

Feb 12 11:39:52 raspberrypi bluetoothd[16313]: bluetoothd[16313]:
src/adapter.c:resume_discovery()


dbus logs

signal sender=:1.0 -> dest=(null destination) serial=3593
path=/org/freedesktop/systemd1;
interface=org.freedesktop.systemd1.Manager; member=UnitNew

   string "sys-devices-platform-soc-3f201000.uart-tty-ttyAMA0-hci0-hci0:12.device"

   object path "/org/freedesktop/systemd1/unit/sys_2ddevices_2dplatform_2dsoc_2d3f201000_2euart_2dtty_2dttyAMA0_2dhci0_2dhci0_3a12_2edevice"

signal sender=:1.0 -> dest=(null destination) serial=3594
path=/org/freedesktop/systemd1;
interface=org.freedesktop.systemd1.Manager; member=UnitNew

   string "sys-subsystem-bluetooth-devices-hci0:12.device"

   object path "/org/freedesktop/systemd1/unit/sys_2dsubsystem_2dbluetooth_2ddevices_2dhci0_3a12_2edevice"

signal sender=:1.237 -> dest=(null destination) serial=84
path=/org/bluez/hci0/dev_50_63_13_27_BB_BE;
interface=org.freedesktop.DBus.Properties; member=PropertiesChanged

   string "org.bluez.Device1"

   array [

      dict entry(

         string "Connected"

         variant             boolean true

      )

   ]

   array [

   ]

signal sender=:1.237 -> dest=(null destination) serial=85
path=/org/bluez/hci0/dev_50_63_13_27_BB_BE;
interface=org.freedesktop.DBus.Properties; member=PropertiesChanged

   string "org.bluez.Device1"

   array [

      dict entry(

         string "ServicesResolved"

         variant             boolean true

      )

   ]

   array [

   ]

signal sender=:1.237 -> dest=(null destination) serial=87
path=/org/bluez/hci0/dev_50_63_13_27_BB_BE;
interface=org.freedesktop.DBus.Properties; member=PropertiesChanged

   string "org.bluez.Device1"

   array [

      dict entry(

         string "ServicesResolved"

         variant             boolean false

      )

      dict entry(

         string "Connected"

         variant             boolean false

      )

   ]

   array [

   ]

signal sender=:1.0 -> dest=(null destination) serial=3595
path=/org/freedesktop/systemd1;
interface=org.freedesktop.systemd1.Manager; member=UnitRemoved

   string "sys-subsystem-bluetooth-devices-hci0:12.device"

   object path "/org/freedesktop/systemd1/unit/sys_2dsubsystem_2dbluetooth_2ddevices_2dhci0_3a12_2edevice"

signal sender=:1.0 -> dest=(null destination) serial=3596
path=/org/freedesktop/systemd1;
interface=org.freedesktop.systemd1.Manager; member=UnitRemoved

   string "sys-devices-platform-soc-3f201000.uart-tty-ttyAMA0-hci0-hci0:12.device"

   object path "/org/freedesktop/systemd1/unit/sys_2ddevices_2dplatform_2dsoc_2d3f201000_2euart_2dtty_2dttyAMA0_2dhci0_2dhci0_3a12_2edevice"


btmon logs

< HCI Command: Create Connection (0x01|0x0005) plen 13

                                           [hci0] 1223.112664

        Address: 50:63:13:27:BB:BE (Hon Hai Precision Ind. Co.,Ltd.)

        Packet type: 0xcc18

          DM1 may be used

          DH1 may be used

          DM3 may be used

          DH3 may be used

          DM5 may be used

          DH5 may be used

        Page scan repetition mode: R2 (0x02)

        Page scan mode: Mandatory (0x00)

        Clock offset: 0x0000

        Role switch: Allow slave (0x01)

> HCI Event: Command Status (0x0f) plen 4                                                                                                                                                [hci0] 1223.114717

      Create Connection (0x01|0x0005) ncmd 1

        Status: Success (0x00)

> HCI Event: Role Change (0x12) plen 8                                                                                                                                                   [hci0] 1223.487109

        Status: Success (0x00)

        Address: 50:63:13:27:BB:BE (Hon Hai Precision Ind. Co.,Ltd.)

        Role: Slave (0x01)

> HCI Event: Link Key Request (0x17) plen 6                                                                                                                                              [hci0] 1223.545305

        Address: 50:63:13:27:BB:BE (Hon Hai Precision Ind. Co.,Ltd.)

< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22

                                           [hci0] 1223.545358

        Address: 50:63:13:27:BB:BE (Hon Hai Precision Ind. Co.,Ltd.)

        Link key: 98e307bc43249190400292272b0af220

> HCI Event: Command Complete (0x0e) plen 10                                                                                                                                             [hci0] 1223.547709

      Link Key Request Reply (0x01|0x000b) ncmd 1

        Status: Success (0x00)

        Address: 50:63:13:27:BB:BE (Hon Hai Precision Ind. Co.,Ltd.)

> HCI Event: Connect Complete (0x03) plen 11                                                                                                                                             [hci0] 1223.610400

        Status: Success (0x00)

        Handle: 12

        Address: 50:63:13:27:BB:BE (Hon Hai Precision Ind. Co.,Ltd.)

        Link type: ACL (0x01)

        Encryption: Enabled (0x01)

< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2

                                           [hci0] 1223.610689

        Handle: 12

> HCI Event: Command Status (0x0f) plen 4                                                                                                                                                [hci0] 1223.611192

      Read Remote Supported Features (0x01|0x001b) ncmd 1

        Status: Success (0x00)

> HCI Event: Read Remote Supported Features (0x0b) plen 11                                                                                                                               [hci0] 1223.611445

        Status: Success (0x00)

        Handle: 12

        Features: 0xff 0xef 0x8d 0xfe 0x9b 0xff 0x79 0x83

          3 slot packets

          5 slot packets

          Encryption

          Slot offset

          Timing accuracy

          Role switch

          Hold mode

          Sniff mode

          Park state

          Power control requests

          Channel quality driven data rate (CQDDR)

          SCO link

          HV3 packets

          u-law log synchronous data

          A-law log synchronous data

          CVSD synchronous data

          Power control

          Transparent synchronous data

          Broadcast Encryption

          Enhanced Data Rate ACL 2 Mbps mode

          Enhanced Data Rate ACL 3 Mbps mode

          Enhanced inquiry scan

          Interlaced inquiry scan

          Interlaced page scan

          RSSI with inquiry results

          Extended SCO link (EV3 packets)

          EV4 packets

          EV5 packets

          AFH capable slave

          AFH classification slave

          3-slot Enhanced Data Rate ACL packets

          5-slot Enhanced Data Rate ACL packets

          Sniff subrating

          Pause encryption

          AFH capable master

          AFH classification master

          Enhanced Data Rate eSCO 2 Mbps mode

          Enhanced Data Rate eSCO 3 Mbps mode

          3-slot Enhanced Data Rate eSCO packets

          Extended Inquiry Response

          Secure Simple Pairing

          Encapsulated PDU

          Erroneous Data Reporting

          Non-flushable Packet Boundary Flag

          Link Supervision Timeout Changed Event

          Inquiry TX Power Level

          Extended features

< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3

                                           [hci0] 1223.611479

        Handle: 12

        Page: 1

> HCI Event: Command Status (0x0f) plen 4                                                                                                                                                [hci0] 1223.612515

      Read Remote Extended Features (0x01|0x001c) ncmd 1

        Status: Success (0x00)

> HCI Event: Read Remote Extended Features (0x23) plen 13                                                                                                                                [hci0] 1223.612524

        Status: Success (0x00)

        Handle: 12

        Page: 1/0

        Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00

< HCI Command: Remote Name Request (0x01|0x0019) plen 10

                                           [hci0] 1223.612597

        Address: 50:63:13:27:BB:BE (Hon Hai Precision Ind. Co.,Ltd.)

        Page scan repetition mode: R2 (0x02)

        Page scan mode: Mandatory (0x00)

        Clock offset: 0x0000

> HCI Event: Command Status (0x0f) plen 4                                                                                                                                                [hci0] 1223.616095

      Remote Name Request (0x01|0x0019) ncmd 1

        Status: Success (0x00)

> HCI Event: Max Slots Change (0x1b) plen 3                                                                                                                                              [hci0] 1223.697784

        Handle: 12

        Max slots: 5

> HCI Event: Remote Name Req Complete (0x07) plen 255                                                                                                                                    [hci0] 1223.776753

        Status: Success (0x00)

        Address: 50:63:13:27:BB:BE (Hon Hai Precision Ind. Co.,Ltd.)

        Name:

< HCI Command: Authentication Requested (0x01|0x0011) plen 2

                                           [hci0] 1223.776831

        Handle: 12

> HCI Event: QoS Setup Complete (0x0d) plen 21                                                                                                                                           [hci0] 1223.776967

        Status: Success (0x00)

        Handle: 12

        Flags: 0x00

        Service type: Best Effort (0x01)

        Token rate: 9955

        Peak bandwidth: 0

        Latency: 22500

        Delay variation: -1

> HCI Event: Command Status (0x0f) plen 4                                                                                                                                                [hci0] 1223.778082

      Authentication Requested (0x01|0x0011) ncmd 1

        Status: Success (0x00)

> HCI Event: Link Key Request (0x17) plen 6                                                                                                                                              [hci0] 1223.778322

        Address: 50:63:13:27:BB:BE (Hon Hai Precision Ind. Co.,Ltd.)

< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22

                                           [hci0] 1223.778362

        Address: 50:63:13:27:BB:BE (Hon Hai Precision Ind. Co.,Ltd.)

        Link key: 98e307bc43249190400292272b0af220

> HCI Event: Command Complete (0x0e) plen 10                                                                                                                                             [hci0] 1223.780092

      Link Key Request Reply (0x01|0x000b) ncmd 1

        Status: Success (0x00)

        Address: 50:63:13:27:BB:BE (Hon Hai Precision Ind. Co.,Ltd.)

@ Device Connected: 50:63:13:27:BB:BE (0) flags 0x0000

> HCI Event: Link Supervision Timeout Changed (0x38) plen 4                                                                                                                              [hci0] 1223.869031

        Handle: 12

        Timeout: 5000.000 msec (0x1f40)

> HCI Event: Auth Complete (0x06) plen 3                                                                                                                                                 [hci0] 1223.937944

        Status: Success (0x00)

        Handle: 12

< ACL Data TX: Handle 12 flags 0x00 dlen 10

                                           [hci0] 1223.938039

      L2CAP: Information Request (0x0a) ident 1 len 2

        Type: Extended features supported (0x0002)

> HCI Event: Max Slots Change (0x1b) plen 3                                                                                                                                              [hci0] 1224.093991

        Handle: 12

        Max slots: 1

> HCI Event: Encryption Key Refresh Complete (0x30) plen 3                                                                                                                               [hci0] 1224.321655

        Status: Success (0x00)

        Handle: 12

> ACL Data RX: Handle 12 flags 0x02 dlen 16                                                                                                                                              [hci0] 1224.521587

      L2CAP: Information Response (0x0b) ident 1 len 8

        Type: Extended features supported (0x0002)

        Result: Success (0x0000)

        Features: 0x00000000

< ACL Data TX: Handle 12 flags 0x00 dlen 12

                                           [hci0] 1224.521666

      L2CAP: Connection Request (0x02) ident 2 len 4

        PSM: 1 (0x0001)

        Source CID: 64

> ACL Data RX: Handle 12 flags 0x02 dlen 16                                                                                                                                              [hci0] 1224.611627

      L2CAP: Connection Response (0x03) ident 2 len 8

        Destination CID: 71

        Source CID: 64

        Result: Connection pending (0x0001)

        Status: Authorization pending (0x0002)

> HCI Event: Number of Completed Packets (0x13) plen 5                                                                                                                                   [hci0] 1224.611715

        Num handles: 1

        Handle: 12

        Count: 2

> ACL Data RX: Handle 12 flags 0x02 dlen 16                                                                                                                                              [hci0] 1224.679069

      L2CAP: Connection Response (0x03) ident 2 len 8

        Destination CID: 71

        Source CID: 64

        Result: Connection successful (0x0000)

        Status: No further information available (0x0000)

< ACL Data TX: Handle 12 flags 0x00 dlen 12

                                           [hci0] 1224.679119

      L2CAP: Configure Request (0x04) ident 3 len 4

        Destination CID: 71

        Flags: 0x0000

> ACL Data RX: Handle 12 flags 0x02 dlen 18                                                                                                                                              [hci0] 1224.746615

      L2CAP: Configure Response (0x05) ident 3 len 10

        Source CID: 64

        Flags: 0x0000

        Result: Success (0x0000)

        Option: Maximum Transmission Unit (0x01) [mandatory]

          MTU: 132

> ACL Data RX: Handle 12 flags 0x02 dlen 16                                                                                                                                              [hci0] 1224.836573

      L2CAP: Configure Request (0x04) ident 9 len 8

        Destination CID: 64

        Flags: 0x0000

        Option: Maximum Transmission Unit (0x01) [mandatory]

          MTU: 132

< ACL Data TX: Handle 12 flags 0x00 dlen 18

                                           [hci0] 1224.836628

      L2CAP: Configure Response (0x05) ident 9 len 10

        Source CID: 71

        Flags: 0x0000

        Result: Success (0x0000)

        Option: Maximum Transmission Unit (0x01) [mandatory]

          MTU: 132

< ACL Data TX: Handle 12 flags 0x00 dlen 24

                                           [hci0] 1224.836811

      Channel: 71 len 20 [PSM 1 mode 0] {chan 0}

      SDP: Service Search Attribute Request (0x06) tid 0 len 15

        Search pattern: [len 5]

          Sequence (6) with 3 bytes [8 extra bits] len 5

            UUID (3) with 2 bytes [0 extra bits] len 3

              L2CAP (0x0100)

        Max record count: 65535

        Attribute list: [len 7]

          Sequence (6) with 5 bytes [8 extra bits] len 7

            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5

              0x0000ffff

        Continuation state: 0

> HCI Event: Number of Completed Packets (0x13) plen 5                                                                                                                                   [hci0] 1224.904015

        Num handles: 1

        Handle: 12

        Count: 2

> ACL Data RX: Handle 12 flags 0x02 dlen 18                                                                                                                                              [hci0] 1224.971622

      Channel: 64 len 14 [PSM 1 mode 0] {chan 0}

      SDP: Service Search Attribute Response (0x07) tid 0 len 9

        Attribute bytes: 6

          Attribute list: [len 0] {position 0}

        Continuation state: 0

< ACL Data TX: Handle 12 flags 0x00 dlen 24

                                           [hci0] 1224.972302

      Channel: 71 len 20 [PSM 1 mode 0] {chan 0}

      SDP: Service Search Attribute Request (0x06) tid 1 len 15

        Search pattern: [len 5]

          Sequence (6) with 3 bytes [8 extra bits] len 5

            UUID (3) with 2 bytes [0 extra bits] len 3

              PnP Information (0x1200)

        Max record count: 65535

        Attribute list: [len 7]

          Sequence (6) with 5 bytes [8 extra bits] len 7

            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5

              0x0000ffff

        Continuation state: 0

> ACL Data RX: Handle 12 flags 0x02 dlen 18                                                                                                                                              [hci0] 1225.039149

      Channel: 64 len 14 [PSM 1 mode 0] {chan 0}

      SDP: Service Search Attribute Response (0x07) tid 1 len 9

        Attribute bytes: 6

          Attribute list: [len 0] {position 0}

        Continuation state: 0

> HCI Event: Number of Completed Packets (0x13) plen 5                                                                                                                                   [hci0] 1225.039248

        Num handles: 1

        Handle: 12

        Count: 2

< ACL Data TX: Handle 12 flags 0x00 dlen 24

                                           [hci0] 1225.039757

      Channel: 71 len 20 [PSM 1 mode 0] {chan 0}

      SDP: Service Search Attribute Request (0x06) tid 2 len 15

        Search pattern: [len 5]

          Sequence (6) with 3 bytes [8 extra bits] len 5

            UUID (3) with 2 bytes [0 extra bits] len 3

              Public Browse Root (0x1002)

        Max record count: 65535

        Attribute list: [len 7]

          Sequence (6) with 5 bytes [8 extra bits] len 7

            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5

              0x0000ffff

        Continuation state: 0

> ACL Data RX: Handle 12 flags 0x02 dlen 18                                                                                                                                              [hci0] 1225.129131

      Channel: 64 len 14 [PSM 1 mode 0] {chan 0}

      SDP: Service Search Attribute Response (0x07) tid 2 len 9

        Attribute bytes: 6

          Attribute list: [len 0] {position 0}

        Continuation state: 0

> HCI Event: Number of Completed Packets (0x13) plen 5                                                                                                                                   [hci0] 1225.293589

        Num handles: 1

        Handle: 12

        Count: 1

< ACL Data TX: Handle 12 flags 0x00 dlen 12

                                           [hci0] 1227.058309

      L2CAP: Disconnection Request (0x06) ident 4 len 4

        Destination CID: 71

        Source CID: 64

> ACL Data RX: Handle 12 flags 0x02 dlen 12                                                                                                                                              [hci0] 1227.176571

      L2CAP: Disconnection Response (0x07) ident 4 len 4

        Destination CID: 71

        Source CID: 64

> HCI Event: Number of Completed Packets (0x13) plen 5                                                                                                                                   [hci0] 1227.418619

        Num handles: 1

        Handle: 12

        Count: 1

< HCI Command: Disconnect (0x01|0x0006) plen 3

                                           [hci0] 1229.175792

        Handle: 12

        Reason: Remote User Terminated Connection (0x13)

> HCI Event: Command Status (0x0f) plen 4                                                                                                                                                [hci0] 1229.176311

      Disconnect (0x01|0x0006) ncmd 1

        Status: Success (0x00)

> HCI Event: Disconnect Complete (0x05) plen 4                                                                                                                                           [hci0] 1229.292168

        Status: Success (0x00)

        Handle: 12

        Reason: Connection Terminated By Local Host (0x16)

@ Device Disconnected: 50:63:13:27:BB:BE (0) reason 2
