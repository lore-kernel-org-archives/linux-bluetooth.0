Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAu3APbw0JyPfKUi6PZ4Nr2Uh5WXtDprDVFBTj3xr+801b9L6w@mail.gmail.com>
References: <CAAu3APbw0JyPfKUi6PZ4Nr2Uh5WXtDprDVFBTj3xr+801b9L6w@mail.gmail.com>
From: Barry Byford <31baz66@gmail.com>
Date: Fri, 7 Apr 2017 22:56:43 +0100
Message-ID: <CAAu3APbMKQY2dnD=TUAb_3BqFKk0s2bzuFFLX8=h-1g7gm8G=Q@mail.gmail.com>
Subject: Re: Serial Port connection with DBus API
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I've made progress by adding a dbus configuration file in
/etc/dbus-1/system.d and the python script is starting up. However on
startup btmon is reporting the following:

= bluetoothd: Invalid value for profile option Channel
= bluetoothd: RFCOMM server failed for SerialPort: socket(STREAM,
RFCOMM): Protocol not supported (93)

My assumption is that this is coming from the options on
RegisterProfile. However it is not obvious to me what the settings
should be. Any suggestions?

My Python script is:

import socket
from pydbus import SystemBus
from gi.repository import GLib

loop = GLib.MainLoop()

dbus = SystemBus()


class Profile(object):
    """
      <node>
        <interface name='org.bluez.Profile1'>
          <method name='Release'>
          </method>
          <method name='Cancel'>
          </method>
          <method name='NewConnection'>
            <arg type='o' name='path' direction='in'/>
            <arg type='h' name='fd' direction='in'/>
            <arg type='a{sv}' name='properties' direction='in'/>
          </method>
          <method name='RequestDisconnection'>
            <arg type='o' name='path' direction='in'/>
          </method>
        </interface>
      </node>
    """
    def __init__(self, mac_address):
        self.server_address = mac_address
        self.server_sock = None
        self.port = 1
        pass

    def Release(self):
        pass

    def Cancel(self):
        pass

    def NewConnection(self, path, fd, properties):
        print('New connection', path, fd, properties)
        self.server_sock = socket.socket(socket.AF_BLUETOOTH,
socket.SOCK_STREAM, socket.BTPROTO_RFCOMM)
        self.server_sock.settimeout(0.01)
        self.server_sock.bind((self.server_address, self.port))
        self.server_sock.listen(1)
        try:
            client, address = self.server_sock.accept()
            while True:
                data = client.recv(1024)
                if data:
                    print(data)
        except:
            print('Debug!')

    def RequestDisconnection(self, path):
        print('Disconnection', path)
        self.server_sock.close()
        self.server_sock = None

if __name__ == '__main__':
    profile_mngr = dbus.get('org.bluez', '/org/bluez')
    spp_uuid = '00001101-0000-1000-8000-00805f9b34fb'
    rfcom_uuid = '00000003-0000-1000-8000-00805F9B34FB'
    l2cap_uuid = '00000100-0000-1000-8000-00805f9b34fb'
    opts = {
            'AutoConnect': GLib.Variant('b', True),
            'Channel': GLib.Variant('i', 1),
            'Service': GLib.Variant('s', rfcom_uuid),
            'Role': GLib.Variant('s', 'server'),
            'Name': GLib.Variant('s', 'SerialPort')
        }

    dbus.publish('ukBaz.bluezero', Profile('00:00:00:00:5A:AD'))
    profile_mngr.RegisterProfile('/ukBaz/bluezero', spp_uuid, opts)

    loop.run()

The full output of btmon is:

Bluetooth monitor ver 5.43
= Note: Linux version 4.9.0-linaro-lt-qcom (aarch64)                   0.650926
= Note: Bluetooth subsystem version 2.22                               0.650947
= New Index: 00:00:00:00:5A:AD (Primary,SMD,hci0)               [hci0] 0.650954
= Open Index: 00:00:00:00:5A:AD                                 [hci0] 0.650961
= Index Info: 00:00:00:00:5A:AD (Qualcomm)                      [hci0] 0.650969
@ MGMT Open: bluetoothd (privileged) version 1.14             {0x0001} 0.650983
@ MGMT Open: btmon (privileged) version 1.14                  {0x0002} 0.651098
= bluetoothd: Invalid value for profile option Channel                 7.672569
= bluetoothd: RFCOMM server failed for SerialPort: socket(STREAM,...   7.675858
> HCI Event: Connect Request (0x04) plen 10                    [hci0] 19.885300
        Address: 64:BC:0C:F6:22:F8 (LG Electronics (Mobile Communications))
        Class: 0x5a020c
          Major class: Phone (cellular, cordless, payphone, modem)
          Minor class: Smart phone
          Networking (LAN, Ad hoc)
          Capturing (Scanner, Microphone)
          Object Transfer (v-Inbox, v-Folder)
          Telephony (Cordless telephony, Modem, Headset)
        Link type: ACL (0x01)
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7  [hci0] 19.885506
        Address: 64:BC:0C:F6:22:F8 (LG Electronics (Mobile Communications))
        Role: Master (0x00)
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 19.886181
      Accept Connection Request (0x01|0x0009) ncmd 1
        Status: Success (0x00)
> HCI Event: Role Change (0x12) plen 8                         [hci0] 20.138773
        Status: Success (0x00)
        Address: 64:BC:0C:F6:22:F8 (LG Electronics (Mobile Communications))
        Role: Master (0x00)
> HCI Event: Connect Complete (0x03) plen 11                   [hci0] 20.142779
        Status: Success (0x00)
        Handle: 1
        Address: 64:BC:0C:F6:22:F8 (LG Electronics (Mobile Communications))
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)
< HCI Command: Read Remote Supported F.. (0x01|0x001b) plen 2  [hci0] 20.143326
        Handle: 1
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 20.143779
      Read Remote Supported Features (0x01|0x001b) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Remote Supported Features (0x0b) plen 11     [hci0] 20.143809
        Status: Success (0x00)
        Handle: 1
        Features: 0xff 0xfe 0x8f 0xfe 0xd8 0x3f 0x5b 0x87
          3 slot packets
          5 slot packets
          Encryption
          Slot offset
          Timing accuracy
          Role switch
          Hold mode
          Sniff mode
          Power control requests
          Channel quality driven data rate (CQDDR)
          SCO link
          HV2 packets
          HV3 packets
          u-law log synchronous data
          A-law log synchronous data
          CVSD synchronous data
          Paging parameter negotiation
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
          AFH capable slave
          AFH classification slave
          LE Supported (Controller)
          3-slot Enhanced Data Rate ACL packets
          5-slot Enhanced Data Rate ACL packets
          Sniff subrating
          Pause encryption
          AFH capable master
          AFH classification master
          Enhanced Data Rate eSCO 2 Mbps mode
          Extended Inquiry Response
          Simultaneous LE and BR/EDR (Controller)
          Secure Simple Pairing
          Encapsulated PDU
          Non-flushable Packet Boundary Flag
          Link Supervision Timeout Changed Event
          Inquiry TX Power Level
          Enhanced Power Control
          Extended features
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1          [hci0] 20.143972
        Scan enable: No Scans (0x00)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 20.144612
      Write Scan Enable (0x03|0x001a) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Remote Extended Fe.. (0x01|0x001c) plen 3  [hci0] 20.144763
        Handle: 1
        Page: 1
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 20.145061
      Read Remote Extended Features (0x01|0x001c) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Remote Extended Features (0x23) plen 13      [hci0] 20.145089
        Status: Success (0x00)
        Handle: 1
        Page: 1/2
        Features: 0x0f 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          Secure Simple Pairing (Host Support)
          LE Supported (Host)
          Simultaneous LE and BR/EDR (Host)
          Secure Connections (Host Support)
< HCI Command: Remote Name Request (0x01|0x0019) plen 10       [hci0] 20.145291
        Address: 64:BC:0C:F6:22:F8 (LG Electronics (Mobile Communications))
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
< ACL Data TX: Handle 1 flags 0x00 dlen 10                     [hci0] 20.145326
      L2CAP: Information Request (0x0a) ident 1 len 2
        Type: Extended features supported (0x0002)
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 20.145898
      Remote Name Request (0x01|0x0019) ncmd 1
        Status: Success (0x00)
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7    [hci0] 20.149914
        Address: 64:BC:0C:F6:22:F8 (LG Electronics (Mobile Communications))
        Page scan repetition mode: R1 (0x01)
> HCI Event: Max Slots Change (0x1b) plen 3                    [hci0] 20.153646
        Handle: 1
        Max slots: 5
> HCI Event: Remote Name Req Complete (0x07) plen 255          [hci0] 20.154938
        Status: Success (0x00)
        Address: 64:BC:0C:F6:22:F8 (LG Electronics (Mobile Communications))
        Name: Nexus 5X
@ MGMT Event: Device Connected (0x000b) plen 28       {0x0002} [hci0] 20.155049
        BR/EDR Address: 64:BC:0C:F6:22:F8 (LG Electronics (Mobile
Communications))
        Flags: 0x00000000
        Data length: 15
        Name (complete): Nexus 5X
        Class: 0x5a020c
          Major class: Phone (cellular, cordless, payphone, modem)
          Minor class: Smart phone
          Networking (LAN, Ad hoc)
          Capturing (Scanner, Microphone)
          Object Transfer (v-Inbox, v-Folder)
          Telephony (Cordless telephony, Modem, Headset)
@ MGMT Event: Device Connected (0x000b) plen 28       {0x0001} [hci0] 20.155049
        BR/EDR Address: 64:BC:0C:F6:22:F8 (LG Electronics (Mobile
Communications))
        Flags: 0x00000000
        Data length: 15
        Name (complete): Nexus 5X
        Class: 0x5a020c
          Major class: Phone (cellular, cordless, payphone, modem)
          Minor class: Smart phone
          Networking (LAN, Ad hoc)
          Capturing (Scanner, Microphone)
          Object Transfer (v-Inbox, v-Folder)
          Telephony (Cordless telephony, Modem, Headset)
> ACL Data RX: Handle 1 flags 0x02 dlen 10                     [hci0] 20.293653
      L2CAP: Information Request (0x0a) ident 2 len 2
        Type: Extended features supported (0x0002)
< ACL Data TX: Handle 1 flags 0x00 dlen 16                     [hci0] 20.293854
      L2CAP: Information Response (0x0b) ident 2 len 8
        Type: Extended features supported (0x0002)
        Result: Success (0x0000)
        Features: 0x000002b8
          Enhanced Retransmission Mode
          Streaming Mode
          FCS Option
          Fixed Channels
          Unicast Connectionless Data Reception
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 20.392999
        Num handles: 1
        Handle: 1
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 20.395496
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 16                     [hci0] 20.492372
      L2CAP: Information Response (0x0b) ident 1 len 8
        Type: Extended features supported (0x0002)
        Result: Success (0x0000)
        Features: 0x000000b8
          Enhanced Retransmission Mode
          Streaming Mode
          FCS Option
          Fixed Channels
< ACL Data TX: Handle 1 flags 0x00 dlen 10                     [hci0] 20.492531
      L2CAP: Information Request (0x0a) ident 2 len 2
        Type: Fixed channels supported (0x0003)
> ACL Data RX: Handle 1 flags 0x02 dlen 10                     [hci0] 20.493632
      L2CAP: Information Request (0x0a) ident 3 len 2
        Type: Fixed channels supported (0x0003)
< ACL Data TX: Handle 1 flags 0x00 dlen 20                     [hci0] 20.493768
      L2CAP: Information Response (0x0b) ident 3 len 12
        Type: Fixed channels supported (0x0003)
        Result: Success (0x0000)
        Channels: 0x0000000000000086
          L2CAP Signaling (BR/EDR)
          Connectionless reception
          Security Manager (BR/EDR)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 20.591765
        Num handles: 1
        Handle: 1
        Count: 1
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 20.592972
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 20                     [hci0] 20.729872
      L2CAP: Information Response (0x0b) ident 2 len 12
        Type: Fixed channels supported (0x0003)
        Result: Success (0x0000)
        Channels: 0x0000000000000082
          L2CAP Signaling (BR/EDR)
          Security Manager (BR/EDR)
> ACL Data RX: Handle 1 flags 0x02 dlen 12                     [hci0] 20.731116
      L2CAP: Connection Request (0x02) ident 4 len 4
        PSM: 1 (0x0001)
        Source CID: 76
< ACL Data TX: Handle 1 flags 0x00 dlen 16                     [hci0] 20.731327
      L2CAP: Connection Response (0x03) ident 4 len 8
        Destination CID: 64
        Source CID: 76
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)
< ACL Data TX: Handle 1 flags 0x00 dlen 23                     [hci0] 20.731355
      L2CAP: Configure Request (0x04) ident 3 len 15
        Destination CID: 76
        Flags: 0x0000
        Option: Retransmission and Flow Control (0x04) [mandatory]
          Mode: Basic (0x00)
          TX window size: 0
          Max transmit: 0
          Retransmission timeout: 0
          Monitor timeout: 0
          Maximum PDU size: 0
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 20.734232
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 16                     [hci0] 20.768614
      L2CAP: Configure Request (0x04) ident 5 len 8
        Destination CID: 64
        Flags: 0x0000
        Option: Maximum Transmission Unit (0x01) [mandatory]
          MTU: 672
< ACL Data TX: Handle 1 flags 0x00 dlen 18                     [hci0] 20.768765
      L2CAP: Configure Response (0x05) ident 5 len 10
        Source CID: 76
        Flags: 0x0000
        Result: Success (0x0000)
        Option: Maximum Transmission Unit (0x01) [mandatory]
          MTU: 672
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 20.769242
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 14                     [hci0] 20.796104
      L2CAP: Configure Response (0x05) ident 3 len 6
        Source CID: 64
        Flags: 0x0000
        Result: Success (0x0000)
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 20.796754
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 38                     [hci0] 20.798611
      Channel: 64 len 34 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 0 len 29
        Search pattern: [len 19]
          Sequence (6) with 17 bytes [8 extra bits] len 19
            UUID (3) with 16 bytes [0 extra bits] len 17
              00001101-0000-1000-8000-00805f9b34fb
              Serial Port
        Max record count: 656
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 0
< ACL Data TX: Handle 1 flags 0x00 dlen 14                     [hci0] 20.799655
      Channel: 76 len 10 [PSM 1 mode 0] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 0 len 5
        Attribute bytes: 2
        Continuation state: 0
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 20.891773
        Num handles: 1
        Handle: 1
        Count: 1
> ACL Data RX: Handle 1 flags 0x02 dlen 12                     [hci0] 20.919861
      L2CAP: Disconnection Request (0x06) ident 6 len 4
        Destination CID: 64
        Source CID: 76
< ACL Data TX: Handle 1 flags 0x00 dlen 12                     [hci0] 20.920045
      L2CAP: Disconnection Response (0x07) ident 6 len 4
        Destination CID: 64
        Source CID: 76
> HCI Event: Number of Completed Packets (0x13) plen 5         [hci0] 20.992989
        Num handles: 1
        Handle: 1
        Count: 1
< HCI Command: Disconnect (0x01|0x0006) plen 3                 [hci0] 24.950685
        Handle: 1
        Reason: Remote User Terminated Connection (0x13)
> HCI Event: Command Status (0x0f) plen 4                      [hci0] 24.951252
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)
> HCI Event: Disconnect Complete (0x05) plen 4                 [hci0] 24.959359
        Status: Success (0x00)
        Handle: 1
        Reason: Connection Terminated By Local Host (0x16)
@ MGMT Event: Device Disconnected (0x000c) plen 8     {0x0002} [hci0] 24.959474
        BR/EDR Address: 64:BC:0C:F6:22:F8 (LG Electronics (Mobile
Communications))
        Reason: Connection terminated by local host (0x02)
@ MGMT Event: Device Disconnected (0x000c) plen 8     {0x0001} [hci0] 24.959474
        BR/EDR Address: 64:BC:0C:F6:22:F8 (LG Electronics (Mobile
Communications))
        Reason: Connection terminated by local host (0x02)
< HCI Command: Write Scan Enable (0x03|0x001a) plen 1          [hci0] 24.991008
        Scan enable: Page Scan (0x02)
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 24.993260
      Write Scan Enable (0x03|0x001a) ncmd 1
        Status: Success (0x00)


On 7 April 2017 at 14:47, Barry Byford <31baz66@gmail.com> wrote:
> Hello,
>
> I am trying to create a serial port server that can be connected to by
> an already existing Android app.
>
> The app is trying connect on channel 1. I am taking the
> test/test-profile example as my starting point.
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/test/test-profile?h=5.43
>
> My code is far from finished but I thought it would be enough to
> accept the connection (or at least print that a new connection attempt
> had happened.) However I am getting an access denied error and I'm
> concerned that I'm going down the wrong route on this and it might be
> simpler than I am making it.
>
> Error message
> $ python3 BTspp.py
> Traceback (most recent call last):
>   File "BTclassic.py", line 54, in <module>
>     dbus.publish('org.bluez.Profile1', Profile('x', 'y'))
>   File "/usr/local/lib/python3.5/dist-packages/pydbus/publication.py",
> line 42, in publish
>     return Publication(self, bus_name, *objects)
>   File "/usr/local/lib/python3.5/dist-packages/pydbus/publication.py",
> line 35, in __init__
>     self._at_exit(bus.request_name(bus_name,
> allow_replacement=allow_replacement, replace=replace).__exit__)
>   File "/usr/local/lib/python3.5/dist-packages/pydbus/request_name.py",
> line 29, in request_name
>     return NameOwner(self, name, allow_replacement, replace)
>   File "/usr/local/lib/python3.5/dist-packages/pydbus/request_name.py",
> line 8, in __init__
>     res = bus.dbus.RequestName(name, flags)
>   File "/usr/local/lib/python3.5/dist-packages/pydbus/proxy_method.py",
> line 75, in __call__
>     0, timeout_to_glib(timeout), None).unpack()
> GLib.Error: g-dbus-error-quark:
> GDBus.Error:org.freedesktop.DBus.Error.AccessDenied: Connection
> ":1.47" is not allowed to own the service "org.bluez.Profile1" due to
> security policies in the configuration file (9
>
> Python code so far:
>
> from pydbus import SystemBus
> from gi.repository import GLib
>
> loop = GLib.MainLoop()
>
> dbus = SystemBus()
>
>
> class Profile(object):
>     """
>       <node>
>         <interface name='org.bluez.Profile1'>
>           <method name='Release'>
>           </method>
>           <method name='Cancel'>
>           </method>
>           <method name='NewConnection'>
>             <arg type='o' name='path' direction='in'/>
>             <arg type='h' name='fd' direction='in'/>
>             <arg type='a{sv}' name='properties' direction='in'/>
>           </method>
>           <method name='RequestDisconnection'>
>             <arg type='o' name='path' direction='in'/>
>           </method>
>         </interface>
>       </node>
>     """
>     def __init__(self, x, y):
>         pass
>
>     def Release(self):
>         pass
>
>     def Cancel(self):
>         pass
>
>     def NewConnection(self, path, fd, properties):
>         print('New connection', path, fd, properties)
>
>     def RequestDisconnection(self, path):
>         pass
>
> if __name__ == '__main__':
>     profile_mngr = dbus.get('org.bluez', '/org/bluez')
>     uuid = "00001101-0000-1000-8000-00805f9b34fb"
>     opts = {
>             "AutoConnect": GLib.Variant('b', True),
>             'Channel': GLib.Variant('i', 1),
>             'Service': GLib.Variant('s', uuid),
>             'Name': GLib.Variant('s', 'Serial Port')
>         }
>
>     # my_profile = Profile(dbus, '/org/bluez/example')
>     dbus.publish('org.bluez.Profile1', Profile('x', 'y'))
>     profile_mngr.RegisterProfile('/foo/bar/profile', uuid, opts)
>
>     loop.run()
>
>
> Is there a simpler way of doing this?
>
> Thanks,
> Barry
